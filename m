Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FA07D85EC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345452AbjJZPYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345440AbjJZPYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:24:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CB41B2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1698333835; x=1698938635; i=estl@gmx.net;
        bh=r1iP9dd5b2jv9LDWP7GApzM3qBAtB031NBx6H4WJIhc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=fyYI1W9Oc5Dgp/JLCYx4TwSwASLh+YIc9N9DFGJ2jtpkiZWOaNFVlvUjuojauz/4
         GpdGXW6O1VcWpuCmUI2v5T4lkm+4k6gDQBssjKz1upg4qZcqdqvRmQ51dexAp8fIq
         PDyKLsKtCSa2D+pmNmDzCYzQ2mKjSyXcN/GrTE8cqUykHaEJ0UvTMH4P8kfUs65EW
         kSPRaJVT4A5dQxKuyxGXFXkIr8t5648TyLgktDjnEu5x3O/u7oUjABxwitdfbCnMQ
         sEKg//jcp7UVcD1byJ/g1sAcoI9uW6eINV/XYWPi9H7YZKtdiMPo759Int8CbUYSR
         1uaL3YB55Vfd24zCnQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([77.246.119.226]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MBm1e-1qmAr83m6G-00CEYy; Thu, 26 Oct 2023 17:23:54 +0200
From:   Eberhard Stoll <estl@gmx.net>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Eberhard Stoll <eberhard.stoll@kontron.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Olivier Maignial <olivier.maignial@hotmail.fr>
Subject: [PATCH 3/4] mtd: spinand: winbond: Add rx sample delay for W25N02KV
Date:   Thu, 26 Oct 2023 17:23:04 +0200
Message-Id: <20231026152316.2729575-4-estl@gmx.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026152316.2729575-1-estl@gmx.net>
References: <20231026152316.2729575-1-estl@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qm3+qc73Q0d80VwPrFMC83h5AQZ8g3IptaI4EvmqqgEU2Q7lfO8
 G+kRCWG2eJD1c/iumZEjS6hUJnBOOyFvBm9w5N7XX3MwWx5xKhfcBu0j5+p9b4GcFKjnPnE
 Wzoq+KHSbFZix7Bt03NNM9orfgpAX72C7zLtoaLO4qB1wnjIKjLLieEu8G2LwRo0blSDUlz
 21etO6tuCVelWpB6l9IBw==
UI-OutboundReport: notjunk:1;M01:P0:DcYq5BOIkhw=;kN1FsiKQrrH87SmU9yWD44Pjp+Y
 okYva25ZFWAkFn4fHz1azeio9Xu9owYEA4r5kQsVtUt65n2nrV0lleE7jkZDolGi68V75KQgR
 gnr2LktX1dBEywFjacggnjCVVP+kC0kFFdYoLSP+KPNHbK3OnMemiK2yLo2cAPGkh52jr07x/
 oEfmtLvnZ5ZcrTPLY3baLaERnSd+XfthUdogGpJ2wp95/0ib5qX0HWVMXL6tcRYsnndibQe1C
 ezOsyg+EPnQFtgvyvEaFrJRqivhJuuGPjtHQwk/hk4b4JOdrkx0N45OG0FhWyqpcQYW+K8+mF
 3n/ePuxHqWa/+7PHkAplpw1dV+ymjygR/q5HAHMOe6SDALo53wc/YRHgRSzZVwV28WnzIl61d
 Ghy620iSSTOsU4Ms5wqG3rxEjxmQDkfdXuCYWw/VrsoifFoxz+GRMdr14ua2WKpsE7Rm4+W6u
 HbEI//FNlCt/Pus2Q/A9jKM1vQyq5bc/NcMxJTQB3vqhf1f7X7pavO9D+BBHe2tjS/bbhcsfm
 w2p7j6IBmt8sWE+qKxzcaVAkP+JiGf66RGDfrQaowLHhjvV6iwQsukONQiuvQ3Z0uS3tTgOvt
 y3WuvR+2WOeIRAI3GSd0vvTCNtA15PKcR8y6lp9lqWE36uTddpnRdqeXVYpJuhg3toa2ffS3k
 lKYqF67SbpQllVSvC2uInF4cbLeaMh3f5Fy0ELM8taixcpDNIn4FnwlgddfoHgCWFIf+bcSqt
 5OFYKR7VwpqWgdUT6vDP9MIbTJiUXBCRcZbFNqkx9S3P/71e8gATzSekYKyxI33s5S0DwwYGz
 lGmigVjsNguCJGd2taMMs2xjWr/KSNeaIMXonWBmOk08DKijb1zVhGmFHPCUF1/03HBQg85BQ
 V6a9gTjeeMu1c9K4BXvU4r1dW4IkvIyp7zukFrHkmgkg0/bA6njQAz274WbMfC6TGYxFq0AZ5
 nbngCN7SiT8TK+FEU0jdLSQa3Ck=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eberhard Stoll <eberhard.stoll@kontron.de>

Add tCLQV (Clock Low to Output Valid) parameter for Winbond W25N02KV
SPI NAND chip.

Signed-off-by: Eberhard Stoll <eberhard.stoll@kontron.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
=2D--
 drivers/mtd/nand/spi/winbond.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond=
.c
index f507e3759301..c0b05f5cbf1b 100644
=2D-- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -168,7 +168,8 @@ static const struct spinand_info winbond_spinand_table=
[] =3D {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status),
+		     SPINAND_RX_SAMPLE_DELAY(7)),
 };

 static int winbond_spinand_init(struct spinand_device *spinand)
=2D-
2.25.1

