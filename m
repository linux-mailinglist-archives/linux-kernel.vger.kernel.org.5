Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FB07644D4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjG0EVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjG0EVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:21:44 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA4B270D;
        Wed, 26 Jul 2023 21:21:42 -0700 (PDT)
X-UUID: c4e8c336545c474ea839337dc23b5787-20230727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:850f6a67-5831-4174-8832-648d3776833c,IP:15,
        URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-INFO: VERSION:1.1.28,REQID:850f6a67-5831-4174-8832-648d3776833c,IP:15,UR
        L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:5
X-CID-META: VersionHash:176cd25,CLOUDID:a66a8142-d291-4e62-b539-43d7d78362ba,B
        ulkID:230727122127Z5FPABKC,BulkQuantity:0,Recheck:0,SF:44|24|17|19|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: c4e8c336545c474ea839337dc23b5787-20230727
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(39.156.73.12)] by mailgw
        (envelope-from <zhaochenguang@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
        with ESMTP id 1520879759; Thu, 27 Jul 2023 12:21:26 +0800
From:   Chenguang Zhao <zhaochenguang@kylinos.cn>
To:     chenhuacai@kernel.org
Cc:     kernel@xen0n.name, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        zhaochenguang@kylinos.cn
Subject: [PATCH v2] LoongArch/bpf: Enable bpf_probe_read{, str}() on LoongArch
Date:   Thu, 27 Jul 2023 12:21:25 +0800
Message-Id: <20230727042125.884988-1-zhaochenguang@kylinos.cn>
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

Currently nettrace does not work on LoongArch due to missing
bpf_probe_read{,str}() support, with the error message:

     ERROR: failed to load kprobe-based eBPF
     ERROR: failed to load kprobe-based bpf

According to commit 0ebeea8ca8a4d ("bpf: Restrict bpf_probe_read{,
str}() only to archs where they work"), we only need to select
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE to add said support,
because LoongArch does have non-overlapping address ranges for kernel
and userspace.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
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

