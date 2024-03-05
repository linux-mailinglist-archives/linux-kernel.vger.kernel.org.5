Return-Path: <linux-kernel+bounces-92433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8367872018
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14B10B2624A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EE486633;
	Tue,  5 Mar 2024 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="G1N++5mh"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74078614C;
	Tue,  5 Mar 2024 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645201; cv=none; b=JAOi7Mi02KmZkRhLCAljbJktyCxJXUyCJaBZZJei9o9mbuC7GExx3N3OzOvXMA9CofZh1UhZc4ET2x8+pQSEtwcNC+Q5/RiCzfReUajfNohanRTxh14u5WcL8dTfi0Q6DvXEOZ+pl7obdO00bCULX0sHr7jASIPld36O6/5utkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645201; c=relaxed/simple;
	bh=HK8LB9QJ8mSrtcVi7IoyDMwKj+da6n0YpnV8wKpMhXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rmbfnKvagZsDGz5Ln5zOc0pojLQR5zfkFteZryWf0VlpDWRmFIpUeGI46/V0C/tcTeUtHFfzoe0DYIme7d20n7W1JRncSdOEFI8xyeO5WoFGAcFE3Is7sChqbAGbThR3NFjtCB7UQV78f9xo5RXjA6CxgtGh4ouBK7ITnZgcrt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=G1N++5mh; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6da202aa138so4123721b3a.2;
        Tue, 05 Mar 2024 05:26:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709645199; x=1710249999;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NLV8P6DpyW79g9n98lCR51WBPdxINm+PK1VfaCZgZ2g=;
        b=XgoI/Ks/e0p72ULGkvOVXfyg/nXKxCwZvV0vJr4KOgCTPdPPkJeXj2TOlxbh/YYota
         2ZOUnrDCIzOwQSRLAaJwo6ZK792uyGXKkNt8IyvUg8rZdXDhB/+0jG8U/B+Km1uJrlN9
         C699zTFM2tKqwcFiH2Nok+Bz/rIIqHHCXvDbp87oLJk7AtgjJFaDgyhip4QJbQ68JvgN
         pQ0jiww5MvWJTBNckD3buDd+ZQvGH0OfiXHIzW6PNhtyGW3Jkrmsnbx4TM1xOHczXitO
         CgIbSvViG3DIOuitfdGOKEcAjTkFtDfVIjvVMSEuXEexPF13cYF7lOOlpxSzuZ/TJQNw
         RYEg==
X-Forwarded-Encrypted: i=1; AJvYcCWOcSUj2XbWdhQiXKY2QwNz0N8By6zKjQ8AKiUMiU7Cmtu0QQIz4XKFZYTXXdXDFp636bP6lpySWWGEMaA6wmpGTAo9Vk8w22L+EfMH4zmfO7cEc2BCjlifvoCRLLlipI7S7+sgpqs/e3c=
X-Gm-Message-State: AOJu0YzT/PpMTU457DvDlxyuK1+pL8ehnDGc/xpr/KfJK4f7aR7xxWP0
	vqqa0AIqOh3dcsG9WQbzCuWLO6tH7ov1KmKL7pA01mCsPVjEZOCi
X-Google-Smtp-Source: AGHT+IFMVpTxgwa8CWp274EVMmUymPxeYlUf2+35ENxL0u93SgGhGRKmJsEn4FIzu4unopQee4RzPw==
X-Received: by 2002:a17:902:7207:b0:1dd:2e6:b951 with SMTP id ba7-20020a170902720700b001dd02e6b951mr2146082plb.12.1709645198955;
        Tue, 05 Mar 2024 05:26:38 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id d3-20020a170903230300b001db7d3276fbsm10484676plh.27.2024.03.05.05.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:26:38 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709645197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLV8P6DpyW79g9n98lCR51WBPdxINm+PK1VfaCZgZ2g=;
	b=G1N++5mhhxHD5t4eqVq2sn2lSXRo3vRFFF3YjDxmR/Ejdf2cyDZWtFrQRx1tOG+G8at9ne
	WKKE3rvVuDMpgfmEIfbx8tKPAMQNoDR7q8MMdKJ/Ua5m0ThM9IECKAcce/zTywuhYYiy/T
	oYsaXttHS5s82TKwgZZB+pYa4R6EVYc4GGmc5Ra+py6YdPi5rkLbvHUnk0dxoEd0TiSewD
	nNKzqwHGCDyGfl4DzG/L6Z7NKhqi9QJIdXGsOOp9s9xzkRq+CWlIODbU1U5PePaek97shi
	ZKk0IG4CaYdbekf+d8UWvWef+dJvNUbdEZw2qiiiCWzkioViOVjdQX12ba1cuQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 10:26:26 -0300
Subject: [PATCH 2/2] media: lirc_dev: make lirc_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-media-v1-2-53e1538973cd@marliere.net>
References: <20240305-class_cleanup-media-v1-0-53e1538973cd@marliere.net>
In-Reply-To: <20240305-class_cleanup-media-v1-0-53e1538973cd@marliere.net>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Sean Young <sean@mess.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2204; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=HK8LB9QJ8mSrtcVi7IoyDMwKj+da6n0YpnV8wKpMhXQ=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5x2DJX8Y0mYNbTp+faeCBlcb7d9roIChNlCh9
 LkYYIZLZvqJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecdgwAKCRDJC4p8Y4ZY
 plFgD/4oPVXKHJWVhySynp0jUQEQnj/OM8VBhehaR2rav2ZlVXJgq9LPa76TH7aSN/gtsx3hK5q
 EfzgetwBnQLXff9sbUPxwT5Hr1dKMTzrWrGRzqqFWXl/NKj+N4LkNZCjCnYASMnAY8UWM3YZl05
 rXp5qeUs4dwfAGHduSEZYQ9jick2lfKUhbQ3n+uurL2StCPUgokbTdBm1sipl5mY1ru55YNvxod
 0HNcitEWbBe6B6H1/MyOeDhaUoSM/MjLeKr3Gl8Hlfsxsx3KFdXfAaKZX09HPormfDXBZ7lBlJ0
 rvsIvCJlKMCtu4pslwu4rq4tPhV258wwZw+Q01NS8/CRmbhbZZIu5bhpUCP8Sso86BswX+Wal42
 udgSd6gQWbi8HBbeZOeOrw46aJM9WGxGRV2Jkpo2GcGIbnz57Ty7cw1RsryWiuBjfnxXHhgxe+k
 CNIZnJFYlwXz9xQYshjHS9EuWFOEwbZ5frTTWYHFmKA9A1MRPyoWU7enKw5/CVAFLvR3pAnaCBC
 +6l4NgLOqJH/r573KrzzpcjqAYnq3k9lACSrhsmAuhjvbhd+YaU8dBGHvIu4J2djI/3KMlZMpdN
 /UCPZ4NFEaVs/5wK/5IdtxDtxTJ7WBYJ+5XkCANY7Ok7TrjSctSYeZWvmPwq1gcrMEzznzeciyC
 b6lhBjjqEQB/3mw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the lirc_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/media/rc/lirc_dev.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index a537734832c5..89551f28e99d 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -27,7 +27,9 @@ static dev_t lirc_base_dev;
 static DEFINE_IDA(lirc_ida);
 
 /* Only used for sysfs but defined to void otherwise */
-static struct class *lirc_class;
+static const struct class lirc_class = {
+	.name = "lirc",
+};
 
 /**
  * lirc_raw_event() - Send raw IR data to lirc to be relayed to userspace
@@ -724,7 +726,7 @@ int lirc_register(struct rc_dev *dev)
 		return minor;
 
 	device_initialize(&dev->lirc_dev);
-	dev->lirc_dev.class = lirc_class;
+	dev->lirc_dev.class = &lirc_class;
 	dev->lirc_dev.parent = &dev->dev;
 	dev->lirc_dev.release = lirc_release_device;
 	dev->lirc_dev.devt = MKDEV(MAJOR(lirc_base_dev), minor);
@@ -789,15 +791,13 @@ int __init lirc_dev_init(void)
 {
 	int retval;
 
-	lirc_class = class_create("lirc");
-	if (IS_ERR(lirc_class)) {
-		pr_err("class_create failed\n");
-		return PTR_ERR(lirc_class);
-	}
+	retval = class_register(&lirc_class);
+	if (retval)
+		return retval;
 
 	retval = alloc_chrdev_region(&lirc_base_dev, 0, RC_DEV_MAX, "lirc");
 	if (retval) {
-		class_destroy(lirc_class);
+		class_unregister(&lirc_class);
 		pr_err("alloc_chrdev_region failed\n");
 		return retval;
 	}
@@ -810,7 +810,7 @@ int __init lirc_dev_init(void)
 
 void __exit lirc_dev_exit(void)
 {
-	class_destroy(lirc_class);
+	class_unregister(&lirc_class);
 	unregister_chrdev_region(lirc_base_dev, RC_DEV_MAX);
 }
 

-- 
2.43.0


