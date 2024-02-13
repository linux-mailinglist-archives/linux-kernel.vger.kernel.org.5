Return-Path: <linux-kernel+bounces-63381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A98D852E79
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0E81C20F76
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436272BB12;
	Tue, 13 Feb 2024 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0LC7Mu1"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7FE25543;
	Tue, 13 Feb 2024 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821764; cv=none; b=tCx4olqM+Lx9UJGTMW+Mi9313twTUXLgPiUNM2zgFWTQkweYm76agql2ZoQWeLEtmF9vnr04mWNveKpGp1KC5uusWSxwetmc84byjM5lMTmtx1EFsbUE1NAO54y1u8XHipXiogQQu7umv7Ddxe+cNtyaacHsIbf1djzjEcDKcMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821764; c=relaxed/simple;
	bh=YUurrgB9hKbq8LQjUCjYTYfNwInt+r7uGpXZGPanFts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PH7YAj+xXWAQbAL9hGj2RpDQA71lI6L7GjqepxvBFeDlXunBR8JriPOXFOO5SgmPkJXhgEPaCv8/sXy2z+FAAK5ESrqEHSsi9g+5wuGijZq2q1isAQJMK+bQFxKy87XWY3e6HK5P4xoMSVIsdxp9BF/BG5WV9Iqjde+nnc4RfXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0LC7Mu1; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3d0d26182dso36305266b.1;
        Tue, 13 Feb 2024 02:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707821761; x=1708426561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUurrgB9hKbq8LQjUCjYTYfNwInt+r7uGpXZGPanFts=;
        b=i0LC7Mu1NYGQfkxAgtcl83Mayvyf3leyTrpTP+Uk9cDqJ+XT9VZWyx8iZmuTHpX0pH
         LNupEYCKVYB0/aSBgEfbaaUZqrI1MivM1WcRU+F+7tRDhLMBrnMeBQFthNXnqMMSgaYx
         6zadalcH8rJ9ryILUPeKVTFRnXuLY6s5ldeReINpC9L/SkKX5G9NJKnSL9X3OkHDqQVA
         v9W7Px7fHupfa0XVJLdqAUWdi53vulmMhgJR9vmYpS8aV916O6DtAsUleqGkjN9b7jQd
         vvBsMw5EnMFeBS/y1Ni4eQB3rvp3vCac9kqIiC5UoXE+lnkN4mw7A+IbtMjXTUtMYU2q
         SToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707821761; x=1708426561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUurrgB9hKbq8LQjUCjYTYfNwInt+r7uGpXZGPanFts=;
        b=Ul9E4i6u7cmNrxghGcU9re9esEHZ/LCysgVb3m053K4u5vmMY+ic8EInGAvKYnLMTA
         6Xy/i3Kzfi73WKTomrsYp1MLIiHUoK9kSWiUJ4eWyybDjrhsUDPKWgO5wSKWUCo6BBPG
         nem7mNgz+MON5hM/uFMOOfq7FvtSG3pLbZxb3VHpx8DG3SPnnpyq3uOJOJnDjuvrlbcS
         ARwBacZEydPnTef6dw3RJ8fltrc6bz7eW6bc+dIlZhlrxkNn3mRqeYNBegH3hbOb2ORn
         tSQyLYJbCSWuLeHeW8R2hY2i1FohUEBMpeI8z2PTy5Vn8rCju+rdMK5sHtypG6zOsPhb
         I3QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlOBAJVBtCQrdm9jGDLgc9CwBQKneLvorKceWTA72GgRlbj0Rv7yNsBpP3G5NeYpf2i+Dr/nieMekPJCYj8F/K2pRnB+F5H1u+4y3MDXqD92YGK3Ep7SmSGqu+yfGCZKG5KWzChz1cbg==
X-Gm-Message-State: AOJu0Yw+tvMXQD9OaES8j2JFsBgMdMWpb5hI7xWz019wZsBCP6FKxkHc
	fv4S2Zq3cZQkaLezlgPM4GGxL1YiG6tMFr0cnmzvG2/R1gGpKWAPDWGJCYrUl0DiFkm14/U0hQG
	Kcn3+zlRJfZx+Hufuu2fK2F6aBed1BW4toaUONw==
X-Google-Smtp-Source: AGHT+IFolOxgwWLz8kVogEtlGE21JCzOZgJAa+aH+vEDXUfXHQDponMPU6Br24q1L+ahv8K1sh+Uqz/FoqPf/0eDVC4=
X-Received: by 2002:a17:906:ae93:b0:a3c:92c2:66e0 with SMTP id
 md19-20020a170906ae9300b00a3c92c266e0mr4060891ejb.64.1707821760864; Tue, 13
 Feb 2024 02:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214173614.2820929-1-gnstark@salutedevices.com>
 <20231221151111.GJ10102@google.com> <ZcZcpUHygltD2ETa@smile.fi.intel.com>
 <d844862e-1d1c-4c9a-b7fe-e0ac44f4126e@salutedevices.com> <CAHp75VfQd9e4fLAYkYrMajnJfPQqno6s_aiTarErPiqP-Z6ydg@mail.gmail.com>
 <ae5bf6bc-5f7f-4fe9-a833-c1bfa31ff534@salutedevices.com>
In-Reply-To: <ae5bf6bc-5f7f-4fe9-a833-c1bfa31ff534@salutedevices.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2024 12:55:24 +0200
Message-ID: <CAHp75Vd1FRz9=Q7NRXsbkBu_K0+zRC6uf5nPM1Q+QnJum+74tg@mail.gmail.com>
Subject: Re: [DMARC error][SPF error] Re: [PATCH v4 00/10] devm_led_classdev_register()
 usage problem
To: George Stark <gnstark@salutedevices.com>
Cc: pavel@ucw.cz, vadimp@nvidia.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, hdegoede@redhat.com, mazziesaccount@gmail.com, 
	nikitos.tr@gmail.com, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Lee Jones <lee@kernel.org>, kernel@salutedevices.com, Waiman Long <longman@redhat.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, 
	"will@kernel.org" <will@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 2:14=E2=80=AFAM George Stark <gnstark@salutedevices=
com> wrote:
>
> Hello Andy
>
> On 2/12/24 12:53, Andy Shevchenko wrote:
> > On Mon, Feb 12, 2024 at 1:52=E2=80=AFAM George Stark <gnstark@salutedev=
ices.com> wrote:
> >> I haven't lose hope for the devm_mutex thing and keep pinging those gu=
ys
> >> from time to time.
> >
> > I don't understand. According to v4 thread Christophe proposed on how
> > the patch should look like. What you need is to incorporate an updated
> > version into your series. Am I wrong?
>
> We agreed that the effective way of implementing devm_mutex_init() is in
> mutex.h using forward declaration of struct device.
> The only inconvenient thing is that in the mutex.h mutex_init() declared
> after mutex_destroy() so we'll have to use condition #ifdef
> CONFIG_DEBUG_MUTEXES twice. Waiman Long proposed great cleanup patch [1]
> that eliminates the need of doubling #ifdef. That patch was reviewed a
> bit but it's still unapplied (near 2 months). I'm still trying to
> contact mutex.h guys but there're no any feedback yet.

So the roadmap (as I see it) is:
- convince Lee to take the first patch while waiting for the others
- incorporate the above mentioned patch into your series
- make an ultimatum in case there is no reaction to get it applied on
deadline, let's say within next cycle (if Lee is okay with a such, but
this is normal practice when some maintainers are non-responsive)

P.S. In case Lee doesn't want to take the first patch separately
(let's say this week), send a new version with amended patches
included.

> [1]
> https://lore.kernel.org/lkml/20231216013656.1382213-2-longman@redhat.com/=
T/#m795b230d662c1debb28463ad721ddba5b384340a


--=20
With Best Regards,
Andy Shevchenko

