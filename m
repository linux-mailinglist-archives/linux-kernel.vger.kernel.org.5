Return-Path: <linux-kernel+bounces-22279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC16C829BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B73728148D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EAD495FA;
	Wed, 10 Jan 2024 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="aiGHYzZl"
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9119048CD2;
	Wed, 10 Jan 2024 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed, 10 Jan 2024 14:50:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1704894659; bh=E2TcI7cs2XAlktwXte8/dwg+LAVaBEtqAxnz/V1z+RE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aiGHYzZlLH204W9GS9EqZlVqbiCD6xB792fBuF7ckDdlV9s5xduDYlyG3W+glB0QC
	 vwMQfDblVwprRPOyezC6b+G+gYkDtKQ0XX2VHzyzCZekG/MUP7WJTWZlDMTmz0FR2F
	 kjGixXZ+qFFxtqJblXrJujl8MQm1KGJakbk5JGrY=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 98702802B0;
	Wed, 10 Jan 2024 14:50:59 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id 8B84C180D88; Wed, 10 Jan 2024 14:50:59 +0100 (CET)
Date: Wed, 10 Jan 2024 14:50:59 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] kbuild: deb-pkg: call more misc debhelper commands
Message-ID: <ZZ6gwwryhC6gnJxV@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
References: <20231230135200.1058873-1-masahiroy@kernel.org>
 <20231230135200.1058873-5-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231230135200.1058873-5-masahiroy@kernel.org>
Organization: AVM GmbH
X-purgate-ID: 149429::1704894659-A0EEC5FF-A60195C8/0/0
X-purgate-type: clean
X-purgate-size: 2931
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Sat, Dec 30, 2023 at 10:52:00PM +0900, Masahiro Yamada wrote:
> Use dh_prep instead of removing old build directories manually.
> 
> Use dh_clean instead of removing build directories and debian/files
> manually.
> 
> Call dh_testdir and dh_testroot for preliminary checks.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/package/builddeb     | 8 --------
>  scripts/package/debian/rules | 6 +++++-
>  2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index d31b16afe0db..e797ad360f7a 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -28,8 +28,6 @@ install_linux_image () {
>  	pname=$1
>  	pdir=debian/$1
>  
> -	rm -rf ${pdir}
> -
>  	# Only some architectures with OF support have this target
>  	if is_enabled CONFIG_OF_EARLY_FLATTREE && [ -d "${srctree}/arch/${SRCARCH}/boot/dts" ]; then
>  		${MAKE} -f ${srctree}/Makefile INSTALL_DTBS_PATH="${pdir}/usr/lib/linux-image-${KERNELRELEASE}" dtbs_install
> @@ -97,8 +95,6 @@ install_linux_image () {
>  install_linux_image_dbg () {
>  	pdir=debian/$1
>  
> -	rm -rf ${pdir}
> -
>  	# Parse modules.order directly because 'make modules_install' may sign,
>  	# compress modules, and then run unneeded depmod.
>  	while read -r mod; do
> @@ -128,8 +124,6 @@ install_kernel_headers () {
>  	pdir=debian/$1
>  	version=${1#linux-headers-}
>  
> -	rm -rf $pdir
> -
>  	"${srctree}/scripts/package/install-extmod-build" "${pdir}/usr/src/linux-headers-${version}"
>  
>  	mkdir -p $pdir/lib/modules/$version/
> @@ -139,8 +133,6 @@ install_kernel_headers () {
>  install_libc_headers () {
>  	pdir=debian/$1
>  
> -	rm -rf $pdir
> -
>  	$MAKE -f $srctree/Makefile headers_install INSTALL_HDR_PATH=$pdir/usr
>  
>  	# move asm headers to /usr/include/<libc-machine>/asm to match the structure
> diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
> index 407f46a4a655..5c5554c70949 100755
> --- a/scripts/package/debian/rules
> +++ b/scripts/package/debian/rules
> @@ -32,6 +32,9 @@ package = $($(@:binary-%=%-package))
>  DH_OPTIONS = -p$(package)
>  
>  define binary
> +	$(Q)dh_testdir $(DH_OPTIONS)
> +	$(Q)dh_testroot $(DH_OPTIONS)
> +	$(Q)dh_prep $(DH_OPTIONS)
>  	$(Q)+$(MAKE) $(make-opts) run-command KBUILD_RUN_COMMAND='+$$(srctree)/scripts/package/builddeb $(package)'
>  	$(Q)dh_installdocs $(DH_OPTIONS)
>  	$(Q)dh_installchangelogs $(DH_OPTIONS)
> @@ -62,7 +65,8 @@ build-arch:
>  
>  .PHONY: clean
>  clean:
> -	$(Q)rm -rf debian/files debian/linux-* debian/deb-env.vars* debian/*.files
> +	$(Q)dh_clean
> +	$(Q)rm -rf debian/deb-env.vars* debian/*.files
>  	$(Q)$(MAKE) ARCH=$(ARCH) clean
>  
>  # If DEB_HOST_ARCH is empty, it is likely that debian/rules was executed
> -- 
> 2.40.1
> 

Reviewed-by: Nicolas Schier <n.schier@avm.de>

