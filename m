Return-Path: <linux-kernel+bounces-112407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 543C2887965
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F9028235A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7264DA13;
	Sat, 23 Mar 2024 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3B0B22M"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FFE1E497;
	Sat, 23 Mar 2024 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711211421; cv=none; b=L26HX2Sb0x1Fy5xNL4bb/cC4LcE+/ZNgQ75PlFenQv8A33Og86sxjgdUG878NfetyFvmolRskq8G+xYvSJvJP5I/quF/0YwWiw0tj5gE3+DdCVKhuCtF+iK7z2BAS80Mm/NELbDY8oRnzIBB+IqTQNFofpZVjeMqTWRM19ccwEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711211421; c=relaxed/simple;
	bh=hYR21Vffkaz1yzdbwEsh41c3XSN5q8lBLdIhHpY99Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6bb3Y3uLq+QXcvYa1waLl3ij2BVv+PCMhT9fNxlPl2l+ofqsCvGLDUObu/ywYSbfeCA55LSPbdgDArA9L54qXpGoUBedhy0lF0NQ1qheOXuhhrnbeuCiXw/vmR4TeH5TyBQkZDRv1EFaT517PgeUOCtbEtpjxwBPoxf7fLAEQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3B0B22M; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29dee60302fso2858015a91.1;
        Sat, 23 Mar 2024 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711211419; x=1711816219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+gNAzOlZksAWrrk/Sn0MY4Ibq+h1gY4sUBMqWqGyMMg=;
        b=h3B0B22MKAAStbt5KEzPSDTej4qTFmgTkX5eE5cN+UfF3Fc8lZoom0gdHLc9Xvx9OJ
         U/Fj6tYKo/7+cBPcI+0Wk/HLIvxfSsP4auDzZ4kYManLO337zin4sYLdIr/sL0fLx0wM
         MBvL9raWnvygmKpkmWmrwnCcFIJX7GFR6hSTWoL2cAv1JWt/EDXdEDwY/TVCNcFmtlJE
         x190+iSbhobgBKqghCO2A5tRExi4sYyXYxU8gM+Hzip4rdjsRWICbGgzPHMjnEo3j4Mz
         RknehuzVA1Dg0YwS8ocWSp6bAFWO2ZvWQLT+tZG+ZMH/16+rRPMcP5ssSqfIBCRSwbE9
         r9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711211419; x=1711816219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+gNAzOlZksAWrrk/Sn0MY4Ibq+h1gY4sUBMqWqGyMMg=;
        b=PDwgriNj1/K/a6iX6bbKsGduwg3/QFwtVVdQFtLsbYsGFoQRVCgo0VD1Ik0mEtDAH1
         /RTFRRDj3CIOA38jY3FUUn9wmraeUPYJAPe2GTD4pfjsFnRpX7OSpp9Ft+x56olH9hBJ
         KSm1Z2QSbWcHGvHEXqokf7wVKZEE3tXJoDntnxLCkZH6ZR29RTouwh+G4sqkY7sWATI4
         lptX20RC8UvfJvFUrelkD4KT7/4Bd9+IA3/X3QCtUZlXZq+jtUtH4MxQuXvbbdeSqxnl
         1Vki0R6bVYcCZTdMDJ9TMWIQzJ42Nw4xaxcKFaXfOiLh8v+ZTqZbGW3rLUtt3WsVqlxN
         RdjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR2Yi8kLeTDIr89JnCpmlJGpwAq2T3HGPMHk9e1X9vuxfirk7D5I+R2eQboTZ2NSuSCshagYPABrjwUtK53XyVpgI4vjFto2jFNhtszuiISTyEZvLozUFX7kf35rcLUtEtqgw7t0ul
X-Gm-Message-State: AOJu0YzLJou7WijIbYD5vYhdFIFaeNWottoZCOU3HWxosEe1b0qPLjBV
	JSzS9k8AIadrTM7mzV3epHbRG+4+mFey7CbvODcDOU97PtuHmUsi
X-Google-Smtp-Source: AGHT+IHY/kpeHfsUu5DENuSNIPbMTQ4vvhND/e4pVt6OYw2ZnQmNlXiz2hcdANGxYrwIMKN9d4YuxA==
X-Received: by 2002:a17:90a:778c:b0:29b:fb23:863e with SMTP id v12-20020a17090a778c00b0029bfb23863emr3009742pjk.17.1711211419567;
        Sat, 23 Mar 2024 09:30:19 -0700 (PDT)
Received: from amogh-desk-mint.Dlink ([119.82.122.244])
        by smtp.gmail.com with ESMTPSA id si14-20020a17090b528e00b002a05c42476csm322228pjb.10.2024.03.23.09.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 09:30:19 -0700 (PDT)
From: Amogh Cheluvaraj <amogh.linux.kernel.dev@gmail.com>
To: airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	corbet@lwn.net,
	javier.carrasco.cruz@gmail.com,
	skhan@linuxfoundation.org
Cc: Amogh Cheluvaraj <amogh.linux.kernel.dev@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix duplicate C declaration warnings
Date: Sat, 23 Mar 2024 22:00:09 +0530
Message-ID: <20240323163012.23263-1-amogh.linux.kernel.dev@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix duplicate C declaration warnings at
Documentation/gpu/drm-kms.rst that was found by
compiling htmldocs

/home/amogh/Linux_Kernel_Workspace/linux-next/Documentation/gpu/drm-
kms:360: ./drivers/gpu/drm/drm_fourcc.c:344: WARNING: Duplicate C
declaration, also defined at gpu/drm-kms:39.
Declaration is '.. c:function:: const struct drm_format_info *
drm_format_info (u32 format)'.
/home/amogh/Linux_Kernel_Workspace/linux-next/Documentation/gpu/drm-
kms:461: ./drivers/gpu/drm/drm_modeset_lock.c:392: WARNING: Duplicate C
declaration, also defined at gpu/drm-kms:49.
Declaration is '.. c:function:: int drm_modeset_lock (struct
drm_modeset_lock *lock, struct drm_modeset_acquire_ctx *ctx)'.

Signed-off-by: Amogh Cheluvaraj <amogh.linux.kernel.dev@gmail.com>
---

changes in v2
- add warnings found after compilation
- fix grammar in commit description

---
 Documentation/gpu/drm-kms.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
index 13d3627d8bc0..a4145f391e43 100644
--- a/Documentation/gpu/drm-kms.rst
+++ b/Documentation/gpu/drm-kms.rst
@@ -357,9 +357,6 @@ Format Functions Reference
 .. kernel-doc:: include/drm/drm_fourcc.h
    :internal:
 
-.. kernel-doc:: drivers/gpu/drm/drm_fourcc.c
-   :export:
-
 .. _kms_dumb_buffer_objects:
 
 Dumb Buffer Objects
@@ -458,9 +455,6 @@ KMS Locking
 .. kernel-doc:: include/drm/drm_modeset_lock.h
    :internal:
 
-.. kernel-doc:: drivers/gpu/drm/drm_modeset_lock.c
-   :export:
-
 KMS Properties
 ==============
 
-- 
2.44.0


