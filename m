Return-Path: <linux-kernel+bounces-48259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26896845938
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97F41F237F5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8485F499;
	Thu,  1 Feb 2024 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LJFdmqgP"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38C65CDFF
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795202; cv=none; b=k71m4xzyyq5bthG+O+oV9KXcQvAgt2QOUhZw5CkLkSAqIuesXVdWQuWcixacEs8lgIpBogDnGQ+zrRDxRoC/Sw12Tz9zSxi8/m0eAt9JrBYHCuyHySOHa9aGnZIes2sWuaNq++eXhsiflYwSzzmkuHyX/ku2MPeNhLQgEN9YY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795202; c=relaxed/simple;
	bh=suoI7qvddasF6ze11GbOGjsGkZl9FBFquOHwW330phg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGBS2ivCa9C1rBeZHJJQv/xZ7Nw3p5CbaLBgGCnyMJZm3h8HfDdU+rCxWKqRdZ15tbqyEpMVVEZ6sSLEj6WDFAvBDTglGUknkT8bW77mH5sABvNN1UcVnUOhOpJIdQ2SINivszmUunLO1VmHjpFJMdkWwAkS6kjzeJ2yY07juSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LJFdmqgP; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4bd80b41cbdso342452e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 05:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706795199; x=1707399999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYWYexFtoJ2yHocou+INVoUtLbF8tOuPvQoRlZwm2yg=;
        b=LJFdmqgPnybJIumvPpfSejLkIEttxsn08suUHDAHBBpYlnfLY7vD/jAwsollH7N3F7
         /3cqzMeD9q0atz+INW14/C+UpgvO/tSxQ3fo6LkcKvgvw4f2O2tNhFpqec8Fur9gMv3v
         riRH9dgwwFJulRbu22STv/MYccrOLORyGL5QxMh/eUmOqx/CtxxU0kTQRX3Xlpy9U69n
         YitNBjDNPl2IwwKRgG0yobZ+WUWalQ/yECvaisqyoop6BsFZXarkvBv0ii1pE/W0beLw
         1xWK4Z/1h78PaQ7lFPIkIfmVGgl0xy/YC9sLuvBzw+MVlkobmg8Mtz/9WpmMqItaonPl
         hcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706795199; x=1707399999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYWYexFtoJ2yHocou+INVoUtLbF8tOuPvQoRlZwm2yg=;
        b=RORbEy7kLMoMOAeXa82wLI+MavE7tVj6+0uyCUawTjM/pxUh2kBtjtU7JKL1fMWXBo
         k1pyh9X9r+3zP/idryHVHTUU1eaNvCiBbT5Sq7nwfqMzHWCMhX75FGHsjmdh6kMSM9Jy
         JKXWMYkq18hG4Ve1GL3pQC4n6bK0Cc2q7RxX2iHUEzPMJ87jJCrf19KBB5bsd7a/VZ5F
         nsjuZABc4RjvCAiUQNLotBsm5oR21JNa06fkNJvGHb+KMt6PCZccfIdi9Y++diwIWjNL
         /TlGxN1htkJXfFEuqd1G8m3pUkxlVSjdoh+0/fF/WyXUklBh7y3FBM0Wzzts4tDE3WBH
         Srcg==
X-Gm-Message-State: AOJu0YyvT1JfgkVMB3a8IYqOJoyVe8btcDpqemikWnaGnQ607fM9Acir
	1VqumdmOr28jcAbwo0Ocok7qrny+WlXF5pUfoU5yf+Uyzgp2lTPL/XSuiHRDTsRtUOtZlB6i4zc
	VEZa/btbfR0pNm5FG5lbGPgLKR/zlfsQrDHTB
X-Google-Smtp-Source: AGHT+IG80kHJI3o0nh9nc37cFYAZfNgIoolcnGet/bLjzO8FQfWUZqIqvqwlp1tA8htBaza2xRqZOec13j3l2wPN17s=
X-Received: by 2002:a05:6122:2a0d:b0:4b6:be94:acc6 with SMTP id
 fw13-20020a0561222a0d00b004b6be94acc6mr5599008vkb.10.1706795199311; Thu, 01
 Feb 2024 05:46:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-2-aleksander.lobakin@intel.com> <3f6df876-4b25-4dc8-bbac-ce678c428d86@app.fastmail.com>
In-Reply-To: <3f6df876-4b25-4dc8-bbac-ce678c428d86@app.fastmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 1 Feb 2024 14:45:58 +0100
Message-ID: <CAG_fn=Wb81V+axD2eLLiE9SfdbJ8yncrkhuyw8b+6OBJJ_M9Sw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 01/21] lib/bitmap: add bitmap_{read,write}()
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
	Marcin Szycik <marcin.szycik@linux.intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>, 
	Yury Norov <yury.norov@gmail.com>, Andy Shevchenko <andy@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jiri Pirko <jiri@resnulli.us>, 
	Ido Schimmel <idosch@nvidia.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Simon Horman <horms@kernel.org>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, 
	ntfs3@lists.linux.dev, linux-s390@vger.kernel.org, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, Netdev <netdev@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, Syed Nayyar Waris <syednwaris@gmail.com>, 
	William Breathitt Gray <william.gray@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 2:23=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Feb 1, 2024, at 13:21, Alexander Lobakin wrote:
> > From: Syed Nayyar Waris <syednwaris@gmail.com>
> >
> > The two new functions allow reading/writing values of length up to
> > BITS_PER_LONG bits at arbitrary position in the bitmap.
> >
> > The code was taken from "bitops: Introduce the for_each_set_clump macro=
"
> > by Syed Nayyar Waris with a number of changes and simplifications:
> >  - instead of using roundup(), which adds an unnecessary dependency
> >    on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
> >  - indentation is reduced by not using else-clauses (suggested by
> >    checkpatch for bitmap_get_value());
> >  - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
> >    and bitmap_write();
> >  - some redundant computations are omitted.
>
> These functions feel like they should not be inline but are
> better off in lib/bitmap.c given their length.
>
> As far as I can tell, the header ends up being included
> indirectly almost everywhere, so just parsing these functions
> likey adds not just dependencies but also compile time.
>
>      Arnd

Removing particular functions from a header to reduce compilation time
does not really scale.
Do we know this case has a noticeable impact on the compilation time?
If yes, maybe we need to tackle this problem in a different way (e.g.
reduce the number of dependencies on it)?

