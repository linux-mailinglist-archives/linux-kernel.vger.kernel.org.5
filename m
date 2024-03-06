Return-Path: <linux-kernel+bounces-93284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084EE872D7C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1ACB1F25FEA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B782E134B0;
	Wed,  6 Mar 2024 03:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UffxNdOv"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEFADDD8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 03:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709695467; cv=none; b=GHS24PK169zbbJ9VcBD9dZWMKKQlNAcGjHfRaHqJQSiygOC9WWUhQ+Atr8RJ57qjkC4ktLiJlkZFF0PA+pF0EIZ3dhZM0iVRhljCNDOiCndURHmrcns4AedFFqkILrt6ucfxKxEDxD6VeyWfDs498/wUwm7V8x0HXz81PwaCUys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709695467; c=relaxed/simple;
	bh=sIgPaakpq0RIE9FvimFLTIqfrslPhHT5y01/qMF8fYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ya90cutpTC8pGqGU2y3YCeQB8XwxoOU0z+P00dMFnhnaT3WwSBxV+/kstML/EWce7THteK20y8ESyFH+Wy7R/dOL+6Yr6w7LUqwk7YQfeY1Z6KZng82oBFQKMsFm6E5DLVMtCLYFGDosaoU1yh1ZLtuXkcosOA+eSGtPaUle/fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UffxNdOv; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-21ffac15528so2560518fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 19:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709695464; x=1710300264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YY8pprhlY2hfjI+DczSHGBDtQSXX8a4KHHRyaWkDhB0=;
        b=UffxNdOvbtq6S5AoQ9bXRBK5PSsQyTa4rzBEBOPaPtI3mv5s+BrvQKMyPu6c+oTu18
         Gwg2IlCYAURediDsqwTC+0nxU7J9qLKXyo25lBnff090vHHiWVAYA+CFzGDmZF52fUQB
         GAFpzeXUsMR9Zi9YRMWnyhO7buKMIZXOr5oP6fYfjUhsLowazrM4sOxuJEuaBNWfMCQP
         Y2/OP1EwPOCQSHiFPXTd0uiWl9SKJ4ZeowJLVf0w2OwSuwj8Ug0fuU6hDu8aD3xmZ2XH
         l+8SbxMX1RlWQ/xpuCpy84CLiKrOeNEque7exXDoUN1DXSyQ3a4hLsTLkKKtUTU+v+Yj
         HkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709695464; x=1710300264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YY8pprhlY2hfjI+DczSHGBDtQSXX8a4KHHRyaWkDhB0=;
        b=VG5eXtijTNdNGpLjgd90DS/z0x+gO9MG8NgWajA6bxc2qciJv6+rq4dHo3Xkx+s36F
         Pzad5uENzE/67X9KtTnFsCqpoPw4J0YGLz/ZATRD6prGHxJwQHvEU6c6RDzJbPwSFHZL
         Fh5hIMJqO/4/EefTErPwFpxlybsToiPsL09RYt0QMvtcn9BE4DN1fUJPpP0jypMNtaH7
         J08GHigzUS3lgiHPHlJJjredEirGTlXCju5jsewDKCWuVvZ6LBC7g6OnFrSPWGzGSBnw
         iL+PXV5YL+osSDzNZFdeo0ylmLEy4SUeMyiDnQGS18mVlZg/RMKwbCHFj/R+R7UIeCw0
         orlg==
X-Forwarded-Encrypted: i=1; AJvYcCWQUbFWjXSZEE893bjkMVXikv80Hwu2pawka7fJhMKwe2KfAX2IUzSUG4pbvLp3V4xBEcQ/4Bge2JblzY6eGT5jbQlx8U5z/E/BVlXt
X-Gm-Message-State: AOJu0YxJWIKB4xb00Vwz06lHdVbTDcHxePrlR4P9Jw2XsONcspG2nNT+
	WM1AuITB8tKiktUd56Iat6gkACQdnvq+Yj569eeiQAx0vHI7yGhp
X-Google-Smtp-Source: AGHT+IG/qPbUHBENxg8B/NMPAY+Iva1zLONMjiTm2XMFQUb8yAin0rmXFmVqAKQdmhrKgGpK008ing==
X-Received: by 2002:a05:6871:2218:b0:21e:e069:5852 with SMTP id sc24-20020a056871221800b0021ee0695852mr4336776oab.55.1709695464513;
        Tue, 05 Mar 2024 19:24:24 -0800 (PST)
Received: from kernel.. ([2402:e280:214c:86:d881:224e:f9c2:b24a])
        by smtp.gmail.com with ESMTPSA id s18-20020a056a0008d200b006e5af565b1dsm1824624pfu.201.2024.03.05.19.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 19:24:24 -0800 (PST)
From: R SUNDAR <prosunofficial@gmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	rdunlap@infradead.org,
	mario.limonciello@amd.com,
	mwen@igalia.com,
	swarupkotikalapudi@gmail.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	R SUNDAR <prosunofficial@gmail.com>
Subject: [PATCH] Removed redundant @ symbol to fix kernel-doc warnings in -next repo
Date: Wed,  6 Mar 2024 08:54:14 +0530
Message-Id: <20240306032414.18488-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For linux-next repository.

/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h:1: warning: no structured comments found
/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:132: warning: Incorrect use of kernel-doc format:          * @@overlap_only: Whether overlapping of different planes is allowed.
/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:132: warning: Incorrect use of kernel-doc format:          * @@overlap_only: Whether overlapping of different planes is allowed.
/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:1: warning: no structured comments found
/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:132: warning: Incorrect use of kernel-doc format:          * @@overlap_only: Whether overlapping of different planes is allowed.
/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:162: warning: Function parameter or struct member 'pre_multiplied_alpha' not described in 'mpcc_blnd_cfg'

Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index ba9b942ce09f..34a398f23fc6 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -110,9 +110,8 @@ struct mpcc_blnd_cfg {
 	 */
 	enum mpcc_alpha_blend_mode alpha_mode;
 
-	/***
-	 * @@pre_multiplied_alpha:
-	 *
+	/**
+	 * @pre_multiplied_alpha:
 	 * Whether pixel color values were pre-multiplied by the alpha channel
 	 * (MPCC_ALPHA_MULTIPLIED_MODE).
 	 */
@@ -129,7 +128,7 @@ struct mpcc_blnd_cfg {
 	int global_alpha;
 
 	/**
-	 * @@overlap_only: Whether overlapping of different planes is allowed.
+	 * @overlap_only: Whether overlapping of different planes is allowed.
 	 */
 	bool overlap_only;
 
-- 
2.34.1


