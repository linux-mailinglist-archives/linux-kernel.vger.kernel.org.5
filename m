Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927AD791656
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352838AbjIDLm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbjIDLmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:42:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2128.outbound.protection.outlook.com [40.107.93.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179B7CC8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 04:42:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aR1ZavAf2oxQEWViV72exOTg2p43i8Y/IQVuEvl1I3wIMMfY1rdQWyol0NVlgcGIsvfdyVEj9p6Zq3jkMHQspgNmWhLBmf37CjCy+fBlz4r1zBygMHYP2yP78/xN9lgZZl0HOIC/Vu/Ks2JA1KMLBseRtuSGtS5sCj6nbVvAhX/2hNFfYQMF048Tea0FKMRIyky8DWc2wfJ6WOthxndSMYUtCa8Mh9nQVjhsl2vbPRFQxKbavTPjgoNGYzjNUj984g9xOqaoNzwLiOiyGEqjanF/tW/ZB0r8xudoUA1rDxTGyLuOUDPibCRJRNBkEkMXda17Ef/EMquubKMtby4mvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuVkEj/RjUkPkRSZVttniWId5jS6FZ8yjquHoiuQ2Ew=;
 b=nkF5PZjitZt3Jh3c44qVkn9gOSEDz+LVHmwQu0jBlaLNw/KwyIB93dCf8ThMnCMfiJoqc5FTXBmUe0/srLvfCysWhJYtsjkNsdcwxaUJw8YOK7yQkCepC08tREiVyNb0zpkUL/630nzEzbrsDIJVTtMDeQ+xcq5tVqz+/UWfwwsMHt+WxhBnXd7TGaOAC2xkzoYiOBjyMOk7xl4WuLmTtuZc6Gqj1zqYcpK8Tc7ACo6BV1sLT/oMoQU9Elc1Joza/1rG3TPGH30vtskIg/+/iu+kSDLM9NsskhCpJVLtCQns8UEb6MAps3OhMw/BxSb66YdI2mc6uU2EYOkNWr2qLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuVkEj/RjUkPkRSZVttniWId5jS6FZ8yjquHoiuQ2Ew=;
 b=BN0LL36bKTCK2MOVSfCNG+7etFdiEjf3yKZFtmR9+hW7Hr4myLukEdg8UyHQ0PgDt11YOo06vBW0vobaliJ2gs0DSVncPqf+yxqyNOkDp2kMpmh+V3mjvn4ojUGQ/UTeM9RU9JCDJO61hB34+GuANEH+b6RmRLd/hDtxJ7AWNwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SJ2PR01MB8008.prod.exchangelabs.com (2603:10b6:a03:4cb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.30; Mon, 4 Sep 2023 11:42:45 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::460c:bded:60ff:3254]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::460c:bded:60ff:3254%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 11:42:45 +0000
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To:     linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org
Cc:     Christoffer.Dall@arm.com, eauger@redhat.com,
        miguel.luis@oracle.com, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com, gankulkarni@os.amperecomputing.com
Subject: [PATCH v2 2/2] KVM: arm64: timers: Save restore CVAL of a ptimer across guest entry and exits
Date:   Mon,  4 Sep 2023 04:42:18 -0700
Message-Id: <20230904114218.590304-3-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230904114218.590304-1-gankulkarni@os.amperecomputing.com>
References: <20230904114218.590304-1-gankulkarni@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:610:50::34) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SJ2PR01MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ca01ec-441b-498d-7346-08dbad3c0e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5PibvsSU9G236iZXNkNDICd8CNt312TSnI6dr2YYRmEO6cfMeMLmAcXTrDzn/YBTSp7xReRSaronu2fTJbAAIMgktqW64ZliZ+zxdRCziqflZmbyipg82aXatk6doffx+j4FgtZo6TRpPQEOU5Iq+I8u8fst3nExRnoaWgDAB30ffXq45ctmoytEqzVKLuYJqN7MAHAbN+JEqHgpX3EjBwOo3slq826dIU5e5Bkmh9ApYbMBXvc/RYixMRTqGYBQ/q/189B1VDg8oDNIjCFtiF4HmCSzHGdGVCQdWzYpmrhoRd4YcivONJJBxMKbEqC91DQD5O/Rx52eo7vRDRCx9s3cNQgzkhyTiT5ms51K2bC6022Q9olLqapXmCLToVcC5QGsL1tlLunx7cTKPhYus5F1DXV0mJua3d65PclK6rmcD+1FHqM3Ar7i8qvVHWPqK6lki2izwVHA/ZsZU5VqMsyKqBbhaCmmAKjxNosRCjvgMBF4ARShxo9JIV0Y+vYMbai9ONZ5aOA8wINnmv/XAHNnq9OPVnq5YWUtOjXdHz04HOnTYIiyF5tDCEPrJMbNGGgwij4Vp6DGXaC3nMaxXuV0EQzzMg7kl3krucf/fz9SGx8eUToTYeWQ5ck9PNr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39850400004)(396003)(451199024)(186009)(1800799009)(38100700002)(38350700002)(41300700001)(5660300002)(86362001)(83380400001)(66476007)(66556008)(66946007)(26005)(1076003)(107886003)(2616005)(478600001)(6666004)(8676002)(4326008)(316002)(8936002)(6512007)(52116002)(6486002)(2906002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j+WZyY5WJ8UU0aH9gXN8h29DHzzGgj4kXGdgALmsHenswCtkqDdD3hBumHyP?=
 =?us-ascii?Q?dve1sn34yOMAAGCMPKKLQ7FOhzbdjoj7wFhsajpXo8K9mY8GlxgkICCr07E5?=
 =?us-ascii?Q?qJgr7ov4XnEvEAYeDh79SqTQRB0eyFn964O0aa/5IeHg/zstsgn6eAeImw7A?=
 =?us-ascii?Q?qQYjI/0YChC7EZKWYyrnk0lD0M+CFddcD7HyucCvuEVrTsFXcmCkTshEO4i7?=
 =?us-ascii?Q?nmYxENv7vPheLNGnIqpEJH9K9Lrrj2tRkbulbk+5OqTEb7kgJ+Zw3guCWGei?=
 =?us-ascii?Q?5K5Z9fiq4a/R3YMd2uI27/SrsCY2Iqjk0FRnD98oDIi/A94FvdmzC3kfMOUv?=
 =?us-ascii?Q?/2B3t5XKQCrj1B6oT4Dc0V+7VRVjZyXmA9CyVuf3c1l4b6um3BupARAzpwVl?=
 =?us-ascii?Q?91FUj5tIYBOYEtLoc/uySrcrOXTMQo3Dr98oz9GbQESscpNdUjzlxKkSh+F5?=
 =?us-ascii?Q?H66IMLY7nmJAqgmrqUFjC8W+ZOUorA5EPROJSn7aT9NuZw77yMk4EOhBLYkg?=
 =?us-ascii?Q?tY21Soueb2JzInS6eORXeFTeVQl2Q+w357K14bbMNxSxu7u6HixL24+XTbJM?=
 =?us-ascii?Q?vVzmdxop0FJJhK5fn0tsI7bkOfhqMjY8Ph/maGHRmlHgCXh+nTG7rTqT8Ldk?=
 =?us-ascii?Q?8TjZoKF0XB4gMNgwU/QCTC9xZ9YB4vK1flmJ5c3VKAlZJFybywqqBz8vbjas?=
 =?us-ascii?Q?mRExFZMZ1uRVICaq/fWwoT9XMbpOOYyBCOKSZCJCCM7Rux3el7AJBixE1CW1?=
 =?us-ascii?Q?JQZvKDP52cePzpiH+pUXcBXNu3wFSggx94mtgxJtdF0mE8bWz9d1aRqMKf0z?=
 =?us-ascii?Q?v6TRcBtFqjVzqN/oQPasX/siJQEoeVoBqcgTxcEN1bpY6el7Dh7AN/uCPh30?=
 =?us-ascii?Q?KIctzLJRdaxouGf1dQv2ykq7w5YM7SJhFxtFoWoR6obre4RFkLG8OVeh1F29?=
 =?us-ascii?Q?IQD4LxoNFDBSF/WPnEuI4mHMVwC76Ne66pMOnnwGViGskuWaO3mCRbZXXO7o?=
 =?us-ascii?Q?YielkQpgs7NTikFnWi7WbdFeKPE7PWzML9Zqcgxh6Iq/lQcdByATJkXpKesA?=
 =?us-ascii?Q?4awYSuWq72AjfhD898eALVxN5sNA7o0Ip804M6qUraGx0wJlrNRBHzWjlfvY?=
 =?us-ascii?Q?ckDK3V66dIF6iXwFzICjQjUhNrfh2SQrgFDKrJOURZp+twm2bTQhDoNp34X8?=
 =?us-ascii?Q?DgK7ZYnoZcmFz4CRQ0K8Hr9XNEaJrhETtBbZ7oCVPcRl5jWpYUGcPIOb9zV7?=
 =?us-ascii?Q?hK7rWFd7x+wgXA84MNy5NGiajDQX1TXfzdsL4gEBWfuLe2RyA52t2OLT7jmE?=
 =?us-ascii?Q?byAs+0dEnjZOtdzzQCqkAD5ZVn8pX+nd86Y955BBexeHdPUgyLs+F/3OMLKB?=
 =?us-ascii?Q?WGK2h9nHFPkbDMqHG1wLtzCrpkslG0XDpfbjqQkcAMKTd2TX6GKEeZbGOSt9?=
 =?us-ascii?Q?O+hognhVkIFf7/Zg6t+qvLHnyL2s3EqIEIrDmitjqrO+OU6ESjGQSQyWMIn2?=
 =?us-ascii?Q?D5t4/PzPExMLiBAAxwA1/jACkQlFrBfeMpIukz1k1l3zpdGJbdmbokjgo/WF?=
 =?us-ascii?Q?2ZFCAFNZVwY6FAZVS7ARgcToX85SrV7OQM5m7x5zLDY9ygAqeKythAn8m1uy?=
 =?us-ascii?Q?Upgz0mvcqpbWB+A/Y5jaoLs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ca01ec-441b-498d-7346-08dbad3c0e8a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 11:42:45.8548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Pmhp/k8R2WV4hh5Q6YUSe5h7KFi8nFLnoqCu5cOZEdPexVmwDi5LfJnp6GJ8ME69C3xOwEwamn3R+bXNhroSOoOsxIrnWrpTb+DX0UMEx3z2xYypKfoHLyj2TrRdPYL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8008
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
to save Guest's CVAL to memory and increment it by CNTPOFF_EL2 at
guest exit to avoid false physical timer interrupts and also
restore back the CVAL with saved value before the guest entry.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---
 arch/arm64/kvm/arch_timer.c     | 60 ++++++++++++++++++++++++++++++---
 arch/arm64/kvm/hyp/vhe/switch.c | 13 +++++++
 include/kvm/arm_arch_timer.h    |  1 +
 3 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 98b0e8ac02ae..9fe3fa6ed98a 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -514,6 +514,59 @@ static void set_cntpoff(u64 cntpoff)
 		write_sysreg_s(cntpoff, SYS_CNTPOFF_EL2);
 }
 
+static void ptimer_cval_save(struct arch_timer_context *ctx, u64 offset)
+{
+	unsigned long flags;
+	u64 cval;
+
+	local_irq_save(flags);
+	cval = read_sysreg_el0(SYS_CNTP_CVAL);
+	timer_set_cval(ctx, cval);
+	cval += offset;
+	write_sysreg_el0(cval, SYS_CNTP_CVAL);
+	isb();
+	local_irq_restore(flags);
+}
+
+static void ptimer_cval_restore(struct arch_timer_context *ctx, u64 offset)
+{
+	unsigned long flags;
+	u64 cval;
+
+	local_irq_save(flags);
+	cval = timer_get_cval(ctx);
+	write_sysreg_el0(cval, SYS_CNTP_CVAL);
+	isb();
+	local_irq_restore(flags);
+}
+
+void kvm_ptimer_cval_save_restore(struct kvm_vcpu *vcpu, bool save)
+{
+	struct timer_map map;
+	struct arch_timer_cpu *timer;
+	struct arch_timer_context *ctxp;
+	u64 offset;
+
+	get_timer_map(vcpu, &map);
+	ctxp = map.direct_ptimer;
+
+	if (unlikely(ctxp == NULL))
+		return;
+
+	offset = timer_get_offset(ctxp);
+	if (!offset)
+		return;
+
+	timer = vcpu_timer(ctxp->vcpu);
+	if (!timer->enabled || !ctxp->loaded)
+		return;
+
+	if (save)
+		ptimer_cval_save(ctxp, offset);
+	else
+		ptimer_cval_restore(ctxp, offset);
+}
+
 static void timer_save_state(struct arch_timer_context *ctx)
 {
 	struct arch_timer_cpu *timer = vcpu_timer(ctx->vcpu);
@@ -562,9 +615,7 @@ static void timer_save_state(struct arch_timer_context *ctx)
 		timer_set_ctl(ctx, read_sysreg_el0(SYS_CNTP_CTL));
 		cval = read_sysreg_el0(SYS_CNTP_CVAL);
 
-		if (!has_cntpoff())
-			cval -= timer_get_offset(ctx);
-
+		cval -= timer_get_offset(ctx);
 		timer_set_cval(ctx, cval);
 
 		/* Disable the timer */
@@ -650,8 +701,7 @@ static void timer_restore_state(struct arch_timer_context *ctx)
 		cval = timer_get_cval(ctx);
 		offset = timer_get_offset(ctx);
 		set_cntpoff(offset);
-		if (!has_cntpoff())
-			cval += offset;
+		cval += offset;
 		write_sysreg_el0(cval, SYS_CNTP_CVAL);
 		isb();
 		write_sysreg_el0(timer_get_ctl(ctx), SYS_CNTP_CTL);
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 561cb53e19ce..097fcaf7b208 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -100,6 +100,10 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
 		hcr |= vhcr_el2;
 	}
 
+	/* Restore CVAL */
+	if (has_cntpoff())
+		kvm_ptimer_cval_save_restore(vcpu, false);
+
 	___activate_traps(vcpu, hcr);
 
 	val = read_sysreg(cpacr_el1);
@@ -141,6 +145,15 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 
 	___deactivate_traps(vcpu);
 
+	/*
+	 * For VHE Host, HCR_EL2.{E2H, TGE} is {1, 1}, FEAT_ECV
+	 * is disabled and CNTPOFF_EL2 value is treated as zero.
+	 * Hence, need to save guest written CVAL in memory and
+	 * increment PTIMER's CVAL by CNTPOFF to avoid false interrupt.
+	 */
+	if (has_cntpoff())
+		kvm_ptimer_cval_save_restore(vcpu, true);
+
 	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
 
 	/*
diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index ea77a569a907..ce3f4d9e7dd4 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -117,6 +117,7 @@ void kvm_timer_vcpu_load(struct kvm_vcpu *vcpu);
 void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu);
 
 void kvm_timer_init_vhe(void);
+void kvm_ptimer_cval_save_restore(struct kvm_vcpu *vcpu, bool save);
 
 #define vcpu_timer(v)	(&(v)->arch.timer_cpu)
 #define vcpu_get_timer(v,t)	(&vcpu_timer(v)->timers[(t)])
-- 
2.41.0

