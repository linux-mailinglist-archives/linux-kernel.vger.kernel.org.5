Return-Path: <linux-kernel+bounces-28445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670F082FE97
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E2D91C2490F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2741FAF;
	Wed, 17 Jan 2024 01:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i2LbIqNG"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A401385;
	Wed, 17 Jan 2024 01:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705456501; cv=none; b=YgnUz6edHGhGAqMXbkVhYxeBlaWrO/oGiCUP/xJk5zVGUzBr+eOV5EUkn2/yBaseTOgGRX+wZ5yX+7zUY2fGdJ0P7pqlXEyy+AfXWfK+ZCBiBAh5Qd9G6OnQJByakqaFuO+0H+qjgQg1XBagmrcM3mPIl4M6jozLZTrziffbPqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705456501; c=relaxed/simple;
	bh=ClQhewjh6YitxqtuZ+PJn8u9gtQ4R5nstBALVRqBAO8=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=qNIMlQRss1uCWOMsM8sTsPS3KOCzsEOTvHo+C3S2zcDNOefUFfGL2gizKtEqt1WO4zTgqd5xY+vGrjbQqSdI49Ho/GJnX2C1922K9B3oE399TFmrhwiqJLfkydTTjwh9Sn27dxn0SaAc+9pA8YTdzFOJdcxga1x36G7Vwgq4Gvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=i2LbIqNG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JW2WdnUR/LjyRgH7ypAslY0/uBukhqoSGdAA5b8yuZg=; b=i2LbIqNGggcW7t1V71pNjrVgkX
	LS+JTQVa/8QXKl2ct+ADiXzrU1Qrnyxln9XIeGkucv1DwBZ73sCH1gXikX3CE8NPOZAxGqtz43C3C
	KUM0SEAkFf4nhdSt7hdtX/cNolWbI7B+b1IjGIyRE6lHXZwMUod6OVXKJgnGKvbNnlvo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rPv8k-005MzP-PH; Wed, 17 Jan 2024 02:54:50 +0100
Date: Wed, 17 Jan 2024 02:54:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Tobias Waldekranz <tobias@waldekranz.com>,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, krzysztof.kozlowski@linaro.org, robh@kernel.org,
	u.kleine-koenig@pengutronix.de, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 043/108] net: mvmdio: Avoid excessive sleeps
 in polled mode
Message-ID: <824aec45-e474-455e-b2c6-00e618445c71@lunn.ch>
References: <20240116194225.250921-1-sashal@kernel.org>
 <20240116194225.250921-43-sashal@kernel.org>
 <20240116174226.52231f8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116174226.52231f8f@kernel.org>

On Tue, Jan 16, 2024 at 05:42:26PM -0800, Jakub Kicinski wrote:
> On Tue, 16 Jan 2024 14:39:09 -0500 Sasha Levin wrote:
> > Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> Andrew and Tobias can override, but vote to drop this.
> Timing changes can backfire easily on flaky HW.

It was not intended for stable. It does not have a fixes tag, it was
not Cc: to stable, etc. Its just an optimisation.  So i agree with
Jakub, this should be dropped.

       Andrew

