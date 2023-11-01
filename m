Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539967DE8D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 00:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbjKAXST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 19:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjKAXSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 19:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F26135
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 16:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698880647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0vwHZc+/Gns5rEzdivTNKNr5j0n3GZLH4TX/0o56Y/4=;
        b=chyzq9C4fVwZzI3soe1A5mGtIdOLQK9TeWLdrfFE2MWQm87zJdSKxYsXrj9pZuoC2K0u/2
        +Jcv9wvuE7yWgatY0YOqsAswsY6VWszGHZPAi6yjsyGxCwQ2EEllY3bb8OaRnr3HPcxVej
        wzYgkpgzPN7v1eUl1rFJV+jZBcXcj+E=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-U-EXtD-mNPO7-k6wh5u8sg-1; Wed, 01 Nov 2023 19:17:25 -0400
X-MC-Unique: U-EXtD-mNPO7-k6wh5u8sg-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-457bc611991so160204137.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 16:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698880645; x=1699485445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vwHZc+/Gns5rEzdivTNKNr5j0n3GZLH4TX/0o56Y/4=;
        b=L6MsAaspYuMDjez7NSkKOTjinNcvV98khithaOrxLR0MyqEZkdlk5Tvs4DumtZ/6Ln
         7OatTw3yb1durxQToHkZmrD7iutAoV0GOTbBugoRwGvE4ZxwIlZ3OvpSCNNmaw+w+WW4
         Iwam0JAVZOKRZooJci83ubJ9XKu9hw1qyLu41E3PcugEG/ZEw11brPW+rjCmix+1X+H9
         KqQc4j0fGanw2zbd5EUsB6IslyzMaW6faRfXiL66Mr0ggHjpgA25vjtRYW1+dQFY50U8
         CQRiwSCtwkFimiUmnO/BxdVxmUWoYxNaTT3JuT21d52PeVHK1NWb4tcvlzF989EMjA0K
         pHWw==
X-Gm-Message-State: AOJu0YzaHhwD/NKFdbfigYjOhNDnEIielOx+V65zeOH11rqJsT2KD/+W
        QlExnWodTEk0NKDK8R26lwitXK1d/v1vY9yvroLSL38eZluWYA28avoLb9vzpl6NDzvwNPZW9OQ
        Rkh0Lp2zsCiy6mtexW1JhWCZDA5F7kqI0iTu9fu/o
X-Received: by 2002:a67:b70e:0:b0:450:8e58:2de4 with SMTP id h14-20020a67b70e000000b004508e582de4mr14946742vsf.7.1698880645387;
        Wed, 01 Nov 2023 16:17:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERW8ZMUKS1oQBttUXGlXfpcF1aXMGz29SltsJOczMO7DdV5tM2YzmJ2Q5mLWwPrzL7OcDPCpWawHIyBUWWBis=
X-Received: by 2002:a67:b70e:0:b0:450:8e58:2de4 with SMTP id
 h14-20020a67b70e000000b004508e582de4mr14946722vsf.7.1698880645133; Wed, 01
 Nov 2023 16:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-18-seanjc@google.com>
 <7c0844d8-6f97-4904-a140-abeabeb552c1@intel.com> <ZUEML6oJXDCFJ9fg@google.com>
 <92ba7ddd-2bc8-4a8d-bd67-d6614b21914f@intel.com> <ZUJVfCkIYYFp5VwG@google.com>
 <CABgObfaw4Byuzj5J3k48jdwT0HCKXLJNiuaA9H8Dtg+GOq==Sw@mail.gmail.com>
 <ZUJ-cJfofk2d_I0B@google.com> <4ca2253d-276f-43c5-8e9f-0ded5d5b2779@redhat.com>
 <ZULSkilO-tdgDGyT@google.com>
In-Reply-To: <ZULSkilO-tdgDGyT@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 2 Nov 2023 00:17:13 +0100
Message-ID: <CABgObfbq_Hg0B=jvsSDqYH3CSpX+RsxfwB-Tc-eYF4uq2Qw9cg@mail.gmail.com>
Subject: Re: [PATCH v13 17/35] KVM: Add transparent hugepage support for
 dedicated guest memory
To:     Sean Christopherson <seanjc@google.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>, Marc Zyngier <maz@kernel.org>,
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
        linux-kernel@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
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
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 1, 2023 at 11:35=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Nov 01, 2023, Paolo Bonzini wrote:
> > On 11/1/23 17:36, Sean Christopherson wrote:
> > > > > "Allow" isn't perfect, e.g. I would much prefer a straight KVM_GU=
EST_MEMFD_USE_HUGEPAGES
> > > > > or KVM_GUEST_MEMFD_HUGEPAGES flag, but I wanted the name to conve=
y that KVM doesn't
> > > > > (yet) guarantee hugepages.  I.e. KVM_GUEST_MEMFD_ALLOW_HUGEPAGE i=
s stronger than
> > > > > a hint, but weaker than a requirement.  And if/when KVM supports =
a dedicated memory
> > > > > pool of some kind, then we can add KVM_GUEST_MEMFD_REQUIRE_HUGEPA=
GE.
> > > > I think that the current patch is fine, but I will adjust it to alw=
ays
> > > > allow the flag, and to make the size check even if !CONFIG_TRANSPAR=
ENT_HUGEPAGE.
> > > > If hugepages are not guaranteed, and (theoretically) you could have=
 no
> > > > hugepage at all in the result, it's okay to get this result even if=
 THP is not
> > > > available in the kernel.
> > > Can you post a fixup patch?  It's not clear to me exactly what behavi=
or you intend
> > > to end up with.
> >
> > Sure, just this:
> >
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index 7d1a33c2ad42..34fd070e03d9 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -430,10 +430,7 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_cr=
eate_guest_memfd *args)
> >  {
> >       loff_t size =3D args->size;
> >       u64 flags =3D args->flags;
> > -     u64 valid_flags =3D 0;
> > -
> > -     if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> > -             valid_flags |=3D KVM_GUEST_MEMFD_ALLOW_HUGEPAGE;
> > +     u64 valid_flags =3D KVM_GUEST_MEMFD_ALLOW_HUGEPAGE;
> >       if (flags & ~valid_flags)
> >               return -EINVAL;
> > @@ -441,11 +438,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_cr=
eate_guest_memfd *args)
> >       if (size < 0 || !PAGE_ALIGNED(size))
> >               return -EINVAL;
> > -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >       if ((flags & KVM_GUEST_MEMFD_ALLOW_HUGEPAGE) &&
> >           !IS_ALIGNED(size, HPAGE_PMD_SIZE))
> >               return -EINVAL;
> > -#endif
>
> That won't work, HPAGE_PMD_SIZE is valid only for CONFIG_TRANSPARENT_HUGE=
PAGE=3Dy.
>
> #else /* CONFIG_TRANSPARENT_HUGEPAGE */
> #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
> #define HPAGE_PMD_MASK ({ BUILD_BUG(); 0; })
> #define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })

Would have caught it when actually testing it, I guess. :) It has to
be PMD_SIZE, possibly with

#ifdef CONFIG_TRANSPARENT_HUGEPAGE
BUILD_BUG_ON(HPAGE_PMD_SIZE !=3D PMD_SIZE);
#endif

for extra safety.

Paolo

