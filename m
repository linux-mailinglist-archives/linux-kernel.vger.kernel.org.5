Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2265D80A4B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573842AbjLHNsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573831AbjLHNsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:48:50 -0500
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DFE1995;
        Fri,  8 Dec 2023 05:48:55 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by helios.alatek.com.pl (Postfix) with ESMTP id C09D92D00F4D;
        Fri,  8 Dec 2023 14:48:52 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 9n85sZtZLwIn; Fri,  8 Dec 2023 14:48:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by helios.alatek.com.pl (Postfix) with ESMTP id 803642D00F4C;
        Fri,  8 Dec 2023 14:48:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 803642D00F4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
        s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1702043328;
        bh=+VrUs53iMXBZp4C7bjp6gDelybgLg3+ZHMDAxXckBJs=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=MYardXXqLKxjfVOaKoQBrfRPdwTUXWmWyzaSnUDJugfH8YrzKCNefTsTAD9Jv+oEF
         9EVTE9HTbOIw8vCzNpbGpaOJCG0eFp2M2CdaSAV0eNwzTlQmuLnMuNJcpfY70pX3/7
         Ay+Wp/kBTbJI2PpyXqSmcMYoDjx6WBFCvuGfsxhU9rgeujtCyGxjr8wKSBXbkJtizx
         OrVne/bn3VeVUJCumU3HOZue+YaU6/fhb9N/BANMm6sYBP5eoQxNsKdZxKg4brkI1s
         TOshiGnfClOP1Nk3YhNXsSLDSNJOV+gHFfgGdN5Ns3XCHgpXwz5+GJIWuZIhmFX3hK
         rKeMju6+kauRw==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id cK0tzk6p_mU6; Fri,  8 Dec 2023 14:48:48 +0100 (CET)
Received: from localhost.localdomain (unknown [10.125.125.6])
        by helios.alatek.com.pl (Postfix) with ESMTPSA id E35882D00F4A;
        Fri,  8 Dec 2023 14:48:47 +0100 (CET)
From:   Jan Kuliga <jankul@alatek.krakow.pl>
To:     lizhi.hou@amd.com, brian.xu@amd.com, raj.kumar.rampelli@amd.com,
        vkoul@kernel.org, michal.simek@amd.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com
Cc:     jankul@alatek.krakow.pl
Subject: [PATCH v4 0/8] Miscellaneous xdma driver enhancements
Date:   Fri,  8 Dec 2023 14:48:38 +0100
Message-Id: <20231208134838.49500-1-jankul@alatek.krakow.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset introduces a couple of xdma driver enhancements. The most
important change is the introduction of interleaved DMA transfers
feature, which is a big deal, as it allows DMAEngine clients to express
DMA transfers in an arbitrary way. This is extremely useful in FPGA
environments, where in one FPGA system there may be a need to do DMA both
to/from FIFO at a fixed address and to/from a (non)contiguous RAM.

It is a another reroll of my previous patch series [1], but it is heavily
modified one as it is based on Miquel's patchset [2]. We agreed on doing
it that way, as both our patchsets touched the very same piece of code.
The discussion took place under [2] thread.

I tested it with XDMA v4.1 (Rev.20) IP core, with both sg and
interleaved DMA transfers.

Jan

Changes since v1:
[PATCH 1/5]:=20
Complete a terminated descriptor with dma_cookie_complete()
Don't reinitialize temporary list head in xdma_terminate_all()=20
[PATCH 4/5]:
Fix incorrect text wrapping

Changes since v2:
[PATCH 1/5]:
DO NOT schedule callback from within xdma_terminate_all()

Changes since v3:
Base patchset on Miquel's [2] series
Reorganize commits` structure
Introduce interleaved DMA transfers feature
Implement transfer error reporting

[1]:
https://lore.kernel.org/dmaengine/20231124192524.134989-1-jankul@alatek.k=
rakow.pl/T/#t

[2]:
https://lore.kernel.org/dmaengine/20231130111315.729430-1-miquel.raynal@b=
ootlin.com/T/#t

---
Jan Kuliga (8):
  dmaengine: xilinx: xdma: Get rid of unused code
  dmaengine: xilinx: xdma: Add necessary macro definitions
  dmaengine: xilinx: xdma: Ease dma_pool alignment requirements
  dmaengine: xilinx: xdma: Rework xdma_terminate_all()
  dmaengine: xilinx: xdma: Add error checking in xdma_channel_isr()
  dmaengine: xilinx: xdma: Add transfer error reporting
  dmaengine: xilinx: xdma: Prepare the introduction of interleaved DMA
    transfers
  dmaengine: xilinx: xdma: Introduce interleaved DMA transfers

 drivers/dma/xilinx/xdma-regs.h |  30 ++--
 drivers/dma/xilinx/xdma.c      | 285 ++++++++++++++++++++++-----------
 2 files changed, 210 insertions(+), 105 deletions(-)

--=20
2.34.1

