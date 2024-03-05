Return-Path: <linux-kernel+bounces-92288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43082871DF5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6658E1C2396D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4346B5917F;
	Tue,  5 Mar 2024 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="j+XUpSrH"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E386658208;
	Tue,  5 Mar 2024 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638462; cv=none; b=pWfLScEgCDMyQs+bXBHcggrLfOI7aiQFeg3kJxDytlk6nIXlHu6aJIYnMPfMToezcK5dDKEE1jxBTGfYEzEKjIgSBbGB5ZRnHQKuBAFPRvv+pG8r3T9p/9tSvuTiHhxL7+HdqqrXTzRnkQ7UMa7kVBpzPiekrSmo5lZkDhsL1gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638462; c=relaxed/simple;
	bh=fpv0oJ9U8YagK74xk5eqtVNJ2I3xbky4omeorhNvWEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hpZSy+yBOybvfKeE5VYxlVFz+qsiVm/mr4svigvylmrtUqSQTrI7lczcg9U1i4Fcmkh9R8CTuPtBVuz0tNoZdUOIvIaVHGCBNZ+uSL7cE9oLl4vlhRvyF4/XCAEgpZrTCIOIeVumFqV2C4xGL4KgOYImdEahdQoFDGElZC++j98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=j+XUpSrH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so45200445ad.2;
        Tue, 05 Mar 2024 03:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709638460; x=1710243260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3HzkmhvWMwRuDdScv54hkeI0UvbzZ4pHSJ+FrUGu5/I=;
        b=peLeijvVdl6wWkYVlrOwdiwymZT3z/A2rFZZtJuNsJKEr+Drc2HuNqScNeIQuHaV+u
         p7TnVCK4eLE/r+gP6y+YKY20bF0X5LNymAz0SJtZlhAoBwyd8gOtM2TZPmrNPnzcmy2A
         ETaTekwzgCMtQq8eWIT+4IDK5dnvC5uyn+QFZnrWy6wEfRcZDHx2yuC9k9OoJAkAjk2M
         BKadKxGq0oAZWnFlkdSOhK+y6UrTdiC7pqBrwol28LoAtrKhRvHSwUfeyD9V5tV4JkhS
         M2s+XxzAUNukkXfvESmcLwML+CRSsiF8lD++6W/DXeAPRiScL49JYrPGlvGijF4uVCsW
         DThQ==
X-Forwarded-Encrypted: i=1; AJvYcCW63xHag4zR93zhQjRZQ6PXccpXTIBzxH2e2a4lJO/m3mFNVEAV3WNXT7GsEJTKjmzQJn0I+zZBAxzUu7v/Zmpx3GFhN3N4wZzGOHV/TPISRA7vcdfvBcu2ZmsjiuRr4kL2Mt8w8AtxVTmZT6wptldkLEm9BLDINekU06p82OAz+JkhoDO9LA==
X-Gm-Message-State: AOJu0YxdQG3rzgSkwU9KJQYCm/exmOOyFe9hr9+6QccdNiXvufI14sE9
	Zym6q8OPHtwufAQhQk0kNAaOlkn8btPQI1kRqOscX8n4pMGHJ/Wq
X-Google-Smtp-Source: AGHT+IFTiJmUTFwl87q23IyWlhXuRr/fIfELN2hh99XRxtIMrOfTtlc6yGT90DD2gClkwJviU8MCGg==
X-Received: by 2002:a17:902:db02:b0:1dc:d642:aace with SMTP id m2-20020a170902db0200b001dcd642aacemr1934203plx.0.1709638460079;
        Tue, 05 Mar 2024 03:34:20 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id cp6-20020a170902e78600b001dd2bacf30asm1282755plb.162.2024.03.05.03.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:34:19 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709638458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HzkmhvWMwRuDdScv54hkeI0UvbzZ4pHSJ+FrUGu5/I=;
	b=j+XUpSrHky5wTzgY91/qYAlt/Eobb6xpsXkETAUNAQflazQog3Z6gM6eUjxsWP8+1OAJBQ
	IsjiefgwoZlPnvuY6tOMteS5pwkYa8iDU2t17+vP53hdXq+B7wIOneAI01IM+Ds+S4SmFv
	VHJf+VLOHCi0NNDTXhgWWH/MqFYSQqpDjlfXq9zJTIxhEDJDqzfxKmpt/Dr5W3MeKv7pE4
	DrvXMCHlo2D5BQRBGzEPZeoghyOO814TNr1MS9ICV/TPQ+uJ0zDgqSJWo5rWPWYO8Tjsps
	rYWVkmZ/7+mH3jIRvUKfvWDW/plNg9wTTRaUXnrR1YmW8F16DGRN0pJa5m5e8g==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 08:34:10 -0300
Subject: [PATCH RESEND drm-misc 1/4] drm/dp: make drm_dp_aux_dev_class
 constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-drm-v1-1-94f82740525a@marliere.net>
References: <20240305-class_cleanup-drm-v1-0-94f82740525a@marliere.net>
In-Reply-To: <20240305-class_cleanup-drm-v1-0-94f82740525a@marliere.net>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Hans de Goede <hdegoede@redhat.com>, Helge Deller <deller@gmx.de>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3018; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=fpv0oJ9U8YagK74xk5eqtVNJ2I3xbky4omeorhNvWEo=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5wMzRRiMg907Bhn7rGA+MECc/mrwVvpNKldbH
 JB1VeLskzOJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecDMwAKCRDJC4p8Y4ZY
 pvlXEACsfpJwMPU4ihjstqWt7WjHRrjk7T0s+v0WofI6JMO+xEgKiY5q5QAnL47p/YiWh5TpNVL
 5X81jJXReN2sLxXFZL+9KZlM+M0dtzAlliyUOJu6qb53BIRZS0GNSc+tw+1P5DDkThI5VlrytgI
 PPk50hgRgYSrbKWXsANpT0N8+olqGjfwNbwvB4Hkc4XJWTEzBXunz/l1WDZs4GzB+KR88AX0GzR
 NXhcKcAfe4tyX8ybwg3F3L05PlMl9vPagrqBFKLs4Ua4KSvuBzopWwpAn2gZl3l8FBEKRactEmw
 nGVsSTHxVJCRPyXGEBxC8wNGhE2HjO5xfaFbF0hhjrKSmXk8oiUBKpqLNzL7QxdfyJaTEbb2ZVO
 pZvDn3a6XYSxCeBF48Nt8jR4XFyH9mFzL1mOfeAZPgFC4wodaKA+euH/UQj90y0PP8zWrjUETP/
 uni7JvVAoxo+Ppj4AiZOrWjq6DQz2PFO9CqX3M2wf24J9t17riKXXLNa9wIC98MDwN0MzeYps6b
 Xsfsn+uwgsCyHQam83Thn4la2EqGal2ca30xKhZiIvT5lS8g5BND/2Mru5Y3YLxyXUb/JmMO02Z
 d5LbGtzG+cO0C7dck6HxhKLZhW3gWEmKdlxDoLc9yG9gpdWxuWGalOdXN5G3e49cLtSz+vIdQBG
 3AAPTLiufPZHqMw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the drm_dp_aux_dev_class structure to be declared at build
time placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/gpu/drm/display/drm_dp_aux_dev.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_aux_dev.c b/drivers/gpu/drm/display/drm_dp_aux_dev.c
index 29555b9f03c8..213abde5b09f 100644
--- a/drivers/gpu/drm/display/drm_dp_aux_dev.c
+++ b/drivers/gpu/drm/display/drm_dp_aux_dev.c
@@ -54,7 +54,6 @@ struct drm_dp_aux_dev {
 #define AUX_MAX_OFFSET	(1 << 20)
 static DEFINE_IDR(aux_idr);
 static DEFINE_MUTEX(aux_idr_mutex);
-static struct class *drm_dp_aux_dev_class;
 static int drm_dev_major = -1;
 
 static struct drm_dp_aux_dev *drm_dp_aux_dev_get_by_minor(unsigned index)
@@ -125,6 +124,11 @@ static struct attribute *drm_dp_aux_attrs[] = {
 };
 ATTRIBUTE_GROUPS(drm_dp_aux);
 
+static const struct class drm_dp_aux_dev_class = {
+	.name = "drm_dp_aux_dev",
+	.dev_groups = drm_dp_aux_groups,
+};
+
 static int auxdev_open(struct inode *inode, struct file *file)
 {
 	unsigned int minor = iminor(inode);
@@ -293,7 +297,7 @@ void drm_dp_aux_unregister_devnode(struct drm_dp_aux *aux)
 
 	minor = aux_dev->index;
 	if (aux_dev->dev)
-		device_destroy(drm_dp_aux_dev_class,
+		device_destroy(&drm_dp_aux_dev_class,
 			       MKDEV(drm_dev_major, minor));
 
 	DRM_DEBUG("drm_dp_aux_dev: aux [%s] unregistering\n", aux->name);
@@ -309,7 +313,7 @@ int drm_dp_aux_register_devnode(struct drm_dp_aux *aux)
 	if (IS_ERR(aux_dev))
 		return PTR_ERR(aux_dev);
 
-	aux_dev->dev = device_create(drm_dp_aux_dev_class, aux->dev,
+	aux_dev->dev = device_create(&drm_dp_aux_dev_class, aux->dev,
 				     MKDEV(drm_dev_major, aux_dev->index), NULL,
 				     "drm_dp_aux%d", aux_dev->index);
 	if (IS_ERR(aux_dev->dev)) {
@@ -330,11 +334,9 @@ int drm_dp_aux_dev_init(void)
 {
 	int res;
 
-	drm_dp_aux_dev_class = class_create("drm_dp_aux_dev");
-	if (IS_ERR(drm_dp_aux_dev_class)) {
-		return PTR_ERR(drm_dp_aux_dev_class);
-	}
-	drm_dp_aux_dev_class->dev_groups = drm_dp_aux_groups;
+	res = class_register(&drm_dp_aux_dev_class);
+	if (res)
+		return res;
 
 	res = register_chrdev(0, "aux", &auxdev_fops);
 	if (res < 0)
@@ -343,12 +345,12 @@ int drm_dp_aux_dev_init(void)
 
 	return 0;
 out:
-	class_destroy(drm_dp_aux_dev_class);
+	class_unregister(&drm_dp_aux_dev_class);
 	return res;
 }
 
 void drm_dp_aux_dev_exit(void)
 {
 	unregister_chrdev(drm_dev_major, "aux");
-	class_destroy(drm_dp_aux_dev_class);
+	class_unregister(&drm_dp_aux_dev_class);
 }

-- 
2.43.0


