Return-Path: <linux-kernel+bounces-130536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A37D989798C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3E61F2508F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEA915572D;
	Wed,  3 Apr 2024 20:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hh/xkprK"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA1E1553AE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174685; cv=none; b=cQAXOCywSrpEB4EKAnhzOQi9+tq3DBrcuqt8T7CpiwgHHFHL0tW2mBZ5IXX35R5t758c7YPqrecWVAGz3ufvGrfz9+uDD+NB9P93otLrSO8rDY24TQ830Pm3ReSzq8Nxuxqff9i254YMcC7pbVfEHyJIDg4X9VRmWsLMNElwQ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174685; c=relaxed/simple;
	bh=nte1yEPWtmTFWWFWa6iF5XCH+QggbDYqwUlZzf9i1xo=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcRklKBkEg91y7t7K7hBULztmlOkcOY29LpeAiOITU6gHeMaJTQW/3DWBFjMmL+pEUSk0JOmvTGycWtSfR19oGd/ZIGClZ+0kN5isSIBM0fSJ7GLUxPKUSzh2DTHV8hv5qy4NzRnk3z+vGs4QOS3BwQlPYiY2CqOLjIVasXDNSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hh/xkprK; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-515c3eeea5dso358551e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 13:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712174681; x=1712779481; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1ldXuBtZD0meeLQ9ewOsNc58bmXcN65nhQZrzCO4+o=;
        b=hh/xkprKOBqxX4c7vYkLSe7/VqxPy9a2IxsXWXxnfFsSwp6JxokVlLOgxIyeSMp1pb
         kkjtP9AKDUIEkrvxiADG0Ag3uqR8zxgVQoQLZNr4ZxR8Ppht8KQi3U5M7FS2vyuYKoXy
         D/N1W5X90PuJFYkXq9x4uJAnt0rSMsCavyn80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712174681; x=1712779481;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1ldXuBtZD0meeLQ9ewOsNc58bmXcN65nhQZrzCO4+o=;
        b=H8S2XATxGZC8T0eYLrDHu5GcbyQQa+M6/1V3nDFYn3djQtNic96oAIgoR3wCsfAtJa
         H9z/TbLjQulm+c4mHvInbKEB4dDdJ9Uk7aWM+wmk8DOZkZH/My1jWYTylUwhsLUdiic9
         REHeOTXZqY1JppGIgqI6zXLmtSmJpfzK25hOjH0gynrubC9Gy3bZLGJN2uO4tX6O9Zg4
         m4o0o3gyYp9Nf3kI7U6LSRi/7tTaz7+G5/q1TPb3YKQJWBUxuc0uPLGpk2Lc9dmGzXRi
         HuGDN0FwfVd4Lo7I7N2hi0hiPgR9BTAeyyXpe1YEtE1RC9u3ofZ+3WXDvyYtAScG74Kv
         peYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzcK24P1Fs6DeKN5gtcwUF9Uos6PPjYcoDTP4Dc1yueAFeNraT7VWkl6HAfZQHTPTdW6hwnXGWHwUdQ/I38arsgfjxtFq8D+lWy7PS
X-Gm-Message-State: AOJu0YyC78xDQZOSNGIOzOjDBiBG/HGmVQPCFVVFbCjHANraMMD5rw6L
	I/1GX3Ikyv4HKNR7bk0DsEg0Mpas4ufc2qCiXW+i6iPRncKyu96TlvFz+rS+I/WslvNB9GJ3lcI
	FtmZb1jU7a4l105P5XdktgpQCSps0lwTMGVY9
X-Google-Smtp-Source: AGHT+IEI86CzA7TT+IdyvGZ2GYs55lyyEY7kHHWG4VeBinBpm342IF+g/Z3YNKn5FTNDKtGHKVF5QpYrRF2JYfdtqg4=
X-Received: by 2002:ac2:5204:0:b0:516:b148:6d8 with SMTP id
 a4-20020ac25204000000b00516b14806d8mr354836lfl.50.1712174681526; Wed, 03 Apr
 2024 13:04:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Apr 2024 13:04:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2f509949-7e7e-cbf6-c1d0-f25971c2d890@quicinc.com>
References: <1711741835-10044-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n50Z2pDGH+ncjQq-huDsn9jdN=1SfaaU+qw229nZpUVCDw@mail.gmail.com> <2f509949-7e7e-cbf6-c1d0-f25971c2d890@quicinc.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 3 Apr 2024 13:04:41 -0700
Message-ID: <CAE-0n50qT2mHOGiU89NAmHdADQAAgs3aMP1RFOTTV8oCUbZKgw@mail.gmail.com>
Subject: Re: [PATCH v3] phy/qcom-qmp-combo: propagate correct return value at phy_power_on()
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	abel.vesa@linaro.org, agross@kernel.org, airlied@gmail.com, 
	andersson@kernel.org, daniel@ffwll.ch, dianders@chromium.org, 
	dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, 
	robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc: quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com, 
	marijn.suijten@somainline.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Abhinav Kumar (2024-04-03 12:58:50)
>
>
> On 4/3/2024 12:51 PM, Stephen Boyd wrote:
> > Quoting Kuogee Hsieh (2024-03-29 12:50:35)
> >> Currently qmp_combo_dp_power_on() always return 0 in regardless of
> >> return value of cfg->configure_dp_phy(). This patch propagate
> >> return value of cfg->configure_dp_phy() all the way back to caller.
> >
> > Is this found via code inspection or because the phy is failing to power
> > on sometimes? I ask because I'm looking at a DP bug on Trogdor with
> > chromeos' v6.6 based kernel and wondering if this is related.
> >
>
> No, we actually hit an issue. This issue was originally reported as a
> link training issue while bringing up DP on x1e80100.
>
> While debugging that we noticed that we should not have even proceeded
> to link training because the PLL was not getting locked and it was
> failing silently since there are no other error prints (and hence the
> second part of the patch to improve the error logs), and we do not
> return any error code from this driver, we could not catch the PLL
> unlocked issue.

Did link training succeed in that case and the screen was black? Also,
did you figure out why the PLL failed to lock? I sometimes see reports
now with an "Unexpected interrupt:" message from the DP driver and the
interrupt is the PLL unlocked one (DP_INTR_PLL_UNLOCKED).

>
> > Also, is the call to phy_power_on() going to be checked in
> > the DP driver?
> >
> >   $ git grep -n phy_power_on -- drivers/gpu/drm/msm/dp/
> >   drivers/gpu/drm/msm/dp/dp_ctrl.c:1453:  phy_power_on(phy);
>
> Yes, this is a good point. We should also post the patch to add the
> error checking in DP driver to fail if phy_power_on fails.

Sounds great, thanks.

