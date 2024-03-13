Return-Path: <linux-kernel+bounces-102591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BCA87B454
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2121C210DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A82659B73;
	Wed, 13 Mar 2024 22:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU3URaS+"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BB759B4E;
	Wed, 13 Mar 2024 22:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710368853; cv=none; b=CW5AUlmgmX/EGld9tS1USIoSGNqNHFLJXa6gCepzsCzxhlvvfnJlf0CLlJMgadgTtzxtg9UALpei8w3/CFONTP175m3+YfDVJlWyn+3AWsMg/6+bmMIv2UZu8D8MdPJhlWe3pXmEP4MnI8D0/SAiI/dNvN9jONfVHxzVYa44luk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710368853; c=relaxed/simple;
	bh=lpNd93RTxuA8gJgUouWbGPC3np5DTIp27HsKDi//PGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nO1xgUnbAfZqB9+OoDEsNv4yLl3Ax/IDL8KgcF9sFUScjsqsvP57iCAFmZpVUnKFHiKrSxAYrdn5Y6EyM74TZ8hd+EXRFe+icyGel4AxJHfFL0tv/srYNQvke8eVd4MamnnCh6QaesnySS4ltSlRHkEdENm6QlJ5DpleHre0hI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU3URaS+; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d2505352e6so3629011fa.3;
        Wed, 13 Mar 2024 15:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710368850; x=1710973650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DONznAauGwqpEdNWqmyG30S9dMHaF9ZOheB/nm6WWg=;
        b=PU3URaS+pFQPb7xz6ZOt4alvWpx6vjO+QacIcuXN3pPt6kzi/GpVbWi4095XCENbZf
         3KGpFLTZrFKu12DSYYCPGF10a1eUP4lMuVLanoc/s0yATmuNByql1w4ImLNO0kwonc3m
         tFCF7efFPrsQgXQdBxH18vSRq11U/mMlSH0kT4wdD97SiFclszODiEyjua+9j6GAsrSY
         NTTv+taQgYjSDN9uaOuz2r9MCw1/5NaFjUiHvXmEC1FB1WoFEhK2Nt+/S5D2qx9UivXj
         nI0Ch9PTlqxxgrXO0m+WG+bIpnrPrlg1+bnRvqf0XeF9ounXu8Pf9gKBD67xig+6godU
         v3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710368850; x=1710973650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DONznAauGwqpEdNWqmyG30S9dMHaF9ZOheB/nm6WWg=;
        b=DAjjdRS3SDIVYmmDh6p3ElnSiJgkA96cwxC6Z0lVP7zcI8s1q/IMF0ARVzi2UJZfUM
         w0/GXciPQizCH6R4spWY6eLA/qGCfh6E1s19szsAYsj04GlACkrQ+xXxEsjf/vUmb3yH
         n8CRJJBc/unOQvu2nf240NhKGfmjtyDGOBYeO9EQMFYE2OrLBlmpsxK5GWg6C1NGFDYA
         teWffrnkxJg0wlSwQa6XuJ39qNTM7dvst2mj5Pf7GocE1c4EGz1s4s16tR3n8WODo0ER
         HKnocNG7QdCSmFHxMQtNCFNL0XPrrUwZvPx7JalDhq9/BbP+7mAhHpWV3Fc2Eg0LfdKt
         j/tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv8jPbZqLHR3Zg6l4fvve2M11dCxDpOHbvfFp+r/lGHXXp/4GWRTHOl2yMVDcOtxURL5CJMwhybt/oLzKDwnVx8GE2i82op88x
X-Gm-Message-State: AOJu0Yy2yaFD6GFDXXknjpZIpGh5BMUsulWsbqmJE/Ye3Ft/dpodQH4y
	fHip3Rc9j52C2P7NcwXXOYnwTni6+AgVfIqbHuDFBUazhY5Fcu7LEEXlRedt5ZNkqIBispRUHPT
	WNb+Hw5jJXacqj0T5kpgSsfYgnViEw+Zcajw=
X-Google-Smtp-Source: AGHT+IGrXnXZkbZyuti1Z59XShBg8fD/igB+wl1jQfpkQFQkJ1jRBTkhT9hC7jR7sDBY8f5n95eEEuB4g7QtO3AxTI0=
X-Received: by 2002:a2e:b1d1:0:b0:2d4:d88:50e1 with SMTP id
 e17-20020a2eb1d1000000b002d40d8850e1mr2960359lja.42.1710368849739; Wed, 13
 Mar 2024 15:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <hxiq3upwxs3j5mc5arwlx4jriqm7fq5z54wroc4h4kqcq4gq7m@uwnoq2vnkhup>
 <ZeXzuWVmC9AnsECt@debian> <7ubz52rfdl2i76sotvd3s4thv6jvbfao6zct3sywqus2owlvkx@wpbeqqdvipo4>
 <ZehMWQ0LkemsTHAC@debian> <CAK1VsR0XZMgUW8qMQMcDPohD8-+OZsgW68sZegLbVy6cdoWucQ@mail.gmail.com>
 <ZehrtwSDQV-X7BXV@debian> <CAK1VsR3MsyphK+=rA7XcEigiSd6J_-QsVW+8hH1fU9xmRY3nGQ@mail.gmail.com>
In-Reply-To: <CAK1VsR3MsyphK+=rA7XcEigiSd6J_-QsVW+8hH1fU9xmRY3nGQ@mail.gmail.com>
From: Oliver Crumrine <ozlinuxc@gmail.com>
Date: Wed, 13 Mar 2024 14:27:17 -0400
Message-ID: <CAK1VsR2zaCT3Bs1cwCEfLhAPXjwNk1byzNq5y32C736=hxqjoA@mail.gmail.com>
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 4:08=E2=80=AFPM Oliver Crumrine <ozlinuxc@gmail.com>=
 wrote:
>
> On Wed, Mar 6, 2024 at 8:12=E2=80=AFAM Alejandro Colomar <alx@kernel.org>=
 wrote:
> >
> > On Wed, Mar 06, 2024 at 08:02:10AM -0500, Oliver Crumrine wrote:
> > > Hi Alex,
> >
> > Hi Oliver,
> >
> > > Type into netcat, not the program I sent.
> > > My program is the server and prints out whatever it recieves,
> > > along with some other stuff that lets you know which options
> > > are supported.
> >
> > Nothing either.
> >
> > $ date; nc localhost 8888 -u | ts
> > Wed Mar  6 14:09:38 CET 2024
> > foo
> > $ echo $?
> > 0
> >
> >
> > $ cc testDgramSocketServer.c
> > $ date; ./a.out | ts
> > Wed Mar  6 14:09:05 CET 2024
> > ^C
> > $
> >
> >
> > Have a lovely day!
> > Alex
> >
> > --
> > <https://www.alejandro-colomar.es/>
> > Looking for a remote C programming job at the moment.
>
>
> Hi Alex,
> I apologize for your repeated troubles with my test program.
> I have attached a video of myself using it in the method that I
> described to you. (I emailed you off-list as to avoid sending a 12
> MB video to the whole list)
>
> If you are using it in the same way that works for me, I don't know
> what the problem is. If I could've been clearer in my instructions, let
> me know for the future.
>
> Thanks,
> Oliver

Hi Alex,
Were you able to make any progress whatsoever with this test program?
Thanks,
Oliver

