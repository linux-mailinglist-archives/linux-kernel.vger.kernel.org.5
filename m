Return-Path: <linux-kernel+bounces-92343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F246D871ED4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86AE72878A4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31135A0FA;
	Tue,  5 Mar 2024 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="BGTAePN3"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507575BAD9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640924; cv=none; b=GDcfwujN3WuQ/cCc3Jfn4sI2BGsp6QypiyKdxV13nRDYMZYdjxv6Xc1VrVbtwvqxD+v+HVs+Hxjnt0sIqt7K4N/oLOGe0bjwGMXJGYamhFs9SDgsdhYKr4pdBZ6MMXVg64wDqswhTnvUbFiN3EidS+O4BPo/AlGyjyHCRRN/fvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640924; c=relaxed/simple;
	bh=kW6ySO9UjKoPkDNKLl904Eg7AGlGAj8q4urpp8bhL+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Xk8y+70qhxK1QH8CodXVHADKwif9mje/sOHItdkX2ZodBr+94sRUN1wiOxDiD3w1Rvdo3Rcz5+o4UM+jDCh2hGUaK1WVnWCOY+dQvwt3FEoG1NkApN4KosfppbeYXYoG9tzsMEB86gkgz8DMW07n5fmgottmA3MXhyq59q+WabM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=BGTAePN3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dd2dca2007so3624195ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 04:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709640921; x=1710245721;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVie1ubg1vO+1LPda2Bilx+ZCICOse/T4HjTbJik150=;
        b=uTNv2A0A54TYNZxay9Aj6ZzooZKi0av5ww5+vZo/bwUXiKNpy6WmqPnZb94MRU6Mao
         6xFpp1liz3uYijQqrZO1WlUeaWNXuvcWhC/m4FnwVCBqZoNJVJtPFSRj4EAhDhB29dfl
         a0X/GI3kJse3gQmYj1WwunNm3pIPVc07cPnW39gpng7C2RT8yJFPhAkHqW9c+VMeihIn
         0Wtjk+6VXIU37PmbdIHz5AUdlFvOouISxHBdtCQgud9GD/Erfsc7qTBjtKZaaE30EYry
         AkLZbDTmceiQ6jSXxQh1G70J33AJpiKuJ9oPZY4byczQSayzTp9+5WeGihh42k7PYLQo
         Jc7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdeXTkxIPj0htUVqfZx7dRSzcZnYh6PQkYxUwJyTfYcDgfFz7Ws1zTHnaWpkfw/blwy1owZODM07geL5paaLS83Y7nEYk8QOEWe4G2
X-Gm-Message-State: AOJu0Yy1/EvuN55MadixxGpblnXLMQawSVUc8lmznKNsWNzgNGu/u1R2
	/n/QcSxxFP9p+pTnY8a5+CJPv9y+hvY1u+ieV/ABgYyg1n1jrKuG+YGuN3EyMFChvA==
X-Google-Smtp-Source: AGHT+IGJOKhnhB8IG8kVYywr4PNMnLud3LPOcz2BGEvgb9t9EUw/+82Q9SP6kp1RrbEw8S9TIE5C6Q==
X-Received: by 2002:a17:902:a389:b0:1db:cfa0:4045 with SMTP id x9-20020a170902a38900b001dbcfa04045mr1648983pla.60.1709640921328;
        Tue, 05 Mar 2024 04:15:21 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id u14-20020a17090341ce00b001dd1096e365sm4182621ple.281.2024.03.05.04.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 04:15:20 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709640919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hVie1ubg1vO+1LPda2Bilx+ZCICOse/T4HjTbJik150=;
	b=BGTAePN3bozrIykaFwJ7dZRpAb3BkQUm8T27HtTgPzaCi4Jm5WG3/t8NFKNtGBKWMQo6vI
	VR8DZQz063RYjfaq0Dt0oivWnNRDf5chrbwk5oVXUjaiV2JkX7i3G6cqOAotaQlunulpgF
	IiiY8NOHzefaKVSSqwOw5SslHHaYVxLQs7hvb4nKIEEbmS5N67S8gFZLNEpZ/JhDYHAB+m
	esgBwae0rbuvwMvTGCM2i4vWOckYvswPONJiJ5nWyrhiRcAkCndD67y/jjvMX9a+qvEAmd
	YrGWD8FoqwuQPe2ETfmDvJb2TxgiLJlZ+4+kXpM7VLTK01nO7yLLbcK8rDBE4w==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 09:15:14 -0300
Subject: [PATCH] drm/amdkfd: make kfd_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-drm-amd-v1-1-ea99b37f26c7@marliere.net>
X-B4-Tracking: v=1; b=H4sIANEM52UC/x3M3QpAQBBA4VfRXJtay6a8iqT9GUyxtBMpeXeby
 +/inAeEEpNAVzyQ6GLhPWZUZQF+sXEm5JANWulG1cqgX63I6Fey8TwwpA3tFtAF32pjXGsaBbk
 9Ek18/99+eN8PW1ehI2cAAAA=
To: Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2580; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=kW6ySO9UjKoPkDNKLl904Eg7AGlGAj8q4urpp8bhL+A=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5wzUrYRyC7QPry2Qt/QVSUFHko1BN60HYq8im
 pKi9crZA16JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecM1AAKCRDJC4p8Y4ZY
 pojlD/4+yZ4Gt+Nxg1Sgg2TByTe24SdCm8LDHQY7YesXADry34SCqGMvqx/PEXvJylFH9kcgh/s
 NPZLOCmapuanwhUJXelV4CqSQS4An59xgPNJuFvmUa4iS4O8Chj3vgPGjtZFpIOsObdTxY0nYmI
 KkBMeUrNPYlVTFUFhnvXSFjSvrd552Un0aSb/IO2+ArAIF43bNQFgC0AeruTxuLRew+OEgYuMR0
 Flkq4sUbzc2i/GJID7KgIzhPM5ZcTPVmapA3B8JXvQAgPHOoazUPMBg0ruRZSwX5973Ul3rzvjl
 F2SkfJSzAvP7BFU3CDkPfXujvWr0U53VRqruHd9Rzr4mreStGDiTDK7kW9pikwU6SK4zG6NDknB
 EgfWQnhxm9wvZmmkQNGEpO7FsyXpKY3ZTj/S4XkflIR3zrnYdZafhiSiz+LwI34TwMMkIp8QD9g
 Zw6fZAgGNlfkTrQOzl+FAqzn4psKVPu3lv8yy1ipGmJbxP0Okwywi/OMk/SBYt8344Iwsz2Nwgp
 q1mM+J5h5/czFQqZmcws2MN7RiFoJH4ccKcD7BgSBAUsgqYbGd/ltg9Y38pcj9021m9/jDxCaQN
 c0/KZdhyOj3Fn/HzGgXONhT9xz3178ZH8jAvtC7uWcH5g7GW8n4QU3EqKyZTBqiehwrHjSGRgGk
 6cTcmFrf0f88Jxg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the kfd_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f030cafc5a0a..dfa8c69532d4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -63,8 +63,10 @@ static const struct file_operations kfd_fops = {
 };
 
 static int kfd_char_dev_major = -1;
-static struct class *kfd_class;
 struct device *kfd_device;
+static const struct class kfd_class = {
+	.name = kfd_dev_name,
+};
 
 static inline struct kfd_process_device *kfd_lock_pdd_by_id(struct kfd_process *p, __u32 gpu_id)
 {
@@ -94,14 +96,13 @@ int kfd_chardev_init(void)
 	if (err < 0)
 		goto err_register_chrdev;
 
-	kfd_class = class_create(kfd_dev_name);
-	err = PTR_ERR(kfd_class);
-	if (IS_ERR(kfd_class))
+	err = class_register(&kfd_class);
+	if (err)
 		goto err_class_create;
 
-	kfd_device = device_create(kfd_class, NULL,
-					MKDEV(kfd_char_dev_major, 0),
-					NULL, kfd_dev_name);
+	kfd_device = device_create(&kfd_class, NULL,
+				   MKDEV(kfd_char_dev_major, 0),
+				   NULL, kfd_dev_name);
 	err = PTR_ERR(kfd_device);
 	if (IS_ERR(kfd_device))
 		goto err_device_create;
@@ -109,7 +110,7 @@ int kfd_chardev_init(void)
 	return 0;
 
 err_device_create:
-	class_destroy(kfd_class);
+	class_unregister(&kfd_class);
 err_class_create:
 	unregister_chrdev(kfd_char_dev_major, kfd_dev_name);
 err_register_chrdev:
@@ -118,8 +119,8 @@ int kfd_chardev_init(void)
 
 void kfd_chardev_exit(void)
 {
-	device_destroy(kfd_class, MKDEV(kfd_char_dev_major, 0));
-	class_destroy(kfd_class);
+	device_destroy(&kfd_class, MKDEV(kfd_char_dev_major, 0));
+	class_unregister(&kfd_class);
 	unregister_chrdev(kfd_char_dev_major, kfd_dev_name);
 	kfd_device = NULL;
 }

---
base-commit: 8bc75586ea01f1c645063d3472c115ecab03e76c
change-id: 20240305-class_cleanup-drm-amd-bdc7255b7540

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


