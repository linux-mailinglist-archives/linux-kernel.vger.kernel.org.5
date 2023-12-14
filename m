Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D648813433
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573692AbjLNPLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573695AbjLNPKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:10:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBD912F;
        Thu, 14 Dec 2023 07:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1702566604; x=1703171404; i=wahrenst@gmx.net;
        bh=HLU+z34FZ8agcDi053VDUgfPobQm95h3h305AtqCmHA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=o91q2t83Dh56Y0d5zHgioKxcbNXzdB7oJSseC6i8yzz5fus6azbSkNGgsQMsI+oF
         y+s33Kxl67uFXFFX+QqtsqF/K5jVbu4cKd8DeP1zI7ddB0Jq+X3Dog+zOg+gFHYSm
         Ei6T593JvxdVxy1BmXH6Y/eY2KPmYamIFP9oiCYnu7scvuzV/MQHMdYsz137Dcask
         ejQ0p3l907kyVYzqySc06KcdsiIaX8XwAqqY1QsifAn9GTCabKLE7AosFX4dGlVYt
         Iq4EPbwv5y12Ny6chstipWkal0s3x5eWBBq44x9hk6rQk4fN2GA2CkgO9sJsiEwAQ
         Qai/Do3P58rrxcRkKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD2Y-1riA1Z3dCc-00eIyI; Thu, 14
 Dec 2023 16:10:03 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 08/12 net-next] qca_spi: Improve calculation of RX buffer size
Date:   Thu, 14 Dec 2023 16:09:40 +0100
Message-Id: <20231214150944.55808-9-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214150944.55808-1-wahrenst@gmx.net>
References: <20231214150944.55808-1-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QvIXuaxuzVK800Irwo++BOQEZ+wzFUpxIEfKzSA1XNu0VI+mZJL
 VC5jrD52OKs1EwsMqdP1iu+H5b2rSfbWBpLE4EqqU5rtOE1Nays9clKNEcYdYkA2Q8jlfj/
 tYN3SNe47hmLjO0BBR4Bz3BxnVFTCPyTtG/T4H6Sxc9gddn8PgDJ7t7ucGc+EXdBAb1+k1/
 LZHOHlZe8oI1Ces8UCwyA==
UI-OutboundReport: notjunk:1;M01:P0:nslnRylfnyQ=;jOare3WTyWLYltgGDSocDPwJvlx
 GXLE6nNb3TBJcj0+ZorXXnY3VWIfnW65No+8/8CCSYKxPLaAHhA/t+xKshsO1gfNaUaIudCOL
 gIVoWKwjMfpG5I+IUuXIj9q2FQvTZRlZgl1ehI5ayaBtszPSF+hvKcZGbybXF87cQ4B/HrUB6
 Vdz9vatjoO3RlTj6k6MFxfmJKyZL5JCS3GDlAHNZZkYRsxjhaYahMfYaN1+r1KJ4/nJNAIK//
 mqkBhn8IpOsdC+rSszwbZyQO90cm2ubO+nE9fzoUdkTSSbnpTvKmITW9qOCeEFMyJR4/+BBo9
 K3Y8kt5+Feh+ErHvRzTpCScaQnK2P7QZJgcEXfdRwjQRqiF5bc8o4ugJWzD0x/sKVnx+PiQTJ
 ykxVBGLIzCFNUBdQ82wNrdJQB6wUR412t2f/a1ce3rL5EYN35VOeSAybFfhacBy+wNQM8eP7y
 zA5PFaf65mZHBQ/nLDl0q/XfNrRgKjpw0mLRIt07KZhvGv0epTj2pFUePAM1MeNGoeG6Z7lAp
 xpjBwTxt581YghgJd9nDvahhwiBLiWtfm1hCqkLU55TpjT8n8eZRqBqo48TGYFFrmvBVAEtLu
 Vp+FfwgcYWxqFq/vlmcegJQc15gIuBhkWdzLuSzcUggNv0uNjgRNFKU/VE/sIzjsMPkBnnwvm
 ailk9uZtgAqJQcXRkPs4v3aeOeE4dqJZFCyp2/l6pWcKXCd84B1CHG71Qcs08ECwuUDqCwhE0
 XGd4N7C2oOXshcZDdNqFr5ba2N60UtAm9iV0gwUe5O5I2YsMxm//05Kr1ujtn9UlSFWOXQ63f
 /sYRHJTedjzTOffN0TYLilUukUmZXC/uQapK/sm9eqv3EZtp+GIdaSnIRn3Xg7puJklSG/BNi
 KvRSjlG43vL0FJm+LjnQjJ/gJx8/hsyHKiebdh+V0apcVb0K59lu8Sb66Fk3fJonq649kQ8ql
 lBWlYc5adm/kAyqj495YwNqVOp0=
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

There are two points with the calculation of RX buffer size which are
not optimal:
1. mtu is a mutual parameter, but actually we need the maximum possible
   MTU. So better use the define directly.
2. This magic number 4 represent the hardware generated frame length
   which is specific to SPI. We better replace this with the suitable
   define.

There is no functional change.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index 450c3d254075..50a862a85f1a 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -795,8 +795,8 @@ qcaspi_netdev_init(struct net_device *dev)
 	qca->clkspeed =3D qcaspi_clkspeed;
 	qca->burst_len =3D qcaspi_burst_len;
 	qca->spi_thread =3D NULL;
-	qca->buffer_size =3D (dev->mtu + VLAN_ETH_HLEN + QCAFRM_HEADER_LEN +
-		QCAFRM_FOOTER_LEN + 4) * QCASPI_RX_MAX_FRAMES;
+	qca->buffer_size =3D (QCAFRM_MAX_MTU + VLAN_ETH_HLEN + QCAFRM_HEADER_LEN=
 +
+		QCAFRM_FOOTER_LEN + QCASPI_HW_PKT_LEN) * QCASPI_RX_MAX_FRAMES;

 	memset(&qca->stats, 0, sizeof(struct qcaspi_stats));

=2D-
2.34.1

