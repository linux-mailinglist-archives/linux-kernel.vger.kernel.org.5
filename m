Return-Path: <linux-kernel+bounces-61406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0358511FC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9031C2149A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFDA39860;
	Mon, 12 Feb 2024 11:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Flmbgik0"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E95239846
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736662; cv=none; b=hI0EhhizxKkEdu5QAldWVRBkD2UpgV4l7ok0xCLOBeHuDxXzE3lCt5N4CMF6GsMno7UfbJOGnleiBWJX02pD/2ZaS2A9dN8TEOtDJzgfRcktMAMtpZPaHUh1zY9unjt4URoZHjfoiMX3p4Mw1+Ph1CpEwuBA0+A9bmQwSA+xlHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736662; c=relaxed/simple;
	bh=6OuJxan0RO9Rm8CnHzNnBl9DKAywxvgH9Eco662MVcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqFbNFrD0zneB+MiAwNtAQHRYKKbKKeqnmyl6tXqkObYcLbKZBqx7rS+3nJe+xb1MGp5LlpzA+NDqhThAdDR099+QAJTgk81uHPDi2bmqsqAXFPO4j7DomzMFF13oQmJv4qFvKyXdq1kIdqTCFAwhne4SCCh9/Vk+B5K1cCHKNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Flmbgik0; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-604b94c0556so21432167b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707736660; x=1708341460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eXlnIB6w3EJyUe2smpgvDwHTN4H9326dG042toXH0B0=;
        b=Flmbgik0+EerQvJble09ihH1iXL/+PRQirW6gTCoe3MWE69aDs8ZWdwvN/J4/Wphie
         5ayPzw5JhOjYYm3y0uFR7cehKSgee0dRQ61Ci5myK0GM34c5Sq6ospJIPHwoC/X+nQ/w
         M8GgbySOjpin6Z9JdM7ZTLHTyg9lh8wlnT3RpPrqo32LUKDjOnLbw1mAv7OKrAc61pvl
         X0WoptTWRxnz6dIuM5p2bUFePFe2mG86DFHb/c8aUvBCBLmxf4W94tqZrsVKXlhUCkvp
         21lh7llZcRkY/rz5JSOqK+/p3cMZgxhFucPqroAx5EM2G609URoPOoMwEblolkeyk5BX
         FCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707736660; x=1708341460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXlnIB6w3EJyUe2smpgvDwHTN4H9326dG042toXH0B0=;
        b=Co+xorM7bAuRIenmgIpMVxg+JgCR0p1redgg0TNvCBdaw0aiJCRZUoP92PVDSMOx26
         rNdGxjlx9hgi3HNc205rw7nyRskZWAJlb+wngnznbJY2xiSovgC0t6fTW+iQmmjKrAlA
         fN1kTd/yS3wZ5YaCf1jbGVNHTX9hjYWaFv/xAF+h246PhZZ/pvUd+KJHls6EYz2ognRP
         ipdXyX4e5gWrHdzc0YLHWfFjwgSk4TxjjUKnH/OwWP/zOSspauHMNijLW9hWrJ2CKpJ6
         tWfYl0AhpEqY2inNwo/vjOG8GJLVY4qUluoiALFhjEEqVx/5L3lnPm51jgH4fymDx0G7
         qyEg==
X-Gm-Message-State: AOJu0YxCoFTC5IHk1kPUoaTHTIlaT3fn/4pEz/8kt5OGYNPf4pExuD4n
	MGfzaLRIHbVYQziaA88vqyo7ud5lE6t1Mw2JTSXEhWThLsmXjg4jAqg3XXp108R4/cQyh+A49R5
	3WAk/MYD+Am+/a/xRp1/87ON8U7BN2GZAUZQ17nKLNbJ3Le3xe4A=
X-Google-Smtp-Source: AGHT+IF9GDNEuttfYlVQrYI4s7jFX4gNI1ltABl5lKf9BO7IINBP0fJdXEuiOWk54w0rp1fb1PQs/TlZyxESPHS3Pa8=
X-Received: by 2002:a81:920c:0:b0:604:9729:6b49 with SMTP id
 j12-20020a81920c000000b0060497296b49mr2924236ywg.5.1707736660068; Mon, 12 Feb
 2024 03:17:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
 <CAPDyKFpmfgwJ5dJFmORhg1tBewzhB_jrWikpX=b23r-joN91SA@mail.gmail.com> <20240209132837.GJ689448@google.com>
In-Reply-To: <20240209132837.GJ689448@google.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 12 Feb 2024 12:17:03 +0100
Message-ID: <CAPDyKFpho16DU7OorMgXDqiyfFfgM_tWu+DZZOHd0gbjtBw_Cg@mail.gmail.com>
Subject: Re: [PATCH 0/6] mfd: tmio: simplify header and move to platform_data
To: Lee Jones <lee@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 14:28, Lee Jones <lee@kernel.org> wrote:
>
> On Fri, 09 Feb 2024, Ulf Hansson wrote:
>
> > On Fri, 9 Feb 2024 at 02:59, Wolfram Sang
> > <wsa+renesas@sang-engineering.com> wrote:
> > >
> > > The MFD parts of the TMIO have been removed by Arnd, so that only the
> > > SD/MMC related functionality is left. Remove the outdated remains in the
> > > public header file and then move it to platform_data as the data is now
> > > specific for the SD/MMC part.
> > >
> > > Based on 6.8-rc3, build bot is happy. Branch is here:
> > >
> > > git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/tmio-simplification
> > >
> > > I'd suggest this goes via the MFD tree, so the series would need acks
> > > from the MMC and SH maintainers. Is that okay with everyone?
> >
> > Wouldn't it be better to funnel this via the mmc tree? In that way, we
> > can easily avoid conflicts with additional renesas-mmc driver changes
> > that we have in pipe.
>
> You could say the same about changes SH, MFD and Platform Data have in
> the pipe.
>
> > Or perhaps there are other changes that make the mfd tree preferred?
>
> MFD is usually preferred since the parent device usually lives there and
> we are well accustomed to merging multi-subsystem related sets.
>
> It doesn't really matter how this is merged.  The only stipulation is
> that whoever applies the set does so on a succinct, immutable, tagged
> branch and sends out a pull-request for everyone else to pull from.

You are right.

Although, in this particular case I thought it could make better sense
to use the mmc tree, because 1) we are only removing a header file
from mfd and 2) I know we have other renesas-mmc changes in the pipe
for the next release. The point is, I wanted us to avoid the need for
using an immutable branch. But nevermind.

>
> If you want to do that, there are no complains from me.

Well, it sounds like we may need the flexibility with the immutable
branch, so I suggest we do the usual thing with the mfd tree.

Please add my ack for the mmc related changes.

[...]

Kind regards
Uffe

