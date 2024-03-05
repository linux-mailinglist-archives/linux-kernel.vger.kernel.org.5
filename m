Return-Path: <linux-kernel+bounces-92417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B3C871FE0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B641F23D64
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236298664C;
	Tue,  5 Mar 2024 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="rTsvBQq9"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76A085C42
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709644579; cv=none; b=tqZAjify/jDmOylodb0khD0xY/vt6LmnDpcVjCFbPZW5pOO6v6W1CzHLLgfy3aO/uEAu9uq1Jj3mG/Fj5WNAmwNUXEpQuKQc+mHa8GFn/VA0jkaQoe3Mxtu3rEVHme8/rVpizGUoPtujmM6bUMd8GHXz15LZfyGyJTQsB6BGhFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709644579; c=relaxed/simple;
	bh=dhrwlnVq2theRONa+InVWSZTMPvREYNEiPaTBGSHGGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a8nb+bJCt0eJzDu8TqqALJLfkxCBHzADwkxsJSG6aE0uL3y97ImoP9rdqaXL44zEg7M+pHUef2gczU2HlQ7hWN+c8YGRfy5O/1ZPUYqtPvP4b2LeZgSudUJSxKOq7Tdir5wcracvHWBEUFsVviUJZhRFn59ZzWcWcx1AEmZQNdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=rTsvBQq9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dd10ae77d8so17181845ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 05:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709644577; x=1710249377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bqt+8cktK+V8idZwjIDNU1rO/elSFQ6X7CURi/kzXvg=;
        b=vvk2vcSQh/nNTJey3P9ykav7yGjrHUKjNIcaaNACcWca/dhzkURteQqLysNwvmIvtN
         CNS1Qqlr6P7vn5a98KJbc0IKHlYqPNxvH6ARCzWRg84cd1K5jHnUNEgbrNf9+MSeOLyE
         gYGGfVckfGqB++koJEFX3uTYTcIq6BfgFPGcoh8piHGaq/TZbwEGBvW638LGu1sylSOG
         Z6QP4DgA/htU+Jv9GkRgJH9nGl9VxMJmWn77QUbD5YUm4GUFtO8c7wYleUe24D/N2eYS
         8HBxIvm3bNGFGYJc+nMTh3RtFP5mOq0sC37CYHlHotkFbTu0cmQcKPJsQ6xRqZytIzRU
         DFJw==
X-Forwarded-Encrypted: i=1; AJvYcCVbg9qyGl+bi/eXxWGFF5DksQVeVIPhERnHxsddP0zAq5URea+xehufUBi5j4U5+HZClsrrtR+yg+NTTXJqs1gC8Yo5xsnut9jFJezM
X-Gm-Message-State: AOJu0YyBjGbXEUHtQQklLMFT1OXPt4nlzQMvPiyJwLdNocC8brtKdeeB
	U3wPkXQ7JS3YB6obdHS6FE7c0hOUS2rdXaxehuNbt50m/OKQJrYC
X-Google-Smtp-Source: AGHT+IG9CQ/TOywUL0lRZw8A45CBzTLMi8LoTwLkUWMwPnBC6g9eldfxFCnZ7t4YOlOhH9FiQJOjqQ==
X-Received: by 2002:a17:903:1249:b0:1db:4419:e925 with SMTP id u9-20020a170903124900b001db4419e925mr2003858plh.1.1709644577073;
        Tue, 05 Mar 2024 05:16:17 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b001dca813b07csm10502348plg.62.2024.03.05.05.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:16:16 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709644575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqt+8cktK+V8idZwjIDNU1rO/elSFQ6X7CURi/kzXvg=;
	b=rTsvBQq9uE6VWvj5xypr/90eZoYr/nFmabxffrvmshWjFc8ehvdkQhf+deH2N0rozSXbZW
	w27TUHwR49lidBoYAvii5CSaYjN8uyXDYcCwXNMCW5r3W3FmQ9xSGwSGG5CjNOcYT6o+qt
	G8t9iuyTjkT6ZUNQNEnIQuw0NFUMCEW4d68AvpEFleB44jEuKPrhoGVgV/w+o7LAH1ukvA
	CsSi1U+Xlspo2E5TBrgjTUTPiL08HFyAzZN4FxHFy4hDrbvMjLQ1ajF/WsipIoY7NiGMa9
	ZyoPqbLmsXdnv7PvO/5QaSV9QkJmx5ohTYsbWlSEU3oaHpGo+dOCF61i33QtOg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 10:15:58 -0300
Subject: [PATCH 3/3] nvme: fcloop: make fcloop_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-nvme-v1-3-c707fc997774@marliere.net>
References: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
In-Reply-To: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2109; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=dhrwlnVq2theRONa+InVWSZTMPvREYNEiPaTBGSHGGM=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5xsRXt2+dITQnRqAEy1FoOdCoRSxRNbVfJPrz
 CQVOd6gJjuJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecbEQAKCRDJC4p8Y4ZY
 poQ+EAC1E0hCOgTum9T66zK+bF1h7DVrDRQqDcefQv/xbPQa/qn1ho/7PMqlVqH9EI2Ns09s85t
 qYZbHDCbGNlFF99xy7Gr5WrmJ/+f+UmuIQjGIj35ZZDWaG1SQ8L7EG23TJnxnLELbN74tGkY8W4
 25cHoAaTo4KRYqMZ7IR0eX8ftfzjhp51yzzpEjLF2jwcO8RqryhEg329LkMNXEIpdf11GPO+6ac
 YZ2zwboPONSN3L2SzmhueKnPExWkGBleZY0m7NE5PyaVFNycui4V5jIrmPw5zwGQO7LAz3jVD0v
 7qYBokatdGrF/K7hPJ4E1bYWjYYi53Q51lRX4MwXl1hDlszzRx0OhVLz6mFhP7LVVfnZ5N3mk7Z
 QbhAzra4F/8V/RiAjAOzzofKtgN/3OSehe8sHFPnSvT2NDERYtmG/8N6Ij+BoXucesN0L6a94a4
 UoeVhXjelNf/BTzjqmHCz03hf+CewLXh9T2loEE3NbS/ngxbbY9DGfNe3KYst0FGXpvjesZH2P/
 mZr7vnqov4m4jHUuv2ffl7s3uyUXAA77wwFBgDaxUrsgXr4xGee71thj9amwPPMyAqfQ+P34tPE
 bu9zUEQW65CD5QbiS2qwYd3ig0zxQFNxvTwahoYZMNNNbdvweZ8isOAmn2Lrz/pACbh20vEAXuU
 eJ3SkhzQmeXvccQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the fcloop_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/nvme/target/fcloop.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 1471af250ea6..913cd2ec7a6f 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1556,7 +1556,9 @@ static const struct attribute_group *fcloop_dev_attr_groups[] = {
 	NULL,
 };
 
-static struct class *fcloop_class;
+static const struct class fcloop_class = {
+	.name = "fcloop",
+};
 static struct device *fcloop_device;
 
 
@@ -1564,15 +1566,14 @@ static int __init fcloop_init(void)
 {
 	int ret;
 
-	fcloop_class = class_create("fcloop");
-	if (IS_ERR(fcloop_class)) {
+	ret = class_register(&fcloop_class);
+	if (ret) {
 		pr_err("couldn't register class fcloop\n");
-		ret = PTR_ERR(fcloop_class);
 		return ret;
 	}
 
 	fcloop_device = device_create_with_groups(
-				fcloop_class, NULL, MKDEV(0, 0), NULL,
+				&fcloop_class, NULL, MKDEV(0, 0), NULL,
 				fcloop_dev_attr_groups, "ctl");
 	if (IS_ERR(fcloop_device)) {
 		pr_err("couldn't create ctl device!\n");
@@ -1585,7 +1586,7 @@ static int __init fcloop_init(void)
 	return 0;
 
 out_destroy_class:
-	class_destroy(fcloop_class);
+	class_unregister(&fcloop_class);
 	return ret;
 }
 
@@ -1643,8 +1644,8 @@ static void __exit fcloop_exit(void)
 
 	put_device(fcloop_device);
 
-	device_destroy(fcloop_class, MKDEV(0, 0));
-	class_destroy(fcloop_class);
+	device_destroy(&fcloop_class, MKDEV(0, 0));
+	class_unregister(&fcloop_class);
 }
 
 module_init(fcloop_init);

-- 
2.43.0


