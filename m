Return-Path: <linux-kernel+bounces-156148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6198AFE88
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3E41F241D3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8785454F8D;
	Wed, 24 Apr 2024 02:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yB6fuoRt"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1586126F09
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926179; cv=none; b=ofhpnbsMM8wq0dMOIQGJhFYLOGhTWaHJXJWKuC4C1wrlIUfoltKtd4DE/UV8y//0wx63D72yMEfFm/cvRCr/7MqAK35nCVdWfeiY19AzILmete/mxM2MOTrmw2ngEzlEmZiR5huJH3bfb8wBnYP5dbgJbNePRwViw+M04OvjbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926179; c=relaxed/simple;
	bh=BafpapFSjyjaYD9stYSue+MJanZABEPgQdhw/3e8eiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tWJ/wWeMQMwRlUMNQdTfvvQTwUhjuWKECEhWB09IfJWc7AvkDfVqaO2hje4HdbDQG1o6dLQ4jeZ2lhPROoi0pv9O2eHcGnuZP8Jfm1M3B1iNOV1He2MV0v31Um5Oq+X3zyRTFzHA8WR/wz48ej5KunCwO0Uj3lf911cSuuP/h2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yB6fuoRt; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713926174; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=BzHtv+v5FsZg+1gMY5pUqSRj6b5kc5jgOVdLsLwEFOE=;
	b=yB6fuoRtrcfc1o/xIsDTJJh+Cdjftco15vHMScvhX0290YJ4AfxePBX5ycgFDEJwgFN21iZMgMfXmlfz5zW+oVmncNwM1DfAXf/NeWsGMcnFWlKP5BpElN3Hpuc5oGGC66LxVS1iGPBs/zhwQD7irFFksplfCKfc36xqX7VH66I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W5AjFF._1713926167;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W5AjFF._1713926167)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 10:36:13 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: suzuki.poulose@arm.com
Cc: mike.leach@linaro.org,
	james.clark@arm.com,
	alexander.shishkin@linux.intel.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] coresight: stm: Remove duplicate linux/acpi.h header
Date: Wed, 24 Apr 2024 10:36:05 +0800
Message-Id: <20240424023605.90489-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/drivers/hwtracing/coresight/coresight-stm.c: linux/acpi.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8871
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/hwtracing/coresight/coresight-stm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index cbf7f17556f8..9ca04fac53fa 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -30,7 +30,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/stm.h>
 #include <linux/platform_device.h>
-#include <linux/acpi.h>
 
 #include "coresight-priv.h"
 #include "coresight-trace-id.h"
-- 
2.20.1.7.g153144c


