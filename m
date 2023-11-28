Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4667FB353
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343919AbjK1Hzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343933AbjK1Hzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:55:42 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F72399
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:55:42 -0800 (PST)
X-UUID: 839542ea8dc311ee8051498923ad61e6-20231128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=EIqL2tD5DZPZv4cReb9xm7HmNydPz9ibyBpjJNHePvQ=;
        b=isnw1ekp5u0CfZw4wekAgZfg5/+Tcbno+jOSORjqH6t/7Sv8iE8ciyHQEWM08Q4p0RJpZy/5FSuyJByQOdubPFR2vH1ZbzRPGcnQyA5lF49+3mcwewgPGnIhQ5zKcTwE45Ar4MZTCZB1/XHjhFcNZngWBv+fbnfbWzlsmHYjN6A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:4a3aa1d3-ec6a-4d77-8b8f-f09482cef926,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:5ca19060-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 839542ea8dc311ee8051498923ad61e6-20231128
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 877891212; Tue, 28 Nov 2023 15:55:36 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 28 Nov 2023 15:55:34 +0800
Received: from mszsdtlt102.gcn.mediatek.inc (10.16.4.142) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 28 Nov 2023 15:55:34 +0800
From:   Haibo Li <haibo.li@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <xiaoming.yu@mediatek.com>,
        Haibo Li <haibo.li@mediatek.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] fix comparison of unsigned expression < 0
Date:   Tue, 28 Nov 2023 15:55:32 +0800
Message-ID: <20231128075532.110251-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.749500-8.000000
X-TMASE-MatchedRID: iv01+ZwXeFIryFHbNnBLG0Zakoam9+aebT2gc93yznn9Ez/5IpHqp8lm
        7UT8OKjb009cKtuMq44lKzzhiO1jPncna+FgAjo0nVTWWiNp+v/jxSCk4x2AYd9RlPzeVuQQObA
        90TJq6C8/ApdYBbUVKYAy6p60ZV621gi3JUE8ePKSkBrqwsq4PfoLR4+zsDTttrrTuahHzlFU1G
        84il7EfntKKivhCrlfE0eoKE0hYr807dg5hv5gH9S5x4PKrQ/8rxK9BaJJfxtRJt1IVZ02lKixa
        UIRQLoOAGAn9m+WxPvyNp7g4PXe0BXsxz6ujBxUq1f8XSkHBUmNJXmEMVvLtpRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.749500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 181391F854EACAAB2F00F5A6344B770795AAFA39D774CB1EEFDEC7134135C8032000:8
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RDNS_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot reported:

'''
mm/kasan/report.c:637 kasan_non_canonical_hook() warn:
unsigned 'addr' is never less than zero.
'''
The KASAN_SHADOW_OFFSET is 0 on loongarch64.

To fix it,check the KASAN_SHADOW_OFFSET before do comparison.

Signed-off-by: Haibo Li <haibo.li@mediatek.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/
  202311270743.3oTCwYPd-lkp@intel.com/
---
 mm/kasan/report.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index e77facb62900..dafec2df0268 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -634,10 +634,10 @@ void kasan_non_canonical_hook(unsigned long addr)
 {
 	unsigned long orig_addr;
 	const char *bug_type;
-
+#if KASAN_SHADOW_OFFSET > 0
 	if (addr < KASAN_SHADOW_OFFSET)
 		return;
-
+#endif
 	orig_addr = (addr - KASAN_SHADOW_OFFSET) << KASAN_SHADOW_SCALE_SHIFT;
 	/*
 	 * For faults near the shadow address for NULL, we can be fairly certain
-- 
2.18.0

