Return-Path: <linux-kernel+bounces-84814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CB786ABE8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147B11C2599E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3FE37165;
	Wed, 28 Feb 2024 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fb3laZnx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169CF37141
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115050; cv=none; b=cJ/DwzRHWRSqYxpYLdP/Gaauygz6bfwhQl6qnTh0MotlYy7suhu7E40Kn0RflLtTW08XYXrqZipBEggJy+EZvqBvQfJxJg3s4UhBMvug6w31bhF5bXzGZlnMszZG+dCxZXxpXpZp8nrOZdXxOISVKI92xepaHWByfrOVLjJ0Bww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115050; c=relaxed/simple;
	bh=tdz0czbokXbZx8NoSb1bVuk3MM7myK0Cqgqnu3P9uqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g0hMEmqzpZ0ItrV2w9ciUqZtof2ikPdZMf6vlqGoDwsijnkMfLZRVbCymUiKWg8YjKJGSPSlHye21Vw3f/EHJT5nW7ZcPKiYimNXOBQDxKWPvBK1BvqtH3iBJdYiZd90i44Gvk1DnKEuY7hKqiNqrCFkNR6mpJpIAy95V38/zFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fb3laZnx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709115047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EDEC0vsrgcNRv6UvAcMAg7ZhZIrIeAEq54Sn/mnIp3o=;
	b=fb3laZnx2pUCA0VcBlf7g//IH6KHspfITBozR30Rcth6FE9ghAzdWHxB5mLtMb+WlRh05U
	q40HKdjhjaoiiMC/omy6O/Ar8ybz2S/SKCIPPXrCBvBTPc6fRSiovUyf9bc5Qa+FOlxpBd
	0256CMDXl32zs+v9oxL3MkiUVaseH2g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-_1zB7Cs7N8KPJ7GFQhs2hw-1; Wed, 28 Feb 2024 05:10:46 -0500
X-MC-Unique: _1zB7Cs7N8KPJ7GFQhs2hw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40d62d3ae0cso28303365e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709115045; x=1709719845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDEC0vsrgcNRv6UvAcMAg7ZhZIrIeAEq54Sn/mnIp3o=;
        b=sLc3FWTYoZBD3IXm0BM86XMga/Ikog6WFHr8nREAS3B52OKy+uunXwlPWsVjBFxACu
         3szuDv4X0LmvLndcPsZcf9AFKFlQf1odVyQJVXWrJldjarLLVQRpLT85AOZ1mIG3ddng
         TijkbsEdP7IhSgEMmDLm5LJA/wi6AM2BOX6p7+grPt0Y+hjl/SyNvJEEuye9wmZSiDn2
         j3hrH1433TzcSmsaD/JUuLgqB3pto9Eek2ovA5coxp7Ib8YDDcfAYTjHvooyQTDxiZZ5
         IK4rFuu/k6hDI5zWsm3whDr8JNfGqheMlI2I19y1khraQSmaSXhO+k5q0JSOLkqqILkE
         N1yw==
X-Gm-Message-State: AOJu0YyTsiFgu3CGsuBDUcQx3cs03hak8+mPQeZBRKM11OOLehFMEXvr
	p4TDUvVpMaeREgMrNRqHMiGf09+LVcwvm2lBgAtFIaNgG/eL+Ukdgm5e07TQTPRqsME+B/ltGry
	eHHJeW+COqRGLh/zmTvrqhVJHGV7qzkMcdjJwgazZAPbbbNP8S3PputEfoCoAy2qBPrKc5vWUHe
	DPe2Zsl6aI7BCOovMkhCfF5xRDIh/bALwCJ78eAlfX6+jM
X-Received: by 2002:adf:e30e:0:b0:33d:6bd5:9f00 with SMTP id b14-20020adfe30e000000b0033d6bd59f00mr8878807wrj.41.1709115044964;
        Wed, 28 Feb 2024 02:10:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNBvyItDUcjcIv0Np/7pXiZKIT9CIiSDAQ+3HmvfjfhrAlJ9hPwCLMmeprtUdu0nI7lbpBTg==
X-Received: by 2002:adf:e30e:0:b0:33d:6bd5:9f00 with SMTP id b14-20020adfe30e000000b0033d6bd59f00mr8878785wrj.41.1709115044551;
        Wed, 28 Feb 2024 02:10:44 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bo28-20020a056000069c00b0033b406bc689sm14668667wrb.75.2024.02.28.02.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 02:10:44 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Kalle Valo <kvalo@kernel.org>,
	Li Zetao <lizetao1@huawei.com>,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2] wlcore: sdio: Rate limit wl12xx_sdio_raw_{read,write}() failures warns
Date: Wed, 28 Feb 2024 11:10:32 +0100
Message-ID: <20240228101042.728881-1-javierm@redhat.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When these failures happen, the warning and call trace is printed which is
excessive. Instead, just print the error but rate limited to prevent warns
to unnecessarily pollute the kernel log buffer and make the serial console
practically unusable.

For example, on an AM625 BeaglePlay board where accessing a SDIO WiFi chip
fails with an -110 (ETIMEDOUT) error:

  $ dmesg | grep "sdio write\|read failed (-110)" | wc -l
  39

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
---

Changes in v2:
- Add Reviewed-by tag by Breno Leitao.
- Drop warns which seems excesive and rate limit the error (Kalle Vallo).

 drivers/net/wireless/ti/wlcore/sdio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
index eb5482ed76ae..70b9648acaaf 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -75,8 +75,8 @@ static int __must_check wl12xx_sdio_raw_read(struct device *child, int addr,
 
 	sdio_release_host(func);
 
-	if (WARN_ON(ret))
-		dev_err(child->parent, "sdio read failed (%d)\n", ret);
+	if (ret)
+		dev_err_ratelimited(child->parent, "sdio read failed (%d)\n", ret);
 
 	if (unlikely(dump)) {
 		printk(KERN_DEBUG "wlcore_sdio: READ from 0x%04x\n", addr);
@@ -120,8 +120,8 @@ static int __must_check wl12xx_sdio_raw_write(struct device *child, int addr,
 
 	sdio_release_host(func);
 
-	if (WARN_ON(ret))
-		dev_err(child->parent, "sdio write failed (%d)\n", ret);
+	if (ret)
+		dev_err_ratelimited(child->parent, "sdio write failed (%d)\n", ret);
 
 	return ret;
 }
-- 
2.43.2


