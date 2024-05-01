Return-Path: <linux-kernel+bounces-164828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C602D8B83A7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055F51C21E3C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F338F15B7;
	Wed,  1 May 2024 00:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e1mFR0ja"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23B625
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 00:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714522641; cv=none; b=Ur0+oLjMz/oa6QUa+4wpuXJNX/+EEMlEZaKhN8vn6CLzp8es/ID/JNdiGQvm7Dqb2umW32Z9wvnkXORaRScwe760RJqd4blGDLCBOeubzS3bfIhTtLjzLFWEgssH4L2dMPtp9VuX497cf3KBvuHXdhJtgdcYEQcJWLIxNSw86Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714522641; c=relaxed/simple;
	bh=1ywHP957dN7QN6N91q0/xp7S+y5cWqGySegerlSjGbo=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZwB2BzV374kbQUgnBbDKuxunIIRhXbndUXXsyrarQg5MEQAtYoHi4XFcv0byTMlL6mw+HSZT2xRkhCQ/N9497IQhHrXi1nDRvTtuq2GkNcDwKZQQpbJf4v9AHOu9Rli6I2BsCVG4inkTEiLFm13W1BL4ACmDUbpV9HOwL4IPQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e1mFR0ja; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-79100a90868so181394985a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714522638; x=1715127438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ywHP957dN7QN6N91q0/xp7S+y5cWqGySegerlSjGbo=;
        b=e1mFR0jabgWyWSAAUL/bOSqHjDXedFTVZkyjI5G14PwDfAHUkLiQYu8mygH22XkAkd
         NaEGUFZyOnK2jOTEjv6bVM8qCWYF6qKG9kRKf3fSGUiukhVKezMmrJuPjc02mRMwoZqK
         4HBcSa+NtowSV9UqTdGcO9mRihWNk3Pjclh08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714522638; x=1715127438;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ywHP957dN7QN6N91q0/xp7S+y5cWqGySegerlSjGbo=;
        b=W/Blq2Ib3M2TCk0yxgizd6Mbo/VDv++kIiyEk+PdaFijIR1/Qrp+guRXBR8wsFGuTC
         un8UgGQN0J249A0jTq93zPRrMfuoUYtJk5xDcG8kUt7rCoKuvdZBfCThYDf8hxb3Cujw
         OYM/8jfK8bdfuzneBYZ6A4lWev07irLZXcy4Mk7y4ku9cnbHdeGklR3sGthM3jTfEQbx
         /EbZLtFrwcM6Oi5o9+KT96CCjeOfIBPSTomLTW7hMojEQnyuIpcDlWram2hqfMA+WOs9
         yRDVEKOQnHpQLHrGdBHvGRuDxxm9cdxd5kOruQa9x/V8zEvyJX08bvqsQ2iDISFyG1kU
         BPRw==
X-Forwarded-Encrypted: i=1; AJvYcCW8bEEDXojU6L/5Ivj57OXDVN1kZGnmjwjylYMWzeaSXLBFqHbpx/+KuQdkIwwBnYxDphBAGqaNXzpYBUtlbduMmKulT6dY300OnyjN
X-Gm-Message-State: AOJu0YxiyFqvyunRFiERnN32deS0p68wLO4DqaKwuj29+dlktNXtk38V
	lhkWXYQLFLGGCPiDL1+WKCkFWLDvoN0rONPrDSr1cSmmg6Me6LOBuM0CCUIv54lgfooY946wvtY
	EL1M/3wo6S/Nuy9pKvKdDX5byY8KbB5sfnw1l
X-Google-Smtp-Source: AGHT+IFHbVqJvW5Quh1nKokc7DOIECNmTOz55NPM4sjfdsU1vArTv7tsX5xChcnAkiqJBSUd0f3wLcvCxkKHa97Wo0U=
X-Received: by 2002:a05:6214:62c:b0:6a0:cd28:ffaa with SMTP id
 a12-20020a056214062c00b006a0cd28ffaamr900368qvx.25.1714522638644; Tue, 30 Apr
 2024 17:17:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Apr 2024 17:17:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VLwa0AFsrXXxKGG+hcyW+h7u7-tyg3uoDB8M_XdPti_Q@mail.gmail.com>
References: <20240327202740.3075378-1-swboyd@chromium.org> <CAD=FV=VLwa0AFsrXXxKGG+hcyW+h7u7-tyg3uoDB8M_XdPti_Q@mail.gmail.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 30 Apr 2024 17:17:17 -0700
Message-ID: <CAE-0n51osUcpqqh6o9OhURLbRKjcWbRZT-5oHLi_mwfJsUngEw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix a black screen on sc7180 Trogdor devices
To: Doug Anderson <dianders@chromium.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Laura Nao <laura.nao@collabora.com>
Content-Type: text/plain; charset="UTF-8"

Quoting Doug Anderson (2024-03-28 09:39:54)
>
> I spent a bunch of time discussing this offline with Stephen and I'll
> try to summarize. Hopefully this isn't too much nonsense...
>
> 1. We'll likely land the patches downstream in ChromeOS for now while
> we're figuring things out since we're seeing actual breakages. Whether
> to land upstream is a question. The first patch is a bit of a hack but
> unlikely to cause any real problems. The second patch seems correct
> but it also feels like it's going to cause stuck clocks for a pile of
> other SoCs because we're not adding hacks similar to the sc7180 hack
> for all the other SoCs. I guess we could hope we get lucky or play
> whack-a-mole? ...or we try to find a more generic solution... Dunno
> what others think.

I think we should hope to get lucky or play whack-a-mole and merge
something like this series. If we have to we can similarly turn off RCGs
or branches during driver probe that are using shared parents like we
have on sc7180.

Put simply, the shared RCG implementation is broken because it reports
the wrong parent for clk_ops::get_parent() and doesn't clear the force
enable bit. With the current code we're switching the parent to XO when
the clk is enabled the first time. That's an obvious bug that we should
fix regardless of implementing proper clk handoff. We haven't
implemented handoff in over a decade. Blocking this bug fix on
implementing handoff isn't practical. Furthermore, we're relying on clk
consumers to clear that force enable bit by enabling the clk once. That
doesn't make any sense, although we could use that force enable bit to
consider the RCG as enabled for clk_disable_unused.

An alternative approach to this series would be to force all shared RCGs
to be parented to XO at clk registration time, and continue to clear
that RCG force enable bit. That's sort of what Dmitry was going for
earlier. Doing this would break anything that's relying on the clks
staying enabled at some frequency through boot, but that isn't supported
anyway because clk handoff isn't implemented. It avoids the problem that
the first patch is for too because XO doesn't turn off causing a clk to
get stuck on. I can certainly craft this patch up if folks think that's
better.

To ease the transition we can make a new clk_ops for the RCG as well so
that each SoC has to opt-in to use this behavior. Then we can be certain
that other platforms aren't affected without being tested first. I'd
prefer to not do that though because I fear we'll be leaving drivers in
the broken state for some time.

