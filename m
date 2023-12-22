Return-Path: <linux-kernel+bounces-9785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6933281CB68
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1711F244DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BFE20DD8;
	Fri, 22 Dec 2023 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="a5bnrp3+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA83210F2;
	Fri, 22 Dec 2023 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Fri, 22 Dec 2023 15:30:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1703255400; bh=vamAEQWaMS2pzzbZEbLWxeCL7hYWTn3s5bEZy3E82pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a5bnrp3+1W/cTQ6j0tdZvUWkhO9WpkuPNr9Qwaq/3qqAcntteC2dbsQ6qDV+FzG8l
	 cXe5GHOICDv/UxobCqmkACyrU8dF42DzbZbQHODYc2MNWp5C10jbEXh5a+Dn3ZUtQp
	 nigVNdxgUk2uaeqEBCOTMlGslR2fxpEh4Nb1tS+I=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 40E8C8041D;
	Fri, 22 Dec 2023 15:30:00 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id 34007180C9F; Fri, 22 Dec 2023 15:30:00 +0100 (CET)
Date: Fri, 22 Dec 2023 15:30:00 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] kbuild: deb-pkg: do not query DEB_HOST_MULTIARCH
Message-ID: <ZYWdaCiNFsseZWWS@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
References: <20231219181957.1449958-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231219181957.1449958-1-masahiroy@kernel.org>
Organization: AVM GmbH
X-purgate-ID: 149429::1703255400-7166592C-4C547590/0/0
X-purgate-type: clean
X-purgate-size: 3222
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Wed, Dec 20, 2023 at 03:19:55AM +0900, Masahiro Yamada wrote:
> Since commit 491b146d4c13 ("kbuild: builddeb: Eliminate debian/arch
> use"), the direct execution of debian/rules fails with:
> 
>   dpkg-architecture: error: unknown option 'DEB_HOST_MULTIARCH'
> 
> I am not sure how important to support such a use case, but at least
> the current code:
> 
>   dpkg-architecture -a$DEB_HOST_ARCH -qDEB_HOST_MULTIARCH
> 
> ... looks weird because:
> 
>  - For this code to work correctly, DEB_HOST_ARCH must be defined.
>    In this case, DEB_HOST_MULTIARCH is likely defined, so there is no
>    need to query DEB_HOST_MULTIARCH in the first place. This is likely
>    the case where the package build was initiated by dpkg-buildpackage.
> 
>  - If DEB_HOST_MULTIARCH is undefined, DEB_HOST_ARCH is likely undefined.
>    So, you cannot query DEB_HOST_MULTIARCH in this way. This is mostly
>    the case where debian/rules is directly executed.
> 
> If we want to run debian/rules directly, we can revert 491b146d4c13 or
> add code to remember DEB_HOST_MULTIARCH, but I chose to remove the
> useless code for now.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

thanks.  Fixing the non-functional things is obviously a good thing.

Reviewed-by: Nicolas Schier <n.schier@avm.de>


Iff we'd like to be able to call debian/rules directly, do we really
have to remember DEB_HOST_MULTIARCH, or just DEB_HOST_ARCH?

In the latter case, might this be a sufficient way to allow calling
debian/rules again?

diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index 3dafa9496c63..e3e0001e7556 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -3,7 +3,9 @@
 
 include debian/rules.vars
 
-srctree ?= .
+DEB_HOST_ARCH ?= $(shell cat debian/arch)
+
+srctree ?= $(or $(wildcard source), .)
 
 ifneq (,$(filter-out parallel=1,$(filter parallel=%,$(DEB_BUILD_OPTIONS))))
     NUMJOBS = $(patsubst parallel=%,%,$(filter parallel=%,$(DEB_BUILD_OPTIONS)))


... but the more I think about it, I am not convinced that we want to
use the debian/arch file.  Actually I think it would be nice if we
strive for an architecture independent source package instead of
engraving the architecture even more.


Nevertheless, your patch looks good to me.

Kind regards,
Nicolas



> 
>  scripts/package/builddeb | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
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
> -- 
> 2.40.1
> 

