Return-Path: <linux-kernel+bounces-117562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 723A588AC9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AB71FA3A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA7D13C83B;
	Mon, 25 Mar 2024 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PX/58+xC"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC61713BAD7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386972; cv=none; b=CAsDeisYbKUMoe/5zYJwgsyRz5yDkz28vmHpZTGHTivev8FkB/EV3ZxNQDaVQ9G0DeohPb98suiJKRtGYK6FrlATbZuOnZi7Lx2uOY4rli3Q9EgCVQXB62R+6df3S/3Lkozgl3+u6Zr5cI1qh5UOX0DGMbSB983PmQL3Cj2ERNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386972; c=relaxed/simple;
	bh=5z7JWgRm+prE8c9r61qKqkGGuVaMbLVUWLsiDunLhpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMdLMNDRLtjzimvMIxNnxwZU4g541AHSKFsND0VytT79GQdMjTS62JzX9SBtsgiByjmxfhgIv5oUmp5whHtgcAxKlZZPQO3EuBqH7HP+pnmnivA3qvn/cEk6f486RO8P86dqdI2pdBhpbGQk5rm4RjYgWgYQkFwCS2cKA3kJSfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PX/58+xC; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c3ceeb2d04so563618b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711386967; x=1711991767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5z7JWgRm+prE8c9r61qKqkGGuVaMbLVUWLsiDunLhpA=;
        b=PX/58+xC1fNRI6lc5d432WfiXaq3h0SrIUmAt1aLuSIX0ZTRrBKPdx6mM99YRu7etI
         x6K40p2FcwKvIJhXQlKsFEJsXKfXz9tzNWLBjSYjjgHVNTvMcCLfkikVdcczozM/YlAU
         PP8DJdVYH/Tfq3/z8HH5a5hbfrU2+B4REx7Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711386967; x=1711991767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5z7JWgRm+prE8c9r61qKqkGGuVaMbLVUWLsiDunLhpA=;
        b=dhUiYwUikCFgMGQTiHwf8GGSn4To+qKvD0pVT+Pj+UAb4nnL3GLocicRo4B9RqcrUa
         rlkaVecRLSygDyQmnb/yDU9YPR0aSiBpWAT/Y0+l4xmef/DnY/O0k2JQuUu4KZEdxBQi
         FwA9P9MA8Sb8zS658WVwslrUsEFTQkXcFQbwQdD935Q8+vU/fD1MV4b3JWNwgOfx+XG+
         u96O7cr3yyeFsAiGjXv94z0tqpy0ASqJBDLBdN+4r4fCVzjyk5MPyj3WWiB54CUF5HxE
         CRZUTy5z8RfdxsGvs2jSMXTyDJE3ZA97BXcZx6ZE5QQuMclhwmV/tnfz7QL8OtTZBrLf
         YKGA==
X-Forwarded-Encrypted: i=1; AJvYcCWHxKQirAbfxh6shrbLeXK2kriIrKqFZdmQAeOQ53RrIhAXIngQYL7tU9WRObjZjSU0dxGI6VHJGmmsVOUqWdtyDtvMen0R7g85scMJ
X-Gm-Message-State: AOJu0Yxgf1PIOwu0leKDA9K7M172B3oJ64R3EjG15qwA/owJpLIbZiQ5
	GsJeSewufolXP36hhJzdJ9u55cTJNgwGHAPpL+gKVkh3B796vaOaUWGGZvS18uvgWwSrCqNPgcY
	=
X-Google-Smtp-Source: AGHT+IHt0uCP1uxFT41AgPIV8sv3zAT91T7zEUw7XKih3D5k1U48qocC3QwhSk0va+LU2nGEeMnGcA==
X-Received: by 2002:a05:6808:13ce:b0:3c3:c12e:c13e with SMTP id d14-20020a05680813ce00b003c3c12ec13emr522105oiw.43.1711386967660;
        Mon, 25 Mar 2024 10:16:07 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id ph16-20020a0562144a5000b006967ba7f1adsm2753940qvb.96.2024.03.25.10.16.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 10:16:07 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-430d3fcc511so8971cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:16:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/vATWsrV6Dj+qp4MtF2Ba/EXAQQak+riTV3ED0+0De+h+N0N3HVBeya4++zEuktMRrOWxwdBKT1kd/UAcSGGTDPkF8B4lrDSQal5q
X-Received: by 2002:a05:622a:2a06:b0:431:baa:825 with SMTP id
 hc6-20020a05622a2a0600b004310baa0825mr1246888qtb.25.1711386965873; Mon, 25
 Mar 2024 10:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325054403.592298-1-sboyd@kernel.org> <20240325054403.592298-5-sboyd@kernel.org>
 <CAD=FV=Ws-LYcpiitibPBPRhqrbS8rTo_7xtPPw2kA+qBzybOxQ@mail.gmail.com> <42ae624ca2289fb82e00f3ac8938d05e.sboyd@kernel.org>
In-Reply-To: <42ae624ca2289fb82e00f3ac8938d05e.sboyd@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 25 Mar 2024 10:15:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XcHdEiMf8Z228sT=ChvjJs8Ujw6q8Hcf4b588ocwJHiQ@mail.gmail.com>
Message-ID: <CAD=FV=XcHdEiMf8Z228sT=ChvjJs8Ujw6q8Hcf4b588ocwJHiQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] clk: Get runtime PM before walking tree during disable_unused
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 25, 2024 at 10:06=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wr=
ote:
>
> > > +/*
> > > + * Call clk_pm_runtime_get() on all runtime PM enabled clks in the c=
lk tree so
> > > + * that disabling unused clks avoids a deadlock where a device is ru=
ntime PM
> > > + * resuming/suspending and the runtime PM callback is trying to grab=
 the
> > > + * prepare_lock for something like clk_prepare_enable() while
> > > + * clk_disable_unused_subtree() holds the prepare_lock and is trying=
 to runtime
> > > + * PM resume/suspend the device as well.
> > > + */
> > > +static int clk_pm_runtime_get_all(void)
> >
> > nit: It'd be nice if this documented that it acquired / held the lock.
> > Could be in comments, or, might as well use the syntax like this (I
> > think):
> >
> > __acquires(&clk_rpm_list_lock);
> >
> > ...similar with the put function.
>
> I had that but removed it because on the error path we drop the lock and
> sparse complains. I don't know how to signal that the lock is held
> unless an error happens, but I'm a little out of date on sparse now.

I'd settle for something in the comments then? Maybe tagged with "Context:"=
 ?

Thanks!

-Doug

