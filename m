Return-Path: <linux-kernel+bounces-51099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DFC848671
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F2D1F22B88
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726CA5D912;
	Sat,  3 Feb 2024 13:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDYf9dso"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557725D904
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706965654; cv=none; b=f6ehesi7evAfvrbYuLVKfjnLuxN380F0NZU6Sfcz5gBxS8aJOBI6yVo/QZxsOqXZReQ1Umeo/ZzjMl5m1auRMNgZ2p2PBUUy78oaorYFcq+4x6qHAzM1Dzk0eIOgH00RIt/s12pto3yROHLXkSk/ERIragvXHxV6praheGLtJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706965654; c=relaxed/simple;
	bh=MNorqcheca3qSqKF2uY5r/B3fNXw7byVmQRVNnFgubQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EaQ1EsrM/79OEXGPX9FZGGn5z7+P69SkFjzNGZ5I2pueSLhReBlkIVxJ84yFqy49QKHPu3LBxxt/BQysphHkobWb/0o2wzPeEVjJ6KDz9XdTF5nBSRV5ebpHnMVRWNxPJt8T+3tQmnzX0U3iHkwsAaBNHrVsuwOSOmi6ZNjj320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDYf9dso; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-290fb65531eso2223356a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 05:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706965652; x=1707570452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y+JrlPIuSE8yozR+GhrPVSUGhg1SjxElkVKDTnKOx20=;
        b=gDYf9dsoNIi69OwBsoXvpXpdL+ev5wp998rZ71ZuFaSa+LsgNTwVuREZnRwcObR9B9
         7gVFARv3WTh48IYeMRCv4nEFRuf2Op3YNC4yswTWanZwKuh9rdOv2wmP9T2GiZlmXv/c
         w1NOUKi8UqbbmprIc+A0+poetdkxj0yS0qbp9M0WIY2gOx0mitWvuN4q/uxH72Q88kPW
         rutFUMKlnLCZrz71mYvkUNvq5Wk81B5s0fGpgtjqIbfJ2SmZilJoI0l9mn/C0mjtqieG
         ZHxs0IKaz6G1CnUmVMFLxbTko5Vr/3Ol4R+xI0j0XVDuYS1LpOUmKfrbYOHOBp32BwbC
         Q5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706965652; x=1707570452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+JrlPIuSE8yozR+GhrPVSUGhg1SjxElkVKDTnKOx20=;
        b=sX6ZqWDyJO+HgEqjrRUw5lqkg/dx/5PvBwp/IQILoPfUtV4Tlkpo6Dm29kVqYUHfw/
         5eju6smx9eIa8A/6VBmirp9MGHJpE6L+9x46yG/dOUl/bf/qHVu/Mng9AU1AI+suxT9H
         MDER2Lx+abV1MwEvh0D3ra9tSGjdjmgPlbSz7lnOhMcaFPPRHEq3Us2v24r3WEUd1/Mz
         O0DDXT3/VCL36RkqTDPC5kwmujGQ4Eu/vXsL53Hpord7vUh8gFm4MFD4dmuoEfqKB61Y
         vzCvHJbqCX67NjK3vcwqAHNzISKJ9iIOsNFOwMlfd+3HQ/XK5CqqEKIj4yolznOVzk0p
         j2Aw==
X-Gm-Message-State: AOJu0YyLN/Kx/4JKX7GhyRF9mETIvNbJnk+QHwZcp9gVVf4NNXCI7CR1
	yhzUifYqtwbdmvLN6x7fPnRAStz58S1m8vbPgpZ7NzUxKYp0sK3K
X-Google-Smtp-Source: AGHT+IEylMPsDlrVCFsSiEAjV/Co51g3W9EQE7MKXyaGWIf6YkYRSVswlXt5iEb4J5XHmc1kAGTQcg==
X-Received: by 2002:a17:90a:7c06:b0:296:1943:35a1 with SMTP id v6-20020a17090a7c0600b00296194335a1mr6497683pjf.35.1706965652538;
        Sat, 03 Feb 2024 05:07:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUPXO0n5NhZyjb/0v7BsREUUf7j6U6ubGD4pYArzaa77z8OR6Zw+8miZ+Jkr/p0cb+iDsmVCUnmKkkUYNor5dJGkYjEK3v+DJY4
Received: from localhost.localdomain ([122.161.75.254])
        by smtp.gmail.com with ESMTPSA id o20-20020a17090aac1400b002961a98c181sm1737940pjq.56.2024.02.03.05.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 05:07:31 -0800 (PST)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Abhinav Jain <jain.abhinav177@gmail.com>
Subject: [PATCH] Task: Extra credit : LKMP Bug Fixing 2024 Spring : Documentation
Date: Sat,  3 Feb 2024 13:07:25 +0000
Message-Id: <20240203130725.14802-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added a prototype for dget() to fix the warning

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 include/linux/dcache.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 3da2f0545d5d..b082b48e7eb5 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -301,7 +301,7 @@ extern char *dentry_path(const struct dentry *, char *, int);
 /* Allocation counts.. */
 
 /**
- *	dget, dget_dlock -	get a reference to a dentry
+ *	dget_dlock -	get a reference to a dentry
  *	@dentry: dentry to get a reference to
  *
  *	Given a dentry or %NULL pointer increment the reference count
@@ -315,6 +315,13 @@ static inline struct dentry *dget_dlock(struct dentry *dentry)
 	return dentry;
 }
 
+/**
+ *	dget -	get a reference to a dentry
+ *	@dentry: dentry to get a reference to
+ *
+ *	Given a dentry or %NULL pointer increment the reference count
+ *	unconditionally and return it.
+ */
 static inline struct dentry *dget(struct dentry *dentry)
 {
 	if (dentry)
-- 
2.25.1


