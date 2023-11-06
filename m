Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3877E1FA8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjKFLKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjKFLKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:10:31 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D72110CC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 03:10:24 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66d11fec9a5so24016056d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 03:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699269023; x=1699873823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnJqfkSSRV3TBP0JexdvtsqLHYDxALR7H+cYP6TRCJE=;
        b=SJtS3dqUGrKW28uxSwfWyiN0BGL2D7TgvMufK+WSZ9HkYWxoBPNKag1WoIpZ2KtIAq
         W79SAPZQirGVO7OBeSqppVDUTxG+xM/lQZ9xm+HKBFVDbasWLoBLQ7V0jAaGHm7/dEEd
         O+qOVeidLuM93YEJ7+c10RnZ/TI0X4DP8y39eEHqdCBJWbS3kAXskWEdxWEak4iAA4mv
         P77vJHf6as5d6EDfWSFK2uAC/d5TmKftjgt7VMZABpJCg0BMBWfCQ+YL1FwynvdwH99x
         JhY0PoPirXyevOmuNgGS8empZ2/IwKkwOBeCFm26KmsNflqmuKaMb46eo9D9RQwQP9NC
         fecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699269023; x=1699873823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnJqfkSSRV3TBP0JexdvtsqLHYDxALR7H+cYP6TRCJE=;
        b=oJ7HQQ8EiGRD5BOWjpW+obJVAYZdCeFoRvK2c4LXDYW2UgepF3pKDgU9/RnCASnvnh
         /3AHd9nQIJDkPwwTbJgoTgsJDFBnIwVcMozKi0Cutq4j3nSxAWJA93B/0z2BxR4DZ5TZ
         ixwig91u4z/HWlmRJbQNOZ9Ibb7uADgFwq7N65jHoPOfnBi/a4Z11WUFpSMNFSHgVGcC
         cC3TGZ35hbmeGyk5E+AFCKi1y7jP0cPaVq6u7t+vJ+N3+eWgBQkvo69TfATtUqFDtOF4
         YiLUSrkCzOLVA+IdAh32My5/d2BC5YAtQ/KuTzjwtC6+VpqGKgEmzHofc/uwqqGM8mmn
         rpdQ==
X-Gm-Message-State: AOJu0YzmNesrqpmUcvkeZFnDeg2Q5xTSWRP3T1p6w7D52SFFXcc8d2N9
        x5uhb0XKgV64XqvFo+8HDkK9RLutek4uB7TR5OYn8A==
X-Google-Smtp-Source: AGHT+IHU/+pefiFnPy+6hnE6koYxy9w/9xmRXHTMFvjZ+YNn5s7SNPQyF9p0CVa6tIfW5b4YJfx0jin9klIyZI5tK50=
X-Received: by 2002:a05:6214:d62:b0:66d:2eab:85ec with SMTP id
 2-20020a0562140d6200b0066d2eab85ecmr28750220qvs.61.1699269022903; Mon, 06 Nov
 2023 03:10:22 -0800 (PST)
MIME-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-25-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-25-pbonzini@redhat.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 6 Nov 2023 11:09:46 +0000
Message-ID: <CA+EHjTwOFAEMchVjob=3chD-TJ=Wau3iPnLdtFXBtiRUG4Dtug@mail.gmail.com>
Subject: Re: [PATCH 24/34] KVM: selftests: Add support for creating private memslots
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Regarding the subject (and the commit message), should we still be
calling them "private" slots, or guestmem_slots?

On Sun, Nov 5, 2023 at 4:34=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Add support for creating "private" memslots via KVM_CREATE_GUEST_MEMFD an=
d
> KVM_SET_USER_MEMORY_REGION2.  Make vm_userspace_mem_region_add() a wrappe=
r
> to its effective replacement, vm_mem_add(), so that private memslots are
> fully opt-in, i.e. don't require update all tests that add memory regions=
.

nit: update->updating

>
> Pivot on the KVM_MEM_PRIVATE flag instead of the validity of the "gmem"

KVM_MEM_PRIVATE  -> KVM_MEM_GUEST_MEMFD

> file descriptor so that simple tests can let vm_mem_add() do the heavy
> lifting of creating the guest memfd, but also allow the caller to pass in
> an explicit fd+offset so that fancier tests can do things like back
> multiple memslots with a single file.  If the caller passes in a fd, dup(=
)
> the fd so that (a) __vm_mem_region_delete() can close the fd associated
> with the memory region without needing yet another flag, and (b) so that
> the caller can safely close its copy of the fd without having to first
> destroy memslots.
>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-Id: <20231027182217.3615211-27-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .../selftests/kvm/include/kvm_util_base.h     | 23 ++++++
>  .../testing/selftests/kvm/include/test_util.h |  5 ++
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 76 +++++++++++--------
>  3 files changed, 73 insertions(+), 31 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/=
testing/selftests/kvm/include/kvm_util_base.h
> index 9f144841c2ee..9f861182c02a 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -431,6 +431,26 @@ static inline uint64_t vm_get_stat(struct kvm_vm *vm=
, const char *stat_name)
>
>  void vm_create_irqchip(struct kvm_vm *vm);
>
> +static inline int __vm_create_guest_memfd(struct kvm_vm *vm, uint64_t si=
ze,
> +                                       uint64_t flags)
> +{
> +       struct kvm_create_guest_memfd guest_memfd =3D {
> +               .size =3D size,
> +               .flags =3D flags,
> +       };
> +
> +       return __vm_ioctl(vm, KVM_CREATE_GUEST_MEMFD, &guest_memfd);
> +}
> +
> +static inline int vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size=
,
> +                                       uint64_t flags)
> +{
> +       int fd =3D __vm_create_guest_memfd(vm, size, flags);
> +
> +       TEST_ASSERT(fd >=3D 0, KVM_IOCTL_ERROR(KVM_CREATE_GUEST_MEMFD, fd=
));
> +       return fd;
> +}
> +
>  void vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32_=
t flags,
>                                uint64_t gpa, uint64_t size, void *hva);
>  int __vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32=
_t flags,
> @@ -439,6 +459,9 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>         enum vm_mem_backing_src_type src_type,
>         uint64_t guest_paddr, uint32_t slot, uint64_t npages,
>         uint32_t flags);
> +void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type=
,
> +               uint64_t guest_paddr, uint32_t slot, uint64_t npages,
> +               uint32_t flags, int guest_memfd_fd, uint64_t guest_memfd_=
offset);
>
>  void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t =
flags);
>  void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_g=
pa);
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/test=
ing/selftests/kvm/include/test_util.h
> index 7e614adc6cf4..7257f2243ab9 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -142,6 +142,11 @@ static inline bool backing_src_is_shared(enum vm_mem=
_backing_src_type t)
>         return vm_mem_backing_src_alias(t)->flag & MAP_SHARED;
>  }
>
> +static inline bool backing_src_can_be_huge(enum vm_mem_backing_src_type =
t)
> +{
> +       return t !=3D VM_MEM_SRC_ANONYMOUS && t !=3D VM_MEM_SRC_SHMEM;
> +}
> +
>  /* Aligns x up to the next multiple of size. Size must be a power of 2. =
*/
>  static inline uint64_t align_up(uint64_t x, uint64_t size)
>  {
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/s=
elftests/kvm/lib/kvm_util.c
> index 3676b37bea38..b63500fca627 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -669,6 +669,8 @@ static void __vm_mem_region_delete(struct kvm_vm *vm,
>                 TEST_ASSERT(!ret, __KVM_SYSCALL_ERROR("munmap()", ret));
>                 close(region->fd);
>         }
> +       if (region->region.guest_memfd >=3D 0)
> +               close(region->region.guest_memfd);
>
>         free(region);
>  }
> @@ -870,36 +872,15 @@ void vm_set_user_memory_region(struct kvm_vm *vm, u=
int32_t slot, uint32_t flags,
>                     errno, strerror(errno));
>  }
>
> -/*
> - * VM Userspace Memory Region Add
> - *
> - * Input Args:
> - *   vm - Virtual Machine
> - *   src_type - Storage source for this region.
> - *              NULL to use anonymous memory.

"VM_MEM_SRC_ANONYMOUS to use anonymous memory"

> - *   guest_paddr - Starting guest physical address
> - *   slot - KVM region slot
> - *   npages - Number of physical pages
> - *   flags - KVM memory region flags (e.g. KVM_MEM_LOG_DIRTY_PAGES)
> - *
> - * Output Args: None
> - *
> - * Return: None
> - *
> - * Allocates a memory area of the number of pages specified by npages
> - * and maps it to the VM specified by vm, at a starting physical address
> - * given by guest_paddr.  The region is created with a KVM region slot
> - * given by slot, which must be unique and < KVM_MEM_SLOTS_NUM.  The
> - * region is created with the flags given by flags.
> - */
> -void vm_userspace_mem_region_add(struct kvm_vm *vm,
> -       enum vm_mem_backing_src_type src_type,
> -       uint64_t guest_paddr, uint32_t slot, uint64_t npages,
> -       uint32_t flags)
> +/* FIXME: This thing needs to be ripped apart and rewritten. */

It sure does :)

With these nits:

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> +void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type=
,
> +               uint64_t guest_paddr, uint32_t slot, uint64_t npages,
> +               uint32_t flags, int guest_memfd, uint64_t guest_memfd_off=
set)
>  {
>         int ret;
>         struct userspace_mem_region *region;
>         size_t backing_src_pagesz =3D get_backing_src_pagesz(src_type);
> +       size_t mem_size =3D npages * vm->page_size;
>         size_t alignment;
>
>         TEST_ASSERT(vm_adjust_num_guest_pages(vm->mode, npages) =3D=3D np=
ages,
> @@ -952,7 +933,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>         /* Allocate and initialize new mem region structure. */
>         region =3D calloc(1, sizeof(*region));
>         TEST_ASSERT(region !=3D NULL, "Insufficient Memory");
> -       region->mmap_size =3D npages * vm->page_size;
> +       region->mmap_size =3D mem_size;
>
>  #ifdef __s390x__
>         /* On s390x, the host address must be aligned to 1M (due to PGSTE=
s) */
> @@ -999,14 +980,38 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>         /* As needed perform madvise */
>         if ((src_type =3D=3D VM_MEM_SRC_ANONYMOUS ||
>              src_type =3D=3D VM_MEM_SRC_ANONYMOUS_THP) && thp_configured(=
)) {
> -               ret =3D madvise(region->host_mem, npages * vm->page_size,
> +               ret =3D madvise(region->host_mem, mem_size,
>                               src_type =3D=3D VM_MEM_SRC_ANONYMOUS ? MADV=
_NOHUGEPAGE : MADV_HUGEPAGE);
>                 TEST_ASSERT(ret =3D=3D 0, "madvise failed, addr: %p lengt=
h: 0x%lx src_type: %s",
> -                           region->host_mem, npages * vm->page_size,
> +                           region->host_mem, mem_size,
>                             vm_mem_backing_src_alias(src_type)->name);
>         }
>
>         region->backing_src_type =3D src_type;
> +
> +       if (flags & KVM_MEM_GUEST_MEMFD) {
> +               if (guest_memfd < 0) {
> +                       uint32_t guest_memfd_flags =3D 0;
> +                       TEST_ASSERT(!guest_memfd_offset,
> +                                   "Offset must be zero when creating ne=
w guest_memfd");
> +                       guest_memfd =3D vm_create_guest_memfd(vm, mem_siz=
e, guest_memfd_flags);
> +               } else {
> +                       /*
> +                        * Install a unique fd for each memslot so that t=
he fd
> +                        * can be closed when the region is deleted witho=
ut
> +                        * needing to track if the fd is owned by the fra=
mework
> +                        * or by the caller.
> +                        */
> +                       guest_memfd =3D dup(guest_memfd);
> +                       TEST_ASSERT(guest_memfd >=3D 0, __KVM_SYSCALL_ERR=
OR("dup()", guest_memfd));
> +               }
> +
> +               region->region.guest_memfd =3D guest_memfd;
> +               region->region.guest_memfd_offset =3D guest_memfd_offset;
> +       } else {
> +               region->region.guest_memfd =3D -1;
> +       }
> +
>         region->unused_phy_pages =3D sparsebit_alloc();
>         sparsebit_set_num(region->unused_phy_pages,
>                 guest_paddr >> vm->page_shift, npages);
> @@ -1019,9 +1024,10 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm=
,
>         TEST_ASSERT(ret =3D=3D 0, "KVM_SET_USER_MEMORY_REGION2 IOCTL fail=
ed,\n"
>                 "  rc: %i errno: %i\n"
>                 "  slot: %u flags: 0x%x\n"
> -               "  guest_phys_addr: 0x%lx size: 0x%lx",
> +               "  guest_phys_addr: 0x%lx size: 0x%lx guest_memfd: %d\n",
>                 ret, errno, slot, flags,
> -               guest_paddr, (uint64_t) region->region.memory_size);
> +               guest_paddr, (uint64_t) region->region.memory_size,
> +               region->region.guest_memfd);
>
>         /* Add to quick lookup data structures */
>         vm_userspace_mem_region_gpa_insert(&vm->regions.gpa_tree, region)=
;
> @@ -1042,6 +1048,14 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm=
,
>         }
>  }
>
> +void vm_userspace_mem_region_add(struct kvm_vm *vm,
> +                                enum vm_mem_backing_src_type src_type,
> +                                uint64_t guest_paddr, uint32_t slot,
> +                                uint64_t npages, uint32_t flags)
> +{
> +       vm_mem_add(vm, src_type, guest_paddr, slot, npages, flags, -1, 0)=
;
> +}
> +
>  /*
>   * Memslot to region
>   *
> --
> 2.39.1
>
>
