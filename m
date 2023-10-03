Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BEB7B652D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjJCJN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjJCJN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:13:56 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DAAEAD;
        Tue,  3 Oct 2023 02:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=aB39z
        3nEFhlQiheQaPa4Ujx4EJgUHKZv82T0iigXc/4=; b=m3rAuWNM23ugb+YjbCMIK
        P0Qr3/8b5b338lExi0XTsAa1JImayRTTC1VW/umLAU1GarBnshOfgIrzxEWSn2/W
        MHzwaSUmT2qbXxAgekGDzNM5RBJGeL3OUxPf/xNo8lvksbaCls/2MAGZSlHDJ2qc
        vzT2ejnTGaitO5rdlB1cEc=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wCnGDMt2xtlDF8gDw--.40780S4;
        Tue, 03 Oct 2023 17:13:28 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: [PATCH v2] media: videobuf2: Fix IS_ERR checking in vb2_vmalloc_put_userptr()
Date:   Tue,  3 Oct 2023 17:13:15 +0800
Message-Id: <20231003091315.3919528-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCnGDMt2xtlDF8gDw--.40780S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWDZw45tFykWFW3trWfGrg_yoW8Gr1DpF
        WFyF9IyFW5J347uw17Jws7uay5Ka95WrW0k3y7Ww1F9wn5Gr9agFyqq34kur17CFZ2yFs0
        yayjqw43JF1xurUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_NtxrUUUUU=
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbiyBr9C1p7L-EpmgAAso
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 drivers/media/common/videobuf2/videobuf2-vmalloc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-vmalloc.c b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
index 7c635e292106..5aa66305546d 100644
--- a/drivers/media/common/videobuf2/videobuf2-vmalloc.c
+++ b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
@@ -133,13 +133,15 @@ static void vb2_vmalloc_put_userptr(void *buf_priv)
 
 	if (!buf->vec->is_pfns) {
 		n_pages = frame_vector_count(buf->vec);
-		pages = frame_vector_pages(buf->vec);
 		if (vaddr)
 			vm_unmap_ram((void *)vaddr, n_pages);
 		if (buf->dma_dir == DMA_FROM_DEVICE ||
-		    buf->dma_dir == DMA_BIDIRECTIONAL)
-			for (i = 0; i < n_pages; i++)
-				set_page_dirty_lock(pages[i]);
+		    buf->dma_dir == DMA_BIDIRECTIONAL){
+			pages = frame_vector_pages(buf->vec);
+			if (!WARN_ON_ONCE(IS_ERR(pages)))
+				for (i = 0; i < n_pages; i++)
+					set_page_dirty_lock(pages[i]);
+		}
 	} else {
 		iounmap((__force void __iomem *)buf->vaddr);
 	}
-- 
2.37.2

