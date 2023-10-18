Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1517CEBD5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjJRXTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjJRXTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:19:25 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2020.outbound.protection.outlook.com [40.92.18.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B073269;
        Wed, 18 Oct 2023 16:18:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FI++m/pd45HSRGeJTJ6H0GR4AdS52Lk5m5fc3lh7eLtByH3Xlg8tj9kMS/TAphp9pF8XbFiUnDnGGg4XSazOxzK3TdhNXWEtn8q2wvI9FDSsxHAYVOU/ptY5EYPXkGs3/FVw5nNptL2WhijCfePjVjLp75IaIQX6sQV3Qch0qSRgvAhWbxus5V+X551lY7EAB98MLiYDOmTCDq4QyfPXlwmwvGSKChK2SG1oZUWPTSwcl47ZGNxqSl0urlDXJxaAPuBhT6YhK7vzyCmV0cyxLTuxuB+aUXIG9N+ZGyrrnmAiqvT8iTYXFqabuzWpoyMtEGCaFV0+M0lidMwi7XfRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=582MOPMCWjoYtgrFOW2pgtTVA6nxyUTk0c8+lCoD1WM=;
 b=KXP2PKmKTrdAHNXur3GnBAYUde6hixh1kiNedONXA/Cow0WKi14NN3A6f44cxnAseGdK6n3HvalmzcEaVqmkAJKJPWE43BtYn1SpGOU5CvKNoLhiYg5bNNFM+HDjrsXTGvYhPIg7WiUrCn4bZ87hty2lRsONGVDj2ge6wPhpB9pRhU97QLSxJoprCiYG4liKHRxmGBAXegq4eTc51NiKb5PoD/Dujf+Nl1agBOK29HmYaYTc4mKr1wm9NeDpSNZ2MO59zZpnwU1pLoVAn+V8Sdm7NCHMcup1uZn+bbXr8RPDutV3rUN0V1HWk0BX6//ZKOsaNFbSgcraPhlB/7qWJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=582MOPMCWjoYtgrFOW2pgtTVA6nxyUTk0c8+lCoD1WM=;
 b=LiiqZuy6z3+xHVb7/A5ubC5yazwm3cXLH8onvzSh5/BCzj8zlkEnal153EyUDEKD3IgngeykzdOlEd05SBzeFNBEOTUoeczA3Rp1VI5wPU376MDCqriFIXtGTisaR/EREaIULD92dEjPqCynXd7w4qbkI3YjWykd3rhBji/lgDRfvA2Z0qp09Ox5ft/nQ5LCMjn3iApGwBSFULjZ7MUoxWBLM5U486s09k0onUMpSoFznIMhUfYwW9sYKLBP8rjDN+RHduNCyLyAfYsXkgumGT0lBxF/C0HVqHxK8/KywNTS2KGc0m2y8lvWHbFF8B5xngoIB9MM475knrlSFr5Yjw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CO6PR20MB3649.namprd20.prod.outlook.com (2603:10b6:5:345::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 23:17:44 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 23:17:44 +0000
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
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Inochi Amaoto <inochiama@outlook.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v4 0/7] Add Huashan Pi board support
Date:   Thu, 19 Oct 2023 07:18:00 +0800
Message-ID: <IA1PR20MB495399CAF2EEECC206ADA7ABBBD5A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Y3YjBzVCFMw78wGdKqQMphN2eLy9DK4LEq8kVZmYKyA=]
X-ClientProxiedBy: TYCP286CA0044.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::17) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231018231803.28262-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CO6PR20MB3649:EE_
X-MS-Office365-Filtering-Correlation-Id: 991da175-f9cc-4805-65a5-08dbd0306ee2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c84eTu+LEa+VE6Q0J0s7MXYB60waJHeDpO+3gO46o7f6HohRw5LZJbhW064lfTp5LFpiK+TELZJoCZSh+DIXo/QkoPHrtbt13VRm0t8xCgx0MIF1tpc9zomHlrqBQm9JrGkZf5IRnwuQEoOL8AatWsfr3so30czak2d6ic9UWUi3itlg84ZejTsRstMN/UQGz3fbXLxbrR+Tw0CzRfIAjL4czKTtfwtkDEU3PCVMWozruKoFMmhI98UgeoaewZI8wyoyNNOsMMjS7uo4eGBHeYRkjS6W/behASX7kS+r6l2pqIYBEak3Sr/Bolw1ID+0n44sMmjSN/3UfS7qWYaNOYTsgk1VdSCXerBt52SBxLDw38oxnoy7ZbdRMef7WnllajHQ2RfDSbAC0mg8yxoAi5YVn174gSSJtHWRpCycSz/1ApFBBr8wbJO7xuqc/IM98JfTZwmTf30sNIgmUNJDrGBIxn9bFY73noDxusLyMuzL3t/Y7DemOuW1IafVHpGSKjpewqZ0/lluQY7fGYuRx69eLiMy3OLb6HILk8UMRGkFOzdoKzX4voigcYcpluH5slJzTaKq7SOrjacyTe+idswie9alkwl3LrAVV6pdH4OE62umYi+HZyQ3nhgkIpRka8cEcSMnAuZG2BIWKJVUpHjBBUXcN7kibiHya2C6mN4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?seen2FLAB13wPcglgTkRmY1Q99XE8vCOyBO/m38DskFbxwz12FFKP+ewFoew?=
 =?us-ascii?Q?MRZJ6wgXtebs3XpRbO9KwyyIrGtaBBL+aWraTOqMDyLkOvqPJ5LekZW9RC3i?=
 =?us-ascii?Q?YECv0v4Ab7ReMRoYwF8cVNv9yg+IV7CD03/JJ05wDZtVkIHA5JSRj3vCm3Bl?=
 =?us-ascii?Q?IYLyYeZOHgUQ9xv3V2tToEvww5vBTinEnz+RsLX81Zg1fOlZnP7QIw0LtTQf?=
 =?us-ascii?Q?IsqrLNeirFeS9qJSqXo/DmaVs1L2dUDyyKSj0D13Iw6wC6piwsFmcATIMvZm?=
 =?us-ascii?Q?VXB/wVgVHmT0yhYHsux2JXE8SWB6suN+ccYnxkUapcuzow4e2BOciO89nXWa?=
 =?us-ascii?Q?EhwraXP9Pp71LlY6ok+j5KMHFvdFJ+soXalR/mqLhz52xqOv0mMhFv/OE/vY?=
 =?us-ascii?Q?9ydhejRzFMIbDS7mTreuIkM+a1wMdUan9la/tQdO+uu++U8ZudVvdupQQUts?=
 =?us-ascii?Q?/RZYVRYZd2q+tsAk7JawZZGpG88NHK8O//gz3scyaoLsj8MDaSEG8yltQO/f?=
 =?us-ascii?Q?fFDlVzqyTlLoQ0I66ycktJAQoD5aUkvqU0sCACjLxvShvXlErds4ZWCANJmt?=
 =?us-ascii?Q?w7El6QtPDcDXuLBTLXIxFMQff/f2xrRHYxr4tgmMIDWogAoT87tHZCTaxVUg?=
 =?us-ascii?Q?/C8QazPjFYMWRh6cBho9NoOzH/1viXQE1CVeCMmdMV/1VjDhniFXDHtvfK87?=
 =?us-ascii?Q?e4XDkz6rxxK6cL8/2UOcP3xHh8IxqwSVyxBAWO1SeS+4MjAv8N78ht7mkJsi?=
 =?us-ascii?Q?HnxJsfum7KvwG42jCIJkzknViU8esQIldEKBP/utye0oDXqpXwZqtwELknwc?=
 =?us-ascii?Q?0nyWvEEXB52Wpq0BG4OueSMEWDlCru5Nrb5PqBOMdnRJq98kLiPZuQTBnPm6?=
 =?us-ascii?Q?coK6+Gwu6DdPt/JRcCcLFPrfnfQOn9JajuPC/1m54wc/88YN6ZRg9IRe446l?=
 =?us-ascii?Q?emrADVbwWgwUiHIUgBKq3+rUS6wV9en3iR8J+7w8jswMcYLfzzdaW/TloRJ6?=
 =?us-ascii?Q?BrNx0AtH3kBYbfsmbf+4J3/0AXSjWKoOY8nyWpKnFcNRX3PRTdj1twLi0LDv?=
 =?us-ascii?Q?sPyRZ94aSEtbr4nGZUyZHo6ioPZCAzJK/0tgaAX18oUben8L0Y/izS7/9btM?=
 =?us-ascii?Q?gtdDSUvhS4nsx5lArbTQEm0Nj2APpOT6NvLWTCP63XO4N7EjirgRy3c6La1Q?=
 =?us-ascii?Q?BJdLppZiyWIoSffHOlCRpMMYKpuYe+UkgmemQyNzkBsWz2CvYSSRRfAxo24?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991da175-f9cc-4805-65a5-08dbd0306ee2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 23:17:44.5925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR20MB3649
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
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

Changed from v3:
1. merge the patch 4 and 5 of v2 to preserve bisectability.

Changed from v2:
1. use dt override to save code.
2. code cleanup.

Changed from v1:
1. split the patch into several patch and refactor them.

Inochi Amaoto (7):
  dt-bindings: interrupt-controller: Add SOPHGO CV1812H plic
  dt-bindings: timer: Add SOPHGO CV1812H clint
  dt-bindings: riscv: Add SOPHGO Huashan Pi board compatibles
  riscv: dts: sophgo: Separate compatible specific for CV1800B soc
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

