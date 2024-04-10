Return-Path: <linux-kernel+bounces-137886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3D789E8EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A2C286E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFBCD515;
	Wed, 10 Apr 2024 04:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="R7ohwTgC"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D48E7460
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 04:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723687; cv=none; b=namMnNe0exLbKcTCajx/ON8Ng5Hn2u+z599AFJrrARD7V6TaLNk8pyLgmnedNl/HU/X6UK7KLj8OB/LUkdckGG2Ki9zoZlyUv0QHhnx0OOZobbcC/1o1fMnv/pPnMNdGMRmIoLz6UkkSgUuTbwfr+MUXEsRL+JXYghinQOch6GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723687; c=relaxed/simple;
	bh=EwGSVi8tsIBhQGwWzz1I/qZviamVBkcZz6+GbYrdYmk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ViCTaijU22Cpd6JSfGrlqrTRK60reChfeysqMjNvSzwxkQtBOI6CZvchUc5I5tkaYwsTg7n5dD2A3movh+Bw7UaGjy5MbTSkDU/aAF2JxqFWcb28RaL3RD4bijR45EW7pgQidNbtE9FDZs4oVWsFtqwSicSXGeBVP8ybsEekU7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=R7ohwTgC; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36a205e0f16so12294455ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 21:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1712723685; x=1713328485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a/JPFUxV2ArWkhwNnn1v7zuWOs9XoBJjsryMcg9Mcoo=;
        b=R7ohwTgCEg/QJQ8V7LMvmWQTuOLEBRgNpllbR4GDO7T5CaJMfUeK1/41c+FR32Ivxk
         juiY1IZ6qPKDSLRYoJevxJ1JW4nzviRSSvvTm4TB34B7jlttE0qKamwkN3pxslxyHkvk
         yj3gxdGRW6qRJLin03IKxXtVt/rxHDow0Tsv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712723685; x=1713328485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/JPFUxV2ArWkhwNnn1v7zuWOs9XoBJjsryMcg9Mcoo=;
        b=PSfyrYn5rhuJ4ib7X38fDDy6tgLRDgA4R/wbtpYZlppI9MI2Y2/AI7TmCY4Kk00q7f
         NZ6jyWNPoGwcGHOoULmKuB3RYtVTiJPumCxj4NHa84oTQqwpsjg21gMnDbYu3J2408JA
         8ipdPcVE4nC/+pvYsgEONtscPHmYf8MivMY9b9H7WRg3Pur+eF+3xfef30AawvJ9n6zL
         jFAh4run15zZCa69XK+zNTBXuGgp/c6TxaCveluJB70qXi7rvO5pMDAwGDcUEk535PIq
         5Zmkj6H5T/QSFHP3nCCvMIYcXPdKt8s9I7OQ5hsiHVYKW7/OUWo4dX6xdncYcKNr8o2y
         IU6w==
X-Gm-Message-State: AOJu0YxLQlBHJzHoPydqQtUR9gCeVmGC3CSi53xrK+paIB/KQfYwmbgn
	+fxVKmUdrCdtBwtokXp9M3CKePW+iudhGGPRGS68GVeq9Lp78TBKuLa2JWmMOG4=
X-Google-Smtp-Source: AGHT+IFILeN96Xd9wtsGDWKumJLAOJAbRVY+isMe2Tofq8xMm3T+C68RphVpIWdR/vNbrvujRnChCQ==
X-Received: by 2002:a05:6e02:1607:b0:369:ed5b:dd56 with SMTP id t7-20020a056e02160700b00369ed5bdd56mr2350659ilu.17.1712723685172;
        Tue, 09 Apr 2024 21:34:45 -0700 (PDT)
Received: from localhost ([2601:285:8700:8f20:fa81:e682:614d:196f])
        by smtp.gmail.com with UTF8SMTPSA id hb2-20020a0566386c0200b0048290482c7bsm2023528jab.54.2024.04.09.21.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 21:34:44 -0700 (PDT)
From: Jose Fernandez <josef@netflix.com>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Alan Liu <haoping.liu@amd.com>,
	George Shen <george.shen@amd.com>,
	Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
	Ilya Bakoulin <ilya.bakoulin@amd.com>,
	Nasir Osman <nasir.osman@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Fangzhi Zuo <jerry.zuo@amd.com>,
	Leo Ma <hanghong.ma@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	Jose Fernandez <josef@netflix.com>
Subject: [PATCH] drm/amd/display: Fix division by zero in setup_dsc_config
Date: Tue,  9 Apr 2024 22:34:33 -0600
Message-Id: <20240410043433.12854-1-josef@netflix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When slice_height is 0, the division by slice_height in the calculation
of the number of slices will cause a division by zero driver crash. This
leaves the kernel in a state that requires a reboot. This patch adds a
check to avoid the division by zero.

The stack trace below is for the 6.8.4 Kernel. I reproduced the issue on
a Z16 Gen 2 Lenovo Thinkpad with a Apple Studio Display monitor
connected via Thunderbolt. The amdgpu driver crashed with this exception
when I rebooted the system with the monitor connected.

kernel: ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447)
kernel: ? do_trap (arch/x86/kernel/traps.c:113 arch/x86/kernel/traps.c:154)
kernel: ? setup_dsc_config (drivers/gpu/drm/amd/amdgpu/../display/dc/dsc/dc_dsc.c:1053) amdgpu
kernel: ? do_error_trap (./arch/x86/include/asm/traps.h:58 arch/x86/kernel/traps.c:175)
kernel: ? setup_dsc_config (drivers/gpu/drm/amd/amdgpu/../display/dc/dsc/dc_dsc.c:1053) amdgpu
kernel: ? exc_divide_error (arch/x86/kernel/traps.c:194 (discriminator 2))
kernel: ? setup_dsc_config (drivers/gpu/drm/amd/amdgpu/../display/dc/dsc/dc_dsc.c:1053) amdgpu
kernel: ? asm_exc_divide_error (./arch/x86/include/asm/idtentry.h:548)
kernel: ? setup_dsc_config (drivers/gpu/drm/amd/amdgpu/../display/dc/dsc/dc_dsc.c:1053) amdgpu
kernel: dc_dsc_compute_config (drivers/gpu/drm/amd/amdgpu/../display/dc/dsc/dc_dsc.c:1109) amdgpu

After applying this patch, the driver no longer crashes when the monitor
is connected and the system is rebooted. I believe this is the same
issue reported for 3113.

Signed-off-by: Jose Fernandez <josef@netflix.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3113
---
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index ac41f9c0a283..597d5425d6cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -1055,7 +1055,12 @@ static bool setup_dsc_config(
 	if (!is_dsc_possible)
 		goto done;
 
-	dsc_cfg->num_slices_v = pic_height/slice_height;
+	if (slice_height > 0)
+		dsc_cfg->num_slices_v = pic_height/slice_height;
+	else {
+		is_dsc_possible = false;
+		goto done;
+	}
 
 	if (target_bandwidth_kbps > 0) {
 		is_dsc_possible = decide_dsc_target_bpp_x16(
-- 
2.44.0


