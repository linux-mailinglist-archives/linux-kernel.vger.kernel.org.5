Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588467D654F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjJYIhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjJYIhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:37:22 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBCB138
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:37:16 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:7faa:e55:54a:cff])
        by xavier.telenet-ops.be with bizsmtp
        id 28dD2B00A5Uc89d018dDsl; Wed, 25 Oct 2023 10:37:14 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qvZNy-007T6G-56;
        Wed, 25 Oct 2023 10:37:13 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qvZO5-00BsgW-0A;
        Wed, 25 Oct 2023 10:37:13 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] media: nuvoton: VIDEO_NPCM_VCD_ECE should depend on ARCH_NPCM
Date:   Wed, 25 Oct 2023 10:37:11 +0200
Message-Id: <f96a26f520d60db61105742b0ab3f8e853a2d570.1698222908.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Nuvoton NPCM Video Capture/Differentiation Engine (VCD) and Encoding
Compression Engine (ECE) are only present on Nuvoton NPCM SoCs.  Hence
add a dependency on ARCH_NPCM, to prevent asking the user about these
drivers when configuring a kernel without  Nuvoton NPCM Architecture
support.

Fixes: 46c15a4ff1f4fe07 ("media: nuvoton: Add driver for NPCM video capture and encoding engine")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/media/platform/nuvoton/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/nuvoton/Kconfig b/drivers/media/platform/nuvoton/Kconfig
index 919d3166756c9d69..40b36d1be8dc3d36 100644
--- a/drivers/media/platform/nuvoton/Kconfig
+++ b/drivers/media/platform/nuvoton/Kconfig
@@ -4,8 +4,8 @@ comment "Nuvoton media platform drivers"
 
 config VIDEO_NPCM_VCD_ECE
 	tristate "Nuvoton NPCM Video Capture/Encode Engine driver"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_DEV
+	depends on V4L_PLATFORM_DRIVERS && VIDEO_DEV
+	depends on ARCH_NPCM || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
 	help
 	  Support for the Video Capture/Differentiation Engine (VCD) and
-- 
2.34.1

