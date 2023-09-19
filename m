Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AD07A669A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjISOZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjISOZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:25:26 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329F9100;
        Tue, 19 Sep 2023 07:25:16 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id CF242186686B;
        Tue, 19 Sep 2023 17:25:12 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id txwk927cRQHZ; Tue, 19 Sep 2023 17:25:12 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 72C471866AFE;
        Tue, 19 Sep 2023 17:25:12 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HIkNsWFKyl_9; Tue, 19 Sep 2023 17:25:12 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.235.105])
        by mail.astralinux.ru (Postfix) with ESMTPSA id DE370186681B;
        Tue, 19 Sep 2023 17:25:10 +0300 (MSK)
From:   Alexandra Diupina <adiupina@astralinux.ru>
To:     Zhao Qiang <qiang.zhao@nxp.com>
Cc:     Alexandra Diupina <adiupina@astralinux.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH v5] drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()
Date:   Tue, 19 Sep 2023 17:25:02 +0300
Message-Id: <20230919142502.13898-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <c1437313a3fea94a66d33f7bf97f363c77838359.camel@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Process the result of hdlc_open() and call uhdlc_close()
in case of an error. It is necessary to pass the error
code up the control flow, similar to a possible
error in request_irq().
Also add a hdlc_close() call to the uhdlc_close()
because the comment to hdlc_close() says it must be called
by the hardware driver when the HDLC device is being closed

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
v5: do some refactoring as Paolo Abeni <pabeni@redhat.com> and=20
Christophe Leroy <christophe.leroy@csgroup.eu> suggested
v4: undo all the things done prior to hdlc_open() as=20
Jakub Kicinski <kuba@kernel.org> suggested,=20
add hdlc_close() call to the uhdlc_close() to match the function comment,=
=20
add uhdlc_close() declaration to the top of the file not to put the=20
uhdlc_close() function definition before uhdlc_open()
v3: Fix the commits tree
v2: Remove the 'rc' variable (stores the return value of the=20
hdlc_open()) as Christophe Leroy <christophe.leroy@csgroup.eu> suggested
 drivers/net/wan/fsl_ucc_hdlc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdl=
c.c
index 47c2ad7a3e42..fd50bb313b92 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -34,6 +34,8 @@
 #define TDM_PPPOHT_SLIC_MAXIN
 #define RX_BD_ERRORS (R_CD_S | R_OV_S | R_CR_S | R_AB_S | R_NO_S | R_LG_=
S)
=20
+static int uhdlc_close(struct net_device *dev);
+
 static struct ucc_tdm_info utdm_primary_info =3D {
 	.uf_info =3D {
 		.tsa =3D 0,
@@ -708,6 +710,7 @@ static int uhdlc_open(struct net_device *dev)
 	hdlc_device *hdlc =3D dev_to_hdlc(dev);
 	struct ucc_hdlc_private *priv =3D hdlc->priv;
 	struct ucc_tdm *utdm =3D priv->utdm;
+	int rc =3D 0;
=20
 	if (priv->hdlc_busy !=3D 1) {
 		if (request_irq(priv->ut_info->uf_info.irq,
@@ -731,10 +734,13 @@ static int uhdlc_open(struct net_device *dev)
 		napi_enable(&priv->napi);
 		netdev_reset_queue(dev);
 		netif_start_queue(dev);
-		hdlc_open(dev);
+
+		rc =3D hdlc_open(dev);
+		if (rc)
+			uhdlc_close(dev);
 	}
=20
-	return 0;
+	return rc;
 }
=20
 static void uhdlc_memclean(struct ucc_hdlc_private *priv)
@@ -824,6 +830,8 @@ static int uhdlc_close(struct net_device *dev)
 	netdev_reset_queue(dev);
 	priv->hdlc_busy =3D 0;
=20
+	hdlc_close(dev);
+
 	return 0;
 }
=20
--=20
2.30.2

