Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA08E7FFC6D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjK3U2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjK3U2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:28:03 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FA910FF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:28:09 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cfa392a13eso15161175ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701376089; x=1701980889; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4OV4iNp1w41nYYoXLoX47tRgNsubd9PkYcYHlp6v5Ac=;
        b=JESR4D/SMy+tEtRVMEMg+JPiL8wFcuss6ItmFTbhNE8e+lzHHRvZy6etYTNArz/4Cc
         TlK/UsDIkUJGV+AZtENwSYVa6py70kslDCpEuvGBsOgKrQa0Z/+10pLa3Uw8V+GXO9DF
         rqz9K0i8L3p+1pcBPywdCM423eRWEKu+8qt17ikqEBOXyyEX+zO6ds90KyIjsHism/gk
         nhzI3weejNOQriGzeGaMOdqhxf0zPtdY2+1crF6CXMeXOedsOZlCTZSazlJ9xJ5GsKvn
         Vn+a78PIWoFH9iRup4Hb9w76OPCjRbKcaVb6lTXwM1yfQy70GgVd1uFseIvPuIeIcO4P
         8KxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701376089; x=1701980889;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4OV4iNp1w41nYYoXLoX47tRgNsubd9PkYcYHlp6v5Ac=;
        b=XQr+eG1lEQmx2D1k5HrhMBOPDFTeDt1wQbmGqin/V/mlzCHFr79s442xtc2yYM6sJn
         erR4bZiwcjxROctz1D3chqQFZ6wpyvW4mGmwn1NHDu/g4qloeo0Gju8Zffr3y1Af3Yyk
         Karkt57etuT36jB7AlnVjk9EwTrCNnKhaCASwDgqkupbYhERxc68LmXdKgjzeyk1ByO3
         1Fp5KTwu6OW0GEjUkAO7MN33JcfqWPvROa6cWYUxZ60abU/+NMRq8axh3BrheSm6Jo2y
         B9p5Jimqz8Q/vyW8VR2REkGk8OEEJ/2s6JFqhryxnVGGnGz+bk5pCfG09+cGeEyKMx2D
         iujw==
X-Gm-Message-State: AOJu0Yxyz2alREUDL0W9R8sONp0uqzcCnVCS/wnT3I0IRytPbYa06Dpf
        s0OsozTu2Lt0SKMrJYnjxzIExN1/hyM=
X-Google-Smtp-Source: AGHT+IHQaxLEqA5rxsivnhYLveGHXMN8rfV5UgZ8GpYx6Dig6VjxZKpBbPSRb9b7A6hv0E+T/P1KhLt82O8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e84f:b0:1cf:ee4c:1200 with SMTP id
 t15-20020a170902e84f00b001cfee4c1200mr1827241plg.5.1701376088878; Thu, 30 Nov
 2023 12:28:08 -0800 (PST)
Date:   Thu, 30 Nov 2023 12:28:07 -0800
In-Reply-To: <ZTcO8M3T9DGYrN2M@google.com>
Mime-Version: 1.0
References: <20231024001636.890236-1-jmattson@google.com> <20231024001636.890236-2-jmattson@google.com>
 <ZTcO8M3T9DGYrN2M@google.com>
Message-ID: <ZWjwV7rQ9i2NCf5A@google.com>
Subject: Re: [PATCH 2/2] KVM: x86: Use a switch statement in __feature_translate()
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "'Paolo Bonzini '" <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023, Sean Christopherson wrote:
> On Mon, Oct 23, 2023, Jim Mattson wrote:
> > The compiler will probably do better than linear search.
> 
> It shouldn't matter, KVM relies on the compiler to resolve the translation at
> compile time, e.g. the result is fed into reverse_cpuid_check().
> 
> I.e. we should pick whatever is least ugly.

What if we add a macro to generate each case statement?  It's arguably a wee bit
more readable, and also eliminates the possibility of returning the wrong feature
due to copy+paste errors, e.g. nothing would break at compile time if we goofed
and did:

	case X86_FEATURE_SGX1:
		return KVM_X86_FEATURE_SGX1;
	case X86_FEATURE_SGX2:
		return KVM_X86_FEATURE_SGX1;

If you've no objection, I'll push this:

--
Author: Jim Mattson <jmattson@google.com>
Date:   Mon Oct 23 17:16:36 2023 -0700

    KVM: x86: Use a switch statement and macros in __feature_translate()
    
    Use a switch statement with macro-generated case statements to handle
    translating feature flags in order to reduce the probability of runtime
    errors due to copy+paste goofs, to make compile-time errors easier to
    debug, and to make the code more readable.
    
    E.g. the compiler won't directly generate an error for duplicate if
    statements
    
            if (x86_feature == X86_FEATURE_SGX1)
                    return KVM_X86_FEATURE_SGX1;
            else if (x86_feature == X86_FEATURE_SGX2)
                    return KVM_X86_FEATURE_SGX1;
    
    and so instead reverse_cpuid_check() will fail due to the untranslated
    entry pointing at a Linux-defined leaf, which provides practically no
    hint as to what is broken
    
      arch/x86/kvm/reverse_cpuid.h:108:2: error: call to __compiletime_assert_450 declared with 'error' attribute:
                                          BUILD_BUG_ON failed: x86_leaf == CPUID_LNX_4
              BUILD_BUG_ON(x86_leaf == CPUID_LNX_4);
              ^
    whereas duplicate case statements very explicitly point at the offending
    code:
    
      arch/x86/kvm/reverse_cpuid.h:125:2: error: duplicate case value '361'
              KVM_X86_TRANSLATE_FEATURE(SGX2);
              ^
      arch/x86/kvm/reverse_cpuid.h:124:2: error: duplicate case value '360'
              KVM_X86_TRANSLATE_FEATURE(SGX1);
              ^
    
    And without macros, the opposite type of copy+paste goof doesn't generate
    any error at compile-time, e.g. this yields no complaints:
    
            case X86_FEATURE_SGX1:
                    return KVM_X86_FEATURE_SGX1;
            case X86_FEATURE_SGX2:
                    return KVM_X86_FEATURE_SGX1;
    
    Note, __feature_translate() is forcibly inlined and the feature is known
    at compile-time, so the code generation between an if-elif sequence and a
    switch statement should be identical.
    
    Signed-off-by: Jim Mattson <jmattson@google.com>
    Link: https://lore.kernel.org/r/20231024001636.890236-2-jmattson@google.com
    [sean: use a macro, rewrite changelog]
    Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 17007016d8b5..aadefcaa9561 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -116,20 +116,19 @@ static __always_inline void reverse_cpuid_check(unsigned int x86_leaf)
  */
 static __always_inline u32 __feature_translate(int x86_feature)
 {
-       if (x86_feature == X86_FEATURE_SGX1)
-               return KVM_X86_FEATURE_SGX1;
-       else if (x86_feature == X86_FEATURE_SGX2)
-               return KVM_X86_FEATURE_SGX2;
-       else if (x86_feature == X86_FEATURE_SGX_EDECCSSA)
-               return KVM_X86_FEATURE_SGX_EDECCSSA;
-       else if (x86_feature == X86_FEATURE_CONSTANT_TSC)
-               return KVM_X86_FEATURE_CONSTANT_TSC;
-       else if (x86_feature == X86_FEATURE_PERFMON_V2)
-               return KVM_X86_FEATURE_PERFMON_V2;
-       else if (x86_feature == X86_FEATURE_RRSBA_CTRL)
-               return KVM_X86_FEATURE_RRSBA_CTRL;
+#define KVM_X86_TRANSLATE_FEATURE(f)   \
+       case X86_FEATURE_##f: return KVM_X86_FEATURE_##f
 
-       return x86_feature;
+       switch (x86_feature) {
+       KVM_X86_TRANSLATE_FEATURE(SGX1);
+       KVM_X86_TRANSLATE_FEATURE(SGX2);
+       KVM_X86_TRANSLATE_FEATURE(SGX_EDECCSSA);
+       KVM_X86_TRANSLATE_FEATURE(CONSTANT_TSC);
+       KVM_X86_TRANSLATE_FEATURE(PERFMON_V2);
+       KVM_X86_TRANSLATE_FEATURE(RRSBA_CTRL);
+       default:
+               return x86_feature;
+       }
 }
 
 static __always_inline u32 __feature_leaf(int x86_feature)

