Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEC07E8B3D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 15:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjKKOdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 09:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjKKOdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 09:33:46 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2360330C0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 06:33:39 -0800 (PST)
X-UUID: 3acd5ef20ddb4d659c0118824e4b727b-20231111
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:aa2daf27-020b-44d2-ba81-26b6c03d0361,IP:15,
        URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-INFO: VERSION:1.1.32,REQID:aa2daf27-020b-44d2-ba81-26b6c03d0361,IP:15,UR
        L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-5
X-CID-META: VersionHash:5f78ec9,CLOUDID:fca8f15f-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:231111222744ETFN0OQ7,BulkQuantity:1,Recheck:0,SF:66|38|24|17|19|44|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 3acd5ef20ddb4d659c0118824e4b727b-20231111
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1167861007; Sat, 11 Nov 2023 22:33:27 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     richard@nod.at, Artem.Bityutskiy@nokia.com
Cc:     kunwu.chan@hotmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] ubifs: Remove unreachable code
Date:   Sat, 11 Nov 2023 22:33:14 +0800
Message-Id: <20231111143314.1518314-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because there is no break statement in the dead loop above,it is
impossible to execute the 'err=0' statement.Delete the code that
will never execute and initialize 'err' at the start of the function.

Fixes: 6fb324a4b0c3 ("UBIFS: allocate ltab checking buffer on demand")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 fs/ubifs/lpt_commit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ubifs/lpt_commit.c b/fs/ubifs/lpt_commit.c
index c4d079328b92..d4751628fe70 100644
--- a/fs/ubifs/lpt_commit.c
+++ b/fs/ubifs/lpt_commit.c
@@ -1589,8 +1589,8 @@ static int dbg_is_node_dirty(struct ubifs_info *c, int node_type, int lnum,
  */
 static int dbg_check_ltab_lnum(struct ubifs_info *c, int lnum)
 {
-	int err, len = c->leb_size, dirty = 0, node_type, node_num, node_len;
-	int ret;
+	int len = c->leb_size, dirty = 0, node_type, node_num, node_len;
+	int ret, err = 0;
 	void *buf, *p;
 
 	if (!dbg_is_chk_lprops(c))
@@ -1646,7 +1646,6 @@ static int dbg_check_ltab_lnum(struct ubifs_info *c, int lnum)
 		len -= node_len;
 	}
 
-	err = 0;
 out:
 	vfree(buf);
 	return err;
-- 
2.34.1

