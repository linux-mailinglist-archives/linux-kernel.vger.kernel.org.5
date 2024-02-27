Return-Path: <linux-kernel+bounces-82715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6F5868888
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7221C21CA8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD4752F82;
	Tue, 27 Feb 2024 05:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HaIdc1OD"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7343C52F7A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 05:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709010860; cv=none; b=IJMs19h4FfWoYksb3qy1b6rpvYh7DC0PqGovw3PC9ElDspENLO9vfOJWQ1HGxYHQy/CktAGwSZTvT0Tlxl7th+nFWWIW6tvlgrVWtYxFk4AXgHRbHwuda1OniWgi+FW49iMvxcsO2aMx/isof0g89ULN5Q7ApmRh+yhH1Ls/A4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709010860; c=relaxed/simple;
	bh=Wgvaos4tMDHQHCPQqba3sjMn7hXYBzfhsdVtj292alY=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V73yQxbK3k1xvT3uxWNBJlBMCkvWS2y6KlaShwbPnW+HGDGrCkLMEFXhq50lajAEpNfOhmb3w8yzgk0bIq1IcHKNbDzaGBZsrN8GQ0J2jXxvzsVWV6EqmeXVGS0U0FljRkSOdKquvQVJaZ3OPPvgXFeWKIPKDkOdWsDvFZ+NNmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HaIdc1OD; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512bde3d197so3551025e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 21:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709010857; x=1709615657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+BQPLCLZpqrKhiNrmiNzr4nlNlMBixVqIVv6pIcROQ=;
        b=HaIdc1ODNMxlOsrywwjh3RFkhQkvE3ZYafJeIPdrulpSwzeyUh9AsW00piKpLZwlAn
         URKPTxrOjN6tp3uNO/23dvbMa8rCNcPWCGKsLEUpR4u+hEhbOUACjMVMgfSSI2VdkKrp
         BeOJ58jSLmi9W5fgMeWm98PxiiN0y2MQmDwmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709010857; x=1709615657;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+BQPLCLZpqrKhiNrmiNzr4nlNlMBixVqIVv6pIcROQ=;
        b=c0Q/jI7WVPFaRSyRgiPvFivZo/uqO1ANKDx+07RtHcEDoIULxNZW1a+MsRUZhp9o/q
         6WMSgey1GRaJnPeNPhlPDqwFQFOVy0CGSl3xew6M2etBiEvzC2UyPXIZ/wlk5WJNyZxy
         cdJmKZRFt4jeEuR3ZPRqVD8iMSnCGql7rAa4Bi2u3fvylUEShCTS6QOO3xhWtPOwwbjY
         q5MBUcHOrZsYscGExkLTmeOwrWJC3GBG0HXhJDKjPU0m39LK/PeK4yX+i7FUU9cD0wnI
         BvznWA7qkKpUY36AUl5w09JKWSZsfLDxziZ8v50vpXvOSgdoQ/nYhJaMb1l/bLNswqtg
         HIuw==
X-Forwarded-Encrypted: i=1; AJvYcCWgcxKvRIt/7kUK6Z58JDWmNhaDiPeWTkeZ75iVFJh4hM8V4jK8ZEErogcTRoeSn340jLVSQCIWOlA/vNH2qimf1Il+mjT8a10YKxqL
X-Gm-Message-State: AOJu0YxvcXY5xR7iMT6Kyr+Ur9zQliAVyDeyId/LOx2R+9ileMM1IL0e
	c0KqmSi6zVpwMxHI3qTLYAcujEZM4pg7Xzs2mLGkJ8Ixj66Jlysq+fiIdtnST/e/GjSajr2EZOE
	HrHM+Kg9J4YoQK4U6l3m6AV0VxgOhrsvf3YEj
X-Google-Smtp-Source: AGHT+IEyr7KXQAxsoRvnnHsDV6pqu0w4lJ40YXWqL0S1fUTZrVkMUjLcnZFHznlTZjulbsH6+afvAMnzVzmlCSDcWyk=
X-Received: by 2002:a05:6512:991:b0:512:ee1f:b5af with SMTP id
 w17-20020a056512099100b00512ee1fb5afmr4441994lft.41.1709010856400; Mon, 26
 Feb 2024 21:14:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Feb 2024 21:14:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240226-rpmhpd-enable-corner-fix-v1-1-68c004cec48c@quicinc.com>
References: <20240226-rpmhpd-enable-corner-fix-v1-1-68c004cec48c@quicinc.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Mon, 26 Feb 2024 21:14:15 -0800
Message-ID: <CAE-0n525gwp5kJGgw9Pnz+h2K6FbuqSG79KfMj_EnueZ-RYnuA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation
To: Bjorn Andersson <andersson@kernel.org>, 
	Bjorn Andersson via B4 Relay <devnull+quic_bjorande.quicinc.com@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	quic_bjorande@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Bjorn Andersson via B4 Relay (2024-02-26 17:49:57)
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
>
> Commit 'e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable
> the domain")' aimed to make sure that a power-domain that is being
> enabled without any particular performance-state requested will at least
> turn the rail on, to avoid filling DeviceTree with otherwise unnecessary
> required-opps properties.
>
> But in the event that aggregation happens on a disabled power-domain, with
> an enabled peer without performance-state, both the local and peer
> corner are 0. The peer's enabled_corner is not considered, with the
> result that the underlying (shared) resource is disabled.
>
> One case where this can be observed is when the display stack keeps mmcx
> enabled (but without a particular performance-state vote) in order to
> access registers and sync_state happens in the rpmhpd driver. As mmcx_ao
> is flushed the state of the peer (mmcx) is not considered and mmcx_ao
> ends up turning off "mmcx.lvl" underneath mmcx. This has been observed
> several times, but has been painted over in DeviceTree by adding an
> explicit vote for the lowest non-disabled performance-state.
>
> Fixes: e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable the domain")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/linux-arm-msm/ZdMwZa98L23mu3u6@hovoldconsulting.com/
> Cc:  <stable@vger.kernel.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

