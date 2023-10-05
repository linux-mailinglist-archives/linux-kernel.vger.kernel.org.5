Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C113E7BABAC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 22:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjJEU4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 16:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjJEU4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 16:56:09 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E18C9F;
        Thu,  5 Oct 2023 13:56:07 -0700 (PDT)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 95EEE7A01D5;
        Thu,  5 Oct 2023 22:56:06 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ata: pata_parport: fix pata_parport_devchk
Date:   Thu,  5 Oct 2023 22:55:56 +0200
Message-Id: <20231005205559.6504-2-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231005205559.6504-1-linux@zary.sk>
References: <20231005205559.6504-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a 'x' missing in 0x55 in pata_parport_devchk(), causing the
detection to always fail. Fix it.

Fixes: 246a1c4c6b7f ("ata: pata_parport: add driver (PARIDE replacement)")
Cc: stable@vger.kernel.org
Signed-off-by: Ondrej Zary <linux@zary.sk>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/pata_parport/pata_parport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index 1af64d435d3c..258d189f42e5 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -64,7 +64,7 @@ static bool pata_parport_devchk(struct ata_port *ap, unsigned int device)
 	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0xaa);
 	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0x55);
 
-	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 055);
+	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0x55);
 	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0xaa);
 
 	nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
-- 
Ondrej Zary

