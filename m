Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7B67AC81B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 14:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjIXMpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 08:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjIXMpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 08:45:39 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A5E3115;
        Sun, 24 Sep 2023 05:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+2Z6h
        zNWL+7AHOQl/szTVZWNb/9TMPRypWtQCppNa4Q=; b=XXlzUobatS3E7yDcYcWPj
        3Rz5JYqeyHEY8g/9dLAs2NaiSKRbsO3YwOxFEfEHWvSvnXbCq0iOnG1Z9NRFY+uM
        T8xqHineiXSguMS5eLDA+q/dR4+g1bH+EARi3V3AfNPgxhcJXbPNj0iyojmEBiRf
        zdfuEctmmJSzkR4iiV7nq0=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g4-3 (Coremail) with SMTP id _____wC3HGMsLxBl7_DWCw--.17004S4;
        Sun, 24 Sep 2023 20:44:42 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] media: videobuf2: Fix IS_ERR checking in vb2_vmalloc_put_userptr()
Date:   Sun, 24 Sep 2023 20:44:25 +0800
Message-Id: <20230924124425.3664024-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3HGMsLxBl7_DWCw--.17004S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1ftw18KrykCry8GrW7Jwb_yoWDJwc_uF
        yDX3Z7uryUWF1rtw1jka1S9ry0y3y8Wrn2gFnYy3s3J34UXa93Zw1qvw1ftF1I9a17A3sF
        vwn8WFyUuF43GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRWHq7JUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbivg70C1Zci1ttGwAAsj
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
 drivers/media/common/videobuf2/videobuf2-vmalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/common/videobuf2/videobuf2-vmalloc.c b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
index 7c635e292106..c37775080aff 100644
--- a/drivers/media/common/videobuf2/videobuf2-vmalloc.c
+++ b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
@@ -134,6 +134,7 @@ static void vb2_vmalloc_put_userptr(void *buf_priv)
 	if (!buf->vec->is_pfns) {
 		n_pages = frame_vector_count(buf->vec);
 		pages = frame_vector_pages(buf->vec);
+		BUG_ON(IS_ERR(pages));
 		if (vaddr)
 			vm_unmap_ram((void *)vaddr, n_pages);
 		if (buf->dma_dir == DMA_FROM_DEVICE ||
-- 
2.37.2

