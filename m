Return-Path: <linux-kernel+bounces-46433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227B5843F94
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EED1C22D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CDD79DC4;
	Wed, 31 Jan 2024 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VCNI9Is3"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AA679DB8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705006; cv=none; b=kkpm0Lj+Zjl3fvBJPwVUnY1If8e3zWE48kRAj0pf/4La0Za4hr4cZl3Bkg1MUtWHuLHF1ybE6zGjjS7ONXQzH9Prp/HMSzFhKbNGmAwrhrz2NvMNqxKAqJXEbVsHuHY6gA48u2bNjC97aLcZjOVtN/BDdkjMEHeX9ZeD5KAocyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705006; c=relaxed/simple;
	bh=ahkd6NRQjX+1YbZ04uWO3jNts1thzHyPVgN0sDH7EQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SbgNXqfJPjBQwoSOhCQ6aGuwkrwiQ21841XE/ouxElX1jEGRgsb+yC+OqWh3CQNWdtzoXRvRg011k69ET3uDTaYar+Yam2oEscEV2xvON/oKOHISafLJyUqr3PjNZeoWroihlgZLN7Dj8/tkPuuUnwTHcCdhaqF4Jx+fkPpQzxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VCNI9Is3; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60412f65124so2106707b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706705003; x=1707309803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ahkd6NRQjX+1YbZ04uWO3jNts1thzHyPVgN0sDH7EQ0=;
        b=VCNI9Is39drr3En/6Hp+1qKt6+089FUElfMStUCeLiErGiUIho2dgxzUHgdnwKYwZp
         MkQFjDymPEglnvqm+8VEwJe7LmvCyl+evgLW1QNj/zt+ewfEykyQAtaY+XcsdD2tZwSG
         qKsvGpTFa5zFTTvvWj0oiTgsnXQ9e4Su89v1p5FH+DZlHvQzA0PjL0scqkpoE38faC4c
         9N8SWmN9oj3DtHaJNcEhudo4976W/4QdfszDNSFrmeDf/1/rSkfyR9RWMKUD3Tcev9aZ
         mTq6uNcE2NacLEgVYBNBUEniCwrFpR1NGGQ2VH6RNvqo4rZxuSjxlDaXbTlhcdCJGvgw
         IlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705003; x=1707309803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahkd6NRQjX+1YbZ04uWO3jNts1thzHyPVgN0sDH7EQ0=;
        b=OLA78943IYPHZIPgk51xxn91ILLArQarWpblyYSYdHf76DJUdYoCgWwy+IakcgAZf8
         SYhErXcV3mTMrex7Re4dbakDS8NXpxEqdqPTk5oGkBwUMwKG+ZFhVhePSCDVZH5iVFig
         yACchkQOqRGuXBSL4VyMyw0ntuUCTIBMH/cy5K7CbnM29QbK7VRB3TOxBlMdPUcoWRQq
         1vmiOuZdwDETyQ5c90MBwB+Cj5Lr73DytSgVSCm696GNB/qkAonapkstcf4e/btY32+W
         mWfSzCjPI24BgUcEgCpf6zJZKM/8sEDN7cHHlYguEEGwlihL836WrKaw7o/2bOIpthAZ
         r+AQ==
X-Gm-Message-State: AOJu0YziI6L5BaBIfPT+NiX9QzWFinbJkRuAz7EHFS1dMx7gwI2yhz0I
	8yv2g3JvjtrtVfbd2okL9caG+1mX3PKqqWcvOinRWuPaIkmBbAxRYSN/aBmDYNws48sLbmBrwpy
	1eeA+nVxh1h4gRj6twuzt4CAn/iFo4X/l8hDcng==
X-Google-Smtp-Source: AGHT+IGK45pFu9Pa1Y4+JOrlMYezN48nzfJwuAw7xA7NIk7/mMcASK1C1sKK2CK7I2+RbRleWeQNhGbNoUIiBg6vArs=
X-Received: by 2002:a81:8404:0:b0:602:b474:bd64 with SMTP id
 u4-20020a818404000000b00602b474bd64mr1319638ywf.13.1706705003378; Wed, 31 Jan
 2024 04:43:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5770175.DvuYhMxLoT@kreacher>
In-Reply-To: <5770175.DvuYhMxLoT@kreacher>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 31 Jan 2024 13:42:46 +0100
Message-ID: <CAPDyKFqpS0jwuxUe=NLA_Lvf2zdo+98ne3iar9Uqu6P=DFNFDg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] PM: sleep: Fix up suspend stats handling and
 clean up core suspend code
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 17:32, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi Everyone,
>
> This is a v2 of
>
> https://lore.kernel.org/linux-pm/5760158.DvuYhMxLoT@kreacher
>
> except for the first two patches that have been queued up for 6.9
> already.
>
> The original series description still applies:
>
> > This series of patches modifies the core system-wide suspend resume of
> > devices to get it more internally consistent (between the suspend and
> > resume parts) and fixes up the handling of suspend statistics in it.
> >
> > The functional changes made by it are expected to be limited to the
> > statistics handling part.
>
> and the differences from the v1 are minor.
>
> Please refer to individual patch changelogs for details.
>
> Thanks!

I have looked through the series and it looks very nice to me!

Feel free to add:
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

