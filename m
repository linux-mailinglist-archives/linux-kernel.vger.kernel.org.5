Return-Path: <linux-kernel+bounces-56813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3212384CF91
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311691C26D28
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9C3823B4;
	Wed,  7 Feb 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K2pHea2z"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E3C8002F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707326050; cv=none; b=Aks3ho+RGyJmtvXAiN8eN7Up/5YHAsU+Vmx7zvSgA4WMYXHnHttSmrVT39ei/DbLB/GyeeFUrURsl5KlGeHyY0mo14opSmkpxLmj79u2szezH4ifR7JcJDJE1aT2yjSzbU5C1+z0Jfp/5g2tZau65MHwoWq94FjNcpCxEa1vy2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707326050; c=relaxed/simple;
	bh=jsXbkQWp51Z/MUfNhTMbRnHNX8uaMpMEt9lE31aF3xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7Qag1zSXc/HxK1FqzIjFaL6pMw60EJWez1L8cjl0TGsMN4p3vzg/xLE/+7risQxpr14W5alFtu6IL17keNir5EhBDc5OF19bjPLQKmcx6KLubzl8tWpwBljJ+vXYl3ydjuoJODaShP6ybF+YxnWAFB8Qj3FB1wtnfLjMNz4RGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K2pHea2z; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a389a3b9601so53484066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 09:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707326046; x=1707930846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+OqFrlutUQNqsEjRfOA+oiFYIRS1Fb6VQtBU8uK0bY=;
        b=K2pHea2zgYwCo8NMvxGIYi+9PFizSluZQYKlGZz+BU0XNZJVkEBkpPxpedJKZVzAbZ
         r23Z+UqGN+QqDBU9HNE+hbIZMLiub1QDGoPNLZKZy0pJIo0IwMPD44+FFEnq4TeN4nD/
         yCQaq61injx1uQmlqOtdNznzKbCz7jLs1i8AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707326046; x=1707930846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+OqFrlutUQNqsEjRfOA+oiFYIRS1Fb6VQtBU8uK0bY=;
        b=PL0KLh0iq44U5GRStFG1Sm1aODhcimmGcMPctaJcyJslWUY/ejt4Z8crB7v2H1qbL2
         UuoJTyCfvzTwCVwOh4jgJ19T0o2AniQSQnXnnffKAoBSvCEJeONPHklf9GMujk1PGoQU
         qUUeSDZa7ZPk3fiA15NRjCbjyNoufR1KTrdbgi/jkhZLIyCon8BNyroSdenIgJ2CrCk3
         tejBf5g+1OQy1xBTaZ/ufVOyws3gAKHOwU7xxcRegT2CpSwZPnrpWF90q5pQ3FhmJpxO
         cT2ey6RZe9z1+a6eK5/I45njgbZL0MPXq0mnRiq28RLE9wqSF7wGdJ0xz+JOHANDiaEl
         yIJQ==
X-Gm-Message-State: AOJu0YwJwobQsSr9TtsWfhBbL4vQAql8cv58UozBJwv6YSPPlO8jGNe7
	VcHtOfuSOxedhQY6GGuhkHegLtmnXjfjvsv6uVFeuzkUFp9+0t16RJHeOssb/Vhsx98rgtusDOK
	Blw==
X-Google-Smtp-Source: AGHT+IGUdqbMLpkRQWqCTjnLrK1wvli3DV/ZOR+jS83vKAeAWLu3aMd7KbIONRSPEW8cJrIBKp1p+A==
X-Received: by 2002:a17:906:646:b0:a35:e7a1:66ec with SMTP id t6-20020a170906064600b00a35e7a166ecmr4913336ejb.44.1707326046193;
        Wed, 07 Feb 2024 09:14:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVrVVSQ8vN+KtyqTSWLYnKerR4bIKncA1l1g3+NWe0KEfbq6jzfeyMknqEMKZzgx7UzvKwiBrj5g4EhJ6cKmVT5ALKNuQeZ4nTFZn5H
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id l5-20020a170906a40500b00a386a441b9csm960980ejz.66.2024.02.07.09.14.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 09:14:05 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40f00adacfeso52535e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 09:14:05 -0800 (PST)
X-Received: by 2002:a05:600c:3d98:b0:410:1d90:bdab with SMTP id
 bi24-20020a05600c3d9800b004101d90bdabmr118622wmb.6.1707326045045; Wed, 07 Feb
 2024 09:14:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206095902.56406-1-yaoma@linux.alibaba.com>
 <20240206095902.56406-2-yaoma@linux.alibaba.com> <CAD=FV=V+mcBdeq8mmH0h41byUtL-G1zFmZQtj341ubwqyPxD1A@mail.gmail.com>
 <1cdff175-37d8-4223-a3ca-07699a5f8a6c@linux.alibaba.com>
In-Reply-To: <1cdff175-37d8-4223-a3ca-07699a5f8a6c@linux.alibaba.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 7 Feb 2024 09:13:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VRNc=dngP5ac45yNrSh06VdE=8iuRVbNN40hgVaXK7sw@mail.gmail.com>
Message-ID: <CAD=FV=VRNc=dngP5ac45yNrSh06VdE=8iuRVbNN40hgVaXK7sw@mail.gmail.com>
Subject: Re: [PATCHv5 1/3] watchdog/softlockup: low-overhead detection of interrupt
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com, 
	liusong@linux.alibaba.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 6, 2024 at 10:18=E2=80=AFPM Bitao Hu <yaoma@linux.alibaba.com> =
wrote:
>
> >> +static void print_cpustat(void)
> >> +{
> >> +       int i, group;
> >> +       u8 tail =3D __this_cpu_read(cpustat_tail);
> >
> > Sorry for not noticing before, but why are you using
> > "__this_cpu_read()" instead of "this_cpu_read()"? In other words, why
> > do you need the double-underscore version everywhere? I don't think
> > you do, do you?
> I also struggled with which version of the operation to use. The one
> without double-underscores provides preemption/interrupt protection,
> but in watchdog.c, the version with double-underscores is used. I
> analyzed that it is also safe to use the version without
> preemption/interrupt protection in my code, so to maintain consistency
> with watchdog.c, I ues the version with double-underscores.
>
> Is my approach reasonable? If not, I will switch to using the
> non-underscored version.

Ah, OK. I hadn't followed the macros all the way through to the
arch-specific defines and I didn't see the preemption disable. OK,
what you have seems fine to me, especially since the double-underscore
version still has double-checks that preemption is disabled. Thanks
for explaining!

-Doug

