Return-Path: <linux-kernel+bounces-153557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 288408ACF90
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5523D1C21891
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619F71514F9;
	Mon, 22 Apr 2024 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="piGpTv3k"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E393CF65
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796558; cv=none; b=JwjlZVx3/pl0Yo/wKNSWUfpiTV7IALo6JIEQrzzEpeDL9eU9D97jgQYB1JUC/o6hKHar731VGO4sGxgyUMdTIA0VlAgmgJNzwEiA1yAx4pgPywPzieEK830AVsmsFcU6L+PEp9YRmiGa4ljWQeLmwx8NKxlsPnCLyjIoCfr1moU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796558; c=relaxed/simple;
	bh=EwGSVi8tsIBhQGwWzz1I/qZviamVBkcZz6+GbYrdYmk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nHH31P53jljc/kjmPEW0Hqv09gwJ/XeRiyprEPaW2AiND+tqwXmdZb0m9v7XfeTcmqlwIYWY3y3VuyFbgv5CfM/50hx4xiwMuUX4+INIDXCIuvz7PLvBKmzNYkJr+tGnioh1POY+8myxBWBbi1/Okiaw1rVcLE2G6GMcwjQVeAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=piGpTv3k; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d6a772af5bso164423939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1713796556; x=1714401356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a/JPFUxV2ArWkhwNnn1v7zuWOs9XoBJjsryMcg9Mcoo=;
        b=piGpTv3k1ztDsoA3KzFniS8OUrino3+OEdveBYnZ/vO5cXdm7yaIbfybmkwEYB+Emh
         +qObK+mu7bLCFtypkwHJabuPkZSF1ApPFlrbGmpAUwDrZzYy0d8rnOBAsqB5UH2BVbsx
         9PkfSUNWjYKVu8EJxpFhLKiDq0U4lu7VmkhCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713796556; x=1714401356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/JPFUxV2ArWkhwNnn1v7zuWOs9XoBJjsryMcg9Mcoo=;
        b=eq21rZcmCx2Bre3ytScNZwS86etDzdQq24wTjtqe+Eek9hx0+yP19GHibDFddLdpOG
         lawUBtB84ooAZYSBxiseNgrT2VW12etEI5aEKAtTH8KAh7Ztq44C5HvpxK0ac0ewYp14
         XfSnfX7rZe/TxCbY2Ky1yik2f7hNvKtGLK1Yl8hJno2Eruxjz0+wVEeSPtHmADDRV1RY
         owiL/c79z9aR6Q89eobh2VeHyZICQ3c7uR6d/9y0kNOVITYTAY3O+ePw9ixvGF6Ggqhq
         9rrRGKEbOJ2JciCe/ZFnpx3LJYNEuEhRPmdA2CwZJ47k9V0mJGu4TskDfTx9/7y8HogD
         H2wA==
X-Gm-Message-State: AOJu0YyjUuJ0Uwk7iA5Tk8oXur9ydKBYZBz0JsIN4q2+e4OeP+OrSY44
	3074g9mlrDEFz5LaUo0PvscgvIbO/NWWGWsDbXO94pC5fH28/8JbJZ+oOWlQlMg=
X-Google-Smtp-Source: AGHT+IGDHc8HUrs0iww/TdL2zMyyadTokjPSQhWtaZ8TbB4GbBiQ8FO8zM77jN0fCSdoCB79InX/Ew==
X-Received: by 2002:a05:6602:1b92:b0:7cb:ffe6:b320 with SMTP id dq18-20020a0566021b9200b007cbffe6b320mr11608580iob.5.1713796555960;
        Mon, 22 Apr 2024 07:35:55 -0700 (PDT)
Received: from localhost ([2601:285:8700:8f20:e98c:6f5c:74a4:9a12])
        by smtp.gmail.com with UTF8SMTPSA id dv10-20020a056638608a00b00482f7427748sm2849642jab.135.2024.04.22.07.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 07:35:55 -0700 (PDT)
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
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Fangzhi Zuo <jerry.zuo@amd.com>,
	Leo Ma <hanghong.ma@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	Jose Fernandez <josef@netflix.com>
Subject: [PATCH RESEND] drm/amd/display: Fix division by zero in setup_dsc_config
Date: Mon, 22 Apr 2024 08:35:44 -0600
Message-Id: <20240422143544.20481-1-josef@netflix.com>
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


