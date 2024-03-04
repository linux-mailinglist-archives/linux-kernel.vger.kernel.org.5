Return-Path: <linux-kernel+bounces-91285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA924870C48
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87571C21373
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A54F200D4;
	Mon,  4 Mar 2024 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nqbr3pNb"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78EA1CD10
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587192; cv=none; b=mZMNlV5fqKJaRpM2ICEg1741yS4+qDS8iRDTL1lV/yc/2VW+GwTvXXZIjzp1P6bHpHOnc/7UdHlxccn14KhNjpK2Yl+TvhzWMEiMnGgo+2sqfR2nXHkrCzBE/bZ1prepyIc5Oi698g2T7cTC8B/pDR1YxvIYsGGHNzc2QF2+VE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587192; c=relaxed/simple;
	bh=GzpZ/81jwqeQvoZLzsqYfc6Kb/FkPz/ssCrmMegdNyY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XBwF3MvEXSeenMCjTbsL5KInHjAEpq6YDGfyhiFk9JlsE5guz+28tvrhMK079WMLyGL3aJCrlesh+zrSX208jNG+L9vdp0aKEfR5Mt5oCd7VLmUH0Iql2tPyzTSNkfa/IQSu/b/mstKnnBHhaz1v97mdXICp3Vu6SYHVn4Zr68w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nqbr3pNb; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e5a232fe80so3051041b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 13:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709587189; x=1710191989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kuwjsv4D6U5YXnr6LRJiA6f6hlMDXAPMBAB9PBj+oJs=;
        b=Nqbr3pNbsSs8KOAPkHUiwKe6Fa7D4jH0z0CEshmReq56L35YYwMFneilP5LRy0BKSN
         +8rfkv/JPmB1jd5RQNm0sqD4cwRDfiL646dF3le/S6vjrlXeD4QZOnnIo6U5Sp9U196F
         Vm+EW8pkxbaGoMS44QB4mTwTcT6UgmBk8mw28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709587189; x=1710191989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kuwjsv4D6U5YXnr6LRJiA6f6hlMDXAPMBAB9PBj+oJs=;
        b=coaQG/5coJ16Y6w+5DrEjLzlu6BcrQH8Cm0+NCs+xEaejOmQ8naRUHFDrsLPk21Ll8
         jjl8N19xHm3PlcXzAyfXbBCNsTu8WVR+BmbmSLyankwAq7U+au6d+DIvFf6LxVZtk9bc
         rYQZ10izFY3QEfxsNhz0FGPtS9nP1n/o3ym6lVNbSbOOWp7Taism6XTT37RqkfUB8ZlH
         HSlkXla5YXYvwTTfHjo48Ohp7ET+KxaK0Kt0mr9Od+elxfU5UT5NTk2osjuujcO1eLgz
         fKdG2CfSM927l9kG9j2vg4eCB0pRlgicKxrL4nyDb001avXWYbyX3ntZCRVmEaNedCk+
         DEsg==
X-Forwarded-Encrypted: i=1; AJvYcCUaIV9almBT+ihERms7/7SRTeEHu30TBINC47r4AJXULFfoAHt89BTwmwzTTzaV9c3Ml514CWimF9UYiMc2gzkJalg2y7wJ4pavkszh
X-Gm-Message-State: AOJu0Yxp01z2rVQnPA6MgbVzCk5/KKzuxoricNlA+UwlxI0SR8E3xxx4
	wgJ4ugP8Tpp9xFlm8tta9FDmmoJnJnuCeKrf0qE2d9UPHd5Vg+GFaryHZ4Ms7g==
X-Google-Smtp-Source: AGHT+IFLxwTdMSiyaeqLoOgKMl1Ene20t6SG2k2rnn50xB6oOWu9hS/cIeVubtkEo9a2ceOAc//KiA==
X-Received: by 2002:a05:6a00:3c8e:b0:6e4:c592:deaa with SMTP id lm14-20020a056a003c8e00b006e4c592deaamr854224pfb.11.1709587189198;
        Mon, 04 Mar 2024 13:19:49 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t26-20020a62d15a000000b006e04c3b3b5asm8283288pfl.175.2024.03.04.13.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 13:19:47 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Alex Elder <elder@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] greybus: Avoid fake flexible array for response data
Date: Mon,  4 Mar 2024 13:19:45 -0800
Message-Id: <20240304211940.it.083-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5072; i=keescook@chromium.org;
 h=from:subject:message-id; bh=GzpZ/81jwqeQvoZLzsqYfc6Kb/FkPz/ssCrmMegdNyY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl5jrxN9hNacEYPFNk5QoT2iY8dnME3XUqQe4kW
 4SvJZfSbCCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZeY68QAKCRCJcvTf3G3A
 JjA/D/9ZZh0WdLrPuYsTqE5waxJVDv77dJ7ZtPPon1KGE7ZBUoDU2617qGC0iPW7EBH6V0zqmzM
 zZwqpVFu/pGNwMEfVPMNXj+q0FPfqAxDDQXWcpH/KVpEYQ1d+y7j+4dENod3GgXzeJxqEk0hR4Y
 lgDr8tKheYkl7kSH+a4r8mM5Kn8akoAA9nWpvg5bDzQIefT7dAoUULSbzrMqEkiz4OdQr2XrGZo
 XPPKxbu09NtSJOLMXgkrQAXQJJue1JZwhQSzQ283Di6OjQXDZnwEDUM6ZubiIMztf5uRJ1e70NI
 m3ca/eug+fjncW2K5aciaPRf7FfISVjaXM9dHvSrLPy9KbKlLelXFeOb252L5fi4zz0g2ce8aVR
 k5QWe0rQRUjGAMfaf05h41sTbv8qppoIfNyysuPEx2tCdlX+ut7A9AV2wnIeoQU32JBgDIzHa5R
 Ayd05DxHwPoze3qRRg8H1D1DkGCsOp6V9K1EgLs/J94xN4kOM+X1CYfiFV+tw5pIFPuwIrYcjY/
 YMn9dLJ7lGZifd1eN6LmnKniG/o38iJhTJTL4bVsrsZHOfFHBE1O0E7X6gdjGYOkUOPV1Q1Eb+z
 VCFyTofIZ3UVEye8ohwp1XI3YF8sGZXa5Jtv4yUpv+9EskUlTq7C2p1iUkgQwl2pl6ZKftEqQ1b
 kGTKWup urpNnjpQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

FORTIFY_SOURCE has been ignoring 0-sized destinations while the kernel
code base has been converted to flexible arrays. In order to enforce
the 0-sized destinations (e.g. with __counted_by), the remaining 0-sized
destinations need to be handled. Instead of converting an empty struct
into using a flexible array, just directly use a pointer without any
additional indirection. Remove struct gb_bootrom_get_firmware_response
and struct gb_fw_download_fetch_firmware_response.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Alex Elder <elder@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: greybus-dev@lists.linaro.org
Cc: linux-staging@lists.linux.dev
 v2: add comments about removed structs
 v1: https://patchwork.kernel.org/project/linux-hardening/patch/20240216232824.work.862-kees@kernel.org/
---
 drivers/staging/greybus/bootrom.c         | 8 ++++----
 drivers/staging/greybus/fw-download.c     | 8 ++++----
 include/linux/greybus/greybus_protocols.h | 8 ++------
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/greybus/bootrom.c b/drivers/staging/greybus/bootrom.c
index 79581457c4af..c0d338db6b52 100644
--- a/drivers/staging/greybus/bootrom.c
+++ b/drivers/staging/greybus/bootrom.c
@@ -243,10 +243,10 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
 	struct gb_bootrom *bootrom = gb_connection_get_data(op->connection);
 	const struct firmware *fw;
 	struct gb_bootrom_get_firmware_request *firmware_request;
-	struct gb_bootrom_get_firmware_response *firmware_response;
 	struct device *dev = &op->connection->bundle->dev;
 	unsigned int offset, size;
 	enum next_request_type next_request;
+	u8 *firmware_response;
 	int ret = 0;
 
 	/* Disable timeouts */
@@ -280,15 +280,15 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
 		goto unlock;
 	}
 
-	if (!gb_operation_response_alloc(op, sizeof(*firmware_response) + size,
-					 GFP_KERNEL)) {
+	/* gb_bootrom_get_firmware_response contains only a byte array */
+	if (!gb_operation_response_alloc(op, size, GFP_KERNEL)) {
 		dev_err(dev, "%s: error allocating response\n", __func__);
 		ret = -ENOMEM;
 		goto unlock;
 	}
 
 	firmware_response = op->response->payload;
-	memcpy(firmware_response->data, fw->data + offset, size);
+	memcpy(firmware_response, fw->data + offset, size);
 
 	dev_dbg(dev, "responding with firmware (offs = %u, size = %u)\n",
 		offset, size);
diff --git a/drivers/staging/greybus/fw-download.c b/drivers/staging/greybus/fw-download.c
index 543692c567f9..a06065fb0c5e 100644
--- a/drivers/staging/greybus/fw-download.c
+++ b/drivers/staging/greybus/fw-download.c
@@ -271,11 +271,11 @@ static int fw_download_fetch_firmware(struct gb_operation *op)
 	struct gb_connection *connection = op->connection;
 	struct fw_download *fw_download = gb_connection_get_data(connection);
 	struct gb_fw_download_fetch_firmware_request *request;
-	struct gb_fw_download_fetch_firmware_response *response;
 	struct fw_request *fw_req;
 	const struct firmware *fw;
 	unsigned int offset, size;
 	u8 firmware_id;
+	u8 *response;
 	int ret = 0;
 
 	if (op->request->payload_size != sizeof(*request)) {
@@ -325,8 +325,8 @@ static int fw_download_fetch_firmware(struct gb_operation *op)
 		goto put_fw;
 	}
 
-	if (!gb_operation_response_alloc(op, sizeof(*response) + size,
-					 GFP_KERNEL)) {
+	/* gb_fw_download_fetch_firmware_response contains only a byte array */
+	if (!gb_operation_response_alloc(op, size, GFP_KERNEL)) {
 		dev_err(fw_download->parent,
 			"error allocating fetch firmware response\n");
 		ret = -ENOMEM;
@@ -334,7 +334,7 @@ static int fw_download_fetch_firmware(struct gb_operation *op)
 	}
 
 	response = op->response->payload;
-	memcpy(response->data, fw->data + offset, size);
+	memcpy(response, fw->data + offset, size);
 
 	dev_dbg(fw_download->parent,
 		"responding with firmware (offs = %u, size = %u)\n", offset,
diff --git a/include/linux/greybus/greybus_protocols.h b/include/linux/greybus/greybus_protocols.h
index aeb8f9243545..820134b0105c 100644
--- a/include/linux/greybus/greybus_protocols.h
+++ b/include/linux/greybus/greybus_protocols.h
@@ -232,9 +232,7 @@ struct gb_fw_download_fetch_firmware_request {
 	__le32			size;
 } __packed;
 
-struct gb_fw_download_fetch_firmware_response {
-	__u8			data[0];
-} __packed;
+/* gb_fw_download_fetch_firmware_response contains no other data */
 
 /* firmware download release firmware request */
 struct gb_fw_download_release_firmware_request {
@@ -414,9 +412,7 @@ struct gb_bootrom_get_firmware_request {
 	__le32			size;
 } __packed;
 
-struct gb_bootrom_get_firmware_response {
-	__u8			data[0];
-} __packed;
+/* gb_bootrom_get_firmware_response contains no other data */
 
 /* Bootrom protocol Ready to boot request */
 struct gb_bootrom_ready_to_boot_request {
-- 
2.34.1


