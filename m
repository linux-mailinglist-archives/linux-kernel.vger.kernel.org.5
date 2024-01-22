Return-Path: <linux-kernel+bounces-33117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9AF8364E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8A71C2251A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5D73D0DB;
	Mon, 22 Jan 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UIa+VbU1"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC68A3D38C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931847; cv=none; b=SBYhgY9P8pkPCHV8j7rMJdxVlrgvHwKfxA6+hmvCBpzkyvCpMCg8i6TtXz9b7+gTt5+9RxRMDnffvUqTT9OM8iQIemNX9BDgqvV6eb/R9pYMtqrG8ldoOchWHPhzi/GDuVpmdNdztzIK9PScyQ1Z3t8bJvEWbuU6iShp+erVx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931847; c=relaxed/simple;
	bh=nnowXkzWgF0Pq5XJ2qngf9wrDF2pzAyVfo5CQNtWqpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F66qDeY/3jZUPyliE6HR7L811PrcysFYe6woko/WjotgCxRHOqZ4qbxJDOfSK5UW+aQGZmvhAhF/wjttNV64WCKcL7SZoemaqgnWsgbvMfdwGikqnZKAY/XtGmNJNTNt7D3D+POGLESD1OBvqQnbgtyG8egHkZu/TKR6B1bks8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UIa+VbU1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a354a65afso2759405a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 05:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705931843; x=1706536643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnowXkzWgF0Pq5XJ2qngf9wrDF2pzAyVfo5CQNtWqpY=;
        b=UIa+VbU1dpIKItcBdAtWkheLNPGbhEs2n37nMi7ERKLjc5ln8AotbDT6fW/DcuilFh
         H/8KaVHhBJf6ZX0Vm3ZQfiWfdgv98sYeNtAUVq63APWTXbUYOb83w2JRSFqr9MLptesr
         qq8hS/oJrr5xG7kZ58RjN/bTwzWEzvnBJQIa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931843; x=1706536643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnowXkzWgF0Pq5XJ2qngf9wrDF2pzAyVfo5CQNtWqpY=;
        b=a5s3gxCY0zY7NjeU/FsKPFYkfR90rK2ssgwRm1S3EZBcMA3A0lWqGsAfs6nRJkGRrN
         x/OlMP+dL9trE2asWKbgPO422Vc16DIvq98hg3Q0QJPk3bgpUTAHMbawpe13tvM1Im7e
         lypSaCnsbzRzMJ2GEKNzMFszFmmMzOTyTpdZSEvf8qD3j0udn+irh09IVCH2Jaxpg0k9
         +kEzs/XWjKKhmF3vkW3YHN3zR/Je7XD19z2YOpGPwZYDkVVpUFbjNeZ5s6bEasCHPLXr
         stTre1o5XfKsL841btiBb1/F1Bo88sbPGPtTHCDiv7y/J/PzG8tMh3Er0iwVoEgEOzTk
         L3+Q==
X-Gm-Message-State: AOJu0YxvVKtRzO/v6JVJ9u+bD/YyAcAluMVIavuvW6If3d1HT8M+Fg5i
	Y4dwv8ffyUGR2MGkeAjNejWV1b709aHL33LrRRrcnF5Y69zMrBZCUgJQu9Kb1LBGLcpe1y663Qx
	A/d4p
X-Google-Smtp-Source: AGHT+IFFMBEeIR8c4KROW5trgnaNzz9tlFtCvDY87hNWH+aq9KZEIVSRDAZj/V8tFM+EzCKt8IWl2g==
X-Received: by 2002:a05:6402:6c4:b0:559:7dd9:a5b2 with SMTP id n4-20020a05640206c400b005597dd9a5b2mr2090533edy.16.1705931843136;
        Mon, 22 Jan 2024 05:57:23 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id da12-20020a056402176c00b00559f653b328sm5996521edb.22.2024.01.22.05.57.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 05:57:21 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-339261a6ec2so1810122f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 05:57:21 -0800 (PST)
X-Received: by 2002:a5d:5f53:0:b0:337:c288:2595 with SMTP id
 cm19-20020a5d5f53000000b00337c2882595mr2749142wrb.78.1705931841164; Mon, 22
 Jan 2024 05:57:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017091900.801989-1-tylor_yang@himax.corp-partner.google.com>
 <6c7d9c92-7616-4fad-806e-44302c33b63c@linaro.org> <CAAFQd5AN-1FTHZcE1Eja0Jd4iqpDocZSz19F44RxqtvKs6ikeQ@mail.gmail.com>
 <5a2f292d-efdf-4647-89ce-e4f5d28c7192@linaro.org>
In-Reply-To: <5a2f292d-efdf-4647-89ce-e4f5d28c7192@linaro.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 22 Jan 2024 22:57:00 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D49SLYS8WJBFOyY7G6fPYR_scDj6aUsPbnk0jet9E_rQ@mail.gmail.com>
Message-ID: <CAAFQd5D49SLYS8WJBFOyY7G6fPYR_scDj6aUsPbnk0jet9E_rQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] HID: touchscreen: add himax hid-over-spi driver
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Tylor Yang <tylor_yang@himax.corp-partner.google.com>, 
	Doug Anderson <dianders@chromium.org>, jingyliang@chromium.org, 
	poyuan_chang@himax.corp-partner.google.com, hbarnor@chromium.org, 
	jikos@kernel.org, wuxy23@lenovo.com, conor+dt@kernel.org, luolm1@lenovo.com, 
	robh+dt@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, poyu_hung@himax.corp-partner.google.com, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	benjamin.tissoires@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 5:08=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/01/2024 05:57, Tomasz Figa wrote:
> > Hi Krzysztof,
> >
> > On Wed, Oct 18, 2023 at 2:08=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 17/10/2023 11:18, Tylor Yang wrote:
> >>> Hello,
> >>>
> >>> This patch series adds the driver for Himax HID-over-SPI touchscreen =
ICs.
> >>> This driver takes a position in [1], it intends to take advantage of =
SPI
> >>> transfer speed and HID interface.
> >>>
> >>
> >> Dear Google/Chromium folks,
> >>
> >> As a multi-billion company I am sure you can spare some small amount o=
f
> >> time/effort/money for internal review before using community for this
> >> purpose. I mean reviewing trivial issues, like coding style, or just
> >> running checkpatch. You know, the obvious things.
> >>
> >> There is no need to use expensive time of community reviewers to revie=
w
> >> very simple mistakes, the ones which we fixed in Linux kernel years ag=
o
> >> (also with automated tools). You can and you should do it, before
> >> submitting drivers for community review.
> >>
> >> Thanks in advance.
> >
> > First of all, I can understand your sentiment towards some of the
> > patches being in a very rough shape. As a community we have large
> > volumes of patches to review and it would be really helpful if new
> > contributors followed some basic simple steps, as described in our
> > "Submitting patches" page...
>
> I don't really understand why responding to something which is three
> months old.

Uh, I got the reply from Dmitry 3 days ago and didn't realize it was that o=
ld.

> Anyway, I talked with Doug on Plumbers about it so things
> are more or less clarified, however since two Google folks responded,
> let me continue.
>
> >
> > That said, it's not a fair assumption that there are no steps taken to
> > offload the upstream reviewers community by the corporate
> > contributors. We usually do have basic internal pre-reviews for
> > patches coming from partners and even a pre-review bot (CoP) that can
>
> Good to know.
>
> > automate some of the checks such as checkpatch or bisectability. But
> > as others said in this thread, we don't control our partners and they
> > are free to send the patches just directly to the mailing lists if
> > they want to do so. In a similar way, not everyone in ChromeOS is
> > super experienced with upstream submissions, so sometimes they may not
> > be aware of the best practices, etc.
> >
> > I haven't seen the patch in question, but I'd assume it's more like an
> > exception rather than a usual pattern, so I'd appreciate it if we
>
> Unfortunately that's the pattern. I was complaining few times about very
> poor quality of some patches from some partners before writing that email=
.
>
> Just to clarify: all the complains are about missing basic stuff, like
> running basic tools. They don't even require internal review by humans.
>

Hmm, that's sad then, but then also as I said, we don't control our
partners, so we can't really guarantee that every single patch goes
through some kind of internal review. Hopefully this has improved by
now and continues to improve as the tooling I mentioned gets more
widely used.

> > could avoid aggressive responses like that and try to solve the
> > problems in a more productive way. Just a simple response with a link
> > to https://www.kernel.org/doc/html/latest/process/submitting-patches.ht=
ml
> > wouldn't really cost you much, or actually even less than the entire
> > litany in this email.
>
> Simple response to docs don't work. Docs are quite long and contributors
> questioned here just don't read them in details.

If asking someone to read a doc doesn't lead to that person reading
the doc, then that's another story. My personal experience is
different, though... But well, again, we're talking about humans, so
we're going to end up with a wide range of extreme cases, regardless
of what we do.

Tbh. I (as a kernel maintainer too) would really imagine we also have
some more automated tooling for the upstream kernel workflows. I don't
see anything preventing some kind of checkpatch (or whatnot) bots,
responding to patches automatically. (Actually we're working on
something like this for the Media subsystem...)

Best regards,
Tomasz

