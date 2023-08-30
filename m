Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A3478E0FF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbjH3UwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240241AbjH3UwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:52:21 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FFAC5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:51:52 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c0cfc2b995so839665ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693428644; x=1694033444; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbCG0tdyar/6+EAaNY79S340Vu6kvaT6TpEIPobVhxc=;
        b=Yj2QWrVreMlTbQK+zmVecrzzrIvOX55wuOowwoBWU84sDgyun1W1Wqqs+v6o2Cxbu8
         CAOTFj9tWo1UKKx9lhkqKd/jgoRqCZGOivV2SuamZ1u+MzAHd3iUJa8/JnMLSDkhd+qg
         /lb0pKNxC/CtctcZzQ+ZxvHkT5lAhzAdlgJJRX1R0z5XraK2h5bexdX0LJ/5BTuM7Dy+
         C6D7EvRHTWJWmrY7AlmVfLsFOsxRf370FJzFnn/5cBKdeFPfiKQLMzUEPJE9+PGHgIlo
         LprqXMo+9rshZ0hrNk3j82WZk0SI08S+G+wYmrcU0XGUaCOFJJ2JL5UuC+J3V7+VzzP4
         UVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693428644; x=1694033444;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbCG0tdyar/6+EAaNY79S340Vu6kvaT6TpEIPobVhxc=;
        b=PSKKoTQM4mN2t73ynPMuSrcGWCqDjfzwIgDVm9ZY98zgGMNYqEqe/A7uEb2XvZdcuN
         lKOHsaVDJ87UgJv6nJd+7R4UuUCtQkq9VaGmCKzarSqk9mdBXbCeS0C2DGcSn/XtOphb
         5bpyzB/QLpf8DKes0yXS4tahVMm9XJ2SRVgz7PGImN6E/Wiw7l7ZS3oFNy3II+OdcehP
         KOIqYonGhYrlqsV0j34kq1At+lctUYzWKzNrlwGNpPLskCY1kc8dw+Cncdr0Zma3FYXI
         RRd5Wu/3DHir+Ihy+f23/IdRU9imYm7sg+SJ+eilNJehqF2Ci6OEMae/uacf/hCQ67BZ
         o5Ag==
X-Gm-Message-State: AOJu0YxTAb4A76FFqoxQjJZl4oI4ae6N9TAWWlJAr7YR2fI2OBc0GDZW
        AXjCcZMYJfiVIWeoDVPU5Fdt19R5QJ0=
X-Google-Smtp-Source: AGHT+IF5b6gqdFR2LDLZ3RJxfd4VjOhdzQk4NFKot509LSj0408O/0vZ9+YO40BiHXDBFLY89BYeBDPkQrA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:234a:b0:1bc:5182:1de2 with SMTP id
 c10-20020a170903234a00b001bc51821de2mr856300plh.1.1693428644421; Wed, 30 Aug
 2023 13:50:44 -0700 (PDT)
Date:   Wed, 30 Aug 2023 13:50:42 -0700
In-Reply-To: <6c691bc5-dbfc-46f9-8c09-9c74c51d8708@gmail.com>
Mime-Version: 1.0
References: <20230729013535.1070024-1-seanjc@google.com> <20230729013535.1070024-17-seanjc@google.com>
 <6c691bc5-dbfc-46f9-8c09-9c74c51d8708@gmail.com>
Message-ID: <ZO+roobNH2QbZZWn@google.com>
Subject: Re: [PATCH v4 16/29] KVM: x86: Reject memslot MOVE operations if
 KVMGT is attached
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     kvm@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Yongwei Ma <yongwei.ma@intel.com>,
        Ben Gardon <bgardon@google.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023, Like Xu wrote:
> On 2023/7/29 09:35, Sean Christopherson wrote:
> > Disallow moving memslots if the VM has external page-track users, i.e. if
> > KVMGT is being used to expose a virtual GPU to the guest, as KVMGT doesn't
> > correctly handle moving memory regions.
> > 
> > Note, this is potential ABI breakage!  E.g. userspace could move regions
> > that aren't shadowed by KVMGT without harming the guest.  However, the
> > only known user of KVMGT is QEMU, and QEMU doesn't move generic memory
> 
> This change breaks two kvm selftests:
> 
> - set_memory_region_test;
> - memslot_perf_test;

It shoudn't.  As of this patch, KVM doesn't register itself as a page-track user,
i.e. KVMGT is the only remaining caller to kvm_page_track_register_notifier().
Unless I messed up, the only way kvm_page_track_has_external_user() can return
true is if KVMGT is attached to the VM.  The selftests most definitely don't do
anything with KVMGT, so I don't see how they can fail.

Are you seeing actually failures?

> Please help confirm if the tests/doc needs to be updated,
> or if the assumption needs to be further clarified.

What assumption?

> > regions.  KVM's own support for moving memory regions was also broken for
> > multiple years (albeit for an edge case, but arguably moving RAM is
> > itself an edge case), e.g. see commit edd4fa37baa6 ("KVM: x86: Allocate
> > new rmap and large page tracking when moving memslot").
> > 
> > Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
> > Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/include/asm/kvm_page_track.h | 3 +++
> >   arch/x86/kvm/mmu/page_track.c         | 5 +++++
> >   arch/x86/kvm/x86.c                    | 7 +++++++
> >   3 files changed, 15 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/kvm_page_track.h b/arch/x86/include/asm/kvm_page_track.h
> > index 8c4d216e3b2b..f744682648e7 100644
> > --- a/arch/x86/include/asm/kvm_page_track.h
> > +++ b/arch/x86/include/asm/kvm_page_track.h
> > @@ -75,4 +75,7 @@ kvm_page_track_unregister_notifier(struct kvm *kvm,
> >   void kvm_page_track_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
> >   			  int bytes);
> >   void kvm_page_track_flush_slot(struct kvm *kvm, struct kvm_memory_slot *slot);
> > +
> > +bool kvm_page_track_has_external_user(struct kvm *kvm);
> > +
> >   #endif
> > diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
> > index 891e5cc52b45..e6de9638e560 100644
> > --- a/arch/x86/kvm/mmu/page_track.c
> > +++ b/arch/x86/kvm/mmu/page_track.c
> > @@ -303,3 +303,8 @@ void kvm_page_track_flush_slot(struct kvm *kvm, struct kvm_memory_slot *slot)
> >   			n->track_flush_slot(kvm, slot, n);
> >   	srcu_read_unlock(&head->track_srcu, idx);
> >   }
> > +
> > +bool kvm_page_track_has_external_user(struct kvm *kvm)
> > +{
> > +	return hlist_empty(&kvm->arch.track_notifier_head.track_notifier_list);
> > +}
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 059571d5abed..4394bb49051f 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -12606,6 +12606,13 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
> >   				   struct kvm_memory_slot *new,
> >   				   enum kvm_mr_change change)
> >   {
> > +	/*
> > +	 * KVM doesn't support moving memslots when there are external page
> > +	 * trackers attached to the VM, i.e. if KVMGT is in use.
> > +	 */
> > +	if (change == KVM_MR_MOVE && kvm_page_track_has_external_user(kvm))
> > +		return -EINVAL;
> > +
> >   	if (change == KVM_MR_CREATE || change == KVM_MR_MOVE) {
> >   		if ((new->base_gfn + new->npages - 1) > kvm_mmu_max_gfn())
> >   			return -EINVAL;
