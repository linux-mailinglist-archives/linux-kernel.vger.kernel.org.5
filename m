Return-Path: <linux-kernel+bounces-83256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474E88690E2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E1328AA63
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AFF13A865;
	Tue, 27 Feb 2024 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1gxsZik"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB3E1EB25;
	Tue, 27 Feb 2024 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038151; cv=none; b=p/Zvzy0SjBK9lGTeunEQTVuzJxDTaRawqyiZ87oF1wxaAqiS5nfK9NSekXCCCK3fkaSmiIsq/Tb1+fUOCSjL0HE4+59mkqoiawWAEiHQBg5kGteJfSyPiXV+1EEtp6Q9jC+1rifx279CIyuAiy7Xw3tUvfuQCoDOjBt61TYJ4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038151; c=relaxed/simple;
	bh=aJN2MeGDZqp0rbRYo0c9XNa6DifuaXrgMmZP4MdDAMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aEDlkZUUZcP03aCnGRKRWgEFV4cQwtnUrK1RxyYKw/EOEg+WWT9I7dKYklKGmNhRGZQldZXnhshjBg9rseJMtC+WbBBaPGI8wD40kAXyIbRXdTavusVaboG327oXs4rXoF2sx45oxFNaeS83hVTiGpxHQBFMefy6d3a4mzuJWqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1gxsZik; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso5247036a12.2;
        Tue, 27 Feb 2024 04:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709038148; x=1709642948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5p1Edl1NH7byvXQfMcSs3cZtovHa/4E/zHLUVKkoBE=;
        b=A1gxsZiklDSbTazHTe8/MLxTRxshgRAfJJ94D0vnOqIc4s5I2NOfxZFC89NVKxVdPH
         TuatXJ2pfdewvUsXN7JA7IG/dhMSZuw2fQsLQDsYET5wnHG9GAdXAzTf3l+hnuAQjYlk
         VykBIBTmwx3vfiPa/oLVSGlguS2Hl0JeBX1gekpH4GIOTv7o1yycS0SYpPLBz94i2MuV
         z3tOPjpZoY9rPfb+qMGpWPGPxxQyiJZmbkXKuVT2oR3UacNfhJgOAxWdB3JbwLCxG4mr
         kK5oA3jd6saAycLlCBcomHxCOonc8AM3ylqMNkp/pgNC0aGScruIBYz0jRVxQQM1H2Fi
         zqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709038148; x=1709642948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5p1Edl1NH7byvXQfMcSs3cZtovHa/4E/zHLUVKkoBE=;
        b=OP9Rw7GkOmyTcSPWsmNxZXRF3KGumBejjX90Lv+Gh9mCOC3a1BuDIsbQSXGWQw9Smc
         mbgr3Q/a04yFoE5ozhaT3BWEz/FHHOXVgawicTVQoec1njxTTI1Ho1VKNzNLeXU+g2Kc
         EVzQRK4i9eLCqDD1yIe8jF8LY8Xn6sAOSQuQFwRHbj+1/PH8yHkA28KKLRu/FXHIpNb/
         i9708YdZCyL3CtsDgKcoXc+6rw+s3uJh2N2evKiF2I7EqC2xDd5iNcwcrOgn5ejh3Paf
         ZoLxILDEg3QNbUvSgVNLHLFSK3/YxvM5w6jZyu6AyugRHM6QDZR7agYkUxY8ihtgt7Si
         6pjA==
X-Forwarded-Encrypted: i=1; AJvYcCUUfY+XoIt2FXxtc/NGV71xONCsEeJ/YakU0bn4a2dAaCXwYm+SDU33ANol6qh2XrJ14In+YqAwWv+mmJ/aFO3wHBl0deSJQWlo3CQK8Sb8ZptaeSmmTyrpu8Co9zjorLLiXHh6Km3f
X-Gm-Message-State: AOJu0Yzv1AYdH/Q8MKVZJAo/uKsi4i57qCUX4IusUoyhKFpHVyc2fwFQ
	+omdCMXD1R2aOd7D8+VAp+/El/edorBpFRMP/wSkE2e6wi58dWM9Av27VerSAY9aa73ueKwPER/
	XkOeiyNbR151W7YttBaRAVq/o5/A=
X-Google-Smtp-Source: AGHT+IFJY/Dc0FAemTrGn7dbCzMq1SVbHT1UbCSPNS1Va9TuSCF77jAwMf0Y1LLTilc0YfteM0PrAKPMqJuOxE+VeAU=
X-Received: by 2002:a17:906:7243:b0:a43:a628:ff31 with SMTP id
 n3-20020a170906724300b00a43a628ff31mr1436136ejk.26.1709038148513; Tue, 27 Feb
 2024 04:49:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223-saradcv2-chan-mask-v1-0-84b06a0f623a@theobroma-systems.com>
 <20240223-saradcv2-chan-mask-v1-3-84b06a0f623a@theobroma-systems.com>
 <CAHp75VfVTJsQDwaPoPgGiT6jnymXAR3WpETqaKai8rXAC70iLw@mail.gmail.com>
 <6f76ffab-69fe-4afb-9d7e-d3cdfe37c28c@theobroma-systems.com>
 <CAHp75Vft3kJEF9JiuEqVsS3biQ6YsuDXON_P3FOZRjtb8NaB2w@mail.gmail.com> <d2a7954926e328cbf898aac0a42a6e24@manjaro.org>
In-Reply-To: <d2a7954926e328cbf898aac0a42a6e24@manjaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 27 Feb 2024 14:48:32 +0200
Message-ID: <CAHp75VcuRacheLt=sAJz27RMEZqvZ8CAZSPvxgUbSFS-dUAAOg@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: rockchip_saradc: replace custom logic with devm_reset_control_get_optional_exclusive
To: Dragan Simic <dsimic@manjaro.org>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
	Quentin Schulz <foss+kernel@0leil.net>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Heiko Stuebner <heiko@sntech.de>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Shreeya Patel <shreeya.patel@collabora.com>, Simon Xue <xxm@rock-chips.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 10:31=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> =
wrote:
> On 2024-02-23 15:39, Andy Shevchenko wrote:
> > On Fri, Feb 23, 2024 at 3:10=E2=80=AFPM Quentin Schulz
> > <quentin.schulz@theobroma-systems.com> wrote:
> >> On 2/23/24 14:00, Andy Shevchenko wrote:

..

> >> I would still be reachable at that Cc address without having to modify
> >> the .mailmap after the fact (which won't make it to an earlier version
> >> of the kernel for example). Some maintainers don't really like this,
> >> some don't mind, we'll see in which category the IIO maintainer(s)
> >> fall
> >> in :) (I don't mind either way just to be clear).
> >
> > My point is that Cc and other similar (non-real-tags) stuff is
> > polluting commit messages. It means that this will be copied to the
> > Git index to all kernel git repositories in the world from now and
> > then, This is at bare minimum makes additional burden on git log (and
> > parsing and so on) and moreover, wastes resources becoming less
> > environment friendly (no jokes). Using --cc or moving to the behind
> > the commit message will keep email copied with cleaner commit
> > messages. Yet, all email tags are available in lore archive
> > (lore.kernel.org). Please, really reconsider the commit messages
> > content in the Linux kernel project and elsewhere, it will help to
> > make the world more friendly.
>
> Believe it or not, I'm working on some patches for Git that, I believe,
> should help a lot when it comes to handling Cc: addresses.  Would you
> like to be included in the list of recipients for those Git patches, so
> you could, hopefully, provide some feeback?

You may Cc me if you want to, but I can't guarantee I have time or
valuable input to that.

--=20
With Best Regards,
Andy Shevchenko

