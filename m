Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C10F7B3470
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjI2ONS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjI2ONQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:13:16 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEA91AC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:13:11 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4054f790190so132448435e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695996789; x=1696601589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uo4m8TJwh5ppVOXwkoM0SRHlHtGCNDCaW2WabCnIhNc=;
        b=R68uuOG5GMCjK3EA489VkOEKmJIH+4Ij5u+s2p+0vvc79M1JDbwneDbCj6l9303XG8
         47ijBMu5UleXzehgABt1QS0VbnV899DnUcQq8nYiLSNw2ZPnv512N8Hy5XpO+uTCp10r
         iqy91XtNpBetHiCxzUZO+TqtdUzyFNNwgS28veS50enGskyP7tbTxmyCkVCNG4HnpPrh
         Man2pl5MnHvTQsdg94PhfSr1w/e7W0V2zz1gKOp7rb9Zxb/eJelMAEa0WLuwsSOmKOpj
         j40LFu5saQksZQLuR9HogD+UcH6p2cg2eP6wjQEnpGCH4tppom7EAdd50c04ijT65Zgg
         hzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695996789; x=1696601589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uo4m8TJwh5ppVOXwkoM0SRHlHtGCNDCaW2WabCnIhNc=;
        b=jNr9VXsEoYacCXFIrwsYOU34bOmu5S4BcDmNz2UgbTYU+54flzluZ+edAdvRap4+AY
         oyfwWzf/tG6YUG1OG0KXpCgHjH8YaRazCJJLaQmEh605cJa4jO1yeCfBjeD4ofobzH3U
         CkPawzDbihfo/6jm2ZytnMeKwRzf8/5AiQdsQP4ZpiTZwZIWEQ2YrMU6tCN2P0nw+bC5
         NEiPsNrvExTgvK0/wgocbvhwxi0b3SD4agq3U50SpjGUInEJixoaJe1d2FIxPO9TygWY
         4jqcKTkP3WxWmnI3L3vCd2Jj3pTWq4T+0LLPvuaVnyO3amHP01IpYzaS4kwwSdaSf+8j
         I+LQ==
X-Gm-Message-State: AOJu0Yzio+jVd0xXzh4kXXYPqRwkGEHD3q3KVElZDAsbGZmmTc1VqEpe
        sybmVdHxanzYzEOHoqqoBzb0Kg==
X-Google-Smtp-Source: AGHT+IErjEd6QXcPqrlM0UsBPLaodnfJsl+IWDeP3dNmLlVnSlLB9EizKVj/nZfotxE6Wo79GdrX3g==
X-Received: by 2002:a1c:4b13:0:b0:405:3dee:3515 with SMTP id y19-20020a1c4b13000000b004053dee3515mr4077408wma.27.1695996789350;
        Fri, 29 Sep 2023 07:13:09 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:dbda:9cd9:39cc:f174])
        by smtp.gmail.com with ESMTPSA id t25-20020a7bc3d9000000b00405391f485fsm1513068wmj.41.2023.09.29.07.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:13:08 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>, Judith Mendez <jm@ti.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v6 00/14] can: m_can: Optimizations for m_can/tcan part 2
Date:   Fri, 29 Sep 2023 16:12:50 +0200
Message-Id: <20230929141304.3934380-1-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, Simon, Martin and everyone,

v6 is a rebase on v6.6. As there was a conflicting change merged for
v6.6 which introduced irq polling, I had to modify the patches that
touch the hrtimer.

@Simon: I removed a couple of your reviewed-by tags because of the
changes.

@Martin: as the functionality changed, I did not apply your Tested-by
tag as I may have introduced new bugs with the changes.

The series implements many small and bigger throughput improvements and
adds rx/tx coalescing at the end.

Based on v6.6-rc2. Also available at
https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-optimization/v6.6?ref_type=heads

Best,
Markus

Changes in v6:
- Rebased to v6.6-rc2
- Added two small changes for the newly integrated polling feature
- Reuse the polling hrtimer for coalescing as the timer used for
  coalescing has a similar purpose as the one for polling. Also polling
  and coalescing will never be active at the same time.

Changes in v5:
- Add back parenthesis in m_can_set_coalesce(). This will make
  checkpatch unhappy but gcc happy.
- Remove unused fifo_header variable in m_can_tx_handler().
- Rebased to v6.5-rc1

Changes in v4:
- Create and use struct m_can_fifo_element in m_can_tx_handler
- Fix memcpy_and_pad to copy the full buffer
- Fixed a few checkpatch warnings
- Change putidx to be unsigned
- Print hard_xmit error only once when TX FIFO is full

Changes in v3:
- Remove parenthesis in error messages
- Use memcpy_and_pad for buffer copy in 'can: m_can: Write transmit
  header and data in one transaction'.
- Replace spin_lock with spin_lock_irqsave. I got a report of a
  interrupt that was calling start_xmit just after the netqueue was
  woken up before the locked region was exited. spin_lock_irqsave should
  fix this. I attached the full stack at the end of the mail if someone
  wants to know.
- Rebased to v6.3-rc1.
- Removed tcan4x5x patches from this series.

Changes in v2:
- Rebased on v6.2-rc5
- Fixed missing/broken accounting for non peripheral m_can devices.

previous versions:
v1 - https://lore.kernel.org/lkml/20221221152537.751564-1-msp@baylibre.com
v2 - https://lore.kernel.org/lkml/20230125195059.630377-1-msp@baylibre.com
v3 - https://lore.kernel.org/lkml/20230315110546.2518305-1-msp@baylibre.com/
v4 - https://lore.kernel.org/lkml/20230621092350.3130866-1-msp@baylibre.com/
v5 - https://lore.kernel.org/lkml/20230718075708.958094-1-msp@baylibre.com

Markus Schneider-Pargmann (14):
  can: m_can: Start/Cancel polling timer together with interrupts
  can: m_can: Move hrtimer init to m_can_class_register
  can: m_can: Write transmit header and data in one transaction
  can: m_can: Implement receive coalescing
  can: m_can: Implement transmit coalescing
  can: m_can: Add rx coalescing ethtool support
  can: m_can: Add tx coalescing ethtool support
  can: m_can: Use u32 for putidx
  can: m_can: Cache tx putidx
  can: m_can: Use the workqueue as queue
  can: m_can: Introduce a tx_fifo_in_flight counter
  can: m_can: Use tx_fifo_in_flight for netif_queue control
  can: m_can: Implement BQL
  can: m_can: Implement transmit submission coalescing

 drivers/net/can/m_can/m_can.c          | 559 ++++++++++++++++++-------
 drivers/net/can/m_can/m_can.h          |  34 +-
 drivers/net/can/m_can/m_can_platform.c |   4 -
 3 files changed, 447 insertions(+), 150 deletions(-)


base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
-- 
2.40.1

