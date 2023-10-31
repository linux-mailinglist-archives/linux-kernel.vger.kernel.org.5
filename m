Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6442A7DCCE4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344238AbjJaMUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344228AbjJaMUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:20:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A4B97;
        Tue, 31 Oct 2023 05:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1698754823; x=1699359623; i=rwahl@gmx.de;
        bh=NStq/1toEyL2yGD2/Gm0voRirfeE5zhvxMJ9KWtuvUg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=jWlSz6671yy7MX/H1w5WZReaIvIZ4Yl8brSpQdfWUTlMMumYWwrzX13WUhtmGk5X
         SQND4GvcwBf1oQF5bA6XuDFDC9o6GexSLHxHJXb71pulKREfV21LelcWdaKO7KTIc
         c5uwHe3fV6ihhltIMPxlLOYDRZixsrNXz3AXff58BmtjAd1HdNQqbcwh7QbF9vSvp
         LsogsC1w+Edgo/aII2qejplW7ifQw64/P775LBDgy/GtbALEddCTBjs62NmLu5FQO
         +T2RnQPsykPlrNgPjLUL2+CyX4hLe4o5DFGoXp9TzXoCJvjvEcryxNMH3bclbKqHE
         SY0WNE9Wizejpd4Syg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.147.134]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbBk-1rGqob2HIs-00seLG; Tue, 31
 Oct 2023 13:20:23 +0100
From:   Ronald Wahl <rwahl@gmx.de>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Roger Quadros <rogerq@kernel.org>,
        Ronald Wahl <ronald.wahl@raritan.com>
Subject: [PATCH] net: ethernet: ti: am65-cpsw: rx_pause/tx_pause controls wrong direction
Date:   Tue, 31 Oct 2023 13:20:05 +0100
Message-ID: <20231031122005.13368-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7vBPN4Q5j4pDzPs1jE0Z5uapPSwVNQl6CIBfHfEPTf8+HE7OXSe
 7hldx3wv5mEH/71uMrLu2kCpI4Ri9AOx0W9uSavfnlf+x+bC63tpFIGv2GnUW0maXUNBM8u
 Wy1gfXJGApL1Jg9thXW9lDegYNwQBuUXyZuqkfH21GVFudsNddWvAq5xW1L/VNWPhzirO/+
 RpVIyEb9j/gK5u/SFMErA==
UI-OutboundReport: notjunk:1;M01:P0:QuDYqB6ayrI=;bqfCBUO6VPEsPZV/2Y/HOZVQ/KR
 S7kuwd5y2giZ0J/a+QMDEmFppMYz+5T1VBrShrX/I5pjhUWR6XUR/NF8jhOTxhi6lcaThiFe2
 xTKm0JTUdKkylPGHCzN8QDwjpYjQeo90W4F0Xgo8q4/F1juF7rMyGHzX27GsHM52UElzcQ0yY
 l7GHSnQzw+UMk4M82UvriMRSu0Zn8fexlFwgqNcBrl6U8M6CHY2DhyP/XnGQyTtLcXsyiyZTM
 zhlvY31iGbmhd8t3Jy+SCx0Bg6gzwozEpJt1oG0xpXNEJHexZZ/sdx5DD0Yj+1oj7K0xkwdi5
 pV+lru+oqi2iP3bEPKEPQcvLyWRQex3nUg76no1a8FbjpRVjanzeXQwWPSe/Cpg0bKcjG6WUL
 y06AZawNJKd9ba6WXhw/E7XKM+WfV83Jt8ok7FPPe8ln6e+QzmvOpbDh8PwEPe9Sy3pRQ5gMI
 gfW7vzDreVKbK7+PbEppu0ss8tQbWYasO9GYM5CtKRCEQ+q4VaeT+EGx2MEaOKXIDk7gu2uey
 aW/1aexC1iTKPoC78l92GoghsdIK/SXFBdgpcYj+OMfqharir59Z3DCWgQnLLH/ZH6pcy6Lb/
 FGEyAdU0Z0vrRBzfHxwmjgNUSGr/BBUntOeH+R9ehSOLcXvJ4rTFFcS3Y/aX9C8iz+zt0THEt
 sOQEtASvctkEWpLo3178CFwgHKv+RbR7uv7zedbLWsiddW2o3yFTqGIzF8b+Hvdu8u76FLhnY
 IWcmcD0jtO5/nJnLRFbqgAuSdQgEKorzKL7k8iecXBr/pH2DnYUAqoK7Bbxy+Kd5cqVDQITm9
 u8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronald Wahl <ronald.wahl@raritan.com>

The rx_pause flag says that whether we support receiving Pause frames.
When a Pause frame is received TX is delayed for some time. This is TX
flow control. In the same manner tx_pause is actually RX flow control.

Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
=2D--
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethern=
et/ti/am65-cpsw-nuss.c
index 24120605502f..ece9f8df98ae 100644
=2D-- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1588,10 +1588,10 @@ static void am65_cpsw_nuss_mac_link_up(struct phyl=
ink_config *config, struct phy

 	/* rx_pause/tx_pause */
 	if (rx_pause)
-		mac_control |=3D CPSW_SL_CTL_RX_FLOW_EN;
+		mac_control |=3D CPSW_SL_CTL_TX_FLOW_EN;

 	if (tx_pause)
-		mac_control |=3D CPSW_SL_CTL_TX_FLOW_EN;
+		mac_control |=3D CPSW_SL_CTL_RX_FLOW_EN;

 	cpsw_sl_ctl_set(port->slave.mac_sl, mac_control);

=2D-
2.41.0

