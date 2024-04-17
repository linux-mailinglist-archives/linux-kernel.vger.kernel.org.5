Return-Path: <linux-kernel+bounces-147929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B308A7B76
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13F4284358
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2F8481BE;
	Wed, 17 Apr 2024 04:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b="TsUJBHv6"
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B5F44C60;
	Wed, 17 Apr 2024 04:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713328688; cv=none; b=pF34WATojBQ7qRczFDO89B/bzLn9fbh45FhVI5su+RQ+2geByD7W4mpwooiQEn4SPz1T9WAPyLLXaLCUbCa5Kvd7aEVX7C+Es9OA7TSvSWfQfnc1hJPTK632YUeRDYJYeQnoWKPt0qLOE6iQfz31yj5v7JA6nCkwQGqNpQiUHAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713328688; c=relaxed/simple;
	bh=zHKzExQqZWqAwP/VxhFaDjDzbwnfwfF4YYZd/OapYkw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdjzeVIKHU5shOYKfxtLfV/SjisgLoMUOX3tfJuNkz+W8TqGOzMZCNjR3VF+D7Isy2nALzp/OOJkPlhBdR4HOQ2sSUdYHjmseuYNBfLDW4wT0VKdqNV3iHAdthZpUliSOOv+Ab7Lm40/KFlIJfhidrfAoliVRt96ibXT5plYTsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com; spf=pass smtp.mailfrom=thefossguy.com; dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b=TsUJBHv6; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thefossguy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thefossguy.com;
	s=protonmail; t=1713328680; x=1713587880;
	bh=pp8p9HGXXcoQWS31K5FE4IE/aNjWd3ZLRLc51c+yVfg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TsUJBHv6UtUA1uWa0BoAuYeveWbqs9SvbmqunDKvIqL4yRFsKZ24bt0ybsToYzUip
	 UIoAMC8/5ZC7fUNjY/UV/rHCljRY8/P2uSIH7pHvR3rYigwQpU96ipHwgiU4zv85mv
	 E+ilSnfuFSP+wUpfwrwoMmk9EzDta+ps9oCB9D495gAdRL4o90r1+bxQ9kb7HCqON3
	 R31vONCuiV+Eg3wsL6ZuaOQ0+opEec/qws9gQIITXyQVmf+hnsXoapH3AObiW2jWiK
	 w1Q0PdpSrJijH0lSQ9N57pQKtokigKU6GsrWsMMdC+C1AxnFeeAIkJtwU4Va4sX1dK
	 WnwtY5pcmZP8g==
Date: Wed, 17 Apr 2024 04:37:46 +0000
To: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Jonathan Corbet <corbet@lwn.net>
From: Pratham Patel <prathampatel@thefossguy.com>
Cc: linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Pratham Patel <prathampatel@thefossguy.com>, thefirst1322@gmail.com
Subject: [PATCH 1/2] kbuild: allow toggling the `with_devel` RPM macro
Message-ID: <20240417043654.60662-2-prathampatel@thefossguy.com>
In-Reply-To: <20240417043654.60662-1-prathampatel@thefossguy.com>
References: <20240417043654.60662-1-prathampatel@thefossguy.com>
Feedback-ID: 104309535:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

As it stands, there is no way to toggle the `with_devel` RPM macro
that is defined in the scripts/package/kernel.spec file, without
manually building the RPM.

Introduce the Kbuild variable KBUILD_RPM_WITH_DEVEL to toggle the
`with_devel` macro when building the binary PRM package.

The prior default of not building the `-devel` RPM package is preserved.

Signed-off-by: Pratham Patel <prathampatel@thefossguy.com>
---
 scripts/Makefile.package | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 38653f3e8108..715e068eae60 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -47,6 +47,8 @@ $(linux-tarballs): .tmp_HEAD FORCE
 # rpm-pkg srcrpm-pkg binrpm-pkg
 # ------------------------------------------------------------------------=
---
=20
+export KBUILD_RPM_WITH_DEVEL ?=3D 0
+
 quiet_cmd_mkspec =3D GEN     $@
       cmd_mkspec =3D $(srctree)/scripts/package/mkspec $@
=20
@@ -71,7 +73,8 @@ rpm-pkg srcrpm-pkg binrpm-pkg: rpmbuild/SPECS/kernel.spec
 =09+$(strip rpmbuild -b$(build-type) rpmbuild/SPECS/kernel.spec \
 =09--define=3D'_topdir $(abspath rpmbuild)' \
 =09$(if $(filter a b, $(build-type)), \
-=09=09--target $(UTS_MACHINE)-linux --build-in-place --noprep --define=3D'=
_smp_mflags %{nil}' \
+=09=09--target $(UTS_MACHINE)-linux --build-in-place --noprep \
+=09=09--define=3D'_smp_mflags %{nil}' --define=3D'with_devel $(KBUILD_RPM_=
WITH_DEVEL)' \
 =09=09$$(rpm -q rpm >/dev/null 2>&1 || echo --nodeps)) \
 =09$(RPMOPTS))
=20
--=20
2.42.0



