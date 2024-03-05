Return-Path: <linux-kernel+bounces-92415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEBA871FDC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279B71C2341C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C8985959;
	Tue,  5 Mar 2024 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="qwGPOhIu"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF6E85954
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709644576; cv=none; b=RmyhFSAhKpfM/bjAwGOy/J3iRy+ca0TnzOluVjvBMVKyigRfpsS3H7mFJoIrGXQyz0sV/iOFubHhBZ11t1tiBzzCmCmOERwZtH2M5HOZU31LdLUGoCmtsA+mK4twRvDQJ5nxwmBno3o2vUz1ywH87syVDXoSTF35eje4aVjS85s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709644576; c=relaxed/simple;
	bh=+dZdFqYSeTBhHCI/BvnkTnL3SyFJABSSpjeS4o55OME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bbDks8RCf9B7Xsbv3Gg2dbTVQkJeH6lnX5HQ8M4QKMTLkGXbN5Fay3mjWHjpWO78smjwX41hwxKpV8QgEcMcWs5GQYmDTzOnJ+k7HOQ7ZJJWrw0Kx4593W9+n8O5g3uwsknV6hF/l68Tr0pam7pK6j10EfKvQ9+WvUWcCDzSphc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=qwGPOhIu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dcab44747bso46247515ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 05:16:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709644574; x=1710249374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gadEZlo5HX6ZvCpKvvvFLxpx/LQrgu8T3YbMhZTBo7E=;
        b=VMHN2nKWqXVLwFFqSrqgP1iCeE9J5aKLK9Hfiz+A2o42351fNOMm0h/9FOYF4NrUZS
         eQBTI+k9RWCoaoN0MQNgnF35QyPcwhhonNB8rWnDnYZ9bfH5qMCNeK0gh41zOXWJBhF3
         5gnXsS4VtJID0YeRWNAZfy9cn6oAJ096z8K7lVO+EUzZ8w+fTDkLtKlE0FOUFTKn5MqD
         MhL4Oroa094cmoxhcdLEKCjudKphznAaaBexcY9ZiPpMHP9R+VUILSdkvpJEwZgkpzA9
         IgsufUU8+fsv11SOTj3Zv7pet7Jmg4v9LhNHFgbHwoAOqOxMzLfaDenOfSzgc4sbrB30
         M60g==
X-Forwarded-Encrypted: i=1; AJvYcCUqCkJ3VI6vpb1iSMQ/yOxd9O1c0sJEo+7boOxPHR9tZpMafWRv293ANrm4TeIEOA8A0oMyYfXxCv13vNWmhLVfZt6qtCfSCNZcX7e8
X-Gm-Message-State: AOJu0Yw44O4A0du+WvIgQNnLFUp/K+P5xapDBj6gfSC2hvZ3afiYvk2u
	827n41T5tJYYTCA9vpYJkkGstvLDuL/JWPnOn4gZP/8qCGemnsOf
X-Google-Smtp-Source: AGHT+IFxlioFA+0snm0cpY62UqyNrvze7kGIh/a9o4bx+H+50s4b27RXJpgKgrdJBQz1ek0gYH4x2w==
X-Received: by 2002:a17:902:e74b:b0:1da:22d9:e7fd with SMTP id p11-20020a170902e74b00b001da22d9e7fdmr1972561plf.20.1709644574032;
        Tue, 05 Mar 2024 05:16:14 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id l15-20020a170902f68f00b001dc96b19616sm10493335plg.66.2024.03.05.05.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:16:13 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709644572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gadEZlo5HX6ZvCpKvvvFLxpx/LQrgu8T3YbMhZTBo7E=;
	b=qwGPOhIu1JrBU+Ku4MfcnysPIzAdIiHZA4ojvs5dgJoNaxxRzWfO0isA4s23FJ2AvErtvL
	uMhE6ciJtGgSJaUpjJmegQIqKOMWpsa3Ig4dthh+kNATuAPUly6Pf0xMssF83j4w95mHk2
	hdpNwolcz+WnZW3dnZwP8AQxczG8LM00nspFDceybthbEd6XloCup/DnGYhglIB85oIJMN
	AlX2O54usTDfubIpGeSVQB51ZY8yMIxwEO1/bKdCD+6TfjHKJSXHy/i17GPLBQJbClMv6/
	mpsR89ucZhVRjY6+F0xvC9CDjfnnTmh2OcjncrKSYpzBnYo3UowfWvMXyVdfHg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 10:15:57 -0300
Subject: [PATCH 2/3] nvme: fabrics: make nvmf_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-nvme-v1-2-c707fc997774@marliere.net>
References: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
In-Reply-To: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2439; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=+dZdFqYSeTBhHCI/BvnkTnL3SyFJABSSpjeS4o55OME=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5xsRk7shI3nEmZOyWDcbHBkqIDALjOp8rSwRS
 PW9luUHba6JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecbEQAKCRDJC4p8Y4ZY
 pokLEAChkBvAmbdjHqdx0mLrG/G/zqnAQyWG16mp9+F/bfOltpDc+KHT6w8q9AlAcWuDi+A0quH
 Aqb8pXZ1LLW2ljEQ79Uyc2GUZ1RBY+POjejYCmNW5B2yqFb07gbpV4hTbAwIiCIe1CvhiV4BdUt
 hyZDu0RypQUJKvMmF3yq6KpWnJkHzxJja2OEYWtLg0w+ekav60KkFSiC2AT/hg71jd+LWnYlXAc
 MUxDRpSjUSwsnUSG8yg/CVdHpxTg4ICOEb2oqEH7vFLUGLK3VkaAUWrxs1pmFVqnCqnJswhWjXT
 u78DPjsdkeJY2INFFkYoJVsxYgKZjgY2S0ja7YBY/j7ynwpMJE95fU91qgFgtFRpble9PmOtNqH
 +veGO4HF8hR8Hz+IpCiNQshdJEpb0jCuih1Adnwu3n/3VPDUsUHMfGULc961qqkhGcEws92j9OT
 B0K5wiox5D5bvBtKGYhUMOFnftMYvB6D0gC/4rYtzlZYb2eKhm6Z2jB4rK5dzL0FfGPAh2R1n6Q
 Nof4Oyx5x2CNKa0TppQ7zY4GYed6Ltf9tDnNrbgAwT1ZLekAAocUIYQL2UgzYXr3hCmTnlP/xHt
 d0jhQaiSufymo8Xf7iQJODbUl6YuyeHRQS+Vy48BC2xPqwOhU3JRn8RRwjrmlNZClBpErCZvF8o
 8Ad9eeLbDqms8Eg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the nvmf_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/nvme/host/fabrics.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3499acbf6a82..94e0911c43bc 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1318,7 +1318,10 @@ nvmf_create_ctrl(struct device *dev, const char *buf)
 	return ERR_PTR(ret);
 }
 
-static struct class *nvmf_class;
+static const struct class nvmf_class = {
+	.name = "nvme-fabrics",
+};
+
 static struct device *nvmf_device;
 static DEFINE_MUTEX(nvmf_dev_mutex);
 
@@ -1438,15 +1441,14 @@ static int __init nvmf_init(void)
 	if (!nvmf_default_host)
 		return -ENOMEM;
 
-	nvmf_class = class_create("nvme-fabrics");
-	if (IS_ERR(nvmf_class)) {
+	ret = class_register(&nvmf_class);
+	if (ret) {
 		pr_err("couldn't register class nvme-fabrics\n");
-		ret = PTR_ERR(nvmf_class);
 		goto out_free_host;
 	}
 
 	nvmf_device =
-		device_create(nvmf_class, NULL, MKDEV(0, 0), NULL, "ctl");
+		device_create(&nvmf_class, NULL, MKDEV(0, 0), NULL, "ctl");
 	if (IS_ERR(nvmf_device)) {
 		pr_err("couldn't create nvme-fabrics device!\n");
 		ret = PTR_ERR(nvmf_device);
@@ -1462,9 +1464,9 @@ static int __init nvmf_init(void)
 	return 0;
 
 out_destroy_device:
-	device_destroy(nvmf_class, MKDEV(0, 0));
+	device_destroy(&nvmf_class, MKDEV(0, 0));
 out_destroy_class:
-	class_destroy(nvmf_class);
+	class_unregister(&nvmf_class);
 out_free_host:
 	nvmf_host_put(nvmf_default_host);
 	return ret;
@@ -1473,8 +1475,8 @@ static int __init nvmf_init(void)
 static void __exit nvmf_exit(void)
 {
 	misc_deregister(&nvmf_misc);
-	device_destroy(nvmf_class, MKDEV(0, 0));
-	class_destroy(nvmf_class);
+	device_destroy(&nvmf_class, MKDEV(0, 0));
+	class_unregister(&nvmf_class);
 	nvmf_host_put(nvmf_default_host);
 
 	BUILD_BUG_ON(sizeof(struct nvmf_common_command) != 64);

-- 
2.43.0


