Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A713C7B8BE0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244663AbjJDSxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244502AbjJDSxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:53:12 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 360EEEC;
        Wed,  4 Oct 2023 11:52:46 -0700 (PDT)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 76F507A0648;
        Wed,  4 Oct 2023 20:52:45 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ata: pata_parport: implement set_devctl
Date:   Wed,  4 Oct 2023 20:52:33 +0200
Message-Id: <20231004185235.27417-3-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231004185235.27417-1-linux@zary.sk>
References: <20231004185235.27417-1-linux@zary.sk>
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

Add missing ops->sff_set_devctl implementation.

Fixes: 246a1c4c6b7f ("ata: pata_parport: add driver (PARIDE replacement)")
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/pata_parport.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index 258d189f42e5..cf87bbb52f1f 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -51,6 +51,13 @@ static void pata_parport_dev_select(struct ata_port *ap, unsigned int device)
 	ata_sff_pause(ap);
 }
 
+static void pata_parport_set_devctl(struct ata_port *ap, u8 ctl)
+{
+	struct pi_adapter *pi = ap->host->private_data;
+
+	pi->proto->write_regr(pi, 1, 6, ctl);
+}
+
 static bool pata_parport_devchk(struct ata_port *ap, unsigned int device)
 {
 	struct pi_adapter *pi = ap->host->private_data;
@@ -252,6 +259,7 @@ static struct ata_port_operations pata_parport_port_ops = {
 	.hardreset		= NULL,
 
 	.sff_dev_select		= pata_parport_dev_select,
+	.sff_set_devctl		= pata_parport_set_devctl,
 	.sff_check_status	= pata_parport_check_status,
 	.sff_check_altstatus	= pata_parport_check_altstatus,
 	.sff_tf_load		= pata_parport_tf_load,
-- 
Ondrej Zary

