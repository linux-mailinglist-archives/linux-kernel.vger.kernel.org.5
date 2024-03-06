Return-Path: <linux-kernel+bounces-93237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AD1872CA9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7BAF282372
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DF8D53C;
	Wed,  6 Mar 2024 02:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fXYhPf+I"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E26117
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 02:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709691706; cv=none; b=S8a/RKiZwrG2SualWQ4jOyESWVuQ8Nyr4LgiOqTzBOtT3ocNvGrZw4VkgUS7OVO3i6JWXJmHUpTeOrPtgMfJ3KROFbK9uVcarXz/1I0q4+bU4YFRLCFOGYlWqeh8w/RfyHJl+ncah0lkfhwLyDNsYHvi6xB9r58aqK3Jt4QGhP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709691706; c=relaxed/simple;
	bh=rm57lsTKciJu3rSiaNHp28RaJrU+K13XPqSSzyLHJB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MtcPt3t0lNJbBP5nakbwAVZAJpmihFB7NRxLO7ZE7hJoGFiXmRwprU43DdzNWEIAQ6RDl52NK7PHaPEnYeM6nZklIAA2TfbJHZtrDUw2a4ggcvx6Z1VNwF65wBcIybSv4rM2ZRwuwtX3WJd/IMiBJTVcNKNEr67D3W+D6fxmLB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fXYhPf+I; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709691700; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=FQajHdlrRIpPD1VfBoGHq5VfrCAvWMrIFU1AsQVmtqE=;
	b=fXYhPf+I6fJZv97QeYDcHzBOZmWQDk7uIHos2N2gQKV4zqZ4XkLFRZd83/+6bdjsffpHh629iLDj0/ld4/+9potvgSLOLH71KX+RktoWwK8lcwP4qRBxek8mlAJCb5LBNR6SMx6M608pG+4dubUvS6wheuvmYoEQjro7dCDaAP0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W1vhPI3_1709691693;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0W1vhPI3_1709691693)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 10:21:39 +0800
From: Tianchen Ding <dtcccc@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v2 0/2] sched/eevdf: Minor fixes for reweight_entity()
Date: Wed,  6 Mar 2024 10:21:31 +0800
Message-Id: <20240306022133.81008-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the discussion in [1], fix a calculation bug in
reweight_entity().

[1] https://lore.kernel.org/all/59585184-d13d-46e0-8d68-42838e97a702@bytedance.com/

v2:
Add fixes tag to the 1st patch.

v1: https://lore.kernel.org/all/20240304030042.2690-1-dtcccc@linux.alibaba.com/

Tianchen Ding (2):
  sched/eevdf: Always update V if se->on_rq when reweighting
  sched/eevdf: Fix miscalculation in reweight_entity() when se is not
    curr

 kernel/sched/fair.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.39.3


