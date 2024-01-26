Return-Path: <linux-kernel+bounces-40485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA8083E174
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3199EB24334
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDE220B37;
	Fri, 26 Jan 2024 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zk7uJWZL"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80C320326
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293703; cv=none; b=hcDVWiKHZq3JFwvU6uarG7i+HuZ7lEK7tw6I7K2DAvsICz1Mv/72oTp2wpY7I+YxfiEVe9wogvH80ZCb8K92fzfeNKRQYm3YWq0BvSkIUDbhZMjrVwaXotulKh5T2T8/ud5KWjop8UFGsqeJ2Zdzz84VzyAaGJUV+mpEdKF0OjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293703; c=relaxed/simple;
	bh=MysLpERkz0mzZyPK1tFCO7q3rwancbhx+xp7RkPmWr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oylivT5uvJE0xsifpkA6H4V3RFBqUzNlAoJpKjHVfnRaA5dzq9PHaV/E52VouYoCP8TA/gy4dJNVrLL1DxLqBVYAxk4cNqX1g4av1DARAtt48orZBXUdu3ZwzMeVXOH3g1iTjv5Seh7gzORSPbI7uQLpdzpXH1AGLdCYBtRkxK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zk7uJWZL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3392b12dd21so887034f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706293700; x=1706898500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MysLpERkz0mzZyPK1tFCO7q3rwancbhx+xp7RkPmWr0=;
        b=Zk7uJWZLHJugqm3zg9wdp2SzCDrr0bSRILFzlpjTEr9U/GHJqcou9ot2KS9qHNMErT
         WgQJ/LfCTtY+14zeJPLZNlYh6GjjD4Zyp6F3D8EULT9jUxEMx7uCTF89pMF/TGQQLNLx
         NOeS6yFTRmcplDGcFetdfaVwJ4SVAwQsDywA35voQVWVSVtrrMH3L18/+mwbHGajn2jP
         L9jNs1Dh/El8ZJtKNu5URDDtouQ3Jl2hOnZS00Qg98ui+SeC/DuHKm7+bNSmaC4XJQOY
         GbORtaYr8p+LFaDmgnzymmXsEG2s0ZC8wC9fUCmXZfcoWbKeAhyGYTNW3/XhnWOXXeXO
         NqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706293700; x=1706898500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MysLpERkz0mzZyPK1tFCO7q3rwancbhx+xp7RkPmWr0=;
        b=IkbXFa+fksTaT/ppblsieeTcuuVdSkxEOZ9cr3bwIiXCNkZUBL/h9IIHUnIMObwT1U
         +QOMX0d8DgXxOiJgX0WCpcG8pFphkqx3zJ6h/besvzm81hrliHewh40MTmPcSRUq0c48
         mQAhOL8Y5fgn4E1ZusB06V+m669l9wtkq+asUK9toNydX55TlMP8BIOUfM2tWlb1l6G8
         fJMXV67BqShGEJujXOWSNVXoVMwZXVe7E/U9dvtv4ZgDjyq1by0UtwUcUxZ4T9utzxOD
         XxPPhZVxFcVK5lCoMlMHKER0d6i/ZaR+GpEAEyqRavKHpWAdf20YG4ER0Kd83keWLXxD
         TcYA==
X-Gm-Message-State: AOJu0YyO0r7BnlEL7DofFfzXWeHWdF/tGgqgCE8XqoC4wWo//B4G1q4e
	EWt3ifW8jt7dkUBmqVzziiTEWGp5lvbDZD5W1mcFc2Cr39Pdv9CiZ6dJ81F0l4Q8Valcj7wLbDL
	6CiEX5Y1bxQw6oQKBAjDX3SnxvA8=
X-Google-Smtp-Source: AGHT+IEEhVmrRyoykZVvxdyf0Rsy3n7egR71cs0hFB7bUpUdamL4pmFk3FBlb8VywPeR6ACbGwR0Crk0G7VNN/sKmyo=
X-Received: by 2002:a5d:55c5:0:b0:339:35a4:7cab with SMTP id
 i5-20020a5d55c5000000b0033935a47cabmr35995wrw.116.1706293699251; Fri, 26 Jan
 2024 10:28:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113164344.1612602-1-mwalle@kernel.org> <631fe35a2a3b00781231e4f3f5094fae@kernel.org>
 <1ef3dad2-5f55-40e5-bba7-3c71d71c12e4@kontron.de> <CAAQKjZMccDwa63_PNJCP0rNOaHjTwcOz8AbKa=JXLQi-b0QVVw@mail.gmail.com>
 <2400535875c353ff7208be2d86d4556f@kernel.org> <ZZ1BBO2nNSp3g-gT@phenom.ffwll.local>
 <CAAQKjZNnJQDn_r1+WNmsxM-2O48O0+yWAUAqpjZRjMYMT3xGwg@mail.gmail.com>
In-Reply-To: <CAAQKjZNnJQDn_r1+WNmsxM-2O48O0+yWAUAqpjZRjMYMT3xGwg@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 27 Jan 2024 04:28:07 +1000
Message-ID: <CAPM=9tytMB9frxNeD08hu1qsusY=wEE3bJOFmUgA1rSpabwDpg@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge: samsung-dsim: Don't use FORCE_STOP_STATE
To: Inki Dae <daeinki@gmail.com>
Cc: Michael Walle <mwalle@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Robert Foss <rfoss@kernel.org>, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, Jagan Teki <jagan@amarulasolutions.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Tim Harvey <tharvey@gateworks.com>, Alexander Stein <alexander.stein@ew.tq-group.com>, 
	linux-kernel@vger.kernel.org, 
	DRI mailing list <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just FYI this conflictted pretty heavily with drm-misc-next changes in
the same area, someone should check drm-tip has the correct
resolution, I'm not really sure what is definitely should be.

Dave.

On Fri, 19 Jan 2024 at 16:37, Inki Dae <daeinki@gmail.com> wrote:
>
> Really sorry for late. Will pick it up.
>
> Thanks,
> Inki Dae
>
> 2024=EB=85=84 1=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 9:50, =
Daniel Vetter <daniel@ffwll.ch>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>>
>> On Tue, Jan 09, 2024 at 09:47:20AM +0100, Michael Walle wrote:
>> > Hi,
>> >
>> > > > Inki, are you picking this up? Or if not, who will?
>> > >
>> > > I can pick it up but it would be better to go to the drm-misc tree. =
If
>> > > nobody cares about it then I will pick it up. :)
>> > >
>> > > acked-by : Inki Dae <inki.dae@samsung.com>
>> >
>> > Who is going to pick this up? Who has access to the drm-misc tree?
>>
>> Inki has, so I'm assuming since he acked he'll also merge.
>> -Sima
>> --
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> http://blog.ffwll.ch

