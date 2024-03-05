Return-Path: <linux-kernel+bounces-92414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61C3871FDA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416671F2398A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA6686128;
	Tue,  5 Mar 2024 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="cKFrfHDg"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB6585C6A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709644573; cv=none; b=n3pnsXm+MLwJEGFg1OoRjqcCTlCCooCJf1eEvu92sOOQ3jjYQx0+HxhDCxSyS8RhSYc74qoQKwDviyQC5pNSq7YlkO8J2fAqTPjyg3aff8pNa67JYBgXB+HcrXXs/sSDQhpKgghP33DXmsTCnYlUK2HdvjiGopUkVnlZPVmZg6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709644573; c=relaxed/simple;
	bh=N127LXZt4grt1w/gMcszgp3Y6dKY6UU9hI85A/v/RiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pJBAhapuLa2eG/ToG7VUUdoREDzTUqbV1wcyujwxee1hutmKbcydakyMYh8Ci5KQPd0X2KzFB52PhCIZSQUHnUAftYDN82CInJOw6tS8grfccFEIjudp1YXtiBDZZVsOK8ahRJ3/O9CGJlh17bkbCSxBHwdc1ddYuyn5ZNcTIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=cKFrfHDg; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6419cd4ddso341414b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 05:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709644571; x=1710249371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=09m5+SBfJc6gX7T4nbwPoMZXriAQEu+6FlQsl0sanWI=;
        b=qh4EfOTmEcISaTfY7eOzZqp6btwLZpLRsbdvTfpYxb2YFiJMWmYQI5g1dHR5wVF3F/
         a26tNih83lMmj2+pFZmS7gm4yLipf2UJifqMZ3LJDjHw7A7NMgqiGcCMW2WzXNlfyshk
         Lpg/Lai6rgDyb4sJ51n2JscWP143zbTPzr37rZ3xCy2W+yq2ZEGVB+3uLu0zPoTVZcOl
         KuWvMGdh6YJPSw1Esm1oRL1CCctoZ5gQ1Lydd+Wi1XMXb0jwU/haUluRMtmwjkDtIrxM
         MlTTynYSl4YiWCwmRK3/oGD3iTo4RVMCBfZDYHmwL39X5/lrVC+rE91f0HuB1l59wCJb
         GPKw==
X-Forwarded-Encrypted: i=1; AJvYcCXK3CM8d8Fi4+rNA1GwNzqov+8fSTpNPteaz7lz3+KiOgJ/QOeof/VagPTtuba531b5BMnIpote2CcVWKfmRD3gqKktT/tXbRNkFXNI
X-Gm-Message-State: AOJu0YzWzkxDRp8glrUHy3G4ATPMLKhp5GOKVukybW0PLwnOYIduva6l
	RELo1fZCJjnL2PizMIXQeo/nN0jWyg3hpDGsV2SNKTjYcT4SXpgS
X-Google-Smtp-Source: AGHT+IEeC1ChjkRaiz7c+VB8f3cr0pptDOo5y15zzCK+P8Uc/lkjf/BcXyQejrRAR+y/zgOz6btJXQ==
X-Received: by 2002:a05:6a20:8f0c:b0:1a1:4cd2:4398 with SMTP id b12-20020a056a208f0c00b001a14cd24398mr1743647pzk.8.1709644570566;
        Tue, 05 Mar 2024 05:16:10 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id m19-20020aa78a13000000b006e509762bc2sm8948560pfa.26.2024.03.05.05.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:16:10 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709644569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09m5+SBfJc6gX7T4nbwPoMZXriAQEu+6FlQsl0sanWI=;
	b=cKFrfHDg4W23mqvrUZ0nGbHiVnX0hmV+shCzba6XDCQjiiMQlkV2J7Ml2bvrvTyUZ65wHv
	Q0IPP5SxrqylsP49H9OkuHcoRVnzJ9RhPzAWw/8fqW5W8UuteBcYOlmzRfNQvfze7KNmrq
	ZfTsIotK43wZ38CHui4I6bwK428aEcfKeU7kSh1BJ0ddgAE02P7AlGgtTeDvO0Wtn2xEAb
	Q3AalaM8mhaDYZZQV8z3Mu8623dr790ndU26llwaFsnxRwFYJ86BBMBUFewPI5nQJRtgeT
	8UdfoaS7bgQOdmY+FcH26jXFrE8qLwnOIbLvhoVmbeR+4ydUV9UaMAnyCXzgLQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 10:15:56 -0300
Subject: [PATCH 1/3] nvme: core: constify struct class usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-nvme-v1-1-c707fc997774@marliere.net>
References: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
In-Reply-To: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4952; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=N127LXZt4grt1w/gMcszgp3Y6dKY6UU9hI85A/v/RiU=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5xsRAgbkZFHltPBoK7XwGNvlCzRSGVI2XEudk
 eoKO0P71o2JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecbEQAKCRDJC4p8Y4ZY
 psf7D/9xaaHQVVjmQLJ/6qwlPxjZZAPXOIVGYtTc3mGa3fmormjDdsvtxJVYybF5kToAel1CP5/
 W9Ri0Gf6QPj/SxaXuwO+LCnm/3uJ2LtWklaYyzeRTbmNzJ80FTh9MntPLp6WsdPh9DBXjot5EuQ
 E4PC4uOS4TdQfmjW/UcL2CI+vZDajsdKna59Bo6/nTCSeg8Sch4K3Q+13bQHu/C+UXzqeS9yixG
 Z0vipWjThk8JfnD/mBS6q8OEVF1glL8Bly1iOiY0hY+AjcX5sfPaIGA/uRYPSEiAQzOARm5DRl+
 R+L2jnIbv4TzSdDnh4rcgU7HdTLnLxIjoSXT6Vdi8erj4SyIRsydehuEYdjo8mssp6VeTTPnGCI
 aUK7/l0bd+IPX2dHzjzA1cdmMAAo2G/Jp1oPuaxzlR0xBzny/x+na8akub5vWP1KYk+L257VFwK
 w1WC4KBJylzDuj2FziuLC6Kvf3HkEkz/PDVV+7jXJwXVtpDMEeAQ24UFdZ6ZQh9P7b9egRux3Lx
 BgV9iRwFbwMwDK9jYVjgSVLumG9kxSj2JhhqdWBq3x7NxD3o+4MjdLLKdi7oj3GHEw8FF2l0iG5
 UxSvnti//gh9MSnzaHvwTx9TwEkwPI/zmuP7Zb3DE91Lu2kLegsWQAbtX4t7tPUjZeKMF0jYtUY
 oWueNeX8ZVsbpmQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the structures nvme_class, nvme_subsys_class and
nvme_ns_chr_class to be declared at build time placing them into read-only
memory, instead of having to be dynamically allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/nvme/host/core.c | 53 +++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 60537c9224bf..fdddf2b17519 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -114,12 +114,21 @@ static DEFINE_MUTEX(nvme_subsystems_lock);
 
 static DEFINE_IDA(nvme_instance_ida);
 static dev_t nvme_ctrl_base_chr_devt;
-static struct class *nvme_class;
-static struct class *nvme_subsys_class;
+static int nvme_class_uevent(const struct device *dev, struct kobj_uevent_env *env);
+static const struct class nvme_class = {
+	.name = "nvme",
+	.dev_uevent = nvme_class_uevent,
+};
+
+static const struct class nvme_subsys_class = {
+	.name = "nvme-subsystem",
+};
 
 static DEFINE_IDA(nvme_ns_chr_minor_ida);
 static dev_t nvme_ns_chr_devt;
-static struct class *nvme_ns_chr_class;
+static const struct class nvme_ns_chr_class = {
+	.name = "nvme-generic",
+};
 
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
@@ -2873,7 +2882,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	subsys->awupf = le16_to_cpu(id->awupf);
 	nvme_mpath_default_iopolicy(subsys);
 
-	subsys->dev.class = nvme_subsys_class;
+	subsys->dev.class = &nvme_subsys_class;
 	subsys->dev.release = nvme_release_subsystem;
 	subsys->dev.groups = nvme_subsys_attrs_groups;
 	dev_set_name(&subsys->dev, "nvme-subsys%d", ctrl->instance);
@@ -3416,7 +3425,7 @@ int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
 	if (minor < 0)
 		return minor;
 	cdev_device->devt = MKDEV(MAJOR(nvme_ns_chr_devt), minor);
-	cdev_device->class = nvme_ns_chr_class;
+	cdev_device->class = &nvme_ns_chr_class;
 	cdev_device->release = nvme_cdev_rel;
 	device_initialize(cdev_device);
 	cdev_init(cdev, fops);
@@ -4609,7 +4618,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->device = &ctrl->ctrl_device;
 	ctrl->device->devt = MKDEV(MAJOR(nvme_ctrl_base_chr_devt),
 			ctrl->instance);
-	ctrl->device->class = nvme_class;
+	ctrl->device->class = &nvme_class;
 	ctrl->device->parent = ctrl->dev;
 	if (ops->dev_attr_groups)
 		ctrl->device->groups = ops->dev_attr_groups;
@@ -4842,42 +4851,36 @@ static int __init nvme_core_init(void)
 	if (result < 0)
 		goto destroy_delete_wq;
 
-	nvme_class = class_create("nvme");
-	if (IS_ERR(nvme_class)) {
-		result = PTR_ERR(nvme_class);
+	result = class_register(&nvme_class);
+	if (result)
 		goto unregister_chrdev;
-	}
-	nvme_class->dev_uevent = nvme_class_uevent;
 
-	nvme_subsys_class = class_create("nvme-subsystem");
-	if (IS_ERR(nvme_subsys_class)) {
-		result = PTR_ERR(nvme_subsys_class);
+	result = class_register(&nvme_subsys_class);
+	if (result)
 		goto destroy_class;
-	}
 
 	result = alloc_chrdev_region(&nvme_ns_chr_devt, 0, NVME_MINORS,
 				     "nvme-generic");
 	if (result < 0)
 		goto destroy_subsys_class;
 
-	nvme_ns_chr_class = class_create("nvme-generic");
-	if (IS_ERR(nvme_ns_chr_class)) {
-		result = PTR_ERR(nvme_ns_chr_class);
+	result = class_register(&nvme_ns_chr_class);
+	if (result)
 		goto unregister_generic_ns;
-	}
+
 	result = nvme_init_auth();
 	if (result)
 		goto destroy_ns_chr;
 	return 0;
 
 destroy_ns_chr:
-	class_destroy(nvme_ns_chr_class);
+	class_unregister(&nvme_ns_chr_class);
 unregister_generic_ns:
 	unregister_chrdev_region(nvme_ns_chr_devt, NVME_MINORS);
 destroy_subsys_class:
-	class_destroy(nvme_subsys_class);
+	class_unregister(&nvme_subsys_class);
 destroy_class:
-	class_destroy(nvme_class);
+	class_unregister(&nvme_class);
 unregister_chrdev:
 	unregister_chrdev_region(nvme_ctrl_base_chr_devt, NVME_MINORS);
 destroy_delete_wq:
@@ -4893,9 +4896,9 @@ static int __init nvme_core_init(void)
 static void __exit nvme_core_exit(void)
 {
 	nvme_exit_auth();
-	class_destroy(nvme_ns_chr_class);
-	class_destroy(nvme_subsys_class);
-	class_destroy(nvme_class);
+	class_unregister(&nvme_ns_chr_class);
+	class_unregister(&nvme_subsys_class);
+	class_unregister(&nvme_class);
 	unregister_chrdev_region(nvme_ns_chr_devt, NVME_MINORS);
 	unregister_chrdev_region(nvme_ctrl_base_chr_devt, NVME_MINORS);
 	destroy_workqueue(nvme_delete_wq);

-- 
2.43.0


