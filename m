Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2F77EDB49
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 06:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjKPFnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 00:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjKPFnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 00:43:53 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C9D98;
        Wed, 15 Nov 2023 21:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700113429; x=1731649429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YR6qpSYee3uoyE22ZksOZTFWGcADilp6yZ9jjUZdsQo=;
  b=AZYpptbpA/BOrbYLqh7pkvKsm0O7wXcNsAg+7UYs83ZBzyJ9eD+o/VDz
   Fyb/atmIM7u+tEotjtrQ+ggBKx0kDYmgepzvfIKrZQgmvVqfjHU1CsILN
   bJRODl24I9fOUv/EVkYtCfC9s0LXDZGWmqrtAI+rhZf5DBcsycmhnHNdy
   7Zp1zwMOpYhj7N9aRxTAIYZgtn9zo1C8JrE81l0vyStyxo3dHSUwuYsXP
   EU5ec3SZQrr+8GFEOeJUgqj1k+xCrXCi9l975cfzS8oam0OmgNZqOHf/e
   ZWd2og8pZHBnVnDJ5+YkyFc7D6ujNHnDylCwN2Yl8kRm2hGt96k5W8hDY
   g==;
X-CSE-ConnectionGUID: wRN1xPZvSQCVlzVPey4TSA==
X-CSE-MsgGUID: uoLZKQB9RF633Z4KKzbwDQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="12057309"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2023 22:43:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Nov 2023 22:43:37 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 15 Nov 2023 22:43:34 -0700
From:   Vishvambar Panth S <vishvambarpanth.s@microchip.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kuba@kernel.org>, <jacob.e.keller@intel.com>
CC:     <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>
Subject: [PATCH net-next] net: microchip: lan743x : bidirectional throughput improvement
Date:   Thu, 16 Nov 2023 11:13:50 +0530
Message-ID: <20231116054350.620420-1-vishvambarpanth.s@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Vishvambar Panth S <vishvambarpanth.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index b648461787d2..be79cb0ae5af 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -1075,7 +1075,7 @@ struct lan743x_adapter {
 #define DMA_DESCRIPTOR_SPACING_32       (32)
 #define DMA_DESCRIPTOR_SPACING_64       (64)
 #define DMA_DESCRIPTOR_SPACING_128      (128)
-#define DEFAULT_DMA_DESCRIPTOR_SPACING  (L1_CACHE_BYTES)
+#define DEFAULT_DMA_DESCRIPTOR_SPACING  (DMA_DESCRIPTOR_SPACING_16)
 
 #define DMAC_CHANNEL_STATE_SET(start_bit, stop_bit) \
 	(((start_bit) ? 2 : 0) | ((stop_bit) ? 1 : 0))
-- 
2.25.1

