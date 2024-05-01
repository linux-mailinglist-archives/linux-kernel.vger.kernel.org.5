Return-Path: <linux-kernel+bounces-165554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AE38B8DE8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA370281D72
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65BA12FF87;
	Wed,  1 May 2024 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FVe1JJuu"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55E114012
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580317; cv=none; b=ivd8hCXfEKnirgAwHwDXS5an6cAkIdPL+TlF2XgbLNhNVLkK4Kz8bcMPfQCP1WJkafHf+sDZo0vNSj4YNgxipfQj6qoHX1H1MNO2MhfVxtC35YzhUnI8+vW3FeNnxs4Fk8QlCmDPPbJ5izbp5yxkuIyID6l2tLEgmDpSbdn3dHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580317; c=relaxed/simple;
	bh=RrsRAJmWysXYR4n1Z7QuovA3tEKIJY2HwJxpKg4/cqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enNOjcUtaqEgCWVXj4jucy173yXj2SUvNizs2A6A0dcKoOxKA7aPROFpgi6EApwkqPkcl7EDY6Pzq12/NLtFa9DoLK1CdYTzDg3R9fsFLJ2gFa/St3AeIqi7WyhuBMcM2D+gxNR/tTJNL5TuxBmupWQSxfUCzhUHjrQxkjY4dJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FVe1JJuu; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c865f01b2bso2108015b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714580314; x=1715185114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrsRAJmWysXYR4n1Z7QuovA3tEKIJY2HwJxpKg4/cqM=;
        b=FVe1JJuuwmeJUs0Vbjx+S2qWt8uj0yXY/nTokp3DIy0kOqT2dgy+Kk4ID3SQ1A3jth
         Qoj6zSpLeFDLCiIWhZkf6Xkz2raTesIi6rpD6DuDQznHSKVnyq1+KJpFPP5Vp+x8FsVT
         UE8xk+zmprXSvGHkjCh3knKhZWits+3k3FlVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714580314; x=1715185114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrsRAJmWysXYR4n1Z7QuovA3tEKIJY2HwJxpKg4/cqM=;
        b=j2TPV6GD8Y00wO0dIlkirEej+xRABnoVR/nNDc3EW1jDFQWaOLGFEkPT1zJjBMJScb
         z3HjYjRG00ExVJwyh/zFlkUU5jUJs6iTKMw58P0QBme+kqkusix2yWj7hiWfpWnR2Ohg
         jlwS0wBjEA/dTxgZMygqP242zrC6vkvIhddOTT672NTZVtPIMeNJTDgBH5ltWJi/ppVi
         mHJwOifqG3z8JUvlq1c0SMOQSYnmsaIFPeBqJ97GPMokiY0WXT8+qpv8h7ZX/fCq/2vI
         XekonKO5byvd66iFU0NyGlvZKLuAsPsBlghDi7jPzQcVXPAPz0/K7dV6AC9HBhhM7ffi
         e5AA==
X-Forwarded-Encrypted: i=1; AJvYcCVsA6Fq7HNLAhvmngHadueu+fwlNAQKV71tR02+mnTPeZlfcjGUU5pN1kS7mY3JNpSygWRVrdS4xn/WOhQN5oe2zufV6y4ViabZoaXb
X-Gm-Message-State: AOJu0YzCBHXkVHu0AYIkQiUV97E7cCgSEERuz9Nrv+vquHXFWs6YrWpz
	V6dEGoFik26FJGL85UXicX9+SpupP+GDkD+Iy9URtABltt751V2WQnMLwaAHYs94A3rSpK+QrQE
	=
X-Google-Smtp-Source: AGHT+IFgI7XdHumgZZXYFtIHQwzrS1VGxLrSYSyMQbic4kuETv7cbeDvbPv5YdQnm5f6hx2L+j+Tww==
X-Received: by 2002:aca:1c07:0:b0:3c5:f022:6b43 with SMTP id c7-20020aca1c07000000b003c5f0226b43mr3367651oic.21.1714580314043;
        Wed, 01 May 2024 09:18:34 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id g19-20020ac84813000000b004364d940d3dsm12391744qtq.96.2024.05.01.09.18.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 09:18:33 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43ae23431fbso28451cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 09:18:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+os2/vNoVlp8z9wBy76IXzDQkyWJb9+HxPmabJu9O8ix9VQInxIXaQeA8UVocOmREyxSrvNx4vA2sxXTHRfw/OxhNKAPSsNkxo3Xm
X-Received: by 2002:ac8:5d8f:0:b0:43a:c84f:5689 with SMTP id
 d15-20020ac85d8f000000b0043ac84f5689mr236131qtx.1.1714580312414; Wed, 01 May
 2024 09:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327202740.3075378-1-swboyd@chromium.org> <CAD=FV=VLwa0AFsrXXxKGG+hcyW+h7u7-tyg3uoDB8M_XdPti_Q@mail.gmail.com>
 <CAE-0n51osUcpqqh6o9OhURLbRKjcWbRZT-5oHLi_mwfJsUngEw@mail.gmail.com>
In-Reply-To: <CAE-0n51osUcpqqh6o9OhURLbRKjcWbRZT-5oHLi_mwfJsUngEw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 1 May 2024 09:18:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=USC_WO_cqYbuHBoScbV=TLtxKSfXmtOBruLSpzSTy4mg@mail.gmail.com>
Message-ID: <CAD=FV=USC_WO_cqYbuHBoScbV=TLtxKSfXmtOBruLSpzSTy4mg@mail.gmail.com>
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

On Tue, Apr 30, 2024 at 5:17=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
> Quoting Doug Anderson (2024-03-28 09:39:54)
> >
> > I spent a bunch of time discussing this offline with Stephen and I'll
> > try to summarize. Hopefully this isn't too much nonsense...
> >
> > 1. We'll likely land the patches downstream in ChromeOS for now while
> > we're figuring things out since we're seeing actual breakages. Whether
> > to land upstream is a question. The first patch is a bit of a hack but
> > unlikely to cause any real problems. The second patch seems correct
> > but it also feels like it's going to cause stuck clocks for a pile of
> > other SoCs because we're not adding hacks similar to the sc7180 hack
> > for all the other SoCs. I guess we could hope we get lucky or play
> > whack-a-mole? ...or we try to find a more generic solution... Dunno
> > what others think.
>
> I think we should hope to get lucky or play whack-a-mole and merge
> something like this series. If we have to we can similarly turn off RCGs
> or branches during driver probe that are using shared parents like we
> have on sc7180.

This is OK w/ me, but of course I'm super biased since the only
Qualcomm platform I'm involved in is sc7180 Chromebooks and that's
handled by your series. If it helps, I suppose you could add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

IMO it would be good to get Bjorn or Dmitry to buy in and maybe post a
PSA and/or request for testing to a few IRC channels where folks hang
out (#linux-msm, #freedreno and #aarch64-laptops, maybe?)


-Doug

