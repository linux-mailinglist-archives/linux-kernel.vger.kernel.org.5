Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD6F7B656B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbjJCJYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239610AbjJCJYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:24:03 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6003EAF;
        Tue,  3 Oct 2023 02:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=e04my
        DLFot6od+kDMPF3w8x1jnIuCirLxdNBI1/fCwA=; b=lyhYffMseMjfqahD0EWgc
        2L5Gdnl0IoQy+eekRWuwv8ybpx5V2IMa00PSp8ueV8HjG/3ljkshY77MlPVv1eA8
        8GZtYnCd4bSyFgg51p7oWqQJz5Kga46qzjhxU8lzA2HIQf52sva0ILFg1jpMK+Ya
        l8MQjRQsbvzR94yeQXiq/s=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g3-4 (Coremail) with SMTP id _____wBXOwuU3Rtl0HD2Dg--.40629S4;
        Tue, 03 Oct 2023 17:23:43 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] media: videobuf2: Fix IS_ERR checking in vb2_dc_put_userptr()
Date:   Tue,  3 Oct 2023 17:23:29 +0800
Message-Id: <20231003092329.3919828-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXOwuU3Rtl0HD2Dg--.40629S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWDZw45tFykWFW3trWfGrg_yoW8XrWUpF
        WSyF9IyFWUJrW3uw17Jw4Duay5Ka95XFW0k3y7G3WrCwn8CFyIvryUt34DuryDGrZ2vFn0
        yayjgr13JF4UuFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEeOpJUUUUU=
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFRT9C2B9oWo6RAABse
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid error pointers from frame_vector_pages(), we could
use IS_ERR() to check the return value to fix this. This checking
operation could make sure that vector contains pages.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 .../media/common/videobuf2/videobuf2-dma-contig.c   | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index 2fa455d4a048..5001f2a258dd 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -542,13 +542,14 @@ static void vb2_dc_put_userptr(void *buf_priv)
 		 */
 		dma_unmap_sgtable(buf->dev, sgt, buf->dma_dir,
 				  DMA_ATTR_SKIP_CPU_SYNC);
-		pages = frame_vector_pages(buf->vec);
-		/* sgt should exist only if vector contains pages... */
-		BUG_ON(IS_ERR(pages));
 		if (buf->dma_dir == DMA_FROM_DEVICE ||
-		    buf->dma_dir == DMA_BIDIRECTIONAL)
-			for (i = 0; i < frame_vector_count(buf->vec); i++)
-				set_page_dirty_lock(pages[i]);
+		    buf->dma_dir == DMA_BIDIRECTIONAL){
+			pages = frame_vector_pages(buf->vec);
+			/* sgt should exist only if vector contains pages... */
+			if (!WARN_ON_ONCE(IS_ERR(pages)))
+				for (i = 0; i < frame_vector_count(buf->vec); i++)
+					set_page_dirty_lock(pages[i]);
+		}
 		sg_free_table(sgt);
 		kfree(sgt);
 	} else {
-- 
2.37.2

