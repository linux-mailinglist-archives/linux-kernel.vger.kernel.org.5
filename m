Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCBD7F5321
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjKVWOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbjKVWOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:14:42 -0500
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7B4AD;
        Wed, 22 Nov 2023 14:14:38 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by helios.alatek.com.pl (Postfix) with ESMTP id 3C4812D00B5B;
        Wed, 22 Nov 2023 23:08:50 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Npj0OrRRbQ5m; Wed, 22 Nov 2023 23:08:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by helios.alatek.com.pl (Postfix) with ESMTP id BEA1B2D00B5A;
        Wed, 22 Nov 2023 23:08:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl BEA1B2D00B5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
        s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1700690929;
        bh=PTa268/JX+mlRh2pftJ7srsiSRZlKXzy21FlzLAe5Bs=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=YNW+agj/fsLXUNs8xM0/H5ifHDFwktw8wkaao56kuymnufHKcZyKgKJC+MspTCSDG
         4OShWE8s8QJBSCBFxJgoaxid/HPMyc+9vob4Q/X/N1m186AFBl/n6DNI2SbMDOGauD
         4yMklW9I5usHXdMmezlei0sBlnmqFH5g7r5dFiM0xVk9f/E7jmirY1rp9Qrw/kamZn
         Uc4PzP+7ozfPx/jsZa9wYn6eSI+WrzwvEiP3uWuwR7yXuUJoNvALEDGRWTTZTs56v3
         c/ldIqLOp6Vw1rp2/Nx/pG9joyVjEqOpibKqzbf+SUflJgOBGIjqmN2f2NaExyl2I4
         CQpkjv5dyy5VA==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id vJcjfbOJKJxQ; Wed, 22 Nov 2023 23:08:49 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
        by helios.alatek.com.pl (Postfix) with ESMTPSA id 82D562D00B50;
        Wed, 22 Nov 2023 23:08:49 +0100 (CET)
From:   Jan Kuliga <jankul@alatek.krakow.pl>
To:     lizhi.hou@amd.com, brian.xu@amd.com, raj.kumar.rampelli@amd.com,
        vkoul@kernel.org, michal.simek@amd.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jan Kuliga <jankul@alatek.krakow.pl>
Subject: [PATCH 0/5] Miscellaneous xdma driver enhancements
Date:   Wed, 22 Nov 2023 23:08:30 +0100
Message-Id: <20231122220830.117403-1-jankul@alatek.krakow.pl>
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

This patch series introduces a couple of xdma driver enhancements, such
as two dmaengine callbacks, partial rework of a interrupt service
routine and loosening of dma_pool alignment requirements. I have tested
these changes with XDMA v4.1 (Rev. 20) block.

Jan
---
Jan Kuliga (5):
  dmaengine: xilinx: xdma: Add transfer termination callbacks
  dmaengine: xilinx: xdma: Get rid of duplicated macros definitions
  dmaengine: xilinx: xdma: Complete lacking register description
  dmaengine: xilinx: xdma: Rework xdma_channel_isr()
  dmaengine: xilinx: xdma: Ease dma_pool alignment requirements

 drivers/dma/xilinx/xdma-regs.h | 24 ++++-------
 drivers/dma/xilinx/xdma.c      | 78 +++++++++++++++++++++++++++++-----
 2 files changed, 76 insertions(+), 26 deletions(-)


base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
--=20
2.34.1

