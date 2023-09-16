Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703A17A2FB8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 13:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbjIPLea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 07:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjIPLeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:34:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F78CC7;
        Sat, 16 Sep 2023 04:33:52 -0700 (PDT)
X-UUID: e54ff656548411ee8051498923ad61e6-20230916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hMzPQ8aaLRD7k9X0lpqUQAXHbIrWQDq6gdiavUcBGAY=;
        b=j3V/bVvvikNFGVMxAv6SU6tQ9RIIGDsXuM+StWQsWwc3ZbqmsWZ13D7LdUsQMKg3tQw5vVVDctXh7nHaszOPh0rPgDm+fd20iHMofz8Z36GFq/DAo99nNP9uHcdr6Q4N6sRZmpK5Yz44lE7Oh0sLOKsG1w8cBVLKYoqmN4nL5L4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:ee064795-73f4-4e0c-9311-1e50db0e8a47,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:d32419c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e54ff656548411ee8051498923ad61e6-20230916
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <bo.ye@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 313232792; Sat, 16 Sep 2023 19:33:45 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 16 Sep 2023 19:33:44 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 16 Sep 2023 19:33:43 +0800
From:   Bo Ye <bo.ye@mediatek.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <yugang.wang@mediatek.com>, <yongdong.zhang@mediatek.com>,
        <browse.zhang@mediatek.com>, Bo Ye <bo.ye@mediatek.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] Subject: thermal: Fix potential race condition in suspend/resume
Date:   Sat, 16 Sep 2023 19:33:26 +0800
Message-ID: <20230916113327.85693-1-bo.ye@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.682700-8.000000
X-TMASE-MatchedRID: 53RBOU84eqlniBBtNEnVPdsfxZpQv2qMFAr+wPWe7jEmu2XKsBcW8Rwb
        B+iCKX6CIpXyAy0omPBsNi0cjuzvUperG0eDQRp7Bu2zRCSrLjYrHkgIan9a0YrVCk5dmxbq3qM
        rf/AypQVwZC1i9Jj6zoeduB0bUkzgz7wL+9mPXSV1e7Xbb6Im2kyQ5fRSh265GNAPebYwJ/uta8
        DXVXWIqYJi3vP75Z5QBFQhScLIoJe6zsztxuMjKKwxbZnudyr7vJ9Xvh5CmT6bKItl61J/yfJvo
        cwUrWp7MFRQ7RYz5mULbigRnpKlKTpcQTtiHDgWg4zVeOPsni4XPwbj6LWT34wDFrwDUXDgxGGc
        duInXkiBFbtJie1T3EMMprcbiest
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.682700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 24FFF8FE059C8449768942D227F29DF4D6B35F708D3BEFDA6387961263ED06362000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "yugang.wang" <yugang.wang@mediatek.com>

Body:
This patch fixes a race condition during system resume. It occurs if
the system is exiting a suspend state and a user is trying to
register/unregister a thermal zone concurrently. The root cause is
that both actions access the `thermal_tz_list`.

In detail:

1. At PM_POST_SUSPEND during the resume, the system reads all thermal
   zones in `thermal_tz_list`, then resets and updates their
   temperatures.
2. When registering/unregistering a thermal zone, the
   `thermal_tz_list` gets manipulated.

These two actions might occur concurrently, causing a race condition.
To solve this issue, we introduce a mutex lock to protect
`thermal_tz_list` from being modified while it's being read and
updated during the resume from suspend.

Kernel oops excerpt related to this fix:

[ 5201.869845] [T316822] pc: [0xffffffeb7d4876f0] mutex_lock+0x34/0x170
[ 5201.869856] [T316822] lr: [0xffffffeb7ca98a84] thermal_pm_notify+0xd4/0x26c
[... cut for brevity ...]
[ 5201.871061] [T316822]  suspend_prepare+0x150/0x470
[ 5201.871067] [T316822]  enter_state+0x84/0x6f4
[ 5201.871076] [T316822]  state_store+0x15c/0x1e8

Change-Id: Ifdbdecba17093f91eab7e36ce04b46d311ca6568
Signed-off-by: yugang.wang <yugang.wang@mediatek.com>
Signed-off-by: Bo Ye <bo.ye@mediatek.com>
---
 drivers/thermal/thermal_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 8717a3343512..a7a18ed57b6d 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1529,12 +1529,14 @@ static int thermal_pm_notify(struct notifier_block *nb,
 	case PM_POST_HIBERNATION:
 	case PM_POST_RESTORE:
 	case PM_POST_SUSPEND:
+		mutex_lock(&thermal_list_lock);
 		atomic_set(&in_suspend, 0);
 		list_for_each_entry(tz, &thermal_tz_list, node) {
 			thermal_zone_device_init(tz);
 			thermal_zone_device_update(tz,
 						   THERMAL_EVENT_UNSPECIFIED);
 		}
+		mutex_unlock(&thermal_list_lock);
 		break;
 	default:
 		break;
-- 
2.17.0

