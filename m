Return-Path: <linux-kernel+bounces-78145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6640E860F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9818D1C21D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9DA76C62;
	Fri, 23 Feb 2024 10:38:24 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446BC1642C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684704; cv=none; b=P1BHiCbzXrzV46zUd7rbtTpeMoIfUhoKU5TgSJZHoFyg+k8PncGzOcuODaQVUFYEMwB+e03ru6QxLW1ICeSrJaPb3VdMhbIUp4xHGVElc0bMMRZp5d4a63/voCl6SuFmZ80ZjK0DD4IVnZmqs3UAtmmDWxNvwBVAaHdrk1gfJJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684704; c=relaxed/simple;
	bh=RUPsiCDd2MQJ2G7s6am/N3RkD+u1oGVMu5JjFEVw4Kg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aN9QlSKSFIxMC2L6EfA+9qKeFB6x+Zv2u2wlyBZuM54ociUx4FefG6Mb+tFWUnQO3nDI+Ly7tYXHyR7/LMbFfXufORlB8WuqeQtF4KmH2Bkcsr2tKGhcDs0WTWlNFyC7lPUDjlCnfCelsCPdj7vQcMh0c0n571iAjJ6AL5uSMgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Th5yb4wYTz1X2qw;
	Fri, 23 Feb 2024 18:36:07 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id A549E1A016B;
	Fri, 23 Feb 2024 18:38:18 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 18:38:18 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <jonathan.cameron@huawei.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<hejunhao3@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: [PATCH v2 0/8] drivers/perf: hisi_pcie: Several updates for HiSilicon PCIe PMU driver
Date: Fri, 23 Feb 2024 18:33:51 +0800
Message-ID: <20240223103359.18669-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)

From: Yicong Yang <yangyicong@hisilicon.com>

This series mainly fix and optimize the several usage of the driver:
- Add more events to complement the TLP bandwidth counting
- Fix the wrong counting on using the event group
- Properly check the target filter to avoid invalid filter value
- Optimize the handling of related events which are not in an event group
- Update the docs

Change since v1:
- Rename hisi_pcie_pmu_{config,clear}_filter() to properly reflect its function.
- Add some test case logs to the Patch 5/8 comments.
- Avoid use HISI_PCIE_MAX_COUNTER outside of functions in Patch 7/8.
Link: https://lore.kernel.org/all/20240204074527.47110-1-yangyicong@huawei.com/

Junhao He (4):
  drivers/perf: hisi_pcie: Check the target filter properly
  drivers/perf: hisi_pcie: Relax the check on related events
  drivers/perf: hisi_pcie: Merge find_related_event() and
    get_event_idx()
  docs: perf: Update usage for target filter of hisi-pcie-pmu

Yicong Yang (4):
  drivers/perf: hisi_pcie: Rename hisi_pcie_pmu_{config,clear}_filter()
  drivers/perf: hisi_pcie: Introduce hisi_pcie_pmu_get_event_ctrl_val()
  drivers/perf: hisi_pcie: Fix incorrect counting under metric mode
  drivers/perf: hisi_pcie: Add more events for counting TLP bandwidth

 .../admin-guide/perf/hisi-pcie-pmu.rst        |  31 ++++--
 drivers/perf/hisilicon/hisi_pcie_pmu.c        | 102 +++++++++---------
 2 files changed, 76 insertions(+), 57 deletions(-)

-- 
2.24.0


