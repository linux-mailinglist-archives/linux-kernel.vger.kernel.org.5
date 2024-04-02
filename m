Return-Path: <linux-kernel+bounces-127841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EC789519A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6A76B24716
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA48F67E69;
	Tue,  2 Apr 2024 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xtz5tf/Q"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DD665BD1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056630; cv=none; b=B4xf+A1RbSYqlkrnIoF/YHaaGfsGy5I8hoqSPGwQI0SRMfcifGHbxxzlZmkEs2PIOGJW0s1VTwgnPATEjfx05ey3LpOcK+EN3bU5067Lqe/uRX+FO+JMVw754R7btPfGZpqOQzwsC+qtFpiBGmO5up6knrclNP8jTx6Q9s+hxaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056630; c=relaxed/simple;
	bh=xYEx1wB0KeFh5dfJ6HSa7rT6aZpOvWbEWZUcFmvpOYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/jRalVmDuGNrBFIT9bue4ZMiE1lD22eLHoUnt92aU9t5h//20P1yOpIhBp5Y1eZ6cTiQxZcHJLZ2sKirzAJB5qPrst2qW1Ojoc7ctQj4pOr2HG55O0xCjmB8qC1vpnGQIiaWK2/PwQrXlqtG1S6h3yrwlKdvHKjWZ6UYqlxDpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xtz5tf/Q; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so4526722276.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 04:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712056627; x=1712661427; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mFAn5q7CQFxXq7JaY+/0V77lsWhz1Tz0icfhEeQZiIA=;
        b=xtz5tf/QsdMLoKnoqx6rUztU2p56/IxKm4kRKm+X4rVcFkrg6e4owC085eK/kYL9kn
         1tjX/ujIHU2cSIoDXA+qTG4MG/rMfvW26UTiwox3tRNqJOZ89Rk+y3ptLICVRhzHPQ6x
         jkQbPlQehDn2Y+KS9/2U1QRPC2pEjlrfZbyjnzhgecb4F638Q1Nyz44id0neiJPxZLI6
         qk/2LfRlq7Me3H7TwhUfQHDas1GKcuIiVc0CGuTn2F6ZLc2h41wtu7/tw81J7mVFKcap
         3mAT8KO0GKbRQ1WL0Wyuc+RV03yzIC5f0jZ3AuBZT/oyofHnXGfIP5L9Or4GyuZLT078
         Xqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712056627; x=1712661427;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFAn5q7CQFxXq7JaY+/0V77lsWhz1Tz0icfhEeQZiIA=;
        b=ur99Tu6gm+lYhS56SgkS/hsIt8b6iMzLlKWFh0jt37YTatxckKUqP6wnvyD8zoHzts
         GRGa+5hWMwL+1N02xjHTemAfXzmNI2WTLmjfPu5Evl0QZEpDmpYLo5EmNaPBpoKBEoIK
         Gsjbnv8Xdil872vB7oQEf1AVNs/DcoM/OKyhIue4DimDVrUgySjqUSa9M53WQ9KJH9I4
         WMJSlRF8qwl5nocGQWOxRk8YPAss3CtDkj/ZetWAj08JksqAnGcpk3H8Q5xHYPIGG7PZ
         ir4SjfHaZUqB3/7o+EWSOPiw2REAeiTnTrmc9SfKBLwsNZaQ+vGxmtx4mt7Eg6sZjepS
         TnmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGWpKVDvqWjsVtlsVzlflNB8oysUh4GpJZNDZBepsv7YfqXyBrLaD9Dg4h2mXgNE/h32XZ/s2wW2vrArxNBylP5GrsH1aFltN0hq2P
X-Gm-Message-State: AOJu0YzFMyfTpOjSryFkO1AxpDF88uLjKN2v/UR2PJmGQFe9HnGBrpEa
	JKSuMJQCyz0SJ1aELuplPOzlbiF4Mm2vIIQoKJXuv0Hag0V7dD+dxZUBIkf4NPZyXrIeufixXMu
	v4u5dm0c1HTLk84EBduayp5ln8YvJDdPXXYehT9Dxg6jOtL5s
X-Google-Smtp-Source: AGHT+IEigHxfdu3Sh5IlyKpDafnA1zAw4DSQNtZfWejv/aZ9zNxq090wRE2n00r1tIubWICmJpip1//6zCXSEBerIZY=
X-Received: by 2002:a25:640c:0:b0:dc6:cbb9:e with SMTP id y12-20020a25640c000000b00dc6cbb9000emr10783156ybb.41.1712056627317;
 Tue, 02 Apr 2024 04:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402103406.3638821-1-quic_varada@quicinc.com>
 <20240402103406.3638821-4-quic_varada@quicinc.com> <CAA8EJpphk_kqzBE7cKb73ipdpTi29t9ZSOOdSfq7pAGSs5NKeg@mail.gmail.com>
 <CAA8EJpo=TMhu+Te+JE0cQzmjLOTDPi-Vv-h5Bch0Wfr_7iVi2w@mail.gmail.com> <ZgvlrbvvPNA6HRiL@hu-varada-blr.qualcomm.com>
In-Reply-To: <ZgvlrbvvPNA6HRiL@hu-varada-blr.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Apr 2024 14:16:56 +0300
Message-ID: <CAA8EJpp2dgy0DcLoUuo6gz-8ee0RRwJ_mvCLGDbdvF-gVhREFg@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] interconnect: icc-clk: Add devm_icc_clk_register
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, djakov@kernel.org, quic_anusha@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 14:02, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> On Tue, Apr 02, 2024 at 01:48:08PM +0300, Dmitry Baryshkov wrote:
> > On Tue, 2 Apr 2024 at 13:40, Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Tue, 2 Apr 2024 at 13:34, Varadarajan Narayanan
> > > <quic_varada@quicinc.com> wrote:
> > > >
> > > > Wrap icc_clk_register to create devm_icc_clk_register to be
> > > > able to release the resources properly.
> > > >
> > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > ---
> > > > v5: Introduced devm_icc_clk_register
> > > > ---
> > > >  drivers/interconnect/icc-clk.c   | 29 +++++++++++++++++++++++++++++
> > > >  include/linux/interconnect-clk.h |  4 ++++
> > > >  2 files changed, 33 insertions(+)
> > >
> > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> > Wait. Actually,
> >
> > Unreviewed-by: me
> >
> > Please return int from devm_icc_clk_register instead of returning the pointer.
>
> Wouldn't returning int break the general assumption that
> devm_foo(), returns the same type as foo(). For example
> devm_clk_hw_get_clk and clk_hw_get_clk return struct clk *?

Not always. The only reason to return icc_provider was to make it
possible to destroy it. With devres-managed function you don't have to
do anything.


-- 
With best wishes
Dmitry

