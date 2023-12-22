Return-Path: <linux-kernel+bounces-9783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2E681CB60
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20263285B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975251DFD6;
	Fri, 22 Dec 2023 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="NDd7xAAX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733817745;
	Fri, 22 Dec 2023 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Fri, 22 Dec 2023 15:27:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1703255256; bh=ntHkONYPmZ/m4S7yKPtQQfIZpoaul6RMdpZ3cw8+Wro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NDd7xAAXkbfaiHoRkRblm5woAL0Vd7PywcsFTmu6DCMY1I/6wFlChZb9tNMCZbtAC
	 ppnB74Y7tHS+2lOer+n39P2DuLaSt6lqgliavVuCmdi0aXw55v7P4LkBerSfIrsa0d
	 5NuWqKlGcquvOmMm23IOrwV1N41k+2gnbykQH0n0=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id DBFAE8041D;
	Fri, 22 Dec 2023 15:27:37 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id D5B80182BE0; Fri, 22 Dec 2023 15:27:37 +0100 (CET)
Date: Fri, 22 Dec 2023 15:27:37 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] kbuild: deb-pkg: use more debhelper commands
Message-ID: <ZYWc2dBxEIx5N0JE@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
References: <20231219181957.1449958-1-masahiroy@kernel.org>
 <20231219181957.1449958-3-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231219181957.1449958-3-masahiroy@kernel.org>
Organization: AVM GmbH
X-purgate-ID: 149429::1703255256-9CFD7DFE-8D48ECCF/0/0
X-purgate-type: clean
X-purgate-size: 2173
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Wed, Dec 20, 2023 at 03:19:57AM +0900, Masahiro Yamada wrote:
> Commit 36862e14e316 ("kbuild: deb-pkg: use dh_listpackages to know
> enabled packages") started to require the debhelper tool suite.
> 
> Use more dh_* commands in create_package():
> 
>  - dh_installdocs to install copyright
>  - dh_installchangelogs to install changelog
>  - dh_compress to compress changelog
>  - dh_fixperms to replace the raw chmod command
>  - dh_gencontrol to replace the raw dpkg-gencontrol command
>  - dh_md5sums to record the md5sum of included files
>  - dh_builddeb to replace the raw dpkg-deb command
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/package/builddeb | 23 ++++++++---------------
>  scripts/package/mkdebian |  2 +-
>  2 files changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index 2eb4910f0ef3..436d55a83ab0 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -26,23 +26,16 @@ if_enabled_echo() {
>  
>  create_package() {
>  	local pname="$1" pdir="$2"
> -	local dpkg_deb_opts
>  
> -	mkdir -m 755 -p "$pdir/DEBIAN"
> -	mkdir -p "$pdir/usr/share/doc/$pname"
> -	cp debian/copyright "$pdir/usr/share/doc/$pname/"
> -	cp debian/changelog "$pdir/usr/share/doc/$pname/changelog.Debian"
> -	gzip -n -9 "$pdir/usr/share/doc/$pname/changelog.Debian"
> -	sh -c "cd '$pdir'; find . -type f ! -path './DEBIAN/*' -printf '%P\0' \
> -		| xargs -r0 md5sum > DEBIAN/md5sums"
> +	export DH_OPTIONS="-p${pname} -P${pdir}"
>  
> -	# a+rX in case we are in a restrictive umask environment like 0077
> -	# ug-s in case we build in a setuid/setgid directory
> -	chmod -R go-w,a+rX,ug-s "$pdir"
> -
> -	# Create the package
> -	dpkg-gencontrol -p$pname -P"$pdir"
> -	dpkg-deb --root-owner-group ${KDEB_COMPRESS:+-Z$KDEB_COMPRESS} --build "$pdir" ..
> +	dh_installdocs
> +	dh_installchangelogs
> +	dh_compress
> +	dh_fixperms
> +	dh_gencontrol
> +	dh_md5sums
> +	dh_builddeb -- ${KDEB_COMPRESS:+-Z$KDEB_COMPRESS}
>  }

That looks much cleaner, thanks!

Reviewed-by: Nicolas Schier <n.schier@avm.de>

