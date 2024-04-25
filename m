Return-Path: <linux-kernel+bounces-157964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E248B1963
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9081C224A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4501C6B9;
	Thu, 25 Apr 2024 03:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oMLjneiG"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CC41C6A8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 03:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015427; cv=none; b=SmGPOJ0+bXr80k3y8G6Kyh/nNzIkkSdZNepEpViieerUsf5ig2CSeri5dGrPqfS6mxWQbzlBWH6p548teOSntxaaTmY5qSHacm5e//0q4r1/k4V5HhR4WQxuNVm44pcoyKi3nT/QIhrSoi7C4AUBnQbS5u/tfVfdKViXIi5F/+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015427; c=relaxed/simple;
	bh=W0kMXR1xOCsdxLV/fPvc2a0HCdfF2CcaczvfVDnmPIU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a7GlSQLpg8UcUyCqC1TkACiorZ0/gpOL+nky1g+zzQUHPph87FTVhs8ovw7e2ceVTb0+ysExQiBGQUrBGgI8GIzxYdDPIKyZ3Uz3yh8kA3Hz4rOAqmqqsBdPaa+Qt0qgO/LukIChAHByL8lw7AO4LcY+riIioMhmMrtoydGlcQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oMLjneiG; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714015421; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=D2MFVeFk0iquizyFFpjJSV1Dr/FtfPZuCe4hBIu1n/0=;
	b=oMLjneiGoJ61qbVpAH0h4AA8rDd4sftrIToOjF4BghSNWTVb7lZTr7B+8eKiptUTDyetZlkuI2D3vG2QbbE3RE9+AF5QX/IPakCxGry5LMLiAuPcnUD0aSoEiZHbnprGD1+omHEoLyF5igwftGf4tL46XVRSQz9gQNquZDAq4hg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W5DsRK2_1714015411;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W5DsRK2_1714015411)
          by smtp.aliyun-inc.com;
          Thu, 25 Apr 2024 11:23:40 +0800
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
Subject: [PATCH] drm/amd/display: Remove duplicate dcn401/dcn401_clk_mgr.h header
Date: Thu, 25 Apr 2024 11:23:30 +0800
Message-Id: <20240425032330.36812-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c: dcn401/dcn401_clk_mgr.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8885
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index d146c35f6d60..005092b0a0cb 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -21,7 +21,6 @@
 #include "dcn/dcn_4_1_0_offset.h"
 #include "dcn/dcn_4_1_0_sh_mask.h"
 
-#include "dcn401/dcn401_clk_mgr.h"
 #include "dml/dcn401/dcn401_fpu.h"
 
 #define mmCLK01_CLK0_CLK_PLL_REQ                        0x16E37
-- 
2.20.1.7.g153144c


