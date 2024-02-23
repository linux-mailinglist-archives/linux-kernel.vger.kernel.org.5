Return-Path: <linux-kernel+bounces-78508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C48EF86144C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605561F24510
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8682D6AF81;
	Fri, 23 Feb 2024 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKtxOxHs"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBA66FAD;
	Fri, 23 Feb 2024 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699200; cv=none; b=qy+AOG0k21968EgJnD1qjOHY6oiQP25+LVpkZcDtB0AAjxGOYzxLF9OErXBgfm4tlHUmGFWKzUwx7tbbneGOdLqVR5eenEvgpR30ojg8Lrsa+TUyPMAFQoQa6G2vhQTa8gOdIQP+bT4RrZoMezICfGWenYsCLXvLVOuEOSpNRN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699200; c=relaxed/simple;
	bh=vpZPuiLLkI988ptyENq7jUvXxAIw1cEVbm2O6JbZLGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+ieR5o7kqqqgAdOir21xf4ryWaTbLZSLBJ1YJBUOEFzEeEGKMw4m4pke4JaRjjzOaESx2NOvHLUj3dnqbRntSLTWnOQIO+0hI9UX+1tSGuyaIFfh994IbDQUxWZi2Phb0psaH8q9KsTk6vVtjAc89VER9QHsX9kvg7HMQcZdmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKtxOxHs; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3f3d0d2787so55526366b.3;
        Fri, 23 Feb 2024 06:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708699197; x=1709303997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpZPuiLLkI988ptyENq7jUvXxAIw1cEVbm2O6JbZLGM=;
        b=WKtxOxHsDgGmBZl8Pm6N7+5snPFEPTFMlrWSlQ2Ash7BvsbDXcwhW4dNmW6XTczaeb
         L0Cy612m5f1N3DpiwJjHzMDozhdF4gEQFfgPIBLaIGy7YEOWU398hZZnv9r2ynnw6+kQ
         Ooo+6w6pbgqcxhXwfaK/eYYMMtWqNDb0yk4tRdWi+voELBWURrt+LfTFoSRHMAKulep8
         AdMC4DT4JyXXSXROG0A6/a9viX26Fl6XMNOnpabTl4qtDEDPPDxv9N/YAdKal+kPoBdP
         MADdl9O3dyNK55WJLhLsoyfgLv/j0vkBtTFC/J6c2kw011jsHYG9Bxj2FVS/7ygKMDIl
         ZMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708699197; x=1709303997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpZPuiLLkI988ptyENq7jUvXxAIw1cEVbm2O6JbZLGM=;
        b=VbjJQpI1PjohgsMdejI64PyTX0iNrLUKX5oWHB/siEw/iFSdyw+MHjqP+fRv7fvky7
         vZv8nyUjI9szUI6yMZ+A/11YxAVGu4cy1VLVvzMww7vQNFLrry6DzRZbjgPhv6ulAFKB
         +Ljkjcw7i/ODMyalCeCXdmSP+BGmwXN3u/Mtayi5UHUp3OhPJBIxIJH1MogwIUu1DNnF
         Ivuvqfu/KdOzADL4BGIJ22+gDdpHL9g9ymi/KFa88CreyCeDhw1zTjOHYIuNGGLE7X9b
         DVJN5nJlx+eXMhEsEiDLFd5QZ/KB9/k5cRu4LfgNVQwxXVv4EcWtmF54lFsCXk0wufwz
         i8WA==
X-Forwarded-Encrypted: i=1; AJvYcCU7a1DTJNYl78pTm25EDwnVpcZV5jUmgV/gOWoFljGmGnGkOeTBiOjges9YwEvCB3wxrZsKMfsgrH3K9/5Yx91v5WrqXuZg62GRvD8ecPMhHqyqToNCD6vD8lFKJNX0W7Kl5nRWlVU5
X-Gm-Message-State: AOJu0YwMqvhrMxvhGcgWQ53eaV8L4Ee4bJi/hW9LlkHH0x4hE+paJwlk
	jq8pY8IgInZ+weUyEIsz05SOBDynuBMChP+tWLnEO+RvkTeg1rHiTiB+MqYhLUW/UTyNy7rGchd
	yNikQQKmKYGW7Hmlj2l78k8f+n18=
X-Google-Smtp-Source: AGHT+IGBCLA7oTCR1x5TwCidwTaIiT3zUeUmp18ugjUau1mCK673R/6uBtfxi8E6jqxFDz/uMvgYluJ/O9I+odulo7Q=
X-Received: by 2002:a17:906:cb08:b0:a3f:684b:d0f0 with SMTP id
 lk8-20020a170906cb0800b00a3f684bd0f0mr1543311ejb.58.1708699196932; Fri, 23
 Feb 2024 06:39:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223-saradcv2-chan-mask-v1-0-84b06a0f623a@theobroma-systems.com>
 <20240223-saradcv2-chan-mask-v1-3-84b06a0f623a@theobroma-systems.com>
 <CAHp75VfVTJsQDwaPoPgGiT6jnymXAR3WpETqaKai8rXAC70iLw@mail.gmail.com> <6f76ffab-69fe-4afb-9d7e-d3cdfe37c28c@theobroma-systems.com>
In-Reply-To: <6f76ffab-69fe-4afb-9d7e-d3cdfe37c28c@theobroma-systems.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Feb 2024 16:39:20 +0200
Message-ID: <CAHp75Vft3kJEF9JiuEqVsS3biQ6YsuDXON_P3FOZRjtb8NaB2w@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: rockchip_saradc: replace custom logic with devm_reset_control_get_optional_exclusive
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Quentin Schulz <foss+kernel@0leil.net>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Heiko Stuebner <heiko@sntech.de>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Shreeya Patel <shreeya.patel@collabora.com>, Simon Xue <xxm@rock-chips.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 3:10=E2=80=AFPM Quentin Schulz
<quentin.schulz@theobroma-systems.com> wrote:
> On 2/23/24 14:00, Andy Shevchenko wrote:
> > On Fri, Feb 23, 2024 at 2:46=E2=80=AFPM Quentin Schulz <foss+kernel@0le=
il.net> wrote:

..

> >> Cc: Quentin Schulz <foss+kernel@0leil.net>
> >
> > You may use the --cc option to `git send-email` instead of polluting
> > commit messages, or move this after the '---' cutter line.
>
> The whole point is that my SoB and authorship is from my professional
> mail address which is likely to change over time, the Cc is my personal
> one for development. Basically, in the event that I change my employer,
> I would still be reachable at that Cc address without having to modify
> the .mailmap after the fact (which won't make it to an earlier version
> of the kernel for example). Some maintainers don't really like this,
> some don't mind, we'll see in which category the IIO maintainer(s) fall
> in :) (I don't mind either way just to be clear).

My point is that Cc and other similar (non-real-tags) stuff is
polluting commit messages. It means that this will be copied to the
Git index to all kernel git repositories in the world from now and
then, This is at bare minimum makes additional burden on git log (and
parsing and so on) and moreover, wastes resources becoming less
environment friendly (no jokes). Using --cc or moving to the behind
the commit message will keep email copied with cleaner commit
messages. Yet, all email tags are available in lore archive
(lore.kernel.org). Please, really reconsider the commit messages
content in the Linux kernel project and elsewhere, it will help to
make the world more friendly.

--=20
With Best Regards,
Andy Shevchenko

