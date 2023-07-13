Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FEF7523DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjGMNdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjGMNds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:33:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763341BF3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:33:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2BBF6153B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE22C433C8;
        Thu, 13 Jul 2023 13:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689255225;
        bh=5JtshTP1bXLjEstDrWEEMA0R1xCxbgWIzfLe0lAZ+so=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O9Nvi27nE13QFvWlrcoIQtMe469KDKMVbqYYNkKdYLv6zMyvY5Rdh38i6DNBUlDJR
         OW7UsXkeZwrhJuNELVYRp3Pn3ZKmNovx12MJe816RwL20jzV0KqdSPWzgztLL5gbuT
         DxTdRIJdzJFM6nomiCzh7nqbDvZPxWsZ3/i6Kptqlhe0E6wWYFvIn4UYn2oRnWz5WF
         ETxipSVEYs3mlTqYJUBF4G1o9obqWRN0iq0t8sp7s5Z7Cwru5wgZ/uhtKV0JMNQgCn
         94OyddAIAlPtujNgpxbkiXCVBogo4kbjIiRCH6KWe+wWRh5njF8ouD9OJzPktzKKsT
         HhoJmuf9VIDrQ==
Date:   Thu, 13 Jul 2023 15:33:38 +0200
From:   Ard Biesheuvel <ardb@kernel.org>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        bluca@debian.org, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Message-ID: <ZK/9MlTh435FP5Ji@gambale.home>
References: <20230711154449.1378385-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711154449.1378385-1-eesposit@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Emanuele,

Please cc the linux-efi@ mailing list and myself on EFI related patches.

First of all, I think the tone of the discussion is way out of hand on
both sides of the debate. Please keep it civil and courteous.

On Tue, Jul 11, 2023 at 11:44:49AM -0400, Emanuele Giuseppe Esposito wrote:
> *Important*: this is just an RFC, as I am not expert in this area and
> I don't know what's the best way to achieve this.
> 
> v2:
> * add standard "sbat,1,SBAT Version,..." header string
> 
> The aim of this patch is to add a .sbat section to the linux binary
> (https://github.com/rhboot/shim/blob/main/SBAT.md).
> We mainly need SBAT in UKIs (Unified Kernel Images), as we might want
> to revoke authorizations to specific signed PEs that were initially
> considered as trusted. The reason might be for example a security issue
> related to a specific linux release.
> 
> A .sbat is simply a section containing a string with the component name
> and a version number. This version number is compared with the value in
> OVMF_VARS, and if it's less than the variable, the binary is not trusted,
> even if it is correctly signed.
> 

Most people will not known what OVMF_VARS is or a PE.

Also, 'version number' is a bit vague, better to stick with existing
terminology that makes this more self explanatory: the component that
authenticates the kernel image keeps a revocation counter, and refuses
to load authentic images whose revocation index is lower than the
revocation counter. This approach removes the need for revoking
individual image hashes or having to rotate the signing keys when a
vulnerability is discovered.

The argument that we need this in the upstream kernel seems to be
predicated on the assumption that there is one universal signing
authority and revocation domain, but this is not necessarily true. Even
if the distros appear to have decided that it is a reasonable choice to
deploy the MicroSoft signed shim and the associated components on other
systems than Windows-crippled x86 PCs, this is not universally true, and
UEFI secure boot can be (and is) deployed in sane ways as well.

Therefore, I don't think it makes sense for the upstream kernel source
to carry a revocation index. It is ultimately up to the owner of the
signing key to decide which value gets signed along with the image, and
this is fundamentally part of the configure/build/release workflow.  No
distro builds and signs the upstream sources unmodified, so each signed
release is a fork anyway, making a upstream revocation index almost
meaningless. Also, while backporting revocation index bumps to -stable
should not result in any issues, I don't think the associated
bookkeeping belongs in the hands of the stable tree maintainers. 

> 
> Right now an UKI is built with a .sbat section containing the
> systemd-stub sbat string (upstream + vendor), we would like to add
> also a per-component specific string (ie vmlinux has its own sbat,
> again upstream + vendor, each signed add-on its own and so on).
> In this way, if a specific kernel version has an issue, we can revoke
> it without compromising all other UKIs that are using a different
> kernel with the same stub/initrd/something else.
> 

Whoever builds *and signs* this kernel should be managing the revocation
metadata. Given that each vendor will have its own linux.<vendor>
revocation counter anyway, why is it necessary to have an upstream one
as well?

> Issues with this patch:
> * the string is added in a file but it is never deleted
> * if the code is not modified but make is issued again, objcopy will
>   be called again and will fail because .sbat exists already, making
>   compilation fail
> * minor display issue: objcopy command is printed in the make logs
> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
>  arch/x86/boot/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index 9e38ffaadb5d..6982a50ba0c0 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -83,6 +83,9 @@ cmd_image = $(obj)/tools/build $(obj)/setup.bin $(obj)/vmlinux.bin \
>  
>  $(obj)/bzImage: $(obj)/setup.bin $(obj)/vmlinux.bin $(obj)/tools/build FORCE
>  	$(call if_changed,image)
> +	@$(kecho) "sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md" > linux.sbat
> +	@$(kecho) "linux,1,The Linux Developers,linux,$(KERNELVERSION),https://linux.org" >> linux.sbat;
> +	$(OBJCOPY) --set-section-alignment '.sbat=512' --add-section .sbat=linux.sbat $@;
>  	@$(kecho) 'Kernel: $@ is ready' ' (#'$(or $(KBUILD_BUILD_VERSION),`cat .version`)')'
>  
>  OBJCOPYFLAGS_vmlinux.bin := -O binary -R .note -R .comment -S
> -- 
> 2.39.1
> 
