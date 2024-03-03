Return-Path: <linux-kernel+bounces-89911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48BA86F730
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0830D281661
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5659D7A701;
	Sun,  3 Mar 2024 21:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mM4rjhyR"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964D535894
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709501454; cv=none; b=dbxWYxZoeZ+Zv2Y6u2gKk7qn0GkyZUoccK3yR3YgWlWfSPqtiwnvLm+j6xwhaqTQlYLkmLxHcoYuaKLYtKHAaMLFdmkn9bspD3ErS8ZeB7PeGUKX+EAKK//+jVOd+yHlnbSZBcZO4WOBxduz/KxNWwW7JyECPcGO1ecJsHUAuBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709501454; c=relaxed/simple;
	bh=M4+OCY/uRp3HpMu+qVLWRiaCccllGsWulyFk0dIdEdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijl4vvZWDU85yTKxNo/Jh9vkocFiW+RUT6bkYfyYguAOxqbPyy0+EkvySgI1Xn2pFKp18ffItsYOeGwiuMl+337v7cGAV6kFmTVSXqQkLLG/ZxENQfFxJpdmafmiTxQKsvGghWDJaI6dWRzGSpGshQb1/SrGhF4y9Sf3H/EjKig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mM4rjhyR; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc745927098so3298612276.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 13:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709501451; x=1710106251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6SUUto2WNajKxxMzEg1WXQSIUtWpWSxHng8wgSt1Kg=;
        b=mM4rjhyRMNcr7Xwa9Mvg1YvYlB28SIdBFdqRI56coIrNzCdNF59C2WXwM6mz5U4C1r
         TLM940hlQ40dNeP9/4grsksf/obF/Np7ls75JVwk5Sbr9RVftQPHcwCnXN6nXpqkXFOB
         3SWGcGuXKc/uzFva8+zaMW5iZnrPUAdg6hJ5l5EBICFW66bvvC69ElXyujbqnsY0bCLs
         ZEafZASn5wei2Ct1YPlnbh4NohhSfK6QcFH3LdDojWj7pnORAgrpYAdV2U+gtqcDVlBF
         Md1x9kN2Z0n6qFDQwTN9WZrrPzoQkyBtBjpOq+pmNgnXDGIr0LOwZrpW40TzYfpSKX4y
         fDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709501451; x=1710106251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6SUUto2WNajKxxMzEg1WXQSIUtWpWSxHng8wgSt1Kg=;
        b=hJ4w2RehXDw3cNIf+ng10KeS475a4j/OGXV2/VneRXRXcudLyEllylqhemY7H0aa4o
         mYM7dLzSln/yXxkYvmnerThQ4LOXUYiNu+KsSg1DQjS0pyMU8kR1Y5owSesf+H8IZobt
         W85PwMo/V2r1bwh1xa/McjYHJHlytm27DlNzJOFbRaaQA0YzKq6MoNJyNavYq+Ss2+Yw
         A9or4oFfwn0Aw0oFlwuGaPTfOOZN8HebTTamzkNFlCEWyc4ngCaLBIpBPwufp7221Hg/
         bAFPp3odFTOyh8YL955Sv4KWu18VNHkn3PeiiwJg9Wo8lJJIJqMoYVbVY2K4Kk+YenZa
         6KqA==
X-Forwarded-Encrypted: i=1; AJvYcCVlpEtVnesfuE2B7z0SMqNDCLFHNYoRw5kzQ4aYyOABXr74dsua0/eymZJHr3Nf6ZzD/jdmPu6hV8emAOBtLv1og/GigeaOhprmc+Hn
X-Gm-Message-State: AOJu0YzkAhcgnkKEQLvue+F/8E3RrE9iCnV8O8KhS4v++ZFBVugJxplU
	dyYFfGi7advFDJ30y1xhuLpZSc8Tjq13bq8NcvnEdLzpJUhGHJBo1ko90frYk1FPxo8SnPrt0+y
	lPVdOs4J+yGnhZc8B6b6XrklHj009r9ToMVrfMA==
X-Google-Smtp-Source: AGHT+IGmIGOehwMt+/9y7Z4fJonS8t0NtdnAk7g7kOPIhhmgzJonXuum5FtV6mjqdlCsGKf2c3pYXz3s3hr9Q+bBbjI=
X-Received: by 2002:a25:c5cb:0:b0:dcc:4b44:336c with SMTP id
 v194-20020a25c5cb000000b00dcc4b44336cmr5189770ybe.53.1709501451446; Sun, 03
 Mar 2024 13:30:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223223958.3887423-1-hsinyi@chromium.org> <20240223223958.3887423-2-hsinyi@chromium.org>
 <87wmqqjmt9.fsf@intel.com> <CAJMQK-jSPg6vU3SLmRy7zwNHJ4yqO2hT6RaiYxA4ifZ7CzwD9Q@mail.gmail.com>
 <CAD=FV=WU-2yystd40e+g9VNDNTiv5c=nP0uQg-AR03o7UGMTdA@mail.gmail.com>
 <87bk7z6x1w.fsf@intel.com> <CAD=FV=Wzm9Y7m9Q6KqO7yWdnc1xToaRMb2f1s2TQMJqpqVYLOg@mail.gmail.com>
In-Reply-To: <CAD=FV=Wzm9Y7m9Q6KqO7yWdnc1xToaRMb2f1s2TQMJqpqVYLOg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 3 Mar 2024 23:30:40 +0200
Message-ID: <CAA8EJpqHJTbc+TCpkccjx_eQH36zaNgcQ9QssecNeQUQgfYApQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm_edid: Add a function to get EDID base block
To: Doug Anderson <dianders@chromium.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Hsin-Yi Wang <hsinyi@chromium.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Feb 2024 at 19:11, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Feb 29, 2024 at 8:43=E2=80=AFAM Jani Nikula <jani.nikula@linux.in=
tel.com> wrote:
> >
> > On Wed, 28 Feb 2024, Doug Anderson <dianders@chromium.org> wrote:
> > > Hi,
> > >
> > > On Tue, Feb 27, 2024 at 5:27=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium=
org> wrote:
> > >>
> > >> On Tue, Feb 27, 2024 at 1:09=E2=80=AFAM Jani Nikula <jani.nikula@lin=
ux.intel.com> wrote:
> > >> >
> > >> > On Fri, 23 Feb 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > >> > > It's found that some panels have variants that they share the sa=
me panel id
> > >> > > although their EDID and names are different. Besides panel id, n=
ow we need
> > >> > > the hash of entire EDID base block to distinguish these panel va=
riants.
> > >> > >
> > >> > > Add drm_edid_get_base_block to returns the EDID base block, so c=
aller can
> > >> > > further use it to get panel id and/or the hash.
> > >> >
> > >> > Please reconsider the whole approach here.
> > >> >
> > >> > Please let's not add single-use special case functions to read an =
EDID
> > >> > base block.
> > >> >
> > >> > Please consider reading the whole EDID, using the regular EDID rea=
ding
> > >> > functions, and use that instead.
> > >> >
> > >> > Most likely you'll only have 1-2 blocks anyway. And you might cons=
ider
> > >> > caching the EDID in struct panel_edp if reading the entire EDID is=
 too
> > >> > slow. (And if it is, this is probably sensible even if the EDID on=
ly
> > >> > consists of one block.)
> > >> >
> > >> > Anyway, please do *not* merge this as-is.
> > >> >
> > >>
> > >> hi Jani,
> > >>
> > >> I sent a v2 here implementing this method:
> > >> https://lore.kernel.org/lkml/20240228011133.1238439-2-hsinyi@chromiu=
m.org/
> > >>
> > >> We still have to read edid twice due to:
> > >> 1. The first caller is in panel probe, at that time, connector is
> > >> still unknown, so we can't update connector status (eg. update
> > >> edid_corrupt).
> > >> 2. It's possible that the connector can have some override
> > >> (drm_edid_override_get) to EDID, that is still unknown during the
> > >> first read.
> > >
> > > I'll also comment in Hsin-Yi's v2, but given Hsin-Yi's digging and th=
e
> > > fact that we can't cache the EDID (because we don't yet have a
> > > "drm_connector"), I'd much prefer Hsin-Yi's solution here from v1 tha=
t
> > > allows reading just the first block. If we try to boot a device with =
a
> > > multi-block EDID we're now wastefully reading all the blocks of the
> > > EDID twice at bootup which will slow boot time.
> > >
> > > If you can see a good solution to avoid reading the EDID twice then
> > > that would be amazing, but if not it seems like we should go back to
> > > what's here in v1. What do you think? Anyone else have any opinions?
> >
> > I haven't replied so far, because I've been going back and forth with
> > this. I'm afraid I don't really like either approach now. Handling the
> > no connector case in v2 is a bit ugly too. :(
> >
> > Seems like you only need this to extend the panel ID with a hash. And
> > panel-edp.c is the only user of drm_edid_get_panel_id(). And EDID quirk=
s
> > in drm_edid.c could theoretically hit the same problem you're solving.
>
> Good point. That would imply that more of the logic could go into
> "drm_edid.c" in case the EDID quirks code eventually needs it.
>
>
> > So maybe something like:
> >
> >         u32 drm_edid_get_panel_id(struct i2c_adapter *adapter, u32 *has=
h);
> >
> > or if you want to be fancy add a struct capturing both id and hash:
> >
> >         bool drm_edid_get_panel_id(struct i2c_adapter *adapter, struct =
drm_edid_panel_id *id);
> >
> > And put the hash (or whatever mechanism you have) computation in
> > drm_edid.c. Just hide it all in drm_edid.c, and keep the EDID interface=
s
> > neat.
> >
> > How would that work for you?
>
> The problem is that Dmitry didn't like the idea of using a hash and in
> v2 Hsin-Yi has moved to using the name of the display. ...except of
> course that eDP panels don't always properly specify
> "EDID_DETAIL_MONITOR_NAME". See the discussion [1]. If you want to see
> some of the EDIDs involved, you can see Hsin-Yi's post [2]. The panels
> included stuff like this:
>
>     Alphanumeric Data String: 'AUO'
>     Alphanumeric Data String: 'B116XAN04.0 '
>
> The fact that there is more than one string in there makes it hard to
> just "return" the display name in a generic way. The way Hsin-Yi's
> code was doing it was that it would consider it a match if the panel
> name was in any of the strings...
>
> How about this as a solution: we change drm_edid_get_panel_id() to
> return an opaque type (struct drm_edid_panel_id_blob) that's really
> just the first block of the EDID but we can all pretend that it isn't.
> Then we can add a function in drm_edid.c that takes this opaque blob,
> a 32-bit integer (as per drm_edid_encode_panel_id()), and a string
> name and it can tell us if the blob matches?

Would it be easier to push drm_edid_match to drm_edid.c? It looks way
more simpler than the opaque blob.

> [1] https://lore.kernel.org/r/CAD=3DFV=3DVMVr+eJ7eyuLGa671fMgH6ZX9zPOkbKz=
YJ0H79MZ2k9A@mail.gmail.com
> [2] https://lore.kernel.org/r/CAJMQK-gfKbdPhYJeCJ5UX0dNrx3y-EmLsTiv9nj+U3=
Rmej38pw@mail.gmail.com



--=20
With best wishes
Dmitry

