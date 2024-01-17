Return-Path: <linux-kernel+bounces-28985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB97830600
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5CC28B22A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14181EA80;
	Wed, 17 Jan 2024 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzEOWWnX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1B21EA66;
	Wed, 17 Jan 2024 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495876; cv=none; b=nxjfwNEKenx4X68FVtOVl5EEX3gV9qXL/U5RGLZKXXr8eVtCBfsj6/zJ0xEBURVr+WadDUZBApWZK7zirD9ChzG20nMNOI6fRWEGgiCOr/0uQmCqqwsY89ZqKIAFqOHLQ9Mb8U1X0LtzHvF1qHr2yoO/lQ/iK5eqLnPlK48qH8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495876; c=relaxed/simple;
	bh=WmJLRAU5oXetMyOkN2h2YdwPSM5CqSZifVrpaIDjSDM=;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=svlgLFK8AZtA2VR4koyAfkuIq/I3jV/1/8fPtWlrj0gSMLv6PzGG47nsEaTu/YTHJwrH+/JEH+EmWgiTgfYlGdkO+tt524Ia8sSNKEq1ZjUiB85cwt/6hILcasnQYnF47oH1qiFM903w8FahjnhkcbnBSYdhYe5udOwywme3cdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzEOWWnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFEFC433C7;
	Wed, 17 Jan 2024 12:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705495875;
	bh=WmJLRAU5oXetMyOkN2h2YdwPSM5CqSZifVrpaIDjSDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LzEOWWnXRo3Q4Hpy2+ku7iBz9Gd1twyi/lmwKnWM+7/jjSrvyp4NErfaE01ZliRgz
	 j70/pMh+66EmeSQnG9us0BKF/7OsaqyCOBf0XzQ9Rqb0TecevhcKIetAqvixhEtvow
	 XPAEaXeZ/HbM3+C9xqEAKm8nbxxb4Zjtg9mTbr0jrS82n71pyxChVuth3lKxrWx2Ol
	 8x1u+CFUopgwp1aAUXPpfvcl5UcZNFmN6qkXrUy6kKS78GTMa+6ldfggRoeYZORQ7d
	 /ukgsCODd304EyWHfVS/vcKL1wCXXC3pneNFpGSoLCdyB356eOai2c+GeQbphUuI2k
	 dyjeTJvyVg0wA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rQ5O4-0005Vv-0V;
	Wed, 17 Jan 2024 13:51:20 +0100
Date: Wed, 17 Jan 2024 13:51:20 +0100
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>, gregkh@linuxfoundation.org,
	hdegoede@redhat.com, fabrice.gasnier@foss.st.com,
	quic_jackp@quicinc.com, saranya.gopal@intel.com,
	quic_linyyuan@quicinc.com, andriy.shevchenko@linux.intel.com,
	minhuadotchen@gmail.com, johan+linaro@kernel.org, robh@kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 044/108] usb: typec: ucsi: fix UCSI on buggy
 Qualcomm devices
Message-ID: <ZafNSGNaw310xgTm@hovoldconsulting.com>
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

AUTOSEL is Sasha's machine-learning based tool for picking potential
fixes also among commits that lack a Fixes tag.

Johan

