Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791EB7DABE7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 10:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjJ2Jqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 05:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJ2Jqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 05:46:35 -0400
Received: from 1.mo576.mail-out.ovh.net (1.mo576.mail-out.ovh.net [178.33.251.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AABC9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 02:46:31 -0700 (PDT)
Received: from director2.ghost.mail-out.ovh.net (unknown [10.108.20.147])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id D82B028082
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 09:39:40 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-wchvn (unknown [10.110.171.1])
        by director2.ghost.mail-out.ovh.net (Postfix) with ESMTPS id A84961FD2D;
        Sun, 29 Oct 2023 09:39:38 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.102])
        by ghost-submission-6684bf9d7b-wchvn with ESMTPSA
        id Vv44I1ooPmW0GAAAMIZvTQ
        (envelope-from <jose.pekkarinen@foxhound.fi>); Sun, 29 Oct 2023 09:39:38 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-102R004927f133c-9d22-4865-bed1-34b055a274b6,
                    2D5A9C8C3C9544CFCEEB4DEE313913C815DB1A20) smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 87.94.110.144
From:   =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        skhan@linuxfoundation.org
Cc:     =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
        x86@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] KVM: x86: replace do_div with div64_ul
Date:   Sun, 29 Oct 2023 11:39:28 +0200
Message-Id: <20231029093928.138570-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2908199461897021094
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeflohhsrocurfgvkhhkrghrihhnvghnuceojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqnecuggftrfgrthhtvghrnhepfedtleeuteeitedvtedtteeuieevudejfeffvdetfeekleehhfelleefteetjeejnecukfhppeduvdejrddtrddtrddupdekjedrleegrdduuddtrddugeegpdefjedrheelrddugedvrddutddvnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeeipdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by coccinelle, there is a do_div call that does
64-by-32 divisions even in 64bit platforms, this patch will
move it to div64_ul macro that will decide the correct
division function for the platform underneath. The output
the warning follows:

arch/x86/kvm/lapic.c:1948:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead.

Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
 arch/x86/kvm/lapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 3e977dbbf993..0b90c6ad5091 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1945,7 +1945,7 @@ static void start_sw_tscdeadline(struct kvm_lapic *apic)
 	guest_tsc = kvm_read_l1_tsc(vcpu, rdtsc());
 
 	ns = (tscdeadline - guest_tsc) * 1000000ULL;
-	do_div(ns, this_tsc_khz);
+	div64_ul(ns, this_tsc_khz);
 
 	if (likely(tscdeadline > guest_tsc) &&
 	    likely(ns > apic->lapic_timer.timer_advance_ns)) {
-- 
2.39.2

