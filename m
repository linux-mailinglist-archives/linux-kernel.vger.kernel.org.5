Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1EE77F05C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 08:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348183AbjHQGEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 02:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348169AbjHQGDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 02:03:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2123.outbound.protection.outlook.com [40.107.93.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809D32102
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 23:03:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/8+aNUyjFnZRV9xIeRWfyUx56UQhmU+QN5ey09Ii5amKv9kFs85RsxUaUZIT4FHFPWykEL8G2M6TRn8lnss4DULfnVlvQ2dQs0xAwK/SawhXJb/xQxLiRKunSmZ3XOZq1ih77gZ8GQUp93bx11+j4AslgVTZQ+auURhM+sk1tFHo4GPruRrRuF/e5/fpVY54kiXSFsMFEMVBRr/eAUWM/iL81HxBcZAvwcaCP9FQMyBsTpeNzWNsIcN8hLyhRmOyeO91aq+8JmNa5qD9i3Gjj8zmNIGvjTnBum1AdD/1dotWKtrqvTKdCT3vl2BLgKBwU1pj74WoJo1/wcQ2WJm1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+zIxP64HjHqcRTk3elG+jLIYNbM2O1BZqY9Jh7iogY=;
 b=WPOCVg7+VNt6h8FmyqhOXwSHLl2DJJcM7ORLXfuTvO1n9v/gLUsaWYb7GmjeBJSeE0NjoOuMO1fr64dJ24ycO5D/7khP5wCN+HJ1YqYoY/nHChvyD628yiqs8n1xqF44laEgBvsb9YWq9FP/e1/RpyawvjbUTuzaowsBnzEd4qR8EhgEwNH/eM7yfsOaghm6DdV++fFOgYn6QIuRa/5Yov0uNypx+LdmbR7bLvkGedsutHlWEszhED3AIJfaTjv9NIWsLUjv++ajn3Tr1OSP5nm+SL9daqiGKuPdfkkjv0y+PziKPC1t2TOdaoxCAG9ITdd2elfcMBAUQQwqTNyCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+zIxP64HjHqcRTk3elG+jLIYNbM2O1BZqY9Jh7iogY=;
 b=CohPIIgjEurixkWGhVDsFacrHl3Oy5IuwDUMRJus4k2owDA1jySWikJdGAXJY7K2ad4DFMfkZ31WLDokoRGXnTY/b4OGsTgPWchGN+k9EZkgs7lvvLHRQa2X+Z4JLSHujaWUZRtllzn4VLSlk2lxZHN7QkUYf/SQ5NBQHV/HWZw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 SA1PR01MB6592.prod.exchangelabs.com (2603:10b6:806:185::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Thu, 17 Aug 2023 06:03:36 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::d62f:d774:15b0:4a40%4]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 06:03:36 +0000
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To:     linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org
Cc:     christoffer.dall@linaro.org, eauger@redhat.com,
        miguel.luis@oracle.com, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com, gankulkarni@os.amperecomputing.com
Subject: [PATCH 2/2] KVM: arm64: timers: Adjust CVAL of a ptimer across guest entry and exits
Date:   Wed, 16 Aug 2023 23:03:14 -0700
Message-Id: <20230817060314.535987-3-gankulkarni@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5ca9ed8a-fa8c-4ba0-cc25-08db9ee7b1d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Ktf2wo/XNdve47O/IbrN0AmnIqvfZP/2+khbCYSEu3jDtXxfBj44WZ3D+I0NNy49yNngavFseSbrQ6VxHzGbVs61IbYjMejqlhhEvJKlTqbz7GNxA1CNhR2WRztR0CZZJXRLxnLaewvjlBMNVgpWd42dh7g1R5sBl0xsZ9bOzXasusIUncHv5SHircsY4pKyZABi/zhX0zpmsM44kKd12y9KXsnD8KR37CoRtum95JXgaukg7YLfHdigbSxHu+rDdZUcfFIJdj3vf5WENctHjQGKty1QsAewjneqI3GEGhovD+3D6rZFbp6KXLGh3d1NdU77s8yG0IL4FIfdnBUdrgswGZ0bXafXoYJw/Z9PkH8jjONwym7KMDtOx8bbU4fhAnvYsfkA6xukfsEUOyTIkqtah5mnD8a3R2MtCDyei9495feQRdaApwlbF0fq6hihulGinehASFXQlgbf+6aHqqtM4JRfW6codkUany6mQQrL90KDHw/XHHZVVdTxm2n18izmvSQXdmPUrjFZcPoOVu+QDpEdQpxqwC20ZcThaK+wUG9nCVn7EnaP50i0yDUkM5SZ+gFEyY/1p4RmCgPTUY2YVYelsU5rVQeQfOBHcBLKfQACUmgcCUlK/d3LMZ2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39850400004)(136003)(396003)(346002)(1800799009)(186009)(451199024)(83380400001)(2906002)(478600001)(66946007)(66556008)(66476007)(6666004)(6506007)(6486002)(52116002)(316002)(107886003)(2616005)(5660300002)(26005)(1076003)(6512007)(4326008)(8936002)(8676002)(41300700001)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6HBOUurHAEaSd+TmBTfPaCyDF2NFRRXC4dYu8pMwjeImNdAN7Mr6r4jizFL3?=
 =?us-ascii?Q?OOJgKM7Nky/poVzUwt2oBPAES4BDCFaNYk9GWPvHR27E5PcLB+QJOlQ233pI?=
 =?us-ascii?Q?xlBQ6W0oxUGgjY4s8ddZLov/GswXDYQ4rZJ3zh+Zbqgb1p1p6ZXlFMrJ1mBM?=
 =?us-ascii?Q?ySxUJAsc1oY+Dt/hSPQNe6zM4tY/a7lh1MKPZNawzEWpCNOM0H8FbgJAN82I?=
 =?us-ascii?Q?Gg1bRN5u5lB8LHld+7aI7QDJvTvWprptLEhbjntF3ueBySH0B41Z+W+WMMT9?=
 =?us-ascii?Q?yK8mR+xaDangAbk64MDu9GHvkyx8YlXlLNED5QDO9dS2YML7s7bGYxc+MLgp?=
 =?us-ascii?Q?bDCXfdUz9RTTXSV3w5Ud7yEytK4SNVYOR3Y5DC1qKlo875uD/7eVsxOo0Nve?=
 =?us-ascii?Q?Y+I10CNr0DDnDWRu8tQ68ewl4vQRj4VTe195E2soxx+TJ5j0RmGwm5frjYeM?=
 =?us-ascii?Q?YhJQfF1dZUjKH5F8BKxiX4JH44es4DuHUdQEEPxgyM9ct5iMUGqoSWfsLIQH?=
 =?us-ascii?Q?Xcf98oHmelDXx0feeBLZPF56IGvlSge1JbPW3wV1kmLsmONFvRCpHhfxxDaP?=
 =?us-ascii?Q?E8cLTKaMhbU8Q3ymCKJIVdzFpaiP0STzjZic/THwmjcqiU+vNwBgO3p/w60D?=
 =?us-ascii?Q?oBzinwlNrUThtbspFWvTTx6CLfzp5mmkA4rwnlNCilaWud4vnSvTzcv5UzWR?=
 =?us-ascii?Q?S9Re4/oUC/X175bbiWdYJcpIAK8SpzJtMfPnB9j9vJas4IiN2IIVGkXLx6md?=
 =?us-ascii?Q?d5fDAoXP2Wf+FFxz/bEcHd1nfCVk9UfoxhNVRtzbpPxLnNddQ+X4XChZrLec?=
 =?us-ascii?Q?y5XTOMQgOQae7P6q1sj1ZLQuk+gqWKgyZyWLKSnJA3ifrhv1KrQsJHFsq1Ba?=
 =?us-ascii?Q?hHl+IcUl2/JZBukcpm17V/ETtl+Hw7d6w8Rfv4B02rJc9HU5Vhl1zYaaRkRY?=
 =?us-ascii?Q?OcaeeENvex/yt/kmftXLcY+yUjqpHYg87LVDd6yno8ZA1hetyLlUSocjX6l5?=
 =?us-ascii?Q?ZUyA4LBEdCbukVnnW5xbXqYWoOQYVo1V5IxUQxM+zKj+hqfbg6H6++7BTMj+?=
 =?us-ascii?Q?T08DQlHP4xoi06CXtlq/1Zn0yyt2XrLtTzhe7M8HWs3uQdPV9H5UDXpj5jAT?=
 =?us-ascii?Q?WG1EC5MCcWGHgqtUSbLq01I1QzO1VG07seXCOpjlM/6ye114+naiRyfaASWt?=
 =?us-ascii?Q?cn32cQqdn/ksRcFLhIFFctV2biuB8u6QDScVTqFFRvpe1gVSgy6XXdN+yozc?=
 =?us-ascii?Q?iFtF+0XqKY7Xv/eDZr8qdkyMFcQf+jiMiMpA9p1iUIKq96YzUkKSVdoxrEEX?=
 =?us-ascii?Q?aM8kQgpDGGDnAZrx+Baw6deJbdx2WxDZhczIUXqfAajLJ3guRRHZzqHNmYDO?=
 =?us-ascii?Q?Olzv2A2YNWSp+6nkfUcs24v0cUyJpq0KMPLBZD625Gcm7QW+onFeXYyIE3N8?=
 =?us-ascii?Q?3Lm4eTY+rwspQyvq/cPEu5vxeJwM0bDR24RnQBerChcJlZpFEdRW0pUiHlWr?=
 =?us-ascii?Q?Ta3xW8QyLUSjvScbnAsLissCJAOFk124xAqbeseBrZzfBBFZ0rlZX3Vy6Ez+?=
 =?us-ascii?Q?f1kbeFHZQMiyPIlgXDvkiBdBu6dtTLA7Babt5XzCZQVNvKVDTMGb9tvkJT/u?=
 =?us-ascii?Q?t+xo/3Gf23aUm9uBe0cudPI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca9ed8a-fa8c-4ba0-cc25-08db9ee7b1d8
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 06:03:36.3086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPaLAaoNP19Z5J5R3Kk8uyDOvEMTuZMaJtUR5vo8herX72zbMh64tUJM+HFp6WY8lFLkmi4dRJxq8trRJy3dpf7UwLKPtwsLBv9CrLQv5kQWRs8tL/jgKVWUJX83Mr17
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6592
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per FEAT_ECV, when HCR_EL2.{E2H, TGE} == {1, 1}, Enhanced Counter
Virtualization functionality is disabled and CNTPOFF_EL2 value is treated
as zero. On VHE host, E2H and TGE are set, hence it is required
to adjust CVAL by incrementing it by CNTPOFF_EL2 after guest
exit to avoid false physical timer interrupts and also
decrement/restore CVAL before the guest entry.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---
 arch/arm64/kvm/arch_timer.c     | 32 ++++++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/vhe/switch.c | 13 +++++++++++++
 include/kvm/arm_arch_timer.h    |  1 +
 3 files changed, 46 insertions(+)

diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 98b0e8ac02ae..be609b12827d 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -955,6 +955,38 @@ void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu)
 		kvm_timer_blocking(vcpu);
 }
 
+static void ptimer_cval_adjust(struct arch_timer_context *ctx, bool inc)
+{
+	struct arch_timer_cpu *timer = vcpu_timer(ctx->vcpu);
+	unsigned long flags;
+	u64 cval, offset;
+
+	if (!timer->enabled || !ctx->loaded)
+		return;
+
+	local_irq_save(flags);
+	offset = timer_get_offset(ctx);
+	if (offset) {
+		cval = read_sysreg_el0(SYS_CNTP_CVAL);
+		if (inc)
+			cval += offset;
+		else
+			cval -= offset;
+		write_sysreg_el0(cval, SYS_CNTP_CVAL);
+		isb();
+	}
+	local_irq_restore(flags);
+}
+
+void kvm_ptimer_cval_adjust(struct kvm_vcpu *vcpu, bool inc)
+{
+	struct timer_map map;
+
+	get_timer_map(vcpu, &map);
+	if (map.direct_ptimer)
+		ptimer_cval_adjust(map.direct_ptimer, inc);
+}
+
 void kvm_timer_sync_nested(struct kvm_vcpu *vcpu)
 {
 	/*
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 561cb53e19ce..0cdcefc1351d 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -100,6 +100,10 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
 		hcr |= vhcr_el2;
 	}
 
+	/* Decrement/Restore CVAL by CNTPOFF. */
+	if (has_cntpoff())
+		kvm_ptimer_cval_adjust(vcpu, false);
+
 	___activate_traps(vcpu, hcr);
 
 	val = read_sysreg(cpacr_el1);
@@ -141,6 +145,15 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 
 	___deactivate_traps(vcpu);
 
+	/*
+	 * For VHE Host, HCR_EL2.{E2H, TGE} is {1, 1}, hence FEAT_ECV
+	 * is disabled and CNTPOFF_EL2 value is treated as zero.
+	 * Need to increment CVAL for non-zero CNTPOFF to avoid
+	 * false PTIMER interrupt.
+	 */
+	if (has_cntpoff())
+		kvm_ptimer_cval_adjust(vcpu, true);
+
 	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
 
 	/*
diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index ea77a569a907..3ce6f02a0d9b 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -117,6 +117,7 @@ void kvm_timer_vcpu_load(struct kvm_vcpu *vcpu);
 void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu);
 
 void kvm_timer_init_vhe(void);
+void kvm_ptimer_cval_adjust(struct kvm_vcpu *vcpu, bool inc);
 
 #define vcpu_timer(v)	(&(v)->arch.timer_cpu)
 #define vcpu_get_timer(v,t)	(&vcpu_timer(v)->timers[(t)])
-- 
2.41.0

