Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04EA7DD33C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346328AbjJaQwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346852AbjJaQwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:52:11 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2093.outbound.protection.outlook.com [40.107.21.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2EB110;
        Tue, 31 Oct 2023 09:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xh4YfwoFaW1lfI9IfFTJcZrAeMlNtS+quoX9yQ9Akx/eOr+DPFBfkhl5/oS2ydC7zveC66/LlZZko1NTdnr/r1LGlPWvdBd0YfvDW8ro5NCL5iKb1uqByNJDy+Ux2I9dc1xyg97XbXdNyDV72LuWc+BMHebbC2X6xdP6bIg6s0guSjJzWJp6VuMJNbkvAeqx8gWYvKwkQz5X/82t5RfiOrMYRrblhUqWe785tzvTpw23qUouH+Rg1DH/5f41xTd/HOsEDiLTfIhMZAUjMEWj16avnZqsGf4zkaduACSxjns8Y0EqP/IJPldz39/S5hSQ2FVc70jlvnUnwg7Pl1qLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jriSpEldINkibeuRMne3XwS+Zsq5Mt6gfzXwUjCUC4=;
 b=bMdQ6fVda2m41bzSB5IDifgOkFsiNHQ/Qt8fOll2chnMZyloReGKzx9mpfpJ33gLDZsQxgeq0XsdUCgMEmGWPPeiOwXf8/0HlpbPjp3iq24stcHkPgHwvQ0RyjPoUjCuitKfvJPZ2liUou4Gnnv19ZjHmnYQ5CikP4xH7S6GoghTI0jFyjOk93ZZR5ytP3+ttOLLojT4c81RfX0fvW8pYN9VB+sD06sHE/hjV3HM1hCOSJJTs/ItL7cSxwWOTOswARgoCNhwK9TfzOPWmCU+OhDTPHMtc6VeFDNfjo9rrTjyJWradIaiZLJZgPsPiDd56hoAMuWTDwNeux7vasaCHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jriSpEldINkibeuRMne3XwS+Zsq5Mt6gfzXwUjCUC4=;
 b=etJQA32ycZC/kHIr9kc+LIPtQj9gHDpGdDsC36qdOxB3P/3gH4F5D87Rlze6Jc0+tSnO/P9y0XlT8JwsIC3+csvY8D6PGiOtyDjIbV23ZY/6bhnpOna9fBDVb2OvJMmAcOqitxGDHqvKho0G/oL8IHTF17hIrLsFmgslvRgfOcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 (2603:10a6:803:1e::32) by AM9PR03MB7187.eurprd03.prod.outlook.com
 (2603:10a6:20b:26f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 31 Oct
 2023 16:49:36 +0000
Received: from VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa]) by VI1PR0302MB3486.eurprd03.prod.outlook.com
 ([fe80::59be:1f7c:f22b:baaa%4]) with mapi id 15.20.6907.032; Tue, 31 Oct 2023
 16:49:36 +0000
From:   Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Aleksandar Rikalo <arikalo@gmail.com>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH v3 00/11] MIPS: Support I6500 multi-cluster configuration
Date:   Tue, 31 Oct 2023 17:49:16 +0100
Message-Id: <20231031164927.371663-1-aleksandar.rikalo@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0065.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::18) To VI1PR0302MB3486.eurprd03.prod.outlook.com
 (2603:10a6:803:1e::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0302MB3486:EE_|AM9PR03MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 8434a8a8-b0a0-4926-fe7e-08dbda315d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXnbjSAgfW7s01pOcphNFAZ/v6X/32VApVuqx+UNvmEf6GR5WWr0+7HfIB+9Nthv+VywZq8cmUpTYEdkKJ1aenR8d1uLw7A+9WZ1qg+oGkYtN2R1OGVYLwJh2In3paDN4Rn9KweHaO8kW8P8nqSNRnZLw/IO+nqckT8NTwG+IH5dr6YZzoH28aLOnntIgyVu5/dOIBF65j75tbySoOr0emdYntWMSb83DDmj3yMxttmfZmEjaaV5Z6JRiM3njiMftSEg3VaNU+y8I5+GpkzK2bSoTTOWlZctiSV20s2SphjErDY5tJb8vsl3gkxI8thNSucPJ2d79awSCh3PBwy9TCtuyG5pBipkBs2CmE3CHGX6tT/A1WXiCVq/jMU9hH7UUrlC3VNfnKzZEznhy9zaiXetVTjQruVpabZqJ2ZM1bgYSWf/I08rFRbFc+f69zE0IF2Rqvg7U8y7CKmgXgZ99rU99NcOvDITKXhCXoRE5lH1q80Olw3X7xttvAbkgttReHr55NveSc7NjiUwDWa+jR9qEZpbvExet2f7me+Wria1QOsVtHmsFGGxzCiiZqBCgQRXM3OfYbSpCzoypw2vLHt2ihdnZy3q9KdPhe8TJDzlJv9Q+hRhQpUv5gYcHxKL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0302MB3486.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(41300700001)(44832011)(316002)(54906003)(6916009)(66946007)(66556008)(66476007)(8936002)(7416002)(478600001)(2906002)(4326008)(5660300002)(8676002)(6486002)(26005)(52116002)(6512007)(6506007)(2616005)(83380400001)(36756003)(1076003)(38350700005)(38100700002)(6666004)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pKWChUnbX+w5e4u9iD7LHLDB/DrHrYb7esRuYk+S47epkkaEG5SR/klqPhqF?=
 =?us-ascii?Q?6xWSONRLDWsDGGeXX3c5WvzcpcQTEiaSL6RIrrpKs5J+uajNOpIQkuWU836J?=
 =?us-ascii?Q?IUs0sEG+/4zT+6wwwWAF8fYYDrZPnBbgVTblKYDl8Z3sSX+sy7Bur87tAbLM?=
 =?us-ascii?Q?oVNkjo/otwvnUD/EDozjsnF34SZtGyzAcIIgI4+5DRGVA2e9fxTbPB8AX3jn?=
 =?us-ascii?Q?tY1aMfZFa6moc/yA6Ks2Z4BOzjupVY68D+6uOgyFQBHOZzGyzVp6aZSxIuh4?=
 =?us-ascii?Q?YJm3LCQUxAEPtIqiqLKWV2ZxR/pTlu4Ha3q+nZaTOecMRtwTkm/WmDptB/3X?=
 =?us-ascii?Q?yJq0/PZrdj5ZLQu89l8xQR1czHryxRKpxH9X3iS05Qm7xvrTNR1tSzY1vZMy?=
 =?us-ascii?Q?ZaOCgVOn25dZJwmKY8+PPQOM8MKKBuWI2IKNAOMY9qkCbn0ZwECUg3Boafod?=
 =?us-ascii?Q?g5tD3NaFqXf1OSmaKp6zX5yeHKH8ZAyl9pwnMyJtexK6aQtLxBcjz6bZgxqu?=
 =?us-ascii?Q?ZNNNBAp6PyRUXUyVJHFuPB/XT9OSanbScjb9dtcsm3pufXT++fpcO41HSUWF?=
 =?us-ascii?Q?zxFKdr9Qv1RQOPaAeDjt2jfiQTSeYUHlz3X+TKb/G635MsR8qxR4iYefftEO?=
 =?us-ascii?Q?bTfkW4CGcgYlqb2y8TC40RIARHyQwpw2UD0czZDHjvX0Dba4vAhEfw3Rof+y?=
 =?us-ascii?Q?+v9Ea+SPHwq4hY6l+p2NJVjJKRKEaTKoVIidKCPA/16qW3J+cfWN57xRTIyX?=
 =?us-ascii?Q?a2pFsaoa05Vu86332OAK9kWihM4B/oFQu8eAW/xlqO3jS5ETrDsJ7smXCMc7?=
 =?us-ascii?Q?q/havzqULJdHucmOTWgYs3st1Yc5+w7QJzjwnvFGHqGqH9VP8PChYQDQexK9?=
 =?us-ascii?Q?hCn+jHd2tL7TXJ84WDV73z653nW+Hf1Fw/gEXUZLmjhPgCukrELzvh95DJSr?=
 =?us-ascii?Q?hYA5S3iKuc1e0OpaaZE/jwrRXB/kO00djg/dKkhdNNPf0lPkun93NTy3Ir33?=
 =?us-ascii?Q?m8kYBDEL5l9PiTDQnnsefj6eP9x8MXrvEYqg97mvn/JXTCAgOOKj7QvS3TYO?=
 =?us-ascii?Q?G2Ymjhk9xBYHUkUCSUcrx4jOJEoLc+XAWfpcna1BIZMyqmjn703HjT67twm+?=
 =?us-ascii?Q?IgijnP4whvf4EGeDjIuQZP4Gcr45eEanxA7LB/h2PaCL8qO08i4tAFHv5Hkf?=
 =?us-ascii?Q?nc7rEdKPQlJME5dRwysxdTmUl4wfdm94oVtN39LAa9aQTq9roHnjk7tcVM2N?=
 =?us-ascii?Q?w0o+zmVaO8Z1M9/c56ZksQZZx3HxBSV1/+pftSZ5c80GAPqSahUtWFdTWUC5?=
 =?us-ascii?Q?Ozg4N2AX9KUqdzZLRRpyR5xrkNxuf3SeUT/ri9NXF2JMEQV8xI5ygHuXU34p?=
 =?us-ascii?Q?zqKJwqlM8kqnJPBj2jeL8vgLJYCJjhRuZwqqn/LwLJyRX53jY80dOciqAzsA?=
 =?us-ascii?Q?4RlOQ0nXtfDQWgYHNExRyeHlgc3WWgKYqkF/JOvnYQiep4UQcZVb3asLgDz8?=
 =?us-ascii?Q?O0WxM4sUTXnzzcSYCzoF5zKafvpOkXdm/V+o1dKEN4XUz/3C+sAfeLjUTJAd?=
 =?us-ascii?Q?q51Wo6uAs67XHXFVhzV4yvsqjgJF49vpChsKNQh/9xchqexJAfTEJhUxrFub?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8434a8a8-b0a0-4926-fe7e-08dbda315d72
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0302MB3486.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:49:36.0555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EYuZ3tgaYEwMmXbZj2CW58exesLlM7m1qgqWF0RqXlV9vG9qXNhKQ1dVRFqvj1TBJ8y7ocUYZECiAJWePbFWQgjZMYcL/NUu2khWqQ/iQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Taken from Paul Burton MIPS repo with minor changes from Chao-ying Fu.
Tested with 64r6el_defconfig on Boston board in 2 cluster/2 VPU and
1 cluster/4 VPU configurations.

v3:
 - Add Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com> for the patch 02/12.
 - Add the changes requested by Marc Zyngier for the 3/12 patch.
 - Remove the patch 11/12 (a consequence of a discussion between Jiaxun Yang
   and Marc Zyngier.
 - Re-base onto the master branch, with no functionality impact.

v2:
 - Apply correct Signed-off-by to avoid confusion.

Chao-ying Fu (1):
  irqchip: mips-gic: Setup defaults in each cluster

Paul Burton (10):
  MIPS: CPS: Add a couple of multi-cluster utility functions
  MIPS: GIC: Generate redirect block accessors
  irqchip: mips-gic: Introduce for_each_online_cpu_gic()
  irqchip: mips-gic: Support multi-cluster in for_each_online_cpu_gic()
  irqchip: mips-gic: Multi-cluster support
  clocksource: mips-gic-timer: Always use cluster 0 counter as
    clocksource
  clocksource: mips-gic-timer: Enable counter when CPUs start
  MIPS: pm-cps: Use per-CPU variables as per-CPU, not per-core
  MIPS: CPS: Introduce struct cluster_boot_config
  MIPS: CPS: Boot CPUs in secondary clusters

 arch/mips/include/asm/mips-cm.h      |  18 ++
 arch/mips/include/asm/mips-cps.h     |  38 ++++
 arch/mips/include/asm/mips-gic.h     |  50 +++--
 arch/mips/include/asm/smp-cps.h      |   7 +-
 arch/mips/kernel/asm-offsets.c       |   3 +
 arch/mips/kernel/cps-vec.S           |  19 +-
 arch/mips/kernel/mips-cm.c           |  41 +++-
 arch/mips/kernel/pm-cps.c            |  35 ++--
 arch/mips/kernel/smp-cps.c           | 297 ++++++++++++++++++++++-----
 drivers/clocksource/mips-gic-timer.c |  45 +++-
 drivers/irqchip/Kconfig              |   1 +
 drivers/irqchip/irq-mips-gic.c       | 276 ++++++++++++++++++++++---
 12 files changed, 702 insertions(+), 128 deletions(-)

-- 
2.25.1

