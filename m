Return-Path: <linux-kernel+bounces-51499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71C2848BF6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716F9284754
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C3010A09;
	Sun,  4 Feb 2024 07:49:40 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ADFDDBB
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707032980; cv=none; b=MQa8fG2y/ak76TzFPMrnc8/a23L7ncZSiiEyq4CrCOTIbYrFilXL2Foq9fd8FJAIw0qwS9hU4qFYabdbL9Fe22uf19FH4HoJM73VyacOrNq0IhQcZblnUeMxdB2RsOD1iUjkDTjORUFAikOXdHGEqXoooGqcQ0XZajoV1Io2T2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707032980; c=relaxed/simple;
	bh=rXYFvyH79l7+Yc0s96NnJNKgXE+8nT+G+a5Np9FZCgk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K3jGuOaXnCHvnqBqCftgm2dCLvjI7dEvxQ1XwsekQpqU0b1sbR4p9kem5SpR4OpYsGlvfzbyuMhDHV9iVxZRjlgWM+b4A0c4ankpx8Dy1wzmHIaNOP81/2Fo3XlLHQItiVGKY4lJsY/QvB2vclOo7b+j6xUxG9O3G/tFp21t5zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TSM7j5MRszsWsW;
	Sun,  4 Feb 2024 15:48:17 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id DA800140384;
	Sun,  4 Feb 2024 15:49:34 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 15:49:34 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <jonathan.cameron@huawei.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<hejunhao3@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: [PATCH 0/7] Several updates for HiSilicon PCIe PMU driver
Date: Sun, 4 Feb 2024 15:45:20 +0800
Message-ID: <20240204074527.47110-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)

From: Yicong Yang <yangyicong@hisilicon.com>

This series mainly fix and optimize the several usage of the driver:
- Add more events to complement the TLP bandwidth counting
- Fix the wrong counting on using the event group
- Properly check the target filter to avoid invalid filter value
- Optimize the handling of related events which are not in an event group
- Update the docs

Junhao He (4):
  drivers/perf: hisi_pcie: Check the target filter properly
  drivers/perf: hisi_pcie: Relax the check on related events
  drivers/perf: hisi_pcie: Merge find_related_event() and
    get_event_idx()
  docs: perf: Update usage for target filter of hisi-pcie-pmu

Yicong Yang (3):
  drivers/perf: hisi_pcie: Introduce hisi_pcie_pmu_get_filter()
  drivers/perf: hisi_pcie: Fix incorrect counting under metric mode
  drivers/perf: hisi_pcie: Add more events for counting TLP bandwidth

 .../admin-guide/perf/hisi-pcie-pmu.rst        | 31 ++++--
 drivers/perf/hisilicon/hisi_pcie_pmu.c        | 99 ++++++++++---------
 2 files changed, 74 insertions(+), 56 deletions(-)

-- 
2.24.0


