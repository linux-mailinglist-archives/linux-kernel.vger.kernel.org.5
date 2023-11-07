Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E2C7E3FCC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbjKGNKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbjKGNK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:10:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9076D2100;
        Tue,  7 Nov 2023 05:05:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2743CC433C9;
        Tue,  7 Nov 2023 13:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699362339;
        bh=RruP1QGaZvTuXJrll5bj84ebMUg3UJxqsTsrVsJCqms=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bgcmAr0ekyPjtlHlJRSPoSGWONG64/XmcaIrdKW4mI3D+o6ctW5e4A+4ERsddqsg8
         Acv+3kdbcNT3MoTiufI565Pu0r+e4QwHMlOmga69I0TEwjvBp/1/uRKu+byguAtB2j
         rNFwGxzIoEOChohuCTot/fFBVh+aEa1+mDYPhQZaKiCsCFT0ArI/r+KCFt81aznIkP
         MNy0APlt90qjAtX+9sGlQdqVYmJ6F2BRooRI9kP+9ROi9JzV9Z4vYXYSbRukg5LWY7
         KDmTsFn+ZxmsuU3qTVJdED7vNIqJ7q4cKx4KCXhniaEDd3j+kqIVFCr2v7xgo6IVEM
         jPHPBSMXOLEpQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1ead2e6fab7so3355299fac.0;
        Tue, 07 Nov 2023 05:05:39 -0800 (PST)
X-Gm-Message-State: AOJu0YzK7L/xFOY6MBophJf46lT3vehkJjZDuMvtoErK1HRodcWLm4b/
        lbkPVMNUSPTpoMN282ZPljsW7GmEVBAwrkXSO18=
X-Google-Smtp-Source: AGHT+IEMhw9WYqCbJTZndEZaZJUtNVpum44vv8O60uyxnlRHxP3PHUzubA1MYIHj/VkTdRa2z2aQxv757U3hRX3iZOI=
X-Received: by 2002:a05:6871:42c4:b0:1ea:4338:20b7 with SMTP id
 lt4-20020a05687142c400b001ea433820b7mr3600723oab.20.1699362338526; Tue, 07
 Nov 2023 05:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20231104194207.3370542-1-sjg@chromium.org> <20231104194207.3370542-4-sjg@chromium.org>
In-Reply-To: <20231104194207.3370542-4-sjg@chromium.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 7 Nov 2023 15:05:01 +0200
X-Gmail-Original-Message-ID: <CAK7LNAQCu9tWcjEtak3sBVo5mQYu1abu-v-GQ0b5h7PhzuHKww@mail.gmail.com>
Message-ID: <CAK7LNAQCu9tWcjEtak3sBVo5mQYu1abu-v-GQ0b5h7PhzuHKww@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: boot: Support Flat Image Tree
To:     Simon Glass <sjg@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 4, 2023 at 9:42=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>  PHONY +=3D $(BOOT_TARGETS)
>
> @@ -215,6 +215,7 @@ virtconfig:
>  define archhelp
>    echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Im=
age.gz)'
>    echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/=
Image)'
> +$(if $(CONFIG_EFI_ZBOOT),,echo  '  image.fit     - Flat Image Tree (arch=
/$(ARCH)/boot/image.fit)')



Why should this be hidden when CONFIG_EFI_ZBOOT=3Dy?




>    echo  '  install       - Install uncompressed kernel'
>    echo  '  zinstall      - Install compressed kernel'
>    echo  '                  Install using (your) ~/bin/installkernel or'
> diff --git a/arch/arm64/boot/.gitignore b/arch/arm64/boot/.gitignore
> index af5dc61f8b43..f84a7073dbcd 100644
> --- a/arch/arm64/boot/.gitignore
> +++ b/arch/arm64/boot/.gitignore
> @@ -2,3 +2,5 @@
>  Image
>  Image.gz
>  vmlinuz*
> +image.itk
> +image.fit
> diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
> index 1761f5972443..2681f54cd2c8 100644
> --- a/arch/arm64/boot/Makefile
> +++ b/arch/arm64/boot/Makefile
> @@ -16,7 +16,8 @@
>
>  OBJCOPYFLAGS_Image :=3D-O binary -R .note -R .note.gnu.build-id -R .comm=
ent -S
>
> -targets :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo Ima=
ge.zst
> +targets :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo \
> +       Image.zst image.fit
>
>  $(obj)/Image: vmlinux FORCE
>         $(call if_changed,objcopy)
> @@ -39,6 +40,10 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
>  $(obj)/Image.zst: $(obj)/Image FORCE
>         $(call if_changed,zstd)
>
> +# Provide the kernel for the FIT
> +$(obj)/image.itk: $(obj)/Image FORCE
> +       $(call if_changed,copy)
> +
>  EFI_ZBOOT_PAYLOAD      :=3D Image
>  EFI_ZBOOT_BFD_TARGET   :=3D elf64-littleaarch64
>  EFI_ZBOOT_MACH_TYPE    :=3D ARM64
> @@ -48,3 +53,5 @@ EFI_ZBOOT_OBJCOPY_FLAGS       =3D --add-symbol zboot_co=
de_size=3D0x$(shell \
>                                 $(NM) vmlinux|grep _kernel_codesize|cut -=
d' ' -f1)
>
>  include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
> +
> +clean-files :=3D image.itk
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 03e79e319293..1427dba4f0f9 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -494,7 +494,23 @@ quiet_cmd_uimage =3D UIMAGE  $@
>                         -C $(UIMAGE_COMPRESSION) $(UIMAGE_OPTS-y) \
>                         -T $(UIMAGE_TYPE) \
>                         -a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \
> -                       -n $(UIMAGE_NAME) -d $< $@
> +                       -n "$(UIMAGE_NAME)" -d $< $@


Please do not do this.
Just drop 2/3.




> +
> +# Flat Image Tree (FIT)
> +# This allows for packaging of a kernel and all devicetrees files, using
> +# compression.
> +# ----------------------------------------------------------------------=
-----
> +
> +MAKE_FIT :=3D $(srctree)/scripts/make_fit.py
> +
> +quiet_cmd_fit =3D FIT     $@
> +      cmd_fit =3D $(MAKE_FIT) -f $@ --arch $(UIMAGE_ARCH) --os linux \
> +                       --name "$(UIMAGE_NAME)" \
> +                       --compress $(UIMAGE_COMPRESSION) -k $< \
> +                       $(dir $<)/dts
> +
> +$(obj)/%.fit: $(obj)/%.itk $(MAKE_FIT) FORCE
> +       $(call if_changed,fit,gzip)


No. This is worse than v1.

Please do not create a silly copy.





As I said in v1, this if_changed does not catch the DTS updates.
So, there is no point in using it.

I recommend just use 'cmd'.


$(obj)/image.fit: $(obj)/Image FORCE
        $(call cmd,fit)





> +
> +    Returns:
> +        tuple:
> +            str: Model name
> +            bytes: Compatible stringlist
> +    """
> +    with fsw.add_node(f'fdt-{seq}'):
> +        # Get the compatible / model information
> +        with open(fname, 'rb') as inf:
> +            data =3D inf.read()
> +        fdt =3D libfdt.FdtRo(data)
> +        model =3D fdt.getprop(0, 'model').as_str()
> +        compat =3D fdt.getprop(0, 'compatible')
> +
> +        fsw.property_string('description', model)
> +        fsw.property_string('type', 'flat_dt')
> +        fsw.property_string('arch', 'arm64')


Why hard-code 'arm64' ?





--=20
Best Regards
Masahiro Yamada
