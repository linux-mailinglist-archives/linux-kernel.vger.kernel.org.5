Return-Path: <linux-kernel+bounces-106546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D69B87F027
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE1E2818D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D098856756;
	Mon, 18 Mar 2024 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewmbfIfD"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AC756742
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710788792; cv=none; b=WZPpYNCERCd5s+uzWaoc6RgBNB11JAxS84BUUUarIWFWj0v8FbAdUonBYS3DDMB3vDGVICmqc4EUx9mcERqk66L7SZ6IsaPS47Jlyr+3ZH54KsmGq1VJOsieyK6cj0Q+G7AI9rVPOS80b8CQFjj+zWe7a1n1jZrUKzemvXOYzsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710788792; c=relaxed/simple;
	bh=NEx2g4n6ufqCzilttVyJiiBJGnoeUzvPlQCp0qHeo88=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UbS57H+OX+syuQ1nSpgwjZSpaT8GXqiBoVL2gZKYY/amoiMl+CZ/tr4ZoIPw7gU5086KWsYE9ZAcZO//Aes2diayXOnVWEQlvw0jjqF9YS0PGaT4JAldU96v5vXfZBPhlb+fZSTU6hw9OgXiSo5aUtA8zwRHto9RHZZ+MSKzfyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewmbfIfD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dd9568fc51so36860865ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710788790; x=1711393590; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3t/6qBY8GxMhzpyZRZVOzzJ2aUCI4p/xA2HtoPwjz48=;
        b=ewmbfIfDQWRcNIZsrfFPmsIxKyMG+NyIHyAmEA4UWMt/zEKQ4dcb/pmAIiSnew4fKL
         MBpWswLEGgNkdY6nogZN1mnDcAwVSsHACUHR+7LrXZ1ALCfB2QGluXZk9spkjq49zmtw
         oQqEupfBHHh901prFCgR7+lYgFAXvjwoIj2pNWkqK9RBwtS0WmBqWPly2KT4eJXBDCEt
         4HloyBPc44mxHsEtSIMh5+T0LEXiPSyxIaRXEHyoOqbWCfWkXe85JbuvqlJNtCHoTuaA
         jZahg1ff6ZXnPOFH1cVjPoW+/3m2KfoKe2/NIwQNdLd0fzj7XdX9+NhE73tR3g+pckpx
         nv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710788790; x=1711393590;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3t/6qBY8GxMhzpyZRZVOzzJ2aUCI4p/xA2HtoPwjz48=;
        b=fOAw+ZxdilwMhMaYc3yamUNjdQj6+UdWXgtfkpdghPiLBjX+7H3dxoWt5IfMx7DknI
         Ysf1pUG0SYc7chT+LMDVYDhFFzSjoMaCSM019HkIA/DNm1ZoJNIbX2i1Y9eNIICWWZ8z
         FcqqDTGuNjXXxdo7SDrF0NJzmFW4q/5pKfvdzusglZutnbJl4GdamSuIl/Ek8ez5cwFA
         POGWYQv760EHs8dxeBwEaXI3vt/CVh5qYa3IsIft9Z2dhYxm7oH3HnR634tU6Fbzuvwj
         VkVQNUZjWLXXvanrcVHa0fRP6Yc6pWthYh7O9gEqswgSQykRlMHiEBf2+yh0+baschGm
         1MTw==
X-Forwarded-Encrypted: i=1; AJvYcCWG3rVwGohoL+XWumdhgUo/9/TXCl47rkJWmtbkG02maG0e/uQ8TjKgN2QQgOTXxbxKpyQezhDqgxAf0Rpi5x66NH8WOzjxEcDRfUwD
X-Gm-Message-State: AOJu0YykQ868AB9OkPcZ8l3XT8HUYBBRB0R0e3txA6SPaGLywWq8+2N5
	bjghG/xo/Tg8urgo2zdJXS9AQh2460WHWCHy//mJbwQ+Z283JQRPntGFcXuOU5o=
X-Google-Smtp-Source: AGHT+IHNcRSrETZMOBGBIJjxlTUKxhM+HgSfC4f7xoyv8I+epdayrvnayaKoLUuqEnsrvYN/c5dUzg==
X-Received: by 2002:a17:902:bcc4:b0:1dd:9da3:59ff with SMTP id o4-20020a170902bcc400b001dd9da359ffmr559461pls.42.1710788789789;
        Mon, 18 Mar 2024 12:06:29 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.68])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902c40a00b001defa97c6basm6416769plk.235.2024.03.18.12.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 12:06:28 -0700 (PDT)
Date: Tue, 19 Mar 2024 00:36:25 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v6] staging: greybus: Constify gb_audio_module_type
Message-ID: <ZfiQsZBrHfImIJfc@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Constify static struct kobj_type gb_audio_module_type to prevent
modification of data shared across many instances and to address the
checkpatch warning that "gb_audio_module_type" should be const. The
"gb_audio_module_type" struct is only used in one place:
err = kobject_init_and_add(&m->kobj, &gb_audio_module_type, NULL, ...
so checkpatch is correct that it can be made const.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>

---
Changes in v6: refined commit message as per suggestions

Changes in v5: added more details as per feedback.

Changes in v4: added more details verifying the change.

Changes in v3: added the message that verifies the change,
as suggested by Julia

Changes in v2: incorporated changes in commit message
as suggested by Alison
---
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


