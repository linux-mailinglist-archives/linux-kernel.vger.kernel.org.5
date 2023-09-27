Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE457AFA6E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjI0Fzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjI0FzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:55:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56FACDE;
        Tue, 26 Sep 2023 22:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695793675; x=1727329675;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VBfJYfk0/YYZyMKG5AzI3+DC5QI5EE3BIhfCiNwIE3A=;
  b=rXpUArzDux9PwzqK5kqUUKmhP0vOD0K2opQQ4n9f0nGwNeOy8ErLbll1
   BCdvX+BVNIrruphuY+t0rcDDnrlbhTAq+vnQYSVAR7JSbu681DyWqdJY9
   r4CTNK/hRELfRhyZMX9dqTmWJ5pYZQ2Ys78JM0fMh93XFYjHUEu25lIff
   MoaqNfrEJwVneR3yww8MUkDOLZeH21JuC1VstQTUqY0dp8cI0UPfFpSXH
   WYlNKuSzFtRDK2RmNLfAh7N0IVzZSJ7aq3gPapiE9rawTYSMyJZv5wC08
   dkqQLoTiGqEcg6DbQDgdrH+OIm8V7cBykbJraD8Z/mltEl9f4c+PyUmLO
   A==;
X-CSE-ConnectionGUID: md8lycmhRzifJ9LQu6C0LA==
X-CSE-MsgGUID: 5JRrVWsTSI2Urbiqi2zLKQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="7065704"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2023 22:47:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 26 Sep 2023 22:47:45 -0700
Received: from che-dk-testitlx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 26 Sep 2023 22:47:42 -0700
From:   Vishvambar Panth S <vishvambarpanth.s@microchip.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <andrew@lunn.ch>
Subject: [PATCH net] net: microchip: lan743x : bidirectional throughuput improvement
Date:   Wed, 27 Sep 2023 16:46:23 +0530
Message-ID: <20230927111623.9966-1-vishvambarpanth.s@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LAN743x/PCI11xxx DMA descriptors are always 4 dwords long, but the
device supports placing the descriptors in memory back to back or
reserving space in between them using its DMA_DESCRIPTOR_SPACE (DSPACE)
configurable hardware setting. Currently DSPACE is unnecessarily set to
match the host's L1 cache line size, resulting in space reserved in
between descriptors in most platforms and causing a suboptimal behavior
(single PCIe Mem transaction per descriptor). By changing the setting
to DSPACE=16 many descriptors can be packed in a single PCIe Mem
transaction resulting in a massive performance improvement in
bidirectional tests without any negative effects.
Tested and verified improvements on x64 PC and several ARM platforms
(typical data below)

Test setup 1: x64 PC with LAN7430 ---> x64 PC

iperf3 UDP bidirectional with DSPACE set to L1 CACHE Size:
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID][Role] Interval           Transfer     Bitrate
[  5][TX-C]   0.00-10.00  sec   170 MBytes   143 Mbits/sec  sender
[  5][TX-C]   0.00-10.04  sec   169 MBytes   141 Mbits/sec  receiver
[  7][RX-C]   0.00-10.00  sec  1.02 GBytes   876 Mbits/sec  sender
[  7][RX-C]   0.00-10.04  sec  1.02 GBytes   870 Mbits/sec  receiver

iperf3 UDP bidirectional with DSPACE set to 16 Bytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID][Role] Interval           Transfer     Bitrate
[  5][TX-C]   0.00-10.00  sec  1.11 GBytes   956 Mbits/sec  sender
[  5][TX-C]   0.00-10.04  sec  1.11 GBytes   951 Mbits/sec  receiver
[  7][RX-C]   0.00-10.00  sec  1.10 GBytes   948 Mbits/sec  sender
[  7][RX-C]   0.00-10.04  sec  1.10 GBytes   942 Mbits/sec  receiver

Test setup 2 : RK3399 with LAN7430 ---> x64 PC

RK3399 Spec:
The SOM-RK3399 is ARM module designed and developed by FriendlyElec.
Cores: 64-bit Dual Core Cortex-A72 + Quad Core Cortex-A53
Frequency: Cortex-A72(up to 2.0GHz), Cortex-A53(up to 1.5GHz)
PCIe: PCIe x4, compatible with PCIe 2.1, Dual operation mode

iperf3 UDP bidirectional with DSPACE set to L1 CACHE Size:
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID][Role] Interval           Transfer     Bitrate
[  5][TX-C]   0.00-10.00  sec   534 MBytes   448 Mbits/sec  sender
[  5][TX-C]   0.00-10.05  sec   534 MBytes   446 Mbits/sec  receiver
[  7][RX-C]   0.00-10.00  sec  1.12 GBytes   961 Mbits/sec  sender
[  7][RX-C]   0.00-10.05  sec  1.11 GBytes   946 Mbits/sec  receiver

iperf3 UDP bidirectional with DSPACE set to 16 Bytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID][Role] Interval           Transfer     Bitrate
[  5][TX-C]   0.00-10.00  sec   966 MBytes   810 Mbits/sec   sender
[  5][TX-C]   0.00-10.04  sec   965 MBytes   806 Mbits/sec   receiver
[  7][RX-C]   0.00-10.00  sec  1.11 GBytes   956 Mbits/sec   sender
[  7][RX-C]   0.00-10.04  sec  1.07 GBytes   919 Mbits/sec   receiver

Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
Signed-off-by: Vishvambar Panth S <vishvambarpanth.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 52609fc13ad9..6dac6fef7d24 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -1067,7 +1067,7 @@ struct lan743x_adapter {
 #define DMA_DESCRIPTOR_SPACING_32       (32)
 #define DMA_DESCRIPTOR_SPACING_64       (64)
 #define DMA_DESCRIPTOR_SPACING_128      (128)
-#define DEFAULT_DMA_DESCRIPTOR_SPACING  (L1_CACHE_BYTES)
+#define DEFAULT_DMA_DESCRIPTOR_SPACING  (DMA_DESCRIPTOR_SPACING_16)
 
 #define DMAC_CHANNEL_STATE_SET(start_bit, stop_bit) \
 	(((start_bit) ? 2 : 0) | ((stop_bit) ? 1 : 0))
-- 
2.25.1

