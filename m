Return-Path: <linux-kernel+bounces-150937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1938AA6E5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 04:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA17AB22481
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC974C85;
	Fri, 19 Apr 2024 02:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xv9VR1+h"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5D34C8A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713493162; cv=none; b=eK/LWkVLv2piPsoN+n3gv6CO60w/HD62FDqYFWIMVTbp9KrWEYbWH4zrWPRlIvMIofyznMKWC9ezSd2GLMWisgQlno2lDDsAvb98xmZ903LrDvubVgLZSVPFQNU92+MGF2qBu4zarNEG0FajUSC0d1SXkg0Z+wPdNXNhN89EujU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713493162; c=relaxed/simple;
	bh=/+KvTI1u3nFceMr/A4WlUovD0kyARNV6CK6TkUnGV3c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V4dUCDf8jm1PB5Uhldntn3h55y0TbCM0EJbFttdoTHb6G7OACvxpTdLB9LArFZVs8h3J+Djuwo+CrOeVkwFjW57kHLDmKJW+gzxKq7LLUUen9mcrMKy3CH+L20FcxEUG1IebcMmj7mt5T9fN21J21QxqrM3PGVjVsdrE74vgZt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xv9VR1+h; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713493156; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Td7V3A43ySEiCBw4iP8fzhTEsH+umasH6SY05GOKao8=;
	b=xv9VR1+hB/b4uvPKsNSnM/ibjYR+kd/cYKAtZhwHHOSmRFdXKR6eCRpsWstSshOf/5attVcxGOQcGV44jsEZXeocPDd8SKayU2fexTXAvmNBM+SP4iX1ECGT8NeDofdijAP2v97pMIgRNQIATiqNg/lSzTMJoG0iaZMjUYigaDg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W4qBpQY_1713493129;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W4qBpQY_1713493129)
          by smtp.aliyun-inc.com;
          Fri, 19 Apr 2024 10:19:16 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: harry.wentland@amd.com
Cc: sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: Remove duplicate dcn32/dcn32_clk_mgr.h header
Date: Fri, 19 Apr 2024 10:18:47 +0800
Message-Id: <20240419021847.16585-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c: dcn32/dcn32_clk_mgr.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8789
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 7eecb3403f74..d7bbb0891398 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -41,7 +41,6 @@
 #include "dcn/dcn_3_2_0_offset.h"
 #include "dcn/dcn_3_2_0_sh_mask.h"
 
-#include "dcn32/dcn32_clk_mgr.h"
 #include "dml/dcn32/dcn32_fpu.h"
 
 #define DCN_BASE__INST0_SEG1                       0x000000C0
-- 
2.20.1.7.g153144c


