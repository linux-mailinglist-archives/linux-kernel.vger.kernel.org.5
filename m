Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDBF7AF8E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjI0D6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjI0D4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:56:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F21272E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:34:46 -0700 (PDT)
X-UUID: cad212ea5ce611ee8051498923ad61e6-20230927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=T/VjjYSP/nPGqaqNizuILOYzcVE0ssqx9zL+nJLUZjQ=;
        b=KUJXGpn+UPKPm1zEdCKI47NctVFEkZIcD46tWk6sGfc9EbEJdvsI/M9cl8bK0q7To3DNcFiY0KQLAEzouv+3COiWzhqcalxwbBcMUIuIg3p+o6Pq6eGJql4Gh4txEdZAxmUaefvzQxteqSiPP10HFg2I6KJBR3MlTJT/3rmtl5k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:95a0f88d-682f-48ad-8bce-ebe80baae5fb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:ad6a6b14-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cad212ea5ce611ee8051498923ad61e6-20230927
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <kuyo.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 503721296; Wed, 27 Sep 2023 11:34:41 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Sep 2023 11:34:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Sep 2023 11:34:37 +0800
From:   Kuyo Chang <kuyo.chang@mediatek.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <wsd_upstream@mediatek.com>, kuyo chang <kuyo.chang@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/1] sched/core: Fix stuck on completion for affine_move_task() when stopper disable
Date:   Wed, 27 Sep 2023 11:34:28 +0800
Message-ID: <20230927033431.12406-1-kuyo.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.864400-8.000000
X-TMASE-MatchedRID: As59EB+03ZJ5vTMZrS1iteEbUg4xvs+wQPCWRE0Lo8IuMQd1pYoA2S7T
        4vtNNpmPhKuaVJ364l1mLZH0kmMDZ1hdPEiZHlm8M8ORI7N4NZbAmOfzKotToi8x1W7rdOBP9BQ
        FWu9qPYa9zsLeDLxbzwszukfLgYhRIg67HHizFeEZXJLztZviXEyQ5fRSh265CqIJhrrDy29ggP
        1j4uH9PN1TeFi3Fi9wgDLqnrRlXrZLA5JD98yI6t0H8LFZNFG71sULACB0qRKy9IyVQRrf1+Lim
        nu7EgSJ3xsiz2kBzNBhrAU2FX2OVDTiLbRo2+mmlExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.864400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9EB54FCE026D70D8BD80CFED08505FB3291A82D5ACCBCBA0DED2477AA3C8A2E32000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kuyo chang <kuyo.chang@mediatek.com>

[Syndrome] hung detect shows below warning msg
[ 4320.666557] [   T56] khungtaskd: [name:hung_task&]INFO: task stressapptest:17803 blocked for more than 3600 seconds.
[ 4320.666589] [   T56] khungtaskd: [name:core&]task:stressapptest   state:D stack:0     pid:17803 ppid:17579  flags:0x04000008
[ 4320.666601] [   T56] khungtaskd: Call trace:
[ 4320.666607] [   T56] khungtaskd:  __switch_to+0x17c/0x338
[ 4320.666642] [   T56] khungtaskd:  __schedule+0x54c/0x8ec
[ 4320.666651] [   T56] khungtaskd:  schedule+0x74/0xd4
[ 4320.666656] [   T56] khungtaskd:  schedule_timeout+0x34/0x108
[ 4320.666672] [   T56] khungtaskd:  do_wait_for_common+0xe0/0x154
[ 4320.666678] [   T56] khungtaskd:  wait_for_completion+0x44/0x58
[ 4320.666681] [   T56] khungtaskd:  __set_cpus_allowed_ptr_locked+0x344/0x730
[ 4320.666702] [   T56] khungtaskd:  __sched_setaffinity+0x118/0x160
[ 4320.666709] [   T56] khungtaskd:  sched_setaffinity+0x10c/0x248
[ 4320.666715] [   T56] khungtaskd:  __arm64_sys_sched_setaffinity+0x15c/0x1c0
[ 4320.666719] [   T56] khungtaskd:  invoke_syscall+0x3c/0xf8
[ 4320.666743] [   T56] khungtaskd:  el0_svc_common+0xb0/0xe8
[ 4320.666749] [   T56] khungtaskd:  do_el0_svc+0x28/0xa8
[ 4320.666755] [   T56] khungtaskd:  el0_svc+0x28/0x9c
[ 4320.666761] [   T56] khungtaskd:  el0t_64_sync_handler+0x7c/0xe4
[ 4320.666766] [   T56] khungtaskd:  el0t_64_sync+0x18c/0x190

[Analysis]

After add some debug footprint massage, this issue happened at stopper
disable case.
It cannot exec migration_cpu_stop fun to complete migration.
This will cause stuck on wait_for_completion.

Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>
---
 kernel/sched/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1dc0b0287e30..98c217a1caa0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3041,8 +3041,9 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		task_rq_unlock(rq, p, rf);
 
 		if (!stop_pending) {
-			stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
-					    &pending->arg, &pending->stop_work);
+			if (!stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
+					    &pending->arg, &pending->stop_work))
+				return -ENOENT;
 		}
 
 		if (flags & SCA_MIGRATE_ENABLE)
-- 
2.18.0

