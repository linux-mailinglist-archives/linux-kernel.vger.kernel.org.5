Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2957A4F39
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjIRQf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjIRQfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:35:30 -0400
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE43E11A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:19:37 -0700 (PDT)
Received: by mail-ot1-x34a.google.com with SMTP id 46e09a7af769-6c46114573fso39839a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695053977; x=1695658777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sNXD76U7haNeW91VMZlpdLB8TVqFEiovhx95zes76gg=;
        b=XT4hOZ7jBUJ/HmcWfgW+s/dDRbl/7htOsH2NkGps9qE5Z1ImL49wk4xDD15aoBNCx0
         qvLbAHeM4e2Y5QGFdnG9zCcH5IK8nhEqK5t8ExM8pC9PkyGSEiCbBiFWQVEwMuo1YWwM
         AEst/M0v7L+JEiRalzoSRENagMo52/t23h6rqIN0KHUxh+uQ7jfoveu6eFgB+LzftNm5
         aOIHWMdhzy/Ei/qRVCedE8R3VnYl9CQWE3HU9a2JC3y7g40XAuQ/wk2hEqa9EnkXHiZ/
         jB5Z28H48T+jnfhYDG1akZ/StInGFYITYuOx+Uhn4/UE/84XXGyAUBUZ9df8mg3eAPIk
         z5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053977; x=1695658777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNXD76U7haNeW91VMZlpdLB8TVqFEiovhx95zes76gg=;
        b=X6taDowNfSpJw/vV8sy25Jpv6VOSakn4HPLnY0XJhmUsbZymKfDcfFmi+em4ozXyMl
         v3ZsCCoZaB6Im/AhjyWQysjlM6JFTV1szv3U6Aier234VuD1SuzIfgk85IJp9qGfVf7V
         Dr1wyJT0o7mRiJ+85kzIRn1JiZpwerwcyAXptdVMdL/zeXleCfnP3hP120NqpMaREf0I
         AdtpEkjJBDQiZrzl9VthoqkB2AdaJrFLEDXgq8RHG3DCGXy0MTfiHCpH6HXE5QZ5+XrZ
         iI2MUaFiJ+UqowXGRDlTgjtf9U2+ov/LG7Mcb0fhZuKYl/C+LOIalkyrKYwjqhcpT+3Q
         lkiQ==
X-Gm-Message-State: AOJu0YwZYYNqXtHCqO7983JWzbaXl9E/a5zKt/WfwkOrRGhIl2oYHUx2
        3RdOkdbVqQFdKAzAffN0iLRaxWzcxLE=
X-Google-Smtp-Source: AGHT+IE1DPoRp0N2nDleDeL+nMknRqhKzdJCPwHMJrwMUBjkYLBNjcfJz91+ASKxJdGzFGGlGgloaP/fXoU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2411:0:b0:d81:78ec:c403 with SMTP id
 k17-20020a252411000000b00d8178ecc403mr192905ybk.12.1695052199184; Mon, 18 Sep
 2023 08:49:59 -0700 (PDT)
Date:   Mon, 18 Sep 2023 08:49:57 -0700
In-Reply-To: <20230918152110.GI13795@ziepe.ca>
Mime-Version: 1.0
References: <20230916003118.2540661-1-seanjc@google.com> <20230916003118.2540661-6-seanjc@google.com>
 <20230918152110.GI13795@ziepe.ca>
Message-ID: <ZQhxpesyXeG+qbS6@google.com>
Subject: Re: [PATCH 05/26] vfio: KVM: Pass get/put helpers from KVM to VFIO,
 don't do circular lookup
From:   Sean Christopherson <seanjc@google.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Anish Ghulati <aghulati@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>,
        Andrew Thornton <andrewth@google.com>
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

On Mon, Sep 18, 2023, Jason Gunthorpe wrote:
> On Fri, Sep 15, 2023 at 05:30:57PM -0700, Sean Christopherson wrote:
> > Explicitly pass KVM's get/put helpers to VFIO when attaching a VM to
> > VFIO instead of having VFIO do a symbol lookup back into KVM.  Having both
> > KVM and VFIO do symbol lookups increases the overall complexity and places
> > an unnecessary dependency on KVM (from VFIO) without adding any value.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  drivers/vfio/vfio.h      |  2 ++
> >  drivers/vfio/vfio_main.c | 74 +++++++++++++++++++---------------------
> >  include/linux/vfio.h     |  4 ++-
> >  virt/kvm/vfio.c          |  9 +++--
> >  4 files changed, 47 insertions(+), 42 deletions(-)
> 
> I don't mind this, but Christoph had disliked my prior attempt to do
> this with function pointers..
> 
> The get can be inlined, IIRC, what about putting a pointer to the put
> inside the kvm struct?

That wouldn't allow us to achieve our goal, which is to hide the details of
"struct kvm" from VFIO (and the rest of the kernel).

What's the objection to handing VFIO a function pointer?

> The the normal kvm get/put don't have to exported symbols at all?

The export of kvm_get_kvm_safe() can go away (I forgot to do that in this series),
but kvm_get_kvm() will hang around as it's needed by KVM sub-modules (PPC and x86),
KVMGT (x86), and drivers/s390/crypto/vfio_ap_ops.c (no idea what to call that beast).

Gah, KVMGT doesn't actually need to call get/put, that can be handled by
kvm_page_track_register_notifier().

I am planning on making exports for sub-modules conditional on there actually
being submodules, so that's 2 of the 3 gone, but tackling the s390 crypto driver
is an entirely different story.
