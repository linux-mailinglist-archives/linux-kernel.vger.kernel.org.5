Return-Path: <linux-kernel+bounces-29688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE088311BE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 04:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18004285106
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FC2AD5A;
	Thu, 18 Jan 2024 03:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oIPQS9Bi"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B0DAD32
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705548323; cv=none; b=uYLgOyZH2XJMcQwEMepnnuix1YFG3+AmLml9p4phwN0Fb7YlMiMj4CbZAfMf8xQb02gl9Ymu+40JwXodSr8SDDY7250Xjuvf13erPjP9YRgueOj2LJ2Qwn2IHp5uzGR1UtZ4zAh4vsmi9a+onliDCx/2cTRrTCYkE9zccAqva+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705548323; c=relaxed/simple;
	bh=M7BOYEdezAOzVq0xrdZOq9iiRomKdt1QdNIDNsIFjCU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=riGkAFWYDOkbmRiqcCKtLMfeoYjnCQl3jmVmjrqMf5cCqU3VK4o2i+DzLTSBSziAcyR+kjM8Pz9dEL0K5nwzxX1YCAgNl7wMi7DxPf0lUHFyyGiCfBAUuqPN8uu423MPZrr9q7Gc/FDqi9xcDlckg6c63Q40bnsflMXd171matk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oIPQS9Bi; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3608402ab93so43088685ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 19:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705548321; x=1706153121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ii56IFJu065FnMv6OshmGSGQK3NaWenX9LFIh28GHDw=;
        b=oIPQS9BiBxJB8eJgU1V4qnfX9W2ozAMT9vlV6KtIsSLHezifz1A0R91rtk9hhcf3y1
         pFdilCpp8rwjzNw2earg5jSgjUoItRRdTx30BQFoDPN5zzVoVJ0PCMsuRLaz9kgbEwGy
         Szv8n6jTECugh2VSFYYwHvhAuecuGHHuU7q/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705548321; x=1706153121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ii56IFJu065FnMv6OshmGSGQK3NaWenX9LFIh28GHDw=;
        b=QuIpq5l6JGlERaZjN92d6AWNXOMH0eYwsQzVYNxbIQLP8NTzoHbOgX9Rix/kOjba9Z
         AB6tDYfbrux7So8DgPKnJMCcQNM/Y9wf41Myem8uS+wbgKojrRics1VzvJ3wG5Y5xNAY
         j/h37ShlsFsebx6fRygOXL5Bxl8KErMFFSrtGysZLTNR33C81vhipDD0Apy6Cjtj0xot
         GJQerFM3/5waEj4Ahv27MZxyX38fGE58/qYwGSY7j35zTDNWbRI2pGNTfKSV2OSpNIUs
         uDkwwFMFRloNP0sH907r+iBWf9T2YnfmA1zNzINgUOzWyO6H2bJAx/XvPKm4h9ZWWu/U
         C2Fg==
X-Gm-Message-State: AOJu0Yyw0EiYztjhbNnaIW6zBI+LSJ2TNNDqeRzWpaq9m4jUEVKyyt1c
	5o6k6kG9CCb62XRYmFsPgHZfz0lFqQX05OeHtw0xt30ry6DKtNcATsQJJbt8wibHQfJFs25hsQy
	9df+3E10dJ2xLogc6S2qEqM2BhX10wn2G6O2B
X-Google-Smtp-Source: AGHT+IE9D1TMeIh1UjhzZONIVYL35nzwGM7vKMti5Frnt+mKigLTifEXOn/4P8AZkmNo4W2eFWm7k1x7hjd+mCT2haA=
X-Received: by 2002:a05:6e02:1bc9:b0:361:8c6f:fbd0 with SMTP id
 x9-20020a056e021bc900b003618c6ffbd0mr388527ilv.49.1705548320834; Wed, 17 Jan
 2024 19:25:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109120528.1292601-1-treapking@chromium.org>
 <CAD=FV=WjjH3BCDf-OnX=zdk201uMu+YJvKVBhVmMa4GqNinacw@mail.gmail.com>
 <CAD=FV=Va-67xojWbm-8MBCxaDG19gQhmNr3V_sBwYUkDkny9GQ@mail.gmail.com> <CAD=FV=UJMVZATztLsx9YCkV37TYuS_mphbHzhqrS3qNKQCzVAA@mail.gmail.com>
In-Reply-To: <CAD=FV=UJMVZATztLsx9YCkV37TYuS_mphbHzhqrS3qNKQCzVAA@mail.gmail.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Thu, 18 Jan 2024 11:25:09 +0800
Message-ID: <CAEXTbpfo7YsEi7uYcYen82vHg0F=Ataca=FocwF1Jr0-6MpgyA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: parade-ps8640: Ensure bridge is suspended
 in .post_disable()
To: Doug Anderson <dianders@chromium.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Thu, Jan 18, 2024 at 2:37=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Wed, Jan 17, 2024 at 9:34=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Tue, Jan 9, 2024 at 8:52=E2=80=AFAM Doug Anderson <dianders@chromium=
org> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Jan 9, 2024 at 4:05=E2=80=AFAM Pin-yen Lin <treapking@chromiu=
m.org> wrote:
> > > >
> > > > The ps8640 bridge seems to expect everything to be power cycled at =
the
> > > > disable process, but sometimes ps8640_aux_transfer() holds the runt=
ime
> > > > PM reference and prevents the bridge from suspend.
> > > >
> > > > Prevent that by introducing a mutex lock between ps8640_aux_transfe=
r()
> > > > and .post_disable() to make sure the bridge is really powered off.
> > > >
> > > > Fixes: 826cff3f7ebb ("drm/bridge: parade-ps8640: Enable runtime pow=
er management")
> > > > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - Use mutex instead of the completion and autosuspend hack
> > > >
> > > >  drivers/gpu/drm/bridge/parade-ps8640.c | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > >
> > > This looks OK to me now.
> > >
> > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > >
> > > I'll let it stew on the mailing list for ~1 week and then land it in
> > > drm-misc-fixes unless there are additional comments.
> >
> > Pushed to drm-misc-fixes:
> >
> > 26db46bc9c67 drm/bridge: parade-ps8640: Ensure bridge is suspended in
> > .post_disable()
>
> Crud. I landed this and then almost immediately hit a bug with it. :(
> I've posted up the fix:
>
> https://lore.kernel.org/r/20240117103502.1.Ib726a0184913925efc7e99c4d4fc8=
01982e1bc24@changeid
>
> -Doug

Sorry, I missed this because the patch was based on drm-misc-next, so
it did not include commit 024b32db43a3 ("drm/bridge: parade-ps8640:
Wait for HPD when doing an AUX transfer").

I also forgot to apply that commit when I did my testing.

Pin-yen

