Return-Path: <linux-kernel+bounces-139750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFF68A073A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358311F246DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D252B13B5B0;
	Thu, 11 Apr 2024 04:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BVvf92su"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFA013C695
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 04:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712810609; cv=none; b=WEKJt3LuNwtLy9zP2J0fnQGEPUUFEIkoDNdlL12nUgBrmRpske8mmFNEFrQXPYA5fgnTPtACXDCmpNHP4e9N/igZcHRWzORol3GvzawKuv3wRUIkw7d/DZkuy8fcof7OCHKuiPO/Ky1JFGJIXnyDDFODxjCyLvy2U8MpJEq7Jps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712810609; c=relaxed/simple;
	bh=6lzwKLB3Q/bTbCjordLPg4qofdWe6rcdh5oPrBvdXm4=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bItgdMKrzp1lER/GHqpaa2yuMhK8fi2AaE5L+gIv9KzuGMsxL5PXPbgyJPsRwWAZYZ5+wbkAUf5vUo/rmOHfsQwDKzdZhyiEBrihYysvX6iaDLyqoB3HvVW2Z6YGZeNrrnNEQLJjFeJqgr2/bmb9uXW+Q7QJSc1HjX/8iAz/k0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BVvf92su; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7e3b3e33aa7so2324544241.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712810606; x=1713415406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6lzwKLB3Q/bTbCjordLPg4qofdWe6rcdh5oPrBvdXm4=;
        b=BVvf92suRfPuHj+fR3KNRnycA8HQw/OQq1kiT+ouGx6P/rwsrrbV75g6OqFUkDEmRv
         YCmBd99yj0npdsStkib6yuyqOIUZaGyDX/mwX8AzLQ6w+btP162lvEoL0Z6Q4xQGVUKb
         6KxLb113uxVG3q+7zBykJT7SSO3olQntPKThY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712810606; x=1713415406;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lzwKLB3Q/bTbCjordLPg4qofdWe6rcdh5oPrBvdXm4=;
        b=PHmfcqn33k7FauJmJ3QQZGNRijEpJrtz17elm6MPYMmBflOWWVR6b7KBte8J3LBQAy
         YjEYajPmuRiVe1v8w8ydUO7XdKIogdHM2DryG1G8RHiYAh5Txdnm5UlialiPqdP+5Iji
         JL97+q9sXgLFUNlxHzD2uJjVZIHST0ZfbFsy+aey3AUBtNsv53mjXjwiEBPLRrgGxcjn
         z4uVE9GOOtZVpFd+q5fvzUA2l0kCCvKtjun2uWhQ7xuoB3fewvRPW703tF0IUB66Shvi
         xKSL/lFRr2xfYUTXl5ovBKRNRHNNfDhLL3Aub3L6AW7V5rMCbkE99bQWQszVd1GYpygz
         MRfw==
X-Forwarded-Encrypted: i=1; AJvYcCV1ikInouFXYWANxO7nWXu2fwYMpvUB64TLEBkZOf8WT8wnVpUtG6zpxyzGusGa4PyRmYwppwgeWuduhljS+eFGlvznjQoccmcNywoQ
X-Gm-Message-State: AOJu0YwjmUrSN6WaM6O9tbHdOevk6XTQJloV+dlrg+fgHqxCui6U08AB
	MKy5/WQnsoERGztTftIgAV0N61mfLxB3p5cg01jVlOOIsPohY+33WEM8axtGAmYpgB4PUtPoeW5
	zL1wS+sOexieM2j7dtmXFmXNVE73UnIvlU85z
X-Google-Smtp-Source: AGHT+IHOJSAnynAh45GPONWTVR+UctgGJjBXaNxm7DI329kef7lVtAeG2dcKVZGBzK+j+2azS/WCcog+uYrBX7LywkQ=
X-Received: by 2002:a05:6102:dd4:b0:47a:2a80:e672 with SMTP id
 e20-20020a0561020dd400b0047a2a80e672mr3052186vst.5.1712810606285; Wed, 10 Apr
 2024 21:43:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Apr 2024 21:43:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240410204337739-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240327200917.2576034-1-volodymyr_babchuk@epam.com>
 <e0586d43-284c-4bef-a8be-4ffbc12bf787@linaro.org> <87a5mjz8s3.fsf@epam.com>
 <f4ebe819-9718-42c3-9874-037151587d0c@linaro.org> <cd549ee8-22dc-4bc4-af09-9c5c925ee03a@linaro.org>
 <ZgU_YDUhBeyS5wuh@gerhold.net> <CAE-0n50BGLccCTDfCmOd0Bcbmp7SMwsJd8qTVPWioKvbaD0A0w@mail.gmail.com>
 <20240410204337739-0700.eberman@hu-eberman-lv.qualcomm.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 10 Apr 2024 21:43:25 -0700
Message-ID: <CAE-0n51e5wm8haqOJgEmE+pEqqFSZOBXvLi-k_+V-Aa0rCXCWA@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Stephan Gerhold <stephan@gerhold.net>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, 
	Bjorn Andersson <andersson@kernel.org>, 
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Douglas Anderson <dianders@chromium.org>, 
	Rob Clark <robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Quoting Elliot Berman (2024-04-10 20:54:24)
> On Thu, Mar 28, 2024 at 07:40:49PM -0500, Stephen Boyd wrote:
> > Quoting Stephan Gerhold (2024-03-28 02:58:56)
> > >
> > > FWIW: This old patch series from Stephen Boyd is closely related:
> > > https://lore.kernel.org/linux-arm-msm/20190910160903.65694-1-swboyd@chromium.org/
> > >
> > > > The main use case I have is to map the command-db memory region on
> > > > Qualcomm devices with a read-only mapping. It's already a const marked
> > > > pointer and the API returns const pointers as well, so this series
> > > > makes sure that even stray writes can't modify the memory.
> > >
> > > Stephen, what was the end result of that patch series? Mapping the
> > > cmd-db read-only sounds cleaner than trying to be lucky with the right
> > > set of cache flags.
> > >
> >
> > I dropped it because I got busy with other stuff. Feel free to pick it
> > back up. It looks like the part where I left off was where we had to
> > make the API fallback to mapping the memory as writeable if read-only
> > isn't supported on the architecture.
> [...]
> > The other weird thing was that we passed both MEMREMAP_RO and
> > MEMREMAP_WB to indicate what sort of fallback we want. Perhaps that can
> > be encoded in the architecture layer so that you get the closest thing
> > to read-only memory (i.e. any sort of write side caching is removed) and
> > you don't have to pass a fallback mapping type.
>
> Was there any motivation for having the fallback? I suspect driver
> owners that want to use MEMREMAP_RO will know which architectures the
> driver is applicable to and also know whether MEMREMAP_RO would work.

I don't think there was any motivation, but it has been many years so
maybe I forgot. I suspect you're suggesting that we just don't do that
and driver writers can call the memremap API another time if they want
to implement a fallback? Sounds OK to me.

>
> > I also wanted to return a const pointer.
>
> The stash looks mostly complete. Do you think it should be part of the
> series or submitted separately?
>

Make it part of the series so this topic can be finished? For example,
it seems like iounmap() should have always taken a const pointer.

