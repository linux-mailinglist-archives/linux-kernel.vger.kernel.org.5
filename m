Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8AC7F33C0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjKUQbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbjKUQar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:30:47 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D1E19A;
        Tue, 21 Nov 2023 08:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1700584229; x=1701189029; i=wahrenst@gmx.net;
        bh=JoGHBVdoQHC+Hv6Wibo5CgNTW7akgW6n35LRv1PZupQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=ep89LGv1rx9UT5YbrIdIfvDUulLILkxBdvGeCDVbWp3ydd9NZWYnG+zL3P8Au4mK
         7DS+Am6nLm5CDB18U1FA6eYDc22xINzVr1/HhrhczwL1zu+wVtJJcrwxO3ZTqczji
         J75cVhpPuM2WIjaW2lx7EE8xwEVpEz3JNZ2cwsHn9RGCoRgdCnw226zGAazZecVgo
         JhJIIwxYdRWwXa+xLpFdbcViiCyLL7l3a03zTiZVN1pXM+M5GImVq48KLU4aT08kI
         zHHEAUmrGqq0qmRGDNO4htEVuDEskVhBZ3D2ge0qu3HB5SWk5aXCEO728YrTmZbNe
         kPVTatLFfYHQxQ1N+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6qC-1rk4FN1m3w-00lUrh; Tue, 21
 Nov 2023 17:30:29 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 4/4 net] qca_spi: Fix reset behavior
Date:   Tue, 21 Nov 2023 17:30:04 +0100
Message-Id: <20231121163004.21232-5-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121163004.21232-1-wahrenst@gmx.net>
References: <20231121163004.21232-1-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bvNYFCb4jDy2CsUdTWKcRtEIeHiKsPwaWtJYrrPMVRe7BQl3yHl
 mYrfz8dy7457KSPmfewTUOV+APtuGdFtt3C+7GtzUrR8B4YIubJzoddH2olZP+4tc5Cvhdx
 Dq7/7Cp6cdAB0C99WrNKkATjOnuMyD7jqnpgSL5RivTo/nnpWJMojWgYWDeglYXlC1DRQQM
 rioKwcU0J5mjSrxvknKzQ==
UI-OutboundReport: notjunk:1;M01:P0:iaqnJNZY4yM=;SPAh/8736h479Vilzu/1j7j+pos
 h7Fn0rUAVg+FHoO2B+2u9MWRa3xGpA4Rf4WOIZs7heabaOoZmwYd8lYu106dS0SmNY/MguGc9
 oH13Z3i42/Fihi6Ycpqw6i6+inuAZQ473d1uo5FCrk0I2ZHvUycG+rJSooVxwq7b84uw0JGx+
 +KO0S6zrl4NGOi7IeItG5OK2sdk1hTkxtbKkytPWvcIqR5RQ8mN0Li+uq8d0zdpgLjifDRK8N
 tejp/3fnHnrFK/YP+S4BiSTb9eZuO4tK7Mpd6JzYAMf0EY/YsZscfWBTBZQOdhuiMyffkjnNA
 qzQoUofxHvSLNbRHT8g9iFbUEgq6hdcMMPORKZuD87QxQz/tFkYACrHUmlpsEaEFL7Yt2tGqd
 8CjLXvwdAOhYbsiWt/s0YCrT08xIjb5W7b0H9WLUayMsx6j8g5HF2NJIDaCafaGzlfb2u2eX8
 diKR3HQMF5PfoUD9o4MGwNBCc9cFL0/ORBiQaeCksZGJX7nXcsDboH0TtANT1JiD3FyI3vyw6
 9Mre0AD+EFt21kem+Y96faGWIcIokkp9G11zcuBivH+yfoJPiwoa9zwzKH2G+T2d5mDasA2Ay
 +uulkfuqc0FkJIiI6ChFZqECeUrbjZ1yejl4sLgTeMgLi6ofwe4vY1kTZ9Cw5g9cJEBMtWpCV
 fm1n+suGtrKs3fOWargxiHlk4FtsPsiXfnqBaDjKdCBNharJyFn2BMdJFWGq/tdNzuLXn9JFi
 s2Aarq/ZwfZl+EUp6KYdnO89NvcjcG1AgXxjZEdXTag8YRUmkXgLf6xIpOGvKStQ4qSra3ITc
 RATATel/zLU3rvtubXIpj3rf67M/eyOa6NfNT7/nDNT8FMglq8sjIUnW2CSw5KGaobfRcnjNR
 YPbc8V7pWmHyNt29MZG6vOjrk5cdHV6i49LPii6W3M9bXs4B5pcovxEFainZQvbrqT4nHN+Db
 gT31uZ/9DXPKHF9XIickBNMmvKI=
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
index b2573eea8a7a..844d255f5d55 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -613,11 +613,17 @@ qcaspi_spi_thread(void *data)
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

