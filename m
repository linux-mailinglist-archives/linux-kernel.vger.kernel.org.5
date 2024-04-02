Return-Path: <linux-kernel+bounces-128438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD1B895AD1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1650028205E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD8215AAA3;
	Tue,  2 Apr 2024 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cwYm0/+M"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B842115A4A4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079523; cv=none; b=m+yX6e0kbWFOAnv4tLjVDQXeJBIUHA87F0l7r631OU84mjqSvPxo910mSyQKfB6AWrIhi+4I1/co/fBI+ZgFwOw5GlmStnL2q9thYSGwtV6aNr5dMyLfFkKMpXbWql6/CWnCjd7/tjVlYaa2Ddl/7Tf8mc9YDfPvAhy+UAeSyO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079523; c=relaxed/simple;
	bh=mjehrL1CeGLW4kKW6mfOdXsxoEA+KJygo9ZmNvXCcmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuiCmBpzwd+WAkr7Qjsi4fSoftvGM6lkB06n127eUegRxVvnEeJ2lcRA0Yg5PW2glSCJ+NwqQgRW+GCtoCJcDD7B0aCEGKnPD/9W48nyxKGBYKhgPhYcdFqhi/1eSyu71HPlfYhAIzQpJgBk+l3gmPE6KDlfbgzpJhCSbbtIuTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cwYm0/+M; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6afb754fcso5180076b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 10:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712079521; x=1712684321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HtrkSh59QkjttbNzKcHQJ3LYMjwTS4ircoPC1SuYzsc=;
        b=cwYm0/+MP90FD7gcZnZWzAQ1lF6KtZlZ8o0M7ZMvq/P/0O8M1el4K2bZUHzle+WU8w
         gF1IAfpS3MVTt2+Kkocb2BodYAiDwsGxNSbW7nciozRHzLZ1YhyBZlRsbxvekcqoo6pE
         qIVFfAk71n4D1B5yQSYnhiH0oBFXgHd25BAxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712079521; x=1712684321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtrkSh59QkjttbNzKcHQJ3LYMjwTS4ircoPC1SuYzsc=;
        b=s+iJvXnSVY3hlYD/VMsDR7ZyV8aVrXVx/qOIe8VEvNHSqNjHGF9wNZJ8xP9xqbwe7X
         lvsjrLIKhqETHLtfnmd3y5gu1WGfODC1GqI39hb+w9Gbe2EShizBgdLnlXUueopnTfXh
         vwJLLrSw3l6km8Y/JmRdoH/Il7RCPkDBeRBcHDU/+UlJvEXViuuXAL6tSgcCBKqDJjSu
         NZBRzr8hy58aB1xQaDt1VNslo7xtCm59u1zawNHQyMx3ubboLk1pGw+HbkdXzy70U9hu
         tOMrYbSJoqYuPxYs8Cn2ABVfE+LkmAap/QlMkKralGMdOiZg/aDDaQPp+oepEx2zOH5C
         dF4g==
X-Forwarded-Encrypted: i=1; AJvYcCVr3hcxwofYWbO9F5nu6Aw8SO46FRo5iYCKH7EaOs0XsYjV0sYCaonINExIssqATlNoLbydM05TiYqj6z04guNjKfp5Bp8EdDt0lY2o
X-Gm-Message-State: AOJu0YzxKAboSRgJcV6LxnbbEFbtCLyonP7gY4IOXhl6mCFYhHt/lVgW
	waj1Ap75W+4D6Ew8V9rnLdFJpFUIwjQjyaWOy5ipCLEVTrCKtF5knUynZnzfVA==
X-Google-Smtp-Source: AGHT+IHTJsSiXsH6JTcmk3cWEEqNnvSwl5ZRIjvO/yZBSMNZyrIBM9Ot3MLRUkrax586uwZ+CcwyQw==
X-Received: by 2002:a05:6a20:7354:b0:1a7:23ae:92c3 with SMTP id v20-20020a056a20735400b001a723ae92c3mr2197471pzc.12.1712079520977;
        Tue, 02 Apr 2024 10:38:40 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:73c6:f4e5:23b5:e248])
        by smtp.gmail.com with UTF8SMTPSA id n4-20020a170903110400b001dcc7795524sm11363589plh.24.2024.04.02.10.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 10:38:40 -0700 (PDT)
Date: Tue, 2 Apr 2024 10:38:38 -0700
From: Brian Norris <briannorris@chromium.org>
To: David Lin <yu-hao.lin@nxp.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Francesco Dolcini <francesco@dolcini.it>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	"rafael.beims" <rafael.beims@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Message-ID: <ZgxCngq_Rguc4qs8@google.com>
References: <ZfTspRKFgrO9xCTH@google.com>
 <969e95ccc4a1d35b45212b7fcb536ee90995e3b5.camel@sipsolutions.net>
 <PA4PR04MB9638D253189D6DD330B198B2D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB9638BE73DDBCE1CE8AA32BA8D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <b2d9a7ef53c5ab4212617e8edf202bbafe52e2f8.camel@sipsolutions.net>
 <ZftaJEIeNfV7YrVo@google.com>
 <PA4PR04MB9638F5037D1AB9BCF51CC9D9D1322@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <Zf4rDifM6bLuqpX2@google.com>
 <4e5f3741819e457c5c79d825c6520cb9ee531b95.camel@sipsolutions.net>
 <PA4PR04MB96386917877832602F221282D13A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB96386917877832602F221282D13A2@PA4PR04MB9638.eurprd04.prod.outlook.com>

Hi Johannes and David,

On Fri, Mar 29, 2024 at 10:06:19AM +0000, David Lin wrote:
> > From: Johannes Berg <johannes@sipsolutions.net>
> > 
> > The way I see it, the issue here isn't necessarily the fact that this uses the
> > auth command (and then requires assoc, of course), but that we see here
> > this is "growing" towards a more mac80211-like model, with the code
> > duplication (albeit little that it is today) implied by that. To me, it seems like
> > the firmware is moving into the "oh we can't do all _that_ in firmware"
> > territory, and that brings it closer to mac80211.
> > 
> > At the same time, as you say, mac80211 is doing more and more offload
> > capability, so it seems like apart from "today the firmware requires an assoc
> > command rather than assoc frame processing in the host", it's actually not
> > _that_ far apart any more!
> > 
> > Now that may be an issue in the short term, but I wouldn't be surprised at
> > all if desiring to implement FILS and other new features in this space would
> > make the driver move to assoc frame processing in the host as well, because
> > it's getting more and more complex, just like auth.
> > 
> > At which point - yeah the APIs are still significantly different, but again we'd
> > end up implementing something that exists in mac80211 today and taking it
> > into mwifiex?

So it seems there's 2 possible sticking points: code duplication, and
overall trend in the specs and implementation that might increase
duplication?

To me, it seems like the duplication is minimal today, or at least, not
much as a result of anything in this patch proposal. There's some
repetition of 802.11 definitions already, but that's probably
orthogonal.

I have less understanding and foresight on the "trend" questions,
although David seems to somewhat agree in his response below -- that NXP
intends to handle modern security features in the host more and more,
which could indeed mean a bit more framing-related duplication.

> Mwifiex is designed based on a "Thick FW" architecture. 
> As security features become more complicated, this patch adds WPA3 support by offloading to wpa_supplicant/hostapd
> With this patch, auth, assoc and key handshakes are handled in wpa_supplicant/hostapd. 
> Wpa_supplicant communicates peer capability and derived keys to driver/FW via cfg80211 assoc and add_key commands.   
> The cfg80211 commands are standard. Implementation between driver and firmware is vendor specific. It shall not break any existing architecture.
> 
> > > It may be harder to add
> > > future additions to the mac80211 stack [*], if we have to add new
> > > concerns of a non-mac80211 implementation in the mix.
> > 
> > Not sure that makes a difference for mac80211 in itself, obviously changes in
> > this space would then affect mwifiex, but that shouldn't be much of an
> > issue.
> > 
> 
> With this patch Mwifiex still a non-mac80211 implementation. 
> Driver communicates with wpa_supplicant/hostapd via cfg80211 
> I think how driver/FW communicate each other is proprietary, I don't see a dependency with mac80211 here

David, I may have pointed in the wrong direction by claiming "conflict"
with mac80211. I believe Johannes's concerns are in code duplication.
Pretty much all other actively-maintained Linux WiFi drivers are based
on mac80211, so that we don't all have to implement the same frame
construction and parsing code. mwifiex is somewhat of an outlier in
actively adding new features while remaining a cfg80211-only driver.

But for myself, I'm not even fully convinced mac80211-style stuff makes
sense here. Even just looking at the auth() stuff in patch 1, this
driver is far from a thin layer that allows mac80211 to handle the
802.11 details. Just look at the 'priv->host_mlme_reg' and
HostCmd_CMD_MGMT_FRAME_REG stuff -- it seems that the simple act of
sending a single 802.11 frame requires opting into some FW-specific
command mask. This feels "thick", like David mentioned above.

> > I'm less worried about this individual patch than what it says about the
> > direction this driver and firmware are taking, and I fear we'll end up in a
> > situation where over time this driver actually gets to a point where it should
> > be using mac80211, but because it's such a piece-meal affair (auth frames
> > now, etc.) and large architectural change, they'd never actually do that.
> > 
> > To be fair, that might also require firmware API changes in some way. I used
> > to think that was something we should never require, but I'm not so sure
> > now any more - certainly we've changed our (Intel) FW API in support of
> > Linux architecture many times, and overall that's for a better product (on
> > Linux at least.)

Yeah, I feel like I see hints of stuff (in public driver code, and in
internal discussions with vendors) where things really work best in
mac80211 land if firmware is developed with *some* consideration for the
mac80211 Linux architecture (or else already is a very thin firmware
from the start). I don't feel like Marvell/NXP has that consideration at
all, and so trying to drag its firmware into mac80211 regardless would
bring its own unique pain. But that's just a lightly-educated feeling.

> > Also: David, I'd appreciate if you actually took this discussion seriously; so
> > far you've not really contributed any technical arguments.
> 
> I think we are using standard cfg80211 commands. How it's handled
> between driver/FW is proprietary, it's carefully verified and shall
> not impact other features or break any architecture. 

David, repeating the "carefully verified" stuff doesn't really help the
subject at hand, and it's not really a technical argument either, when
it's not accompanied by any proofs. Being careful and running a good QA
cycle are excellent and appreciated, but that's not what we're talking
about any more. We're trying to understand what the firmware
architecture is like, and what driver architecture matches your future
development best, with the needs of the Linux community in mind.

(Now, as an example useful argument: if you claimed that implementing a
mac80211 driver with a generalized ieee80211_ops::tx() function would
introduce unvetted combinations of control logic that cannot be
reconciled with your HostCmd protocols, or that QA can't properly vet
that ... well, that would be a start of a technical argument. But it
would require more than a sentence or two to describe why that's
impossible or difficult.)

> We do not see a need why driver has to be redesigned based on
> mac80211. We can keep adding new features using cfg80211.

All in all, other than being a little grumpy about reviewing new
features here, I'm still leaning toward David's statement here -- that I
don't see why it *must* be rewritten toward mac80211. But I still defer
to Johannes, and I'm just trying to be a bit of a referee, or the
proverbial "devil's advocate".

Brian

