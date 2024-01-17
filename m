Return-Path: <linux-kernel+bounces-29276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7145B830C00
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13843B24933
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3D42263A;
	Wed, 17 Jan 2024 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HaTqRKA2"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C3225DE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705512908; cv=none; b=n5MQszpbXh96dZEM4ARCR27HZTsE9NuxCDsfGc6dXHIhtfpDVJMNUO11siUW6IYam1ITAATayMlb1q45QIdG4iTJoCfctFP9txSLa7oQkcNg1A1L+n8r12x14hJpdWps/CrQ7v6NcI5vy8/nG7oeu3D0O5X31igPHW7erXFG1FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705512908; c=relaxed/simple;
	bh=lqzoX95WO4GKaKEgXr0lsnk6tNZCK832/4Z65BP28p8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=sPWcDIXNc31udeG3ZHu8K++NRb7wrTrkN1rbH5yT3vlPTMpyoNkzQm/vLaXWjVWyBO6gqaxUzRUADb/HFCjYKNzu7ceQsFNyQGGEkrGDFc4+IgBs69OpIa4jiC4RzVdST9LDO86XpXyk6kEoeF0NdvkfMZ9U6eJ1ugiKmzi7izE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HaTqRKA2; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cd0f4f306fso132456861fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705512903; x=1706117703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMltNFrkMZ6CS156UQXDFciqpUkUbjTQoqkBzQba0M8=;
        b=HaTqRKA28+83QzABgB00yoVIT1m32GdiER+zkxo0umHyY2RRi/4WduoqyzHh791TxM
         NCCO+U69FzHdAahX6KLIDw9sQ1BGmRtpzTH+y6LOAqiIEsBbhN5l8Joqi5mADyOu5oYu
         dby6NKK41v05fSskBddxmrVzA5/s2lGPQ+dDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705512903; x=1706117703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMltNFrkMZ6CS156UQXDFciqpUkUbjTQoqkBzQba0M8=;
        b=F0M9iPF0UAOk+YTiFWVbBeqR8zcT887Yp+QdkYsg1uYJH+LXYwJamiLz0gie+JqCkq
         ExsBWNuPLPGg5NEQPim3U4FvhPI1Kgcd59DeTL5fRoT8g31/FCcXx0+kcn/e+oCTbdQO
         om1CQGwRZxl6yBUXIRkg3v55FJUV3MoFveC1/jHnBPkU/yJeFWkklcOwU5lNluePV6ak
         jkQkC/1YqMCm2Z3pdcg6O/lIW3qfsR0Lns4RUNbDuo4MiQqTCXXeG5i2bsw87Y6sBqWF
         L/wN+FenjbLkkY/iBjJ0YKscBql9MRylsXf2y4ubAVsy58lUdxuZ+n4jsmg/yb/lbcsk
         Nimw==
X-Gm-Message-State: AOJu0Ywl5aKB1o2CafFadbn936EOUGJxqjpRcjwTrTute9ktO7OdG8M+
	zxyuLkYQs4+PUgKenVWK0CXbqGjfXTE+FAjDmd4BrubrxMUW
X-Google-Smtp-Source: AGHT+IFHsDrxqmDIT1lgrS3hMguY6+NhHYycuV4WLDZktRoZ4fxlttmhKfb/zGeJd6mvlR/iXNIyUg==
X-Received: by 2002:a2e:3c1a:0:b0:2cd:494b:b4aa with SMTP id j26-20020a2e3c1a000000b002cd494bb4aamr4494552lja.30.1705512902810;
        Wed, 17 Jan 2024 09:35:02 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id e5-20020a2e8185000000b002ccbc09230csm1982648ljg.97.2024.01.17.09.35.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 09:35:01 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50eb9d41d57so3269e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:35:01 -0800 (PST)
X-Received: by 2002:a05:6512:1318:b0:50e:84b4:2bdc with SMTP id
 x24-20020a056512131800b0050e84b42bdcmr140208lfu.2.1705512900966; Wed, 17 Jan
 2024 09:35:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109120528.1292601-1-treapking@chromium.org> <CAD=FV=WjjH3BCDf-OnX=zdk201uMu+YJvKVBhVmMa4GqNinacw@mail.gmail.com>
In-Reply-To: <CAD=FV=WjjH3BCDf-OnX=zdk201uMu+YJvKVBhVmMa4GqNinacw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 17 Jan 2024 09:34:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Va-67xojWbm-8MBCxaDG19gQhmNr3V_sBwYUkDkny9GQ@mail.gmail.com>
Message-ID: <CAD=FV=Va-67xojWbm-8MBCxaDG19gQhmNr3V_sBwYUkDkny9GQ@mail.gmail.com>
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

On Tue, Jan 9, 2024 at 8:52=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Tue, Jan 9, 2024 at 4:05=E2=80=AFAM Pin-yen Lin <treapking@chromium.or=
g> wrote:
> >
> > The ps8640 bridge seems to expect everything to be power cycled at the
> > disable process, but sometimes ps8640_aux_transfer() holds the runtime
> > PM reference and prevents the bridge from suspend.
> >
> > Prevent that by introducing a mutex lock between ps8640_aux_transfer()
> > and .post_disable() to make sure the bridge is really powered off.
> >
> > Fixes: 826cff3f7ebb ("drm/bridge: parade-ps8640: Enable runtime power m=
anagement")
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Use mutex instead of the completion and autosuspend hack
> >
> >  drivers/gpu/drm/bridge/parade-ps8640.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
>
> This looks OK to me now.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> I'll let it stew on the mailing list for ~1 week and then land it in
> drm-misc-fixes unless there are additional comments.

Pushed to drm-misc-fixes:

26db46bc9c67 drm/bridge: parade-ps8640: Ensure bridge is suspended in
post_disable()

