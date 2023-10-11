Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2A27C47C0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344859AbjJKCYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344739AbjJKCYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:24:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BE992;
        Tue, 10 Oct 2023 19:24:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33904C433CC;
        Wed, 11 Oct 2023 02:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696991051;
        bh=RHFN1FO9/ftnJhtd5wsYZBpO5z3hsvR+2HgNHN/aptw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D5tPoW1AAFWi8mmnq3Qm/p73nSW6zxWxZQgnhx9woStByx0mTImSgwgCCUm4euyam
         FQX0K8rWsGZiXgCeYQ5DiSZT2kQmH9OrenZQt/Ya3K7qXbbdNwJidbqQobQZtBCqaO
         1xkR2NaAomyHqFc4Z0WlKdYybOuBFB8PTmTZZc6ki5ZvxBRhRO9v2v28mdZp32VQsv
         MkbhnIGaf7NfDDKzI9BXwA0HCehj1tu+DJjUZKol8ARQR1kGhaHR/XLkrSbjStHNPm
         5RqFUtWI9Ag75jWvJvZz+Qe2TrRfwgpLIMRadbG9CLnt1Z/t/4MAF4nEK1HPUh7+CN
         qjfZVm6XelN7w==
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-32d834ec222so377327f8f.0;
        Tue, 10 Oct 2023 19:24:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YyM76eJsUg8cQgSfzLYHwCT2kvL3A6ZjWrINPx67hfQwPTolqD4
        8rILykFexUZS7RAwc4zVDm9mVqVMaFOm8QWvjQI=
X-Google-Smtp-Source: AGHT+IE7xntPJSkBNkeGpTc53bJWGKzf4kw+kCkaQkuXM8kgw2ahLlmtMqnS4LxDn8NEGp4CP9kmgt/C6oNK+XzDp8g=
X-Received: by 2002:a5d:60d1:0:b0:321:7052:6406 with SMTP id
 x17-20020a5d60d1000000b0032170526406mr16510458wrt.12.1696991049407; Tue, 10
 Oct 2023 19:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231009124210.1064021-1-masahiroy@kernel.org> <20231009124210.1064021-4-masahiroy@kernel.org>
In-Reply-To: <20231009124210.1064021-4-masahiroy@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 11 Oct 2023 10:23:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTDpGgzsiRk=q6FCdX_g5maY-sT9h0jiW=p6HLziq97yA@mail.gmail.com>
Message-ID: <CAJF2gTTDpGgzsiRk=q6FCdX_g5maY-sT9h0jiW=p6HLziq97yA@mail.gmail.com>
Subject: Re: [PATCH 4/5] kbuild: unify vdso_install rules
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        x86@kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 8:42=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> Currently, there is no standard implementation for vdso_install,
> leading to various issues:
>
>  1. Code duplication
>
>     Many architectures duplicate similar code just for copying files
>     to the install destination.
>
>     Some architectures (arm, sparc, x86) create build-id symlinks,
>     introducing more code duplication.
>
>  2. Accidental updates of in-tree build artifacts
>
>     The vdso_install rule depends on the vdso files to install.
>     It may update in-tree build artifacts. This can be problematic,
>     as explained in commit 19514fc665ff ("arm, kbuild: make
>     "make install" not depend on vmlinux").
>
>  3. Broken code in some architectures
>
>     Makefile code is often copied from one architecture to another
>     without proper adaptation or testing.
>
>     The previous commits removed broken code from csky, UML, and parisc.
>
>     Another issue is that 'make vdso_install' for ARCH=3Ds390 installs
>     vdso64, but not vdso32.
>
> To address these problems, this commit introduces the generic vdso_instal=
l.
>
> Architectures that support vdso_install need to define vdso-install-y
> in arch/*/Makefile.
>
> vdso-install-y lists the files to install. For example, arch/x86/Makefile
> looks like this:
>
>   vdso-install-$(CONFIG_X86_64)           +=3D arch/x86/entry/vdso/vdso64=
.so.dbg
>   vdso-install-$(CONFIG_X86_X32_ABI)      +=3D arch/x86/entry/vdso/vdsox3=
2.so.dbg
>   vdso-install-$(CONFIG_X86_32)           +=3D arch/x86/entry/vdso/vdso32=
.so.dbg
>   vdso-install-$(CONFIG_IA32_EMULATION)   +=3D arch/x86/entry/vdso/vdso32=
.so.dbg
>
> These files will be installed to $(MODLIB)/vdso/ with the .dbg suffix,
> if exists, stripped away.
>
> vdso-install-y can optionally take the second field after the colon
> separator. This is needed because some architectures install vdso
> files as a different base name.
>
> The following is a snippet from arch/arm64/Makefile.
>
>   vdso-install-$(CONFIG_COMPAT_VDSO)      +=3D arch/arm64/kernel/vdso32/v=
dso.so.dbg:vdso32.so
>
> This will rename vdso.so.dbg to vdso32.so during installation. If such
> architectures change their implementation so that the file names match,
> this workaround will go away.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  Makefile                               |  9 ++++++
>  arch/arm/Makefile                      |  7 +---
>  arch/arm/vdso/Makefile                 | 25 --------------
>  arch/arm64/Makefile                    |  9 ++----
>  arch/arm64/kernel/vdso/Makefile        | 10 ------
>  arch/arm64/kernel/vdso32/Makefile      | 10 ------
>  arch/loongarch/Makefile                |  4 +--
>  arch/loongarch/vdso/Makefile           | 10 ------
>  arch/riscv/Makefile                    |  9 ++----
>  arch/riscv/kernel/compat_vdso/Makefile | 10 ------
>  arch/riscv/kernel/vdso/Makefile        | 10 ------
>  arch/s390/Makefile                     |  6 ++--
>  arch/s390/kernel/vdso32/Makefile       | 10 ------
>  arch/s390/kernel/vdso64/Makefile       | 10 ------
>  arch/sparc/Makefile                    |  5 ++-
>  arch/sparc/vdso/Makefile               | 27 ----------------
>  arch/x86/Makefile                      |  7 ++--
>  arch/x86/entry/vdso/Makefile           | 27 ----------------
>  scripts/Makefile.vdsoinst              | 45 ++++++++++++++++++++++++++
>  19 files changed, 71 insertions(+), 179 deletions(-)
>  create mode 100644 scripts/Makefile.vdsoinst
>
> diff --git a/Makefile b/Makefile
> index 373649c7374e..2170d56630e8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1317,6 +1317,14 @@ scripts_unifdef: scripts_basic
>  quiet_cmd_install =3D INSTALL $(INSTALL_PATH)
>        cmd_install =3D unset sub_make_done; $(srctree)/scripts/install.sh
>
> +# ----------------------------------------------------------------------=
-----
> +# vDSO install
> +
> +PHONY +=3D vdso_install
> +vdso_install: export INSTALL_FILES =3D $(vdso-install-y)
> +vdso_install:
> +       $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vdsoinst
> +
>  # ----------------------------------------------------------------------=
-----
>  # Tools
>
> @@ -1560,6 +1568,7 @@ help:
>         @echo  '* vmlinux         - Build the bare kernel'
>         @echo  '* modules         - Build all modules'
>         @echo  '  modules_install - Install all modules to INSTALL_MOD_PA=
TH (default: /)'
> +       @echo  '  vdso_install    - Install unstripped vdso to INSTALL_MO=
D_PATH (default: /)'
>         @echo  '  dir/            - Build all files in dir and below'
>         @echo  '  dir/file.[ois]  - Build specified target only'
>         @echo  '  dir/file.ll     - Build the LLVM assembly file'
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 547e5856eaa0..5ba42f69f8ce 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -304,11 +304,7 @@ $(INSTALL_TARGETS): KBUILD_IMAGE =3D $(boot)/$(patsu=
bst %install,%Image,$@)
>  $(INSTALL_TARGETS):
>         $(call cmd,install)
>
> -PHONY +=3D vdso_install
> -vdso_install:
> -ifeq ($(CONFIG_VDSO),y)
> -       $(Q)$(MAKE) $(build)=3Darch/arm/vdso $@
> -endif
> +vdso-install-$(CONFIG_VDSO) +=3D arch/arm/vdso/vdso.so.dbg
>
>  # My testing targets (bypasses dependencies)
>  bp:;   $(Q)$(MAKE) $(build)=3D$(boot) $(boot)/bootpImage
> @@ -331,7 +327,6 @@ define archhelp
>    echo  '                  Install using (your) ~/bin/$(INSTALLKERNEL) o=
r'
>    echo  '                  (distribution) /sbin/$(INSTALLKERNEL) or'
>    echo  '                  install to $$(INSTALL_PATH) and run lilo'
> -  echo  '  vdso_install  - Install unstripped vdso.so to $$(INSTALL_MOD_=
PATH)/vdso'
>    echo
>    echo  '  multi_v7_lpae_defconfig     - multi_v7_defconfig with CONFIG_=
ARM_LPAE enabled'
>  endef
> diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
> index 515ca33b854c..d761bd2e2f40 100644
> --- a/arch/arm/vdso/Makefile
> +++ b/arch/arm/vdso/Makefile
> @@ -63,28 +63,3 @@ quiet_cmd_vdsold_and_vdso_check =3D LD      $@
>
>  quiet_cmd_vdsomunge =3D MUNGE   $@
>        cmd_vdsomunge =3D $(objtree)/$(obj)/vdsomunge $< $@
> -
> -#
> -# Install the unstripped copy of vdso.so.dbg.  If our toolchain
> -# supports build-id, install .build-id links as well.
> -#
> -# Cribbed from arch/x86/vdso/Makefile.
> -#
> -quiet_cmd_vdso_install =3D INSTALL $<
> -define cmd_vdso_install
> -       cp $< "$(MODLIB)/vdso/vdso.so"; \
> -       if readelf -n $< | grep -q 'Build ID'; then \
> -         buildid=3D`readelf -n $< |grep 'Build ID' |sed -e 's/^.*Build I=
D: \(.*\)$$/\1/'`; \
> -         first=3D`echo $$buildid | cut -b-2`; \
> -         last=3D`echo $$buildid | cut -b3-`; \
> -         mkdir -p "$(MODLIB)/vdso/.build-id/$$first"; \
> -         ln -sf "../../vdso.so" "$(MODLIB)/vdso/.build-id/$$first/$$last=
.debug"; \
> -       fi
> -endef
> -
> -$(MODLIB)/vdso: FORCE
> -       @mkdir -p $(MODLIB)/vdso
> -
> -PHONY +=3D vdso_install
> -vdso_install: $(obj)/vdso.so.dbg $(MODLIB)/vdso
> -       $(call cmd,vdso_install)
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 2d49aea0ff67..4bd85cc0d32b 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -169,12 +169,6 @@ install: KBUILD_IMAGE :=3D $(boot)/Image
>  install zinstall:
>         $(call cmd,install)
>
> -PHONY +=3D vdso_install
> -vdso_install:
> -       $(Q)$(MAKE) $(build)=3Darch/arm64/kernel/vdso $@
> -       $(if $(CONFIG_COMPAT_VDSO), \
> -               $(Q)$(MAKE) $(build)=3Darch/arm64/kernel/vdso32 $@)
> -
>  archprepare:
>         $(Q)$(MAKE) $(build)=3Darch/arm64/tools kapi
>  ifeq ($(CONFIG_ARM64_ERRATUM_843419),y)
> @@ -205,6 +199,9 @@ ifdef CONFIG_COMPAT_VDSO
>  endif
>  endif
>
> +vdso-install-y                         +=3D arch/arm64/kernel/vdso/vdso.=
so.dbg
> +vdso-install-$(CONFIG_COMPAT_VDSO)     +=3D arch/arm64/kernel/vdso32/vds=
o.so.dbg:vdso32.so
> +
>  include $(srctree)/scripts/Makefile.defconf
>
>  PHONY +=3D virtconfig
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Mak=
efile
> index fe7a53c6781f..8818287f1095 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -78,13 +78,3 @@ include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg F=
ORCE
>  # Actual build commands
>  quiet_cmd_vdsold_and_vdso_check =3D LD      $@
>        cmd_vdsold_and_vdso_check =3D $(cmd_ld); $(cmd_vdso_check)
> -
> -# Install commands for the unstripped file
> -quiet_cmd_vdso_install =3D INSTALL $@
> -      cmd_vdso_install =3D cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
> -
> -vdso.so: $(obj)/vdso.so.dbg
> -       @mkdir -p $(MODLIB)/vdso
> -       $(call cmd,vdso_install)
> -
> -vdso_install: vdso.so
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32=
/Makefile
> index 2f73e5bca213..1f911a76c5af 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -172,13 +172,3 @@ gen-vdsosym :=3D $(srctree)/$(src)/../vdso/gen_vdso_=
offsets.sh
>  quiet_cmd_vdsosym =3D VDSOSYM $@
>  # The AArch64 nm should be able to read an AArch32 binary
>        cmd_vdsosym =3D $(NM) $< | $(gen-vdsosym) | LC_ALL=3DC sort > $@
> -
> -# Install commands for the unstripped file
> -quiet_cmd_vdso_install =3D INSTALL32 $@
> -      cmd_vdso_install =3D cp $(obj)/$@.dbg $(MODLIB)/vdso/vdso32.so
> -
> -vdso.so: $(obj)/vdso.so.dbg
> -       @mkdir -p $(MODLIB)/vdso
> -       $(call cmd,vdso_install)
> -
> -vdso_install: vdso.so
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index fb0fada43197..b86f2ff31659 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -136,9 +136,7 @@ vdso_prepare: prepare0
>         $(Q)$(MAKE) $(build)=3Darch/loongarch/vdso include/generated/vdso=
-offsets.h
>  endif
>
> -PHONY +=3D vdso_install
> -vdso_install:
> -       $(Q)$(MAKE) $(build)=3Darch/loongarch/vdso $@
> +vdso-install-y +=3D arch/loongarch/vdso/vdso.so.dbg
>
>  all:   $(notdir $(KBUILD_IMAGE))
>
> diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
> index 5c97d1463328..c74c9921304f 100644
> --- a/arch/loongarch/vdso/Makefile
> +++ b/arch/loongarch/vdso/Makefile
> @@ -83,13 +83,3 @@ $(obj)/vdso.so: $(obj)/vdso.so.dbg FORCE
>  obj-y +=3D vdso.o
>
>  $(obj)/vdso.o : $(obj)/vdso.so
> -
> -# install commands for the unstripped file
> -quiet_cmd_vdso_install =3D INSTALL $@
> -      cmd_vdso_install =3D cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
> -
> -vdso.so: $(obj)/vdso.so.dbg
> -       @mkdir -p $(MODLIB)/vdso
> -       $(call cmd,vdso_install)
> -
> -vdso_install: vdso.so
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 1329e060c548..18a47b4d6795 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -131,12 +131,6 @@ endif
>  libs-y +=3D arch/riscv/lib/
>  libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmware/efi/libstub/lib=
.a
>
> -PHONY +=3D vdso_install
> -vdso_install:
> -       $(Q)$(MAKE) $(build)=3Darch/riscv/kernel/vdso $@
> -       $(if $(CONFIG_COMPAT),$(Q)$(MAKE) \
> -               $(build)=3Darch/riscv/kernel/compat_vdso compat_$@)
> -
>  ifeq ($(KBUILD_EXTMOD),)
>  ifeq ($(CONFIG_MMU),y)
>  prepare: vdso_prepare
> @@ -148,6 +142,9 @@ vdso_prepare: prepare0
>  endif
>  endif
>
> +vdso-install-y                 +=3D arch/riscv/kernel/vdso/vdso.so.dbg
> +vdso-install-$(CONFIG_COMPAT)  +=3D arch/riscv/kernel/compat_vdso/compat=
_vdso.so.dbg:../compat_vdso/compat_vdso.so
Why do we need ":../compat_vdso/compat_vdso.so" here?

> +
>  ifneq ($(CONFIG_XIP_KERNEL),y)
>  ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
>  KBUILD_IMAGE :=3D $(boot)/loader.bin
> diff --git a/arch/riscv/kernel/compat_vdso/Makefile b/arch/riscv/kernel/c=
ompat_vdso/Makefile
> index b86e5e2c3aea..62fa393b2eb2 100644
> --- a/arch/riscv/kernel/compat_vdso/Makefile
> +++ b/arch/riscv/kernel/compat_vdso/Makefile
> @@ -76,13 +76,3 @@ quiet_cmd_compat_vdsold =3D VDSOLD  $@
>  # actual build commands
>  quiet_cmd_compat_vdsoas =3D VDSOAS $@
>        cmd_compat_vdsoas =3D $(COMPAT_CC) $(a_flags) $(COMPAT_CC_FLAGS) -=
c -o $@ $<
> -
> -# install commands for the unstripped file
> -quiet_cmd_compat_vdso_install =3D INSTALL $@
> -      cmd_compat_vdso_install =3D cp $(obj)/$@.dbg $(MODLIB)/compat_vdso=
/$@
> -
> -compat_vdso.so: $(obj)/compat_vdso.so.dbg
> -       @mkdir -p $(MODLIB)/compat_vdso
> -       $(call cmd,compat_vdso_install)
> -
> -compat_vdso_install: compat_vdso.so
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Mak=
efile
> index 6b1dba11bf6d..e8aa7c380007 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -73,13 +73,3 @@ quiet_cmd_vdsold =3D VDSOLD  $@
>        cmd_vdsold =3D $(LD) $(ld_flags) -T $(filter-out FORCE,$^) -o $@.t=
mp && \
>                     $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-syms)) $=
@.tmp $@ && \
>                     rm $@.tmp
> -
> -# install commands for the unstripped file
> -quiet_cmd_vdso_install =3D INSTALL $@
> -      cmd_vdso_install =3D cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
> -
> -vdso.so: $(obj)/vdso.so.dbg
> -       @mkdir -p $(MODLIB)/vdso
> -       $(call cmd,vdso_install)
> -
> -vdso_install: vdso.so
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index a53a36ee0731..73873e451686 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -138,9 +138,6 @@ bzImage: vmlinux
>  zfcpdump:
>         $(Q)$(MAKE) $(build)=3D$(boot) $(boot)/$@
>
> -vdso_install:
> -       $(Q)$(MAKE) $(build)=3Darch/$(ARCH)/kernel/vdso64 $@
> -
>  archheaders:
>         $(Q)$(MAKE) $(build)=3D$(syscalls) uapi
>
> @@ -160,6 +157,9 @@ vdso_prepare: prepare0
>         $(if $(CONFIG_COMPAT),$(Q)$(MAKE) \
>                 $(build)=3Darch/s390/kernel/vdso32 include/generated/vdso=
32-offsets.h)
>
> +vdso-install-y                 +=3D arch/s390/kernel/vdso64/vdso64.so.db=
g
> +vdso-install-$(CONFIG_COMPAT)  +=3D arch/s390/kernel/vdso32/vdso32.so.db=
g
> +
>  ifdef CONFIG_EXPOLINE_EXTERN
>  modules_prepare: expoline_prepare
>  expoline_prepare: scripts
> diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/M=
akefile
> index 23e868b79a6c..caec7db6f966 100644
> --- a/arch/s390/kernel/vdso32/Makefile
> +++ b/arch/s390/kernel/vdso32/Makefile
> @@ -61,16 +61,6 @@ quiet_cmd_vdso32as =3D VDSO32A $@
>  quiet_cmd_vdso32cc =3D VDSO32C $@
>        cmd_vdso32cc =3D $(CC) $(c_flags) -c -o $@ $<
>
> -# install commands for the unstripped file
> -quiet_cmd_vdso_install =3D INSTALL $@
> -      cmd_vdso_install =3D cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
> -
> -vdso32.so: $(obj)/vdso32.so.dbg
> -       @mkdir -p $(MODLIB)/vdso
> -       $(call cmd,vdso_install)
> -
> -vdso_install: vdso32.so
> -
>  # Generate VDSO offsets using helper script
>  gen-vdsosym :=3D $(srctree)/$(src)/gen_vdso_offsets.sh
>  quiet_cmd_vdsosym =3D VDSOSYM $@
> diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/M=
akefile
> index fc1c6ff8178f..e3c9085f8fa7 100644
> --- a/arch/s390/kernel/vdso64/Makefile
> +++ b/arch/s390/kernel/vdso64/Makefile
> @@ -70,16 +70,6 @@ quiet_cmd_vdso64as =3D VDSO64A $@
>  quiet_cmd_vdso64cc =3D VDSO64C $@
>        cmd_vdso64cc =3D $(CC) $(c_flags) -c -o $@ $<
>
> -# install commands for the unstripped file
> -quiet_cmd_vdso_install =3D INSTALL $@
> -      cmd_vdso_install =3D cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
> -
> -vdso64.so: $(obj)/vdso64.so.dbg
> -       @mkdir -p $(MODLIB)/vdso
> -       $(call cmd,vdso_install)
> -
> -vdso_install: vdso64.so
> -
>  # Generate VDSO offsets using helper script
>  gen-vdsosym :=3D $(srctree)/$(src)/gen_vdso_offsets.sh
>  quiet_cmd_vdsosym =3D VDSOSYM $@
> diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
> index 7417345c6639..5f6035936131 100644
> --- a/arch/sparc/Makefile
> +++ b/arch/sparc/Makefile
> @@ -76,9 +76,8 @@ install:
>  archheaders:
>         $(Q)$(MAKE) $(build)=3Darch/sparc/kernel/syscalls all
>
> -PHONY +=3D vdso_install
> -vdso_install:
> -       $(Q)$(MAKE) $(build)=3Darch/sparc/vdso $@
> +vdso-install-$(CONFIG_SPARC64) +=3D arch/sparc/vdso/vdso64.so.dbg
> +vdso-install-$(CONFIG_COMPAT)  +=3D arch/sparc/vdso/vdso32.so.dbg
>
>  # This is the image used for packaging
>  KBUILD_IMAGE :=3D $(boot)/zImage
> diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
> index 77d7b9032158..d08c3a0443f3 100644
> --- a/arch/sparc/vdso/Makefile
> +++ b/arch/sparc/vdso/Makefile
> @@ -116,30 +116,3 @@ quiet_cmd_vdso =3D VDSO    $@
>
>  VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id=3Dsha1 -Bsymboli=
c
>  GCOV_PROFILE :=3D n
> -
> -#
> -# Install the unstripped copies of vdso*.so.  If our toolchain supports
> -# build-id, install .build-id links as well.
> -#
> -quiet_cmd_vdso_install =3D INSTALL $(@:install_%=3D%)
> -define cmd_vdso_install
> -       cp $< "$(MODLIB)/vdso/$(@:install_%=3D%)"; \
> -       if readelf -n $< |grep -q 'Build ID'; then \
> -         buildid=3D`readelf -n $< |grep 'Build ID' |sed -e 's/^.*Build I=
D: \(.*\)$$/\1/'`; \
> -         first=3D`echo $$buildid | cut -b-2`; \
> -         last=3D`echo $$buildid | cut -b3-`; \
> -         mkdir -p "$(MODLIB)/vdso/.build-id/$$first"; \
> -         ln -sf "../../$(@:install_%=3D%)" "$(MODLIB)/vdso/.build-id/$$f=
irst/$$last.debug"; \
> -       fi
> -endef
> -
> -vdso_img_insttargets :=3D $(vdso_img_sodbg:%.dbg=3Dinstall_%)
> -
> -$(MODLIB)/vdso: FORCE
> -       @mkdir -p $(MODLIB)/vdso
> -
> -$(vdso_img_insttargets): install_%: $(obj)/%.dbg $(MODLIB)/vdso FORCE
> -       $(call cmd,vdso_install)
> -
> -PHONY +=3D vdso_install $(vdso_img_insttargets)
> -vdso_install: $(vdso_img_insttargets) FORCE
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 5bfe5caaa444..3ff53a2d4ff0 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -291,9 +291,10 @@ PHONY +=3D install
>  install:
>         $(call cmd,install)
>
> -PHONY +=3D vdso_install
> -vdso_install:
> -       $(Q)$(MAKE) $(build)=3Darch/x86/entry/vdso $@
> +vdso-install-$(CONFIG_X86_64)          +=3D arch/x86/entry/vdso/vdso64.s=
o.dbg
> +vdso-install-$(CONFIG_X86_X32_ABI)     +=3D arch/x86/entry/vdso/vdsox32.=
so.dbg
> +vdso-install-$(CONFIG_X86_32)          +=3D arch/x86/entry/vdso/vdso32.s=
o.dbg
> +vdso-install-$(CONFIG_IA32_EMULATION)  +=3D arch/x86/entry/vdso/vdso32.s=
o.dbg
>
>  archprepare: checkbin
>  checkbin:
> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> index 6a1821bd7d5e..c197efd82922 100644
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -190,31 +190,4 @@ GCOV_PROFILE :=3D n
>  quiet_cmd_vdso_and_check =3D VDSO    $@
>        cmd_vdso_and_check =3D $(cmd_vdso); $(cmd_vdso_check)
>
> -#
> -# Install the unstripped copies of vdso*.so.  If our toolchain supports
> -# build-id, install .build-id links as well.
> -#
> -quiet_cmd_vdso_install =3D INSTALL $(@:install_%=3D%)
> -define cmd_vdso_install
> -       cp $< "$(MODLIB)/vdso/$(@:install_%=3D%)"; \
> -       if readelf -n $< |grep -q 'Build ID'; then \
> -         buildid=3D`readelf -n $< |grep 'Build ID' |sed -e 's/^.*Build I=
D: \(.*\)$$/\1/'`; \
> -         first=3D`echo $$buildid | cut -b-2`; \
> -         last=3D`echo $$buildid | cut -b3-`; \
> -         mkdir -p "$(MODLIB)/vdso/.build-id/$$first"; \
> -         ln -sf "../../$(@:install_%=3D%)" "$(MODLIB)/vdso/.build-id/$$f=
irst/$$last.debug"; \
> -       fi
> -endef
> -
> -vdso_img_insttargets :=3D $(vdso_img_sodbg:%.dbg=3Dinstall_%)
> -
> -$(MODLIB)/vdso: FORCE
> -       @mkdir -p $(MODLIB)/vdso
> -
> -$(vdso_img_insttargets): install_%: $(obj)/%.dbg $(MODLIB)/vdso
> -       $(call cmd,vdso_install)
> -
> -PHONY +=3D vdso_install $(vdso_img_insttargets)
> -vdso_install: $(vdso_img_insttargets)
> -
>  clean-files :=3D vdso32.so vdso32.so.dbg vdso64* vdso-image-*.c vdsox32.=
so*
> diff --git a/scripts/Makefile.vdsoinst b/scripts/Makefile.vdsoinst
> new file mode 100644
> index 000000000000..1022d9fdd976
> --- /dev/null
> +++ b/scripts/Makefile.vdsoinst
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +# Install unstripped copies of vDSO
> +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +PHONY :=3D __default
> +__default:
> +       @:
> +
> +include $(srctree)/scripts/Kbuild.include
> +
> +install-dir :=3D $(MODLIB)/vdso
> +
> +define gen_install_rules
> +
> +src :=3D $$(firstword $$(subst :,$(space),$(1)))
> +dest :=3D $(install-dir)/$$(or $$(word 2,$$(subst :,$(space),$(1))),$$(p=
atsubst %.dbg,%,$$(notdir $(1))))
> +
> +__default: $$(dest)
> +$$(dest): $$(src) FORCE
> +       $$(call cmd,install)
> +
> +# Some architectures create .build-id symlinks
> +ifneq ($(filter arm sparc x86, $(SRCARCH)),)
> +link :=3D $(install-dir)/.build-id/$$(shell $(READELF) -n $$(src) | sed =
-n 's@^.*Build ID: \(..\)\(.*\)@\1/\2@p')
> +
> +__default: $$(link)
> +$$(link): $$(dest) FORCE
> +       $$(call cmd,symlink)
> +endif
> +
> +endef
> +
> +$(foreach x, $(sort $(INSTALL_FILES)), $(eval $(call gen_install_rules,$=
(x))))
> +
> +quiet_cmd_install =3D INSTALL $@
> +      cmd_install =3D mkdir -p $(dir $@); cp $< $@
> +
> +quiet_cmd_symlink =3D SYMLINK $@
> +      cmd_symlink =3D mkdir -p $(dir $@); ln -sf --relative $< $@
> +
> +PHONY +=3D FORCE
> +FORCE:
> +
> +.PHONY: $(PHONY)
> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren
