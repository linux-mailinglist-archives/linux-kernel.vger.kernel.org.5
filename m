Return-Path: <linux-kernel+bounces-78148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F7A860F90
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B371287094
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28E37B3E6;
	Fri, 23 Feb 2024 10:38:25 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C9A6310A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684705; cv=none; b=k2i/uz8mf0W9eD2hA+vz965GO4Oh1lbdEGvmtk+5JIZUVxENV/yHtk9KjDJpIw/p+J1YeeVYJ/dQ/VojPcv/Mx+rqys4pDFIKGy+08brS5KES40RkLaoUmdJ7vppfgc6ClXs6HlMFOoLsQAOoELztCV83upw7pJftNkUNHlZ77c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684705; c=relaxed/simple;
	bh=azBPhXIyTF3fSClMZpebCbapCugiPBnyh9ir8UHejD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEJjYC9vDc7XuN8uB2HvgaPMzzhwdBEXoMu4C61sTbBoeKvFxPNaDwGjh1enuB1lmnM1d1faVJhU5EQBfF6qyOzoEkuTnVTz51NbAx/rLD2NQILBSppEyx5M1bGfUJul6fgsev2F8/hyY1CsdxQ6+73yxLeUr/LH3HmAYucp1tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Th60S5mTTz1vv9l;
	Fri, 23 Feb 2024 18:37:44 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id D27221A0172;
	Fri, 23 Feb 2024 18:38:19 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 18:38:19 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <jonathan.cameron@huawei.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<hejunhao3@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: [PATCH v2 6/8] drivers/perf: hisi_pcie: Relax the check on related events
Date: Fri, 23 Feb 2024 18:33:57 +0800
Message-ID: <20240223103359.18669-7-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20240223103359.18669-1-yangyicong@huawei.com>
References: <20240223103359.18669-1-yangyicong@huawei.com>
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

From: Junhao He <hejunhao3@huawei.com>

If we use two events with the same filter and related event type
(see the following example), the driver check whether they are related
events and are in the same group, otherwise the function
hisi_pcie_pmu_find_related_event() return -EINVAL, then the 2nd event
cannot count but the 1st event is running, although the PCIe PMU has
other idle counters.

In this case, The perf event scheduler will make the two events to
multiplex a counter, if the user use the formula
(1st event_value / 2nd event_value) to calculate the bandwidth, he/she
won't get the correct value, because they are not counting at the
same period.

This patch tries to fix this by making the related events to use
different idle counters if they are not in the same event group.

And finally, I'm going to say. The related events are best used in the
same group [1]. There are two ways to know if they are related events.
a) By event name, such as the latency events "xxx_latency, xxx_cnt" or
bandwidth events "xxx_flux, xxx_time".
b) By event type, such as "event=0xXXXX, event=0x1XXXX".

Use group to count the related events:
  [1] -e "{pmu_name/xxx_latency,port=1/,pmu_name/xxx_cnt,port=1/}"

  example:
    1st event: hisi_pcie0_core1/event=0x804,port=1
    2nd event: hisi_pcie0_core1/event=0x10804,port=1

  test cmd:
    perf stat -e hisi_pcie0_core1/event=0x804,port=1/ \
               -e hisi_pcie0_core1/event=0x10804,port=1/

  before patch:
            25,281      hisi_pcie0_core1/event=0x804,port=1/    (49.91%)
           470,598      hisi_pcie0_core1/event=0x10804,port=1/    (50.09%)

  after patch:
            24,147      hisi_pcie0_core1/event=0x804,port=1/
           474,558      hisi_pcie0_core1/event=0x10804,port=1/

Signed-off-by: Junhao He <hejunhao3@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index b2dde7559639..5b15f3698188 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -409,14 +409,10 @@ static int hisi_pcie_pmu_find_related_event(struct hisi_pcie_pmu *pcie_pmu,
 		if (!sibling)
 			continue;
 
-		if (!hisi_pcie_pmu_cmp_event(sibling, event))
-			continue;
-
 		/* Related events must be used in group */
-		if (sibling->group_leader == event->group_leader)
+		if (hisi_pcie_pmu_cmp_event(sibling, event) &&
+		    sibling->group_leader == event->group_leader)
 			return idx;
-		else
-			return -EINVAL;
 	}
 
 	return idx;
-- 
2.24.0


