Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3EA7E148A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 17:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjKEQUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 11:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjKEQUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 11:20:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9B6DE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 08:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699201191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5S45DCFEET4FUlleAs+X25SSP8exRtkoxGaiIZR36AY=;
        b=Qs3HRrP3qIhpoKM72TcYby7LjkynOYF2uGUiYgOpf4cM1NTdPhrht9wGz/KnO3gBjJxfUq
        mza5kadjnoQ8KRXMz4halkRbOGmF7JZQRnmEXEipVlcbqxqYJs2bJ/KxI1kMpBJJetCEJF
        dDxtT0VknqS2ie5C9oxIB6gY14EdZkk=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-DV5Uv0HoPz6PrJx3jndauA-1; Sun, 05 Nov 2023 11:19:50 -0500
X-MC-Unique: DV5Uv0HoPz6PrJx3jndauA-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4ac2ffa81f1so312122e0c.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 08:19:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699201190; x=1699805990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5S45DCFEET4FUlleAs+X25SSP8exRtkoxGaiIZR36AY=;
        b=vyb61WUi6UEm+aPl9IAn8KUzOJQp7HW12/hIPvAL2+GI22ryMzYOqKe6z5KAhC7DU6
         PSvBYX+Dswq4JQvMQXPMwRxVGRq0kVSIfT5r6KQebIbs/P33qY89Yi4qX6EwCd2QNqWA
         EXEatdIx3vxz3WuxfWCAZf7vL+rywCDSygvvEeqT/iYbVlEigXnzMlnXslWbR/E6I+qE
         pwkKuTiCy6p16TvF5k1eIpcf/GmnpjUPLivIlkKrzKkAXcNpCbHmFpbCxh56XY+ED3Qh
         1rB+E3p//eLryKEQ/aVVK2IXd1SwhGPSJZbX1rV2dQXXLbAAaXotCGZhWO0tJTpo8kJA
         DL/w==
X-Gm-Message-State: AOJu0Ywm2JnWg05IJwpKhC3Cs0c72jMb5uEmt4f+sZPUmanF1w+j2Hlp
        CaOESA+sLCW9yJ4lQJoUM/5Quy37w18V9AYWQPNJ7vaUU3HM+B0p8wXZxfb6BlWLUofY1z/w9p4
        iPoDbKP0O+RyeuUOhwO+05gWQtDL73kPJ/Xj0dQn1
X-Received: by 2002:a05:6102:4743:b0:45d:8f83:e10f with SMTP id ej3-20020a056102474300b0045d8f83e10fmr5351504vsb.4.1699201189803;
        Sun, 05 Nov 2023 08:19:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9PY/ps/exIZhJtEiBPcrHL5I4MFvN3fWtoZJg4K/o1jMHEXmGlTLfpUZIUzDcxTZUf1dOb3c60KPU/ucxafo=
X-Received: by 2002:a05:6102:4743:b0:45d:8f83:e10f with SMTP id
 ej3-20020a056102474300b0045d8f83e10fmr5351461vsb.4.1699201189503; Sun, 05 Nov
 2023 08:19:49 -0800 (PST)
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-21-seanjc@google.com>
 <ZUeSaAKRemlSRQpO@yilunxu-OptiPlex-7050>
In-Reply-To: <ZUeSaAKRemlSRQpO@yilunxu-OptiPlex-7050>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Sun, 5 Nov 2023 17:19:36 +0100
Message-ID: <CABgObfb1Wf2ptitGhJPM6VcmkCG9haMoQj2BsttjeoV=9F0O9Q@mail.gmail.com>
Subject: Re: [PATCH v13 20/35] KVM: x86/mmu: Handle page fault for private memory
To:     Xu Yilun <yilun.xu@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        David Matlack <dmatlack@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 5, 2023 at 2:04=E2=80=AFPM Xu Yilun <yilun.xu@linux.intel.com> =
wrote:
>
> > +static void kvm_mmu_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
> > +                                           struct kvm_page_fault *faul=
t)
> > +{
> > +     kvm_prepare_memory_fault_exit(vcpu, fault->gfn << PAGE_SHIFT,
> > +                                   PAGE_SIZE, fault->write, fault->exe=
c,
> > +                                   fault->is_private);
> > +}
> > +
> > +static int kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
> > +                                struct kvm_page_fault *fault)
> > +{
> > +     int max_order, r;
> > +
> > +     if (!kvm_slot_can_be_private(fault->slot)) {
> > +             kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> > +             return -EFAULT;
> > +     }
> > +
> > +     r =3D kvm_gmem_get_pfn(vcpu->kvm, fault->slot, fault->gfn, &fault=
->pfn,
> > +                          &max_order);
> > +     if (r) {
> > +             kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> > +             return r;
>
> Why report KVM_EXIT_MEMORY_FAULT here? even with a ret !=3D -EFAULT?

The cases are EFAULT, EHWPOISON (which can report
KVM_EXIT_MEMORY_FAULT) and ENOMEM. I think it's fine
that even -ENOMEM can return KVM_EXIT_MEMORY_FAULT,
and it doesn't violate the documentation.  The docs tell you "what
can you do if error if EFAULT or EHWPOISON?"; they don't
exclude that other errnos result in KVM_EXIT_MEMORY_FAULT,
it's just that you're not supposed to look at it

Paolo

