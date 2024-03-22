Return-Path: <linux-kernel+bounces-112072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0548874DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1AF1F23741
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A85D82C8E;
	Fri, 22 Mar 2024 22:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EC1n8Imh"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92678289B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711146802; cv=none; b=MICzvwn8QAt31tGsMaeRzJFE9vqxC77mQyiZmvoZ2AM2xYoGJ1VvpZZjN97oeucJde5CMfhwpb2EmE2FlouOGVCdEmHRfumsa+6ZMWMItRryPmA7K45X8ySkiXBENBqA+oqXZAU3Xtne72eyqIiEjwdH/gYM8i84poNChuNeQCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711146802; c=relaxed/simple;
	bh=eqf3ihHx9YHmHJuuScJ0QnswcC+loLOYogzQd1XaHpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9gUbRTs6hHe/FRYhs/Xm+4+w1SSFnizSikW8f6b+CBrZlNAWnkoLt5e/jKhErN7c6VdKNttCXSMLvYQC1kAThJiAdNMjEPIy0AIxdPAVLyEn2lhL9YQ3LNQr8pC0EXTBVo2hM7RoneVBzq0ZBbROqCpPHoh75le7OGG8+sUEKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EC1n8Imh; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dd14d8e7026so2414136276.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711146800; x=1711751600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJ9F0pY9n/+igvd/03ZLKYicj33ULltRkxaxHp9S2Mk=;
        b=EC1n8ImhTItkTN4PavZIK4BRpWnuHsMjukmbTREwhMfKuGkMbUU1ObIvXhzPgXskFf
         Sjk0TPxH4Msq4lGSTPSMmSfpPwJGzLbTvg5OM9lG/fhQ+93MrO522fxc+UFfIEC5Vg4+
         SQ3RaqAwpUi0urIseuKGN5JY10a7dm6ZeugrnBdltOaXS+bt15yg6YmYdyu5T7ilBk5k
         p+d3kYZ3h75c6vnkv9vSwZqUCEy4oASN4RxFnrTgD98YdBh4OGXIX9DhJMm3v6+Cr4YC
         CNScVUlHIjpbZzz1kWfm9p5RUfuMFfuWLQ6/xImSDi+z79q59NzUPdQ1dhKZP3OBgPw7
         ajVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711146800; x=1711751600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJ9F0pY9n/+igvd/03ZLKYicj33ULltRkxaxHp9S2Mk=;
        b=ihte8drQHC4hpDo1RCqhbWZqcGzS1Eo4ZBcW9PAqz2TbNGKOfiZvlmmO0jAvvkamx0
         VHLXlnKJerPpkKdvIvGGqBlZwEqkRouoOh4dDMItG80Hs/FY+/fp1bI1sRdk/Bbb1Cwc
         nB7OLE8zsrLR5QedGUjCWmW+G0IsYnXacaSYlIX/4YHs/attP25VnNN84x97lAfrL1SQ
         zLAzfrvqq7SW6rcXJvNMV6c4EHHd1/dDuEDZn5rYkGjOuER1QUvBwvySSsJVYF1l1AnK
         q/o39nNv5NSkhpc2BzTJgWOrxFLI53I7SGO80FXo52IlHwXDR1m6JhGlJGdHH9zE+/fm
         VTqw==
X-Forwarded-Encrypted: i=1; AJvYcCViPsqDs7aBVcV1kspF/YqVn8pc7MjhiS5+U7eP8FzcIz8pt1qdGjplRp1/2zs1O7qbhzJIXtul5Y6EW7jkPqudmhKQ+VqdcRhYmiit
X-Gm-Message-State: AOJu0YyNDFzTuHz9POCJrLaHHWTlssduRIgM0xKf9HfgAHLDnmwiLdoD
	17MnRdlNfX3uH+Kczg6wtloR9ASsR6PEIhxSGNKBDNkLbjBKSKjyNYj7ZvBarNBsuN6lxz6X/wU
	7Q99YWWDR+jJvf2NYHq75wSZupDmLeJT7ptA69w==
X-Google-Smtp-Source: AGHT+IHeqHvXyVTz47o9FkA2GJ7YHmI3n1DCfYkliY4NJgtd4mhyutbc3aVWnftbGu6jfh1yTN/kdnyTxaqt4ddPtJ8=
X-Received: by 2002:a25:1941:0:b0:dd0:2076:4706 with SMTP id
 62-20020a251941000000b00dd020764706mr576713ybz.31.1711146799824; Fri, 22 Mar
 2024 15:33:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321-apss-ipq-pll-cleanup-v2-0-201f3cf79fd4@gmail.com>
 <20240321-apss-ipq-pll-cleanup-v2-3-201f3cf79fd4@gmail.com>
 <CAA8EJprr4E1CM4f+eBzdRN41nm33xY-hRPQDn3peR94vLyJsYQ@mail.gmail.com> <ca4d85f1-397e-4c43-8548-436b9238e85e@gmail.com>
In-Reply-To: <ca4d85f1-397e-4c43-8548-436b9238e85e@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 23 Mar 2024 00:33:08 +0200
Message-ID: <CAA8EJpp9jyCHgMSEBMumSz7xXUkMRm3wapjUdjzeOuJSpH5g5w@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] clk: qcom: apss-ipq-pll: remove 'pll_type' field
 from struct 'apss_pll_data'
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Mar 2024 at 22:59, Gabor Juhos <j4g8y7@gmail.com> wrote:
>
> 2024. 03. 21. 11:37 keltez=C3=A9ssel, Dmitry Baryshkov =C3=ADrta:
> > On Thu, 21 Mar 2024 at 09:50, Gabor Juhos <j4g8y7@gmail.com> wrote:
> >>
> >> The value of the 'pll_type' field of 'struct apps_pll_data'
> >> is used only by the probe function to decide which config
> >> function should be called for the actual PLL. However this
> >> can be derived also from the 'pll' field  which makes the
> >> 'pll_type' field redundant.
> >>
> >> Additionally, the CLK_ALPHA_PLL_TYPE_* enumeration values
> >> are meant to be used as indices to the 'clk_alpha_pll_regs'
> >> array so using those to define the pll type in this driver
> >> is misleading anyway.
> >>
> >> Change the probe function to use the 'pll' field to determine
> >> the configuration function to be used, and remove the
> >> 'pll_type' field to simplify the code.
> >
> > I can't fully appreciate this idea. There can be cases when different
> > PLL types share the set of ops. I think having a type is more
> > versatile and makes the code more obvious.
>
> I understand your concerns, but let me explain the reasons about why I ha=
ve
> choosed this implementation in more detail.
>
> The driver declares three distinct clocks for the three different PLL typ=
es it
> supports. Each one of these clocks are using different register maps and =
clock
> operations which in a whole uniquely identifies the type of the PLL. In c=
ontrary
> to this, the CLK_ALPHA_PLL_TYPE_* values assigned to 'pll_type' are only
> indicating that which register map should be used for the given PLL. Howe=
ver
> this is also specified indirectly through the 'regs' member of the clocks=
 so
> this is a redundant information.
>
> Additionally, using the CLK_ALPHA_PLL_TYPE_*  for anything other than for
> specifying the register map is misleading.  For example, here are some sn=
ippets
> from the driver before the patch:
>
> static struct clk_alpha_pll ipq_pll_stromer_plus =3D {
>         ...
>         .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER],
>         ...
>
> static struct apss_pll_data ipq5332_pll_data =3D {
>         .pll_type =3D CLK_ALPHA_PLL_TYPE_STROMER_PLUS,
>         .pll =3D &ipq_pll_stromer_plus,
>         ...
>
> Since it is not obvious at a first glance, one could ask that why the two
> CLK_ALPHA_PLL_TYPE_* values are different?
>
> Although my opinion that it is redundant still stand, but I'm not against
> keeping the pll_type. However if we keep that, then at least we should us=
e
> private enums (IPQ_APSS_PLL_TYPE_* or similar) for that in order to make =
it more
> obvious that it means a different thing than the CLK_ALPHA_PLL_TYPE_* val=
ues.
>
> This solution would be more acceptable?

This looks like a slight overkill, but yes, it is more acceptable. The
logic should be type =3D> functions, not the other way around.


--=20
With best wishes
Dmitry

