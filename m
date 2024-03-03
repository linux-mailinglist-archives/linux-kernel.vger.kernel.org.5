Return-Path: <linux-kernel+bounces-89682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F03A86F41C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 09:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CBF1F21BBB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 08:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BDFB676;
	Sun,  3 Mar 2024 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNA73hkW"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EF6AD58
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709455693; cv=none; b=u0ItwICzh5/kJHY578dI+Ve85lRRYhDggN6d87dlfAqf+YvjxF8llmafTp/uBjhsPtt6f2drDL0lHRz7OKK01AiGShiN4Emfa75YBRQroA9RgJZasf6NFhkvPOquqqA+FLPjRQ0muTPJNZ6lCCEUQ/p8Nkwg2G8rqOsLB2lAwwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709455693; c=relaxed/simple;
	bh=kLYaTjP5R2oq1R/5Twd/mx9E1Qx85BwSSo78QQuvl+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WW19/4RVALwVjaL0iN4tX9S9GW6f0yu3IB/ANwVgoqGwZCyBfxP3rlXrYUveerXv8m02E2J8Cgt2Dq7PxY4GNWMXeCz1sgoRcTMaROIVAp72h+toI37lm8Hcm70rdTcTNgappB9Pk3k+B63VJqnz3EgD6Qe04hfBPwM58K+OjoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pNA73hkW; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6098b9ed2a3so12526827b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 00:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709455691; x=1710060491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLYaTjP5R2oq1R/5Twd/mx9E1Qx85BwSSo78QQuvl+8=;
        b=pNA73hkWKG5hBTFzkSQB9Rci2BFiBoAUaoOfrU5+NFg7sEqvm8W29LtG8D9YhmFZy+
         hOQdg7pRinoXHTOYfyWNbU/V4iTQoYflmMgnZJUo4kVqGbqMG1yqAOenq9STYLi2maFW
         ThmZeT1NiYfaaMK+uthM9k0ZRzVsoySAa8FauEAv/tV5m341VcsKvJ4n4ejZSG33NmKO
         BeZ5LP5pUfcbeh6smpK6u8jH1nTU1HGUj6yET6vgPhJwWImVavuf4bpYBQFLlIGBiVwu
         ZPY3pfhIW87JHtiNsJDksyb/oTCKHzOkmnVzxNZ5A3fzQ7fTzq4hyWflh3LRQtyXo6DR
         ISDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709455691; x=1710060491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLYaTjP5R2oq1R/5Twd/mx9E1Qx85BwSSo78QQuvl+8=;
        b=lBqvlas6LMsVYGI1vhy1gK8RfNrjhqkpE/+eRQ375EVuXpVbQQT3wPEbxdn+jWdtfH
         ZA8SYgIQ5PppoaU0FS2NFTNSvxO58sO5G7NNikuslZmbT4ecbuUtSitIJDZGcU6h1+yR
         31lg6XlHhQOeVZHN46AYvLsZXAolFJudCGkEDwgHZcbjHSoy+l/AtjtTafG2mw009rW6
         F6rWCYdHNW5QPd4zvUsBm1fBOiwF+Rvij7CdPIw9RawdA6nGoaWso4vUKGSF4Hyxo+eE
         vLC5+tnomyeVLsAD+YjSYjp+KvxyOcPP+dzZ75mnHd9oN9HrlVMPoKR8dFcmJsVEGHST
         HN6w==
X-Forwarded-Encrypted: i=1; AJvYcCUOYFmHRjoAdua67wSxnTvaopOrUr+YrYAt3x+zuf4j1sV/bS36QpvuODSmp0goZquTIhYAt0PDO4595qhJW5ZLI8R97wtphiSJcN0V
X-Gm-Message-State: AOJu0Yw6/DFCAdnFj4RLFfjWVib2D81TpvoPIS/eQh/3D5iblDvsIgeW
	+gH0pREdPe+stDuziW5fMLAIAgrJ8afEfxWHsq4r+CZ5o1qpPB/5bGLzsH7YpPyjqvySAXDMydR
	ivUdMj5nBDCJ9bhopDz/0i+APgLuMod8QmtfHZg==
X-Google-Smtp-Source: AGHT+IHBdRv9QfjCZh/K8ngsmlUj0sB9GmAcizj5skko5rUg2FHag7v7Vi1eEBnFSP2Nv1DpYsQn3HvCRk62lQBOy0s=
X-Received: by 2002:a81:7705:0:b0:604:9d6d:681f with SMTP id
 s5-20020a817705000000b006049d6d681fmr6160056ywc.31.1709455691305; Sun, 03 Mar
 2024 00:48:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227113426.253232-1-herve.codina@bootlin.com>
 <CAMRc=MeSMTnPUYGyJir4fc=6=Gnw_MVP9wfEKMQ6Ck33FYCrRA@mail.gmail.com>
 <CACRpkdZbGUd-u3ZcmmK1POSEq8z9J1aDhbGPAbcR6guKuEpEFQ@mail.gmail.com>
 <CAMRc=MeqiYZv3ViHRKKUsXTqG5Pc8Ev2jUcN=A4VuX3RU7dDtw@mail.gmail.com>
 <CACRpkdYWDzu+VMQOYO_Sh1NM2ei=VRC-0df4teAZjirfrTB67A@mail.gmail.com> <CAMRc=MdLmU3uezKSg2d83HSZ3wYXFx68oGshx_yJyvJToN261Q@mail.gmail.com>
In-Reply-To: <CAMRc=MdLmU3uezKSg2d83HSZ3wYXFx68oGshx_yJyvJToN261Q@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 3 Mar 2024 09:48:00 +0100
Message-ID: <CACRpkdaQ5OthgFMG+6DNy7BGi+qLMgqNMOfk+cqra37EGyEYRA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] gpio-cdev: Release IRQ used by gpio-cdev on gpio
 chip removal
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Herve Codina <herve.codina@bootlin.com>, Kent Gibson <warthog618@gmail.com>, 
	Saravana Kannan <saravanak@google.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 10:00=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
> On Fri, Mar 1, 2024 at 9:15=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:

> > The problem is that I have never heard about a user unbinding/binding
> > a driver from sysfs for anything but debugging a drivers ability to
> > bind/unbind. Partly I feel that thing should just be moved
> > to debugfs given the usecase and because it just looks like a way for
> > attackers to provoke crashes given how some drivers look.
>
> That's not the only thing - device unbind can also be triggered by
> removing the module providing the driver which is a completely normal
> operation for user-space.

That is one thing, but every time I hear about "have you thought about
users going in and using bind/unbind in sysfs" it's for builtin bool
drivers.

I almost feel like bool drivers should have bind/unbind disabled by
default :/

The introduction of deferred probe has made the situation much better
because it tends to exercise the bind/unbind path a bit.

Yours,
Linus Walleij

