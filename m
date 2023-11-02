Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824EE7DF474
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376693AbjKBOCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjKBOCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:02:19 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711A8130
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:02:16 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-672096e0e89so5552426d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698933735; x=1699538535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U02Q7Uz9N3AbuVAnly2/lx/zX8zq9jlSHWgyTKq7w1o=;
        b=Yxy4gQpwYzPaq9tP896yqaCi9p11oYl2Yzvg3AOcYCBzXFNcPARUyBNABoHe9j9N3V
         wcBmk8rMRqhtKI0gtYIRh61Q/cqDIcZE8J4dHHUV6LHQRoOmJuNLhNQ6cmmaeKBSxVRV
         64KMyHAErZ+NOkvBIgGj9Mc1O1KS55eSImpiDRj1arP6EztcNJW3ziCErr+nM8bBP9/z
         c1srkNrEVFXof5T1vl+NJ8cXDxQh0UvP6/wANNL5klwVVRz1nyj0QLrFARtokMET/G/J
         lrcHEQMbta2sM5ZZpxZWXLDAHHjVIDEqCYqYABwvEC3pOo95InIC6QSaE8lq0Pi45HPM
         5eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933735; x=1699538535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U02Q7Uz9N3AbuVAnly2/lx/zX8zq9jlSHWgyTKq7w1o=;
        b=b7ZzjxqclleGH0n+dAVBqi5oVfpja7H5N9j5I94dC5ZDtkxP0Z6Pcc4cnwMNSdHtx5
         zoTiJXfHiA3Ru98xPTDKIzie5fbAYe7HA6MdzHdY7ge97kCsHrDYomEJK6oO/h653naG
         U0jnB/4nY4drRhp+x0mmrbIceyhcZ99tnN2ppt0jK9z6iK4o6J2JcYgwMpZKhrW9Tqlo
         rvLSbj3iSH6MTOOWhjfAOgUL4KDNh6p8nMY/uRRIn1ZkNLvpRflc67yBnOG+g4WjY+Du
         VC3JXsOfP/6K/pDgZ/aOyfXWR13EaVwcmpkXVTkqcSxcwlg987WPLUUG+nbu/bgzXy2A
         a0kQ==
X-Gm-Message-State: AOJu0YweRH2Sl5dyRLGAEVxGglFyPyr042swl6j0d9C4lc7SpLYhncAs
        xnIxoBdfK0clc1xRaMUXzBCxhOeFvN9t7oyFEWhQbQ==
X-Google-Smtp-Source: AGHT+IFvNZeWhAvz2uQajFEXI2VcBpwz2QgnpWebvg+MWTN/rWHt/IyUj1LF075258r9rR5adzICFKMJ4AWj6dfus40=
X-Received: by 2002:ad4:5c47:0:b0:66d:62b7:53f4 with SMTP id
 a7-20020ad45c47000000b0066d62b753f4mr28124932qva.45.1698933735448; Thu, 02
 Nov 2023 07:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-13-seanjc@google.com>
In-Reply-To: <20231027182217.3615211-13-seanjc@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 2 Nov 2023 14:01:39 +0000
Message-ID: <CA+EHjTyAU9XZ3OgqXjmAKh-BKsLrH_8QtnJihQxF4fhk8WPSYg@mail.gmail.com>
Subject: Re: [PATCH v13 12/35] KVM: Prepare for handling only shared mappings
 in mmu_notifier events
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 27, 2023 at 7:22=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Add flags to "struct kvm_gfn_range" to let notifier events target only
> shared and only private mappings, and write up the existing mmu_notifier
> events to be shared-only (private memory is never associated with a
> userspace virtual address, i.e. can't be reached via mmu_notifiers).
>
> Add two flags so that KVM can handle the three possibilities (shared,
> private, and shared+private) without needing something like a tri-state
> enum.
>
> Link: https://lore.kernel.org/all/ZJX0hk+KpQP0KUyB@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  include/linux/kvm_host.h | 2 ++
>  virt/kvm/kvm_main.c      | 7 +++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 96aa930536b1..89c1a991a3b8 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -263,6 +263,8 @@ struct kvm_gfn_range {
>         gfn_t start;
>         gfn_t end;
>         union kvm_mmu_notifier_arg arg;
> +       bool only_private;
> +       bool only_shared;

If these flags aren't used in this patch series, should this patch be
moved to the other series?

Also, if shared+private is a possibility, doesn't the prefix "only_"
confuse things a bit? I.e., what is shared+private, is it when both
are 0 or when both are 1? I assume it's the former (both are 0), but
it might be clearer.

Cheers,
/fuad

>         bool may_block;
>  };
>  bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index cb9376833c18..302ccb87b4c1 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -635,6 +635,13 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hva=
_range(struct kvm *kvm,
>                          * the second or later invocation of the handler)=
.
>                          */
>                         gfn_range.arg =3D range->arg;
> +
> +                       /*
> +                        * HVA-based notifications aren't relevant to pri=
vate
> +                        * mappings as they don't have a userspace mappin=
g.
> +                        */
> +                       gfn_range.only_private =3D false;
> +                       gfn_range.only_shared =3D true;
>                         gfn_range.may_block =3D range->may_block;
>
>                         /*
> --
> 2.42.0.820.g83a721a137-goog
>
