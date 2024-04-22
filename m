Return-Path: <linux-kernel+bounces-152683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D138AC2C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 04:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06121F21570
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 02:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F3A522A;
	Mon, 22 Apr 2024 02:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoQgb5Xu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38A62CA8;
	Mon, 22 Apr 2024 02:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713752893; cv=none; b=utC0wr5sMu1kROyaTOrraqPggfnx4ZeE5BCc/2I2z1hz6ZGfBHaY1ZESWA9StEFuxLhZaw2+EJ2kBUTJjx6zcam93jqKWJ02HWSXfUkzqt49b4kBcyLlA36dR3d2l6CHz+bkXfR3OfM0FfpalWBoPGz5V1eVOBekgk6SMCqE+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713752893; c=relaxed/simple;
	bh=V3J+dZjlVRVuGxpt2BvlNuZeDPKEzUoaUQImwYXDqb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOq2fKelyqsUR2881BsCfMpikDQNHnGgn01Kn/1qJvRP7RgKEQ+sMhKFlc7mN9cSlhwe7q8m6WkVdUwbF+cVT0RAkgIMyYZlE+tQ0PDyBoJn4DwHJNqhDxpStj3+nM4ahD94ayJOryOpXYuiDy1CkD9etkE8A8Wq04i2ltwhQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoQgb5Xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C568C2BD10;
	Mon, 22 Apr 2024 02:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713752892;
	bh=V3J+dZjlVRVuGxpt2BvlNuZeDPKEzUoaUQImwYXDqb8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SoQgb5Xu/qAftX+fnAmiPRfxmFjkyjj1xmYMTH+XKeq95hWU9Ylan/z4THnbpM7pR
	 BprPPWafl18P8xQBF9xfsD500AkDkVqdu+nI8bFp4L243Xf5Sp5fH7JWLFiByqCDWg
	 tlR/Es5nOni6kVI+4SwtzNZY/A8esPO8iAT7gAgU5OAf/xzc694gNYWiDQ1XoAkKF9
	 WDA7zyvkgI4Paqu4gE6Ba+XMNv3sRXH9INkbTk970sXkUaJ3j7/jb5NpU8fXx+NLcw
	 P8PGAFzUL8FsefnkZlNnTTEsW14dVpNo90TxCKX3UsKwLO2Ag8nOV8+VOk8oDHaswn
	 Q53qrmf3KHWMA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2db101c11feso24300221fa.0;
        Sun, 21 Apr 2024 19:28:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXxohJ6ZAx2K4tnead/dvx9nTdXoHvdAGIpFc4W5BaNn0y3A+56tWgTEZ0WlecBrAppUZ/5Z/JaFjEI/Yw+d6iFWFmPV8wmR1cwguO0C2GsM2IkJgupkNJXXAU9iCRpJ4GHEXh2Jk=
X-Gm-Message-State: AOJu0YxsLtRpUrWCHmpwvYGXhtKzrmkwA19fr2C2hay26k90lZAIP64D
	WY/vxIsjLShJBboT+yZ06wqXo6Ykz1sZqwYs9scKz9/ccQq7MxGf09Ow2G0dnGrWcnotqkCrwuN
	w6kd/SvhikY4A/qTg7b4nSjHGIUk=
X-Google-Smtp-Source: AGHT+IFrV9OmRbRKvaOhpQhnQ7DlGsG8CgkAy1ZsedVEVvDGIv820SOXLEXBhWXMrKJNg1NMjYlLu7xEdI7V8C/X7s8=
X-Received: by 2002:a2e:9cd7:0:b0:2d8:79d6:454d with SMTP id
 g23-20020a2e9cd7000000b002d879d6454dmr2853128ljj.23.1713752891086; Sun, 21
 Apr 2024 19:28:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240421120824.2713923-1-masahiroy@kernel.org>
 <20240421120824.2713923-2-masahiroy@kernel.org> <80d969b70038f5c0de6f2d912cb1f6b395eea94a.camel@physik.fu-berlin.de>
In-Reply-To: <80d969b70038f5c0de6f2d912cb1f6b395eea94a.camel@physik.fu-berlin.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 22 Apr 2024 11:27:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNASyu9=7MQ0zd8doGEENN7GHxupg+fkpK3FCktyjVwLfjw@mail.gmail.com>
Message-ID: <CAK7LNASyu9=7MQ0zd8doGEENN7GHxupg+fkpK3FCktyjVwLfjw@mail.gmail.com>
Subject: Re: [PATCH 1/2] sh: convert the last use of 'optional' property in Kconfig
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 2:51=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Masahiro,
>
> On Sun, 2024-04-21 at 21:08 +0900, Masahiro Yamada wrote:
> > The 'choice' statement is primarily used to exclusively select one
> > option, but the 'optional' property allows all entries to be disabled.
> >
> > This feature is only used in arch/sh/Kconfig because the equivalent
> > outcome can be achieved by inserting one more entry as a place-holder.
> > This approach is commonly used, for example, LTO_NONE, DEBUG_INFO_NONE,
> > INITRAMFS_COMPRESSION_NONE, etc.
> >
> > The 'optional' property support will be removed from Kconfig.
> >
> > This commit converts the last user.
> >
> > Note:
> >  The 'default CMDLINE_OVERWRITE' statement does not work as intended
> >  in combination with 'optional'. If neither CONFIG_CMDLINE_OVERWRITE
> >  nor CONFIG_CMD_EXTEND is specified in a defconfig file, both of them
> >  are disabled. This is a bug. To maintain the current behavior, I
> >  added CONFIG_CMD_NO_MODIFY=3Dy to those defconfig files.
>          ^^^^^^^^^^^^^^^^^^^^^^
>      This would be CMDLINE_NO_MODIFY as used in the actual Kconfig files.
>
> I am fine with the change per se, but could you rename CMDLINE_NO_MODIFY =
to
> CMDLINE_FROM_BOOTLOADER as it's used on the other architectures such as a=
rm
> and powerpc, preferably using the same help text.



OK, but the sh behavior is different from
early_init_dt_scan_chosen().


I will drop this part:
"If the boot loader doesn't provide any, the default
kernel command string provided in CMDLINE will be used."




config CMDLINE_FROM_BOOTLOADER
       bool "Use bootloader kernel arguments"
       help
         Uses the command-line options passed by the boot loader.







>
> Also, I usually prefer the first word in the subject to be capitalized, i=
e..
>
>         sh: Convert the last use of 'optional' property in Kconfig
>
> Thanks,
> Adrian
>
> --
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
>


--=20
Best Regards
Masahiro Yamada

