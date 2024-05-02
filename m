Return-Path: <linux-kernel+bounces-165872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8372B8B92BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20A91C2146F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E416EA921;
	Thu,  2 May 2024 00:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bugOooDb"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C697322B
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 00:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714609222; cv=none; b=eiw+l+uRVKg3Mp8xZ/g1Nv4JT+Vu5Ki/0rTV7PbsSzp57ic4zB5+vxQ3J6tjx144NXsndZIZrJk+lqugX4S5Ruz9G2zah6Izpx4zAyheXscueFpDocz+0PuMaaXvqa4S/mXz7Xl2T7eHsc6OSYcmN+kuUkuxj7xLs7ZXsSPtHk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714609222; c=relaxed/simple;
	bh=u41EwqRKzoIPMnwx3uJD5HnTN0ef2JtTmKQdCY/Erwc=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyv76VG5x/6IU2yAR1TK1tuA87f1QZmL8U+umjDLqGpyVA+VJCh3hr1NOCwFp/Fna7yFz58bhliQR9fjwor1xfva1L3M9KCf6E72e7Dkt4yJfXE5rJlfxe01o3ZHbzDXtL7LgCUJF73f3bk8tR1wscG+pYdfgyZvnf8AelAlESc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bugOooDb; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-69b514d3cf4so80599696d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 17:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714609219; x=1715214019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u41EwqRKzoIPMnwx3uJD5HnTN0ef2JtTmKQdCY/Erwc=;
        b=bugOooDbNCoejEADieRSHfp+9g6wkP/WY5N81ay1vzvGoq9aDajmDDrc4ebJcA7tpO
         xqIBRAA74ziMGHE6IaKSd1sj/mPgs75ZJslJq9k3nI59loWl7hpzCBET6TrcqCndATp0
         Lbk1EQfNSufBOQlfVmf7Lb0BrTUMmJmp03A+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714609219; x=1715214019;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u41EwqRKzoIPMnwx3uJD5HnTN0ef2JtTmKQdCY/Erwc=;
        b=F5m2Zo0iilQtV8YeEvAoBavVEXntjgS5tO3VtAf/oXsJceox12rh6sJ5w7ZJs2FHbT
         NKuS8iJfrtMBxOZpuvIQ0E7AohroX7QWqhdbElyvV5bhenK3naYoRro7Y/FRevuE/cEb
         HSgUcP29Ck7j7SnitHqkaaPwUcoAQ9THd6DFHtQpy7k2wiFWZA8fIiVEGdpY/Gd3jonP
         ykHHDWpUcMez8Q340EaSqg+N1xIsBM2UL4N2D7HeCyrno2ZLmO8/snGTh8HBGQfwwTXp
         YlKGHhudG2/JRf32wUWsQCcAbTnMAr9fhNY/J1EJ9CtrHqlsh3wyQALZQ5+oHDmLKzXH
         G7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1ahlKod9odlrQlDTt+6Zdou8eBMnVGxmD0WgZM6xlFRXaCeaLtMY5egEFB+NYFrZ/AhgX4FN3h9aFrEMPhZ0vwEfUDbLXGRGXEeeV
X-Gm-Message-State: AOJu0Ywa3un/TkFUAE4HH5LT0vQDNJa9I0v529s17lnu+g7Wj1C7Ys0l
	IKwGLQ3Ne0FYVO7I1EYwjutIA2gx69O6Pcjd7jalj253o8PevsXBReAeAhPcH2Sm9Fi9AlHifYj
	j4TUhZB3lLEK0cqagwSwLv5I1fpakbQcKiFRj
X-Google-Smtp-Source: AGHT+IEc1eTRsFE6XeEVTYHiMbtnza7LGG/rlt3ScVq6rOvZPlhWc3Y03+hhqJKXzOZ75M3+vGyimImWhMVDRjS2H9g=
X-Received: by 2002:ad4:5baa:0:b0:6a0:8511:98e0 with SMTP id
 10-20020ad45baa000000b006a0851198e0mr443958qvq.22.1714609219471; Wed, 01 May
 2024 17:20:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 May 2024 17:20:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAA8EJpqVGHqufKo1kV52RzQCNL5D92mmnCzUwKZn4o+5=wF9pQ@mail.gmail.com>
References: <20240327202740.3075378-1-swboyd@chromium.org> <CAD=FV=VLwa0AFsrXXxKGG+hcyW+h7u7-tyg3uoDB8M_XdPti_Q@mail.gmail.com>
 <CAE-0n51osUcpqqh6o9OhURLbRKjcWbRZT-5oHLi_mwfJsUngEw@mail.gmail.com> <CAA8EJpqVGHqufKo1kV52RzQCNL5D92mmnCzUwKZn4o+5=wF9pQ@mail.gmail.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 1 May 2024 17:20:18 -0700
Message-ID: <CAE-0n52knCL3DP35jg8UhTJP6wxQ5Fueq9Qa796O9hKuEFPRQg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix a black screen on sc7180 Trogdor devices
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>, 
	Laura Nao <laura.nao@collabora.com>
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-05-01 11:11:14)
> On Wed, 1 May 2024 at 03:17, Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Doug Anderson (2024-03-28 09:39:54)
> > >
> > > I spent a bunch of time discussing this offline with Stephen and I'll
> > > try to summarize. Hopefully this isn't too much nonsense...
> > >
> > > 1. We'll likely land the patches downstream in ChromeOS for now while
> > > we're figuring things out since we're seeing actual breakages. Whether
> > > to land upstream is a question. The first patch is a bit of a hack but
> > > unlikely to cause any real problems. The second patch seems correct
> > > but it also feels like it's going to cause stuck clocks for a pile of
> > > other SoCs because we're not adding hacks similar to the sc7180 hack
> > > for all the other SoCs. I guess we could hope we get lucky or play
> > > whack-a-mole? ...or we try to find a more generic solution... Dunno
> > > what others think.
> >
> > I think we should hope to get lucky or play whack-a-mole and merge
> > something like this series. If we have to we can similarly turn off RCGs
> > or branches during driver probe that are using shared parents like we
> > have on sc7180.
> >
> > Put simply, the shared RCG implementation is broken because it reports
> > the wrong parent for clk_ops::get_parent() and doesn't clear the force
> > enable bit. With the current code we're switching the parent to XO when
> > the clk is enabled the first time. That's an obvious bug that we should
> > fix regardless of implementing proper clk handoff. We haven't
> > implemented handoff in over a decade. Blocking this bug fix on
> > implementing handoff isn't practical.
>
> Yes, that needs to be fixed. My approach was to drop the XO parent and
> consider the clock to be off if it is fed by the XO.
>
> > Furthermore, we're relying on clk
> > consumers to clear that force enable bit by enabling the clk once. That
> > doesn't make any sense, although we could use that force enable bit to
> > consider the RCG as enabled for clk_disable_unused.
>
> That patch seems fine to me. Will it work if we take the force-enable
> bit into account when considering the clock to be on or off?

What is "that patch"?

It would work to consider the rcg clk as on or off. During rcg clk
registration if a branch child is found to be enabled we would go and
write the force enable bit in the parent rcg. And similarly we would
modify the rcg clk_ops to set that bit whenever the clk is enabled and
clear it whenever it is disabled. This avoids the feedback mechanism
from confusing us about the enable state of the rcg, at the cost of
writing the register.

It wouldn't fix the problem that we have on Trogdor though. That's
because the display GDSC is turned off when the rotator clk is enabled
and parented to the display PLL, which is also turned off. We have to
either turn off the rotator clk, or switch the parent to something that
is always on, XO, or keep the display GDSC on until the rotator clk can
be turned off. On other SoCs we may need to turn off even more clks
depending on which ones the display GDSC is controlling.

>
> >
> > An alternative approach to this series would be to force all shared RCGs
> > to be parented to XO at clk registration time, and continue to clear
> > that RCG force enable bit. That's sort of what Dmitry was going for
> > earlier. Doing this would break anything that's relying on the clks
> > staying enabled at some frequency through boot, but that isn't supported
> > anyway because clk handoff isn't implemented. It avoids the problem that
> > the first patch is for too because XO doesn't turn off causing a clk to
> > get stuck on. I can certainly craft this patch up if folks think that's
> > better.
>
> I think this approach makes sense too (and might be preferable to
> boot-time hacks).
> On most of the platforms we are already resetting the MDSS as soon as
> the mdss (root device) is being probed. Then the display is going to
> be broken until DPU collects all the coonectors and outpus and finally
> creates the DRM device.

Ok. I'm leaning towards this approach now because it seems like keeping
the clk at whatever it was set at boot isn't useful. If it becomes
useful at some point we can implement a better handoff mechanism. I have
some idea how to do that by using the 'clocks' DT property to find child
clks that haven't probed yet. I'll test out this alternate approach to
park shared clks at probe and send the patch.

>
> But I think we should fix the get_parent() too irrespectively of this.
>

Sure, but it becomes sorta moot if we force the parent to be XO.

