Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2133177F05A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 08:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348173AbjHQGEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 02:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348167AbjHQGDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 02:03:39 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2123.outbound.protection.outlook.com [40.107.93.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4502102
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 23:03:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JulC2HBUDFXOOlRmXUrsqZK9IQ5hvus4mmskRAWUZnGEubO5yQ42CtEwUFxiupCf7iz0BK3Q2QkXvKsW+eCIA4wSDylB7uU5lY7xpNtzk+5ygD0IGeshVFbroFmtkc43wS3wUCrqSc6LI2XFZ+UII9mj2g3P5LfQOHQX/VVf2tzfWknT1GqG+ybnIs3qP/+3bHMobyPuBbzod/GmRNYr6cFTDpCcvNN6kL13PyZIxfqTsJMjHU6m+1A6twxgbbhOrNK8GnsELBaDJ0Ug9tIvEfBCnT/P3UTPT0N8SDA7vwiFeeJiCHvYow/BD5wFtpOm5njOIyfmDXL8lvucsympXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOZw2EURdLDxgbCFLA4cIfp5eTLsDkKifig5lfBXwNI=;
 b=YMxFpSv8luoj1jMg0jmLalUJ0QRFF9anLhKOH1ffNyw2IJnzMymGLoJvCvo+w8ki5sbhOL8a+vnY7GKKFKWzLwKoQ2Y/zIysMDCCvC+UPGHW+o32/XV990BsiI9G+S+aeXybFnQXyLtoY7v8mKXbDM3AQRESz08XrbedeMzkXYl+zrt5dM7E+VuA5lvMDwuON4w8GsDc4dRaHCK6s3KhqUG1w6Og4dAH/rz/QrHjiehVBH74o5g2djCKJZqY2/OaUptmIHePz7jtPzsICc4IS7dALxHVwntv0XUrCKO4lA8ea/tfbMDyQnox7Ik/j3LL8yXkEgH5DmBaTc8ghMDOQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOZw2EURdLDxgbCFLA4cIfp5eTLsDkKifig5lfBXwNI=;
 b=f/WgRTxHA4M7ZyoQ3dSckLUyN88M2KO30vAtODYV01fjTjBVtQ8u0CasY6H4bDHiw+HbbvDZeUk1lk2h+FmCMLYG2dGtfCXKSN/ZMIQBhs8e37dQqCBrnFc5cUrx95iK71/gTo9OIjr9MoH37ktwIEHEw1EvdfO3TUilripkARw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 SA1PR01MB6592.prod.exchangelabs.com (2603:10b6:806:185::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Thu, 17 Aug 2023 06:03:35 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40%4]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 06:03:35 +0000
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To:     linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org
Cc:     christoffer.dall@linaro.org, eauger@redhat.com,
        miguel.luis@oracle.com, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com, gankulkarni@os.amperecomputing.com
Subject: [PATCH 1/2] KVM: arm64: timers: Move helper has_cntpoff to a header file
Date:   Wed, 16 Aug 2023 23:03:13 -0700
Message-Id: <20230817060314.535987-2-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230817060314.535987-1-gankulkarni@os.amperecomputing.com>
References: <20230817060314.535987-1-gankulkarni@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:610:59::28) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|SA1PR01MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: fa03734f-ecd0-4406-1664-08db9ee7b139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jABkziO/VFX7cwmIas7CFX6VHx5XsHxZee/zhnjqoyUKgiYppa/B/X4BMG36K+IS+Zky+8T6D0Ffy61vJ/PpG/4FzGjR3pKQGmDaZaGkgFzETdqNlL8rBlAKTYdFBc1gKogkQ4oGH7J4zGYADaD1byMU5m4tdvitwnW2f6v2UggLCJylqx2K7wb9YgctvVUmHfwfXFULbLQ8Vd3sFc2KRu0cDSdSWT9Jrj+iutjiiFRZiDkJ+qcXweHMbzQlRAUn3iSOcnGRPYSIKrSM7lfPSp1mHbPb4k1WBoUZwWAVZHGkKPYz3gIoy/RFFdJqopnz0wCvG6fqKjlRrHQNVKFQV6YUTrRyuqLx9yPXAShuQyw76HA/tzAgAgGCvTrRSEWDM/3U7J/PgLuy5yqbVajq+5ZFYl6ubGSlnt5yGX1V9r/fL24XXhsNGJreHPLiek7nMb7sBlmfTPkwqR5HSM66QqVzwtVmFbgWxeu9p+LsQYqddQ9jVHOT43T69O7TCZfGhh/JeZYaByhjibIWTKGeTKHTcWrCTPU/7GGw0Egt73ebGW7Wuf0G6x/bK4jOgvSUDWBwd2zVOCrjm/aSMJZE9BiKaaJwhSeUKklszY2g+oJPg+mqrRHB945Lm2AiXQzu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39850400004)(136003)(396003)(346002)(1800799009)(186009)(451199024)(83380400001)(2906002)(478600001)(66946007)(66556008)(66476007)(6666004)(6506007)(6486002)(52116002)(316002)(107886003)(2616005)(5660300002)(26005)(1076003)(6512007)(4326008)(8936002)(8676002)(41300700001)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NlxIoS+wOPoPLHIt/APzMGQ5zoL69/7YvKf+wIMWqlkoghLOGhQxK3KpGZLm?=
 =?us-ascii?Q?HPQ1jlZjlc0GoEL5HkOvdStc/ovq+iqEGXMIaKpzrH5h0QZxiP6uNLT4f4go?=
 =?us-ascii?Q?XNkkzFX9d9aiNSYrRlOizY6VkwO1CZwd300CZsAvbGLMT98QhXouKLn2Ots4?=
 =?us-ascii?Q?07CM22pSgUr/qB09/LdrfC7Hf+6oEOe8zMS1jCMZD/MHygrEMPTcXK2wcwrK?=
 =?us-ascii?Q?xiBVS/XnfL/ZLG3l7SorG9MG/q9XzyBJcy973X6O4zAuwVDKfbc3ZJaRuhgG?=
 =?us-ascii?Q?yf+5erTT+gfibpmU2LmxyLlIUuC/LZwGwpro1cpf+vpchTIecMXhOaDnZsIN?=
 =?us-ascii?Q?iBrmcClNngtBVZgvpjtotB64FjE8cMbbXkkwE3aYGGrn3KJq9gynyDqpD8KN?=
 =?us-ascii?Q?SqsTftEj2ccqE4chgQ/TSCSx16nsJb10/rFSlek6bhSqo/7f4JfqYIzSpKe4?=
 =?us-ascii?Q?HyhmrZr0/8eYn/RuCPJfqY/gyqXVUJIr/8OURLT0vkTp6XXiBSrxFKqxoGxN?=
 =?us-ascii?Q?+Ce8PIaVdzjg0+ZYL5HJbS6hq4KKWQ+hwww/07zIEiC05Y8uQdUrdpw5WPeN?=
 =?us-ascii?Q?YjxXtIwUElAodQmi7o3R/4syT0fA0iEJabuftm5vttiK0sHXVdmT/0KxAXh5?=
 =?us-ascii?Q?RKH2nDfVOBXGM1yq0xpxOitqrOcwFsYWIqCKBB+uGqkHcD6CQCJmzblwhncw?=
 =?us-ascii?Q?adF2bGRyfIlsz8lyzd2+zks+pwYr0KErIXvq4XtTkFVnoaTR1weHWj9YY4dC?=
 =?us-ascii?Q?BaUKHz1z3Rm1Dg588uQSzFEtBGW0DRcCtLweQBuzVyl0Sz5tgfyudK0+Roe8?=
 =?us-ascii?Q?sLn4zGo9nmix4eZLPKGOcuAT+HWcnMHNE8KXrQnLgWVfxQ1zClwDf+E833YN?=
 =?us-ascii?Q?Q+MBheUKyXL6UBRR7BPGwx75XNamPBZlqpyZ7DJzpwem4shXDE9AF7S8V+Wb?=
 =?us-ascii?Q?PR+KEu3eOyv8+D3zl9sI9acv1OhZ3ndRPeyYzitnImvv9AUiVQwgKhIk+VHs?=
 =?us-ascii?Q?DYlvDYpMIc3IXeYKgu2b2NvB60frXp9AwgGLB61cN4dPk9ABM4nBhx2tPSZ5?=
 =?us-ascii?Q?S6tZyLRnPuivJxipISyUXT/sS0waL9VE9Htzt51a2Sqbv2m+OkISCAAuf7t0?=
 =?us-ascii?Q?Ro8W0uDU/tkHaaCr5zn4Yy9qllEES+aS2j8G8xoCsU7Lq+aSdc+HQZIYfPJJ?=
 =?us-ascii?Q?+Sjdj45QC9qYzaAce5PVBnqZPshH10SB8/7IHwOQELU6HoS+yRy8B/+p+Qz3?=
 =?us-ascii?Q?hkKTd4dkOeZpMNKBGGMJiOacYbqrySiOhd5X5WTyaIkMEWrcrsD4rg/Eth+F?=
 =?us-ascii?Q?FHp6cDO7wFzov/ZhzIoEsOclHysDbD6e99WVOvHvidEuztlmnMXYL0EOF07u?=
 =?us-ascii?Q?Y0Iz3FJY7xjNdR/QdUzMFz1+1ZEq59WBTv3GWBmV3e8WAC/Z2nE6S/zgJWSp?=
 =?us-ascii?Q?+typj2hKbHq1UVesNJ8ZELwYYGbJ0/G/ferYQxdQ2ebGnAmgbJIJZcXYZ1id?=
 =?us-ascii?Q?Mkc6EyWw1McwimTF7nSOfGaStLqHlWN0xcLrYr2ATg5jbXvunF8sn46otKXr?=
 =?us-ascii?Q?32SGvryiJPJ8XT/LMojH/hKZzB98/hPU9Oy81p/EmeEPGQbGFcLIQAPvaj6o?=
 =?us-ascii?Q?IEEeSzCOOm3yFOn4ZsnOBVc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa03734f-ecd0-4406-1664-08db9ee7b139
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 06:03:35.2759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lr6/jPNTFua6VZrL+CLRg/LCvsib0UTRHPEWOd1N2fqsPoXIrxJpc5sAl8ZQr3ZKxWyXjqSxTfCrOvffB3Sp3jptgmzenAqPSrzkriYx6XkHyq0Q+0gWo3NpD7+Nyky9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6592
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move helper function has_cntpoff() to header file as an inline
function to make it available to other functions as well.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---
 arch/arm64/include/asm/virt.h | 5 +++++
 arch/arm64/kvm/arch_timer.c   | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 4eb601e7de50..f22cc733efb1 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -132,6 +132,11 @@ static __always_inline bool has_vhe(void)
 		return cpus_have_final_cap(ARM64_HAS_VIRT_HOST_EXTN);
 }
 
+static __always_inline bool has_cntpoff(void)
+{
+	return (has_vhe() && cpus_have_final_cap(ARM64_HAS_ECV_CNTPOFF));
+}
+
 static __always_inline bool is_protected_kvm_enabled(void)
 {
 	if (is_vhe_hyp_code())
diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 75bddab3224f..98b0e8ac02ae 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -55,11 +55,6 @@ static struct irq_ops arch_timer_irq_ops = {
 	.get_input_level = kvm_arch_timer_get_input_level,
 };
 
-static bool has_cntpoff(void)
-{
-	return (has_vhe() && cpus_have_final_cap(ARM64_HAS_ECV_CNTPOFF));
-}
-
 static int nr_timers(struct kvm_vcpu *vcpu)
 {
 	if (!vcpu_has_nv(vcpu))
-- 
2.41.0

