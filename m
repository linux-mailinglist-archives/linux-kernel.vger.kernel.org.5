Return-Path: <linux-kernel+bounces-51737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C60C848EB5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45EF2821A7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBA8224FB;
	Sun,  4 Feb 2024 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj9c0OoC"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EF2224D2
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058454; cv=none; b=u0oLw3kWPyT/vZkrhQBG0rCyQCb6JqpbN8vqZ3aul7l3iPmtGQFUp1PLuFN43pxmZO1t3OMj1iiCyxE2TUfJnc+Hys9geVxakdxp/GHFc21UGzh2GhjI+GbNiiVVdOXoUYgCS7nY47ckcVAuApnNQyLtpj7lNzAZZ14E0aFyxQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058454; c=relaxed/simple;
	bh=t5PBrNaa/5JPrYNdF7BoNULfY3r6ZqVl7vqLphsOQ6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iG/yR/jUhkB+WipTxovR2O0T7LJGuhsol60RvUfnsn/oJ8AL9tb/OmXpgMDLI/LbM2M0ryByhkHHz2YiXMaXMcmTTHZohtIUpJfTd54Qd3UtChwQVNh23zToH8GcbP5MPyD6jFhXs0d63wngxVCKAr1EzqfXqblbBn3c7+km00w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj9c0OoC; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d3907ff128so3146805a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 06:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707058452; x=1707663252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n3whH72L6JbdpRMThqcQPd4/z6Z10Hs1Q/PHuiiBNDc=;
        b=Yj9c0OoCQOEHCjEG7wN0ZB5wduP91j9ksJc80OVrHOnyUVapFTVsZxrUT3EqryDnHI
         XNmv4+TU1QsDDuxwvbbS7MfoPIAx8BGrL+sJoYu2q2PkCPIGdXPVMHFqNQoDzPxbSLnk
         hmdtkrBoz5cgey5ncWK5AIlRFRIhA820FPqF40gaTY6le5RDn9M9vr0vd5X5Dp17gXTO
         2UbLicmMOjC55fxHPLOUpKbnHsUKlPnatDxuYYHDf1J1LNyq1VckPcgnNXGaRBzuzvqX
         1RbgC7Lz5406BJAFAWxayspmEZ/ra/VvvXbArEQeOrzFeDWEDVzeXWgyRG0GJJ0oN9vd
         5Pfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707058452; x=1707663252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3whH72L6JbdpRMThqcQPd4/z6Z10Hs1Q/PHuiiBNDc=;
        b=pDBVTtTElQtXpKbP+5YlIShU5RnuxCxFrTK2XwsGgc1kgk4Oh2iE7RJTJZJol9L74Z
         nBLN84WukWnvEUCG7Rf6PC3Gu+gi9e2vEyBW4z64s83uartEt/HRss6hHRuw8Dbv95eS
         taEKIujiTYGb+FntUQAEFCv8d3IZvyL3L8moeFsmaOzHU4rx6g8a32WwMJ8I0UsBYZ/q
         18pEW1w+iL17dAUeZO2BTORiq37wunnx07xvTqujoKiMwhewUUH6xTnt5xfWsyuDbeyz
         DDEwBBqV1fLCUgtAhSYuOs1EinglCHUaMSaVU6HgXZAEqpafcHyUW2T5vQC8gHc2LeOg
         OWTQ==
X-Gm-Message-State: AOJu0Ywf+4/H1ZzZJkY0q2ECjH2hKPigyr4by6HZJMG2wlQWV6VfAOe+
	F/gPnZjMhsTvJSniCcbtY9zsHy83JhcK4GORP2Y8FI5nGPb852Oj
X-Google-Smtp-Source: AGHT+IFKIQr25L6upTbF8DkN0oy7iPsUjkCU30eKPdE7KclI3lrjTImtO2y4SXNynkzRWEBAMcvVhQ==
X-Received: by 2002:a05:6a21:7894:b0:19c:90fc:f0d3 with SMTP id bf20-20020a056a21789400b0019c90fcf0d3mr17292149pzc.46.1707058452169;
        Sun, 04 Feb 2024 06:54:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWLgqaoTUsz8EFM/UWYR3wQRQToleUGy8Ejzwo/789riZZr+R3Rshzv2kutEzaRCTuN3XfGdXrZD2B8scfYl/n/ALi5iP/2FdAlDxHj82y2r+55fXKl91xQU3Yiu4Ob84gzeuluSNaK60AGRZbt/i2qlhWhpne/wbubqe4JhngqEQBb43RiMrFDbWt9IYXvjtPOF+5l0yx0V/BsWaS6DZ7Db4a427vyVOGGrQxMrRYvaAXcfXBr5hSzIPg=
Received: from localhost ([103.139.191.218])
        by smtp.gmail.com with UTF8SMTPSA id lw10-20020a056a00750a00b006de11c980e5sm4864257pfb.80.2024.02.04.06.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 06:54:11 -0800 (PST)
From: Kartik Agarwala <agarwala.kartik@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: Kartik Agarwala <agarwala.kartik@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: fix kernel-doc warning in drm_vram_mm
Date: Sun,  4 Feb 2024 20:23:48 +0530
Message-Id: <20240204145348.56924-1-agarwala.kartik@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc warning in drm_vram_mm struct generated due to 
obselete field.

Signed-off-by: Kartik Agarwala <agarwala.kartik@gmail.com>
---
 include/drm/drm_gem_vram_helper.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index e18429f09..c89c9bafe 100644
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


