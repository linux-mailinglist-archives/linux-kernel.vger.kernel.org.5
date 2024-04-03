Return-Path: <linux-kernel+bounces-130154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 001D18974BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD50728D122
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D3214B073;
	Wed,  3 Apr 2024 16:01:23 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B1114AD16;
	Wed,  3 Apr 2024 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160083; cv=none; b=Ne1YAVjAgsYx1lVYnQKWjCRZl3XiTKxbVNk5WfMmE349+PZDSTl+9vB+HgNq9nTFJ5NGC7+D0xWmHiy2Q5IFiRvO4X94X//Pcr+XcEhIBSi+1ef6Z9n9K112K1RmXkZYjQ2Hor6P0dj4eAPyn02qwNSzDTXdk9S1qQOZoogti/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160083; c=relaxed/simple;
	bh=F+mXsbsBtwXCi5SGIYExSQ4DFRDs0WCi8xy62MEN6Wo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N/1QFEwYTUznCQA4g9GI4fRTbYYy0ou7Y5Sekis+6CdZhmseWUywVLie8X/NEh9MXSCHxjGu9AMRApEmiJKVoHc8wsUGr+gfK7nTtR9azXv550dojqes3vIc56o3xCUBmTb0RqOXFoyf28pD4PtOb6o41WYFHc+R02vU6XgkkcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp78t1712159992t6njo4v7
X-QQ-Originating-IP: pHJr87vrbCc1ofnl88X9CvVXg6F7BapJkb93YA7DMVU=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Apr 2024 23:59:51 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: nOLHIySYvhh+CK+Ko5fE9E+vJIyoQ0sr8MduZU6gkv+fTySD2AjqTWq+tV9Ur
	wpRok6DgZj2rp/2omAWwyTM/xEy+7ayFGvqM3ixvm55oGlpanZkoZcrBB/eGQ46tQjz7IXA
	/HiG6s8qO0h4OAQMEbEi+84gvKNduvMa7xGF1sYuFHiKoCwGEEp0xiqDRgzRWuVri7OQxQ1
	phbvv0krKC/OCZBEslPYNsmvJVLexs41LJoYpC01ymibwkpp/t1QqBf7XtyrPVgCak677uE
	nO3AqTL//5Q4UpwtWr7k5gFPCUuKzKVWpRWkALsioIczMWzAiNSctkPQbjwpV/lk6vpkEpN
	08ZQCEk3GxEbt3twGkiP8aCD1qRQu2Sj4xR05xIpvIwRHiLVgkuEpVh/rPdZGetyy3kV6H6
	rZq/EvlHgYA4rIatWstu4Q==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6963273910614302494
From: Dawei Li <dawei.li@shingroup.cn>
To: will@kernel.org,
	mark.rutland@arm.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk
Cc: xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com,
	jonathan.cameron@huawei.com,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v3 00/10] perf: Avoid placing cpumask on the stack
Date: Wed,  3 Apr 2024 23:59:40 +0800
Message-Id: <20240403155950.2068109-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi all,

This is v3 of previous series on elimination of placing cpumask var on
stack.

Change since v2:
- Update commit message for patch[2-10]. [Mark] 
- Add Reviewed-by from Mark for patch[2-10].

Change since v1:
- Change from dynamic allocation to a temporary var free helper:
  cpumask_any_and_but().	[Mark]

- Some minor coding style improvements, reverse chrismas tree e.g.

- For cpumask_any_and_but() itself:
  - Moved to cpumask.h, just like other helpers.
  - Return value converted to unsigned int.
  - Remove EXPORT_SYMBOL, for obvious reason.

v1:
https://lore.kernel.org/lkml/20240402105610.1695644-1-dawei.li@shingroup.cn/
https://lore.kernel.org/lkml/1486381132-5610-1-git-send-email-mark.rutland@arm.com/

v2:
https://lore.kernel.org/lkml/20240403125109.2054881-1-dawei.li@shingroup.cn/

Dawei Li (9):
  perf/alibaba_uncore_drw: Avoid placing cpumask on the stack
  perf/arm-cmn: Avoid placing cpumask on the stack
  perf/arm_cspmu: Avoid placing cpumask on the stack
  perf/arm_dsu: Avoid placing cpumask on the stack
  perf/dwc_pcie: Avoid placing cpumask on the stack
  perf/hisi_pcie: Avoid placing cpumask on the stack
  perf/hisi_uncore: Avoid placing cpumask on the stack
  perf/qcom_l2: Avoid placing cpumask on the stack
  perf/thunderx2: Avoid placing cpumask on the stack

Mark Rutland (1):
  cpumask: add cpumask_any_and_but()

 drivers/perf/alibaba_uncore_drw_pmu.c    | 10 +++-------
 drivers/perf/arm-cmn.c                   | 10 +++++-----
 drivers/perf/arm_cspmu/arm_cspmu.c       |  8 +++-----
 drivers/perf/arm_dsu_pmu.c               | 19 ++++++-------------
 drivers/perf/dwc_pcie_pmu.c              | 10 ++++------
 drivers/perf/hisilicon/hisi_pcie_pmu.c   |  9 ++++-----
 drivers/perf/hisilicon/hisi_uncore_pmu.c |  6 ++----
 drivers/perf/qcom_l2_pmu.c               |  8 +++-----
 drivers/perf/thunderx2_pmu.c             | 10 +++-------
 include/linux/cpumask.h                  | 23 +++++++++++++++++++++++
 10 files changed, 56 insertions(+), 57 deletions(-)

Thanks,

    Dawei

-- 
2.27.0


