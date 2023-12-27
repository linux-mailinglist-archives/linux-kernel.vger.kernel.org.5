Return-Path: <linux-kernel+bounces-11897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1B481ED26
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68E3DB20FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C47B63AA;
	Wed, 27 Dec 2023 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="KVYkCEWz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D4A6127;
	Wed, 27 Dec 2023 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed, 27 Dec 2023 09:08:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1703664500; bh=NCCEHPYYk6kNINCmBJigOpfQPQaHrByq4i5dZjzV7gE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KVYkCEWzMmgvL0BVlCuPU4A/ImDvuBAJdQEOhtF3WdtR14WOipCJO18MPOtGYaY8I
	 Aa82O19DMW8i9D6V6bhuqT4r37oHnq3BM2Hh3FjMFf7yf9sZc0v6N9WMBTkU8Mrokg
	 3bU7DxNUc5OAtwGcboU445X5br/AK/2vdzWI1fHo=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id B20968001F;
	Wed, 27 Dec 2023 09:08:20 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id A623218109B; Wed, 27 Dec 2023 09:08:20 +0100 (CET)
Date: Wed, 27 Dec 2023 09:08:20 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] kbuild: deb-pkg: set DEB_* variables if debian/rules
 is directly executed
Message-ID: <ZYvbdMfz1PzROlb6@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
References: <20231226135243.1393780-1-masahiroy@kernel.org>
 <20231226135243.1393780-3-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231226135243.1393780-3-masahiroy@kernel.org>
Organization: AVM GmbH
X-purgate-ID: 149429::1703664500-8BE5092C-2A6AEF5A/0/0
X-purgate-type: clean
X-purgate-size: 3211
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Tue, Dec 26, 2023 at 10:52:40PM +0900, Masahiro Yamada wrote:
> Since commit 491b146d4c13 ("kbuild: builddeb: Eliminate debian/arch
> use"), direct execution of debian/rules results in the following error:
> 
>   dpkg-architecture: error: unknown option 'DEB_HOST_MULTIARCH'
> 
> The current code:
> 
>   dpkg-architecture -a$DEB_HOST_ARCH -qDEB_HOST_MULTIARCH
> 
> ... does not look sensible because:
> 
>  - For this code to work correctly, DEB_HOST_ARCH must be pre-defined,
>    which is true when the packages are built via dpkg-buildpackage.
>    In this case, DEB_HOST_MULTIARCH is also likely defined, hence there
>    is no need to query DEB_HOST_MULTIARCH in the first place.
> 
>  - If DEB_HOST_MULTIARCH is undefined, DEB_HOST_ARCH is likely undefined
>    too. So, you cannot query DEB_HOST_MULTIARCH in this way. This is
>    mostly the case where debian/rules is directly executed.
> 
> When debian/rules is directly executed, querying DEB_HOST_MUCHARCH is
> not enough because we need to know DEB_{BUILD,HOST}_GNU_TYPE as well.
> 
> All DEB_* variables are defined when the package build is initiated by
> dpkg-buildpackage, but otherwise, let's call dpkg-architecture to set
> all DEB_* environment variables.
> 
> This implementation relies on dpkg commit 7c54fa2b232e
> ("dpkg-architecture: Add a --print-format option").
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/package/builddeb     |  5 ++---
>  scripts/package/debian/rules | 12 +++++++++++-
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index 2fe51e6919da..2eb4910f0ef3 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -171,9 +171,8 @@ install_libc_headers () {
>  
>  	# move asm headers to /usr/include/<libc-machine>/asm to match the structure
>  	# used by Debian-based distros (to support multi-arch)
> -	host_arch=$(dpkg-architecture -a$DEB_HOST_ARCH -qDEB_HOST_MULTIARCH)
> -	mkdir $pdir/usr/include/$host_arch
> -	mv $pdir/usr/include/asm $pdir/usr/include/$host_arch/
> +	mkdir "$pdir/usr/include/${DEB_HOST_MULTIARCH}"
> +	mv "$pdir/usr/include/asm" "$pdir/usr/include/${DEB_HOST_MULTIARCH}"
>  }
>  
>  rm -f debian/files
> diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
> index 529b71b55efa..8f24a8e84bf2 100755
> --- a/scripts/package/debian/rules
> +++ b/scripts/package/debian/rules
> @@ -30,5 +30,15 @@ build-arch:
>  
>  .PHONY: clean
>  clean:
> -	rm -rf debian/files debian/linux-*
> +	rm -rf debian/files debian/linux-* debian/deb-env.vars
>  	$(MAKE) -f $(srctree)/Makefile ARCH=$(ARCH) clean
> +
> +# If DEB_HOST_ARCH is empty, it is likely that debian/rules was executed
> +# directly. Run 'dpkg-architecture --print-set --print-format=make' to
> +# generate a makefile construct that exports all DEB_* variables.
> +ifndef DEB_HOST_ARCH
> +-include debian/deb-env.vars
> +
> +debian/deb-env.vars:
> +	dpkg-architecture -a$$(cat debian/arch) --print-set --print-format=make > $@
> +endif
> -- 
> 2.40.1

Thanks!

Reviewed-by: Nicolas Schier <n.schier@avm.de>

