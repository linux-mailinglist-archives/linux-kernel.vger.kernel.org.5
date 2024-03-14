Return-Path: <linux-kernel+bounces-102892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4818D87B814
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3781F21381
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D396E6107;
	Thu, 14 Mar 2024 06:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHTDBnzG"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FB110E5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710399169; cv=none; b=mOT03QnVeOHzU6/WkXkqPI4MPLWPBpIUbe38O3snQ2bzHn2iK26rZzlFTCWUMyMLGmD8UdQcF73YW9uK/oLsSb0uw9nmslVVhlfqYNv5jCcZzeVNesxH73WBzL/b5WNnvwWQMyjQkmWvOzlWTcrYeBwaH/9tE+YJCKG6scCrl4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710399169; c=relaxed/simple;
	bh=T0GxMwBwmySlOVbSj7gx2Xa77TGbUn8GftiSzlBmKtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sslN19qd5d2nWr0upHIIZKEjMzFe7rCfc3sSqMxCjbdnC25nQEaqf8kudKiF4jY3utTnRKE4pm3j9DtAQmgQZzwC++3kg0b+DBuDY9qXwtn7mkUlVGWrbW0gEqqSnyqVCbBTo814tgcXQ00zSFjH9J7EO2/zeqGUgVt9mvrSfZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHTDBnzG; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29bd0669781so545734a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710399167; x=1711003967; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3LwgfnVSRb6bo5n7xp3n3DJcNJBHsfZFGHFZZEWHyXg=;
        b=fHTDBnzG3bjOPQlMgjt2fSQpxDfonctCRn3WmFl303+pBYrDHscFzWZ8gyYSaZM9gK
         cWHgYTtLWGxCk2ehLhYBCWNMb0NigMfbQT0kbrOmFfGx3DdaogPwiraKHJghYqHEYk2n
         i3u584od8DezSi2A+UwEchIwJ3X5TYbEJcJDzKzkpM3W5l9wPTgTzGLCWS3DEn9NHSH4
         yJdqBF3qtzQhgzFczQXutLr8KrAFYHY5LKHPBOuXe4+5O0ySHN7Gcem1mp6LUI/pt2Ge
         r/D7MvjulAxzBM2FgbjxfHALsXSDO3GFcj25XkkY96TGCT0WH/hqa8YH+GlShULgjxFS
         M4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710399167; x=1711003967;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LwgfnVSRb6bo5n7xp3n3DJcNJBHsfZFGHFZZEWHyXg=;
        b=Fw0dR8wVU5Nt/C+MRJ1fhV3YhljIs3l1I/uBwMdmbzPOEefB6HYMpGkOMuXf2K5Zcc
         VElJz3mVXSddWKJYT8nAA3tVYhIXNcKCGkqWj1wnu+c3Wzi1/SeGlHDkw9pkWYrE6437
         xF23IqSOOvdHE4w3Xidpy9PxF3eIoRAyXYvT8BjhNfjPDOmqV6zQQboZk3k+WmuvSIf1
         rKWQZuTyMbT4XlGKcV7tZo3LRyl7XhTMERgMb6kziBz1HDC64L/vENg1rnVIwY0ypuId
         NLDpoE1UkgTgSkoEmEqetsuAkY3WW5jXxEnwFmlK8uc1kvKVjtK0P5Pv3rSlGLhGIhIM
         ymVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn703SyJYWHWp+IhCbXl4usAU+2QF1oYRsGNJep92nr4nok61Iba9dsSYMcBfpHdC24hFJIaYx4thMCjnH/UjpiZDejjdPcLNhZTPw
X-Gm-Message-State: AOJu0Yy5jnkswmDCnqz01zRYsaDI7aOGY0mo2IzQrmXWlcysgAWA9UqL
	4V8x/rwKySheXz0C6gtWX3vJLTKy3DNwPXCnqANZrRmNc/7oYVBr
X-Google-Smtp-Source: AGHT+IF1yL1y9JAi64OSd93uOJ530JOSBG3XsJb9SJ1Lq9etWeAeWmllsYTSaHKMWopChno69w23/w==
X-Received: by 2002:a17:90a:ab12:b0:29b:95a:baaa with SMTP id m18-20020a17090aab1200b0029b095abaaamr750755pjq.47.1710399166989;
        Wed, 13 Mar 2024 23:52:46 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.66])
        by smtp.gmail.com with ESMTPSA id ns5-20020a17090b250500b0029dd92da150sm85107pjb.19.2024.03.13.23.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 23:52:46 -0700 (PDT)
Date: Thu, 14 Mar 2024 12:22:44 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v2] staging: greybus: Constify static struct kobj_type
 gb_audio_module_type
Message-ID: <ZfKevNRRNteRXZHT@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Constify static struct kobj_type gb_audio_module_type to prevent
modification of data shared across many instances, ensuring that the
structure's usage is consistent and predictable throughout the driver
and allows the compiler to place it in read-only memory.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---

Changes in v2: incorporated changes in commit message as suggested by
Alison

 drivers/staging/greybus/audio_manager_module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/audio_manager_module.c b/drivers/staging/greybus/audio_manager_module.c
index 5f9dcbdbc191..4a4dfb42f50f 100644
--- a/drivers/staging/greybus/audio_manager_module.c
+++ b/drivers/staging/greybus/audio_manager_module.c
@@ -144,7 +144,7 @@ static struct attribute *gb_audio_module_default_attrs[] = {
 };
 ATTRIBUTE_GROUPS(gb_audio_module_default);
 
-static struct kobj_type gb_audio_module_type = {
+static const struct kobj_type gb_audio_module_type = {
 	.sysfs_ops = &gb_audio_module_sysfs_ops,
 	.release = gb_audio_module_release,
 	.default_groups = gb_audio_module_default_groups,
-- 
2.40.1


