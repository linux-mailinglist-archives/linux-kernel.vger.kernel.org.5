Return-Path: <linux-kernel+bounces-128307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B050589591E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0ED3B217D0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1A5134CE0;
	Tue,  2 Apr 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxER6vrc"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9A413340D;
	Tue,  2 Apr 2024 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073594; cv=none; b=HyNOJl0QOA8FlkajhUxpUT6fMGznjvYC0+VSDHMVsx3fujRG2pEv1W7EzesiSd4uAErQ1TLIqrJ/ASdPhPV85u+PWJlu9uRZZ5TZ4AGHXtmRF+oyU1ooHeC3dtA9z7PuZ/Z11W+H5VU3vxmFV9GsVTcie/gYdqtKeeOY0uPDNUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073594; c=relaxed/simple;
	bh=9h0ja0fzbpqt/scnHosHOcw3nHfUNNwfNkOqdpgC51o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifI9Ftsn1bk+VSBa/yrXfOPHQqXMvg8M5SYA1bTEhX4qMrmIIE+Q8nJbD2HXpCdarFjb665C9g0I8uA43gtc3ydywh8lAQHNkiKUbYUzH2SHquVN3MNLlp7hvXr8zlgKGvZMDr/KT76TJFkELJ1u4noyujHXSPyl4mnB2BJI2kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxER6vrc; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78bc322a55cso302354985a.1;
        Tue, 02 Apr 2024 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712073591; x=1712678391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iMupQUHAsYvjV/fM+O/DYp3vUVspONAX/mj9N6Emok=;
        b=FxER6vrcSosT4dpSVmtIpBQ0Vj0IJd2F9Mjr7aqn/jnTBB2Y0VIohq1FM/D23wI3rk
         z2507T3nJj34Grm9bkYzzLmls4jcCk04JmUy6+264uMJaX9Uu7t3zsnDmPEES0hvNjcg
         yMsUH9S76ld9gHBLlea6UIHZkIF72Yyx+CRBxnamiM50Zp/34n26sLa5dTM0F7u8FICy
         5WAeKvBGA8rmrbRuu7yivsH3XQSxlGQbT6dKrvGZsR+PV2Pkwwg92Q0kfo7O4aHkccmE
         nj8xRIVoNP+5xt1slxdk4ipGNsmhGZfOqvl7kSY2OsET7gmdXCe7SPPBmhzD1qvZsNYB
         F3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712073591; x=1712678391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iMupQUHAsYvjV/fM+O/DYp3vUVspONAX/mj9N6Emok=;
        b=wYuCMYxye0DjO2LueGGUpCJn6uF6dQczD1agiLoLuH/weeDVlqerJ1haDnLG9ee+T2
         uOXLfP9wMsfWmzLQlI6Pka5/6yXVnk8UxOHjhia7pW1wo5fE7QHCCuAFqeQxlLf9C6kP
         yEZIRSxNZpQs1O3ZGEyIhqqkw2xgH9qQhBbCbVxKDNqo4QjPTD1BVQvKetXzrj7QNsQk
         zEqFj6K800FAw8Oc4P7xvrAtB9Qwz3rAtjc7AGAGI57S2bNq5gX8C5oCsrrasi75RqZL
         6O/ggorszJUbrNLAEL2ghBWg9vK/vk2VMpH/iQ8pj3hJAcor/Zc2PSzu6ahn+ShxKwxt
         lE6w==
X-Forwarded-Encrypted: i=1; AJvYcCUZsPgOsCvMqunWWNlWp+sPLhl3KyFWK102Cmpf5IBE+Y0vyPxzd2rapDWdd3sDGOCwozxsut8TtzNmeN0nfN9QOAoPpNAs14bcP0HL
X-Gm-Message-State: AOJu0YwJUdWYHeu8NRKI3HZhnNpWz+fcTRlOISf7SVpq6YwDKHXAvz06
	ZuQ9PJ12SZLobtEDC0wr4rbDrMOKcoXJS8lh/bm3QNAOm5ergoVORQThzKp2IQQ+5yNPT6IZk0N
	/8vJz2vMnXcqAJvibFUij5K7Kwy9Stsbq+b0=
X-Google-Smtp-Source: AGHT+IGPHg/9HglXdc6tls4Z75LO/pZfrCaLGGUa/G+QAANEau2vAKO2EPIan4VWLJmB8BdAd9NwinEhaMetg3yDkwg=
X-Received: by 2002:a0c:ecd0:0:b0:699:245c:bcc8 with SMTP id
 o16-20020a0cecd0000000b00699245cbcc8mr202370qvq.19.1712073590911; Tue, 02 Apr
 2024 08:59:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226135243.1393780-1-masahiroy@kernel.org> <20231226135243.1393780-6-masahiroy@kernel.org>
In-Reply-To: <20231226135243.1393780-6-masahiroy@kernel.org>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Tue, 2 Apr 2024 10:59:24 -0500
Message-ID: <CAOCHtYiCcxssYNvPwq5RoSv30+hkWOJD4=uRaGQmatOdJR9n0A@mail.gmail.com>
Subject: Re: [PATCH 6/6] kbuild: deb-pkg: use more debhelper commands in builddeb
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>, 
	Nicolas Schier <n.schier@avm.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 7:54=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
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
> Set DEB_RULES_REQUIRES_ROOT to 'no' in case debian/rules is executed
> directly.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nicolas Schier <n.schier@avm.de>
> ---
>
>  scripts/package/builddeb     | 23 ++++++++---------------
>  scripts/package/debian/rules |  2 ++
>  scripts/package/mkdebian     |  2 +-
>  3 files changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index 2eb4910f0ef3..436d55a83ab0 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -26,23 +26,16 @@ if_enabled_echo() {
>
>  create_package() {
>         local pname=3D"$1" pdir=3D"$2"
> -       local dpkg_deb_opts
>
> -       mkdir -m 755 -p "$pdir/DEBIAN"
> -       mkdir -p "$pdir/usr/share/doc/$pname"
> -       cp debian/copyright "$pdir/usr/share/doc/$pname/"
> -       cp debian/changelog "$pdir/usr/share/doc/$pname/changelog.Debian"
> -       gzip -n -9 "$pdir/usr/share/doc/$pname/changelog.Debian"
> -       sh -c "cd '$pdir'; find . -type f ! -path './DEBIAN/*' -printf '%=
P\0' \
> -               | xargs -r0 md5sum > DEBIAN/md5sums"
> +       export DH_OPTIONS=3D"-p${pname} -P${pdir}"
>
> -       # a+rX in case we are in a restrictive umask environment like 007=
7
> -       # ug-s in case we build in a setuid/setgid directory
> -       chmod -R go-w,a+rX,ug-s "$pdir"
> -
> -       # Create the package
> -       dpkg-gencontrol -p$pname -P"$pdir"
> -       dpkg-deb --root-owner-group ${KDEB_COMPRESS:+-Z$KDEB_COMPRESS} --=
build "$pdir" ..
> +       dh_installdocs
> +       dh_installchangelogs
> +       dh_compress
> +       dh_fixperms
> +       dh_gencontrol
> +       dh_md5sums
> +       dh_builddeb -- ${KDEB_COMPRESS:+-Z$KDEB_COMPRESS}
>  }
>
>  install_linux_image () {
> diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
> index 36d51f60f98d..1f56938ea5d4 100755
> --- a/scripts/package/debian/rules
> +++ b/scripts/package/debian/rules
> @@ -1,6 +1,8 @@
>  #!/usr/bin/make -f
>  # SPDX-License-Identifier: GPL-2.0-only
>
> +export DEB_RULES_REQUIRES_ROOT :=3D no
> +
>  include debian/rules.vars
>
>  ifneq (,$(filter-out parallel=3D1,$(filter parallel=3D%,$(DEB_BUILD_OPTI=
ONS))))
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index 93a24712b9a1..070149c985fe 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -193,7 +193,7 @@ Section: kernel
>  Priority: optional
>  Maintainer: $maintainer
>  Rules-Requires-Root: no
> -Build-Depends: debhelper
> +Build-Depends: debhelper-compat (=3D 12)

make ARCH=3Darm  CROSS_COMPILE=3D  bindeb-pkg

I'm seeing a fun issue with Ubuntu 24.04 (Noble)... 13.14.1ubuntu5:
https://launchpad.net/ubuntu/+source/debhelper

dpkg-buildpackage --build=3Dbinary --no-pre-clean --unsigned-changes
-R'make -f debian/rules' -j1 -a$(cat debian/arch)
dpkg-buildpackage: info: source package linux-upstream
dpkg-buildpackage: info: source version 1noble
dpkg-buildpackage: info: source distribution noble
dpkg-buildpackage: info: source changed by rcn-ee <robertcnelson@gmail.com>
 dpkg-source --before-build .
dpkg-buildpackage: info: host architecture armhf
dpkg-checkbuilddeps: error: Unmet build dependencies: debhelper-compat (=3D=
 12)
dpkg-buildpackage: warning: build dependencies/conflicts unsatisfied; abort=
ing
dpkg-buildpackage: warning: (Use -d flag to override.)

Where as Debian (testing) Trixie and Sid: 13.15.3
https://packages.debian.org/source/trixie/debhelper

dpkg-buildpackage --build=3Dbinary --no-pre-clean --unsigned-changes
-R'make -f debian/rules' -j1 -a$(cat debian/arch)
dpkg-buildpackage: info: source package linux-upstream
dpkg-buildpackage: info: source version 1trixie
dpkg-buildpackage: info: source distribution trixie
dpkg-buildpackage: info: source changed by rcn-ee <robertcnelson@gmail.com>
 dpkg-source --before-build .
dpkg-buildpackage: info: host architecture armhf
 make -f debian/rules binary

dpkg-buildpackage --build=3Dbinary --no-pre-clean --unsigned-changes
-R'make -f debian/rules' -j1 -a$(cat debian/arch)
dpkg-buildpackage: info: source package linux-upstream
dpkg-buildpackage: info: source version 1sid
dpkg-buildpackage: info: source distribution trixie
dpkg-buildpackage: info: source changed by rcn-ee <robertcnelson@gmail.com>
 dpkg-source --before-build .
dpkg-buildpackage: info: host architecture armhf
 make -f debian/rules binary


Not really sure why Noble is failing, but wonder if, would fix it..
Build-Depends: debhelper-compat (>=3D 12)

Regards,

--=20
Robert Nelson
https://rcn-ee.com/

