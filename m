Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D787AAED6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjIVJyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjIVJyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:54:37 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608E5194;
        Fri, 22 Sep 2023 02:54:24 -0700 (PDT)
X-UUID: fe012622592d11ee8051498923ad61e6-20230922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=7eyIb7lKDJwsdidMLPGj2HCRCGXL1RdAvXGmM4zqz54=;
        b=pB+Sn79w4QP2yxDZ8CHJM9lGFzU146EH+zHhQbdxLi60Zfzdeq3mzjACTncQNKyRwh6HG1vtExLOlF1BdhjaQrrcZDOgI9qJcNb8ES2HTsBdOhutE/PAEweNlf38rdbMTFxx74iHcIGNmIwmF/jLPMhxGEbfxTq/3OW3mYnkUTI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:553c8447-96ab-4b04-a5c4-f9fb10966fb9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:1ac556c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fe012622592d11ee8051498923ad61e6-20230922
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <pablo.sun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1656327549; Fri, 22 Sep 2023 17:54:16 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Sep 2023 17:54:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Sep 2023 17:54:14 +0800
From:   Pablo Sun <pablo.sun@mediatek.com>
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Pablo Sun <pablo.sun@mediatek.com>
Subject: [PATCH v1] mmc: mtk-sd: Use readl_poll_timeout_atomic in msdc_reset_hw
Date:   Fri, 22 Sep 2023 17:53:48 +0800
Message-ID: <20230922095348.22182-1-pablo.sun@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.723900-8.000000
X-TMASE-MatchedRID: 6QBcT7wcRsRvitkUzhYBjXTnOygHVQpO7yWPaQc4INRh2fnHe1cil3o4
        yKeg8X9ygjknrxu7OUiNj7XtNYzGtcEF95g58PMZi/b+LxU2p45Ag1IWH8kbY99RlPzeVuQQ3oz
        JRX7b4NmqPbMuMCi6h4Ay6p60ZV62SwOSQ/fMiOrdB/CxWTRRu3aDLLDbFMGFfUadd7N1arKJeW
        +qZhvjB+0IrX0f+ReSjoE+g/57DJoQkGmQTYDw+jFh8TQbyenjgrCX/PEu4TDrHUK6UmomFyYKa
        1BmIhZZgITnGkK0NFNRskXKHhdfKpij9M86UwHhsKHfMTjCprwNQJGvyiKf6Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.723900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: BA674A7FBD61D5BE8CE30A6057F748C730D889939DCE9B09EAD473DD2F74FB752000:8
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use atomic readl_poll_timeout_atomic, because msdc_reset_hw
may be invoked in IRQ handler in the following context:

  msdc_irq() -> msdc_cmd_done() -> msdc_reset_hw()

The following kernel BUG stack trace can be observed on
Genio 1200 EVK after initializing MSDC1 hardware during kernel boot:

[    1.187441] BUG: scheduling while atomic: swapper/0/0/0x00010002
[    1.189157] Modules linked in:
[    1.204633] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.15.42-mtk+modified #1
[    1.205713] Hardware name: MediaTek Genio 1200 EVK-P1V2-EMMC (DT)
[    1.206484] Call trace:
[    1.206796]  dump_backtrace+0x0/0x1ac
[    1.207266]  show_stack+0x24/0x30
[    1.207692]  dump_stack_lvl+0x68/0x84
[    1.208162]  dump_stack+0x1c/0x38
[    1.208587]  __schedule_bug+0x68/0x80
[    1.209056]  __schedule+0x6ec/0x7c0
[    1.209502]  schedule+0x7c/0x110
[    1.209915]  schedule_hrtimeout_range_clock+0xc4/0x1f0
[    1.210569]  schedule_hrtimeout_range+0x20/0x30
[    1.211148]  usleep_range_state+0x84/0xc0
[    1.211661]  msdc_reset_hw+0xc8/0x1b0
[    1.212134]  msdc_cmd_done.isra.0+0x4ac/0x5f0
[    1.212693]  msdc_irq+0x104/0x2d4
[    1.213121]  __handle_irq_event_percpu+0x68/0x280
[    1.213725]  handle_irq_event+0x70/0x15c
[    1.214230]  handle_fasteoi_irq+0xb0/0x1a4
[    1.214755]  handle_domain_irq+0x6c/0x9c
[    1.215260]  gic_handle_irq+0xc4/0x180
[    1.215741]  call_on_irq_stack+0x2c/0x54
[    1.216245]  do_interrupt_handler+0x5c/0x70
[    1.216782]  el1_interrupt+0x30/0x80
[    1.217242]  el1h_64_irq_handler+0x1c/0x2c
[    1.217769]  el1h_64_irq+0x78/0x7c
[    1.218206]  cpuidle_enter_state+0xc8/0x600
[    1.218744]  cpuidle_enter+0x44/0x5c
[    1.219205]  do_idle+0x224/0x2d0
[    1.219624]  cpu_startup_entry+0x30/0x80
[    1.220129]  rest_init+0x108/0x134
[    1.220568]  arch_call_rest_init+0x1c/0x28
[    1.221094]  start_kernel+0x6c0/0x700
[    1.221564]  __primary_switched+0xc0/0xc8

Fixes: ffaea6ebfe9c ("mmc: mtk-sd: Use readl_poll_timeout instead of open-coded polling")
Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 5392200cfdf7..97f7c3d4be6e 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -669,11 +669,11 @@ static void msdc_reset_hw(struct msdc_host *host)
 	u32 val;
 
 	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_RST);
-	readl_poll_timeout(host->base + MSDC_CFG, val, !(val & MSDC_CFG_RST), 0, 0);
+	readl_poll_timeout_atomic(host->base + MSDC_CFG, val, !(val & MSDC_CFG_RST), 0, 0);
 
 	sdr_set_bits(host->base + MSDC_FIFOCS, MSDC_FIFOCS_CLR);
-	readl_poll_timeout(host->base + MSDC_FIFOCS, val,
-			   !(val & MSDC_FIFOCS_CLR), 0, 0);
+	readl_poll_timeout_atomic(host->base + MSDC_FIFOCS, val,
+				  !(val & MSDC_FIFOCS_CLR), 0, 0);
 
 	val = readl(host->base + MSDC_INT);
 	writel(val, host->base + MSDC_INT);
-- 
2.18.0

