Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4833A7E86BA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjKJXz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344717AbjKJXzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:55:46 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697CC448C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:55:43 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-28016806be2so3296287a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699660543; x=1700265343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=lj6QboIyWdPKwpOPfJ3u7CONO+6S55iCaYCfcwC+TWo=;
        b=iEc25nsvsauTcalh84eeP2HJzFe5VLQfjJRlce3g+JgdgW88cWCLLkwEWIsPEeRen5
         PS+gkCXWD4jhG86f4Z/5iI7UYt20uB43lH1Tp7EdGruwFDctylDUtOLypXMrolNmJsGk
         /Yf5aPFUZ6W62xO+UFACyXDpyHPz5wQR/LTgW8P/d6TkO5mOXJj4eUms4UEA9bGFBwS1
         poWH/MCetJjhhebB1/B3Xcz0xeKegNd5TbFzEwFJB5F0UrtvlxVnol/dkNMpymRG0n0+
         Mqlrr/hHJQw46i8dW1pAhnyvTU1sJ92Ly/7KBHo6U9gYO9BP1G/MXHogAEk1vwT/7O7e
         9TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699660543; x=1700265343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lj6QboIyWdPKwpOPfJ3u7CONO+6S55iCaYCfcwC+TWo=;
        b=GDXirv4NwRMdQOia5l7HTjqOH6283KAPR2GgyxtmZB7n3/6CthntUIblLWloWdDvNV
         V7jBoxC4rOgQXMVRjkgWQwnrVlBup6IopB7cx3lxFAjhu9/wDfcyf4LRGzijPjV4f50P
         V6KmS7rdbwYjjSJDV6o+Nb1iRQaKIbaL58xlZGBkNn/ynYLcqCUtNDhh4iiHWw2+hgPm
         WS3goQxL/ADFRL2PFE1LEbfuqpsmL6YFNUAz2hVSBjVsfdDmC637WT4pETE7o5V1RP3D
         hYwEMIqBdEktfo0558I7WEAG8RShxxQk9Mlx4EvObJVRE3jisih5jmV8H8pMkvUWS2yr
         8slg==
X-Gm-Message-State: AOJu0YxKf9euGgM0ETzuC3TdhBQMdpKkEIA5mPs/0kxRQUwtm4IHweGm
        UecZKc4KjZ3d2N5KnkdkfUOmd3dynWk=
X-Google-Smtp-Source: AGHT+IGnfhC7CLi2jPB1BP4mqYcKdyc5bXkMBRuQ0Ukestup4m0lzMxogNBHWXgmaVlSgUzREdADxCqw4EE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e413:b0:27d:3322:68aa with SMTP id
 hv19-20020a17090ae41300b0027d332268aamr164287pjb.2.1699660542941; Fri, 10 Nov
 2023 15:55:42 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Nov 2023 15:55:24 -0800
In-Reply-To: <20231110235528.1561679-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110235528.1561679-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110235528.1561679-6-seanjc@google.com>
Subject: [PATCH 5/9] KVM: x86: Drop unnecessary check that cpuid_entry2_find()
 returns right leaf
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop an unnecessary check that cpuid_entry2_find() returns the correct
leaf when getting CPUID.0x7.0x0 to update X86_FEATURE_OSPKE, as
cpuid_entry2_find() never returns an entry for the wrong function.  And
not that it matters, but cpuid_entry2_find() will always return a precise
match for CPUID.0x7.0x0 since the index is significant.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 6777780be6ae..36bd04030989 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -284,7 +284,7 @@ static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_e
 	}
 
 	best = cpuid_entry2_find(entries, nent, 7, 0);
-	if (best && boot_cpu_has(X86_FEATURE_PKU) && best->function == 0x7)
+	if (best && boot_cpu_has(X86_FEATURE_PKU))
 		cpuid_entry_change(best, X86_FEATURE_OSPKE,
 				   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
 
-- 
2.42.0.869.gea05f2083d-goog

