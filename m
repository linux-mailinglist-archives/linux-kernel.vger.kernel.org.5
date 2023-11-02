Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832427DEDD4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjKBIES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbjKBIER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45CA111
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 01:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698912208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WvS8MNTF0hgInyS69OR8wJBPNbNz7HePMphlox+7hLE=;
        b=HMh6mc1oUNhcz81BnkRCFEpRE+aNqlpgVmqGmWCajxUHei+9zwYZmlsVXAQa1HL6IelWpC
        m88JuZto6TvNZOm8f83wgXkFyp2e4Hp9tJWTJQXyAQ7cSI/3czfm49F5LPPriIFxtkg7CL
        avh3/wAmGKWWiOYy2IyRIl76vaESK8g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-ZXeI0wL_OGCPKuuv_BOOQg-1; Thu,
 02 Nov 2023 04:03:23 -0400
X-MC-Unique: ZXeI0wL_OGCPKuuv_BOOQg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5121F3810D23;
        Thu,  2 Nov 2023 08:03:23 +0000 (UTC)
Received: from localhost (unknown [10.72.113.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F192492BE0;
        Thu,  2 Nov 2023 08:03:21 +0000 (UTC)
Date:   Thu, 2 Nov 2023 16:03:18 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, eric_devolder@yahoo.com
Subject: Re: [PATCH 1/2] kexec: fix KEXEC_FILE dependencies
Message-ID: <ZUNXxp9AIkjQkP9s@MiWiFi-R3L-srv>
References: <20231023110308.1202042-1-arnd@kernel.org>
 <ZTe8NOgAjvKDA6z0@MiWiFi-R3L-srv>
 <b71034f4-5cdc-44e0-b72f-1a8ffae0593e@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b71034f4-5cdc-44e0-b72f-1a8ffae0593e@app.fastmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 10/24/23 at 03:17pm, Arnd Bergmann wrote:
> On Tue, Oct 24, 2023, at 14:44, Baoquan He wrote:
> > Just add people and mailing list to CC since I didn't find this mail in
> > my box, just drag it via 'b4 am'.
> >
> > On 10/23/23 at 01:01pm, Arnd Bergmann wrote:
> > ......
> 
> >> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> >> index 7aff28ded2f48..bfc636d64ff2b 100644
> >> --- a/kernel/Kconfig.kexec
> >> +++ b/kernel/Kconfig.kexec
> >> @@ -36,6 +36,7 @@ config KEXEC
> >>  config KEXEC_FILE
> >>  	bool "Enable kexec file based system call"
> >>  	depends on ARCH_SUPPORTS_KEXEC_FILE
> >> +	depends on CRYPTO_SHA256=y || !ARCH_SUPPORTS_KEXEC_PURGATORY
> >
> > I am not sure if the logic is correct. In theory, kexec_file code
> > utilizes purgatory to verify the checksum digested during kernel loading
> > when try to jump to the kernel. That means kexec_file depends on
> > purgatory, but not contrary?
> 
> The expression I wrote is a bit confusing, but I think this just
> keeps the existing behavior:
> 
> - on architectures that select ARCH_SUPPORTS_KEXEC_PURGATORY
>   (powerpc, riscv, s390 and x86), we also require CRYPTO_SHA256
>   to be built-in.
> - on architectures that do not have ARCH_SUPPORTS_KEXEC_PURGATORY
>   (arm64 and parisc), CRYPTO_SHA256 is not used and can be disabled
>   or =m.
> 
> Since ARCH_SUPPORTS_KEXEC_PURGATORY is a 'bool' symbol, it could
> be written as
> 
> depends on (ARCH_SUPPORTS_KEXEC_PURGATORY && CRYPTO_SHA256=y) \
>            || !ARCH_SUPPORTS_KEXEC_PURGATORY
> 
> if you find that clearer. I see that the second patch
> actually gets this wrong, it should actually do
> 
> select CRYPTO if ARCH_SUPPORTS_KEXEC_PURGATORY
> select CRYPTO_SHA256 if ARCH_SUPPORTS_KEXEC_PURGATORY
> 
> > With these changes, we can achieve the goal to avoid building issue,
> > whereas the code logic becomes confusing. E.g people could disable
> > CONFIG_KEXEC_FILE, but still get purgatory code built in which is
> > totally useless.
> >
> > Not sure if I think too much over this.
> 
> I see your point here, and I would suggest changing the
> CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY symbol to just indicate
> the availability of the purgatory code for the arch, rather
> than actually controlling the code itself. I already mentioned
> this for s390, but riscv would need the same thing on top.
> 
> I think the change below should address your concern.

Since no new comment, do you mind spinning v2 to wrap all these up?

Thanks
Baoquan

> 
>      Arnd
> 
> diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
> index e60fbd8660c4..3ac341d296db 100644
> --- a/arch/riscv/kernel/elf_kexec.c
> +++ b/arch/riscv/kernel/elf_kexec.c
> @@ -266,7 +266,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
>                 cmdline = modified_cmdline;
>         }
>  
> -#ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY
> +#ifdef CONFIG_KEXEC_FILE
>         /* Add purgatory to the image */
>         kbuf.top_down = true;
>         kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> @@ -280,7 +280,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
>                                              sizeof(kernel_start), 0);
>         if (ret)
>                 pr_err("Error update purgatory ret=%d\n", ret);
> -#endif /* CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY */
> +#endif /* CONFIG_KEXEC_FILE */
>  
>         /* Add the initrd to the image */
>         if (initrd != NULL) {
> diff --git a/arch/riscv/Kbuild b/arch/riscv/Kbuild
> index d25ad1c19f88..ab181d187c23 100644
> --- a/arch/riscv/Kbuild
> +++ b/arch/riscv/Kbuild
> @@ -5,7 +5,7 @@ obj-$(CONFIG_BUILTIN_DTB) += boot/dts/
>  obj-y += errata/
>  obj-$(CONFIG_KVM) += kvm/
>  
> -obj-$(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) += purgatory/
> +obj-$(CONFIG_KEXEC_FILE) += purgatory/
>  
>  # for cleaning
>  subdir- += boot
> diff --git a/arch/s390/Kbuild b/arch/s390/Kbuild
> index a5d3503b353c..361aa01dbd49 100644
> --- a/arch/s390/Kbuild
> +++ b/arch/s390/Kbuild
> @@ -7,7 +7,7 @@ obj-$(CONFIG_S390_HYPFS)        += hypfs/
>  obj-$(CONFIG_APPLDATA_BASE)    += appldata/
>  obj-y                          += net/
>  obj-$(CONFIG_PCI)              += pci/
> -obj-$(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) += purgatory/
> +obj-$(CONFIG_KEXEC_FILE)       += purgatory/
>  
>  # for cleaning
>  subdir- += boot tools
> 

