Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF1B763A90
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbjGZPNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjGZPMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5712722
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:11:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEA5561B75
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808D4C433CB;
        Wed, 26 Jul 2023 15:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690384285;
        bh=bj1mr5kflt647mue4Mv7IoBZUc04fe5DGEibqyieb4A=;
        h=From:To:Cc:Subject:Date:From;
        b=HuYUFpuhD34XJ8sidC97NZLbJsh6MAP+XypkbjSB6LVD1rVMstnSGWdTIXP9TV+5s
         Z5WY8rIg8RJsEJt+5ft6ngmpAN1Z6texrn3N0C6MH/HabtQhnDQ23aTNDl0kXnCYMe
         lYOVH3x8Htxf2tBUbm0C2HWXCvHuLnZRiP8QNBF02gSxnbeJ3B2lEQUrauCHhHY5Vd
         ngbo+d67jBYjquGRwzFQHD5Cf/Ttlx/vuq2TbrWZKv9f9pmoeomFwLJm9Ru9+VDry1
         riuS2jfcLmV4ZIX7LHaX8GIHewY53zYPgOo8w5BgfiiTf1rqikwpJg2q+FSiGnk3t2
         DrXIJm4QhbfQw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>, Jeff Garzik <jeff@garzik.org>,
        Alan Cox <alan@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ata: pata_ns87415: mark ns87560_tf_read static
Date:   Wed, 26 Jul 2023 17:10:23 +0200
Message-Id: <20230726151119.2303954-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The global function triggers a warning because of the missing prototype

drivers/parport/parport_gsc.c: At top level:
drivers/parport/parport_gsc.c:415:5: warning: no previous prototype for 'parport_gsc_init' [-Wmissing-prototypes]

There are no other references to this, so just make it static.

Fixes: c4b5b7b6c4423 ("pata_ns87415: Initial cut at 87415/87560 IDE support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ata/pata_ns87415.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index d60e1f69d7b02..c697219a61a2d 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -260,7 +260,7 @@ static u8 ns87560_check_status(struct ata_port *ap)
  *	LOCKING:
  *	Inherited from caller.
  */
-void ns87560_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+static void ns87560_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
-- 
2.39.2

