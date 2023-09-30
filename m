Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35207B4336
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 21:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjI3TPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 15:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbjI3TPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 15:15:33 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81732E3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 12:15:30 -0700 (PDT)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id CC42D7A00BF;
        Sat, 30 Sep 2023 21:15:27 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] pata_parport: fix pata_parport_devchk
Date:   Sat, 30 Sep 2023 21:15:08 +0200
Message-Id: <20230930191511.24994-2-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230930191511.24994-1-linux@zary.sk>
References: <20230930191511.24994-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a 'x' missing in 0x55 in pata_parport_devchk(), causing the
detection to always fail. Fix it.

Signed-off-by: Ondrej Zary <linux@zary.sk>
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

