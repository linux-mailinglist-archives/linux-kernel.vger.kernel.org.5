Return-Path: <linux-kernel+bounces-153656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240958AD137
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9917FB258FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46252153563;
	Mon, 22 Apr 2024 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQtkKAfi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B6E502A8;
	Mon, 22 Apr 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800899; cv=none; b=WMIdrDuCTYloUrdwqgX/KeQBc8b+dqKm0JUbTvteAQ5zMBvYLgXnzkVScuul+zzeqVurlzhMJ2w69m1fAHYNDAGoPuOHruHIabTwYI12kXgtZcfBOg8dvJCA4ktuybKigxmdb3e4ustrnUploKJMZtryVG4cLTtDcHMGiBQIiuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800899; c=relaxed/simple;
	bh=qhx0qzJ6eh/Piwu61s3SOfrpixoraj8h9WKEC68zkvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTLY//LY6eDvddaIk3uq3aMaTFcRp+6mMnAq61ywLZC7CGcsd+BtNyIJn2AyyPupPwJW4u5m4BeneNGTzsZkSiXqy8MeEqnh4zymZ6e5pu905vXE+Uj/GHJVIGFVVhRbZRUHrFS410eTg9+7sDiUADbxrVRsAJ1KnN7+cD6cQr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQtkKAfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0339EC113CC;
	Mon, 22 Apr 2024 15:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713800899;
	bh=qhx0qzJ6eh/Piwu61s3SOfrpixoraj8h9WKEC68zkvE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eQtkKAfiwdsuq9XsDA3nQk4XOR+nL7theGHHVtmfJBKxJX4cx+ryozk04IpE1d1Wi
	 4dGU2YB7VPTSm4ZXmDPlWuxqTvh8aYhXx1rrh+Tnh+oCtaCKzSe9uJUYHqw3EpC6hz
	 0YVJztgRg9qW8BY0PW+eGHvEXL8NMUegwRx2nuGlcUfBByvKRIqZpLJiOZ2zkjjARj
	 Vmu9XUGdTXA0XLtUspNjPiHBQgO0yU11bQpoaYg5CKawps1PW/QTGtg2s/fCOSfsOT
	 6tHBdpl+8WDjtLJdUnnTGOAqE9Tecz5dbtgVyDRfytUdL1jhWFluqwD9eOpE7DpC98
	 v2UZVkiXiELbw==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5acf5723325so1073148eaf.0;
        Mon, 22 Apr 2024 08:48:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3Iis48cDCO715Mr1axJd3r7G16lw/lbV2HxS94x9lSsd3/MteLHp1SaMdG7ZgmtvxEtZsRMQtQdXY4hriJGkDxVYXf8d1qYw8zHoNcxTZP/C9PhV1tvBYCsWva5b8HTegO4sPCu0=
X-Gm-Message-State: AOJu0YyyL9/0geVn2VZKr7EZMZnTC+IgMHJCi11BJkZGZ0rLe3RxVFXG
	OAPZq8zroF9ilj7z3lM24EBNMr/Bgih5yDHzCBfB7yxa847lCk1gC1EwB7IrqJ83FodqxOg5uz/
	vrJcgsD4QsTdj1Ml/yUDKXOEH6ZQ=
X-Google-Smtp-Source: AGHT+IEejy7ZrxkOXryq/C/rtyhD6+Fy0SmQNR3iAw9VjlGe2eFjqyjYSJMQRgsNHyrgaAjcIJHaXgJ5j1bzdRA9xgM=
X-Received: by 2002:a4a:de19:0:b0:5a7:db56:915c with SMTP id
 y25-20020a4ade19000000b005a7db56915cmr11719433oot.1.1713800898393; Mon, 22
 Apr 2024 08:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4918025.31r3eYUQgx@kreacher> <3a8f1978-c5df-40d6-91ca-276431bb01e1@arm.com>
 <e8193798-4c02-423a-a9d8-63d29ebd7faa@linaro.org>
In-Reply-To: <e8193798-4c02-423a-a9d8-63d29ebd7faa@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 17:48:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i2pvTLwj7jTzwhoQMap_cvjvNnK2Beuje2COo+F4hBzA@mail.gmail.com>
Message-ID: <CAJZ5v0i2pvTLwj7jTzwhoQMap_cvjvNnK2Beuje2COo+F4hBzA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] thermal/debugfs: Fix and clean up trip point
 statistics updates
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 5:34=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 22/04/2024 13:37, Lukasz Luba wrote:
> > Hi Rafael,
> >
> > On 4/17/24 14:07, Rafael J. Wysocki wrote:
> >> Hi Everyone,
> >>
> >> The first patch in this series addresses the problem of updating trip
> >> point statistics prematurely for trip points that have just been
> >> crossed on the way down (please see the patch changelog for details).
> >>
> >> The way it does that renders the following cleanup patch inapplicable:
> >>
> >> https://lore.kernel.org/linux-pm/2321994.ElGaqSPkdT@kreacher/
> >>
> >> The remaining two patches in the series are cleanups on top of the
> >> first one.
> >>
> >> This series is based on an older patch series posted last week:
> >>
> >> https://lore.kernel.org/linux-pm/13515747.uLZWGnKmhe@kreacher/
> >>
> >> but it can be trivially rebased on top of the current linux-next.
> >>
> >> Thanks!
> >>
> >>
> >>
> >
> > I've checked this patch patch set on top of your bleeding-edge
> > which has thermal re-work as well. The patch set looks good
> > and works properly.
> >
> > Although, I have found some issue in this debug info files and
> > I'm not sure if this is expected or not. If not I can address this
> > and send some small fix for it.
> >
> > When I read the cooling device residency statistics, I don't
> > get updates for the first time the state is used. It can only
> > be counted when that state was known and finished it's usage.
> >
> > IMO it is not the right behavior, isn't it?
>
> Do you mean the right behavior is a regression

It has not changed AFAICS.

> or we should expect at least the residency to be showed even if the
> mitigation state is not closed ?

Well, in fact the device has already been in that state for some time
and the mitigation can continue for a while.

