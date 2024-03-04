Return-Path: <linux-kernel+bounces-90043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8BD86F942
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507582810B6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9C06138;
	Mon,  4 Mar 2024 04:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MDn5p9VB"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A676D17F3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 04:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709527030; cv=none; b=ee/+aWErOG3kwEPp46z8x0kLuQXLNltQTU3vwdgWApKwk86PeBAf9NQbwG0E4BBXzUCY6VmpvcW0EgwVg5YNOXPYEQsq/mBdfaBHxnndWEZsS+MHoo7UiJQyk0Zs2lOxE+SrNyW1FDTYMBcDmUnXPAtaDMIElyyf2oNQUkd/ZpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709527030; c=relaxed/simple;
	bh=RQ0Re9dOygXA8q8ock0UFf+fi9aJ29xHyYDdaPMhliE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDFEUoqVfgOQzjAn/+XN3l+ZkwCCBrA4XEggs+EDiF2UE6BzmiUg2gFvljDOAPqlFJyWAgU/uLF4fNx4uzftCyYg+H+4gCkJdQJEN7R+3gzyRt/ZqxqMxa3hlE45cQn/Vb58tA2FkS9r1UOwOr0LPUyRtgG4VeBWu/4kyK6Ep+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MDn5p9VB; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512f54fc2dbso3263952e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 20:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709527027; x=1710131827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTOlq64wIgshTpM8C3f1ldjOD6bahRq8iEfxnNSHr8U=;
        b=MDn5p9VBqYS9V0xP4Eai/DAG9/eAtQaA1jxqTkSL7MMWpGJL5FwVPys55qh21W/ECY
         X/7VK7jvrXsEfknspP9j1gvYhnP3F5Fe5XymhagAFDAlBUjpkMFTj5jI5LmQZvfPefoo
         nVtSQIhYbrrg/uZT9o9GIlpKp1qLjB0FuAPPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709527027; x=1710131827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTOlq64wIgshTpM8C3f1ldjOD6bahRq8iEfxnNSHr8U=;
        b=ZHUaGDSYU9RNiFCyY6N4Cpi9wiNUmqiRgzrjlfLICLqbaIg3DecgBTrDxBcsY5S5vb
         40cnlMA6+ScwsSX4i+LTH37Jbn5eY+hyyGTBYd2NgrON2Z8PBSmzs4qqBO5TUcXWwy83
         LCIfxJ6MF3t+2HnDj7ZtG+uGNqZVoqg11mMmD72qvgUKwYNIugHyHX8rna2YSYqevcf5
         jO8DRK8pYBXePNY+pkiKuhlJI9+z2C4bh1+NkJZhs542HfjH98vpzSfsXCGc2l+8UU5S
         8R1XG3uSymBBzJT8dln6Z+EvgNMA1JoCKgT7h/imM1ziLRfkDahx/tCz6kZX6X/XGte1
         Jrtg==
X-Forwarded-Encrypted: i=1; AJvYcCXbQcQtNcSZRQbDM7jmrvkbyup2DHP//5kBNpFDQhAhKjydKM/bOI8shk75ojU4t9CjzUi5XPG6eGZqyRSYhTDhWJymbGzxXaRUpeu+
X-Gm-Message-State: AOJu0YwBy57wO8M+2BifhaOARHzq4/BE83fQ14Z0JJ0/0OisROCSwLG+
	WJ1oghOS5WbFCivL/N/Bb9E3hwBwa+j94uHRuozJ7yk69QXcyabiCWi9BP2ocxFESULeKPFZ3wB
	YxyhWyo30gm+aZdbOVraIB5C4qxRkEKzDl4a1Lqn2kFvIYwYfwQ==
X-Google-Smtp-Source: AGHT+IGaLqAJnfP7I301yVrk8e4LcZH5fmAVqWQXo/UiRkrdFbGRFLVTfN2Qq3NAP0AjApVqTbRD03JjIdQ9nmSMeTU=
X-Received: by 2002:a05:6512:201a:b0:511:9008:7266 with SMTP id
 a26-20020a056512201a00b0051190087266mr4757627lfb.6.1709527026727; Sun, 03 Mar
 2024 20:37:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223092338.2433632-1-wenst@chromium.org> <CAK7LNAQmvyftnFJaByyjH+f4nxcNUKpjkDXwebEH5AhMF6U0Kw@mail.gmail.com>
 <CAGXv+5GmkZdqpNZDFN4dcTyZ-qVS0TjrrqBrBAei6DP+eXLnJg@mail.gmail.com> <CAK7LNAS8tLuHYcPTb5pJZixn5Hb0yjo0nmbrfSUr5Cd_pc+WMg@mail.gmail.com>
In-Reply-To: <CAK7LNAS8tLuHYcPTb5pJZixn5Hb0yjo0nmbrfSUr5Cd_pc+WMg@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 4 Mar 2024 12:36:55 +0800
Message-ID: <CAGXv+5HB7gXJ0x1uVdgbWaRWS8+rN6FwEgyGLObxr_cfyLty6A@mail.gmail.com>
Subject: Re: [PATCH RFC] kbuild: create a list of all built DTB files
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 11:35=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> On Thu, Feb 29, 2024 at 11:38=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org=
> wrote:
> >
> > On Sun, Feb 25, 2024 at 4:21=E2=80=AFPM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > >
> > > On Fri, Feb 23, 2024 at 6:23=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.=
org> wrote:
> > > >
> > > > It is useful to have a list of all composite *.dtb files, along wit=
h
> > > > their individual components, generated from the current build.
> > > >
> > > > With this commit, 'make dtbs' creates arch/*/boot/dts/dtbs-componen=
ts,
> > > > which lists the composite dtb files created in the current build. I=
t
> > > > maintains the order of the dtb-y additions in Makefiles although th=
e
> > > > order is not important for DTBs.
> > > >
> > > > This compliments the list of all *.dtb and *.dtbo files in dtbs-lis=
t,
> > > > which only includes the files directly added to dtb-y.
> > > >
> > > > For example, consider this case:
> > > >
> > > >     foo-dtbs :=3D foo_base.dtb foo_overlay.dtbo
> > > >     dtb-y :=3D bar.dtb foo.dtb
> > > >
> > > > In this example, the new list will include foo.dtb with foo_base.dt=
b and
> > > > foo_overlay.dtbo on the same line, but not bar.dtb.
> > > >
> > > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > > ---
> > > > Hi,
> > > >
> > > > I hacked up this new thing to list out the individual components of=
 each
> > > > composite dtb. I think this information would be useful for FIT ima=
ge
> > > > generation or other toolchains to consume. For example, instead of
> > > > including each dtb, a toolchain could realize that some are put tog=
ether
> > > > using others, and if the bootloader supports it, put together comma=
nds
> > > > to reassemble the end result from the original parts.
> > > >
> > > > This is based on and complements Masahiro-san's recent dtbs-list wo=
rk.
> > >
> > >
> > >
> > > This is another format of my previous per-dtb "*.dtlst"
> > > (but I did not pick up 3/4, 4/4 because I did not know what we need a=
fter all).
> > >
> > > This should be discussed together with how Simon's script will look l=
ike.
> > >
> > > I can understand your Makefile code, but I still do not know
> > > how the entire overlay stuff will work in a big picture.
> >
> > How would you like to proceed? I can through together some changes on t=
op
> > of Simon's patches as an initial proposal if that helps?
> >
> > I can use your format if you prefer.
>
>
> How would you select base+addonX among
> other base+addonY or base+addonZ configurations?

I assume you are alluding to the existing in-tree composite DTs that
share the same board compatible strings?

Under the current FIT image design with compatible strings populated from
the FDTs, I don't think there's any way to automatically select among them.
The FIT image simply does not have the information available. Nor do the
overlays themselves. The toolchain can only either include all of them
and let the bootloader figure things out, or filter out all the duplicates.
With the composite list, at least it will be able to consistently keep
only the base DT and drop the ones with the addons.

In one of my previous replies to v9 I mentioned adding a user provided
mapping between "configuration" compatible string and FDT filename. The
mapping could be maintained in-tree for those base+addonXYZ FDTs if
desired.

Also, Simon's FIT image "extensions" proposal [1] adds more metadata to
the FIT image to cover these addons that currently don't have distinct
compatible strings.


ChenYu

[1] https://lore.kernel.org/u-boot/CAPnjgZ06s64C2ux1rABNAnMv3q4W++sjhNGCO_u=
PMH_9sTF7Mw@mail.gmail.com/

