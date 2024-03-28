Return-Path: <linux-kernel+bounces-122410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A074088F6B3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD53298C72
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41143FBA2;
	Thu, 28 Mar 2024 04:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jdc+Jjoo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3155D3FBA7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 04:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711601429; cv=none; b=GlaDeF0GuoEZ8zVp1oKNENGM1BetQqJTYS6jzpzg2jrp9BTZQwlyZRqKHh8KC2iDUHSJ13I9m/P+AyP0MBwBqQyZd4G1tFbQHul2ZMfZGamvep+aH+V1Jsy6Wx1Gi0neKMBOm+2dWhTi5UNvE02fTPYonT5xl3Dzf4VR5h/oX3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711601429; c=relaxed/simple;
	bh=xY/HNhI1nvghGP/OSzgUM0x0YxXVXvi/u/5b00HnsE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cceBpZwOOO9d9DSpCyArx/Jn1r4R9tGs6RPtFhm2KvqzZbwI+8yhJ9DCMEKk5qi3HZCusZZsEXgrP90D6x8gs6GN1St24zJRiR5CrN6O7C3oVtIp1VH0B4blyNhHEAAy1o7YIsGcOxx7ZeqhMGUFCYXiTMiUjgJeU7ftddcVfjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jdc+Jjoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20A9C4167E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 04:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711601428;
	bh=xY/HNhI1nvghGP/OSzgUM0x0YxXVXvi/u/5b00HnsE8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jdc+Jjoo6pXlAr89uOoUeHYOafMkPdLKwde2gkD1wCaKJaVmBUOPesJv9xozeU6l4
	 ZMXJkS0t6gqx/EgoubmKk3XLatstrXAogTzk5P4FoDokRL8MmRyeQWGmM7ita1ToYW
	 PzTYWOZ4c6af91b9oBZBfxmonfRGZS8haQ4iLGDEGNWi7Jce5ey9MZjlGMXvStKJEW
	 bet5GEODEZNMG/WpHhEu9cuPRGD8b219a9Wy7PeEl93+vjByrTPgXJ/S3kbTf/go/V
	 2x6qvxa0ynUxn33poU3gtWeMfnWT3B0clQojwOPiJbC4gbehKX34l93oInAUAKVTLn
	 rukzO35zP80dA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-568c714a9c7so520131a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 21:50:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUn0aaUZvQJuVN3ZWSFyrwuNwekcsARLVW38dn+QpQ0eqTMhFnK03/2nWfKFgTDHRavCDm5vwYeX8JEdvuUib/VK6VSATlTr7s3CE3+
X-Gm-Message-State: AOJu0Yy/r0yjU1ggD7aFgsHXHTy+FmVUrNy2rcl4FqPH5W/RxEXz4mPg
	69n5OGfXkQe/A2Ai4uUgJ6JJzk4+nEx3AfVNFzYaHpZ5Be9RotWQyNI6610VHeQJhXtglcTZ0oU
	APAeWRDlqwqB4rU20RDZgmjwvWPQiEBPShAGItg==
X-Google-Smtp-Source: AGHT+IEm55nBivDBKmxEjdKFbUvUfnIwT9rouZunAhi1aFtOcHvo3G0pJiyBhJ/1+PibUmlWLC2dNrkwWfqWh5slCe8=
X-Received: by 2002:a17:906:718a:b0:a47:3428:2b2f with SMTP id
 h10-20020a170906718a00b00a4734282b2fmr878468ejk.64.1711601427303; Wed, 27 Mar
 2024 21:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326074033.17002-1-quic_priyjain@quicinc.com>
 <9bea167d-edcf-4d66-8ec7-051e97c8dffd@linaro.org> <05d95845-85ce-bf83-57a7-135265a7508d@quicinc.com>
In-Reply-To: <05d95845-85ce-bf83-57a7-135265a7508d@quicinc.com>
From: Amit Kucheria <amitk@kernel.org>
Date: Thu, 28 Mar 2024 10:20:16 +0530
X-Gmail-Original-Message-ID: <CAHLCerM-iD0k-gOEtRP0y7J1k_mJpiNp1RUFhJg12V6eN7evSw@mail.gmail.com>
Message-ID: <CAHLCerM-iD0k-gOEtRP0y7J1k_mJpiNp1RUFhJg12V6eN7evSw@mail.gmail.com>
Subject: Re: [PATCH v4] thermal/drivers/tsens: Add suspend to RAM support for tsens
To: Priyansh Jain <quic_priyjain@quicinc.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_manafm@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 3:12=E2=80=AFPM Priyansh Jain <quic_priyjain@quicin=
c.com> wrote:
> On 3/26/2024 4:30 PM, Daniel Lezcano wrote:
> > On 26/03/2024 08:40, Priyansh Jain wrote:
> >> As part of suspend to RAM, tsens hardware will be turned off.
> >> While resume callback, re-initialize tsens hardware.
> >>
> >> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
> >> ---
> >> V3 -> V4: Make tsens_reinit function specific to tsens v2. Add
> >> NULL resume callback support for platform whose versions < ver_2_x
> >> in tsens ops.
> >> V2 -> V3: Remove suspend callback & interrupt enablement part from
> >> resume callback.
> >> V1 -> V2: Update commit text to explain the necessity of this patch
> >>
> >>   drivers/thermal/qcom/tsens-v0_1.c |  6 +++++
> >>   drivers/thermal/qcom/tsens-v1.c   |  3 +++
> >>   drivers/thermal/qcom/tsens-v2.c   |  1 +
> >>   drivers/thermal/qcom/tsens.c      | 37 +++++++++++++++++++++++++++++=
++
> >>   drivers/thermal/qcom/tsens.h      |  5 +++++
> >>   5 files changed, 52 insertions(+)
> >>
> >> diff --git a/drivers/thermal/qcom/tsens-v0_1.c
> >> b/drivers/thermal/qcom/tsens-v0_1.c
> >> index 32d2d3e33287..7ed85379247b 100644
> >> --- a/drivers/thermal/qcom/tsens-v0_1.c
> >> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> >> @@ -329,6 +329,7 @@ static const struct tsens_ops ops_8226 =3D {
> >>       .init        =3D init_8226,
> >>       .calibrate    =3D tsens_calibrate_common,
> >>       .get_temp    =3D get_temp_common,
> >> +    .resume        =3D NULL,
> >
> > As a static variable it is already set to NULL. Why do you need to
> > explicitly set them everywhere ?
> >
> It was asked in last version to explicitly add (.resume =3D NULL). So
> added this for all the tsens platforms for which resume callback is not
> validated.

Daniel's right, you can lose this bit now that your reinit function
will only work for 2.x.

