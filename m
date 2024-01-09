Return-Path: <linux-kernel+bounces-20378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2AA827DE2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E6B1F2415F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C19819;
	Tue,  9 Jan 2024 04:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YX/DbdCU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D5738A;
	Tue,  9 Jan 2024 04:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4561EC433F1;
	Tue,  9 Jan 2024 04:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704775125;
	bh=seyz1YfDIvyylL/AiuFwsvW0dpM/NUMlH9bFYXik1z8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YX/DbdCUSEDZmRUtywo/bALRWoY93sPnQjffQK3e4YHX2abBVvQVs+4f1DAM/RnEh
	 X0go/6ci5oK7nbS1Vx9XgXawdqVqieAjK4pi+v25c9nBK3OuV4J205dBLzK/jbEtPV
	 v+U52AdjDUHCsU18qs7nPE6kq5Oi6yzCG3p57L+7OkCq5Tw+kFB5t1OeaYmIFQQqm4
	 qMmnckRqEmM2yO6dOazXJwMCg1lBmsvTgJEnoq6NEVKtwchspRrI7oO/pc9kKWDKCB
	 Gxlr2X7M1gqYz3rHBP2Xe+o8E+Dd4ArjgBiezPP34gD0rb/I4f0tu/xhAl4ZPJFK4Z
	 33XXlMsxECE1A==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-205f223639fso1829673fac.2;
        Mon, 08 Jan 2024 20:38:45 -0800 (PST)
X-Gm-Message-State: AOJu0YyCe6gS4pVDL/bTbd9pV7IGcRqXalAaOxoGvW1p9U9bWcKFt/60
	AS19a2yOaf16JRW3LPlmeOXBw4IeqktKpByQ3GQ=
X-Google-Smtp-Source: AGHT+IHbCUHcJPP9RXg2OBCenHQWvBRO7OZe8uTEajO/YwMutJAjkpGJOrsL6SzjrBjIv25HEe9Y/jizLRjYzas7Ufo=
X-Received: by 2002:a05:6870:e60b:b0:203:c5ca:5333 with SMTP id
 q11-20020a056870e60b00b00203c5ca5333mr6372868oag.41.1704775124623; Mon, 08
 Jan 2024 20:38:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231230135200.1058873-1-masahiroy@kernel.org>
In-Reply-To: <20231230135200.1058873-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 9 Jan 2024 13:38:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNATLZ2rt8fFZYu1KX4HW5s0EjNbDEXp8csCPGtA5a-6qPw@mail.gmail.com>
Message-ID: <CAK7LNATLZ2rt8fFZYu1KX4HW5s0EjNbDEXp8csCPGtA5a-6qPw@mail.gmail.com>
Subject: Re: [PATCH 1/5] kbuild: deb-pkg: move 'make headers' to build-arch
To: linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2023 at 10:52=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> Strictly speaking, 'make headers' should be a part of build-arch
> instead of binary-arch.
>
> 'make headers' constructs read-to-copy UAPI headers in the kernel
> directory.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/package/builddeb     | 1 -
>  scripts/package/debian/rules | 4 ++--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index cc8c7a807fcc..842ee4b40528 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -155,7 +155,6 @@ install_libc_headers () {
>
>         rm -rf $pdir
>
> -       $MAKE -f $srctree/Makefile headers
>         $MAKE -f $srctree/Makefile headers_install INSTALL_HDR_PATH=3D$pd=
ir/usr
>
>         # move asm headers to /usr/include/<libc-machine>/asm to match th=
e structure
> diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
> index cb084e387469..a686c37d0d02 100755
> --- a/scripts/package/debian/rules
> +++ b/scripts/package/debian/rules
> @@ -26,8 +26,8 @@ binary-arch: build-arch
>  build: build-arch build-indep
>  build-indep:
>  build-arch:
> -       $(MAKE) $(make-opts) \
> -       olddefconfig all
> +       $(MAKE) $(make-opts) olddefconfig
> +       $(MAKE) $(make-opts) headers all




To avoid a build error for ARCH=3Dum,
I will apply the following fix-up.





diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index 1a18ca3c43db..098307780062 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -27,7 +27,7 @@ build: build-arch build-indep
 build-indep:
 build-arch:
        $(MAKE) $(make-opts) olddefconfig
-       $(MAKE) $(make-opts) headers all
+       $(MAKE) $(make-opts) $(if $(filter um,$(ARCH)),,headers) all

 .PHONY: clean
 clean:







>
>  .PHONY: clean
>  clean:
> --
> 2.40.1
>


--=20
Best Regards
Masahiro Yamada

