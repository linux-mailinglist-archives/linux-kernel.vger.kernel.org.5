Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812257771D9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjHJHrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbjHJHq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:46:57 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FA31702;
        Thu, 10 Aug 2023 00:46:54 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id DEBE78565;
        Thu, 10 Aug 2023 15:46:47 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 10 Aug
 2023 15:46:47 +0800
Received: from starfive-sdk.starfivetech.com (171.223.208.138) by
 EXMBX062.cuchost.com (172.16.6.62) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Thu, 10 Aug 2023 15:46:46 +0800
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
Subject: [-next v1 0/1] Fix StarFive JH7110 gmac TCP RX speed issue
Date:   Thu, 10 Aug 2023 15:46:45 +0800
Message-ID: <20230810074646.19076-1-samin.guo@starfivetech.com>
X-Mailer: git-send-email 2.17.1
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

This patch fixes the StarFive JH7110 gmac TCP RX slow issue. And it has been
tested on VisionFive 2.

Here is the result of the test (iperf3):

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


For more information and support, you can visit RVspace wiki[1].

[1]: https://wiki.rvspace.org/

Samin Guo (1):
  riscv: starfive: jh7110: Fix GMAC configuration

 arch/riscv/boot/dts/starfive/jh7110.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--
2.17.1

