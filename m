Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F56780F676
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbjLLTTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbjLLTTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:19:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E88F5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:19:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266EEC433C8;
        Tue, 12 Dec 2023 19:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702408760;
        bh=uqEk75tNt0gCIiuSDm0WdJvZtKoO1NR6Qn5m6gbH2tU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sv4X21Aqaaa/6NVM5siE3Ts0NlVAQSrkbVJ/0ylBNduhTX6+Dba0Vt1QiATLtcOWL
         oaMQYtwW0TZi9F3BXbqJmoXNItwUQxVbXk0ikBvQDrLNzFIWMLwW8Seer+KzR2ozQx
         CuAHW5UBoSYKyG+L6H3YQJy4dNGoaNNCzTtH8ZR1eK4ASA99wU9jgNDI7/opQymw5A
         WUlcMnSIf215SpBE2LAyuyUluuruGGyKB3pFQ5bowm71qutLyVTS3MxtfmJETEGJZU
         ALZRN2ehEtppvlOhdfhjuuQ9YFOt7GRg4OSRWfHUPvdb77a/Hrc699kRymsDTz9VVW
         hGUsCMps1pOrg==
Date:   Tue, 12 Dec 2023 12:19:18 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc:     dcavalca@meta.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu, stable@vger.kernel.org
Subject: Re: [PATCH v2] rpm-pkg: simplify installkernel %post
Message-ID: <20231212191918.GA2914380@dev-arch.thelio-3990X>
References: <20231108000749.GA3723879@dev-arch.thelio-3990X>
 <20231212171044.1108464-1-jtornosm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212171044.1108464-1-jtornosm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 06:10:44PM +0100, Jose Ignacio Tornos Martinez wrote:
> A new installkernel application is now included in systemd-udev package
> and it has been improved to allow simplifications.
> 
> For the new installkernel application, as Davide says:
> <<The %post currently does a shuffling dance before calling installkernel.
> This isn't actually necessary afaict, and the current implementation
> ends up triggering downstream issues such as
> https://github.com/systemd/systemd/issues/29568
> This commit simplifies the logic to remove the shuffling. For reference,
> the original logic was added in commit 3c9c7a14b627("rpm-pkg: add %post
> section to create initramfs and grub hooks").>>
> 
> But we need to keep the old behavior as well, because the old installkernel
> application from grubby package, does not allow this simplification and
> we need to be backward compatible to avoid issues with the different
> packages. So the easiest solution is to check the package that provides
> the installkernel application, and simplify (and fix for this
> application at the same time), only if the package is systemd-udev.
> 
> cc: stable@vger.kernel.org
> Co-Developed-by: Davide Cavalca <dcavalca@meta.com>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Thanks, I can confirm that installing the same RPM package produced by
binrpm-pkg on both Fedora 38 and 39 works as expected now and the check
seems reasonable to me but I'll defer to Masahiro for further comments.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> V1 -> V2:
> - Complete to be backward compatible with the previous installkernel
> application.
> 
>  scripts/package/kernel.spec | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index 3eee0143e0c5..d4276ddb6645 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
> @@ -77,12 +77,16 @@ rm -rf %{buildroot}
>  
>  %post
>  if [ -x /sbin/installkernel -a -r /boot/vmlinuz-%{KERNELRELEASE} -a -r /boot/System.map-%{KERNELRELEASE} ]; then
> +if [ $(rpm -qf /sbin/installkernel --queryformat "%{n}") = systemd-udev ];then
> +/sbin/installkernel %{KERNELRELEASE} /boot/vmlinuz-%{KERNELRELEASE} /boot/System.map-%{KERNELRELEASE}
> +else
>  cp /boot/vmlinuz-%{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm
>  cp /boot/System.map-%{KERNELRELEASE} /boot/.System.map-%{KERNELRELEASE}-rpm
>  rm -f /boot/vmlinuz-%{KERNELRELEASE} /boot/System.map-%{KERNELRELEASE}
>  /sbin/installkernel %{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
>  rm -f /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
>  fi
> +fi
>  
>  %preun
>  if [ -x /sbin/new-kernel-pkg ]; then
> -- 
> 2.43.0
> 
