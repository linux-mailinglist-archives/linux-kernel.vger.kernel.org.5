Return-Path: <linux-kernel+bounces-60648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E31850808
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2D02B228D1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 07:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C957F4595D;
	Sun, 11 Feb 2024 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="AXuAnsP4"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448644437A;
	Sun, 11 Feb 2024 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.132.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707638218; cv=none; b=AZnOR3gdz1fwAXhDmKfM0ZBoWQvWT82BtTHQnaI3IMu4PLT3vxqyxWi1pm/ETkqfL0Q5WZyA/ABt/8v2fRbg9rlKsKk8QQ4qo8zmBKmTNdVEk1E5yevypbdrD9K3QzhCHfK2lCSwI5lzs/ZdN9dQbi6QrERlXusBCYM94Jpt/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707638218; c=relaxed/simple;
	bh=6AKgtrBfCsel99oJPCAdmr2PiW5gpjpbUluGKeTb9f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfSSvt9k3yzgYiWs2G7sORxdFhk1Yml9RdpiUbIhjN9D8nZpetg6zDFW5f2bKbzvs6kQKIle5ZIP2s2+Xb5iFaBXH9BSrU3VcnnBrUw7HZLgrmKN/+CAJIeI2jcHyvtq+ljIvCNpfKs4Lfe+rg8is1NZDxjaCQr447P6wvlw9OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=AXuAnsP4; arc=none smtp.client-ip=172.104.132.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.101.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 1CD4A327B85;
	Sun, 11 Feb 2024 07:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1707638209;
	bh=6AKgtrBfCsel99oJPCAdmr2PiW5gpjpbUluGKeTb9f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AXuAnsP4jq5ARLjpnPbunCokwUwWzvPk4NpkL3xoiCmBoyZp1ihKkzLFUbz8Wq5Qx
	 eFFjZIvYlPx4WdcR/45b2vYQKUwPfUg9A1qoRjyKbh1B6Hv2R4C8sI6ab83uFNTZ5N
	 EdE7nQSpdadKuU1HRuAcfr51RsWwZlbEbHDjNfXY=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 2/6] iio: pressure: hsc030pa: use signed type to hold div_64() result
Date: Sun, 11 Feb 2024 09:56:33 +0200
Message-ID: <20240211075645.28777-3-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211075645.28777-1-petre.rodan@subdimension.ro>
References: <20240211075645.28777-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use signed type to variable holding the result given by div_s64().

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 no changes
v2 -> v3 split cleanup patch into 3 parts, no code changes
 drivers/iio/pressure/hsc030pa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/hsc030pa.c b/drivers/iio/pressure/hsc030pa.c
index d6a51f0c335f..7e3f74d53b47 100644
--- a/drivers/iio/pressure/hsc030pa.c
+++ b/drivers/iio/pressure/hsc030pa.c
@@ -406,7 +406,7 @@ int hsc_common_probe(struct device *dev, hsc_recv_fn recv)
 	struct hsc_data *hsc;
 	struct iio_dev *indio_dev;
 	const char *triplet;
-	u64 tmp;
+	s64 tmp;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*hsc));
-- 
2.43.0


