Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1509A81341B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573683AbjLNPKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573642AbjLNPKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:10:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259B311D;
        Thu, 14 Dec 2023 07:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1702566602; x=1703171402; i=wahrenst@gmx.net;
        bh=SdG5JZGe1SUnpzceGIn1uNATbX/L+NGxavKwWZ5qQwY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=rnjkgg5o0xk1tdiGaiIae7Ny9xtbNA/MuWfZOIkADZQ6G+Jj6A5z9GvLgqKczWNs
         oEFFtxnOGFiwOdf284nvA/vxF6oITUTaHCfQwxNH+jJC2rz5nv1LTVgLX0+0UI1sb
         D905qM34i4A/2bvHUxxfeMUKS1UB00OkXqFpKNW3450+B/3JEDs1WkpgLvVmSaNP4
         Z8B98+pSo50RkYCrdQx3iXCgkHVTWodcmUHHYzF+DSsoS5DUMMkAoyU1+e+8hxw2z
         /cIvW/euchEaY1eyEc38A9qGHg48hCId5tkuZWj7NnyND1XbDXhBdZ+kIC/ORFjtN
         RaWNAx9dGbVUIDHWxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MirjY-1rjoic0quq-00erCe; Thu, 14
 Dec 2023 16:10:02 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 03/12 net-next] qca_spi: Avoid skb_copy_expand in TX path
Date:   Thu, 14 Dec 2023 16:09:35 +0100
Message-Id: <20231214150944.55808-4-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214150944.55808-1-wahrenst@gmx.net>
References: <20231214150944.55808-1-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CxcXeQyPbzMOKEARp7hridvQcOuDtfTlK8rzBiMHXcAv0Nl/iBR
 C6GE2LFL20clk5gv3G7a9U23SmOhhR08OYxzuz8I17wEXQaKzjYA6v1i71JnNbnH9eJszG1
 p2E5XuGEPR1W0KU8w4xesla0rijqmrE8+7e2wEbToGaA6tmyw6c+MNDfSNKbc1+Nj0CWpQC
 PwGErQ24m9qUs8UGjP0Fg==
UI-OutboundReport: notjunk:1;M01:P0:d1QZxsP7/vE=;WgD8AYmF8FaDICVVm4LDQofmLj3
 Jps9N7g4huwPz70xAx86OdpnKx4ZPIEUXsfwxfyKUymUZ2YaAdxs8OyYpTVrfd8oU824wDbUg
 +jNpYXRIUFx1k+GfXGkApSl9QnK33M/ojJU2OT0J82moBSfyqzfiADch+pHMt9rdNfV2xVRI3
 kDTTUR0mgla6AFthgWdhSqDmezu7yiJOIIxiKToRihpehCmd/wg26RysNOTWQTfLE5q9b8ILy
 JA7YiqmuF+tan2q4P/yk0RNOlIUrRMYh0oRll4H/K2kbYbxYCnUNlgU737/sq5w1Mcp5XkEGy
 xofOtq5hN1cQ2mqg3lhoV2MBXyI5+rQyKSH7AMQcyy0aM0oFIaEFuiwok/rlXodd59f78Zb4D
 bT19uY65hvIteUWYWo8yXQJ6mx3v+qwUtPQqreiUbMHD0BI/TTnYgYJvlfMS91TIzs0jIbI0x
 +qrgiNrkEVmNrX8PwDNLrndSF5Ifa59dweeZaYCC7GqCyeITpTjC19e9WehMP7V6IrZrJmevv
 8YarZtaU2tQ8fZ4mCGJw+wQJ0gy1TdMKCBlxGITAnLthjU74iwPTmJKvZH0OuVrp8jp4YUCF6
 t5Jz7oNt9pzBMmRCweyWwrxPCvXM+4MoG9H+nXE1Ym6yTZd9erjbwNaxeo5mx+1AfI7Ir/+Nk
 CHlQQ/zplWozZkErQ1BUi/gvx2QcWkpH9xdg+GvizdzDIynCpCGltNcxi/QwjELiRekEIgoE/
 sSGcjpoIavQa5PV8/LjhsnEfUicPiKexSF/rrhD6kozOg1bRwXxVJEg3sNuhoD+QqOPHsz8QX
 XU0bbao1dzoHbiq9H0u7C4x5VHeFekTrvAsYiG9S9mvfbhAgQZXgOO1mVmT8JY+LihvR7mxOK
 nNR1KUHBjvyWk1z+EH1ibHGPMpI+lDG+rLw27YbNZwyosBYYLDonzofDYW5g0jZj0MBnoYRpP
 ohyURA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The skb spare room needs to be expanded for SPI header, footer
and possible padding within the TX path. So announce the necessary
space in order to avoid expensive skb_copy_expand calls.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index 88f2468ba676..f0c99ac8d73d 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -859,6 +859,8 @@ qcaspi_netdev_setup(struct net_device *dev)
 	qcaspi_set_ethtool_ops(dev);
 	dev->watchdog_timeo =3D QCASPI_TX_TIMEOUT;
 	dev->priv_flags &=3D ~IFF_TX_SKB_SHARING;
+	dev->needed_tailroom =3D ALIGN(QCAFRM_FOOTER_LEN + QCAFRM_MIN_LEN, 4);
+	dev->needed_headroom =3D ALIGN(QCAFRM_HEADER_LEN, 4);
 	dev->tx_queue_len =3D 100;

 	/* MTU range: 46 - 1500 */
=2D-
2.34.1

