Return-Path: <linux-kernel+bounces-109445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B29C881946
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2110B283162
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BB285C46;
	Wed, 20 Mar 2024 21:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NVYwzLlt"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11902CA6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 21:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710971432; cv=none; b=Pb7D7bUNTtn2Rc0ORVX6N7yK/8Ea5lnMaSUslGx5etmWlNCMx61kXgWu3sUe9e7Ek1PCShRxd+QZRuFzK//kWtF5OjGs4y2diDaZq40kqsTSrloro8Qba2S28hyYMkwWUvLY2FGZ62viNQG9M8F/ctWrSQP4uFyKzqPHq/cI3Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710971432; c=relaxed/simple;
	bh=GIQekNhKN6ZhVqvNkVI/XRisn39GJLGs4aMBSBeIl80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOaRHeLB4/KID/ymN4x9pUOiImq582qJbq4ZuylTpURjExsKpFW1eyO2/fxYjYacPN8A7l5Wl8Q0ayu3mGF+B0CzDYggMdvdaZXkqEzVBH8lhPqCLzvTehIBtSFKQKSJ1FsUTarm8XO9bxIQg9FqvnIe276nM8fCOl68AQbrKno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NVYwzLlt; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e6ae6b56ecso142762a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710971429; x=1711576229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7e5DS/yA7HbHfT6B5LGwx48ERu4SeNkBqpRXvy8fkH4=;
        b=NVYwzLlt+EZUjEHnZLPfCjl3Ly/CoWKyg8hQKVjMoUEGHZ1Lfl43lM+eOG2MVzfSjO
         VhvNzBfsJCSXBaIUEf8fA8Rkv9E7HzMFm3kWLfB6NtpboBkWKNmRoaY5SXgpQXSZcuHQ
         YyT+6XS7OMORMaq5fW025gX6PTMA+mdTbeEQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710971429; x=1711576229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7e5DS/yA7HbHfT6B5LGwx48ERu4SeNkBqpRXvy8fkH4=;
        b=iD6E+cWcHUNIf10gBmtcXUVE8bebT4rPUOLHp+Gi44TIXVMt9W7pYinS+PVy1ewYid
         seX7zxrqmsGkpBAYaYvD4ySXAlj3WgNqV4cA1JiyqEluZ6YmGeB/iV4FvtdFkjEfT3H8
         9NZ2fclQ4sgWmb7lpYFa8tzoJkW0dDSeiU2vY0LFlPiWiI+ydJnTooLsbY0pnL6zSicO
         sussEkIWmopZYIgbSuNM+xSEHOfe1sCbKbmp73iYJ/hvmZljzeAhjg59Gu2yTzUGmBZd
         kH92IPFky2Li1BDW5y2qEPsOBr54PdJ7dEQ1S4CSVmrIJ4AwEiuATk89S1W43o0hC/S0
         e4fg==
X-Forwarded-Encrypted: i=1; AJvYcCVa9FOuQKyBT3YrUW4rMXqVnMgzFPoNKetv8CPCl3wycBT43LtYqakMK8sujmMd58qQiPkLqSM7KjvqZpSe4yqoF5t/M3BEiAgR9t+O
X-Gm-Message-State: AOJu0YzD2/egLNQbZmkL2NeVhadztKjaLYH93hNMps9oe9LD3BUbvz7x
	c5X3El+TZfg2dbxpjnKgVeC4sry2UMSrsDLgy6lumHZ2RJHJpdjAVwMbj5IjLg==
X-Google-Smtp-Source: AGHT+IH9O5DCRQxgg/juNeTEEUiRb3od5GqM5/PbooTEf3XOb1UYlPpyE3wXSOeN2DuMZCfRVAQBUw==
X-Received: by 2002:a05:6870:527:b0:221:cb66:c36b with SMTP id j39-20020a056870052700b00221cb66c36bmr3566275oao.4.1710971429612;
        Wed, 20 Mar 2024 14:50:29 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:8598:2b3d:6e11:4163])
        by smtp.gmail.com with UTF8SMTPSA id k21-20020a628415000000b006e6bf165a3asm13056754pfd.91.2024.03.20.14.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 14:50:29 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:50:28 -0700
From: Brian Norris <briannorris@chromium.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: David Lin <yu-hao.lin@nxp.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	"rafael.beims" <rafael.beims@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Message-ID: <ZftaJEIeNfV7YrVo@google.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <20240315094927.GA6624@francesco-nb>
 <ZfTspRKFgrO9xCTH@google.com>
 <969e95ccc4a1d35b45212b7fcb536ee90995e3b5.camel@sipsolutions.net>
 <PA4PR04MB9638D253189D6DD330B198B2D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB9638BE73DDBCE1CE8AA32BA8D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <b2d9a7ef53c5ab4212617e8edf202bbafe52e2f8.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2d9a7ef53c5ab4212617e8edf202bbafe52e2f8.camel@sipsolutions.net>

On Wed, Mar 20, 2024 at 10:12:45AM +0100, Johannes Berg wrote:
> On Wed, 2024-03-20 at 01:10 +0000, David Lin wrote:
> > > > 
> > > > Also decl.h should probably _shrink_ rather than grow, a number of
> > > > things just replicate ieee80211.h (such as MWIFIEX_MGMT_HEADER_LEN
> > > > really is just
> > > > sizeof(ieee80211_mgmt) or so? Not quite correctly.)
> > > > 
> > > 
> > > This can be done for feature patches.
> 
> But this is a feature patch :-)

I'm going to hazard a guess David may have meant "future"?

But yeah, I get overwhelemed at how similar-but-not-quite-the-same
definitions in this driver sometimes. It definitely could use some
spring cleaning.

> > > > So yeah, agree with Brian, not only would this be the first, but it's
> > > > also something we don't really _want_. All other drivers that want
> > > > stuff like this are stuck in staging ...
> > > > 
> > > > So why is this needed for a supposedly "firmware does it all" driver,
> > > > and why can it not be integrated with mac80211 if it's no longer "firmware
> > > does it all"?
> > > > 
> > > > Johannes
> > > 
> > > Our proprietary driver is cfg80211 driver, it is very hard to create a brand new
> > > mac80211 driver and still can port all tested stuffs from our proprietary driver.
> 
> That basically doesn't matter for upstream at all.

+1

> > BTW, vendor should have the choice to use cfg80211 or mac80211 for their chips, right?
> 
> No, that's not how it works. The choice should be what makes sense
> architecturally.

And to put some specifics on it, that's what's described here:

https://wireless.wiki.kernel.org/en/developers/documentation/mac80211
https://wireless.wiki.kernel.org/en/developers/documentation/cfg80211

(I don't consider myself an authority on this stuff, for the record.
But:)

I've often felt like the SoftMAC designation has a very fuzzy
definition. Or, that definition is very much subject to the whims of the
hardware/firmware vendor, and can change from day to day. For instance,
it feels like there are plenty of "fat firmware" features in mac80211
drivers today, where pretty much anything and everything *might* be
handled in some kind of firmware-offload feature, in addition or instead
of on the host CPU.

But a key point that *is* a pretty hard designation, from the mac80211
page:

"SoftMAC devices allow for a finer control of the hardware, allowing for
802.11 frame management to be done in software for them, for both
parsing and generation of 802.11 wireless frames"

AFAICT, mwifiex firmware still isn't allowing "parsing and generation of
802.11 wireless frames" in any general form -- everything I see is still
wrapped in custom firmware command protocols. I do see that the AUTH
frame looks like it's essentially duplicating the standard mgmt format,
and uses the driver's TX path for it, but there isn't a corresponding
ASSOC management frame that I can see...
..so I really can't tell how much control this firmware *does* give the
host regarding arbitrary 802.11 frame management.

But that's pretty much business as usual for anybody but the vendor in
priorietary firmware land; I can't answer pretty much any question,
other than what I can glean from a driver.

Brian

