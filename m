Return-Path: <linux-kernel+bounces-91745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 245FA8715F6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98C51F22E13
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A799B54FBA;
	Tue,  5 Mar 2024 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmTAEMHn"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386EE1EB2A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709620893; cv=none; b=udl4tSJF+6GW7xKpvWFK2oN/r6vEp+h2TgAdE1LqQ8azJk4lHx8DC98Sj6QEzGu8jhmf8wZsIEfUZAtkQocnoxb1OrJDGiqayrgqvC6urgLrsYabx57KPi/4O5tfebE/IQ9nn31GOBVXZbR66AyCGMK2930Sw9KqlTKGfmY/hJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709620893; c=relaxed/simple;
	bh=Ps/VJqEyp7guXeJPu2FrOwduSl73CHpkzvjzkVsVtTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzW1/3j2gqOBz9yy9tz5Wudl7/cvcHUyGdrS+1fdXt5YvT+YYYwcDcbCUBjKkI60O8AMuoAeOI8U7NcbDRZAbsBNjT0NP/5vLK620KOcPI8sZgnT1zrsYpWRXAPCLUHk3dj1OrVR6dQ/dsQvTcAlj2LyVfN6ndZMzvD37MasttQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cmTAEMHn; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-609a773ec44so24188337b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 22:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709620891; x=1710225691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ccg/Lc70kvp90dYd+ZbmISgOfdv3HBJZ65KNlm+3N78=;
        b=cmTAEMHnM+IvXsUZliiWRWExCL3kxOKkN5wLTtToV09GgSRz2VwJnHzzkpVzgNW/h8
         hWJ5qvyeir3KPc9B9jtkbqfjxtvqHk1noXwdg9HV0M+Orld8w3bSE89IsQyot1AHQ1Un
         d9GOHfzoowjdsis8t1L5ROH+xQ5bUAziO93pMUziLnuKTJ6uU5KeVoIDnYVzWykEzYtN
         FFQsrGNLkNtX9VGYdigky1g/5mv/nDBDTP0WGq0HQBdj2NlwlRNCkEwrRFtqQK2cEW8M
         28saLrbaWtv0goWzopKOp/9lN78g/HWU2GJWbJ7VLApQwtotb0+J0X3nTquWatMHewGo
         6sYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709620891; x=1710225691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccg/Lc70kvp90dYd+ZbmISgOfdv3HBJZ65KNlm+3N78=;
        b=TEcfUrrCU25tK4qGZX+ZR0XGUVkRTxOpqXgVbabzZdor6vut/0PWzaNvhUXuWMohoF
         QKszLEYFAfQ+n445Ztn7scWIpiPZgmgDWlJ7PjivdC7EP2m8srexiFbhMjdD3kOogm67
         OkUzro3oE0zHC+VMlfkASVGBB79+cKhEy8FqrhsJ/+uSlCtJB6i9ODJkxdxBzszDTswm
         uHx1wJ64HURoNzNJZhYVkJ3Vc/Xl0TfQ6Q7HXMYAtmNiQvhaol1dZgLh4qfL1cP0IxXb
         Uul2PqsBkRI1rJyXcWmdMspraKfUYjA85+81JqHSupO2L26SFcps7GQy5mtj6tcAMBVd
         ad3w==
X-Forwarded-Encrypted: i=1; AJvYcCWEOV0LMNlgwUBMHQH+/+HUvICbdqR7giE/+CGjOtS6mbqd3VjfbWlVtQreOBkuKDQW+ySoih4sAGzEMBL6m7SzgUo66FcafxKVYVWx
X-Gm-Message-State: AOJu0YzjmfoynD2siw6mbzTv9gEG3IDaKnR+6Pv1rwnZMfYJB9mlIdql
	a64JusdnEYKMSQO+F4V6E+An0QdRBfOCgzTQFZ1ADrg5b3izmj102y1Wb7LoZfrBwKDw1tml1qp
	IZ453qr0Sjl5WNNomKiZdP4c5KQl99A6eVRh+7g==
X-Google-Smtp-Source: AGHT+IGRNcWGc+ovIvoeKHsS2bsRGRrdE1GgYvwR+P/OeZcykFPfCL7rKLURH+3X2nQAEd3t1oe4qRWeuBF8ZkkOBug=
X-Received: by 2002:a05:6902:305:b0:dcf:bc57:cd61 with SMTP id
 b5-20020a056902030500b00dcfbc57cd61mr8363686ybs.50.1709620891239; Mon, 04 Mar
 2024 22:41:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
 <20240122-ipq5332-nsscc-v4-2-19fa30019770@quicinc.com> <7a69a68d-44c2-4589-b286-466d2f2a0809@lunn.ch>
 <11fda059-3d8d-4030-922a-8fef16349a65@quicinc.com> <17e2400e-6881-4e9e-90c2-9c4f77a0d41d@lunn.ch>
 <8c9ee34c-a97b-4acf-a093-9ac2afc28d0e@quicinc.com> <CAA8EJppe6aNf2WJ5BvaX8SPTbuaEwzRm74F8QKyFtbmnGQt=1w@mail.gmail.com>
 <74f585c2-d220-4324-96eb-1a945fef9608@quicinc.com> <CAA8EJppuNRB9fhjimg4SUR2PydX7-KLWSb9H-nC-oSMYVOME-Q@mail.gmail.com>
 <d518dbc1-41aa-46f9-b549-c95a33b06ee0@quicinc.com> <CAA8EJppP_bAPRH7Upnq8dO7__xQPOJ6F_Lc-fpRAcutKKzk0eA@mail.gmail.com>
 <3a6d301d-16f6-4a11-8be5-6bbb6eb501f4@quicinc.com>
In-Reply-To: <3a6d301d-16f6-4a11-8be5-6bbb6eb501f4@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 5 Mar 2024 08:41:19 +0200
Message-ID: <CAA8EJpq2x-1mbBApGH5CiGZqCVhdP97pveZupdJyGQGo3MT8-Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] clk: qcom: ipq5332: enable few nssnoc clocks in
 driver probe
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 12:18, Kathiravan Thirumoorthy
<quic_kathirav@quicinc.com> wrote:
>
>
>
> On 2/19/2024 3:53 PM, Dmitry Baryshkov wrote:
> > On Sun, 18 Feb 2024 at 06:29, Kathiravan Thirumoorthy
> > <quic_kathirav@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 2/17/2024 10:15 PM, Dmitry Baryshkov wrote:
> >>> On Sat, 17 Feb 2024 at 17:45, Kathiravan Thirumoorthy
> >>> <quic_kathirav@quicinc.com> wrote:
> >>>>
> >>>>
> >>>> <snip>
> >>>>
> >>>>>> Reason being, to access the NSSCC clocks, these GCC clocks
> >>>>>> (gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk)
> >>>>>> should be turned ON. But CCF disables these clocks as well due to the
> >>>>>> lack of consumer.
> >>>>>
> >>>>> This means that NSSCC is also a consumer of those clocks. Please fix
> >>>>> both DT and nsscc driver to handle NSSNOC clocks.
> >>>>
> >>>>
> >>>> Thanks Dmitry. I shall include these clocks in the NSSCC DT node and
> >>>> enable the same in the NSSCC driver probe.
> >>>
> >>> Or use them through pm_clk. This might be better, as the system
> >>> doesn't need these clocks if NSSCC is suspended.
> >>
> >>
> >> IPQ53XX SoC doesn't support the PM(suspend / resume) functionality, so
> >> that, can I enable these clocks in NSSCC driver probe itself?
> >
> > There is a difference between PM (suspend/resume) and runtime PM.
> >
> >
>
> Thanks Dmitry. IIUC your question correctly, runtime PM for the
> peripherals are not supported (except CPU cores which supports DVFS).
> Since these are router based products, once system is powered on, all
> the peripherals are configured to the required frequency and it will be
> never go into low power modes.
>
> Please let me know if this answers your questions.

It seems there is a misunderstanding somewhere. Runtime PM allows the
Linux kernel to disable temporary unused devices at runtime. E.g. if
the NSS is switched off, the kernel can switch NSSCC off too, cutting
the power. It has nothing to do with the frequency of the device /
clock or with the product being a router or a mobile device.


-- 
With best wishes
Dmitry

