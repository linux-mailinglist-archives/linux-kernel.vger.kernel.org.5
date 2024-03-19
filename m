Return-Path: <linux-kernel+bounces-106845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4049187F462
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98C33B21316
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553617FE;
	Tue, 19 Mar 2024 00:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NhJ45GCc"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEE23D69
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710806990; cv=none; b=s5QkMtOk41qCl64p8iRr+fdWEmTRRrt/v7K+pSdb4OQi9P4us4VazAUyScdP8XocPxmVOe5tdiJbBX906BR9U420rqLn9Bq7zizlzgADWcA3LtCxQJ5Z/k6bEld5TMQx5zZ3YCnGSHXjmMyi1rY/+2V0EUdxhwLeirFQnjTVCg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710806990; c=relaxed/simple;
	bh=ZkryvYHfhOSYdw2tF4GlFSpiTUyA8Rs2/YBQ7EUbLn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0Dzij1/khoLAsVZtNw+rYgonGRPz2i+ldg47HNtnGG/4D7bPKYwir/AOghDNVsG6yY/LOVmx6erO4LY0n3Hb4IZDn2GJfnX3lDQYLFBQeI3YSkpmidqG/RJoF8O3aWKmcqIMzOjy8S4+3atwvI0FXqnneUwaVdJ4hZP1PZ5mZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NhJ45GCc; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60a5a11b59dso55206037b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 17:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710806988; x=1711411788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fys+S9pk0Mj+NPz2xMHtozxNN5zajv+q8g6ODVq+MHY=;
        b=NhJ45GCcjPZ+Y3/GEqpvClbS62XxzfUNAIbW506fVaGdSJnGtnizOJsz3tMqJ2SaTu
         EjN/YJToRebs3GWpEsxX1vwuNsTC6VZ+o5H1WWO6HqSQPpLF0QqihUbIkwueT9tTCc/2
         6puFWX8tCRqFaK3VjgFvyNRt9YGrxi9YpObtQjQd8iK63EhVwK2moKHXz5wJ2IbsyKKS
         fmWdfrAngpmpJluiDlt0OHolwllk5kGM+CtipzSdbDhOswYMX1/buVdefBnoVT7MLqK/
         Nm87ilgJWW6JDu2F8ntKi9SU3ogyqtzRCfKx0hiEtrxvmssX7TzejdUEw0FO+m3d/JZX
         H5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710806988; x=1711411788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fys+S9pk0Mj+NPz2xMHtozxNN5zajv+q8g6ODVq+MHY=;
        b=UeOTQ/zOAx+UHJ5+8kKfAq4OEWHGY9+XCpyYDew4PeCIQ62/VqfWLDaVSJvexGqy6G
         mrUpbEgqisjJShaSsOSjlcv+afNLH+7uKqsqr2B1Ld1Up5YReGaSXipDB5aKI2ywfPs1
         XkeyxZndJCLZggFWeaxsgglZuxTT9VYOqRPTkzk5xO7sfVUcrDuLjpwgWFH70jtUBTCS
         JGsGVFqL7M5br3PifyngBMeaNeVzoFFYxQswjX8EPT1JVdSeN1thVCXX1TDI/t9aAg+9
         jZdPgQyVWi5trPUgnjwKj1HECY6I+B/fjt4MngVEriFLW34aICyYcPw0asH8XTBR23BY
         frKA==
X-Forwarded-Encrypted: i=1; AJvYcCUozGvCx5HHN2vS47m31/Eyy99aDfQYDIP+hCZVZ7YMDWPTS0iv2hfZjAFFN+RyMFkXyrEHDjols8u9PLsfstZ0263gqfHvmNyxhnKi
X-Gm-Message-State: AOJu0YximotRHUg/as/iBB9PBLkr61K1PWlcNpLcGnIMoQznIPw1po8g
	Z9tvU+cg53fWbHxaL/y7skuPMnn85WvZ5HvepdRQTdTUPn3LCJC21N8MHTym8TDBVdf834egpC4
	18KnJa1FAmh20QSdJGknWcOov+4leQc0K52Ft7w==
X-Google-Smtp-Source: AGHT+IFUYNy3nqPWMFhyeAEEOgz59hN/rjXpDhVqxQJfYXeOZMQXyBfEq4Imb4IL7qF0eBO8bT0npSGQAdC6hzcbEjA=
X-Received: by 2002:a81:8147:0:b0:610:caab:bf50 with SMTP id
 r68-20020a818147000000b00610caabbf50mr5157049ywf.37.1710806988056; Mon, 18
 Mar 2024 17:09:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-apss-ipq-pll-cleanup-v1-0-52f795429d5d@gmail.com>
 <20240318-apss-ipq-pll-cleanup-v1-2-52f795429d5d@gmail.com>
 <CAA8EJpo2Vo-XqstNk69dWW8pqNkGi0tz3UmHY7j6LLKd-yH22w@mail.gmail.com> <09c91419-8bce-49dc-86d1-3ed1b9f28ee6@gmail.com>
In-Reply-To: <09c91419-8bce-49dc-86d1-3ed1b9f28ee6@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 19 Mar 2024 02:09:36 +0200
Message-ID: <CAA8EJpq+PUavezxAwpStm98_3uW7HQraFyUdr6uwZCNHJ4yU5w@mail.gmail.com>
Subject: Re: [PATCH 2/5] clk: qcom: apss-ipq-pll: use an 1-D array for Huayra
 pll register offsets
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Mar 2024 at 23:23, Gabor Juhos <j4g8y7@gmail.com> wrote:
>
> 2024. 03. 18. 15:16 keltez=C3=A9ssel, Dmitry Baryshkov =C3=ADrta:
>
> ...
>
> >> +static const u8 ipq_pll_huayra_regs[PLL_OFF_MAX_REGS] =3D {
> >> +       [PLL_OFF_L_VAL] =3D 0x08,
> >> +       [PLL_OFF_ALPHA_VAL] =3D 0x10,
> >> +       [PLL_OFF_USER_CTL] =3D 0x18,
> >> +       [PLL_OFF_CONFIG_CTL] =3D 0x20,
> >> +       [PLL_OFF_CONFIG_CTL_U] =3D 0x24,
> >> +       [PLL_OFF_STATUS] =3D 0x28,
> >> +       [PLL_OFF_TEST_CTL] =3D 0x30,
> >> +       [PLL_OFF_TEST_CTL_U] =3D 0x34,
> >>  };
> >
> > Can you please move this to clk_alpha_pll? We can then drop it from
> > clk-cbf-8996.c too.
>
> Sure, I can do that. By any chance, do you have a suggestion for the name=
 of the
> new enum value to be used in the clk_alpha_pll_regs array?
>
> CLK_ALPHA_PLL_TYPE_HUAYRA_IPQ seems too generic, and it would be a bit
> misleading using that for MSM8996 CBF.
>
> CLK_ALPHA_PLL_TYPE_HUAYRA_IPQ6018_A53 is quite long and it is also mislea=
ding.
>
> Maybe we could use CLK_ALPHA_PLL_TYPE_IPQ6018_A53 which is short and uniq=
ue
> enough and we could add an alias for that like CLK_ALPHA_PLL_TYPE_MSM8996=
_CBF or
> something similar.

HUAYRA_APSS ?

>
> Regards,
> Gabor
>


--=20
With best wishes
Dmitry

