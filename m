Return-Path: <linux-kernel+bounces-29324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2C3830CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04F128417B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F752376D;
	Wed, 17 Jan 2024 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CDus9cbU"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E313923765
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705516631; cv=none; b=pZn/OxgdYzimamSUeotNQ5QSKQFu9MYavwUe2MataeFLFN0X3Gq8imEwBY2HI0Xo+YxaU551QAJhqVk98A/HXjyF2iGv+RkO8QYPI5zYFBE5LvRrPfbBJ1Hp90zOpJcTjdu18sHp9ATDc7PpLlt+xaIEk1DVZnawbixFO7O6LfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705516631; c=relaxed/simple;
	bh=HxGUciIBuckpGOe+kmgopYi9nYhmcXqZnm7C/QozRFY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=NPIndwgBWzfPALFbtAIG212MhJmGyXNQH+WdkzSZz5X8ttHYUt1TL/faoPSsbFZNNDKZT7G+MXJ/zHtq+qkvewSbP2kcy1LOuT7gCahKlw/OKcqLumLjp420bffspZCl+yV0UbQfCX7Ftngra1duPZH4m+nJPscwEe1pDVsMr08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CDus9cbU; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-559c1396ecfso1804192a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705516627; x=1706121427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bvYD5YctFjlcXWn2S0lcBi88MDlkJ0fyWZbTuf+w4Q=;
        b=CDus9cbUaVPLR+wqgYom4eKWY6inS2XXqeozIhrYpYVTtkFw7q/WqIBpWo4Rg/eZNY
         zNgrZC2YSoK1ats4bV3RrWY4SuA85JTzVlHGXlgpHRK9L8IZ5j4Bu2v78Q/vw1sFz+fz
         TafeXyVN5FMVsSAGUQd6crH6C42sWfhTDOY7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705516627; x=1706121427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bvYD5YctFjlcXWn2S0lcBi88MDlkJ0fyWZbTuf+w4Q=;
        b=rHQkBjU/drmAZmq6SavHicHX1dhLv5sv3jpzfjS1t/pPIdfWzLihHNKxrBvBen2ly9
         B1hb52ovhnbJD5jYzki/bJl7D4m8Ur3iczVi3xFCCFlSJYqdrLZBflOhhTgdQiXJZfFG
         ru41FvYYC/Wkzh6yo7RjcAp8xjNfKMHBYxtEAPu3yttSWPlEC2uhldR2FlsdpQOCVPq2
         xgo/eqFCR0vCpjj+roCyT1uHcfloFo5vCA/U6MrbnQ3+YR0NLxbue9Lbmq2n13RUOpx/
         CNh3V11MoB84njm5w3kllQwfS7peTK7EQszCNlDY4dSXTz7l7U3c0djznVkR87oaeuoR
         3w/g==
X-Gm-Message-State: AOJu0YyZdPS5s7KQih4TxYhP8xtkTNS23HaWaysPWjNTkx7WYnFze+p2
	CDGLyR9DNm8tcpJoUyPFa7WOLnGgM/xQwjIbNkTNmBjBfF8vx6c=
X-Google-Smtp-Source: AGHT+IFNwQXcGnU/G/8fnKDF/mLh6CkfYSn1fAdwyWP7AyEFl6YX/EU2ekJO1lERflmoXCPp5Q84CA==
X-Received: by 2002:aa7:df08:0:b0:559:f84f:2028 with SMTP id c8-20020aa7df08000000b00559f84f2028mr87516edy.31.1705516627401;
        Wed, 17 Jan 2024 10:37:07 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id ef5-20020a05640228c500b00557d839727esm8440869edb.7.2024.01.17.10.37.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 10:37:07 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e43e55b87so63365e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:37:06 -0800 (PST)
X-Received: by 2002:a05:600c:1990:b0:40e:863c:89d5 with SMTP id
 t16-20020a05600c199000b0040e863c89d5mr183514wmq.2.1705516625942; Wed, 17 Jan
 2024 10:37:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109120528.1292601-1-treapking@chromium.org>
 <CAD=FV=WjjH3BCDf-OnX=zdk201uMu+YJvKVBhVmMa4GqNinacw@mail.gmail.com> <CAD=FV=Va-67xojWbm-8MBCxaDG19gQhmNr3V_sBwYUkDkny9GQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Va-67xojWbm-8MBCxaDG19gQhmNr3V_sBwYUkDkny9GQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 17 Jan 2024 10:36:49 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UJMVZATztLsx9YCkV37TYuS_mphbHzhqrS3qNKQCzVAA@mail.gmail.com>
Message-ID: <CAD=FV=UJMVZATztLsx9YCkV37TYuS_mphbHzhqrS3qNKQCzVAA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: parade-ps8640: Ensure bridge is suspended
 in .post_disable()
To: Pin-yen Lin <treapking@chromium.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 17, 2024 at 9:34=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Tue, Jan 9, 2024 at 8:52=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
> >
> > Hi,
> >
> > On Tue, Jan 9, 2024 at 4:05=E2=80=AFAM Pin-yen Lin <treapking@chromium.=
org> wrote:
> > >
> > > The ps8640 bridge seems to expect everything to be power cycled at th=
e
> > > disable process, but sometimes ps8640_aux_transfer() holds the runtim=
e
> > > PM reference and prevents the bridge from suspend.
> > >
> > > Prevent that by introducing a mutex lock between ps8640_aux_transfer(=
)
> > > and .post_disable() to make sure the bridge is really powered off.
> > >
> > > Fixes: 826cff3f7ebb ("drm/bridge: parade-ps8640: Enable runtime power=
 management")
> > > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - Use mutex instead of the completion and autosuspend hack
> > >
> > >  drivers/gpu/drm/bridge/parade-ps8640.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> >
> > This looks OK to me now.
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > I'll let it stew on the mailing list for ~1 week and then land it in
> > drm-misc-fixes unless there are additional comments.
>
> Pushed to drm-misc-fixes:
>
> 26db46bc9c67 drm/bridge: parade-ps8640: Ensure bridge is suspended in
> .post_disable()

Crud. I landed this and then almost immediately hit a bug with it. :(
I've posted up the fix:

https://lore.kernel.org/r/20240117103502.1.Ib726a0184913925efc7e99c4d4fc801=
982e1bc24@changeid

-Doug

