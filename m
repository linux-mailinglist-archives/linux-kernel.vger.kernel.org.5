Return-Path: <linux-kernel+bounces-123293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA70689062F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD60E1C30288
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27B1137779;
	Thu, 28 Mar 2024 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K5bLOviP"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485A2137774
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644020; cv=none; b=ArifEUbg3+KsJmvFEw5nadSrwGzmgBslBnMaOKmxR07qgQ8KrCGoa48U6kbkdu/Yyae1MZm3ejfpJvLhLP61pw1PZSduen1l4935UkUb39VmNuR/iB+PDx6kjctXIBVkein2lAH2HGwT58ZjlElexDr1IewoB9gcZOqw9EAe4dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644020; c=relaxed/simple;
	bh=JukYux1lE2QutH9NWRSXKyGW55kBvsXf0kklaYf/Sz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AI5tuiRPSaNDr0XVK5SW5TPaI9lSFgWKbv6nFooMfVGuNGarFZVKkwtCjTexTvxlDq+rLb9iFVuU/hccVR12GDlKWLdxPxmNhas2t/D5nBz4PLqXuvydLvxPBy6j7wcYXb3wksE2p/GwO3WerbO6Voqn+VlNqfffYGRCWEEmt9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K5bLOviP; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78a746759b4so75659285a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711644012; x=1712248812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPv1IlNNd25MIWO2snW+UJ+Z3ASjHN9LM0c86t+nKQY=;
        b=K5bLOviP3mNl3nVMjA+qtDEOE6lbXd/RvD2zGCw4w7wGy1T6Uk++RvUuYg09SsBYrg
         E76lW4mTM5GuZFOE3rnnYy1YRvWCgOjYFzyQ9G78/B30GqTg/CmQXQTkrbgVYTXia9ex
         1tCjqitBHT0TepmYOGbufkF4szk9dqeENxQnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711644012; x=1712248812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPv1IlNNd25MIWO2snW+UJ+Z3ASjHN9LM0c86t+nKQY=;
        b=XRyIJrN/jtwoVEHrn+wX3Rzu/SNNg+JxktsplHEc4OUMNlyJfV9QqbTr6xuiSiGsmj
         RnHHyqcfOAyNmnuXWDtIPmGED67xJesP7u42oMU/SSXsuYLQFjE+04LxoySeSM4Nl8tc
         2/wXr3hKx5Iw+VBUTicgYe6ZzwM9LaDjNjAS8ubBWg/XkdyYPTa/l8gQ/btdXULIsA5F
         nnYGkcee3xHR31wOhWZEwPLlkIvpRgBr/JJ/zgg1pfXIGRSw53708OlXf1h/qnPmIkqf
         lEMVQfpk83P5kQoUmsEtBWdSH+EMdHmreUMsGlAzMt+sF/2tDVcpswXQTYyi/wagqA1R
         L1fg==
X-Forwarded-Encrypted: i=1; AJvYcCV414fYUVkuX0PhMyGhxe41/aoIp7VPsYI46+nXmjMSiDUuS/rFMHX+CJ8zRFrxdwtP6Gj0asDQCtqA9UdEUiOPxo/zEypQqeBLYjtb
X-Gm-Message-State: AOJu0YzQ9hZCOPWqSgV4PMcwTDOPpoTETZ8K9Ah1FNgymd4BF25F0Pui
	HjADRGCxRAS6aUlQyMxtE6/et3Yix96IXbC9O615XO/eWfenNGeHXxuFrpcceHgOydD9A7TgGLg
	=
X-Google-Smtp-Source: AGHT+IFwmjGri9VT2QsbqfC0FTzNJ6YFY+Hb6p68Al0FX4W6c03JOs6VNo7pti8KCvMWjWuwZf6XnA==
X-Received: by 2002:a05:620a:2fc:b0:78a:5d41:d1ee with SMTP id a28-20020a05620a02fc00b0078a5d41d1eemr2957425qko.72.1711644012166;
        Thu, 28 Mar 2024 09:40:12 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id h29-20020a05620a21dd00b00789f57cadc5sm658335qka.10.2024.03.28.09.40.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 09:40:11 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-431347c6c99so5481cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:40:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUToKvkkHomxXPEC9eWRf5mqtz7u6lOfzVkPBWKjBRfi0xOVm4NA6XdhtxnrmNeCXO3shvwmP3Wy+KHB16d1eptAwj6DYNAYqDMbJbS
X-Received: by 2002:a05:622a:410a:b0:431:8151:e7c1 with SMTP id
 cc10-20020a05622a410a00b004318151e7c1mr379066qtb.4.1711644008766; Thu, 28 Mar
 2024 09:40:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327202740.3075378-1-swboyd@chromium.org>
In-Reply-To: <20240327202740.3075378-1-swboyd@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 28 Mar 2024 09:39:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VLwa0AFsrXXxKGG+hcyW+h7u7-tyg3uoDB8M_XdPti_Q@mail.gmail.com>
Message-ID: <CAD=FV=VLwa0AFsrXXxKGG+hcyW+h7u7-tyg3uoDB8M_XdPti_Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix a black screen on sc7180 Trogdor devices
To: Stephen Boyd <swboyd@chromium.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Laura Nao <laura.nao@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 27, 2024 at 1:27=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
> This patch series fixes a black screen seen at boot on Trogdor devices.
> The details of that problem are in the second patch, but the TL;DR is
> that shared RCGs report the wrong parent to the clk framework and shared
> RCGs never get turned off if they're left force enabled out of boot,
> wedging the display GDSC causing the display bridge to fail to probe
> because it can't turn on DSI.
>
> The first patch is basically a hack. It avoids a problem where the mdss
> driver probes, turns on and off the mdp clk, and hangs the rotator clk
> because the rotator clk is using the same parent. We don't care about
> this case on sc7180, so we simply disable the clk at driver probe so it
> can't get stuck on.
>
> The second patch fixes the shared RCG implementation so that the parent
> is properly reported and so that the force enable bit is cleared. Fixing
> the parent causes the problem that the first patch is avoiding, which is
> why that patch is first. Just applying this second patch will make it so
> that disabling the mdp clk disables the display pll that the rotator clk
> is also using, causing the rotator clk to be stuck on.
>
> This problem comes about because of a combination of issues. The clk
> framework doesn't handle the case where two clks share the same parent
> and are enabled at boot. The first clk to enable and disable will turn
> off the parent. The mdss driver doesn't stay out of runtime suspend
> while populating the child devices. In fact, of_platform_populate()
> triggers runtime resume and suspend of the mdss device multiple times
> while devices are being added. These patches side-step the larger issues
> here with the goal of fixing Trogdor in the short-term. Long-term we
> need to fix the clk framework and display driver so that shared parents
> aren't disabled during boot and so that mdss can't runtime suspend until
> the display pipeline/card is fully formed.
>
> Stephen Boyd (2):
>   clk: qcom: dispcc-sc7180: Force off rotator clk at probe
>   clk: qcom: Properly initialize shared RCGs upon registration
>
>  drivers/clk/qcom/clk-rcg2.c      | 19 +++++++++++++++++++
>  drivers/clk/qcom/dispcc-sc7180.c | 14 ++++++++++++++
>  2 files changed, 33 insertions(+)

I spent a bunch of time discussing this offline with Stephen and I'll
try to summarize. Hopefully this isn't too much nonsense...

1. We'll likely land the patches downstream in ChromeOS for now while
we're figuring things out since we're seeing actual breakages. Whether
to land upstream is a question. The first patch is a bit of a hack but
unlikely to cause any real problems. The second patch seems correct
but it also feels like it's going to cause stuck clocks for a pile of
other SoCs because we're not adding hacks similar to the sc7180 hack
for all the other SoCs. I guess we could hope we get lucky or play
whack-a-mole? ...or we try to find a more generic solution... Dunno
what others think.

2. One thing we talked about would be adding something like
`CLK_OPS_PARENT_ENABLE_FOR_DISABLE` for all the RCGs. That should get
rid of the actual error we're seeing. Essentially what we're seeing
today is:

* RCG1 is parented on a PLL
* RCG2 is parented on the same PLL
* RCG1, RCG2, and the PLL are left enabled by the BIOS

When we enable/disable RCG1 then the PLL turns off (since we propagate
our disable to our parent and nothing else is keeping the PLL on). At
this time RCG2 is implicitly off (it's not producing a clock) since
its parent (the PLL) is off. ...but the hardware "force enable" bit
for RCG2 is still set to on and the kernel still thinks the child of
this clock is on.

If, after this, we "disabled" a branch clock child of RCG2 (because
it's unused and we get to the part of the kernel that disables unused
clocks) then we were getting the error since you can't change the
hardware "enable" bit for a branch clock if its parent is not
clocking.

..so `CLK_OPS_PARENT_ENABLE_FOR_DISABLE` would fix this specific case
because we'd turn the PLL on for the duration of the "disable" call.

..but there is still the concern here that there will be a period of
time that the RCG2 child is "stuck" even if we're not paying attention
to it. This would be the period of time between when we turned the PLL
off and we got around to disabling the RCG2 child because it was
unused. Stephen thought that perhaps something else in hardware
(perhaps a GDSC) might notice that the RCG2 child's hardware "enable"
bit was set and would assume that it was clocking. Then that other bit
of hardware would be unhappy because no clock came out. This concern
made us think that perhaps `CLK_OPS_PARENT_ENABLE_FOR_DISABLE` isn't
the right way to go.

3. Another idea was essentially to implement the long talked about
idea of "handoff". Essentially check the state of the clocks at boot
and if they're enabled then propagate the enable to our parents.

If we implement this then it would solve the problem because RCG1 and
RCG2 would add an implicit request for the PLL to be on. If we
enable/disable RCG1 at boot then the PLL will still stay on because
there's a request from RCG2. If/when we disable children of RCG2 then
the PLL will lose its request but that's fine. In no cases will we
have a hardware "enable" bit set without the parent.

This seems solid and probably the right solution.


Stephen was a bit concerned, though, because you don't know when all
your children have been registered. If a child shows up after "disable
unused" runs then you can get back into the situation again. That
probably isn't concern for the immediate problem at hand because all
the clocks involved show up in early boot, but it means that the
problem is half solved and that's not super satisfying.

To solve this, we need to overall solve the "disable_unused" problem
to be at the right time, after everything has had a chance to probe.
To me this feels a bit like the "sync state" problem with all the
baggage involved there. Specifically (like sync state) I think it
would have to be heavily based on analysis of the device tree and
links and that has the standard problem where you never enter sync
state when DT has a node "enabled" but you didn't happen to enable the
relevant driver in your kernel config. ...though I guess we've "sorta"
solved that with the timeout. NOTE: if I understand correctly this
would only be possible if drivers are using "struct clk_parent_data"
and not if they're just using global names to match clocks.

I'll also note that in general I believe Stephen isn't a fan of
"disable_unused", but (my opinion) is that it's important to have
something in the kernel that disables unused clocks when everything is
done loading. Without this we add a lot of complexity to the firmware
to turn off all the clocks that the SoC might have had on by default
and that's non-ideal.

-Doug

