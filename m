Return-Path: <linux-kernel+bounces-45041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF49842AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312431C258BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E3C86AC8;
	Tue, 30 Jan 2024 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="krXG7/Lh"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035CD1292CD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635734; cv=none; b=FEoRmTXGUmvn+6HLWkxImObBo15vWLNExuHzA9nUk5J5LpzKHT9ZzlqyuOnxsc3BIg9ynwj9V3lAfCWHtO9DtBT6eq5Lm0YVWReb0rDQvwEY689OMky670iKbD6eXJAIzjsW83xAPx0gZDfxAdyovQDc+xm2v2Yt45YtRJI6P+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635734; c=relaxed/simple;
	bh=14TQ/1zcCqLGdolRK0IcXEJl5bdtA9sEHTihtDnduYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFNQMH207IZvpY3PH1Eab/cSCgCcIZym4zt7V6pHV5heIVxqdu3uR9rn3fylBOTgA9TH8acgEwKZ9xidEjbZf/y6ApfkGpZtDSFlZ0Zm4IUxMB8DEzPaRGsT4aViJgSGuOTNxH52av3DKX/4hUtkKecvYJIiJ1cy18/uzN0EpDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=krXG7/Lh; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso2328169a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706635732; x=1707240532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fZz+3WykNM8556Tzol1mqtpnBeKBTaXu9EkNH0f8s9c=;
        b=krXG7/LhOyZCCXw1aBfLZE/J8LJmLxFgj1GUWfM4v36DhPcxTkZ1898b3r6iKvR55q
         AUOScNK4SWlik+35ZJoL6gJcq+jfRY7iAhPAfP81GzynXSTh5vZ1Vda4nmqjQDaziKVU
         aEnmOvY0sYM02ZhF7OobqW2ohyA4/Cq7LgLKan/oYZpwXnSHi1vYBxLjU+tkrJSJF1yh
         sUjuc9DRSQAxeUqpx5WCB304WXg3Etzobudy1J6rogRqnNdXg8ePUxawVxdeqB67GnI1
         BhBNHZPixZ2qO/+MDzyk59nyu5EV4qam2ObDVgpYNkFAqjnJ9IBiLuiJrkzeP7wEQUeq
         ujQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706635732; x=1707240532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZz+3WykNM8556Tzol1mqtpnBeKBTaXu9EkNH0f8s9c=;
        b=u1UDTdYXgsroTZ2SDgxF663869pXpjJp/MgZlTe7MBdWcpTMdUldi/jJEn1oqCxCAU
         4oB96z2/W4vYtnT93RiDNMVEIt6zeQzeZb42mPZvpmBKmwwA50d0eoFuH0Eh3Z3Z4v+M
         hk3881tkZ1bHINtmHfMehhWQv7HOV3SjuzgbVKGwpM74hKJ4aM1nmFwm7N0kkr8ffNSO
         4AJEehBKDT/4EepdID+rxmuY9oLSUSAGBrxMjERQKUtspBTC5Py4Vcfve/qzHRyIv/55
         +IwZhZB9Ca+AlwRt+9ikI/+XgePUYsoA5tatat7KgTaZ3dN95iR8r/dX4p4LPd586Hlo
         LwhA==
X-Gm-Message-State: AOJu0YynWopgaARw1cg/GninyUFoZ3Y5lKhlWM2I88JX4ly9j6H4dyFX
	dU1C+PuFrIL2t2K1HpbDu+s1boKPE72yaDhZo5aUo01cWIh7FE7GIqmy6mmGRS+jfhMj2w5RyWT
	LBruk1GPLkbsMCcf7wFX3Zt+KpxF94Tzw+oQnOQ==
X-Google-Smtp-Source: AGHT+IFhnTLNnR0RIqoES54tod5OivJXs32LyIzAe5lH54IERWGNOWiPrgUtQZYL8/C6vjjnV6O2Ng/fDqCQzij4xrY=
X-Received: by 2002:a05:6a20:6e81:b0:199:37ce:2370 with SMTP id
 gr1-20020a056a206e8100b0019937ce2370mr4431243pzb.23.1706635732296; Tue, 30
 Jan 2024 09:28:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208002342.367117-1-qyousef@layalina.io> <20231208002342.367117-9-qyousef@layalina.io>
 <a561029e-993d-726d-18ce-0bc014e6533c@quicinc.com> <20240121000444.ghue2miejmiair6l@airbuntu>
 <8dfb5db7-6da0-4f6f-30ef-8966428e4a1c@quicinc.com>
In-Reply-To: <8dfb5db7-6da0-4f6f-30ef-8966428e4a1c@quicinc.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 30 Jan 2024 18:28:40 +0100
Message-ID: <CAKfTPtB=nv7DDqTvsdenOg+UNoNFx=f2SLvihHx+CMkeE6NyNA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] sched/pelt: Introduce PELT multiplier
To: Ashay Jaiswal <quic_ashayj@quicinc.com>
Cc: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>, 
	Chung-Kai Mei <chungkai@google.com>, quic_anshar@quicinc.com, quic_atulpant@quicinc.com, 
	quic_shashim@quicinc.com, quic_rgottimu@quicinc.com, 
	quic_adharmap@quicinc.com, quic_kshivnan@quicinc.com, 
	quic_pkondeti@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 17:22, Ashay Jaiswal <quic_ashayj@quicinc.com> wrote:
>
> Hello Qais Yousef,
>
> Thank you for your response.
>
> On 1/21/2024 5:34 AM, Qais Yousef wrote:
> > Hi Ashay
> >
> > On 01/20/24 13:22, Ashay Jaiswal wrote:
> >> Hello Qais Yousef,
> >>
> >> We ran few benchmarks with PELT multiplier patch on a Snapdragon 8Gen2
> >> based internal Android device and we are observing significant
> >> improvements with PELT8 configuration compared to PELT32.
> >>
> >> Following are some of the benchmark results with PELT32 and PELT8
> >> configuration:
> >>
> >> +-----------------+---------------+----------------+----------------+
> >> | Test case                       |     PELT32     |     PELT8      |
> >> +-----------------+---------------+----------------+----------------+
> >> |                 |    Overall    |     711543     |     971275     |
> >> |                 +---------------+----------------+----------------+
> >> |                 |    CPU        |     193704     |     224378     |
> >> |                 +---------------+----------------+----------------+
> >> |ANTUTU V9.3.9    |    GPU        |     284650     |     424774     |
> >> |                 +---------------+----------------+----------------+
> >> |                 |    MEM        |     125207     |     160548     |
> >> |                 +---------------+----------------+----------------+
> >> |                 |    UX         |     107982     |     161575     |
> >> +-----------------+---------------+----------------+----------------+
> >> |                 |   Single core |     1170       |     1268       |
> >> |GeekBench V5.4.4 +---------------+----------------+----------------+
> >> |                 |   Multi core  |     2530       |     3797       |
> >> +-----------------+---------------+----------------+----------------+
> >> |                 |    Twitter    |     >50 Janks  |     0          |
> >> |     SCROLL      +---------------+----------------+----------------+
> >> |                 |    Contacts   |     >30 Janks  |     0          |
> >> +-----------------+---------------+----------------+----------------+
> >>
> >> Please let us know if you need any support with running any further
> >> workloads for PELT32/PELT8 experiments, we can help with running the
> >> experiments.
> >
> > Thanks a lot for the test results. Was this tried with this patch alone or
> > the whole series applied?
> >
> I have only applied patch8(sched/pelt: Introduce PELT multiplier) for the tests.
>
> > Have you tried to tweak each policy response_time_ms introduced in patch
> > 7 instead? With the series applied, boot with PELT8, record the response time
> > values for each policy, then boot back again to PELT32 and use those values.
> > Does this produce similar results?
> >
> As the device is based on 5.15 kernel, I will try to pull all the 8 patches
> along with the dependency patches on 5.15 and try out the experiments as
> suggested.

Generally speaking, it would be better to compare with the latest
kernel or at least close and which includes new features added since
v5.15 (which is more than 2 years old now). I understand that this is
not always easy or doable but you could be surprised by the benefit of
some features like [0] merged since v5.15

[0] https://lore.kernel.org/lkml/249816c9-c2b5-8016-f9ce-dab7b7d384e4@arm.com/

>
> > You didn't share power numbers which I assume the perf gains are more important
> > than the power cost for you.
> >
> If possible I will try to collect the power number for future test and share the
> details.
>
> >
> > Thanks!
> >
> > --
> > Qais Yousef

