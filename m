Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838507E4DB8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjKHAHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjKHAHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:07:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5A610EB;
        Tue,  7 Nov 2023 16:07:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D41C433C7;
        Wed,  8 Nov 2023 00:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699402071;
        bh=0EH+T/QEjc38AnUu2TmGCCAb/82ws/TY3BHNT4h27nM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZitqmFPOpSqYYDPJdCzHPGwQGYA3xxIpV+oGvzQPLr0ARf+0BgklNPKlOp0TvthDr
         GfTAVMSuGtYBJSLR5fURRYT8aVf1wjiERIxlb4qkO4j5kQz99TGwv0TGL6CPtUPvdu
         oTe/BOsjbTjN/MaJJhokCGmS7DtlsWiALPWtF8sptikg/rGks9pmi8gHl4REawWi23
         sC4e2DugDTlsMxHMvgBa9hkk4/1FRQZLIFyA6+Ijw5Q5v5o42gwpXUsKvJY3FHyteq
         IevAG+llj2HyKKbxYbHRM6Vo5VwrATSNe4QpaaPvPblnCrQakBZvn/SOx6zBpUcuiD
         W/G64nIdKDAaw==
Date:   Tue, 7 Nov 2023 17:07:49 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     dcavalca@meta.com
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rpm-pkg: simplify installkernel %post
Message-ID: <20231108000749.GA3723879@dev-arch.thelio-3990X>
References: <20231103-rpmpost-v1-1-9c18afab47f4@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103-rpmpost-v1-1-9c18afab47f4@meta.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davide,

On Fri, Nov 03, 2023 at 11:33:42PM +0000, Davide Cavalca via B4 Relay wrote:
> From: Davide Cavalca <dcavalca@meta.com>
> 
> The %post currently does a shuffling dance before calling installkernel.
> This isn't actually necessary afaict, and the current implementation
> ends up triggering downstream issues such as
> https://github.com/systemd/systemd/issues/29568
> 
> This commit simplifies the logic to remove the shuffling. For reference,
> the original logic was added in commit 3c9c7a14b627("rpm-pkg: add %post
> section to create initramfs and grub hooks").
> 
> Signed-off-by: Davide Cavalca <dcavalca@meta.com>

I took this for a spin in a Fedora 38 virtual machine while I wait for
Fedora 39 to make sure that this does not regress older installkernel
implementations and I think that this patch does just that. With Fedora
38, I see the following error during installation that I did not see
prior to applying your patch:

  cp: cannot stat '/boot/System.map-6.6.0-15157-gefb5302e6ea5': No such file or directory

and when attempting to boot the newly installed kernel, I see:

  error: ../../grub-core/loader/efi/linux.c:47:kernel is too small.
  error: ../../grub-core/loader/efi/linux.c:47:kernel is too small.
  error: ../../grub-core/loader/i386/efi/linux.c:258:you need to load the kernel
  first.
  error: ../../grub-core/loader/i386/efi/linux.c:258:you need to load the kernel first.

before I get kicked back to the grub menu. The /boot folder after
installing the rpm package with your patch in it looks like:

  $ ls -al /boot
  total 240012
  dr-xr-xr-x.  5 root root      4096 Nov  7 17:04 .
  dr-xr-xr-x. 18 root root       235 Nov  7 16:24 ..
  -rw-r--r--.  1 root root    268497 Nov  7 15:43 config-6.6.0-15156-g13d88ac54ddd
  -rw-r--r--.  1 root root    268497 Nov  7 15:50 config-6.6.0-15157-gefb5302e6ea5
  drwx------.  3 root root      4096 Dec 31  1969 efi
  drwx------.  3 root root        50 Nov  7 17:03 grub2
  -rw-------.  1 root root 114164610 Nov  7 16:26 initramfs-0-rescue-01cdbeade0ec4c07828d9f3919ec2772.img
  -rw-------.  1 root root  36334410 Nov  7 16:40 initramfs-6.6.0-15156-g13d88ac54ddd.img
  -rw-------.  1 root root  36174736 Nov  7 17:04 initramfs-6.6.0-15157-gefb5302e6ea5.img
  drwxr-xr-x.  3 root root        21 Nov  7 16:25 loader
  lrwxrwxrwx.  1 root root        42 Nov  7 17:04 System.map -> /boot/System.map-6.6.0-15157-gefb5302e6ea5
  -rw-r--r--.  1 root root   8968631 Nov  7 16:40 System.map-6.6.0-15156-g13d88ac54ddd
  -rw-r--r--.  1 root root   8968631 Nov  7 15:50 System.map-6.6.0-15157-gefb5302e6ea5.old
  lrwxrwxrwx.  1 root root        39 Nov  7 17:04 vmlinuz -> /boot/vmlinuz-6.6.0-15157-gefb5302e6ea5
  -rwxr-xr-x.  1 root root  14577352 Nov  7 16:25 vmlinuz-0-rescue-01cdbeade0ec4c07828d9f3919ec2772
  -rw-r--r--.  1 root root  13012992 Nov  7 16:40 vmlinuz-6.6.0-15156-g13d88ac54ddd
  -rw-r--r--.  1 root root         0 Nov  7 17:04 vmlinuz-6.6.0-15157-gefb5302e6ea5
  -rw-r--r--.  1 root root  13012992 Nov  7 15:50 vmlinuz-6.6.0-15157-gefb5302e6ea5.old

That zero sized vmlinuz-6.6.0-15157-gefb5302e6ea5 is likely the cause of
the grub error. It seems like this logic is likely still necessary for
older distributions.

Cheers,
Nathan

> ---
>  scripts/package/kernel.spec | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index 3eee0143e0c5..cc4292c03ea2 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
> @@ -77,11 +77,7 @@ rm -rf %{buildroot}
>  
>  %post
>  if [ -x /sbin/installkernel -a -r /boot/vmlinuz-%{KERNELRELEASE} -a -r /boot/System.map-%{KERNELRELEASE} ]; then
> -cp /boot/vmlinuz-%{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm
> -cp /boot/System.map-%{KERNELRELEASE} /boot/.System.map-%{KERNELRELEASE}-rpm
> -rm -f /boot/vmlinuz-%{KERNELRELEASE} /boot/System.map-%{KERNELRELEASE}
> -/sbin/installkernel %{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
> -rm -f /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
> +/sbin/installkernel %{KERNELRELEASE} /boot/vmlinuz-%{KERNELRELEASE} /boot/System.map-%{KERNELRELEASE}
>  fi
>  
>  %preun
> 
> ---
> base-commit: e392ea4d4d00880bf94550151b1ace4f88a4b17a
> change-id: 20231103-rpmpost-f5c99552919f
> 
> Best regards,
> -- 
> Davide Cavalca <dcavalca@meta.com>
> 
