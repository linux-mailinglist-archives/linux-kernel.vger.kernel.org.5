Return-Path: <linux-kernel+bounces-5600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F7B818CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF581C2140E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B615A20DE7;
	Tue, 19 Dec 2023 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guAAzcAz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E552C23769;
	Tue, 19 Dec 2023 16:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8369C433C7;
	Tue, 19 Dec 2023 16:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703004589;
	bh=R4UK43hZlwabAzzEBuvlrt8StIK7OiOPqq5J59SVXhs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=guAAzcAzwt3lyO3MlGj8pUpuMNSJHEcAwMNE3V34NOkp2QHOIkD+/Td9E6Rk9MdL5
	 x0x65A3tVJ9XFPP8tzWyPyOTbBVSEbtVIHgXX38PXbuIEDu+LjDOdEXDpNLlfftkdm
	 6b5SVkmA+Cod18DxDykF4HJyKkCKIqp0MKo0ZHjb4ZETdFlXjgcQ52wtReUQEbMJoQ
	 S8NeJg75jcSmzCo2YopfmTP2zkGMYGyK3r0Y+f4CwEwpmgjJ4aGFt0v80nm0sqo01G
	 uFGW+zX7iAuOETcoCGeDFP3Ht0MqqQmiSlft85auD0VqhXzVibLirDZXlx95aIV262
	 RE6fTHk2HMAWw==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-20335dcec64so3194180fac.3;
        Tue, 19 Dec 2023 08:49:49 -0800 (PST)
X-Gm-Message-State: AOJu0YzqWWGVbWJXWJRiIihssoh6HEd5xFcsE7i+a1Q3O+3v7juZ/Q3D
	lbqhNapAVUMi/eLoLSrpyHPc25oO/y6idqODYx4=
X-Google-Smtp-Source: AGHT+IEWhtbbGW2BVJtAybpYwxfOzJcvIfYfBcmKnkMkewuOuXlu5bMduy3fh4kxvistnBA5hrCUUPH8OX7WJ4CsRlg=
X-Received: by 2002:a05:6870:a40d:b0:1fb:75a:6d45 with SMTP id
 m13-20020a056870a40d00b001fb075a6d45mr23293575oal.108.1703004589143; Tue, 19
 Dec 2023 08:49:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNATu-4TSSWpyFyVQYrkS++fUQbfp2tVjEpf3oZBV8ihq8w@mail.gmail.com>
 <20231219155659.1591792-1-jtornosm@redhat.com>
In-Reply-To: <20231219155659.1591792-1-jtornosm@redhat.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 20 Dec 2023 01:49:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNASf7cOiWpcMsycVSBOg4Xp-dmUnAvGqdw5wAYR=KBzdig@mail.gmail.com>
Message-ID: <CAK7LNASf7cOiWpcMsycVSBOg4Xp-dmUnAvGqdw5wAYR=KBzdig@mail.gmail.com>
Subject: Re: [PATCH v3] rpm-pkg: simplify installkernel %post
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: dcavalca@meta.com, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nathan@kernel.org, ndesaulniers@google.com, 
	nicolas@fjasle.eu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 12:57=E2=80=AFAM Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> The new installkernel application that is now included in systemd-udev
> package allows installation although destination files are already presen=
t
> in the boot directory of the kernel package, but is failing with the
> implemented workaround for the old installkernel application from grubby
> package.
>
> For the new installkernel application, as Davide says:
> <<The %post currently does a shuffling dance before calling installkernel=
.
> This isn't actually necessary afaict, and the current implementation
> ends up triggering downstream issues such as
> https://github.com/systemd/systemd/issues/29568
> This commit simplifies the logic to remove the shuffling. For reference,
> the original logic was added in commit 3c9c7a14b627("rpm-pkg: add %post
> section to create initramfs and grub hooks").>>
>
> But we need to keep the old behavior as well, because the old installkern=
el
> application from grubby package, does not allow this simplification and
> we need to be backward compatible to avoid issues with the different
> packages.
>
> Mimic Fedora shipping process and store vmlinuz, config amd System.map
> in the module directory instead of the boot directory. In this way, we wi=
ll
> avoid the commented problem for all the cases, because the new destinatio=
n
> files are not going to exist in the boot directory of the kernel package.
>
> Replace installkernel tool with kernel-install tool, because the latter i=
s
> more complete. Suitable manual actions are added as a default if tool is =
not
> present (unusual).
>
> Special installation case for discontinued architecture ia64 has been
> removed.


This code does not exist any more.

A patch applicable to linux-kbuild would be appreciated.





--=20
Best Regards
Masahiro Yamada

