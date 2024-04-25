Return-Path: <linux-kernel+bounces-158546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9705A8B21E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B011C20A1F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF74149C50;
	Thu, 25 Apr 2024 12:48:49 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6959512BF29
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049329; cv=none; b=oSL7DCdGuXQpilF9xg91bcdrmX/2t5JWFHA6MGiQNxhZpYXAK0CwPxsumlN9BErWIks6+zH4EJll3YOrhZT3GduhDW3F4nda9m9dsLm/dFskPAywKv+yggyYn8zKtLiVWOUjfK+dCKwAs8eF/7RY0WLs0DmQ9rmw5tf+vJoXXwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049329; c=relaxed/simple;
	bh=ZHMcQbBSYof64DylecLYGkgdGxUJ5RsY1fCpIJYqfa8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YSthA1Rjffe8lU1F6B5R4RorjSVktrdyUUKXQTnYvrZob6WI8VmwngX8fENYF/GA+9KOWwJmrutRYRQhyFBG0GGsaT84eLWJQmCgZSnnA7Coc8Dcfz8CG9i5iF+ZHlowb59TTuYGmovDa5eP0WdVkww200mEBPi/LVIVxDD8bc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VQFtv62VFzXj9L;
	Thu, 25 Apr 2024 20:45:11 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (unknown [7.185.36.158])
	by mail.maildlp.com (Postfix) with ESMTPS id EE08D18007F;
	Thu, 25 Apr 2024 20:48:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 20:48:42 +0800
From: Junhao He <hejunhao3@huawei.com>
To: <will@kernel.org>, <jonathan.cameron@huawei.com>, <yangyicong@huawei.com>,
	<shaojijie@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>,
	<chenhao418@huawei.com>
Subject: [PATCH 0/3] drivers/perf: hisi: Fixed some issues with hisi pmu
Date: Thu, 25 Apr 2024 20:46:24 +0800
Message-ID: <20240425124627.13764-1-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500002.china.huawei.com (7.185.36.158)

This patchset includes 3 bug fixes changes to hisi PMU:
- Fix out-of-bound access when valid event group in hns pmu
- Fixes the memory leak in hns pmu
- Fix out-of-bound access when valid event group in pcie pmu

Hao Chen (1):
  drivers/perf: hisi: hns3: Actually use devm_add_action_or_reset()

Junhao He (2):
  drivers/perf: hisi_pcie: Fix out-of-bound access when valid event
    group
  drivers/perf: hisi: hns3: Fix out-of-bound access when valid event
    group

 drivers/perf/hisilicon/hisi_pcie_pmu.c | 14 +++++++++++++-
 drivers/perf/hisilicon/hns3_pmu.c      | 16 ++++++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)

-- 
2.33.0


