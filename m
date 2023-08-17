Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAD577F05B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 08:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348178AbjHQGEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 02:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348168AbjHQGDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 02:03:39 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2123.outbound.protection.outlook.com [40.107.93.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6DE2D56
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 23:03:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOJb02Kgm5LBHBDpiaV1qvqBebceHYXhisr+NZ0Lpx05P7pEyhwRcGp1vZcSSt3P+Vwo9WFDRwF3u7qLR367HRh3GTLo+vAyzfO+s/S1YnsfPYO0QT9TTLGCpUmglN9F/3y832KGPwVsy9fNd1r5/ft12serWy0O7d30zx9TCwZVy2c9uH8CRxSXkwEcjNLICZZYFUgx9qtJ6B3DFP0nn6l1TNwtBUbf4PK+X0j5dFs2AcTDRvSlCcDt/R0jIwQ42DD32BvR9j0rioJpK+68dTpvLrcUEYJW0MEyBAz4i2Qhxfppe2iH9VMwuVz6wogedHJ/+lE57gKJUjBoFCnrLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+9C6B7WScMrstTmoeb0PyKUYfP8W/AiqHCbUQglK6E=;
 b=a1QugVaeINtjaSgoNMcgnFaLhnZStzAt8eqaIN+UCAOhiZHN1R6/nYXqmxnh1KSYBsOiCoIng0tCg5BB6KDJfpyeoMJIRKERP092Gjx4cw/Tw7i+ro3DQpdUZSU3T51c/mOlHBidVHQL/Pooh83cKgTkD2u35sHt1uh01IFeCbMRsGP3L6SS2FDeVKbxY7g+Iw+ljMshRl1FX0qZEuDzrTX28ff2AgKYuksKPRuula5Ubb3O2vrLRfnlu8kZrU49k3uQkBJelh4aqQ9fIGzy3Hui9hYevqHfoqN8WIpTQ2RX/uI+M1fht+IKSa8SSgvspQElMxnxYWq2SHDb2BMz5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+9C6B7WScMrstTmoeb0PyKUYfP8W/AiqHCbUQglK6E=;
 b=rQpYtsIC2q5S5v6IR+k9s+t9Tu0xkNy/2Uc/bi2KSqaPh+Nnm3nEjCVkK1vGoKTgzCR2IV6hpRw+7gMnnkGfoR/USqW7auzyFaP1D8vONPWeem2cnGFlI5ZEWY04+ToCezOZ25HUGwHmDEcBE5vmjNjWuujcb7Xzxjd3gzksaQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 SA1PR01MB6592.prod.exchangelabs.com (2603:10b6:806:185::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Thu, 17 Aug 2023 06:03:34 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40%4]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 06:03:34 +0000
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To:     linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org
Cc:     christoffer.dall@linaro.org, eauger@redhat.com,
        miguel.luis@oracle.com, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com, gankulkarni@os.amperecomputing.com
Subject: [PATCH 0/2] Avoid spurious ptimer interrupts for non-zero cntpoff
Date:   Wed, 16 Aug 2023 23:03:12 -0700
Message-Id: <20230817060314.535987-1-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:610:59::28) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|SA1PR01MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 5819036a-63ac-4d33-ec95-08db9ee7b083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDyuNEdqeAhyG+hlsWdB0qP3ZSOjkXrnzxg4ppubMxuQ25IRMBOGrvq4FYSWh78iFVJ8ostL78W3BZFHiBnPrhrVok/FvZPky43OsnT1zppwm6B0xx7XW6yFvZ+0xM3r7FEz0UmCNhvPJy8ARmnVczSzOZ52QgLkLYzismEawDAtaXcuHVmJdF2Tjo1AbxkSYJSmcrqIEGhlA4Sd1wnkuGOKd3P2sEgSYYRC6e0eAyiETT0d3mM2nO+xXSkmd3Pq6BOsgfdrL63y6BefNa35kBJtkI/ZbP5FX/r3Jbb9ErdWDyk4m7PCFBGsA2lhoCLT503Zu+wWIfVnGJUWp4w+Mo/UmB5sSngXRUQGzvTAI5xsAutmFoy2U6hxHbjinCVuNO9yNTNVZJ6Is0jPxgoxnaqStMqklyRq251lnix0fisVaypqBNOLwsk0UiRmTwGcUUMkmCax5LfEdhAtjtR1k4K2+EJLGrKS5uJDu4+Q32YP8vJm1vUX94dpWVc0HPDX0bwCyz2Z7DeFshGWNZOO2FkHlXdQilkAu4nMDnyPLWhadeTH9nwhwtoSU0y+k9e0MC92mQrtyRqzvvq/Mp+enxyumxzUC5xMseYCOf93jXwMVCQYmp84fE9iJXqcyEK6+1Rf6kkmL9p1NGqk/UUgLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39850400004)(136003)(396003)(346002)(1800799009)(186009)(451199024)(83380400001)(2906002)(478600001)(66946007)(66556008)(66476007)(6666004)(6506007)(6486002)(52116002)(316002)(966005)(107886003)(2616005)(5660300002)(26005)(1076003)(6512007)(4326008)(8936002)(8676002)(41300700001)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WrYAYCeFehmBglJQAHEn71kOnA8ZezQGdLMtpo3NR4Va5OJZjSyRb4n/2z4k?=
 =?us-ascii?Q?e7UY0rN1ULowTdkN5+6Qi31H96GD2m02zYmJojpkwMYL5O5nh/7KG0gJMxrZ?=
 =?us-ascii?Q?2lZ2SYPREjnW6hJtixVMOQYg36ILh4Q4+H0Da8W38cwdsnBXdDlRPnrkOB6N?=
 =?us-ascii?Q?wWOGEtfSeSsxGQgURQcVO6dhByi2ZOVPVuVLuIsU9IULq2GgyJuM6F4DRXEm?=
 =?us-ascii?Q?H4JA7ZkA2foksfkuiYyyCIMJ5wEBBBO2MuJXFCbWKwK1ZwIZ4+J8yIamDQR4?=
 =?us-ascii?Q?xUku29pKHlkpvJHrXHGFKxs0kqaAeHJ3q3zNc55g1xt4MC0jdQ9Gr46ApZIj?=
 =?us-ascii?Q?o31ocO7IQVZgP+J9yEyYuZpKwULk20+cIwSySq7WiqKRK+8lz/W3Qe9DshZN?=
 =?us-ascii?Q?hMaRxuWKB3sxbHmCalI4hpoAkn97Ao6NItAPjztpLE+FXwGmzrh6AIDYbvRf?=
 =?us-ascii?Q?zgpAXuPCAS7hXj4uIf7fDen/11DbHfTo3Wh9kq5RkvTrODbiJrlxRvn/3HgL?=
 =?us-ascii?Q?WPKI9odJ8Va92IljT79x7aqj3LAK73ZkW01r9x1F2DMEMwCAUZ+DkUSz8OxM?=
 =?us-ascii?Q?gKX69oXD3KDQuH2tuiqQ5omGnZx/8Fl8J4yYAIk9mmnfz4IH3vPfu9Qo7KB5?=
 =?us-ascii?Q?Xyzyzv3ZxgiF48aN9M+TJeiC7A4dKY0vkyENSQRtTCKGIqY35wmtn+KEOzPb?=
 =?us-ascii?Q?JvmkRySHKd+Fm2joa15X8IUX9KcvnPTk5cgc3WPz53BgsIfNMYhpT/6+Xios?=
 =?us-ascii?Q?mA5FHd8S9Gqp8O2RIVKzLwyv3Y2ZGFHmx/kv5KN5pCXBLJXsnbefgk9MHYHp?=
 =?us-ascii?Q?Z8L870GvLsVfdjuXUF38QilwArFYl/f3aZ0k4q+ZkLwqUSDvZjpaLihjV2BO?=
 =?us-ascii?Q?Ldw/Yc6QC6PlGIdu2MdmJbRwovRsD0+ZAOFuIB+YRulVhTpQ2nJhvbOlA8dp?=
 =?us-ascii?Q?x/TZo8x23Zn+tsx6HjjNTIHB5yo2obl58EdkXQm9obJI3b81hT5PD0airRwZ?=
 =?us-ascii?Q?Bzl8fYjfokBsS2leZpNFYRFkwG1As2Dje6wSzZL54ZguDilbCRlZ7Z+g1iYF?=
 =?us-ascii?Q?FnJgR7J+ZSjwJTW8ACCAMq+D6+qGcE57sjplo5PepCCdVvUkaZRckQdTXqEO?=
 =?us-ascii?Q?1934UDT81l4zFyoWo82kBcDvjz5c+LhBuv+O67aglQ0CdBrDpLC71kTtBzOs?=
 =?us-ascii?Q?VJFYblUrQd8Q1TsB/4HBe2CuOQ/fCjMj+o7TYiaXt8nkT45zTrgoavpbKhmX?=
 =?us-ascii?Q?6NxMNuLVQEg//MewjQP2SEAUceoRRm9XphfyMoFRx2zVVwDPLCZd3IdjqW3E?=
 =?us-ascii?Q?sCh3BGI3CLvSp9xYebWMJlgDRAnh8IUgXYDrV7ML0gN1fFPxI3goR9NCREPf?=
 =?us-ascii?Q?7fPXrxXRc7tTFS/druazxcth3iyKh+jUOD+Vhr+vhVWGYUkLJEriDlRUhOIC?=
 =?us-ascii?Q?WETXpCWODiXeG8W7NIKY9bCjviQb4fOgqMJPi+/r8u9571KWX5vw82LZvGwV?=
 =?us-ascii?Q?PIRXGnpUPNiOmm/HTJ/14MhUSj6/NASUWRamxTS28+swKZFhyZ8V6kimYzo1?=
 =?us-ascii?Q?bsSCoEUYEF3Joma7n+GeO11iZk0MY6IVUQUSSLxnNEKsMbABacSNrJ6Sb8gu?=
 =?us-ascii?Q?m8XaBlOzchU+gJK/e7XLk40=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5819036a-63ac-4d33-ec95-08db9ee7b083
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 06:03:34.2119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGmcPChOjVIwlVQkHLw+vFYQLIa8lieK0Kg2nhH+A16BWzUSZdqv/odfqkbIxXtbfuEmjTtPXUuEBJXIFmj676uiD8MaQLU65G5XeIwLTvznTtnd9VkaWJwa7aKC/k3V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6592
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guest-Hypervisor(NV use-case) uses ptimer as an arch_timer.
While running Guest-Hypervisor from a VHE host on a platform which
supports FEAT_ECV/CNTPOFF_EL2, burst of spurious ptimer interrupts
were generated for a non-zero offset, causing the boot to hang.

The issue is due to the value of CNTPOFF_EL2 is treated as zero while on
VHE host. This patch fixes the issue by adjusting the CVAL of a
loaded ptimer across the entry and exit of a guest.

This patchset is rebased on NV-V10[1][2]

[1] https://lore.kernel.org/linux-arm-kernel/19c775ad-9573-b4d4-886d-c631b468856f@redhat.com/T/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/nv-6.5-WIP-6.4

Ganapatrao Kulkarni (2):
  KVM: arm64: timers: Move helper has_cntpoff to a header file
  KVM: arm64: timers: Adjust CVAL of a ptimer across guest entry and
    exits

 arch/arm64/include/asm/virt.h   |  5 +++++
 arch/arm64/kvm/arch_timer.c     | 37 ++++++++++++++++++++++++++++-----
 arch/arm64/kvm/hyp/vhe/switch.c | 13 ++++++++++++
 include/kvm/arm_arch_timer.h    |  1 +
 4 files changed, 51 insertions(+), 5 deletions(-)

-- 
2.41.0

