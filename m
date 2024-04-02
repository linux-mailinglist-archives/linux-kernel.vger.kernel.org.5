Return-Path: <linux-kernel+bounces-127769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D16E8950AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0BE1C21C6F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544D25EE82;
	Tue,  2 Apr 2024 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u4tCu6Gh"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C042F4776F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054903; cv=none; b=BnXlKDKmJk0ineZZoFI9AkWyV+DCO9jqUM4UzEGm67LzIdm1sDnuyUqd2DkU31T1JmTLgp3W/9Osx+gHOdwNms9nq5fEevUNeT9EqHpulzm2FC7uWmNVPcC3rvi2FckIZxNqOzHNH0kcyn0wtVytgXnRzlcKXYA71n7ZQr1kCIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054903; c=relaxed/simple;
	bh=qqkptkwBB5jmETqLjS63zlxdb+z5eD6/k+FZmoOcCP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgpbYw5ClnZ9Q2IQZlz1tcrjDROzKG+1frP2IfRabsuE7B+y/mL92unbWIbN+0GXkk72hjwE+C4SShgoT+KnQI99cNMO5wb35IJC78ohRU4a9Fcqh5iMBgfB28isyLKrJ25lUkqfNefNQrcu6E17AXcu4dbPLwH5GN4AdsJoLcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u4tCu6Gh; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso4837450276.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 03:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712054900; x=1712659700; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+xPQyCvLo53dq7pKGpQQof9V6YZJuIofT5TTwfg8858=;
        b=u4tCu6GhOY38sRAviEV/tKlL3V3tT2l3fvAV59tynf3dKBVNSfO/RXTM5iS23pXu+7
         0qvMqTLkTyQqwMB0XwY4ciDrt21N1kbM3QG6YvCZtCoYUGcUiffQDKuSH56LkBwHUhES
         hOJVE4POJfo4e+7Q02ODEDCgG+/dky/Z1jpgk3nWT99mwem8H4e/cyAPXocjN0ZyW0sG
         w13myAXscyDancBhQqgM4ply80ZcqpNRp8MWGPTKaRGQfIPjRRBObK7u5Op3wtSAukId
         c/hAdLOzFkcrrQmRwa+TtxBMj4R5WToq8vDsSc5h3taODFEQh29ntK/JvlLU7IbLeikt
         sakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712054900; x=1712659700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xPQyCvLo53dq7pKGpQQof9V6YZJuIofT5TTwfg8858=;
        b=L3Q59J1pTyBY8uvQoM1clBMj6Ntz83ciOagbt3vDJduS0DqDzeg6JGLjMqlEwpwmli
         XLzdyuadjRD6cLnK9MJONs8Bcr6LnqffhgOLNgZxZZqoN9X8nCITteaKxj/b3NetyVA4
         3ztei3ttutuKzHrUAoWi6cYTWqMRIz+I0VQyWuwyjCqK+/MAkTj59Pu+8xz7urYacmjc
         4afINxA44z6qSZY5bUvY15jVFn6mxTcyoCoB8cE/0kO4aNcjRV5ge95zIHIi3CMnh3yb
         XxKAmvBPYKMkWYkkvDvRC6cRJSxBKSV6YFhka2uIRgbx/rDwaGVPUoQW9Pdsm21onLSa
         YrKA==
X-Forwarded-Encrypted: i=1; AJvYcCXMCiyDRbvZsrMPpHZRvlYsFBwrr3pwrxUQutnaLDG8UvFl3huJaJoS6qBCbBlePpqMzB46bfXhddh1HWdP6w373dm8NoHtqqNXYgJG
X-Gm-Message-State: AOJu0YyNhMsLpwl6RLpTGJ1iWHksbS/U8DvhVVdEXGfIrWZO0NvzHiDd
	j6Naocrc9zDTQUKS6l82vPDjjE7vymiXId85nBbNmUCv9JvPumYC61pLm+wYpzRlZ/WeBhTSF92
	5A61W7IbrcgXoCZ4LIkfReNRt3Zg8BZPpEKnchg==
X-Google-Smtp-Source: AGHT+IEdThI7DXVCE+YtsqVQ5FfgA2JdRwa/suM7w9m6RjmrZhMB+jlS68lFUGN2ID6qPpnpew/nE9vA5K+Hs04awQo=
X-Received: by 2002:a25:9a05:0:b0:dcc:9e88:b15 with SMTP id
 x5-20020a259a05000000b00dcc9e880b15mr10209955ybn.41.1712054899681; Tue, 02
 Apr 2024 03:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402103406.3638821-1-quic_varada@quicinc.com>
 <20240402103406.3638821-4-quic_varada@quicinc.com> <CAA8EJpphk_kqzBE7cKb73ipdpTi29t9ZSOOdSfq7pAGSs5NKeg@mail.gmail.com>
In-Reply-To: <CAA8EJpphk_kqzBE7cKb73ipdpTi29t9ZSOOdSfq7pAGSs5NKeg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Apr 2024 13:48:08 +0300
Message-ID: <CAA8EJpo=TMhu+Te+JE0cQzmjLOTDPi-Vv-h5Bch0Wfr_7iVi2w@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] interconnect: icc-clk: Add devm_icc_clk_register
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, djakov@kernel.org, quic_anusha@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 13:40, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 2 Apr 2024 at 13:34, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > Wrap icc_clk_register to create devm_icc_clk_register to be
> > able to release the resources properly.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v5: Introduced devm_icc_clk_register
> > ---
> >  drivers/interconnect/icc-clk.c   | 29 +++++++++++++++++++++++++++++
> >  include/linux/interconnect-clk.h |  4 ++++
> >  2 files changed, 33 insertions(+)
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Wait. Actually,

Unreviewed-by: me

Please return int from devm_icc_clk_register instead of returning the pointer.

-- 
With best wishes
Dmitry

