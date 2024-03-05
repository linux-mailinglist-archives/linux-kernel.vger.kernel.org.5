Return-Path: <linux-kernel+bounces-92355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AF9871F02
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2E2BB22AB1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AF95B20A;
	Tue,  5 Mar 2024 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="FT7/iUAn"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9A5A4FE;
	Tue,  5 Mar 2024 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641287; cv=none; b=Lmv3sinIR822i2PoLV0P/C5S7nWmdB7n0YfnWl/DLu1od2hbXjChPsFvFxdzx6VVjYpVVxqQw1acDM/sWFncBYtBH1xyhCMVAdeQeJv1p47+KMFKrUlps1QnUrkUjLK77D1b0B5NLOubUuPIVSyJjyxpPCF4YY5ds8LdUQW5wmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641287; c=relaxed/simple;
	bh=wPqgO6x1c97ZMRaqAAcxuPo7qKZW50BhJ1TgJiyowRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gY7nkkOnP10367vgmZ71IgUIXkHl964YZZ/uLqGv/N8vOrUgtGrXy/ilX4tQWy0Yqv4tRy+DmY3dqQT9B8QKUcGxwVr4RI+STZ7AdmsYM8rUoo/GYQFjxKtHqyRn/JidF/lJrC5GvcDnSBNBariMyONZwldvdoSFHaMIsvP2UXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=FT7/iUAn; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e64647af39so97039b3a.1;
        Tue, 05 Mar 2024 04:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709641286; x=1710246086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EB+zvigNjipJqZrGtyuvHVekbcDWdJOO5TYIKi4KvqM=;
        b=gM/HDK196LGhxs2MyN1G29qnGXRclN/ZGLqqFpn3zA8J/dZn5ndMhR3JFCxiZw6ljm
         xM5BxR7QYzDIjzmByCLWMoPq23iYoKHspJf4NilcTAAaPb13jjG42dQIEqhAIgy4nlXQ
         BunqZ0OKPd6ajxVqs6BNXhx8DFk7wVQqIM8E8oW/NpkxhlY3X2zI6yiocPU2QNfWstQv
         NiqGf8rr7WvGSDHuiwc/4csixnzo6HhY7BHsv+/839ofTAYFkxdxPXsK+QBZ27NQ22FO
         xLh0OPxkcAKrINZn90KI3Y7genn9XDgiSo5i858uRACJwmsBqcu3HBM3kg/IpPFiWyP2
         BsAw==
X-Forwarded-Encrypted: i=1; AJvYcCVdpMBUIDN+tSQ02x7UIMDzRKHs/0f7qt+EBKqaDlnHeCu77BUN+q99zpps7ZcVGyirTdRaxEpnmpt04vq9y4L6HK5bWhwCRo7XU7sXwUPa0ogkixF9UBNfSa480BRhdb3XK6fv3KU8eH0=
X-Gm-Message-State: AOJu0YyM5JKLqH4KOLie+T2ODxrCmz0s1bkGTlRfA3c8I4GVeQBYhaXS
	bQrFSmzGeCHGJeJFtOevYUnyDszb0nbcABx3SI+aSsNmuU0g0YJb
X-Google-Smtp-Source: AGHT+IEsx2oyGpXbYX5zFlR9y9i1MJGRXxMf1XwxwrBx6v8x/fHt2MRSi5W1e5+ZtQQm1dIQybLYIA==
X-Received: by 2002:aa7:88c5:0:b0:6e4:f4b4:9ea2 with SMTP id k5-20020aa788c5000000b006e4f4b49ea2mr16673906pff.32.1709641285659;
        Tue, 05 Mar 2024 04:21:25 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id du6-20020a056a002b4600b006e5933a0da9sm8833564pfb.165.2024.03.05.04.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 04:21:25 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709641284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EB+zvigNjipJqZrGtyuvHVekbcDWdJOO5TYIKi4KvqM=;
	b=FT7/iUAnqYSX1LAYGofJsvMLqVcEZ5Vp+GZkvigG5oabTdXc+QhEgU2Vz2W7ukhClIFg6M
	hnagd15E1pJ75mZMc2US/FdDKhZREZOKezgQICrnczAMcy6Pjv5eOW7fD5kF5bOfAMrEnA
	Hd1wMF9gDMUOnrLkQNp9naj0pVxRjjPbRB4wRl+Q6Sg3+Z6LXNns13JVMxeDLXGIGqGY2b
	mXqZc8zGvJ7J2v7jMgSKadHWXRYZri+AoJKDS24Py1YrvE8HSxLKuXXBth6QHQ8LqWZvo4
	p2v4rRP+RIk4hpGUnDkA93rU7AIxr7m2kWW075vKTTzIHj16NBDAJT4Q0y7Kag==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 09:21:17 -0300
Subject: [PATCH 1/2] video: backlight: make backlight_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-backlight-v1-1-c0e15cc25be1@marliere.net>
References: <20240305-class_cleanup-backlight-v1-0-c0e15cc25be1@marliere.net>
In-Reply-To: <20240305-class_cleanup-backlight-v1-0-c0e15cc25be1@marliere.net>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Ricardo B. Marliere" <ricardo@marliere.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3316; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=wPqgO6x1c97ZMRaqAAcxuPo7qKZW50BhJ1TgJiyowRg=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5w49fb2fHi43ZPpQ2hgetHTWppuTBPoASWbre
 ej/ze4OJJaJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecOPQAKCRDJC4p8Y4ZY
 psSXD/9N3DmlQ1MjAQcQFB7xpnrLJU/FzcyKQaoKqqJgaoAY6UJcBawC55DUL1mkUBMICTknNau
 KYRSOjxQG6RnO5VnKEZk8sCzO4MtM4ZO0pUG9whq3ga8adY/wTOIbWEYwu4PhSba20K3sPDk5lu
 /0mAzm02RUfz5BCOkoIzHYfFUp/KbEkT7In7xSQ97MifeVOHsWyfCXNSiVmW/Za/zM3vLufhL4R
 lYnAk/A/oZgmH2FcLHcby9FWNLlvpgp/lW/4xAJZ6/jKZXW76EC4wKCrrTOWrVWfliY0ZfnCCLq
 xlS3jxoM8kt2sm7yubV8BDM0R8PPXgIrNphespzfGNUxPA/f+pwSwVzCR870uMOzwb+LdgUZeL+
 hVt/O0/UUn7Da+oqvVqUeTVgvgrbpitdNKGHzxXNabcQ283dVbymV9VFNxvtL7UGDEhAryj8m48
 T4Vi95NdTluJNgsMzznNP4ncWNKu7UmIKhcs0ZiuFOKEADWJQ8sZd/UVYvu/XwalFp4/hZYA7uP
 ljzVoFuGyZnsXoIYBb1RFzSl473QMvQZU/pbDJolgn6SZyrnEJ7jFMVWc9/12CaWnlDUscbS+cR
 SP46VN9s2gs2oEYqWQoh6VEpm0lsI5VcoOTpl3ZyrChv9LGl5t+7Zq5RP/0S4SOxbPuJa2RhQ0N
 y1mxM9Oy9FBAhGg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the backlight_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/video/backlight/backlight.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 86e1cdc8e369..d2feaebfd84a 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -317,8 +317,6 @@ static ssize_t scale_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(scale);
 
-static struct class *backlight_class;
-
 #ifdef CONFIG_PM_SLEEP
 static int backlight_suspend(struct device *dev)
 {
@@ -369,6 +367,12 @@ static struct attribute *bl_device_attrs[] = {
 };
 ATTRIBUTE_GROUPS(bl_device);
 
+static const struct class backlight_class = {
+	.name = "backlight",
+	.dev_groups = bl_device_groups,
+	.pm = &backlight_class_dev_pm_ops,
+};
+
 /**
  * backlight_force_update - tell the backlight subsystem that hardware state
  *   has changed
@@ -418,7 +422,7 @@ struct backlight_device *backlight_device_register(const char *name,
 	mutex_init(&new_bd->update_lock);
 	mutex_init(&new_bd->ops_lock);
 
-	new_bd->dev.class = backlight_class;
+	new_bd->dev.class = &backlight_class;
 	new_bd->dev.parent = parent;
 	new_bd->dev.release = bl_device_release;
 	dev_set_name(&new_bd->dev, "%s", name);
@@ -510,7 +514,7 @@ struct backlight_device *backlight_device_get_by_name(const char *name)
 {
 	struct device *dev;
 
-	dev = class_find_device_by_name(backlight_class, name);
+	dev = class_find_device_by_name(&backlight_class, name);
 
 	return dev ? to_backlight_device(dev) : NULL;
 }
@@ -678,7 +682,7 @@ struct backlight_device *of_find_backlight_by_node(struct device_node *node)
 {
 	struct device *dev;
 
-	dev = class_find_device(backlight_class, NULL, node, of_parent_match);
+	dev = class_find_device(&backlight_class, NULL, node, of_parent_match);
 
 	return dev ? to_backlight_device(dev) : NULL;
 }
@@ -746,20 +750,19 @@ EXPORT_SYMBOL(devm_of_find_backlight);
 
 static void __exit backlight_class_exit(void)
 {
-	class_destroy(backlight_class);
+	class_unregister(&backlight_class);
 }
 
 static int __init backlight_class_init(void)
 {
-	backlight_class = class_create("backlight");
-	if (IS_ERR(backlight_class)) {
-		pr_warn("Unable to create backlight class; errno = %ld\n",
-			PTR_ERR(backlight_class));
-		return PTR_ERR(backlight_class);
+	int ret;
+
+	ret = class_register(&backlight_class);
+	if (ret) {
+		pr_warn("Unable to create backlight class; errno = %d\n", ret);
+		return ret;
 	}
 
-	backlight_class->dev_groups = bl_device_groups;
-	backlight_class->pm = &backlight_class_dev_pm_ops;
 	INIT_LIST_HEAD(&backlight_dev_list);
 	mutex_init(&backlight_dev_list_mutex);
 	BLOCKING_INIT_NOTIFIER_HEAD(&backlight_notifier);

-- 
2.43.0


