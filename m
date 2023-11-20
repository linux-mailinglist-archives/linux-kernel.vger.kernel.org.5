Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9487F0A95
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 03:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjKTCkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 21:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjKTCkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 21:40:09 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48204115;
        Sun, 19 Nov 2023 18:40:04 -0800 (PST)
X-UUID: 39d7d5fb5edc46168faf7ff080bd8aac-20231120
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:8135b8e8-d3b6-4fe3-9943-462edf7b4002,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-15
X-CID-INFO: VERSION:1.1.32,REQID:8135b8e8-d3b6-4fe3-9943-462edf7b4002,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-15
X-CID-META: VersionHash:5f78ec9,CLOUDID:9ccfd572-1bd3-4f48-b671-ada88705968c,B
        ulkID:231120103957OR2B7NMK,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 39d7d5fb5edc46168faf7ff080bd8aac-20231120
X-User: zhouzongmin@kylinos.cn
Received: from thinkpadx13gen2i.. [(116.128.244.169)] by mailgw
        (envelope-from <zhouzongmin@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1341798825; Mon, 20 Nov 2023 10:39:54 +0800
From:   Zongmin Zhou <zhouzongmin@kylinos.cn>
To:     linkinjeon@kernel.org, sfrench@samba.org
Cc:     senozhatsky@chromium.org, tom@talpey.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH] ksmbd: initialize ar to NULL
Date:   Mon, 20 Nov 2023 10:39:50 +0800
Message-Id: <20231120023950.667246-1-zhouzongmin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
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

Initialize ar to NULL to avoid the case of aux_size will be false,
and kfree(ar) without ar been initialized will be unsafe.
But kfree(NULL) is safe.

Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/smb/server/ksmbd_work.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/ksmbd_work.c b/fs/smb/server/ksmbd_work.c
index 44bce4c56daf..2510b9f3c8c1 100644
--- a/fs/smb/server/ksmbd_work.c
+++ b/fs/smb/server/ksmbd_work.c
@@ -106,7 +106,7 @@ static inline void __ksmbd_iov_pin(struct ksmbd_work *work, void *ib,
 static int __ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len,
 			       void *aux_buf, unsigned int aux_size)
 {
-	struct aux_read *ar;
+	struct aux_read *ar = NULL;
 	int need_iov_cnt = 1;
 
 	if (aux_size) {
-- 
2.34.1

