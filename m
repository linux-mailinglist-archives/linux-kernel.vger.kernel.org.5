Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA7A7CE824
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjJRTty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjJRTtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:49:41 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073DE134;
        Wed, 18 Oct 2023 12:49:03 -0700 (PDT)
Received: from smtp.gmail.com (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C605141687;
        Wed, 18 Oct 2023 19:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697658541;
        bh=8Y07yuoT6DVyuGlkc8/akVKoJW7v392Ra1UBrfLmh5Y=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=dc6cF6qoAjkfEXrGMu0blXNYuIEkkt4XWwFkrTY+GNsY+UPMYNV9PGaEca8gY5R1U
         vMl/LXS/vNd6G1SnK+G1WvGyvx1SoeG+TJ/jCOV4l8iKm6IgHUQroBsTiLAfE0XY3z
         PhgyfLRirMrTLNsG1faA4fYJWtp554F64OPPsWSaiFymqNuKV1JSRg+jyww6l/0HTT
         RWX57Z+MVZx24z/FeMExLU7StqidEc22lzUkcKT5jv1KF/Z7nsSg/FX2LtKifEnuAd
         eyoCAmHb7kq8njndyyvx9pp1uZ/aps3JvZWyS0Qu0QiI3QnvGNXUkJ4kxLJSjfM4Gj
         Yfton3wKj8SNQ==
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>,
        Joseph Salisbury <joseph.salisbury@canonical.com>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Chris Wilson <chris.p.wilson@intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH RT 11/12] drm/i915: Do not disable preemption for resets
Date:   Wed, 18 Oct 2023 15:48:32 -0400
Message-Id: <20231018194833.651674-12-joseph.salisbury@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018194833.651674-1-joseph.salisbury@canonical.com>
References: <20231018194833.651674-1-joseph.salisbury@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

v5.15.133-rt70-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[commit 40cd2835ced288789a685aa4aa7bc04b492dcd45 in linux-rt-devel]

Commit ade8a0f59844 ("drm/i915: Make all GPU resets atomic") added a
preempt disable section over the hardware reset callback to prepare the
driver for being able to reset from atomic contexts.

In retrospect I can see that the work item at a time was about removing
the struct mutex from the reset path. Code base also briefly entertained
the idea of doing the reset under stop_machine in order to serialize
userspace mmap and temporary glitch in the fence registers (see
eb8d0f5af4ec ("drm/i915: Remove GPU reset dependence on struct_mutex"),
but that never materialized and was soon removed in 2caffbf11762
("drm/i915: Revoke mmaps and prevent access to fence registers across
reset") and replaced with a SRCU based solution.

As such, as far as I can see, today we still have a requirement that
resets must not sleep (invoked from submission tasklets), but no need to
support invoking them from a truly atomic context.

Given that the preemption section is problematic on RT kernels, since the
uncore lock becomes a sleeping lock and so is invalid in such section,
lets try and remove it. Potential downside is that our short waits on GPU
to complete the reset may get extended if CPU scheduling interferes, but
in practice that probably isn't a deal breaker.

In terms of mechanics, since the preemption disabled block is being
removed we just need to replace a few of the wait_for_atomic macros into
busy looping versions which will work (and not complain) when called from
non-atomic sections.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Chris Wilson <chris.p.wilson@intel.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20230705093025.3689748-1-tvrtko.ursulin@linux.intel.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[PG: backport from v6.4-rt ; minor context fixup caused by b7d70b8b06ed]
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Clark Williams <williams@redhat.com>
(cherry picked from commit 1a80b572f783a15327663bf9e7d71163976e8d6a
v6.1-rt)
Signed-off-by: Joseph Salisbury <joseph.salisbury@canonical.com>
---
 drivers/gpu/drm/i915/gt/intel_reset.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_reset.c b/drivers/gpu/drm/i915/gt/intel_reset.c
index 9dc244b70ce4..06ab730dc9a8 100644
--- a/drivers/gpu/drm/i915/gt/intel_reset.c
+++ b/drivers/gpu/drm/i915/gt/intel_reset.c
@@ -167,13 +167,13 @@ static int i915_do_reset(struct intel_gt *gt,
 	/* Assert reset for at least 20 usec, and wait for acknowledgement. */
 	pci_write_config_byte(pdev, I915_GDRST, GRDOM_RESET_ENABLE);
 	udelay(50);
-	err = wait_for_atomic(i915_in_reset(pdev), 50);
+	err = _wait_for_atomic(i915_in_reset(pdev), 50, 0);
 
 	/* Clear the reset request. */
 	pci_write_config_byte(pdev, I915_GDRST, 0);
 	udelay(50);
 	if (!err)
-		err = wait_for_atomic(!i915_in_reset(pdev), 50);
+		err = _wait_for_atomic(!i915_in_reset(pdev), 50, 0);
 
 	return err;
 }
@@ -193,7 +193,7 @@ static int g33_do_reset(struct intel_gt *gt,
 	struct pci_dev *pdev = to_pci_dev(gt->i915->drm.dev);
 
 	pci_write_config_byte(pdev, I915_GDRST, GRDOM_RESET_ENABLE);
-	return wait_for_atomic(g4x_reset_complete(pdev), 50);
+	return _wait_for_atomic(g4x_reset_complete(pdev), 50, 0);
 }
 
 static int g4x_do_reset(struct intel_gt *gt,
@@ -210,7 +210,7 @@ static int g4x_do_reset(struct intel_gt *gt,
 
 	pci_write_config_byte(pdev, I915_GDRST,
 			      GRDOM_MEDIA | GRDOM_RESET_ENABLE);
-	ret =  wait_for_atomic(g4x_reset_complete(pdev), 50);
+	ret =  _wait_for_atomic(g4x_reset_complete(pdev), 50, 0);
 	if (ret) {
 		GT_TRACE(gt, "Wait for media reset failed\n");
 		goto out;
@@ -218,7 +218,7 @@ static int g4x_do_reset(struct intel_gt *gt,
 
 	pci_write_config_byte(pdev, I915_GDRST,
 			      GRDOM_RENDER | GRDOM_RESET_ENABLE);
-	ret =  wait_for_atomic(g4x_reset_complete(pdev), 50);
+	ret =  _wait_for_atomic(g4x_reset_complete(pdev), 50, 0);
 	if (ret) {
 		GT_TRACE(gt, "Wait for render reset failed\n");
 		goto out;
@@ -736,9 +736,7 @@ int __intel_gt_reset(struct intel_gt *gt, intel_engine_mask_t engine_mask)
 	intel_uncore_forcewake_get(gt->uncore, FORCEWAKE_ALL);
 	for (retry = 0; ret == -ETIMEDOUT && retry < retries; retry++) {
 		GT_TRACE(gt, "engine_mask=%x\n", engine_mask);
-		preempt_disable();
 		ret = reset(gt, engine_mask, retry);
-		preempt_enable();
 	}
 	intel_uncore_forcewake_put(gt->uncore, FORCEWAKE_ALL);
 
-- 
2.34.1

