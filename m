Return-Path: <linux-kernel+bounces-99952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4021C878FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718811C216E8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E368177658;
	Tue, 12 Mar 2024 08:35:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1583B779E4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710232509; cv=none; b=SQaOsTIOaEi0U8VRgMUS5Y3chGwJuvcfzQxP4vYUQWDz4Md1jhyO2EzjJupQbga6g5G731sfc06uvwUPKOzV51YLWjZAj6bV0rwrUP1v3uDCPuMB5uX6se6wMfzM+NFYCDDJ5xdSeZTRym3wTxwTdyBP8WrKO0CSu7djiT/gcA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710232509; c=relaxed/simple;
	bh=gsfSeC1YLbyxRfbDKgs8J90ICDzH9w8rykID/VZwCPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bkFgtlRGbMWhLX02li2N2uQxqZLjLdGtfLX5KuEDrh3p5xq0xGyD4x72apCcjRHaZpSvqX/tuQokCR0vSM8EduKeu0LiHKKSsWv8M18KL6FdNxThPsIygVXLqbnlC7Du1IGEVxH6zvn6sizUXdDJK0U2oZgsKV0m4B+kjH+99bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54B201007;
	Tue, 12 Mar 2024 01:35:43 -0700 (PDT)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7CBA33F73F;
	Tue, 12 Mar 2024 01:35:04 -0700 (PDT)
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
Subject: [PATCH v3 0/3] Add support for AArch64 AMUv1-based arch_freq_get_on_cpu
Date: Tue, 12 Mar 2024 08:34:28 +0000
Message-Id: <20240312083431.3239989-1-beata.michalska@arm.com>
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
an FVP model.

Relevant discussions:
[1] https://lore.kernel.org/all/20240229162520.970986-1-vanshikonda@os.amperecomputing.com/
[2] https://lore.kernel.org/all/7eozim2xnepacnnkzxlbx34hib4otycnbn4dqymfziqou5lw5u@5xzpv3t7sxo3/
[3] https://lore.kernel.org/all/20231212072617.14756-1-lihuisong@huawei.com/
[4] https://lore.kernel.org/lkml/ZIHpd6unkOtYVEqP@e120325.cambridge.arm.com/T/#m4e74cb5a0aaa353c60fedc6cfb95ab7a6e381e3c

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

Beata Michalska (2):
  arm64: Provide an AMU-based version of arch_freq_get_on_cpu
  arm64: Update AMU-based frequency scale factor on entering idle

Ionela Voinescu (1):
  arch_topology: init capacity_freq_ref to 0

 arch/arm64/kernel/topology.c | 116 +++++++++++++++++++++++++++++++----
 drivers/base/arch_topology.c |   8 ++-
 2 files changed, 110 insertions(+), 14 deletions(-)

-- 
2.25.1


