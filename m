Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B457771DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjHJHrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjHJHq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:46:57 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15B12127;
        Thu, 10 Aug 2023 00:46:51 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A31FA8567;
        Thu, 10 Aug 2023 15:46:48 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 10 Aug
 2023 15:46:48 +0800
Received: from starfive-sdk.starfivetech.com (171.223.208.138) by
 EXMBX062.cuchost.com (172.16.6.62) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Thu, 10 Aug 2023 15:46:47 +0800
From:   Samin Guo <samin.guo@starfivetech.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samin Guo <samin.guo@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>
Subject: [-next v1 1/1] riscv: dts: starfive: jh7110: Fix GMAC configuration
Date:   Thu, 10 Aug 2023 15:46:46 +0800
Message-ID: <20230810074646.19076-2-samin.guo@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230810074646.19076-1-samin.guo@starfivetech.com>
References: <20230810074646.19076-1-samin.guo@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed configuration to improve the speed of TCP RX.

Before:
  # iperf3 -s
  -----------------------------------------------------------
  Server listening on 5201 (test #1)
  -----------------------------------------------------------
  Accepted connection from 192.168.1.4, port 47604
  [  5] local 192.168.1.3 port 5201 connected to 192.168.1.4 port 47612
  [ ID] Interval           Transfer     Bitrate
  [  5]   0.00-1.00   sec  36.3 MBytes   305 Mbits/sec
  [  5]   1.00-2.00   sec  35.6 MBytes   299 Mbits/sec
  [  5]   2.00-3.00   sec  36.5 MBytes   306 Mbits/sec
  [  5]   3.00-4.00   sec  36.5 MBytes   306 Mbits/sec
  [  5]   4.00-5.00   sec  35.7 MBytes   300 Mbits/sec
  [  5]   5.00-6.00   sec  35.4 MBytes   297 Mbits/sec
  [  5]   6.00-7.00   sec  37.1 MBytes   311 Mbits/sec
  [  5]   7.00-8.00   sec  35.6 MBytes   298 Mbits/sec
  [  5]   8.00-9.00   sec  36.4 MBytes   305 Mbits/sec
  [  5]   9.00-10.00  sec  36.3 MBytes   304 Mbits/sec
  - - - - - - - - - - - - - - - - - - - - - - - - -
  [ ID] Interval           Transfer     Bitrate
  [  5]   0.00-10.00  sec   361 MBytes   303 Mbits/sec        receiver

After:
  # iperf3 -s
  -----------------------------------------------------------
  Server listening on 5201 (test #1)
  -----------------------------------------------------------
  Accepted connection from 192.168.1.4, port 47710
  [  5] local 192.168.1.3 port 5201 connected to 192.168.1.4 port 47720
  [ ID] Interval           Transfer     Bitrate
  [  5]   0.00-1.00   sec   111 MBytes   932 Mbits/sec
  [  5]   1.00-2.00   sec   111 MBytes   934 Mbits/sec
  [  5]   2.00-3.00   sec   111 MBytes   934 Mbits/sec
  [  5]   3.00-4.00   sec   111 MBytes   934 Mbits/sec
  [  5]   4.00-5.00   sec   111 MBytes   934 Mbits/sec
  [  5]   5.00-6.00   sec   111 MBytes   935 Mbits/sec
  [  5]   6.00-7.00   sec   111 MBytes   934 Mbits/sec
  [  5]   7.00-8.00   sec   111 MBytes   935 Mbits/sec
  [  5]   8.00-9.00   sec   111 MBytes   934 Mbits/sec
  [  5]   9.00-10.00  sec   111 MBytes   934 Mbits/sec
  [  5]  10.00-10.00  sec   167 KBytes   933 Mbits/sec
  - - - - - - - - - - - - - - - - - - - - - - - - -
  [ ID] Interval           Transfer     Bitrate
  [  5]   0.00-10.00  sec  1.09 GBytes   934 Mbits/sec        receiver

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index a608433200e8..76884cf373bf 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -318,8 +318,8 @@

 	stmmac_axi_setup: stmmac-axi-config {
 		snps,lpi_en;
-		snps,wr_osr_lmt = <4>;
-		snps,rd_osr_lmt = <4>;
+		snps,wr_osr_lmt = <0xf>;
+		snps,rd_osr_lmt = <0xf>;
 		snps,blen = <256 128 64 32 0 0 0>;
 	};

@@ -839,7 +839,7 @@
 			rx-fifo-depth = <2048>;
 			tx-fifo-depth = <2048>;
 			snps,multicast-filter-bins = <64>;
-			snps,perfect-filter-entries = <8>;
+			snps,perfect-filter-entries = <256>;
 			snps,fixed-burst;
 			snps,no-pbl-x8;
 			snps,force_thresh_dma_mode;
@@ -870,7 +870,7 @@
 			rx-fifo-depth = <2048>;
 			tx-fifo-depth = <2048>;
 			snps,multicast-filter-bins = <64>;
-			snps,perfect-filter-entries = <8>;
+			snps,perfect-filter-entries = <256>;
 			snps,fixed-burst;
 			snps,no-pbl-x8;
 			snps,force_thresh_dma_mode;
--
2.17.1

