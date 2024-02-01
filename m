Return-Path: <linux-kernel+bounces-48693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3834845FD7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C401F2BE58
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983177C6E6;
	Thu,  1 Feb 2024 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0MAZp+7"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0D97E118
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811879; cv=none; b=CyXZpRBrpSIF9ljCRb3+uYZv67ODAefPHD0elid0LWoRAHOgfnWOVdANbNV8tgp1IzarYHv/Q3EliNbR8TN2PxKCXsBbo5c0gKaanq34YtDBdi7HYWY9JV8dcYOe0x1l/3DczLYOtVfj0uxkBYYapLWvhgjse8ksCsmhO5EPZtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811879; c=relaxed/simple;
	bh=WhQ0DzBaMOf2p0BQ0/iyFODtrdWQQm9VRmT+icXLJ58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzL6HM6eAJ8RDTakZWHNHuRJlPehWFrNq1EN7lddnpQq4+ZZs4Iegt2hyQa1NzVRLY6ZK7IobhbNWgBTtrUi4K7PSKbEm/L1x8qr3ChqpFgt9c+/gdhDx0fVVBu/5wsvABbtuKJzC7q3Sgdv4kgPzWrdnBgOZ7jsTYSuGnUPUO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S0MAZp+7; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cf765355ecso1021424a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 10:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706811877; x=1707416677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUFcyRGjgFCHcU7TELJdpFaJ75t2Lcru3pbZ6VhQGp4=;
        b=S0MAZp+7aOh8rmNVAxqoRVgiAKNW/vVMV+tbEt2Yy2c8VMttn//g8P3YdS5o6LvPOy
         S2rkDPirq5BzfIfEdO+NWrXYCACa1RqscRTCB3e9fTlbOM/L0RUXxZL9xsfIOyvbAnN/
         sEjfVMUwzMTVgFag+ZGWN151m8sXac5+xIMGnWeRqBgkDoXXnL4Dhp3e1CamAdKkYj5/
         EIh2gs0uJJAg9RT8HbAJSKf7gRg2JvNujcbm/g3SRBgTl04g3R3r0VgSNamxSL49P9pR
         26RVrW4FZZ5Q60CxiRTnkFKC6gALILZtt44M5g9s2Elnw5PzwgWhfk0aJBxyCDZfo6Pc
         yh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706811877; x=1707416677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUFcyRGjgFCHcU7TELJdpFaJ75t2Lcru3pbZ6VhQGp4=;
        b=pe1m1gsznvjRLJvLRQhBZSTnpDcgWpCc0ubnbvLPgsO9kxHb55vlsl9N2lotNjzgPG
         XHRi/Q6iPa4WQ5Z6Iv2I+a58NyYkhQeU6QnkLbjRnsrWxpafcQuyWLRyZ7fXhQVI6z7f
         1xbxEWwh8ntLhmTQ6X5x89BOM/RfQvbaRI2M3muzBap4FpSkR2aWMoLP5leh0vuq53wu
         NX4A+HTadCecHmiGKUXJkqVVDEK4nCFoSCyqbssCpkk7sQULn8w2AYxMwS+Ldra3gXYZ
         JtgdphjGQ8VqOd9bifZKZvHzpZZcex6uYP8zTGNZ+kmsc91AsQaWuF6rrfdCCTDxHKl2
         QXUQ==
X-Gm-Message-State: AOJu0YzHZ5b691tyakzMisx7IDsImLGez4S8c6jX9E0FzVbZRrlhWdoy
	SvWYfs06A6zrhDftnzIg3yD9FrOMcKg6NXT1FnAcvBex8o0EdbZRL0ENhbkRj8tfQcE4A3y1yGs
	2XlRNRSSLlvnXngP/xTSp0lKmUYSF8eE0nYnQOQ==
X-Google-Smtp-Source: AGHT+IEB90qcFx4TY3tpzYId3RpaXO+09NutWYPVOmVFBsoOrpib63SakvoAaXQt2ipdj1IdFncbrNePKi1xEbmWqqY=
X-Received: by 2002:a05:6a20:46a2:b0:199:cecf:9f5d with SMTP id
 el34-20020a056a2046a200b00199cecf9f5dmr5277395pzb.29.1706811877389; Thu, 01
 Feb 2024 10:24:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125013858.3986-1-semen.protsenko@linaro.org>
 <20240125013858.3986-4-semen.protsenko@linaro.org> <170678377409.179918.13077326172475089482.b4-ty@linaro.org>
 <4c2c425b-3ddd-4484-98cf-3f7768c94e82@linaro.org>
In-Reply-To: <4c2c425b-3ddd-4484-98cf-3f7768c94e82@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 1 Feb 2024 12:24:25 -0600
Message-ID: <CAPLW+4=wsR=V+6vctf0gMzFVg6havL-M0kTDLLwhr-XdfuCD5Q@mail.gmail.com>
Subject: Re: (subset) [PATCH v2 3/3] arm64: dts: exynos: Add SPI nodes for Exynos850
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 5:56=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 01/02/2024 11:36, Krzysztof Kozlowski wrote:
> >
> > On Wed, 24 Jan 2024 19:38:58 -0600, Sam Protsenko wrote:
> >> Some USI blocks can be configured as SPI controllers. Add correspondin=
g
> >> SPI nodes to Exynos850 SoC device tree.
> >>
> >>
> >
> > Applied, thanks!
> >
> > [3/3] arm64: dts: exynos: Add SPI nodes for Exynos850
> >       https://git.kernel.org/krzk/linux/c/98473b0d78caa5502b7eee05553ee=
168f0b0b424
>
> And dropped. You did not test it.
>

Right. Forgot to re-test it after re-shuffling the clocks. Sorry for
the hustle, I'll send v3 shortly.

> For some time, all Samsung SoCs and its variants are expected not to
> introduce any new `dtbs_check W=3D1` warnings. Several platforms, like al=
l
> ARM64 Samsung SoCs, have already zero warnings, thus for such platforms
> it is extra easy for the submitter to validate DTS before posting a
> patch. The patch briefly looks like it is not conforming to this rule.
> Please confirm that you tested your patch and it does not introduce any
> new warnings (linux-next is decisive here).
>
> Best regards,
> Krzysztof
>

