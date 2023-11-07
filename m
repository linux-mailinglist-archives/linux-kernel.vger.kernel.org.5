Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7367E3FD3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343497AbjKGNLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbjKGNLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:11:05 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A552947B0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:07:55 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1f0f160e293so707430fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 05:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699362475; x=1699967275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VRoxoxM3bk/ddMYA7RkVxhIt7sN32CxDfhJasXbdTQ=;
        b=d+AqvpjiFbFAWRV9cRJNKM3v3+qxl1cKA38dut0JjiA4ZbvMBxHGiFdgjCsutproHH
         6HnqdEbNqk0h/X0h52BLPSv3pILQ6OucibhTiP7uDR3GnEkBHBWQnf9hG6p0JVzcviQC
         aY9Ojx2Mztp6zUpbe5e9YEeKDWtdBIkSNLBThIGCKPJKRlP48841vRZ5iB4Uj0BdizKf
         M9PGkCSbajupx+ldPomAqseDO/W0+69X4hr3QQdNE9Onj+F79btBCLki3H9VRTSSO7co
         Zz9FQYfrvqEiG2x5YPNAv5Ud1E/XsNf4yucjlAKenbi1kIrzw8HR08VQVCqGalDrGrq+
         ZbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699362475; x=1699967275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VRoxoxM3bk/ddMYA7RkVxhIt7sN32CxDfhJasXbdTQ=;
        b=V5w6NB+76s+F81bquFAhSF5d7JKd2eI9LGDzec+gHCuyc9wBucnncNb/9EePcMxKxz
         U3/5Ox/n77/envIA9DR6Mooe/qbtKkpc4pgILHJj9pMsZ1+SqUp1VrlT4STiHAPEXEQx
         8LIwOJx2r0vGXIGDEpJ61humzwJdy+FwcXUoQcXQHfssLQm9H+UsfFcHrwpSAIhaih+8
         qRrY/vPviWKUErBBcHIbzodruOfE1zaaH/MiybkCb5k2NYecq66e94L5sTmyMKQMT9XG
         PRaqYGX4oZRtR9nHpSgF9WcbMx4YsoxdsgpXu9DwyPxW1RPdtMA0kcOxnufvW4qeEcLR
         dw+g==
X-Gm-Message-State: AOJu0Yzy8WK42KlICmu/jfVYYz+m/llCJCFxWxjYjkuNzTok8p0dbdzv
        YBV0442h5ywM9fvm0KBLTDu0YAgiuJhwz0Usn9YX3A==
X-Google-Smtp-Source: AGHT+IEc/OoLKiW5UzIza8k0AJcg/cvGrUiQc/SGatsr9amhK5Gck/VoGoIGcZKiRYhIoVxvQmPBVV/w9nNgSokWHaw=
X-Received: by 2002:a05:6871:3227:b0:1ef:ace4:f360 with SMTP id
 mo39-20020a056871322700b001eface4f360mr2023903oac.17.1699362474620; Tue, 07
 Nov 2023 05:07:54 -0800 (PST)
MIME-Version: 1.0
References: <20231105163040.14904-1-pbonzini@redhat.com> <20231105163040.14904-33-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-33-pbonzini@redhat.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 7 Nov 2023 13:07:18 +0000
Message-ID: <CA+EHjTxMK2G3WSQsjPA5zn94+a91HsoaWXx8tz1TTGuq1tVZ5Q@mail.gmail.com>
Subject: Re: [PATCH 32/34] KVM: selftests: Add basic selftest for guest_memfd()
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 5, 2023 at 4:35=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> From: Chao Peng <chao.p.peng@linux.intel.com>
>
> Add a selftest to verify the basic functionality of guest_memfd():
>
> + file descriptor created with the guest_memfd() ioctl does not allow
>   read/write/mmap operations
> + file size and block size as returned from fstat are as expected
> + fallocate on the fd checks that offset/length on
>   fallocate(FALLOC_FL_PUNCH_HOLE) should be page aligned
> + invalid inputs (misaligned size, invalid flags) are rejected
> + file size and inode are unique (the innocuous-sounding
>   anon_inode_getfile() backs all files with a single inode...)
>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-Id: <20231027182217.3615211-35-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../testing/selftests/kvm/guest_memfd_test.c  | 206 ++++++++++++++++++
>  2 files changed, 207 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/guest_memfd_test.c
>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftes=
ts/kvm/Makefile
> index ecdea5e7afa8..fd3b30a4ca7b 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -134,6 +134,7 @@ TEST_GEN_PROGS_x86_64 +=3D access_tracking_perf_test
>  TEST_GEN_PROGS_x86_64 +=3D demand_paging_test
>  TEST_GEN_PROGS_x86_64 +=3D dirty_log_test
>  TEST_GEN_PROGS_x86_64 +=3D dirty_log_perf_test
> +TEST_GEN_PROGS_x86_64 +=3D guest_memfd_test
>  TEST_GEN_PROGS_x86_64 +=3D guest_print_test
>  TEST_GEN_PROGS_x86_64 +=3D hardware_disable_test
>  TEST_GEN_PROGS_x86_64 +=3D kvm_create_max_vcpus
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> new file mode 100644
> index 000000000000..ea0ae7e25330
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -0,0 +1,206 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright Intel Corporation, 2023
> + *
> + * Author: Chao Peng <chao.p.peng@linux.intel.com>
> + */
> +
> +#define _GNU_SOURCE
> +#include "test_util.h"
> +#include "kvm_util_base.h"
> +#include <linux/bitmap.h>
> +#include <linux/falloc.h>
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <fcntl.h>

The include ordering should be fixed. Otherwise,

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> +
> +static void test_file_read_write(int fd)
> +{
> +       char buf[64];
> +
> +       TEST_ASSERT(read(fd, buf, sizeof(buf)) < 0,
> +                   "read on a guest_mem fd should fail");
> +       TEST_ASSERT(write(fd, buf, sizeof(buf)) < 0,
> +                   "write on a guest_mem fd should fail");
> +       TEST_ASSERT(pread(fd, buf, sizeof(buf), 0) < 0,
> +                   "pread on a guest_mem fd should fail");
> +       TEST_ASSERT(pwrite(fd, buf, sizeof(buf), 0) < 0,
> +                   "pwrite on a guest_mem fd should fail");
> +}
> +
> +static void test_mmap(int fd, size_t page_size)
> +{
> +       char *mem;
> +
> +       mem =3D mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED,=
 fd, 0);
> +       TEST_ASSERT_EQ(mem, MAP_FAILED);
> +}
> +
> +static void test_file_size(int fd, size_t page_size, size_t total_size)
> +{
> +       struct stat sb;
> +       int ret;
> +
> +       ret =3D fstat(fd, &sb);
> +       TEST_ASSERT(!ret, "fstat should succeed");
> +       TEST_ASSERT_EQ(sb.st_size, total_size);
> +       TEST_ASSERT_EQ(sb.st_blksize, page_size);
> +}
> +
> +static void test_fallocate(int fd, size_t page_size, size_t total_size)
> +{
> +       int ret;
> +
> +       ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE, 0, total_size);
> +       TEST_ASSERT(!ret, "fallocate with aligned offset and size should =
succeed");
> +
> +       ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
> +                       page_size - 1, page_size);
> +       TEST_ASSERT(ret, "fallocate with unaligned offset should fail");
> +
> +       ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE, total_size, page_size)=
;
> +       TEST_ASSERT(ret, "fallocate beginning at total_size should fail")=
;
> +
> +       ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE, total_size + page_size=
, page_size);
> +       TEST_ASSERT(ret, "fallocate beginning after total_size should fai=
l");
> +
> +       ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
> +                       total_size, page_size);
> +       TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) at total_size should suc=
ceed");
> +
> +       ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
> +                       total_size + page_size, page_size);
> +       TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) after total_size should =
succeed");
> +
> +       ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
> +                       page_size, page_size - 1);
> +       TEST_ASSERT(ret, "fallocate with unaligned size should fail");
> +
> +       ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
> +                       page_size, page_size);
> +       TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) with aligned offset and =
size should succeed");
> +
> +       ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE, page_size, page_size);
> +       TEST_ASSERT(!ret, "fallocate to restore punched hole should succe=
ed");
> +}
> +
> +static void test_invalid_punch_hole(int fd, size_t page_size, size_t tot=
al_size)
> +{
> +       struct {
> +               off_t offset;
> +               off_t len;
> +       } testcases[] =3D {
> +               {0, 1},
> +               {0, page_size - 1},
> +               {0, page_size + 1},
> +
> +               {1, 1},
> +               {1, page_size - 1},
> +               {1, page_size},
> +               {1, page_size + 1},
> +
> +               {page_size, 1},
> +               {page_size, page_size - 1},
> +               {page_size, page_size + 1},
> +       };
> +       int ret, i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(testcases); i++) {
> +               ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUN=
CH_HOLE,
> +                               testcases[i].offset, testcases[i].len);
> +               TEST_ASSERT(ret =3D=3D -1 && errno =3D=3D EINVAL,
> +                           "PUNCH_HOLE with !PAGE_SIZE offset (%lx) and/=
or length (%lx) should fail",
> +                           testcases[i].offset, testcases[i].len);
> +       }
> +}
> +
> +static void test_create_guest_memfd_invalid(struct kvm_vm *vm)
> +{
> +       size_t page_size =3D getpagesize();
> +       uint64_t flag;
> +       size_t size;
> +       int fd;
> +
> +       for (size =3D 1; size < page_size; size++) {
> +               fd =3D __vm_create_guest_memfd(vm, size, 0);
> +               TEST_ASSERT(fd =3D=3D -1 && errno =3D=3D EINVAL,
> +                           "guest_memfd() with non-page-aligned page siz=
e '0x%lx' should fail with EINVAL",
> +                           size);
> +       }
> +
> +       for (flag =3D 1; flag; flag <<=3D 1) {
> +               uint64_t bit;
> +
> +               fd =3D __vm_create_guest_memfd(vm, page_size, flag);
> +               TEST_ASSERT(fd =3D=3D -1 && errno =3D=3D EINVAL,
> +                           "guest_memfd() with flag '0x%lx' should fail =
with EINVAL",
> +                           flag);
> +
> +               for_each_set_bit(bit, &valid_flags, 64) {
> +                       fd =3D __vm_create_guest_memfd(vm, page_size, fla=
g | BIT_ULL(bit));
> +                       TEST_ASSERT(fd =3D=3D -1 && errno =3D=3D EINVAL,
> +                                   "guest_memfd() with flags '0x%llx' sh=
ould fail with EINVAL",
> +                                   flag | BIT_ULL(bit));
> +               }
> +       }
> +}
> +
> +static void test_create_guest_memfd_multiple(struct kvm_vm *vm)
> +{
> +       int fd1, fd2, ret;
> +       struct stat st1, st2;
> +
> +       fd1 =3D __vm_create_guest_memfd(vm, 4096, 0);
> +       TEST_ASSERT(fd1 !=3D -1, "memfd creation should succeed");
> +
> +       ret =3D fstat(fd1, &st1);
> +       TEST_ASSERT(ret !=3D -1, "memfd fstat should succeed");
> +       TEST_ASSERT(st1.st_size =3D=3D 4096, "memfd st_size should match =
requested size");
> +
> +       fd2 =3D __vm_create_guest_memfd(vm, 8192, 0);
> +       TEST_ASSERT(fd2 !=3D -1, "memfd creation should succeed");
> +
> +       ret =3D fstat(fd2, &st2);
> +       TEST_ASSERT(ret !=3D -1, "memfd fstat should succeed");
> +       TEST_ASSERT(st2.st_size =3D=3D 8192, "second memfd st_size should=
 match requested size");
> +
> +       ret =3D fstat(fd1, &st1);
> +       TEST_ASSERT(ret !=3D -1, "memfd fstat should succeed");
> +       TEST_ASSERT(st1.st_size =3D=3D 4096, "first memfd st_size should =
still match requested size");
> +       TEST_ASSERT(st1.st_ino !=3D st2.st_ino, "different memfd should h=
ave different inode numbers");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       size_t page_size;
> +       size_t total_size;
> +       int fd;
> +       struct kvm_vm *vm;
> +
> +       TEST_REQUIRE(kvm_has_cap(KVM_CAP_GUEST_MEMFD));
> +
> +       page_size =3D getpagesize();
> +       total_size =3D page_size * 4;
> +
> +       vm =3D vm_create_barebones();
> +
> +       test_create_guest_memfd_invalid(vm);
> +       test_create_guest_memfd_multiple(vm);
> +
> +       fd =3D vm_create_guest_memfd(vm, total_size, 0);
> +
> +       test_file_read_write(fd);
> +       test_mmap(fd, page_size);
> +       test_file_size(fd, page_size, total_size);
> +       test_fallocate(fd, page_size, total_size);
> +       test_invalid_punch_hole(fd, page_size, total_size);
> +
> +       close(fd);
> +}
> --
> 2.39.1
>
>
