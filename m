Return-Path: <linux-kernel+bounces-123047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFD5890170
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCF81F26EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78D3823CB;
	Thu, 28 Mar 2024 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNlAHUmN"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A417C3D387;
	Thu, 28 Mar 2024 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635331; cv=none; b=JHO8lTd8Pu+FbsYlxSzth6gVjGLP77YqOiHM1fKC/iIp573UflQduFI1RgWXQg8YWjCIgWWuU2mfS7enBgyV1v4QL3KHicU8LWsJyIOe8qPYT7P17eCn1AP6LmMlYy+ULqbxWlZsn5Ys5Ro4dtg4G+PGDInxQRRDCkbwOLYhfjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635331; c=relaxed/simple;
	bh=mU1Q3Hs355RiH3zIw2sY1eFLDQnHp3SmEWyNqbFmVXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMbSJ356wFW0RU9giwUBrKKAWRkNs9BY5C57Ohn+Yi4HpKHeJxKF4mTbm2KVxjiMXglPGjm5w6e96CD8Sd7NvYWQj06/tehe0CryukcGDu07xiWWq4MqTaBGCzuenlfoc2AgzkRX67gc/WyR9GJ3LrLraQXVLQ1YdqLaOw8272c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNlAHUmN; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56b8e4f38a2so1272878a12.3;
        Thu, 28 Mar 2024 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711635328; x=1712240128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mU1Q3Hs355RiH3zIw2sY1eFLDQnHp3SmEWyNqbFmVXU=;
        b=aNlAHUmNF0JZKoTnrGn0//eYTovBfiP8z1A69dN62W3WKv5TdQnFSeyyvNbU/w8pv6
         xIFjii1pt096rTUR21R8FBLuM6D4Ym+YFm0e8jm1YAq9eSR88/d9pxX7mLguUD6tssk4
         9J53iygK86ZgJK8A/DHhFzRCXQC3BQfxQO1Oq59KdY7o0MzzshGqNSJ/nJvb9bGGWmcn
         2HBK0Urc69R1xOPUhnQnOb9APofekN9NiETud0yAWfd9J3JaaKPY7EnKzsjR/X3A/kGw
         hq9qDCDOgc5bDcDu/HsdDguFH5MeIJrJdgKkTJga7HDvMTG9dZurWSuzgarzP5ifga1d
         LmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711635328; x=1712240128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mU1Q3Hs355RiH3zIw2sY1eFLDQnHp3SmEWyNqbFmVXU=;
        b=JO7js/51gV3vArXDgGWnxKc8XraNyxXOSvoNPmNCHRgvyHk93KBaeFmdp+YCf1IfSm
         tpDX4ijzX1SOR7VoeiJnh92klLvCtLgLwB+c+jnrvMFXCjgfRdbtmHLY9tf51xm61AU4
         Z3T/z0w76uOTb2bm1InlHb0MUTwXTkdeMIiRGr6kWMcuGg8gX1CwG3dt/o0wwcJna1BH
         r4k2PAkEZsV7qT7OenkiIK/OijsZwZRbJDEOqZxjpCVBOwA03FIuniATIBDC/CUshLWB
         s4v44u3phi/vVQx45ofBVPrhjJ05R3BaDLsQpTvlqtai2Of5KHiQnadI6HvXVqkKiSWb
         olIg==
X-Forwarded-Encrypted: i=1; AJvYcCWONOkpPAFhxI7Xxl6w23h7WIdGn4wf2YLq3RIuehFmLJwdcntDAWWAL9/a1F6CIo2HE7+xD41popt4J+z9Qwe7uygtXujoKSNzzdurocMT/ZyVXKgZlTbbXo+nWnMjvsPc09A4kj6n+g==
X-Gm-Message-State: AOJu0YxvSDQzW1K12bWU6MO91IHZX0bbakgm6UaK5gXREveZ5k0TxCG9
	iKWJpAu/p8CvmuUnlq8TVn0RzD/CDJpuiAvUcM83Eg7mbmnm0w8mFCOdLepC/vsul6PV62GoGmy
	LMTsaNo8f5sNXdWVnvRvYWTl1UzTz9Mb0VdksjQ==
X-Google-Smtp-Source: AGHT+IEzGzEsu2/3DcShIPr4EwtPLk0LtKWEXdRfLVR0k8Xl1hCdTP5injO7iw42zrvR3WpQamN6D1LjXhZFzIj5VGg=
X-Received: by 2002:a17:906:d1c4:b0:a4e:f84:41aa with SMTP id
 bs4-20020a170906d1c400b00a4e0f8441aamr1546359ejb.67.1711635327885; Thu, 28
 Mar 2024 07:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313235422.180075-1-andy.shevchenko@gmail.com> <CACRpkdZUnmnLj6ZJ8_p2tyN4txCA1fkSvqPo5gTqi=v33FToKg@mail.gmail.com>
In-Reply-To: <CACRpkdZUnmnLj6ZJ8_p2tyN4txCA1fkSvqPo5gTqi=v33FToKg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 28 Mar 2024 16:14:51 +0200
Message-ID: <CAHp75VducfkQ9kCMvzcBcY5QN7n8z9NXxk4948Hpv5k7QciRqg@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] pinctrl: aw9523: number of cleanups
To: Linus Walleij <linus.walleij@linaro.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 11:22=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> On Thu, Mar 14, 2024 at 12:54=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>
> > Just noticed that the newly introduced driver has some leftovers or unn=
eeded
> > customisation. Hence this series. It may (or may not :-) be sent as an =
update
> > after v6.9-rc1 for v6.9 cycle, but TBH there is nothing functional crit=
ical.
>
> There is some speling mistake making patch 4 fail according to kernelbot,
> if you rebase on v6.9-rc1 and fix patch 4 I think I can just apply the lo=
t.

Yeah, I will do it soon.

--=20
With Best Regards,
Andy Shevchenko

