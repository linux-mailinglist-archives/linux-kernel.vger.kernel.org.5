Return-Path: <linux-kernel+bounces-104434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E5D87CDB6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77CA1C212DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F41C25565;
	Fri, 15 Mar 2024 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJlxCRrv"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3055D28E3C;
	Fri, 15 Mar 2024 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508003; cv=none; b=XA406mTee6WbUlZtVsg0VMU6ggKNVFCIYpOyYKbR+m1BAMsQkaoE2/Lh3C5ivhAOa+XfHz1ZjxPdRnIrnyiI2L5iJPvuxVM7TZX2bxEBg9eFWXfm+DRM0hEoxMsJIYOprBB3GVCnSn44BMitrwn+Y/5pHnWbExW0kqux1oaUtmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508003; c=relaxed/simple;
	bh=pAuOxrGJjw+WcXIsvKFpQEfMzj7cwcNiaJNToVzH3Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ff1aOPQQ1o5iXzEWVTx1JgZ5vJkWQp+MPgtS8TwKBt0gvEKTZYmeZFhwqKNHZiLubUw4+KA1ZQvUlKcept8y3zTPH2QRStregBo0wO3ro06IfYOMsvDIRf3SbFfKe1N4/ZBbt/+xhTCFzaMJDr0UnQ29vYEWSXYl19OZRZBxpgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJlxCRrv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6cb0f782bso1688840b3a.1;
        Fri, 15 Mar 2024 06:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710508001; x=1711112801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1NY1O0ew0W7ggm7j9xxECvAoyGcWbE8/Wq9boK0lbYA=;
        b=YJlxCRrvFkfyT7x8p6puPuxjyYnxMSwF0Q+QSEQUGBXLwWH685RKzaG0zEkx+datJ4
         KP3rlmO2Zq8rZfKuMnkSf2Bj3QdyJ+9dMAwYA0w1PpSFZwtCdjsNsd/c/dkxQUXxeaEs
         un/O0QtIE5is8pe0vpry0WyCckrQn2xWs5juibbl6zvoUTN/SPKSmj7vEVohgTjiGd71
         Z4IL0WXEsAhvMCEyFajKrbM3ZXhNsBN8OqJ8aSMHyIB7wvsOhERVMBKzDtkP43md+jXU
         x4IsWNpd0dNvGthlvg0k2f8ulUO/KHHG1CxSzdfrYdzSM1PEQfIBKyYhIY17Tz1WWLTO
         O/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710508001; x=1711112801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NY1O0ew0W7ggm7j9xxECvAoyGcWbE8/Wq9boK0lbYA=;
        b=Ud+0P1J12KUK9z2xDpSfuXYXfdmvFH4oioZ+pgpw6x2R86Lun0uGujIEL85kBDRudU
         psPFVHq4USwzVq0c8DaADXrPauqzg2Mq1cJdrlRp9lJZ0WIe8AnuA8jBeJLkdyohZeWx
         jeFxKZ6Qc1/GttZnUxvamIp41ra60BEgpMxFXk3pKtU6mh0pz68o8p0HPoZS5NZAa9OC
         VLS1xjL/I5GfzCHopE2HDcgYOPuDhyjk0eHP4vaLAp8LK1FXGFZ1kCy3SxEOYEd0iedG
         MEqtmLX/nx/SrgP6HJRQdCDi64HSP3dVQvSzqb1THfInEgFAstEhL2r03sE+rW+C2JrZ
         uurA==
X-Forwarded-Encrypted: i=1; AJvYcCVb/oLPbQQ4JK+0T8odqucHGJa53gaVp7rsUdfgjlaNAQ0196vrTsYDcN/kYyiGQ0cVeuUQ6Lz4HAxzaX1NrwNWNaZ/IDmngatFFmkWUv1GJ+051PBceYkmws29BZMx1YH4LWZzCVxxclw=
X-Gm-Message-State: AOJu0YzOq+zcKqmtoHRDBnEjmnbVKxWFgyaUfSukfqguSncrrsK6Pojq
	x8i4JvQqf8vpO7a67dgavWGDHthxt+XM+DJlfz+MlwQd2ULtjY2U
X-Google-Smtp-Source: AGHT+IHp3wY7HaOB/AXDMYPVMVe0FLS60qkHQi/s9HluWJwdOEJAqeMHDfX/YkdOWLYIGINrsaasnw==
X-Received: by 2002:a05:6a20:959a:b0:1a3:18be:9b18 with SMTP id iu26-20020a056a20959a00b001a318be9b18mr5058987pzb.26.1710508001267;
        Fri, 15 Mar 2024 06:06:41 -0700 (PDT)
Received: from Ubuntu.. ([160.202.10.71])
        by smtp.googlemail.com with ESMTPSA id i3-20020a056a00004300b006e56e5c09absm3408220pfk.14.2024.03.15.06.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 06:06:40 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: outreachy@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [PATCH] staging: sm750fb: Replace comparisons with NULL and 0
Date: Fri, 15 Mar 2024 18:31:11 +0530
Message-ID: <20240315130400.11540-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace '(foo != NULL)' with '(foo)' and 'x != 0'
with 'x' to adhere to the coding standards.

Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 04c1b32a22c5..4537f007a810 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -926,7 +926,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 		goto NO_PARAM;
 	}
 
-	while ((opt = strsep(&src, ":")) != NULL && *opt != 0) {
+	while ((opt = strsep(&src, ":")) && *opt) {
 		dev_info(&sm750_dev->pdev->dev, "opt=%s\n", opt);
 		dev_info(&sm750_dev->pdev->dev, "src=%s\n", src);
 
@@ -1147,7 +1147,7 @@ static int __init lynxfb_setup(char *options)
 	 * strsep() updates @options to pointer after the first found token
 	 * it also returns the pointer ahead the token.
 	 */
-	while ((opt = strsep(&options, ":")) != NULL) {
+	while ((opt = strsep(&options, ":"))) {
 		/* options that mean for any lynx chips are configured here */
 		if (!strncmp(opt, "noaccel", strlen("noaccel"))) {
 			g_noaccel = 1;
-- 
2.43.2


