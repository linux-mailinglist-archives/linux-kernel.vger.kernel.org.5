Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8092D7BBD5C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjJFQ6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjJFQ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:58:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9928BAD;
        Fri,  6 Oct 2023 09:58:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B1CC433C8;
        Fri,  6 Oct 2023 16:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696611498;
        bh=W/PV9BEnW7qV8HRBjAeCSKH71F8YRJwxXRxGjI45a6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QtctmrP7HPX723W0dFuw/syZx1G3b4jfABirVj7JKuUFR4u0ANnNX9D9WFqmGsizJ
         iomwfbA3VchilnHSRmBdJbSjGjzv5uZ49OeA095CjlXG8M7ItBd8qPL9QMUK/QrZ65
         tnkIn0MBo8NLpb3kkkez6smKI0yHnyR3oxGlCH7Tw/BF5baOzK8QzamZtZYZ52UHfJ
         yuPotqd/7l+OL/s5ThUw+Zlv1HX02eOtqk4dWMHcHjngAb1dbCohYH2U37ymWy+5oD
         qVCziJ7OACmhP86Vhm0WeDvNsTJ8c6ZOUc6cwNYampiMTHyv1l+aZYg0NdiQL/F+lj
         fowcyiaLg/Xng==
Date:   Fri, 6 Oct 2023 09:58:15 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH rebased] kbuild: rpm-pkg: Fix build with non-default
 MODLIB
Message-ID: <20231006165815.GA3359308@dev-arch.thelio-3990X>
References: <20231005150728.3429-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005150728.3429-1-msuchanek@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 05:07:28PM +0200, Michal Suchanek wrote:
> The default MODLIB value is composed of two variables and the hardcoded
> string '/lib/modules/'.
> 
> MODLIB = $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> 
> Defining this middle part as a variable was rejected on the basis that
> users can pass the whole MODLIB to make, such as
> 
> make 'MODLIB=$(INSTALL_MOD_PATH)/usr/lib/modules/$(KERNELRELEASE)'
> 
> However, this middle part of MODLIB is independently hardcoded by
> rpm-pkg, and when the user alters MODLIB this is not reflected when
> building the package.
> 
> Given that $(INSTALL_MOD_PATH) is overridden during the rpm package build
> it is likely going to be empty. Then MODLIB can be passed to the rpm
> package, and used in place of the whole
> /usr/lib/modules/$(KERNELRELEASE) part.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

This appears to work for me.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  scripts/package/kernel.spec | 8 ++++----
>  scripts/package/mkspec      | 1 +
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index 3eee0143e0c5..15f49c5077db 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
> @@ -67,7 +67,7 @@ cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KERNELRELEA
>  %{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
>  cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
>  cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
> -ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/build
> +ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}%{MODLIB}/build
>  %if %{with_devel}
>  %{make} %{makeflags} run-command KBUILD_RUN_COMMAND='${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
>  %endif
> @@ -98,8 +98,8 @@ fi
>  
>  %files
>  %defattr (-, root, root)
> -/lib/modules/%{KERNELRELEASE}
> -%exclude /lib/modules/%{KERNELRELEASE}/build
> +%{MODLIB}
> +%exclude %{MODLIB}/build
>  /boot/*
>  
>  %files headers
> @@ -110,5 +110,5 @@ fi
>  %files devel
>  %defattr (-, root, root)
>  /usr/src/kernels/%{KERNELRELEASE}
> -/lib/modules/%{KERNELRELEASE}/build
> +%{MODLIB}/build
>  %endif
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index d41608efb747..d41b2e5304ac 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -18,6 +18,7 @@ fi
>  cat<<EOF
>  %define ARCH ${ARCH}
>  %define KERNELRELEASE ${KERNELRELEASE}
> +%define MODLIB ${MODLIB}
>  %define pkg_release $("${srctree}/init/build-version")
>  EOF
>  
> -- 
> 2.42.0
> 
