Return-Path: <linux-kernel+bounces-20890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE5A8286FE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731AF287234
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2C338F97;
	Tue,  9 Jan 2024 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="XbOUl1YL"
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD0438F89;
	Tue,  9 Jan 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue,  9 Jan 2024 14:24:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1704806650; bh=tMStWelCVVDu4o3rBq23Y0TJCZcZ13Gsa2QHe6beLOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XbOUl1YLQzT+Q5pGYYeIrGuUkIFunMxyTZ3ap8V5rYuiUE1MXPgt+aWXXNCOOt4nk
	 gJLKWYOqidHStMn1nCQLL8bCpspF9ePqnkGdDAjMn1+XQkBetXY8sBya7aIX+jMDF2
	 WU4hSJNNgAW4uPeyCHRMGxcg6RZjZ3Jd6vGK3pdc=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 8FF5C8001F;
	Tue,  9 Jan 2024 14:24:10 +0100 (CET)
Received: from reykjavik.ads.avm.de (unknown [172.17.89.91])
	by buildd.core.avm.de (Postfix) with ESMTPS id 848DC180DE2;
	Tue,  9 Jan 2024 14:24:10 +0100 (CET)
Date: Tue, 9 Jan 2024 14:24:07 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH 1/5] kbuild: deb-pkg: move 'make headers' to build-arch
Message-ID: <ZZ1I95oHTayfygue@reykjavik.ads.avm.de>
References: <20231230135200.1058873-1-masahiroy@kernel.org>
 <CAK7LNATLZ2rt8fFZYu1KX4HW5s0EjNbDEXp8csCPGtA5a-6qPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATLZ2rt8fFZYu1KX4HW5s0EjNbDEXp8csCPGtA5a-6qPw@mail.gmail.com>
X-purgate-ID: 149429::1704806650-92EC05FF-B30D294E/0/0
X-purgate-type: clean
X-purgate-size: 2372
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Tue, Jan 09, 2024 at 01:38:07PM +0900, Masahiro Yamada wrote:
> On Sat, Dec 30, 2023 at 10:52 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Strictly speaking, 'make headers' should be a part of build-arch
> > instead of binary-arch.
> >
> > 'make headers' constructs read-to-copy UAPI headers in the kernel

s/read/ready/ ?

> > directory.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/package/builddeb     | 1 -
> >  scripts/package/debian/rules | 4 ++--
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> > index cc8c7a807fcc..842ee4b40528 100755
> > --- a/scripts/package/builddeb
> > +++ b/scripts/package/builddeb
> > @@ -155,7 +155,6 @@ install_libc_headers () {
> >
> >         rm -rf $pdir
> >
> > -       $MAKE -f $srctree/Makefile headers
> >         $MAKE -f $srctree/Makefile headers_install INSTALL_HDR_PATH=$pdir/usr
> >
> >         # move asm headers to /usr/include/<libc-machine>/asm to match the structure
> > diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
> > index cb084e387469..a686c37d0d02 100755
> > --- a/scripts/package/debian/rules
> > +++ b/scripts/package/debian/rules
> > @@ -26,8 +26,8 @@ binary-arch: build-arch
> >  build: build-arch build-indep
> >  build-indep:
> >  build-arch:
> > -       $(MAKE) $(make-opts) \
> > -       olddefconfig all
> > +       $(MAKE) $(make-opts) olddefconfig
> > +       $(MAKE) $(make-opts) headers all
> 
> 
> 
> 
> To avoid a build error for ARCH=um,
> I will apply the following fix-up.
> 
> 
> 
> 
> 
> diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
> index 1a18ca3c43db..098307780062 100755
> --- a/scripts/package/debian/rules
> +++ b/scripts/package/debian/rules
> @@ -27,7 +27,7 @@ build: build-arch build-indep
>  build-indep:
>  build-arch:
>         $(MAKE) $(make-opts) olddefconfig
> -       $(MAKE) $(make-opts) headers all
> +       $(MAKE) $(make-opts) $(if $(filter um,$(ARCH)),,headers) all

Reviewed-by: Nicolas Schier <n.schier@avm.de>

I'm wondering if we might want to change the headers target in top-level
Makefile to not bail-out for ARCH=um but only show a warning that there
is nothing to export.

Kind regards,
Nicolas

