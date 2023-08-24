Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18DB786472
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 03:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbjHXBF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 21:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238945AbjHXBFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 21:05:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F685101
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 18:05:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7494be34f8so4814287276.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 18:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692839115; x=1693443915;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciPsiCz8yRdds7TlQN57K1bIWKakCjV9gzutuPf6Vpo=;
        b=SdedHeyF9zT2I6oXPzI3C3PP/mWA2v6GF689lF8eMP3dYY9zcq9TQv9ARwOxgX4hrk
         Zc5rVcfASn1P8Ce9MK7mx6CzUikF7D+F7l2TsNdlaj3W8xMAz6sSb+fpJ5YhVPUOV8WT
         3+vbvQJCr2xSG4Xp/m/XuwsFtx0wd6025Wnk/9AqbavbE7cNMyIPsRr+iwGfx2cGg+IB
         xuGAH13yQvPFe78Kzsi4xwEf5ceBfXz0TVVkhtrrbmE5oEsohONv9ysIsLjRgGnY3dXB
         Kfgj+OuUi2tKEbrtIT3d7lgfoCiM6UkB9cutLawQZYqyrIpM70ykbE2jqYBufK8V9w8/
         IWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692839115; x=1693443915;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ciPsiCz8yRdds7TlQN57K1bIWKakCjV9gzutuPf6Vpo=;
        b=gP9IFCcjAMo/ajJzNG+XGpzW9OF6SRfh3ir62uwU4LHCgb9W7sQEB+WD6pAMkC0PMK
         L0hl13dDNTnuF+9AAEGMZFclY/2kHz+zMAeTa9RSogD5lzShvkTQhYPLomves1pOKjIt
         6pOI13dr11id/H203w9oSM9XgptV6NTtYjOFVutwN6P7fWZnkbj9+XH8eniZDBSEbN7Y
         aKMSV9upvXk/oNN6I1gCTZZI5v/AFloJvQvCCm+2yrYybdIRYGdibzbFlcH3Xw4ms6g9
         UcEfGgje1z2Cs506WA1RAoXOOH0pQy1vWM4A8MH1oRZKVFtofZlmuGadrsF+UvVSojmr
         ECBA==
X-Gm-Message-State: AOJu0YybKkvfPKCMHgh/s6QTN5wuHJJUzqFHvfXdq8jAULqdHk8kNPI8
        fMJq+Q41Njd9GgvbtNg2UvYKOY5elss=
X-Google-Smtp-Source: AGHT+IGvZeYDmJ5qRDwkuav3SWHa2ryrgfkFo061XRpAtQVhMvYGtZtAxM56ojlm5rlYbmzFAkShwllBI4Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ce14:0:b0:c15:cbd1:60da with SMTP id
 x20-20020a25ce14000000b00c15cbd160damr178097ybe.6.1692839114887; Wed, 23 Aug
 2023 18:05:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 23 Aug 2023 18:05:12 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230824010512.2714931-1-seanjc@google.com>
Subject: [PATCH 5.15] Revert "KVM: x86: enable TDP MMU by default"
From:   Sean Christopherson <seanjc@google.com>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the TDP MMU by default in v5.15 kernels to "fix" several severe
performance bugs that have since been found and fixed in the TDP MMU, but
are unsuitable for backporting to v5.15.

The problematic bugs are fixed by upstream commit edbdb43fc96b ("KVM:
x86: Preserve TDP MMU roots until they are explicitly invalidated") and
commit 01b31714bd90 ("KVM: x86: Do not unload MMU roots when only toggling
CR0.WP with TDP enabled").  Both commits fix scenarios where KVM will
rebuild all TDP MMU page tables in paths that are frequently hit by
certain guest workloads.  While not exactly common, the guest workloads
are far from rare.  The fallout of rebuilding TDP MMU page tables can be
so severe in some cases that it induces soft lockups in the guest.

Commit edbdb43fc96b would require _significant_ effort and churn to
backport due it depending on a major rework that was done in v5.18.

Commit 01b31714bd90 has far fewer direct conflicts, but has several subtle
_known_ dependencies, and it's unclear whether or not there are more
unknown dependencies that have been missed.

Lastly, disabling the TDP MMU in v5.15 kernels also fixes a lurking train
wreck started by upstream commit a955cad84cda ("KVM: x86/mmu: Retry page
fault if root is invalidated by memslot update").  That commit was tagged
for stable to fix a memory leak, but didn't cherry-pick cleanly and was
never backported to v5.15.  Which is extremely fortunate, as it introduced
not one but two bugs, one of which was fixed by upstream commit
18c841e1f411 ("KVM: x86: Retry page fault if MMU reload is pending and
root has no sp"), while the other was unknowingly fixed by upstream
commit ba6e3fe25543 ("KVM: x86/mmu: Grab mmu_invalidate_seq in
kvm_faultin_pfn()") in v6.3 (a one-off fix will be made for v6.1 kernels,
which did receive a backport for a955cad84cda).  Disabling the TDP MMU
by default reduces the probability of breaking v5.15 kernels by
backporting only a subset of the fixes.

As far as what is lost by disabling the TDP MMU, the main selling point of
the TDP MMU is its ability to service page fault VM-Exits in parallel,
i.e. the main benefactors of the TDP MMU are deployments of large VMs
(hundreds of vCPUs), and in particular delployments that live-migrate such
VMs and thus need to fault-in huge amounts of memory on many vCPUs after
restarting the VM after migration.

Smaller VMs can see performance improvements, but nowhere enough to make
up for the TDP MMU (in v5.15) absolutely cratering performance for some
workloads.  And practically speaking, anyone that is deploying and
migrating VMs with hundreds of vCPUs is likely rolling their own kernel,
not using a stock v5.15 series kernel.

This reverts commit 71ba3f3189c78f756a659568fb473600fd78f207.

Link: https://lore.kernel.org/all/ZDmEGM+CgYpvDLh6@google.com
Link: https://lore.kernel.org/all/f023d927-52aa-7e08-2ee5-59a2fbc65953@gameservers.com
Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc: Mathias Krause <minipli@grsecurity.net>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 6c2bb60ccd88..7a64fb238044 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -10,7 +10,7 @@
 #include <asm/cmpxchg.h>
 #include <trace/events/kvm.h>
 
-static bool __read_mostly tdp_mmu_enabled = true;
+static bool __read_mostly tdp_mmu_enabled = false;
 module_param_named(tdp_mmu, tdp_mmu_enabled, bool, 0644);
 
 /* Initializes the TDP MMU for the VM, if enabled. */

base-commit: f6f7927ac664ba23447f8dd3c3dfe2f4ee39272f
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

