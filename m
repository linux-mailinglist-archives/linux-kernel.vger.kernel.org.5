Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C09C7A4985
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241934AbjIRMYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241982AbjIRMYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:24:31 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 970DA102;
        Mon, 18 Sep 2023 05:24:18 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,156,1688396400"; 
   d="scan'208";a="176397769"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 18 Sep 2023 21:24:18 +0900
Received: from localhost.localdomain (unknown [10.226.92.107])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3159C41F6AEF;
        Mon, 18 Sep 2023 21:24:14 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.au@gmail.com>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 0/3] Fix IRQ storm with GPIO interrupts
Date:   Mon, 18 Sep 2023 13:24:08 +0100
Message-Id: <20230918122411.237635-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following issues observed while adding IRQ support for RTC.
 * The irq_disable is not clearing interrupt source properly.
 * The driver is not following as per hardware manual for changing
   interrupt settings.
 * IRQ storm due to phantum interrupt, when we select the TINT source.
   Here IRQ handler disables  the interrupts using disable_irq_nosync()
   and scheduling a work queue and in the work queue, re-enabling the
   interrupt with enable_irq().

Biju Das (3):
  irqchip: renesas-rzg2l: Fix logic to clear TINT interrupt source
  irqchip: renesas-rzg2l: Mask interrupts for changing interrupt
    settings
  irqchip: renesas-rzg2l: Fix irq storm with edge trigger detection for
    TINT

 drivers/irqchip/irq-renesas-rzg2l.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
2.25.1

