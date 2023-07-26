Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1AA76408D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 22:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjGZUeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 16:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGZUeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:34:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D702704;
        Wed, 26 Jul 2023 13:34:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 448E461C9C;
        Wed, 26 Jul 2023 20:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC48C433C8;
        Wed, 26 Jul 2023 20:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690403643;
        bh=HTr91m36lJ4Cgl7LDNajp4qXfX9dPoHByJE92PuE8JI=;
        h=From:To:Cc:Subject:Date:From;
        b=S3u9aEl76uukqy01rW+W7RcRVroR+zjgtOtHUCwvN3NPPx/ShzpjdSBp1u4GyOncz
         2V0kEEzIoNMzV66sT8UWGRYJr5pzl94deFOzxEV8/U5sccyDIHsnrY78vq6rTV5yrf
         GjWzoBJ0MNr0LB+PqhHfyPiYC3UrpGHo6/gc3+BLwp06oQwQDadqqb6vlKdM1L4pg6
         HQiPEGdDaoil0gLu8zRzsu8k63rJLOJbv+jTm2qsrXpKb3CxMO4fJ0bCEGsQWEOid0
         yXyW6ynj176Z/RVQktzD3YhigECyVon16JjL8p7AiZ9SYsyDYpVDoV0cAY/kqgdwM0
         rt8eoOplUJyFg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jon Hunter <jonathanh@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] ata: pata_ns87415: mark ns87560_tf_read static
Date:   Wed, 26 Jul 2023 22:33:22 +0200
Message-Id: <20230726203354.946631-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The global function triggers a warning because of the missing prototype

drivers/ata/pata_ns87415.c:263:6: warning: no previous prototype for 'ns87560_tf_read' [-Wmissing-prototypes]
  263 | void ns87560_tf_read(struct ata_port *ap, struct ata_taskfile *tf)

There are no other references to this, so just make it static.

Fixes: c4b5b7b6c4423 ("pata_ns87415: Initial cut at 87415/87560 IDE support")
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix changelog text
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

