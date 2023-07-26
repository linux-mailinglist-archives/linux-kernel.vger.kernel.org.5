Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D003762B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjGZG3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGZG3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:29:17 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F68BF;
        Tue, 25 Jul 2023 23:29:15 -0700 (PDT)
X-UUID: 298248b7ac0046aba6541fdef59d3975-20230726
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:31363ec0-5fda-4b34-ba66-addfbed97a15,IP:25,
        URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:28
X-CID-INFO: VERSION:1.1.28,REQID:31363ec0-5fda-4b34-ba66-addfbed97a15,IP:25,UR
        L:0,TC:0,Content:-5,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_HamU,ACTION
        :release,TS:28
X-CID-META: VersionHash:176cd25,CLOUDID:effeccb3-a467-4aa9-9e04-f584452e3794,B
        ulkID:23072614290472T5GNHT,BulkQuantity:0,Recheck:0,SF:24|16|19|44|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 298248b7ac0046aba6541fdef59d3975-20230726
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(39.156.73.12)] by mailgw
        (envelope-from <zhaochenguang@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
        with ESMTP id 1987773905; Wed, 26 Jul 2023 14:29:04 +0800
From:   zhaochenguang <zhaochenguang@kylinos.cn>
To:     chenhuacai@kernel.org
Cc:     kernel@xen0n.name, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        zhaochenguang@kylinos.cn
Subject: [PATCH] LoongArch: eBPF: Restrict bpf_probe_read{, str}() only to archs where they work
Date:   Wed, 26 Jul 2023 14:29:02 +0800
Message-Id: <20230726062902.566312-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we run nettrace on LoongArch, there is a problem that
ERROR: failed to load kprobe-based eBPF
ERROR: failed to load kprobe-based bpf

Because ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE dose not exist,
so we enable it.

The patch reference upstream id 0ebeea8ca8a4d1d453ad299aef0507dab04f6e8d.

Signed-off-by: zhaochenguang <zhaochenguang@kylinos.cn>
---
 arch/loongarch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 903096bd87f8..4a156875e9cc 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -11,6 +11,7 @@ config LOONGARCH
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION
 	select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
-- 
2.25.1

