Return-Path: <linux-kernel+bounces-91580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 993CD8713E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E0F286959
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C17F28E02;
	Tue,  5 Mar 2024 02:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsK9c/pT"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ED02940B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 02:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606948; cv=none; b=jLsQ4CBuXRI4g8idkUayMAgihE3ooKqTf2XGqm47IJcFpfbLwMa69e65lYRmsoyr6xR2Bpg5E01FkK/cdEENx2uaiQduFNLUNpktGes9IHVQrw6ifcqrpWfjTyiubjUouJtOV99aWetKNs07RtRTF2dp1LGDUpMu6Uil6AuEIAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606948; c=relaxed/simple;
	bh=utFBf9M5dcRM6tABm4BVVtrrxHPeD0DczLAlTWsRgMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ROBY3v4NGLhY8Rt4z++FTXS3kmnPUzsoJnbmHJzhnAAoBKI1Rs9APoCn4d6gK4Ta4C6NeBhx31t1rr0/Pg/GhEzuKN7HPEcxQa+N+Fuwwlh1UguCsFMm3wwoY7j/y8hXAdinmbWeemeMXgvvytD9wNxZCTVM+zor694ZDsawfws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsK9c/pT; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so4710746a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 18:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709606946; x=1710211746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Etsiw27aFJ6ePlRv4kJKzIjRIrMxwFQzPpjYTTmiNpg=;
        b=RsK9c/pTJ++TQl3V2zbH6NouowJWbVbGTKCr69wUHVjkauEjMEI4qQoAXLYX3B4mCx
         lHqaS3XLI2nCUo3yUpDJPQ+t266s5ownviYf+qRF86MpjsfclIX6rudvEvwU6dtB1c55
         9RBtjSThM3sCOliOVvxn8bDsfNV435F74eNPI4m4iyT/NtjxlRC/NUIUZqudMK9/MWXe
         XmilVOlEMuS2mEqlEPGQ7iIH2b82G/9JkZ0oOvHV9iOiaWjO0OfX0QAc65Jr55IbyN46
         YrbubySDuiPvO+CDiEhbpN0ddrphJkT8XIsBAIJpr8bwi5hMMzTQfR8wNgogdiPmetse
         6faA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709606946; x=1710211746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Etsiw27aFJ6ePlRv4kJKzIjRIrMxwFQzPpjYTTmiNpg=;
        b=oJdNirStH7N7A6q//A5Des/7ToiiiOeS6cFRzvCypn/650nuevaLHnORnnGBIncavR
         w4ewjRqsMyoYpwKAgM7F3L6VQBccx29aYk/Sce84HnLgWNb5Q/9qJAv5lypaW+M0DCQE
         tYmbfMG51Mez6oYYvmAGjFPJY8+aJCRuteqz/Vx2lLfQbDo6eI3uT/AIToNesJeibDa8
         Iqyp6hQNLgznhD34leBYyJe/F0URHiAMfcoiDMxS06OetI4p/0MNwYj0d/sQlRli8uh4
         QOYwc/CQ26kl8PKSIKI/DuSy8mK8Gv2bhTKquSBu3Qw26tFqiQNn8n2dKWdHjeoRayrZ
         lL/g==
X-Forwarded-Encrypted: i=1; AJvYcCW5AqSNIxsdMyDea2yaAm3WhYiLK3Xns3UlrzkeHwfX3xVMjqDJB50zJccyzVWe4/oWHDRTQiYrs9YEuKnXJ+NbkNu76T0Hok4Kr7AB
X-Gm-Message-State: AOJu0Ywz4mGNH+oZ8vC771g9xrdL2mes3oWvzr0aRqlG+UFK1f2T4u8H
	8vjxSsv2soKQ3tZQx5GFn8r/xO7f/CtSoFh9Z/nY52S5C+KGBqVdCwx2dtD/
X-Google-Smtp-Source: AGHT+IFk9yI11rYtUnsLd3T3/itcAQ/8dXD2j/JJua/SgqclOjI32ujKMZVqVKGMRDVQxz7mbNfDuQ==
X-Received: by 2002:a05:6a21:3399:b0:1a0:dfcc:ca95 with SMTP id yy25-20020a056a21339900b001a0dfccca95mr653435pzb.18.1709606946607;
        Mon, 04 Mar 2024 18:49:06 -0800 (PST)
Received: from kernel.. ([2402:e280:214c:86:bce8:b689:c68d:28ed])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7851a000000b006e5b549949asm6324877pfn.206.2024.03.04.18.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 18:49:06 -0800 (PST)
From: R SUNDAR <prosunofficial@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	R SUNDAR <prosunofficial@gmail.com>
Subject: [PATCH] Removed funcs field description for kernel doc warning.
Date: Tue,  5 Mar 2024 08:18:57 +0530
Message-Id: <20240305024857.12783-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/include/drm/drm_gem_vram_helper.h:185: warning: Excess struct member 'funcs' description in 'drm_vram_mm'

Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
---
 include/drm/drm_gem_vram_helper.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index e18429f09e53..c89c9bafeb44 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -170,7 +170,6 @@ void drm_gem_vram_simple_display_pipe_cleanup_fb(
  * @vram_base:	Base address of the managed video memory
  * @vram_size:	Size of the managed video memory in bytes
  * @bdev:	The TTM BO device.
- * @funcs:	TTM BO functions
  *
  * The fields &struct drm_vram_mm.vram_base and
  * &struct drm_vram_mm.vrm_size are managed by VRAM MM, but are
-- 
2.34.1


