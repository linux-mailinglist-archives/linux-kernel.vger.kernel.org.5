Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0087FC24E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344006AbjK1QbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjK1QbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:31:15 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A514D53
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:31:21 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5caf86963ecso79394887b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701189080; x=1701793880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LkifhWeFq2AKAH7BOOvlkDTRE/IRSV6lCofOJbiTrgk=;
        b=BEHt+2359ElZZ5O0q5swBpofB3e6PlqcIlk9Jhlt46Dl+Yy3jDhtYUk75bjhSEioVQ
         NbplDtP+BZciI/dlgikmxAZ8z91Sj4kap+/Ywalcuh495XRDah5bTqjYwk8a162uyXbP
         spMayaUrIAN6BA/t8MbzvJ9RKaQnMdVnt25GwubQPqrYosf6RC9fLLTOrD8nsumc3cAF
         i/qvqcvuf0R3q7sMOFR+pc6oCE3L5GOLrUhoXvXLDpnhPWMX/fOfmuz7IUd0FcxEw+NF
         BXvSNJDpjauz44b7gsRkDKhDCkoHLFW9KSAEsJAcuNoKXsLDH2Z6OOLJV2fWfd/swzsF
         +KyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701189080; x=1701793880;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkifhWeFq2AKAH7BOOvlkDTRE/IRSV6lCofOJbiTrgk=;
        b=RIPwrlgGTKAbOWaxy4QZESR0M+w9KSo+5EnPqkQl39DgrujPLb6pSohF+0LFLjXRDE
         ex/wno71roDzEAV905mxoPiz4qP2dcMTtH5j1JmQbDusqRILsEg0nNPCRZQEjJNfyB3N
         CB/XP5qv3XIauuYI5b/BcQD1crInqjdoSpcsulhJB0NBuefoY+ZEgLXAeYKPItt6ze8B
         HTEU2Q9tkZg/yjkdXwIHvVmB2okHCj4NEPBJypfYwFaGlu+frChGLca5y9w8lX95NWeI
         ZyZEGIl6hM+WwDGTAonUrKz7uxg2rugvEstoCr1Kar/l8eByH3zg0ezY5vGrH5EplnUB
         hdvA==
X-Gm-Message-State: AOJu0YyE0l/sMqPNOlx4bhL5dOdTiJPJH3+F89INeDhZWxHMe7Hdb6I6
        uNkupAfuaOgDgT507Kl4itpEY4rOvZ8=
X-Google-Smtp-Source: AGHT+IE6iXeIU9xVOZUNgTDVtSSOhSFc12TNtoEA7Y1QnCurGnLjmDvGB9zjJ61WPs74wQDuAfvDjFcCHnc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d4c6:0:b0:dae:292e:68de with SMTP id
 m189-20020a25d4c6000000b00dae292e68demr498633ybf.6.1701189080247; Tue, 28 Nov
 2023 08:31:20 -0800 (PST)
Date:   Tue, 28 Nov 2023 08:31:18 -0800
In-Reply-To: <69c10848d4a4f36ab71ca518f4b23d4dee377572.camel@redhat.com>
Mime-Version: 1.0
References: <20231108111806.92604-1-nsaenz@amazon.com> <20231108111806.92604-17-nsaenz@amazon.com>
 <69c10848d4a4f36ab71ca518f4b23d4dee377572.camel@redhat.com>
Message-ID: <ZWYVw93lixTmlCqD@google.com>
Subject: Re: [RFC 16/33] KVM: x86/mmu: Expose R/W/X flags during memory fault exits
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        pbonzini@redhat.com, vkuznets@redhat.com, anelkz@amazon.com,
        graf@amazon.com, dwmw@amazon.co.uk, jgowans@amazon.com,
        corbert@lwn.net, kys@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, x86@kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023, Maxim Levitsky wrote:
> On Wed, 2023-11-08 at 11:17 +0000, Nicolas Saenz Julienne wrote:
> > Include the fault's read, write and execute status when exiting to
> > user-space.
> > 
> > Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c   | 4 ++--
> >  include/linux/kvm_host.h | 9 +++++++--
> >  include/uapi/linux/kvm.h | 6 ++++++
> >  3 files changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 4e02d506cc25..feca077c0210 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -4300,8 +4300,8 @@ static inline u8 kvm_max_level_for_order(int order)
> >  static void kvm_mmu_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
> >  					      struct kvm_page_fault *fault)
> >  {
> > -	kvm_prepare_memory_fault_exit(vcpu, fault->gfn << PAGE_SHIFT,
> > -				      PAGE_SIZE, fault->write, fault->exec,
> > +	kvm_prepare_memory_fault_exit(vcpu, fault->gfn << PAGE_SHIFT, PAGE_SIZE,
> > +				      fault->write, fault->exec, fault->user,
> >  				      fault->is_private);
> >  }
> >  
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 71e1e8cf8936..631fd532c97a 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -2367,14 +2367,19 @@ static inline void kvm_account_pgtable_pages(void *virt, int nr)
> >  static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
> >  						 gpa_t gpa, gpa_t size,
> >  						 bool is_write, bool is_exec,
> > -						 bool is_private)
> > +						 bool is_read, bool is_private)
> 
> It almost feels like there is a need for a struct to hold all of those parameters.

The most obvious solution would be to make "struct kvm_page_fault" common, e.g.
ARM's user_mem_abort() fills RWX booleans just like x86 fills kvm_page_fault.
But I think it's best to wait to do something like that until after Anish's series
lands[*].  That way the conversion can be more of a pure refactoring.

[*] https://lore.kernel.org/all/20231109210325.3806151-1-amoorthy@google.com

