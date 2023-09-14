Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7307179FDD9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbjINIIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjINIIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:08:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57AF9B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:08:41 -0700 (PDT)
X-UUID: e7bd0d1252d511eea33bb35ae8d461a2-20230914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=mlOEeXuSL3Jd9KWoAGMasqY7uUX1ru96a24IVEsPgXk=;
        b=nbN5kH2ZHeBSmRDbusxGl/9eZ7H7OM8VxEjN4Ceca7hkyiE0CFGeQkeuunWg5eIxbwkPkmeufwzTexRgUinXlwQ7jnxFzPWvyYuJLwqC/Lu3A8Lec/y8ZBCSLi0HkNR5XSRzUt5nmpMC2GJwBAABc2a32vq8tNsraXzIPxgHiVg=;
X-CID-CACHE: Type:Local,Time:202309141550+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:e318bec8-4d6f-4264-ad9c-b8bfbcc41368,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:228104c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: e7bd0d1252d511eea33bb35ae8d461a2-20230914
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1145535570; Thu, 14 Sep 2023 16:08:36 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Sep 2023 16:08:35 +0800
Received: from mszsdtlt101.gcn.mediatek.inc (10.16.4.141) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Sep 2023 16:08:34 +0800
From:   Haibo Li <haibo.li@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <xiaoming.yu@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Haibo Li <haibo.li@mediatek.com>
Subject: [PATCH] kasan:fix access invalid shadow address when input is illegal
Date:   Thu, 14 Sep 2023 16:08:33 +0800
Message-ID: <20230914080833.50026-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when the input address is illegal,the corresponding shadow address
from kasan_mem_to_shadow may have no mapping in mmu table.
Access such shadow address causes kernel oops.
Here is a sample about oops on arm64(VA 39bit) with KASAN_SW_TAGS on:

[ffffffb80aaaaaaa] pgd=000000005d3ce003, p4d=000000005d3ce003,
    pud=000000005d3ce003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 3 PID: 100 Comm: sh Not tainted 6.6.0-rc1-dirty #43
Hardware name: linux,dummy-virt (DT)
pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __hwasan_load8_noabort+0x5c/0x90
lr : do_ib_ob+0xf4/0x110
ffffffb80aaaaaaa is the shadow address for efffff80aaaaaaaa.
The problem is reading invalid shadow in kasan_check_range.

The generic kasan also has similar oops.

To fix it,check shadow address by reading it with no fault.

After this patch,KASAN is able to report invalid memory access
for this case.

Signed-off-by: Haibo Li <haibo.li@mediatek.com>
---
 mm/kasan/kasan.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index f70e3d7a602e..bd30f35e18b2 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -304,8 +304,17 @@ static __always_inline bool addr_has_metadata(const void *addr)
 #ifdef __HAVE_ARCH_SHADOW_MAP
 	return (kasan_mem_to_shadow((void *)addr) != NULL);
 #else
-	return (kasan_reset_tag(addr) >=
-		kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
+	u8 *shadow, shadow_val;
+
+	if (kasan_reset_tag(addr) <
+		kasan_shadow_to_mem((void *)KASAN_SHADOW_START))
+		return false;
+	/* use read with nofault to check whether the shadow is accessible */
+	shadow = kasan_mem_to_shadow((void *)addr);
+	__get_kernel_nofault(&shadow_val, shadow, u8, fault);
+	return true;
+fault:
+	return false;
 #endif
 }
 
-- 
2.25.1

