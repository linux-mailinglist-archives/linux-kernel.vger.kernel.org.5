Return-Path: <linux-kernel+bounces-29183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7821F830A53
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F613287420
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F225C2231B;
	Wed, 17 Jan 2024 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XV0Wzw6S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2200622301;
	Wed, 17 Jan 2024 16:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705507448; cv=none; b=YqjTOlBLqO+mdAuIugKYb54ZaL1qG/peqNDWg+gf/J4hPl2mx1ohe8vWcJklLDkBPu23MwYxxjg9Hx9gPd+ToPifz+JKhHqCTdwTPrlG890XzFT85XatS58mCQj4nLaDk/BKBf1CzBfjMQ5cCxoRRnh2YG4s+iG3hv8s+Sr+y2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705507448; c=relaxed/simple;
	bh=60VU2dcIMdN0LnwmSLQHz70ySOYSNvUalPN6aiFFDwE=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=Y6ZIYbADvF358HJJAZER0wkf/rHGoNiANj+iCstQecEh0HPl75zVrnFOxSLosPAiV6E177Bn/FoP1LbOwlNoGoFCjbG6aQhNj6OBjUtBdMm+1d9xsOmfmh/ql27Wouz0UdRsmySxjXJujFvuNm7k/bKIux5V63qc8jWHZztfpBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XV0Wzw6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E489C433F1;
	Wed, 17 Jan 2024 16:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705507446;
	bh=60VU2dcIMdN0LnwmSLQHz70ySOYSNvUalPN6aiFFDwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XV0Wzw6SbMY8QV/wlCcAIDvzFMs9AQvd2F6I1XoO8oaP0hyCSNeB8UjLxFWYGQ6dE
	 hVN0FqamxWg84g376gpCwTfBEF/cKlihkocEgBX2WRtlV/iJzIwPj+A2bwI3Q6L3+n
	 7VHWbL4f1f9Uj4XmN/O6X26YVT5js3un7OT+TjE8=
Date: Wed, 17 Jan 2024 17:04:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>, hdegoede@redhat.com,
	fabrice.gasnier@foss.st.com, quic_jackp@quicinc.com,
	saranya.gopal@intel.com, quic_linyyuan@quicinc.com,
	andriy.shevchenko@linux.intel.com, minhuadotchen@gmail.com,
	johan+linaro@kernel.org, robh@kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 044/108] usb: typec: ucsi: fix UCSI on buggy
 Qualcomm devices
Message-ID: <2024011719-riverside-flashcard-0524@gregkh>
References: <20240116194225.250921-1-sashal@kernel.org>
 <20240116194225.250921-44-sashal@kernel.org>
 <ZaeJ8Sh4JLo5GAQw@hovoldconsulting.com>
 <CAA8EJpoQZc0f2HusJOMa_45bh8Eh=sVg-aOUbNR3S0+oQQQ+MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpoQZc0f2HusJOMa_45bh8Eh=sVg-aOUbNR3S0+oQQQ+MQ@mail.gmail.com>

On Wed, Jan 17, 2024 at 02:17:40PM +0200, Dmitry Baryshkov wrote:
> On Wed, 17 Jan 2024 at 10:03, Johan Hovold <johan@kernel.org> wrote:
> >
> > On Tue, Jan 16, 2024 at 02:39:10PM -0500, Sasha Levin wrote:
> > > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > >
> > > [ Upstream commit 1d103d6af241dbfc7e11eb9a46dff65db257a37f ]
> > >
> > > On sevral Qualcomm platforms (SC8180X, SM8350, SC8280XP) a call to
> > > UCSI_GET_PDOS for non-PD partners will cause a firmware crash with no
> > > easy way to recover from it. Since we have no easy way to determine
> > > whether the partner really has PD support, shortcut UCSI_GET_PDOS on
> > > such platforms. This allows us to enable UCSI support on such devices.
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > Link: https://lore.kernel.org/r/20231025115620.905538-2-dmitry.baryshkov@linaro.org
> > > Signed-off-by: Bjorn Andersson <andersson@kernel.org>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> > Correct me if I'm wrong Dmitry, but while the commit message makes this
> > sound like a fix, it is not needed unless you backport follow-on patches
> > that enable UCSI on these platforms.
> >
> > So this one can be dropped from all stable queues (unless you're
> > backporting patches that enable new features and that depend on this
> > one).
> 
> Exactly. It didn't have the Fixes: tag. So I'm completely unsure why
> it ended up in the autosel queue at all.

Based on the text in the subject and in the changelog, it sure looks
like a bugfix to me!  Perhaps don't write changelogs that say "fix
SOMETHING on SOMETHING" next time if they really are not a fix :)

thanks,

greg k-h

