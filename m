Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF85813422
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573710AbjLNPKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573669AbjLNPKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:10:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3460D121;
        Thu, 14 Dec 2023 07:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1702566604; x=1703171404; i=wahrenst@gmx.net;
        bh=4w4fV8/WCKx7Frl/07FVoRBC+dlP5+0w1N8Tetjnf5U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=G7axTDMb87TwXmQMzrnRCn73mmJZVMTZrjo68NJCKKZ6vlamHZYaC62b5jzZgKKD
         Mi4t7FuRcEFWnn6RkHVnPsccnVHJQAEIq9oOl62Tfv25QiPmmST2T9JTS5iCUu52j
         IebKuldOYntI2hiEcW6QXQhMHBinfcaUcSAyd7uWMrIAl4Vw0gUhE7nj4alNbN+fF
         4tKaqsC3iQz6+CtHOWtIG7WooipEJ5WtnJbJbirkhH6OPYxlh7Iqvj86hFAcS9UbD
         ECojJeSZ98iCkrtBee7l/zu/zgoviY6n3iwJzCj+WWVBW6RMx2MX1WKHPxqfYgkjg
         4NYtQ3K5ifQL4YR8QQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KYb-1rFw2P0kwr-016jkH; Thu, 14
 Dec 2023 16:10:04 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 09/12 net-next] qca_spi: Log expected signature in error case
Date:   Thu, 14 Dec 2023 16:09:41 +0100
Message-Id: <20231214150944.55808-10-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214150944.55808-1-wahrenst@gmx.net>
References: <20231214150944.55808-1-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I4FtcHIGKQ1KMO8qcctQVpRrWx2lfstqeLAuShvPuGje6dgTdsY
 APzCseQ/2Ry8IIxZwQG0ZveFOhdgVPnU0Tx2kFBa3B8Dq70EZXEzv9BpPvdVDgb8s8MNDbL
 3+jdzKRNLIPeCViTj/hguwDjqcDVrVU0HeKnySzZBZIaH5yoBTexcZQIF2uuKHe5qaB5ZWP
 CohckMqUsPxg8YPXJjMJg==
UI-OutboundReport: notjunk:1;M01:P0:wL04cVLQOoo=;7xzT4lG8th9sNhun9U7n4TaBqYx
 ZULawFsRAPqKoZKndu+qHFb7F5zWR9v1AO+BhOlBqcB1GXz6AfqkytD68VbdpsJITjziUbPF1
 TObhfNHnrGonFL6JIRj0FR8oHNmSuVXjHek8DpZb/fYBhBcjq619dnakdp/QI11BDTfbnV2DN
 fTABC1mFTroaaIXAFQak+BKSezljVODT1WOBJuRT/zI2AvN0eXdh1KGHQRAFZi8rAIU2YKoE3
 xVp4B6U6HGGAupeApKe7Kgc7V9yLmaESsJVbKJXV7hEYt7Pr/isPqHUkqWbHz5HzwYN5p+a+s
 SY1Mc/pFpYr4U4dpz+fNnGhsA4JqyP25EnM4bsYL7XffuDNU61OvzNBl+dbApyKaFm4mXiajG
 Sc/Fi1BULGOqRiVNFV+OIKSLcRuFL4l0VUw2ad8KBlry3gLy+hOb92jvjIoxWIFw/mMDQrqif
 ccJ5/JAmXH9xzSrPgGMJF55YWZdCfBaUzDscafmv+VR0SNadEq14mmbueM0gEXsjCLJJ5giil
 68e4EQi2EbDTiNSVsvfDV0y0Nze20kwqFzdlRUTgi/wc6sMKGC40lk0iu4/HyGQ7Y3kkP71cs
 Jn31AUZzjy8lXPLAtVaNgcYRNWNSrrq4OCuWR2ZkNOSFQ4y2fDz6OXd1OWv4gIUB7PQlmJhpm
 i1i0eSY7eikJ+FEwmFrkgBlhy/rZ3mkdTe70S4a9wq/9cA2whNnfX9pUZJvM9fRlkeZrZBdMo
 Nl4YnHvLlNK6KB9rCGbTivP7nABHf2yqguCfV3hktrRGogTFQ7EqS3qPeND0wmna+SlO2EVKm
 dlo1UrvXVNeWiA+akAKJi5vLbDGLLdTcKjYKOyQ4DCDV2iQTWYeFdiDmrQLZOMsC+HllYYsPT
 IMZVToTOKwpWg59x21JWjmUNUHhjeIvFCC25M+R53T64gV1zFOn8ks+F/LwMChzDZdIIfB6YL
 bRdifpWTIu28MrnFz4V0P/zxzfY=
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

Most of the users doesn't know the expected signature of the QCA700x.
So provide it within the error message. Btw use lowercase for hex as
in the rest of the driver.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index 50a862a85f1a..a9188b19d1fb 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -987,8 +987,8 @@ qca_spi_probe(struct spi_device *spi)
 		qcaspi_read_register(qca, SPI_REG_SIGNATURE, &signature);

 		if (signature !=3D QCASPI_GOOD_SIGNATURE) {
-			dev_err(&spi->dev, "Invalid signature (0x%04X)\n",
-				signature);
+			dev_err(&spi->dev, "Invalid signature (expected 0x%04x, read 0x%04x)\n=
",
+				QCASPI_GOOD_SIGNATURE, signature);
 			free_netdev(qcaspi_devs);
 			return -EFAULT;
 		}
=2D-
2.34.1

