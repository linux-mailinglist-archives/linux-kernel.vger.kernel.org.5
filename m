Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DD7797705
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbjIGQT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240303AbjIGQTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:19:39 -0400
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7F14C2F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:00:11 -0700 (PDT)
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-414c43a48fdso13873891cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694102025; x=1694706825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FgzAJvMWabKSg+Fs2ABIxLNoYDB74sHy1tmQmF1BFrA=;
        b=5XA3nCMqUM6qS8z8uVPlKi3mToDKtyIfODlZ79tP3IR4X9OdcwL9+xvNmPS9Pkbws8
         B0A7xeBV8A6fKXlvYR4+8T0jEHJONzu/Yc5OtDKMEBuCPxmREpOMa9uDVNiN8m7VIBUE
         M/w4J6dkafUQ7MJAzbRreP5svMoYYZ0EEE6tlyyXo+y1tFxJgkNfjwcesbBTyzC+GdKW
         G423gPOjaYsRAVktX6IUixu5a/SEZlf2YA1ReNVvkuoJ0AMSPL4Ezduas3CwjRZOinD1
         8EApinrUYHwwY/T/K2ycw+RLnDiXi1E6GT4bTILBpAWI8VV6J7/7rU0ZpnxqZzSI9ohX
         efqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102025; x=1694706825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgzAJvMWabKSg+Fs2ABIxLNoYDB74sHy1tmQmF1BFrA=;
        b=G2IVCnxasKBRZ1rkh0shuHyeAXHHJFTwaRYliJb6Xl4LNhce7mCXwdj8tqR1TWuE3Y
         MwEOU1CiRE8KbQdWmr76BGmODD7tn7TvcMhQ+Nwu7s2q2TZ/pOVv2xIQLuEPerfogfoL
         YpovfxXhk3qsqJFzB/EcdNluThHJikJyhwlsjXEUSp81I/HD2T5WIjUWh08X32dwyHDE
         LdxcdgDYEvHhJiVWZnDnKo/HmGtNZXTU6CAQsNcMG+lrlcCcy2UdBfVBHPs7PGsijxKi
         19CNmxhTfDlL1/LvmJEg1xotaB5gNNz0BUzcdgEwRjdDs5zCfgs+VS8B9TXiwQwJWGWQ
         OqQA==
X-Gm-Message-State: AOJu0YxvsaMKNLdPDRQjJzQ2/tcOVMeyR7O5RJgISRTT2TaCvtIZ1Psk
        X7MfyM/yvD6yJu6CL2FZzlhhn32cH5w=
X-Google-Smtp-Source: AGHT+IFZD8rMKqtrUZuxadapb0kMDmHCmcHSIKx2uaonJiqykBzMJVL+4SXojH5SnWKxOUNiBkjxt5kZ8C0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1cc:b0:d07:e80c:412e with SMTP id
 u12-20020a05690201cc00b00d07e80c412emr228078ybh.12.1694097933191; Thu, 07 Sep
 2023 07:45:33 -0700 (PDT)
Date:   Thu, 7 Sep 2023 07:45:31 -0700
In-Reply-To: <68859513bc0fb4eda4e3e62ec073dd2a58f7676b.camel@intel.com>
Mime-Version: 1.0
References: <20230825020733.2849862-1-seanjc@google.com> <20230825020733.2849862-3-seanjc@google.com>
 <68859513bc0fb4eda4e3e62ec073dd2a58f7676b.camel@intel.com>
Message-ID: <ZPniC2JCOPMK1JQb@google.com>
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Retry fault before acquiring mmu_lock
 if mapping is changing
From:   Sean Christopherson <seanjc@google.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yan Y Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023, Kai Huang wrote:
> On Thu, 2023-08-24 at 19:07 -0700, Sean Christopherson wrote:
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 1a5a1e7d1eb7..8e2e07ed1a1b 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -4334,6 +4334,9 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
> >  	if (unlikely(!fault->slot))
> >  		return kvm_handle_noslot_fault(vcpu, fault, access);
> >  
> > +	if (mmu_invalidate_retry_hva(vcpu->kvm, fault->mmu_seq, fault->hva))
> > +		return RET_PF_RETRY;
> > +
> 
> ... Perhaps a comment saying this is to avoid unnecessary MMU lock contention
> would be nice.  Otherwise we have is_page_fault_stale() called later within the
> MMU lock.  I suppose people only tend to use git blamer when they cannot find
> answer in the code :-)

Agreed, will add.

> >  	return RET_PF_CONTINUE;
> >  }
> >  
> 
> Btw, currently fault->mmu_seq is set in kvm_faultin_pfn(), which happens after
> fast_page_fault().  Conceptually, should we move this to even before
> fast_page_fault() because I assume the range zapping should also apply to the
> cases that fast_page_fault() handles?

Nope, fast_page_fault() doesn't need to "manually" detect invalidated SPTEs because
it only modifies shadow-present SPTEs and does so with an atomic CMPXCHG.  If a
SPTE is zapped by an mmu_notifier event (or anything else), the CMPXCHG will fail
and fast_page_fault() will see the !PRESENT SPTE on the next retry and bail.
