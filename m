Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EC977D141
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbjHORmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238927AbjHORmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:42:19 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75061BD2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:42:17 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-684c8a66e86so6047746b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692121337; x=1692726137;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I85hmMEUfQYoNIAIbzoOssifzEA41haxq2Yrcu6u0/4=;
        b=O29+28g02fpA1C6NlzwVGPY8eRAEeK8NVduW8N2KjdxPVJCz2HW5jWnMBX0bDDL9Sa
         rKIcOrSMTc3sJfjK+/Z3Pg9RO7nLQiR19dT4wyksYH5VdshYj7Ah6D85fqLhSgqqrvZJ
         4eIeeSGbb7AWshM/XYfJnuLumjOk0ilbev+72PDkpk9GvEpVPkbM5QZTmfPtn7YV5u4s
         46JfzgMDopKhbeEvWqqiLKoi+Va5vC9ECkO1gcCNxMdxNtIKrbcxt03sQCDAfa/+V+1p
         q5HFqHZqXsDSCu0ft3TkxR4hw2Uv77DCWrr5CpwAGjFeSkEzDXOvyd18OWirVeuuNM8N
         bOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692121337; x=1692726137;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I85hmMEUfQYoNIAIbzoOssifzEA41haxq2Yrcu6u0/4=;
        b=IAAcTxiVccWT4bu/yYyRIheI0unaGMXACpcIivZ8PRdi3IjeSFECE2JD3R+cNWiB1N
         ybrzSJtvshGv5gg9f213ho1aGGrxw+TQeJGZYUFFhEtzumHPLpXV3hBosl5ICk6lWywt
         cOxZ4+prwkZ6OMVArUpkxBtMJWhLaktkiWlulRqB04P9qGGgP7aogeSvhQFL9dhoqZX0
         PJVknM+BkkUdsiC2KZGG7aPV81mW8Zcjk0Q9fFFSPjtccUCWvV0Si/SrKEubehgMqV29
         gR2gWXjGjCEsDckE0Hi39Gysz/BadLacXZdruOor9yNGIuJt3pvUeMAAuE7LmiZ7N1Ms
         kKgQ==
X-Gm-Message-State: AOJu0YyYYaAMk1rkcvochlnfq2lHq27Em983zFrA8xpI/CZpOaRTEgZG
        tfl+cUW0xkZ0LR9lqbGzyCFXg5tg8cA=
X-Google-Smtp-Source: AGHT+IEmiqcN2YRYAzdWGaGfLTHuDo20/Rre8XF+8NajJbqYsdhtNoO78nHJYJuqpJxqAKa91/SNTwvof04=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d0e:b0:666:e42c:d5ec with SMTP id
 fa14-20020a056a002d0e00b00666e42cd5ecmr5881663pfb.3.1692121337470; Tue, 15
 Aug 2023 10:42:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 15 Aug 2023 10:42:15 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230815174215.433222-1-seanjc@google.com>
Subject: [PATCH] KVM: VMX: Delete ancient pr_warn() about KVM_SET_TSS_ADDR not
 being set
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Glaser <t.glaser@tarent.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete KVM's printk about KVM_SET_TSS_ADDR not being called.  When the
printk was added by commit 776e58ea3d37 ("KVM: unbreak userspace that does
not sets tss address"), KVM also stuffed a "hopefully safe" value, i.e.
the message wasn't purely informational.  For reasons unknown, ostensibly
to try and help people running outdated qemu-kvm versions, the message got
left behind when KVM's stuffing was removed by commit 4918c6ca6838
("KVM: VMX: Require KVM_SET_TSS_ADDR being called prior to running a VCPU").

Today, the message is completely nonsensical, as it has been over a decade
since KVM supported userspace running a Real Mode guest, on a CPU without
unrestricted guest support, without doing KVM_SET_TSS_ADDR before KVM_RUN.
I.e. KVM's ABI has required KVM_SET_TSS_ADDR for 10+ years.

To make matters worse, the message is prone to false positives as it
triggers when simply *creating* a vCPU due to RESET putting vCPUs into
Real Mode, even when the user has no intention of ever *running* the vCPU
in a Real Mode.  E.g. KVM selftests stuff 64-bit mode and never touch Real
Mode, but trigger the message even though they run just fine without
doing KVM_SET_TSS_ADDR.  Creating "dummy" vCPUs, e.g. to probe features,
can also trigger the message.  In both scenarios, the message confuses
users and falsely implies that they've done something wrong.

Reported-by: Thorsten Glaser <t.glaser@tarent.de>
Closes: https://lkml.kernel.org/r/f1afa6c0-cde2-ab8b-ea71-bfa62a45b956%40tarent.de
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8cf1c00d9352..aadbe1a23e3a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3061,13 +3061,6 @@ static void enter_rmode(struct kvm_vcpu *vcpu)
 
 	vmx->rmode.vm86_active = 1;
 
-	/*
-	 * Very old userspace does not call KVM_SET_TSS_ADDR before entering
-	 * vcpu. Warn the user that an update is overdue.
-	 */
-	if (!kvm_vmx->tss_addr)
-		pr_warn_once("KVM_SET_TSS_ADDR needs to be called before running vCPU\n");
-
 	vmx_segment_cache_clear(vmx);
 
 	vmcs_writel(GUEST_TR_BASE, kvm_vmx->tss_addr);

base-commit: 240f736891887939571854bd6d734b6c9291f22e
-- 
2.41.0.694.ge786442a9b-goog

