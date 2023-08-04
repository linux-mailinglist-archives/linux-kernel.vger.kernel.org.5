Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0E9770803
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjHDSfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjHDSeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:34:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6259558B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:32:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c8f360a07a2so2413399276.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691173934; x=1691778734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yicl8HQWxQqj3w4wcqj/w2h6VZPy7YMSL4dCcW63iys=;
        b=xXfEWAUoLym3ey/URqf8+QtwlIpkZM0HYUDSyZKPwfwg6eEFc3tDOHI2jaVWEl3Aq6
         mETmLdNPAjJs2ZrLGwcmlD47anKBY8sHlzZYZL93y4Z+9fO42xryLVBX+eJueLqo/mhd
         vfVumO0H/Y4bvsejUooP4wdEsGwg4yQ94Qkbtk6da5gq6YtgUElhRe9X1DPbGKdalApU
         Afx1Q6HHIt+3qoYHiaUFN5OZ5TScfEOPP+ULTUQuovnWOuwhHdX5Pm/gw9ctqUp4BhqU
         GEa6cZNLQcyVyrwWreZInUb2rN8uW5tLw/1EDtCLNFHS6KRUt+tf2M1XlPqRf1rcpKEr
         ouVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691173934; x=1691778734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yicl8HQWxQqj3w4wcqj/w2h6VZPy7YMSL4dCcW63iys=;
        b=OnhheKorC0/WSqB4K+5KE2UUgJgEPr4oPSn4bpAQeL5Dpt6U1y1KB6D8H9Bi15e5M7
         SWRr2a99YJM4mhAyktUlZqUFFVj1btiK5vOdiK53nuhHo8uoGIIx0C/9hxjgTxacoCSZ
         JW3HIbA5PvcpcHfio8bGAdDwLD1zGQV1Huukb7qey52Y6xUJ0EObKmoO7mjeR4NJ8mc3
         CnGBmqaPR3/nf+vAYZRaHQhL8exMQkJWmKMt3FDLSiJoBlZiN04Vdj6Wm69NhfTaos+r
         z5MSfei4vUiANpe9MVqKsKpz0ZRWqalj0TXFtnnkekusxwXCpfQLCvWQ65EIo7fmro1y
         fVFw==
X-Gm-Message-State: AOJu0YzQn835Fkvw7KZxr4nwVHq01pDrujbCU/prqjTQcUkxuRdWwYtt
        FmlW3SQ4l0qIRkobPk1yFytOcEJ+CYc=
X-Google-Smtp-Source: AGHT+IHoZUXVYbPP+MadD0iZRGDE0s1QJNlhExLbvmwhVTuvQVXgGPBmnTPtoHs7EIJYDdx+8/h9hEmhmmQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1588:b0:d3b:12d3:564e with SMTP id
 k8-20020a056902158800b00d3b12d3564emr14010ybu.2.1691173625936; Fri, 04 Aug
 2023 11:27:05 -0700 (PDT)
Date:   Fri, 4 Aug 2023 11:27:04 -0700
In-Reply-To: <20230803042732.88515-5-weijiang.yang@intel.com>
Mime-Version: 1.0
References: <20230803042732.88515-1-weijiang.yang@intel.com> <20230803042732.88515-5-weijiang.yang@intel.com>
Message-ID: <ZM1C+ILRMCfzJxx7@google.com>
Subject: Re: [PATCH v5 04/19] KVM:x86: Refresh CPUID on write to guest MSR_IA32_XSS
From:   Sean Christopherson <seanjc@google.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, peterz@infradead.org, john.allen@amd.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rick.p.edgecombe@intel.com, chao.gao@intel.com,
        binbin.wu@linux.intel.com, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023, Yang Weijiang wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0b9033551d8c..5d6d6fa33e5b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3780,10 +3780,12 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		 * IA32_XSS[bit 8]. Guests have to use RDMSR/WRMSR rather than
>  		 * XSAVES/XRSTORS to save/restore PT MSRs.
>  		 */
> -		if (data & ~kvm_caps.supported_xss)
> +		if (data & ~vcpu->arch.guest_supported_xss)

Hmm, this is arguably wrong for userspace-initiated writes, as it would prevent
userspace from restoring MSRs before CPUID.

And it would make the handling of MSR_IA32_XSS writes inconsistent just within
this case statement.  The initial "can this MSR be written at all" check would
*not* honor guest CPUID for host writes, but then the per-bit check *would* honor
guest CPUID for host writes.

But if we exempt host writes, then we'll end up with another mess, as exempting
host writes for MSR_KVM_GUEST_SSP would let the guest coerce KVM into writing an
illegal value by modifying SMRAM while in SMM.

Blech.

If we can get away with it, i.e. not break userspace, I think my preference is
to enforce guest CPUID for host accesses to XSS, XFD, XFD_ERR, etc.  I'm 99%
certain we can make that change, because there are many, many MSRs that do NOT
exempt host writes, i.e. the only way this would be a breaking change is if
userspace is writing things like XSS before KVM_SET_CPUID2, but other MSRs after
KVM_SET_CPUID2.

I'm pretty sure I've advocated for the exact opposite in the past, i.e. argued
that KVM's ABI is to not enforce ordering between KVM_SET_CPUID2 and KVM_SET_MSR.
But this is becoming untenable, juggling the dependencies in KVM is complex and
is going to result in a nasty bug at some point.

For this series, lets just tighten the rules for XSS, i.e. drop the host_initated
exemption.  And in a parallel/separate series, try to do a wholesale cleanup of
all the cases that essentially allow userspace to do KVM_SET_MSR before KVM_SET_CPUID2.
