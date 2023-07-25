Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13D2760F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjGYJhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjGYJgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:36:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60BF2D77;
        Tue, 25 Jul 2023 02:35:37 -0700 (PDT)
X-UUID: 96bb7fa42ace11eeb20a276fd37b9834-20230725
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8C8olInZ2U2OjphX9pSmDTmiExKe1b/NUHKYXQxINTw=;
        b=e9a7c3J8ZMyiZv87hpnff3+7M2HOoIlM11mOshOBFtJmgYgMhvPjacktFlca995qYwFNtRn4JYMdUJMLBQjLVFphaW0/PwEpa3GdIhaBHJ+ZRSD7Xg0wD4bLCyNNS6SoUY/Bl44cHB8R9uPPEDIfLzu9U3D5pyIwJgeOm88aPeQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:82867447-0cbd-4259-ab88-f47d35880812,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:1,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-META: VersionHash:e7562a7,CLOUDID:ed234dd2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 96bb7fa42ace11eeb20a276fd37b9834-20230725
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1502966521; Tue, 25 Jul 2023 17:35:27 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 25 Jul 2023 17:35:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 25 Jul 2023 17:35:26 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <chinwen.chang@mediatek.com>, <qun-wei.lin@mediatek.com>,
        <linux-mm@kvack.org>, <linux-modules@vger.kernel.org>,
        <casper.li@mediatek.com>, <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/8] scripts/gdb/modules: add get module text support
Date:   Tue, 25 Jul 2023 17:34:52 +0800
Message-ID: <20230725093458.30064-3-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230725093458.30064-1-Kuan-Ying.Lee@mediatek.com>
References: <20230725093458.30064-1-Kuan-Ying.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we get an text address from coredump and we cannot find
this address in vmlinux, it might located in kernel module.

We want to know which kernel module it located in.

This GDB scripts can help us to find the target kernel module.

(gdb) lx-getmod-by-textaddr 0xffff800002d305ac
0xffff800002d305ac is in kasan_test.ko

Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 scripts/gdb/linux/modules.py | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/modules.py b/scripts/gdb/linux/modules.py
index 261f28640f4c..54bb7fcad41d 100644
--- a/scripts/gdb/linux/modules.py
+++ b/scripts/gdb/linux/modules.py
@@ -91,5 +91,35 @@ class LxLsmod(gdb.Command):
 
             gdb.write("\n")
 
-
 LxLsmod()
+
+def help():
+    t = """Usage: lx-getmod-by-textaddr [Heximal Address]
+    Example: lx-getmod-by-textaddr 0xffff800002d305ac\n"""
+    gdb.write("Unrecognized command\n")
+    raise gdb.GdbError(t)
+
+class LxFindTextAddrinMod(gdb.Command):
+    '''Look up loaded kernel module by text address.'''
+
+    def __init__(self):
+        super(LxFindTextAddrinMod, self).__init__('lx-getmod-by-textaddr', gdb.COMMAND_SUPPORT)
+
+    def invoke(self, arg, from_tty):
+        args = gdb.string_to_argv(arg)
+
+        if len(args) != 1:
+            help()
+
+        addr = gdb.Value(int(args[0], 16)).cast(utils.get_ulong_type())
+        for mod in module_list():
+            mod_text_start = mod['mem'][constants.LX_MOD_TEXT]['base']
+            mod_text_end = mod_text_start + mod['mem'][constants.LX_MOD_TEXT]['size'].cast(utils.get_ulong_type())
+
+            if addr >= mod_text_start and addr < mod_text_end:
+                s = "0x%x" % addr + " is in " + mod['name'].string() + ".ko\n"
+                gdb.write(s)
+                return
+        gdb.write("0x%x is not in any module text section\n" % addr)
+
+LxFindTextAddrinMod()
-- 
2.18.0

