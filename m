Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5074C8079C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442836AbjLFUsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjLFUsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:48:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AD7C7;
        Wed,  6 Dec 2023 12:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=aBy9F9kxxPHfX2iwr4WNWrmiHbFVf5OKMgUWN/MZxMY=; b=4ed1oWJhWhoKn3jb19vkRj5F9+
        5efmRwI3yxoAVQ0Z8U+/WE4hZLU2MEdBaI4R4U+Zmkffa7Pnc/9vUx0ii5SODjr5XlIkaAgtRQvbI
        XT6uRlbB4yENkrokgg8fJkZVKjvxh0684zgOV7jJCCg4OD1gRrrQQTKWYQvuOtvUuef+jcB+LFDT9
        px5ypJl1X3kV2BFc3doN0Po5bcSvGhV0tqySqFcyXb8x4lDwg5BHW8fhtFjDmDe77GcRGSfb/b4Xq
        aF0panlrkikQ/tqWia1/j4dKF27w8Z8bA+fPamWrZpoOxTSYoxXt9ZQJPB4DbjRPUlzyBbuvzOTCO
        h3gjnICg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAyov-00BFMR-0d;
        Wed, 06 Dec 2023 20:48:37 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: chips-media: wave5: requires GENERIC_ALLOCATOR
Date:   Wed,  6 Dec 2023 12:48:36 -0800
Message-ID: <20231206204836.27932-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver uses the API that is provided by GENERIC_ALLOCATOR API, so
select it to prevent build errors:

riscv32-linux-ld: drivers/media/platform/chips-media/wave5/wave5-vpu.o: in function `.L37':
wave5-vpu.c:(.text+0x468): undefined reference to `of_gen_pool_get'
riscv32-linux-ld: drivers/media/platform/chips-media/wave5/wave5-vdi.o: in function `.L116':
wave5-vdi.c:(.text+0xaac): undefined reference to `gen_pool_dma_alloc'
riscv32-linux-ld: drivers/media/platform/chips-media/wave5/wave5-vdi.o: in function `wave5_vdi_free_sram':
wave5-vdi.c:(.text+0xb60): undefined reference to `gen_pool_free_owner'

Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Nas Chung <nas.chung@chipsnmedia.com>
Cc: Jackson Lee <jackson.lee@chipsnmedia.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
---
 drivers/media/platform/chips-media/wave5/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/media/platform/chips-media/wave5/Kconfig b/drivers/media/platform/chips-media/wave5/Kconfig
--- a/drivers/media/platform/chips-media/wave5/Kconfig
+++ b/drivers/media/platform/chips-media/wave5/Kconfig
@@ -6,6 +6,7 @@ config VIDEO_WAVE_VPU
 	select VIDEOBUF2_DMA_CONTIG
 	select VIDEOBUF2_VMALLOC
 	select V4L2_MEM2MEM_DEV
+	select GENERIC_ALLOCATOR
 	help
 	  Chips&Media stateful encoder and decoder driver.
 	  The driver supports HEVC and H264 formats.
