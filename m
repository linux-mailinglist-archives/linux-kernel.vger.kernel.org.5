Return-Path: <linux-kernel+bounces-147826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AC28A7A29
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926D62839C8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66D97470;
	Wed, 17 Apr 2024 01:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oysQD+AK"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9DC6FB6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713317377; cv=none; b=H84FTJYcrjQNHjP8QVZykI6TgDRNaPapppZggTM3YPAmOmafkSp+Wfy2avj+qi0qbz2jyUJpe7lEU7pSlLZfpVgSrPmDcHQedH7ju85ZXjKD421CJXtNUkmHidgdVrKQWqYTloh0tdf65x0gbvd6Z/WZA+HfuR3IVqbk7+dQDUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713317377; c=relaxed/simple;
	bh=zrsbrWUCH7IU2OQjgGNK2JeXB+8qJqCr8GXdz6VEmPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=thEAFJTdKKyEHKfw63dMRmW8fo659muwReHjxNnjSCJ7D6I9F6O6cSySG1evqssku479lq2Itzfx0YUlmuorulIuR8YKLq1GIj1KK0w1LPjDl5t93GFFq8PVT3h8PS2BA6j8URcsbzXvSHfz4YudyM2B1gUF2234OwyJcKeksoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oysQD+AK; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713317366; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Dr7jF+FySk7Rp7HxMoL85gwUKMW7cBIWwj0ZHoPvAOU=;
	b=oysQD+AKWXDGoxT/c8ZVRoGuuwtXX6nY+qFUMlpGJiMC2tJNpdICoAz5DafIjDJD9aW6/fvMicBKRG5lLIz73kmNJQsjRQNYBC4VgWi33c+cxuoAyYmoPbZ3mYKtm4FujpgT5nmt04H0v3jnVSYHj3GPZsRxaoBv66pOxCvpUyE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4jMUmb_1713317359;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W4jMUmb_1713317359)
          by smtp.aliyun-inc.com;
          Wed, 17 Apr 2024 09:29:26 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/vmwgfx: Remove duplicate vmwgfx_vkms.h header
Date: Wed, 17 Apr 2024 09:29:17 +0800
Message-Id: <20240417012917.66046-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c: vmwgfx_vkms.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8772
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
index 7e93a45948f7..3bfcf671fcd5 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
@@ -31,7 +31,6 @@
 #include "vmwgfx_bo.h"
 #include "vmwgfx_drv.h"
 #include "vmwgfx_kms.h"
-#include "vmwgfx_vkms.h"
 
 #include "vmw_surface_cache.h"
 
-- 
2.20.1.7.g153144c


