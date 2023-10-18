Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A0E7CDA59
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjJRLa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjJRLaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:30:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2043.outbound.protection.outlook.com [40.92.19.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327A910F;
        Wed, 18 Oct 2023 04:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+TZF7kzTcMTWgOV8LgQgrGYIMrG43RMPFyDs/5WrDMUVakNu8XCsJQkXkZrIISY6Oxj319y6CQjS1feNvpQOIzZu7DFSAV8787PqIZF0b3K6WVdUamNIyNIrYgjnjwHFoKkMvvTuojZFjA/7zTdFcKKg1uYa/5dT9pk03BXDxyPwdnxdiddeWxAhLg1Fc/eOmTB+SF6DBng4I1V3rgbrnnKFSYKN0TJnx/+ezkaVISwGhIisil3Xb6J3a/bJaJD9cFBul/pE+W2+W+jOGvRgGlqfbmJHJVwTVFztnQKZICipb2Ufxr/tpGnSVrRt8cqqkGYfmzttD7bRHBrrBo9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmF9y8nmjJXKvRBJifeR5HdGVzzGW1tw5HGH5RUvpMQ=;
 b=Ulnxzov4qzxKWeRFqdYqEtPlMp1xuoGO5e1rFbfvBuhakLvNr/PZHgQuviDgaSXxLn83CMx0ZiwsAHp8hWNzgpr3O9tWe1CYtuwVHMBPifW+6TErQ/pFkX2iY+Y+kSltl+IjAjxFY+1pJw4nlaCpbbYSdF/M1Eef8htAR6HKAbe8iJ/HO49frQNjJItxtmt11NK7zAxXe52Os1z0VZMQoE/mskuCOOtPH5z//JK8alfxv3DmgPqDj2Djvhja8a2yLAeAvmofFqJtazReZWu7wiCIqAEynRO5OEHqqxZsKdhgHYcB1EruqUIJydtn8JEhkw6mc6MSBX4Tmy5HYjOK2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmF9y8nmjJXKvRBJifeR5HdGVzzGW1tw5HGH5RUvpMQ=;
 b=tbum83Qn+vADq7ke98R3jcqsM8mVQ9gYPCoN48MD3SFN9sN84uiXYpbbVR9cOPcghvnaFKhXo8fFx09Kc++erKmDcDe7gZLbmaWWgqEvU7hxO+fWibYwC8BLWCxcpHA0N43fUtmE8vKFZeoYkYYu3zyA9tThmSsyCZWqisGcCrJTSyX2wQER4mLPt2CbrXxYEp674NkFZPl8w4J9J5p58qi8CGEr/P2xV9I0d1P/Nwgw6J/2CMzXtXPkd5JvCO/rUbnQq8k5l3yoDvSajhgr0+ggX2DGba00S4Apjnh194x+y5LogZkFmMGYnL4hfVJmvAEeB6JPNAMkH4uCmPRAsw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH0PR20MB4059.namprd20.prod.outlook.com (2603:10b6:610:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 11:30:50 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 11:30:50 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 0/8] Add Huashan Pi board support
Date:   Wed, 18 Oct 2023 19:30:52 +0800
Message-ID: <IA1PR20MB49538F60A390CA74EF1D16A2BBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [MnphO5VqSjehvkmyGjRHCjMGY4+dXs/st0Gl0OggFGk=]
X-ClientProxiedBy: TYCP286CA0129.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::17) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231018113055.1605263-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH0PR20MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: 55217145-a0a9-4861-71fa-08dbcfcdae15
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yR83TfUdUppMzvIHWR8iNv1tQNxG9b79XUTthnNZhBhlbtK+giP95p52mQeuUN7WveATlUOCUkTmglPDGlg1MDC9Ki6URn+JUfpXeI8nByd/pO+mGHLEghg8CseLjr7uzFOChaoSR3IA7pv3xRVguvrBJa9Ui7SuO2b7bR47eKL7XYT7k6gtxo1uzZAdOTiVFWSKCGBjIhsT6U9xOTpgdP8E6gcS2muQ0d6mPxIT2aTpCMYIwwSYsDWpqjw3sdJVWGVngyl9mE8VZNwkliEf4zvoNAAh+Pl23uWqUZFU5mrGnfrsKXPGwHX1mkV7Jy3gORhBQYquzM42PJ344EKZ2a5MHYYgsfKpYgdBGET31Zv6bDcGc/P5G622/qB9WSyN2Nlux4/5GjUTElvWdd0hXSHkyE08mNJt3lIMbP1HVwkBSUeiW0jaFhUNBmYzT7WXtU9jDMU7zD9B7EXjwptu85ab1AeEYLVsHLe0F6gKrF2NWVNzv874uoxaN4BFfG2oafHgHvhgz9lmDCuu8OEojyc6n0eUBtfzNTk2M2gKc2Ji7sIN1GNZ90I0yNQ/qxqov8bQfJ/+YMgzjv9dSkDlgGVXGJIQ5aaKBgiDsDPErkgd40keJnXW9zJD00VMyDVaarw8x0pV4NCrKUfXOfMAKVvbCIwqp66XBnGW7QCAcwc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zjW9A2a5jjbohgj0LhMfDxe/VfzhFSvy/FT/ROcm/OPwQuFxI3srYYitaADy?=
 =?us-ascii?Q?r2LZeSipIYk20PSIg9M3rtM14QVdNf2qBdBl+xwqcvM3rPRF2jfhHLdIMz/N?=
 =?us-ascii?Q?Hi6Vrs1qwQsZk0S1mxA1uc+edvS2IV7Hb1FZS87hhMj3RZ/TxPtMLpGMxMGJ?=
 =?us-ascii?Q?bVO/t6cbLShPnVIbwwoe5Tl7270GSAwVWqXma+c7Yfh5uhwEkr3RufJvd8yd?=
 =?us-ascii?Q?M5hTMLyVouLXjxTIq/DAldCZXY+40QvOaMeA7jmAxVW+akAFx8u2Eq1oQxLf?=
 =?us-ascii?Q?pZSAqRuTkXEMQy7K5bbeZ3flub+AEKchL02EJiZRGS6djMeoaFbzRV/4m5l3?=
 =?us-ascii?Q?+xH+bKUFm5B921FHp2ZStfVLB+gVbEl0zTeh89qFV0wHkTCCci0ViK9KoM1Y?=
 =?us-ascii?Q?wcr4vKsvgVk4a0vZ6tAdsyLFJs+GaLztRavDdPpf+esM+kTJNR+vGC1oTcmJ?=
 =?us-ascii?Q?NDpro2TD5JARl1lTPxgq6wx4Ivv+2ZNbGEH0tx7Il05c0EmgYTZduLue/V2B?=
 =?us-ascii?Q?H562Vun7JyiazKowjt5d8QVaKKmZ1WHakQ7VO4nAK9Hv5wvAQewSGgYm4z1+?=
 =?us-ascii?Q?CGfBzJD8TDNarh256gZD8egLtfHzt8ZVIkj0HqxHXqTv0IWVwnMxvt9KC7Lv?=
 =?us-ascii?Q?DthbIh1C4xBTbP5JO1eWIjTT24Rq+FI03JVBc09C0qypm1lyoqodrUtEMt4b?=
 =?us-ascii?Q?0L/XC8wf7QLC8H1i0RR5obGcRXbER54znS6jkbHaiYO5DwAZK2rGFe5WxXhv?=
 =?us-ascii?Q?z5vFNjkaauvbHl6J0VBBRcuiHRpzkVdk82fUoYmYO9LZIC8YHLJI2pQriGAC?=
 =?us-ascii?Q?SqQnDLnDF75nKCCxPTtI2cfhprfsX1SxOSzV0c3ApRKlYS7FhfCrp+YQYGoX?=
 =?us-ascii?Q?tyf7G2tlXj+V7/sUglfXg3F8AjyxS2+9X0LdbU4Wu+wh9IqUnsJiBnx1GOQa?=
 =?us-ascii?Q?RgTbLsWLHK3SWNQZTVJfZbdcapvCQdRYwBZslHgRG+fRQwQ3wrkQ2/pzHXMH?=
 =?us-ascii?Q?5YNPVwKqyrPr2vEKCQr4U+uYYiioXyteZYlsYbBS25iUpwRLCApmm8WpHgir?=
 =?us-ascii?Q?Z0TBSdcUvLvJbQxzS25qr/k/9XZaGLCAHlssSdMglz5c9spPgjz7jVsq3t5U?=
 =?us-ascii?Q?M/9eOqcM2EJbaG2KA71HIvkg91n6Ilm5tj39cVSIsD5luvlJzEvJwNKNRDQU?=
 =?us-ascii?Q?ukhU2Bcpe/JrtSUrvIXCPrAC6bRONEzZgxxzCj/fhXuKhOS35L97O899uqA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55217145-a0a9-4861-71fa-08dbcfcdae15
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 11:30:50.2265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR20MB4059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huashan Pi board is an embedded development platform based on the
CV1812H chip. Add minimal device tree files for this board.
Currently, it can boot to a basic shell.

NOTE: this series is based on the Jisheng's Milk-V Duo patch.

Link: https://en.sophgo.com/product/introduce/huashan.html
Link: https://en.sophgo.com/product/introduce/cv181xH.html
Link: https://lore.kernel.org/linux-riscv/20231006121449.721-1-jszhang@kernel.org/

Changed from v2:
1. use dt override to save code.
2. code cleanup.

Changed from v1:
1. split the patch into several patch and refactor them.

Inochi Amaoto (8):
  dt-bindings: interrupt-controller: Add SOPHGO CV1812H plic
  dt-bindings: timer: Add SOPHGO CV1812H clint
  dt-bindings: riscv: Add SOPHGO Huashan Pi board compatibles
  riscv: dts: sophgo: Rename cv1800b device tree file
  riscv: dts: sophgo: Separate compatible specific for cv1800b soc
  riscv: dts: sophgo: cv18xx: Add gpio devices
  riscv: dts: sophgo: add initial CV1812H SoC device tree
  riscv: dts: sophgo: add Huashan Pi board device tree

 .../sifive,plic-1.0.0.yaml                    |   1 +
 .../devicetree/bindings/riscv/sophgo.yaml     |   4 +
 .../bindings/timer/sifive,clint.yaml          |   1 +
 arch/riscv/boot/dts/sophgo/Makefile           |   1 +
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 119 +----------
 .../boot/dts/sophgo/cv1812h-huashan-pi.dts    |  48 +++++
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi       |  24 +++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        | 193 ++++++++++++++++++
 8 files changed, 279 insertions(+), 112 deletions(-)
 create mode 100644 arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
 create mode 100644 arch/riscv/boot/dts/sophgo/cv1812h.dtsi
 create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx.dtsi

--
2.42.0

