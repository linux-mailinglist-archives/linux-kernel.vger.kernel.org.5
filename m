Return-Path: <linux-kernel+bounces-37273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 285EE83AD97
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B4B3B28632
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031277C09E;
	Wed, 24 Jan 2024 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="pr/NzzDD"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCDD7A70B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110924; cv=none; b=GHreQc2iyz7TUyBb6/MLxJkEPdAlI3wRQCxPygurfqYhZ8fDL/695XZYEjqc0ZARC9Ep2QdOuzw6dpgW42btU1L5Lgc4535qvLTxr1j0GVKu3qkd8+jKTx3toEtwsiGBZOB+plrQLfCF5gvZamaIMuFWlTmD6OPyBwyT+ytpVF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110924; c=relaxed/simple;
	bh=zZtqPrTKuP34/jvntdipBLPLeyPhiNZKTBLPTHrVnGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QETXFzcycqywA9aHzknSf7Gt0qZ2GXeY5yJWy9Tsx+DdVicZ1u2Z/21rvnhNLJ87oEM9QC0/l308XAumr54brMoKeyWexh7G5OMnRsXRVaPpF9tV4x3VJe85QxNyfRfMWoamsizJiHER5Qgf9x/2DHdfSp368TYYEDPrg0mn8BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=pr/NzzDD; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4298b23abffso33094861cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1706110921; x=1706715721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQ6dRDElSaRcgR3iRNGH9d+ZZaHrFWZ7b3nOI9hdY9Q=;
        b=pr/NzzDDiG3Ut09/G9RCBKPHnj8WAAYTPtwECoV9TWdmyem6GuTCcZ+J5xo0ewE5kt
         UXU5A/xSJ07aw4/EaWk1aJN9kqb2t9pG+U0C0yQzQSEDA1CsAp0R36zzFKBbvp2Nwdmt
         uR7lNIABmXWkzIGIoXzxzlsLDGwiWeSLUPVu7RHshm5MhV8kr4xgLI5WDN1hoeBPhnIh
         sLhBhZXzy2zklNlqY3lzismmCdEK+SXsnhR6qJuIZZYbowcIAOXNUsHcFuB3qjNjFjbM
         QWV5Nf+8Yj83g0auoXUsF6+YcEqlcEvBRAMpo21Bn9Tv/ZXkQq7Mljxvi9hglZSNkWhr
         uYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706110921; x=1706715721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQ6dRDElSaRcgR3iRNGH9d+ZZaHrFWZ7b3nOI9hdY9Q=;
        b=jabaFnKX7ylePZzj7/CmmGrFOk9SD5o9nDvoQytzsDIjJK7wZ2q1NtQjMNlm8bD8z9
         4a41XLhsesUvExqk+2DKULVkS57DL5MiwBxl4y+Nqfb0LmJAXRmxM9i3vEqOzpVCxRpN
         a53QCyw1sNbTEiK91Lz6BVuh2ft+37v+CBcAh6cZf+2tj2Crv3hqO7aYvXSX9mt85m3v
         2A5Rb6haxIMd+g2EuTVnwfp94qlxE/X9gSXIV83B0NcX/oG2odRNGBAXlbFHlQ7/8X44
         KnF1prMHDRYODo3CHMXF8y/7govr3aVdbn5YL0GECOJ1Y1zE0OZpxUO0nY/KJrDCnaVG
         cd6w==
X-Gm-Message-State: AOJu0Yz9Z3uEYPy632z9NcooIez1HuTq1sDXb45ceEJM+HoSwbyomNyu
	XYt9J+13Zamj2VyBbBrdAqOTL2s4f2VgPhDykpydEQXqhlHNNeTf85A6vrlqkRZRzwPN1uOaIyO
	bBrzYadpAw3iupEF9GEtwAL3o3n1Xu5Vcg+UV
X-Google-Smtp-Source: AGHT+IHfd9mDrWK8flOo3lERVCzYlymsCptpYdK7FSX4w9QUsOdflSyDmlcKJXQOcSC32czQhAeQI0zbMdz6Hltorzc=
X-Received: by 2002:ac8:590d:0:b0:42a:4509:ce74 with SMTP id
 13-20020ac8590d000000b0042a4509ce74mr2965908qty.9.1706110921408; Wed, 24 Jan
 2024 07:42:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124130101.428c09a3@canb.auug.org.au>
In-Reply-To: <20240124130101.428c09a3@canb.auug.org.au>
From: Mike Marshall <hubcap@omnibond.com>
Date: Wed, 24 Jan 2024 10:41:50 -0500
Message-ID: <CAOg9mSQ0GBrRbBWtcNad1vSU+H5vZq6akcCQVDnUS-iw9yWGFg@mail.gmail.com>
Subject: Re: linux-next: trees being removed
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Hector Martin <marcan@marcan.st>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Jean Delvare <jdelvare@suse.de>, 
	Lee Jones <lee@kernel.org>, Micah Morton <mortonm@chromium.org>, Pavel Machek <pavel@ucw.cz>, 
	"Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We are active with Orangefs, both on the userspace
side and in the kernel... I might only run xfstests to
make sure we're not regressing as kernel code
changes through numerous development cycles,
but we do intend to continue contributing in the
future...

-Mike

On Tue, Jan 23, 2024 at 9:01=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
>
> The following trees are going to be removed from linux-next because they
> have not been updated in more than a year.  If you want a tree restored,
> just let me know (and update its branch).
>
> Tree                    Last commit date
>   URL
>   commits (if any)
> -----------------------------------------
> asahi-soc-fixes         2022-08-14 15:50:18 -0700
>   https://github.com/AsahiLinux/linux.git#asahi-soc/fixes
> backlight-fixes         2023-01-01 13:53:16 -0800
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git#for-bac=
klight-fixes
> broadcom-fixes          2022-10-16 15:36:24 -0700
>   https://github.com/Broadcom/stblinux.git#fixes
> dmi                     2022-09-23 14:53:14 +0200
>   git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git#dmi-=
for-next
> leds                    2022-12-25 13:41:39 -0800
>   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git#for-=
next
> mfd-fixes               2023-01-01 13:53:16 -0800
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git#for-mfd-fixes
> orangefs                2022-12-07 15:18:30 -0500
>   git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux#for-next
> random                  2023-01-04 12:11:29 -0800
>   git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git#master
> safesetid               2022-07-15 18:24:42 +0000
>   https://github.com/micah-morton/linux.git#safesetid-next
> sparc                   2022-09-30 11:58:23 +0100
>   git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git#master
>   2d2b17d08bfc ("sparc: Unbreak the build")
>   (This commit has been included in Linus' tree as part of another commit=
)
> userns                  2022-11-30 12:54:24 -0600
>   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.g=
it#for-next
>   54e1011bd95a ("sysctl: Allow change system v ipc sysctls inside ipc nam=
espace")
>   f9b90c2062b2 ("docs: Add information about ipc sysctls limitations")
>   7608b6a72ed0 ("sysctl: Allow to change limits for posix messages queues=
")
>   a799be9bafe3 ("ipc/ipc_sysctl: Add missing include of linux/cred.h")
>   b895e6689ebf ("sysctl: Fix mq permission check")
>   295227b10192 ("ucount: Fix atomic_long_inc_below argument type")
>   b4b11b58cd02 ("ucount: Use atomic_long_try_cmpxchg in atomic_long_inc_b=
elow")
>   (only these last 2 commits actually change anything in Linus' tree)
>
> --
> Cheers,
> Stephen Rothwell

