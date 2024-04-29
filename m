Return-Path: <linux-kernel+bounces-162166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE258B56EF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A88B24441
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C5C47F5F;
	Mon, 29 Apr 2024 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MPVTwJat"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660C64501D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390783; cv=none; b=WcVbZxSK8VXcoJgapJPK4ae44fUIggBYy96z8O3g0PcP8+dQ0pxklk3OZF/erBS7nU6/R55Bzpm0GKQd5KPKUMbEv7SbliHEky0EZPQW9B/m6LTCcs3fzy76pxWMNbFZjWHxYPM6BIKg4FEbgqxHOQEIYNrZAKeaE7cozz35vT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390783; c=relaxed/simple;
	bh=I96nVD/pvl/HbzA+JSRfMVYooN/S/Dzke1463qRCo+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DR9o7F8k8attMW/Ed8EYyZp5XA0xRkRdIePXql0dhX/7XPtJIEH1d4/gAzIGNf9ND8drtu3BfPKQiuVK+Y9JEeGKPpmk6Ho3zI36dj8s7jdo7MwmNwm7UEYoxHhB3ocy/juiGidLAH6UAuNedzCAIeT2YRnaemd9/vTJxwwednE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MPVTwJat; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78efd533a00so322872785a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714390781; x=1714995581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=05L08pI3kBTDsTqcTJqQ2PruWVHcpez2K/eYqwLWDm0=;
        b=MPVTwJatyDLYP3g1H06sNv8qi68dfxAH6k6GgKzb3blmsttWHzYsqCR5UZJddUB4lo
         CH3SBkcRyH7prIbaWdUVf3eJwrtF/cEiNn2OoApeIrNL6n45VAUZ6yjnmbrwoiPT4X80
         js/cfLMc/1AkccLURcui0twXbRMJT2uxTfDrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714390781; x=1714995581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05L08pI3kBTDsTqcTJqQ2PruWVHcpez2K/eYqwLWDm0=;
        b=FrKJ6lEysP27NkIXirmwL4HAMelIylyLxJtSC0axLp3Qtjc1kpACO8ntvk49ONtHy5
         ysPqRy3D8B2pvIgwJDmpsFnicLjKvJus45/MhJLjCLhg8tLm1iQggMCK4cDzUomkMnYX
         OTtwTfqnm4B1P1+hEJygBO0G5BvLrR+wYvzIaCJkcF5wASD2QsktjFKB0wX3WDlfYpXE
         bfsOS+sSZiyrXwKaU5h2+rI7IORQXNVxrwRo0ONeh9aVC3f4+WP+xRq+8ezDw3y19oKR
         jlyhrM4+i0urEBwrUiCCPqsIzcd9U9BZ7Z2mMkgsz0IokM0zBLdEihyBsBrsn3RQOA2z
         OVag==
X-Forwarded-Encrypted: i=1; AJvYcCVZUgCdw+7yNz50YW8ZO9LLQySElmX6uWHedlctghICtU1EKnePX0+8/iflIhgdpvXHieyJuYltWcF69Nt1AItVUuq+R5EueRNRC6DA
X-Gm-Message-State: AOJu0YyNqH2ttPDiXgFPLXy8CfMhopoHRAN/KDk22vxpdgMAr6bUZILs
	wE1TZOy+nEG79vWFW8GDvDHqINiwvhmsmxDkXJQxZbmvKl7ueHr5npDUFFkuE5caP3ul5Y4GbdA
	=
X-Google-Smtp-Source: AGHT+IHU/raqlzFfIKNt/eX+MfbrRu1zAHJKgZ4rw/IuDRkVdLe59HpTMw5E/vEDsDY7FXGkUIlg5g==
X-Received: by 2002:a05:620a:4103:b0:790:c2d0:31a7 with SMTP id j3-20020a05620a410300b00790c2d031a7mr8687003qko.73.1714390781207;
        Mon, 29 Apr 2024 04:39:41 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id h14-20020a05620a10ae00b0078d6303c099sm10375375qkk.112.2024.04.29.04.39.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 04:39:40 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-439dfa27003so25183671cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:39:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLhb+6wHkq3pFN4XOo+RBC68NSFq7MA21LDJCC28/F2ZruRRbxDowgNFtG+W7MkuQXm0fVq0zpXCEAgti8rH/yokfksreuKxfgCbK9
X-Received: by 2002:aca:f1a:0:b0:3c8:39b2:bd8b with SMTP id
 26-20020aca0f1a000000b003c839b2bd8bmr7165395oip.55.1714390759097; Mon, 29 Apr
 2024 04:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>
 <20240415-fix-cocci-v1-23-477afb23728b@chromium.org> <97f51ae8-6672-4bd4-b55b-f02114e3d8d0@moroto.mountain>
 <7a8d403b-8baf-4eff-8f9c-69cdcb8b2180@moroto.mountain> <9ba7f4e6-2b8b-44a3-9cac-9ed6e50f1700@moroto.mountain>
In-Reply-To: <9ba7f4e6-2b8b-44a3-9cac-9ed6e50f1700@moroto.mountain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 29 Apr 2024 13:39:03 +0200
X-Gmail-Original-Message-ID: <CANiDSCsCpE55_huYq1BchDCR88O3FWRYBGYwA00o01ZdZeL3NA@mail.gmail.com>
Message-ID: <CANiDSCsCpE55_huYq1BchDCR88O3FWRYBGYwA00o01ZdZeL3NA@mail.gmail.com>
Subject: Re: [PATCH 23/35] media: dvb-frontends: tda10048: Use the right div
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Martin Tuma <martin.tuma@digiteqautomotive.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hugues Fruchet <hugues.fruchet@foss.st.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>, 
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Dmitry Osipenko <digetx@gmail.com>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
	Sylvain Petinot <sylvain.petinot@foss.st.com>, Jacopo Mondi <jacopo+renesas@jmondi.org>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	Pavel Machek <pavel@ucw.cz>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dan

On Tue, 23 Apr 2024 at 11:55, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> Btw, here is the output from my check (based on linux next from a few
> days ago).  There are some false positives because Smatch parses
> __pow10() incorrectly etc but it's mostly correct.

This looks pretty cool :)

Are you planning to add this to smatch soon?

Thanks!

