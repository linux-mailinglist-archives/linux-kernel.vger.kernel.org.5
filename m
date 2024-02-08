Return-Path: <linux-kernel+bounces-57753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 590CB84DD04
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAF51C22A43
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E076D1C4;
	Thu,  8 Feb 2024 09:32:46 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8C46BB2C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384766; cv=none; b=N+5S5tkmz5PnnrkjMub+qlObX05I8h1S7Btv7Z2Yz+xb5lH2AYz0UV498Ag1V70yAJsbqr53B33YkqfXS5QFbaL6gcQxDq+w9x2EwyxDJAuL2AXd641nMbtRl7NNljZstXIQFJ1p1uWjYNTiw00tKPtJfF7qJJjEEKABv81HT14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384766; c=relaxed/simple;
	bh=krq/hS9/1j9KLRxH0FYt963iK2ab66gutwWA8nIZph0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j0iUhTHzaAWtRijGJ2u5JmLMz8qDVrFiOrziR9PSwbVB6PBI7sscJap9T9q9IJ4hoy1O/Xr+Himm57zPWa3JcnEvrPP/h4peHpW4yZs80+/m0dcU8TftXfmUAjCvYsDcymDi2dD+IsTQDm9KFHUEspJnV1bHJ+lg8Raq9KuRA7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4189VjUp048928;
	Thu, 8 Feb 2024 17:31:45 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TVsF36KYhz2K4gjP;
	Thu,  8 Feb 2024 17:31:35 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 8 Feb 2024 17:31:43 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
        Ingo
 Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent
 Guittot <vincent.guittot@linaro.org>,
        Yu Zhao <yuzhao@google.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH 1/3] sched: fix compiling error on kernel/sched/sched.h
Date: Thu, 8 Feb 2024 17:31:34 +0800
Message-ID: <20240208093136.178797-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 4189VjUp048928

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Below compiling error reported. fix it.

block/../kernel/sched/sched.h: In function ‘update_current_exec_runtime’:
block/../kernel/sched/sched.h:3287:2: error: implicit declaration of function ‘account_group_exec_runtime’; did you mean ‘sched_group_rt_runtime’? [-Werror=implicit-function-declaration]
  account_group_exec_runtime(curr, delta_exec);

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 kernel/sched/sched.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 04846272409c..b0cffc9c0f0d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -20,6 +20,7 @@
 #include <linux/sched/task_flags.h>
 #include <linux/sched/task.h>
 #include <linux/sched/topology.h>
+#include <linux/sched/cputime.h>
 
 #include <linux/atomic.h>
 #include <linux/bitmap.h>
-- 
2.25.1


