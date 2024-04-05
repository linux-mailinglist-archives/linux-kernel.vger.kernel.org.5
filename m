Return-Path: <linux-kernel+bounces-133067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 160A4899E57
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D2A1F222E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7924016D4E4;
	Fri,  5 Apr 2024 13:33:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929C916D338
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324023; cv=none; b=mSDLufUOcgTTrNrBG+Ln40v8SY+OwMRuWLcJpXmAKjIgb6HO9b+UIquSHrb2ia/8Aet3ntqbLbMBLFUd67O82WlRZl1V9j964hfIgS0eX+PEpkhIykVrSjvF6Jn2Doc0R+katckXr8QeLg7VE+Canh3oUofS7vfFt5/MqU89SLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324023; c=relaxed/simple;
	bh=LXjGpHiVHp7hjPWruy4/t8/vqKCfVZqBmrey23+vPl8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m41NlILj3mvGws2qvV3MKqwmU9XyivyBwGAx36zhp/ANmHp21K44Y0WGIflwS9VmKaadKKZb80rJqSmWTUOty82TBT+WJxBpSFfoWcOUIXvbqMkJ77bJXPSWR+qVaWug4KEH7Mun6si3wuN/VSbzTRgDfl9vlVhTXRooXanndio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 312F0DA7;
	Fri,  5 Apr 2024 06:34:10 -0700 (PDT)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 20A2A3F7B4;
	Fri,  5 Apr 2024 06:33:38 -0700 (PDT)
From: Beata Michalska <beata.michalska@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com,
	vanshikonda@os.amperecomputing.com
Cc: sudeep.holla@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	vincent.guittot@linaro.org,
	sumitg@nvidia.com,
	yang@os.amperecomputing.com,
	lihuisong@huawei.com
Subject: [PATCH v4 0/4] Add support for AArch64 AMUv1-based arch_freq_get_on_cpu
Date: Fri,  5 Apr 2024 14:33:15 +0100
Message-Id: <20240405133319.859813-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introducing arm64 specific version of arch_freq_get_on_cpu, cashing on
existing implementation for FIE and AMUv1 support: the frequency scale
factor, updated on each sched tick, serves as a base for retrieving
the frequency for a given CPU, representing an average frequency
reported between the ticks - thus its accuracy is limited.

The changes have been rather lightly (due to some limitations) tested on
an FVP model. Note that some small discrepancies have been observed while
testing (on the model) and this is currently being investigated, though it
should not have any significant impact on the overall results.

Relevant discussions:
[1] https://lore.kernel.org/all/20240229162520.970986-1-vanshikonda@os.amperecomputing.com/
[2] https://lore.kernel.org/all/7eozim2xnepacnnkzxlbx34hib4otycnbn4dqymfziqou5lw5u@5xzpv3t7sxo3/
[3] https://lore.kernel.org/all/20231212072617.14756-1-lihuisong@huawei.com/
[4] https://lore.kernel.org/lkml/ZIHpd6unkOtYVEqP@e120325.cambridge.arm.com/T/#m4e74cb5a0aaa353c60fedc6cfb95ab7a6e381e3c

v4:
- dropping seqcount
- fixing identifying active cpu within given policy
- skipping full dynticks cpus when retrieving the freq
- bringing back plugging in arch_freq_get_on_cpu into cpuinfo_cur_freq

v3:
- dropping changes to cpufreq_verify_current_freq
- pulling in changes from Ionela initializing capacity_freq_ref to 0
  (thanks for that!)  and applying suggestions made by her during last review:
	- switching to arch_scale_freq_capacity and arch_scale_freq_ref when
	  reversing freq scale factor computation
	- swapping shift with multiplication
- adding time limit for considering last scale update as valid
- updating frequency scale factor upon entering idle

v2:
- Splitting the patches
- Adding comment for full dyntick mode
- Plugging arch_freq_get_on_cpu into cpufreq_verify_current_freq instead
  of in show_cpuinfo_cur_freq to allow the framework to stay more in sync
  with potential freq changes


Beata Michalska (3):
  arm64: Provide an AMU-based version of arch_freq_get_on_cpu
  arm64: Update AMU-based frequency scale factor on entering idle
  cpufreq: Use arch specific feedback for cpuinfo_cur_freq

Ionela Voinescu (1):
  arch_topology: init capacity_freq_ref to 0

 arch/arm64/kernel/topology.c | 125 ++++++++++++++++++++++++++++++++---
 drivers/base/arch_topology.c |   8 ++-
 drivers/cpufreq/cpufreq.c    |   4 +-
 3 files changed, 123 insertions(+), 14 deletions(-)

-- 
2.25.1


