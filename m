Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DFD7BB097
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 05:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjJFDtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 23:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJFDti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 23:49:38 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C84DE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 20:49:37 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2790596f212so1465977a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 20:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696564176; x=1697168976; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RP5C8+THBjB2H5YRaScy7Lv702OAjYtMFbuoNQ3aYig=;
        b=jiY40mQS7rx7AA7j9sEUkcRwLjOR42+L5NB/aoFPKKKPrNtkokTvm1P0+oYndinsGk
         1gWBofLMn1iaD+E6rWD6kUnfWpdbUuVvTA+F6hI012ku3RlnlPPLb6Iikg+1MnkNcJH6
         84WnvQrw+YMC5vqs8aoSiaebWsjLDNJtn7/xUGrLRpONkEb/PYJ02otA4LU5jVnBa2is
         UvPqYqoMSmdrp6Hs3eoGHRhEHP6xGx2IKYZ43AytBirb15umIpwg9DFT9tWnkEYifmYL
         WQvpvQLCgLdtWidf7SJzyxr8kDPiUHiN2TJQWqqI2ECWSkszb3ie5d3hhQQQPmMGajI5
         +sWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696564176; x=1697168976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RP5C8+THBjB2H5YRaScy7Lv702OAjYtMFbuoNQ3aYig=;
        b=OKCCPkHa2bYtmEo8tZVcqAYV7P1duPHa0cl6Y/EBRTeRtOUu5pYNx4ZG67frstIeFh
         hqqXvc1Y5Pz2SKiZaPDEzOwqzIHY41n5h/1eBcs4ebnBspwKoj9sbSAkac+H6X/VZuql
         bxnFNy9conukjdispwud6pLcKWOTqBy8rriew6iWNTaaOy7KSJf+KWUhsxurtPecIplj
         MOhNGa5jnUSqeYyo5xGXDKZR/17A13KqlSNfyX5wR3gdm/V7xNUibJKt+35xubCpxaj9
         Z0D7CzBIV0zhtgzC/M0IFqqi6IptzkC7dNSFDecrBxLdU6eumxVHa7Zgi0atvAJAg5Ty
         27kA==
X-Gm-Message-State: AOJu0YxSnjq+bbCFLlLNzRbyop+8oPgKNT6+USbeTEf3HvyfN+dKSjfB
        uvPr2BjP9KdTaSTGIbQrUY0WXtNMwyc=
X-Google-Smtp-Source: AGHT+IFilYDOBS7nXWrljMzE2+jIlTAP7zEzSQHMXmmsTdNtHK1HwfNl71hBcy9+Or+muSKsoyfIamb1TyQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:cb8b:b0:268:8e93:6459 with SMTP id
 a11-20020a17090acb8b00b002688e936459mr110379pju.8.1696564176601; Thu, 05 Oct
 2023 20:49:36 -0700 (PDT)
Date:   Thu,  5 Oct 2023 20:48:45 -0700
In-Reply-To: <bfc6d3d7cfb88c47481eabbf5a30a264c58c7789.camel@infradead.org>
Mime-Version: 1.0
References: <bfc6d3d7cfb88c47481eabbf5a30a264c58c7789.camel@infradead.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <169655984952.3566976.10999544287483399463.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86: Refine calculation of guest wall clock to
 use a single TSC read
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Durrant <paul@xen.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2023 10:16:10 +0100, David Woodhouse wrote:
> When populating the guest's PV wall clock information, KVM currently does
> a simple 'kvm_get_real_ns() - get_kvmclock_ns(kvm)'. This is an antipattern
> which should be avoided; when working with the relationship between two
> clocks, it's never correct to obtain one of them "now" and then the other
> at a slightly different "now" after an unspecified period of preemption
> (which might not even be under the control of the kernel, if this is an
> L1 hosting an L2 guest under nested virtualization).
> 
> [...]

Applied to kvm-x86 misc, thanks!  And double thanks for the function comment,
it's awesome!

Note, I moved the declaration in x86.h just below get_kvmclock_ns() to bundle
the two kvmclock helpers together.

[1/1] KVM: x86: Refine calculation of guest wall clock to use a single TSC read
      https://github.com/kvm-x86/linux/commit/5d6d6a7d7e66

--
https://github.com/kvm-x86/linux/tree/next
