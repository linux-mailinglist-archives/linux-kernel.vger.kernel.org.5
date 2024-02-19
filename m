Return-Path: <linux-kernel+bounces-71269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDD385A2B8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08421F2264E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03B136138;
	Mon, 19 Feb 2024 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="qkL+tNUb"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800CB36114
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344016; cv=none; b=XaiANXnin11ETq76dzvNuTV6wbfrQh8DdtpJzbvCekkR4KvRaatonysIZHZfMtAVkzx7sSwxPy1u2Lj8K0vtbX6LaBr20bsyNhH51hrEoYhp7fBWVdZ5WrPG5E070ChRJR8vxeCsoyPfxm2+W9UcOpoVKWaYjOXFw/1ofe/CRnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344016; c=relaxed/simple;
	bh=cGE1aXmbUEcCZqNxBm1s72ykW3IRXfETFVI2UY/p55s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YQnTThsUlYuGbIV5fVqmUKdgKpGGKLpibormLy/GoleZk++l1haq2IpLbw+TSdV8BwQIwgJiC1iCqV5OfxnKFKqgcn2d/lnHH4RoOxyhOKKJ1o840S/aIuGp8m6rnj3PgFX3T0cj0mjyUcoA++V0uQW/1G6q58qrEWQF0bEL+Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=qkL+tNUb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1db562438e0so32780135ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:00:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708344014; x=1708948814;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=haRjgjClnBjya1hn/kXkmNJwZcsnCLiTNm2A48TJj2I=;
        b=r15wbzV6fN+L+51OlGuvkk0vihGXLTfyeJedyr9hDjg+mcG03Mva2k9NsJsQBmfCbB
         aTPe0oXQKtBRhJR7yexlKy8xtpqDQ7rbDhtE4BBqbfolJ+mTbcguVHbEBXrfb0lk8oQk
         SmwFcDAdGvE7OLgkTig5qTbVzYz3I9On0Y1JXIPJ1YAQ5rz+QETcUGj6oRteBRVfBvss
         d35X7ES6/bhd95ljGtmAje9dqFL9+E8ZsrwsJUBZHqqZxsPsIN9Xg9VjaO1VnHdr1V2r
         FJtiEQi7TFYcuyCk5lvvXa8Zz5Hicz/o6uvmJzJX5JjGoqyaICPZE8FBx3shcYsbHTbJ
         zD0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHgTVFQ6ScN2X/S5HnHGVsnlKmtD8FLogip+fmmLisjpfKiyvwlwog8fRRVi5rlpSIZyeRJVbY4RYJS/8qolstFsH/TK2v/wxYGZkM
X-Gm-Message-State: AOJu0Yx1G+58QyhKKy2lhw+EdJE8iYoTL+pLE4j1JsS0C+2tpCONiQbP
	DlwoSwgBjgReqf1Zon7j6Y0sBy/RW9I2Hf8OVhaHoaYi4EDwA3w6
X-Google-Smtp-Source: AGHT+IHpP8ZQkzVZGA724rm5IY8BShrmDVlMjxj4PtnkrX0AYah52rqOinVekUWURDe4fWZAw0c/rw==
X-Received: by 2002:a17:902:ec8b:b0:1dc:11f:d954 with SMTP id x11-20020a170902ec8b00b001dc011fd954mr1174732plg.54.1708344013304;
        Mon, 19 Feb 2024 04:00:13 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id f19-20020a170902e99300b001d944b3c5f1sm4230209plb.178.2024.02.19.04.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:00:12 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708344011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=haRjgjClnBjya1hn/kXkmNJwZcsnCLiTNm2A48TJj2I=;
	b=qkL+tNUbSQysejjyPo2IADm5Uiy+7XE4eRkam3bEIrzBgumLuTqCcm1vFxwf97IyXyNVIq
	pdYaw1jk/+XQ1oHe4bc7ltuRr/8pVZTGWUwlS45C2f/cj3FYdTp63h/+Fi67Q+HnOKCCxy
	7hbaSNgdQ161QNQZT98Z8gRRHqZ3F+vwjD4xytxUjJMu9m9VLZ+reIfKzaxACIrtlKSpfs
	Z7mJNFT70whvSrEPJXjgpUGgCV0HSxwXOBj86TVuW9s1bjB2aOhcgevj9FjVFo18vnHev6
	EFJq06G2xHWr7dsgFCSKq09ZDIdpWPm8sTJWJCKTTAwtYiwAIotimvW/oxXasg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 09:00:51 -0300
Subject: [PATCH drm-misc 1/3] drm/dp: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-drm-v1-1-e2f2acb38bff@marliere.net>
References: <20240219-device_cleanup-drm-v1-0-e2f2acb38bff@marliere.net>
In-Reply-To: <20240219-device_cleanup-drm-v1-0-e2f2acb38bff@marliere.net>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=cGE1aXmbUEcCZqNxBm1s72ykW3IRXfETFVI2UY/p55s=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl00L1k052ApVj3eKMw9G3Ku1/NjhsrLFY6W6ht
 ItWIhyt15eJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdNC9QAKCRDJC4p8Y4ZY
 pudYEACsGPi2u6bKrs3VW9TMpjmsDX2fTJjiVoC4jM994qt17r42Irs2YKFXYtzzrzELtZjybWK
 TRkRQgDJAkHnJONZAbwx6mRRIeRWu4ydtuJ8k5NqhQ5MjA5o/dSXBSOEQ3lmU9iIqPdlf9QBwCg
 dSxUGUZFbLpF+S1jXcaP46DIhVXSOIUHcS4rgs17JFNoL1GAV6jbpFEbfWJZktvfW41nGcvi1/c
 BRCdrXyDukn91tKrjiRs57l+yPzXSM4vNroIHaKD17CHaL0OvisXpZZAwX5TeEr6QX7wekyi7Kk
 cmUyqrDs67x7CQsMcLYAsaGKKSHDobFZ5DE1mZLv/P3ng08ImSb7INKQDPRF+Nz9AAITjHMoTrM
 p0SbvF9zA1WK55B04H3PIhN4D+LAS4eZgkDj8as2dRSEabTmtRAvf9y5VKwu5A6MzLpqW8SpCN0
 zMuKaxhtB+QDYPchjs0D2cMFjAxQhIlKQEFVmKgfsQjpWRx4hPJKRt1E+5fGwx0K3q0evKLInXR
 8IxskXFN7ogFQBHI8Ee1yIViObkacXdjFIVlULXU3LYbmKgCv0ZV2TUIFxiuuC8Y49eCyXcJzlD
 gZzGhkLTK6wpCAsrgroBrQrfDfmAW0YNmOecqU8iaAgIhTKTZEhhvOAKzK07FTn3ZA5o7Nf6Yl0
 ehjiK5gLQebjTKQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
dp_aux_device_type_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/gpu/drm/display/drm_dp_aux_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c b/drivers/gpu/drm/display/drm_dp_aux_bus.c
index 5afc26be9d2a..f4c66937ef79 100644
--- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
+++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
@@ -166,7 +166,7 @@ static int dp_aux_ep_dev_modalias(const struct device *dev, struct kobj_uevent_e
 	return of_device_uevent_modalias(dev, env);
 }
 
-static struct device_type dp_aux_device_type_type = {
+static const struct device_type dp_aux_device_type_type = {
 	.groups		= dp_aux_ep_dev_groups,
 	.uevent		= dp_aux_ep_dev_modalias,
 	.release	= dp_aux_ep_dev_release,

-- 
2.43.0


