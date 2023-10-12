Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17187C66B8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378092AbjJLHqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347176AbjJLHqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:46:16 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75BB1B7;
        Thu, 12 Oct 2023 00:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qWbjv
        CWf8Co8w4DvJ4AlzsjUwC+Safue0OWpCEcLtK8=; b=fWnV1ncFn19Z/tXYqIq8p
        YWD6OUNuJSF4fwbIijOBfyhwQJvxIxnu6DsAU1XeZX24ByT4dbxlkprDbCYJx1n1
        eHcXd3w5U6/Mce6vly0MdOIF6HGRFcc/qbVrqMySgVCwpfGBXqF0Osuri6cSswSM
        JjPT1JYDOgdD/Ju/tYpuQA=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g4-3 (Coremail) with SMTP id _____wDnz8wQpCdlbUFfAQ--.57375S4;
        Thu, 12 Oct 2023 15:45:29 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: [PATCH v2] media: videobuf2: Fix IS_ERR checking in vb2_dc_put_userptr()
Date:   Thu, 12 Oct 2023 15:45:19 +0800
Message-Id: <20231012074519.597651-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnz8wQpCdlbUFfAQ--.57375S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWDZw45tFykWFW3trWfGrg_yoW8XrWUpF
        WFyF9IyFWUJrW3uwnrtw4Duay5Ka95XFW0k3y7G3Z5Cwn8CFyIvryUt34DWrWDGrZ2vFs0
        yayjqr13JF4UuFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_NtxrUUUUU=
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFQIHC2B9oe1JLgABss
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 2fa455d4a048..3d4fd4ef5310 100644
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
+				buf->dma_dir == DMA_BIDIRECTIONAL) {
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

