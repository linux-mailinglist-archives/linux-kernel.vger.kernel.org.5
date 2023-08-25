Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C868788BC4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343795AbjHYOch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343533AbjHYOcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:32:05 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A56AE7F;
        Fri, 25 Aug 2023 07:32:03 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 88D0F1867F2E;
        Fri, 25 Aug 2023 17:31:59 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8GwYOjxrMV8q; Fri, 25 Aug 2023 17:31:59 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 1579C1866E63;
        Fri, 25 Aug 2023 17:31:59 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Mw8i77wbVndL; Fri, 25 Aug 2023 17:31:58 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.233.189])
        by mail.astralinux.ru (Postfix) with ESMTPSA id A98BD1867E38;
        Fri, 25 Aug 2023 17:31:57 +0300 (MSK)
From:   Alexandra Diupina <adiupina@astralinux.ru>
To:     Zhao Qiang <qiang.zhao@nxp.com>
Cc:     Alexandra Diupina <adiupina@astralinux.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] fsl_ucc_hdlc: add a check of the return value from hdlc_open
Date:   Fri, 25 Aug 2023 17:31:12 +0300
Message-Id: <20230825143112.16184-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Process the result of hold_open() and return it from
uhdlc_open() in case of an error
It is necessary to pass the error code up the control flow,
similar to a possible error in request_irq()

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdl=
c.c
index 47c2ad7a3e42..cdd9489c712e 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -708,6 +708,7 @@ static int uhdlc_open(struct net_device *dev)
 	hdlc_device *hdlc =3D dev_to_hdlc(dev);
 	struct ucc_hdlc_private *priv =3D hdlc->priv;
 	struct ucc_tdm *utdm =3D priv->utdm;
+	int rc =3D 0;
=20
 	if (priv->hdlc_busy !=3D 1) {
 		if (request_irq(priv->ut_info->uf_info.irq,
@@ -731,10 +732,12 @@ static int uhdlc_open(struct net_device *dev)
 		napi_enable(&priv->napi);
 		netdev_reset_queue(dev);
 		netif_start_queue(dev);
-		hdlc_open(dev);
+		rc =3D hdlc_open(dev);
+		if (rc)
+			return rc;
 	}
=20
-	return 0;
+	return rc;
 }
=20
 static void uhdlc_memclean(struct ucc_hdlc_private *priv)
--=20
2.30.2

