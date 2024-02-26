Return-Path: <linux-kernel+bounces-81498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9F98676BC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414BC1F23F22
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECA71292C0;
	Mon, 26 Feb 2024 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dG97OFSY"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF66C7FBAA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954655; cv=none; b=hTpK6Dz2VIbzwxHBlMz58ef8bMw1XsL4VL5D0xvPjcukCANhBkEKTvuybwLs1/4UeDP6RawJQKEqelz72cEiFHWoQrFdaaaW61WVvB5BobwFnFvceG9kvjZOt4p9aR2bAEcAKrj+VAAh2bXcubF5e9vcNOYNeQMwI+xmEn8EKtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954655; c=relaxed/simple;
	bh=QdEwI9QlMgL01Ffi2DaCcAkgo345YjCp2wxa14Lk+NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AV1Dcur/LHbNs2HJAYpv0rdXJnGC/08RzKuWqtT0Bar+p0g3F6aQ5ixVhzty/1UD1r+4LZcXIiKs5t0nH1p18DBV5cttT8P0GEL1H83gchf4ffCWSMaGvt7zRej9XAujOMwqHUHhJOd67NJKG33duDF0tE+ST7xv1Ch4CiTKR4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dG97OFSY; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4ccfb94ee5cso302349e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 05:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708954652; x=1709559452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVBescN1cuFlk0Nm2k2RUQXFNz8C6uStbKpoBsdlsAw=;
        b=dG97OFSYAM5gOF68+MxVRAAlNhVVRx6sajFXM7Szyot9RYRDul8fXmRV56Zar9t3T0
         yvDcOXer5iWqGjr/HR7rnR6aiA7XY+q9mqOouKWji86obG0hBYI8MUQJUHJeuIaTUYgp
         6k+Knk8jTeGMwN9AmPZv8+L5FjnRsnjyljIrpfp1Yf0Z0WT9BJvt+afXWEQ4yxdNcvfN
         4eBDlDpsujhphz674nw+ml/v1aZHDbqCFA1rtt7cSJmfDAm/Y2jw+82sNgoZd+EuAPkd
         674Df78nsf9fSImrGN5kERJ2BdyHKUVDAWXk7VCExJ21QEpC+oSXRZavm/2vr2igVS8X
         3xPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708954652; x=1709559452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVBescN1cuFlk0Nm2k2RUQXFNz8C6uStbKpoBsdlsAw=;
        b=NVzfBshnLliNVqLvevdkHashQXeEsWGDHc5mwt9pPpyDWBvWM1qH60FCLWKH2pX5p7
         Oz6zIqyI+JC3cDH/hy3ZKrzAIdzWUdyeCCmnlydsdlGJ3UK+zl7J37Bt4qfq3dHCepd/
         b+nMTrOPSJz0R0uYZv1AwksVNaEIHUTFnLynBNMyI6WJEScKfcRBHjtQdkh/JPJOXZe6
         5APcu0z9RvdZBAGqk98eJJo3RpDOmGdP+4lKqVAu0SVXkjr/3iDsGrreE3Y1WRlmRaPb
         vRWoiLcZXeOvYVmO7WPtnplPro6ZTiaek1Lfe+bhZwam0hg94oV/nDn2aoCE9WTRvvdt
         /chQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwUBeg0ycn9tyC7pA3MVqOCy0yBsyCR4WszkLZChdVQqkRzavy7eJ8ysKNrLzs1ctv6pTPNwuldZtFHwCCrtRpzM0ZZh5VVcMQh3NR
X-Gm-Message-State: AOJu0YzswG771Wh4qiNUKjh3STM/O1Iam0W3rry5S6bFCaC2OzlmzeBq
	2/fWXQ7u5BSX7C6B3XLKSU8efRajH2U2ZqazZISMsF/u0SplmpKLjxqutWWfMhn+cNKxNRh1qYR
	BjJWz1cVlAvfpjbAVbFk+SyX5pVQnwb3A3QjtHnhIbKADTRE4bpM=
X-Google-Smtp-Source: AGHT+IEfn2RuqdpoU1z0tZbiuMJyTRGgX8/XzY8xA4xhr9R9WWQS7s+vHLTBQjEQ7TNvZhNKDomanMyhV93RZKd81I4=
X-Received: by 2002:a1f:dd81:0:b0:4cf:19c3:c1cb with SMTP id
 u123-20020a1fdd81000000b004cf19c3c1cbmr3104603vkg.12.1708954651109; Mon, 26
 Feb 2024 05:37:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226174117.722301b9@canb.auug.org.au> <CAMRc=MctN=PqM6O3GxvcFuk2ZT2YcqTiKZiuCiaTnXDEV+gXaw@mail.gmail.com>
 <20240226110424.GA120668@google.com>
In-Reply-To: <20240226110424.GA120668@google.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 26 Feb 2024 14:37:20 +0100
Message-ID: <CAMRc=Md3pfEWcMSoVjdj7_o9MJQUShfKL6=XyWVm3MqEWKFX9Q@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the gpio-brgl tree
To: Lee Jones <lee@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 12:04=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Mon, 26 Feb 2024, Bartosz Golaszewski wrote:
>
> > On Mon, Feb 26, 2024 at 7:41=E2=80=AFAM Stephen Rothwell <sfr@canb.auug=
org.au> wrote:
> > >
> > > Hi all,
> > >
> > > The following commit is also in the mfd tree as A different commit
> > > (but the same patch):
> > >
> > >   4a7b0850fc7a ("dt-bindings: cros-ec: Add properties for GPIO contro=
ller")
> > >
> > > This is commit
> > >
> > >   7b79740d42e7 ("dt-bindings: mfd: cros-ec: Add properties for GPIO c=
ontroller")
> > >
> > > in the mfd tree.
> > >
> > > --
> > > Cheers,
> > > Stephen Rothwell
> >
> > Hi Stephen, Lee!
> >
> > I picked it up because I was already queuing the patch adding the GPIO
> > driver. Unless there are conflicts with the MFD branch (doesn't seem
> > like it?), I think it should go through the GPIO branch together with
> > the driver.
>
> This is the first I've heard of it.  There was no reply from you, even
> after I specifically asked you for an explanation.
>

Huh, I now see your email in lore[1] but I don't have it in my inbox,
not even in spam. I would have answered otherwise.

> There is no convincing reason for this to follow the C change.  It's
> more important to avoid Linus from facing merge-conflicts during the
> merge-window. Please remove the patch from your tree.
>

This is why I'm asking if this caused a conflict. Whatever, I'll drop
it alright.

Bartosz

> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

[1] https://lore.kernel.org/lkml/20240223102039.GK10170@google.com/

