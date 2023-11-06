Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6129C7E1FE9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjKFLZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFLZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:25:35 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1211EBB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 03:25:32 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-778999c5ecfso283870085a.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 03:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699269931; x=1699874731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FgFIIfzRIOk5S3UyWAM1hrnYX4eHCPdXXTgA8O3M1A=;
        b=CSAKZPPUhSeyEd+FVcFc/wE7BH7/lltaIavlc/tV7hlCdyKd83MMBTrV4+2QdjaVI5
         re4Un19fI8++TRdDNzRRKVcWvhkLL5hRE/PqjHicq6Yg52UVbIXndvrRV6Y+TqCqW1KP
         qwPYKB/RiUmn66O/9+Cxdqjq0ID/uK5pDYKZLyw9rZRF4ogasppO4z/41nUiWVolLMta
         dMqk+CU3+vSnN3anBCRC9fxV98Q/ooEzqgWQN4zqGELxiSKQ8Q3rnh5J5cUjgD/5TWLv
         B1bAVx7MMqrfiqcClz5zDUFdg87t03JoNLveKQUJkQ3+GPd+OuaUIRgcoruGyCpDK+Lr
         x1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699269931; x=1699874731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FgFIIfzRIOk5S3UyWAM1hrnYX4eHCPdXXTgA8O3M1A=;
        b=TZGniFU+h3aSkGdPa+yzWaKJ/iipCpQR4AdXLXU+IK6djsqgqdvaHQCZACdujBHncp
         pnrsfwAluXCqtlC8yuK4nSfCFGuYDXKtykCLEejHPzcoFPXqkCsCz/Y8HMVoVG+X2eEP
         /X81kgBdR9m7opAo2AbQI3WCt/pNH0I9c66EJx5aeiTqJlhd7+YFgXszHpwPucPNVdFM
         fufzPNjj83e1ELM1Wp2i9tRK6yAE+WxqeGywewRa9k1pNXiCYu6T26S4E4V+dIBoHSbr
         jsrS57jtQI7OvHZwJAD/BOZV7IhUcUvTuN0Bbyp6WUIhtbdAk1LTO3uxowvZBPJ93t3B
         +6lg==
X-Gm-Message-State: AOJu0YyiFCVbLHCPGOHm2LX7e+KOequJniK2nJWnaGezHtNORk8uJqF+
        vSycJN6CWy0i0FAhZEsTAMhP0JPuCM5qRF78mujhCQ==
X-Google-Smtp-Source: AGHT+IF4yL2/LL4u2aXRMHdIO4tBxiGnD2Sg0p8AaFV/BRnT///c7YsCa6iLfBADu8SZkPGs+0c1ElvE1cEBNyIvvIQ=
X-Received: by 2002:a05:6214:ac9:b0:671:7312:bf5 with SMTP id
 g9-20020a0562140ac900b0067173120bf5mr32557664qvi.17.1699269931062; Mon, 06
 Nov 2023 03:25:31 -0800 (PST)
MIME-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-26-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-26-pbonzini@redhat.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 6 Nov 2023 11:24:54 +0000
Message-ID: <CA+EHjTxy6TWM3oBG0Q6v5090XTrs+M8_m5=6Z2E1P-HyTkrGWg@mail.gmail.com>
Subject: Re: [PATCH 25/34] KVM: selftests: Add helpers to convert guest memory
 b/w private and shared
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sean Christopherson <seanjc@google.com>,
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 5, 2023 at 4:34=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> From: Vishal Annapurve <vannapurve@google.com>
>
> Add helpers to convert memory between private and shared via KVM's
> memory attributes, as well as helpers to free/allocate guest_memfd memory
> via fallocate().  Userspace, i.e. tests, is NOT required to do fallocate(=
)
> when converting memory, as the attributes are the single source of true.

nit: true->truth

> Provide allocate() helpers so that tests can mimic a userspace that frees
> private memory on conversion, e.g. to prioritize memory usage over
> performance.
>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-Id: <20231027182217.3615211-28-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .../selftests/kvm/include/kvm_util_base.h     | 48 +++++++++++++++++++
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 28 +++++++++++
>  2 files changed, 76 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/=
testing/selftests/kvm/include/kvm_util_base.h
> index 9f861182c02a..1441fca6c273 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -333,6 +333,54 @@ static inline void vm_enable_cap(struct kvm_vm *vm, =
uint32_t cap, uint64_t arg0)
>         vm_ioctl(vm, KVM_ENABLE_CAP, &enable_cap);
>  }
>
> +static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t =
gpa,
> +                                           uint64_t size, uint64_t attri=
butes)
> +{
> +       struct kvm_memory_attributes attr =3D {
> +               .attributes =3D attributes,
> +               .address =3D gpa,
> +               .size =3D size,
> +               .flags =3D 0,
> +       };
> +
> +       /*
> +        * KVM_SET_MEMORY_ATTRIBUTES overwrites _all_ attributes.  These =
flows
> +        * need significant enhancements to support multiple attributes.
> +        */
> +       TEST_ASSERT(!attributes || attributes =3D=3D KVM_MEMORY_ATTRIBUTE=
_PRIVATE,
> +                   "Update me to support multiple attributes!");
> +
> +       vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &attr);
> +}
> +
> +
> +static inline void vm_mem_set_private(struct kvm_vm *vm, uint64_t gpa,
> +                                     uint64_t size)
> +{
> +       vm_set_memory_attributes(vm, gpa, size, KVM_MEMORY_ATTRIBUTE_PRIV=
ATE);
> +}
> +
> +static inline void vm_mem_set_shared(struct kvm_vm *vm, uint64_t gpa,
> +                                    uint64_t size)
> +{
> +       vm_set_memory_attributes(vm, gpa, size, 0);
> +}
> +
> +void vm_guest_mem_fallocate(struct kvm_vm *vm, uint64_t gpa, uint64_t si=
ze,
> +                           bool punch_hole);
> +
> +static inline void vm_guest_mem_punch_hole(struct kvm_vm *vm, uint64_t g=
pa,
> +                                          uint64_t size)
> +{
> +       vm_guest_mem_fallocate(vm, gpa, size, true);
> +}
> +
> +static inline void vm_guest_mem_allocate(struct kvm_vm *vm, uint64_t gpa=
,
> +                                        uint64_t size)
> +{
> +       vm_guest_mem_fallocate(vm, gpa, size, false);
> +}
> +
>  void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size);
>  const char *vm_guest_mode_string(uint32_t i);
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/s=
elftests/kvm/lib/kvm_util.c
> index b63500fca627..95a553400ea9 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1167,6 +1167,34 @@ void vm_mem_region_delete(struct kvm_vm *vm, uint3=
2_t slot)
>         __vm_mem_region_delete(vm, memslot2region(vm, slot), true);
>  }
>
> +void vm_guest_mem_fallocate(struct kvm_vm *vm, uint64_t base, uint64_t s=
ize,
> +                           bool punch_hole)
> +{
> +       const int mode =3D FALLOC_FL_KEEP_SIZE | (punch_hole ? FALLOC_FL_=
PUNCH_HOLE : 0);
> +       struct userspace_mem_region *region;
> +       uint64_t end =3D base + size;
> +       uint64_t gpa, len;
> +       off_t fd_offset;
> +       int ret;
> +
> +       for (gpa =3D base; gpa < end; gpa +=3D len) {
> +               uint64_t offset;
> +
> +               region =3D userspace_mem_region_find(vm, gpa, gpa);
> +               TEST_ASSERT(region && region->region.flags & KVM_MEM_GUES=
T_MEMFD,
> +                           "Private memory region not found for GPA 0x%l=
x", gpa);
> +
> +               offset =3D (gpa - region->region.guest_phys_addr);

nit: why the parentheses?

> +               fd_offset =3D region->region.guest_memfd_offset + offset;
> +               len =3D min_t(uint64_t, end - gpa, region->region.memory_=
size - offset);
> +
> +               ret =3D fallocate(region->region.guest_memfd, mode, fd_of=
fset, len);
> +               TEST_ASSERT(!ret, "fallocate() failed to %s at %lx (len =
=3D %lu), fd =3D %d, mode =3D %x, offset =3D %lx\n",
> +                           punch_hole ? "punch hole" : "allocate", gpa, =
len,
> +                           region->region.guest_memfd, mode, fd_offset);
> +       }
> +}
> +
>  /* Returns the size of a vCPU's kvm_run structure. */
>  static int vcpu_mmap_sz(void)
>  {

Nits aside:

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> --
> 2.39.1
>
>
