Return-Path: <linux-kernel+bounces-11892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1025B81ED08
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938C91F21C22
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CF56118;
	Wed, 27 Dec 2023 07:55:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A48C566F;
	Wed, 27 Dec 2023 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed, 27 Dec 2023 08:55:12 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 6755A80453;
	Wed, 27 Dec 2023 08:55:12 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id 5B8EF18131F; Wed, 27 Dec 2023 08:55:12 +0100 (CET)
Date: Wed, 27 Dec 2023 08:55:12 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] kbuild: deb-pkg: factor out common Make options in
 debian/rules
Message-ID: <ZYvYYBgAVmO0uj8V@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
References: <20231226135243.1393780-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231226135243.1393780-1-masahiroy@kernel.org>
Organization: AVM GmbH
X-purgate-ID: 149429::1703663712-956FB5FF-50D739FB/0/0
X-purgate-type: clean
X-purgate-size: 1491
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Tue, Dec 26, 2023 at 10:52:38PM +0900, Masahiro Yamada wrote:
> This avoid code duplication between binary-arch and built-arch.

avoids ?

Reviewed-by: Nicolas Schier <n.schier@avm.de>

> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/package/debian/rules | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
> index 3dafa9496c63..26bc6239e200 100755
> --- a/scripts/package/debian/rules
> +++ b/scripts/package/debian/rules
> @@ -10,20 +10,20 @@ ifneq (,$(filter-out parallel=1,$(filter parallel=%,$(DEB_BUILD_OPTIONS))))
>      MAKEFLAGS += -j$(NUMJOBS)
>  endif
>  
> +make-opts = ARCH=$(ARCH) KERNELRELEASE=$(KERNELRELEASE)
> +
>  .PHONY: binary binary-indep binary-arch
>  binary: binary-arch binary-indep
>  binary-indep: build-indep
>  binary-arch: build-arch
> -	$(MAKE) -f $(srctree)/Makefile ARCH=$(ARCH) \
> -	KERNELRELEASE=$(KERNELRELEASE) \
> +	$(MAKE) -f $(srctree)/Makefile $(make-opts) \
>  	run-command KBUILD_RUN_COMMAND=+$(srctree)/scripts/package/builddeb
>  
>  .PHONY: build build-indep build-arch
>  build: build-arch build-indep
>  build-indep:
>  build-arch:
> -	$(MAKE) -f $(srctree)/Makefile ARCH=$(ARCH) \
> -	KERNELRELEASE=$(KERNELRELEASE) \
> +	$(MAKE) -f $(srctree)/Makefile $(make-opts) \
>  	$(shell $(srctree)/scripts/package/deb-build-option) \
>  	olddefconfig all
>  
> -- 
> 2.40.1
> 

