Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD057EBC3C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjKODlM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Nov 2023 22:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjKODlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:41:10 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40A1C5;
        Tue, 14 Nov 2023 19:41:02 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 2330524E2BC;
        Wed, 15 Nov 2023 11:40:50 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Nov
 2023 11:40:50 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Nov
 2023 11:40:46 +0800
From:   Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] StarFive's StarLink PMU Support
Date:   Wed, 15 Nov 2023 11:36:06 +0800
Message-ID: <20231115033608.1597807-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
- Change compatible field from generic "starfive,starlink-pmu"
   to "starfive,starlink-500-pmu" with specific IP versioning
   in bindings and driver.
- Fix warning '-Wmissing-prototypes' reported by kernel test robot,
   by appending static to starlink_pmu_set_event_period() in
   starfive_starlink_pmu.c.

Changes since v1:
- Change 'depends on SOC_STARFIVE' to 'depends on ARCH_STARFIVE'
   in Kconfig

----

This patch series adds support for StarFive's Starlink Performance
Monitor Unit(PMU).
StarFive's StarLink PMU integrates one or more CPU cores with
a shared L3 memory system. The PMU supports overflow interrupt,
up to 16 programmable 64bit event counters, and an independent
64bit cycle counter.
StarLink PMU is accessed via MMIO.

Example Perf stat output:
[root@user]# perf stat -a -e /starfive_starlink_pmu/cycles/ \
        -e /starfive_starlink_pmu/read_miss/ \
        -e /starfive_starlink_pmu/read_hit/ \
        -e /starfive_starlink_pmu/release_request/  \
        -e /starfive_starlink_pmu/write_hit/ \
        -e /starfive_starlink_pmu/write_miss/ \
        -e /starfive_starlink_pmu/write_request/ \
        -e /starfive_starlink_pmu/writeback/ \
        -e /starfive_starlink_pmu/read_request/ \
        -- openssl speed rsa2048
Doing 2048 bits private rsa's for 10s: 5 2048 bits private RSA's in
2.84s
Doing 2048 bits public rsa's for 10s: 169 2048 bits public RSA's in
2.42s
version: 3.0.11
built on: Tue Sep 19 13:02:31 2023 UTC
options: bn(64,64)
CPUINFO: N/A
                  sign    verify    sign/s verify/s
rsa 2048 bits 0.568000s 0.014320s      1.8     69.8
/////////
 Performance counter stats for 'system wide':

         649991998      starfive_starlink_pmu/cycles/
           1009690      starfive_starlink_pmu/read_miss/
           1079750      starfive_starlink_pmu/read_hit/
           2089405      starfive_starlink_pmu/release_request/
               129      starfive_starlink_pmu/write_hit/
                70      starfive_starlink_pmu/write_miss/
               194      starfive_starlink_pmu/write_request/
            150080      starfive_starlink_pmu/writeback/
           2089423      starfive_starlink_pmu/read_request/

      27.062755678 seconds time elapsed

Ji Sheng Teoh (2):
  perf: starfive: Add StarLink PMU support
  dt-bindings: perf: starfive: Add StarLink PMU

 .../bindings/perf/starfive,starlink-pmu.yaml  |  46 ++
 drivers/perf/Kconfig                          |   9 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/starfive_starlink_pmu.c          | 654 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 5 files changed, 711 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/starfive,starlink-pmu.yaml
 create mode 100644 drivers/perf/starfive_starlink_pmu.c

-- 
2.25.1

