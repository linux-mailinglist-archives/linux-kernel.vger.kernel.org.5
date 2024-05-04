Return-Path: <linux-kernel+bounces-168495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC668BB940
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 04:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F558282BF7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA6912B7F;
	Sat,  4 May 2024 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="Wy9YlDaq"
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D564AD31;
	Sat,  4 May 2024 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714788923; cv=none; b=VFSJx/F8juO9o1zKd/v7/v8nBh3BCoiNHo98xmbdfre1eKmXFGtTGFuo5jWBLFt7g3RZTtZjEwQefXKOFeIv4A3tK39yHAMnmTkpSISIFHNv3DTUYi8CKy8FS48IDJ/lNdTcUwrUJ7aZnq4lw/2/YGPE+oH02mrdiGOqHQnFoSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714788923; c=relaxed/simple;
	bh=QekW4ra98idxZLFZSch4rIOC7DAEv7PojML3X6CnQXE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcgFAWPKEKI1HRznylfiyCvsWBkohT3YwYD0ImartosUOxfT5Dnim6iG/QADSLDU+KRctWBuZSz78+4SKaIIWzCQFJ/6n0F34BeccEz9M/VMOrhR5+HLzWNqpnLRcRHnSDKLE2k3oeDbKtizHksZhzDygtcI7wUvwtqfO9np1Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=Wy9YlDaq; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5520CC0071;
	Fri,  3 May 2024 22:08:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1714788491; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=9lSYqpkK/tY8uix/2anBrbdiWyUXg2DgSAxMjG5QZKc=;
	b=Wy9YlDaqwg4moJOujWEOfpaS6qZKy8E9jnd569vYPo1xWqcQ2/O709He8KCG8FmPWVVIcb
	snB9NXnFtzKvwN2xxpT00w+AKQ6Q+jZ/n4dF/PiuE3bEEMlUEWUwnnkVBf68KHQSramlhT
	eQzhot65+WcRPGvPaq363OLP3zVXGPE=
From: Felix Kaechele <felix@kaechele.ca>
To: Job Noorman <job@noorman.info>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] input: himax_hx83112b: implement MCU register reading
Date: Fri,  3 May 2024 22:04:43 -0400
Message-ID: <20240504020745.68525-5-felix@kaechele.ca>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504020745.68525-1-felix@kaechele.ca>
References: <20240504020745.68525-1-felix@kaechele.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Implement reading from the MCU in a more universal fashion. This allows
properly handling reads of more than 4 bytes using the AHB FIFO
implemented in the chip.

Signed-off-by: Felix Kaechele <felix@kaechele.ca>
---
 drivers/input/touchscreen/himax_hx83112b.c | 51 ++++++++++++++++++++--
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/himax_hx83112b.c b/drivers/input/touchscreen/himax_hx83112b.c
index ba5442cc0a24..0173ff394a99 100644
--- a/drivers/input/touchscreen/himax_hx83112b.c
+++ b/drivers/input/touchscreen/himax_hx83112b.c
@@ -29,9 +29,13 @@
 #define HIMAX_AHB_ADDR_BYTE_0			0x00
 #define HIMAX_AHB_ADDR_RDATA_BYTE_0		0x08
 #define HIMAX_AHB_ADDR_ACCESS_DIRECTION		0x0c
+#define HIMAX_AHB_ADDR_INCR4			0x0d
+#define HIMAX_AHB_ADDR_CONTI			0x13
 #define HIMAX_AHB_ADDR_EVENT_STACK		0x30
 
 #define HIMAX_AHB_CMD_ACCESS_DIRECTION_READ	0x00
+#define HIMAX_AHB_CMD_INCR4			0x10
+#define HIMAX_AHB_CMD_CONTI			0x31
 
 #define HIMAX_REG_ADDR_ICID			0x900000d0
 
@@ -73,10 +77,34 @@ static const char *const himax_supply_names[] = {
 	"vdd",
 };
 
-static int himax_read_config(struct himax_ts_data *ts, u32 address, u32 *dst)
+static int himax_bus_enable_burst(struct himax_ts_data *ts)
 {
 	int error;
 
+	error = regmap_write(ts->regmap, HIMAX_AHB_ADDR_CONTI,
+					 HIMAX_AHB_CMD_CONTI);
+	if (error)
+		return error;
+
+	error = regmap_write(ts->regmap, HIMAX_AHB_ADDR_INCR4,
+					 HIMAX_AHB_CMD_INCR4);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static int himax_bus_read(struct himax_ts_data *ts, u32 address, void *dst,
+			  size_t length)
+{
+	int error;
+
+	if (length > 4) {
+		error = himax_bus_enable_burst(ts);
+		if (error)
+			return error;
+	}
+
 	error = regmap_write(ts->regmap, HIMAX_AHB_ADDR_BYTE_0, address);
 	if (error)
 		return error;
@@ -86,7 +114,24 @@ static int himax_read_config(struct himax_ts_data *ts, u32 address, u32 *dst)
 	if (error)
 		return error;
 
-	error = regmap_read(ts->regmap, HIMAX_AHB_ADDR_RDATA_BYTE_0, dst);
+	if (length > 4)
+		error = regmap_noinc_read(ts->regmap,
+					  HIMAX_AHB_ADDR_RDATA_BYTE_0,
+					  dst, length);
+	else
+		error = regmap_read(ts->regmap,
+				    HIMAX_AHB_ADDR_RDATA_BYTE_0, dst);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static int himax_read_mcu(struct himax_ts_data *ts, u32 address, u32 *dst)
+{
+	int error;
+
+	error = himax_bus_read(ts, address, dst, sizeof(dst));
 	if (error)
 		return error;
 
@@ -112,7 +157,7 @@ static int himax_read_product_id(struct himax_ts_data *ts, u32 *product_id)
 {
 	int error;
 
-	error = himax_read_config(ts, HIMAX_REG_ADDR_ICID, product_id);
+	error = himax_read_mcu(ts, HIMAX_REG_ADDR_ICID, product_id);
 	if (error)
 		return error;
 
-- 
2.44.0


