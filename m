Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D88C8071F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378686AbjLFONI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378688AbjLFONE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:13:04 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B20D4D;
        Wed,  6 Dec 2023 06:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1701871977; x=1702476777; i=wahrenst@gmx.net;
        bh=NFHFy7MUTsIivLLoDazvEvqOotBAQMt162fTOKvGnW4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=nMnbgVzJ5g9k4NhkelmRDBlz7WbjnM9nwn6xE0e14EZ/q3E9Ei7DaCfStDJ9GYZt
         31EiwRZAPvGw3l/L5qCTeh8v99do6bY6w2MeH+Q/PwUdzoV4lQ1t/UTm+PLOPDj21
         qeWee1MS66gJVwfUe70QgFolQ3bfk5RxBPkf4anY4x6uQGQHF3jrGnrPeTgYsIdm3
         UgsU+9OiQT5d7eg0ZVlXx2XsdiXSLd59wti3V7kKasN23KKElVCEwRCz0OL8MNoQh
         cXHnJL7Dc3GJq0MUUXw43ZasY1BGtP8k1zc4QqWKMmyayFTHPNUV72Q8XD7aCkIjr
         uhvfATbjwRnVAugMLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpDJd-1ravrC0Kh5-00qlAk; Wed, 06
 Dec 2023 15:12:57 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V3 3/3] qca_spi: Fix reset behavior
Date:   Wed,  6 Dec 2023 15:12:22 +0100
Message-Id: <20231206141222.52029-4-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206141222.52029-1-wahrenst@gmx.net>
References: <20231206141222.52029-1-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+XSWkDgLG6Ts7yg8IvwWWOfQQgwbt2PKtQsWdmvBvK1QXPcSrZT
 1p591gcydajuLH8DrU1WjNiXNHLADPCAbus6Od/+vKBDjMcm5F63uskiGZ0CRIQuk/TDgWC
 jVPI02amPtfrp7Ds6sA84eJosQ/hULL3wmDPO1+l1wymxvZyTcJkeGWMe/GVWjxrs5YXTTS
 TOEq8SJl/CyZ9BgfZXg2Q==
UI-OutboundReport: notjunk:1;M01:P0:6rEvhQ21+Mc=;zuh1M4W3sztlsJGyKeR50nIJMhR
 IBuGi2ieIugsooP/gypPY5lnP9S0dabGARRPLBU4rsc9NVEyRQuMJTmHz60EbmUPo9iKqhj2v
 i3glTa/EeYft4myDbmMozzzV2SusrNzwGZ5GVv1YWIFBWwMmwiqnqbccwzM2uBHsCM+j3jwT4
 QfbaczjA4da7s7SPL4Fi/ZHRU6q76CFYtkcNPl9SP2O9Y8O42K4EfYlRApb7vXJLYzvgI1oK0
 Y/vw3HwLYVaY8yQAY2/VfSdqWXMQcV1SEeuzqgdXgrO8O2qXn6B9o9VMYAxtGsse/qa8KECd6
 KZEDH4/VQJ6Vf494E+QrK6aPWY56KFVgB+ji/y5N9DQrq4wgaacHLvxoMOzGVOFNmLTmlI9cm
 JA0XVyfsZXOhK6QWhJBXS9UuCDqSzzxwRovA/WiDCQAb1fF49WzTyqKvC3FY1VWd7wkR7uWPE
 92nWxpFl/Z6cDkjcypkKZuxQuPn2M0Af+JO3Q63JLe+dwdp720P4wnBSEbcyHPaefUuEz97lB
 dBl5bNKy5syueHx/6tNIvJdEgnTfeD3Mb3jgHkYFgda9u3FLzBCQm9T0O8yXjy45sv2aqTTRe
 EEsedw353HgoDZPMNFjRMN0Ca7q3DnpyUlMS/SwG+a7Jr/FVunshN1FD21Z8pp033ScHBQ2HF
 0YN2pGX5gF3FkQsiaUlZ1rxgYLZoMT5ZghoKfaQ7HCOVMDIQ6XPhaV7+7zq6yXKwkhnejM31i
 7ahQ+ytiwZqRL1wuwHAgCsezMrA9ajKQ8vBObrnkzn1US8l0Vmwf7AH824nYj97PJNoRLgSm7
 VFRYiznSpL/GEorZCoz2Cx2LOBFevGCPTtrXyuvDx+3VK4BLdzvjp0xQT9o4mwzOYO92YkSzm
 GQBqlW+1CKZKJpfPWSzP2RSVAZuO+FtSbi5ITglfACrv++hWwtwLvEarojoTlte1rOUPIqd8N
 1AvvEukd2c69QVIDb+B0DFLJG/c=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of a reset triggered by the QCA7000 itself, the behavior of the
qca_spi driver was not quite correct:
- in case of a pending RX frame decoding the drop counter must be
  incremented and decoding state machine reseted
- also the reset counter must always be incremented regardless of sync
  state

Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7=
000")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index b0fad69bb755..5f3c11fb3fa2 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -620,11 +620,17 @@ qcaspi_spi_thread(void *data)
 			if (intr_cause & SPI_INT_CPU_ON) {
 				qcaspi_qca7k_sync(qca, QCASPI_EVENT_CPUON);

+				/* Frame decoding in progress */
+				if (qca->frm_handle.state !=3D qca->frm_handle.init)
+					qca->net_dev->stats.rx_dropped++;
+
+				qcafrm_fsm_init_spi(&qca->frm_handle);
+				qca->stats.device_reset++;
+
 				/* not synced. */
 				if (qca->sync !=3D QCASPI_SYNC_READY)
 					continue;

-				qca->stats.device_reset++;
 				netif_wake_queue(qca->net_dev);
 				netif_carrier_on(qca->net_dev);
 			}
=2D-
2.34.1

