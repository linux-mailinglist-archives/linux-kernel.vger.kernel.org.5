Return-Path: <linux-kernel+bounces-16360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B57823D4F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7DB31C20D27
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B8A1EA87;
	Thu,  4 Jan 2024 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W63L+Qw5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C948200C6;
	Thu,  4 Jan 2024 08:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8088FC433C8;
	Thu,  4 Jan 2024 08:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704356486;
	bh=zS2xNl0qvwto+EsZXnidzfKrWR+w3hw0vpx+ygIbVFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W63L+Qw5C8WyRqetzCAJ9q/xzcqkQQglWV6S9e4dan1w8kfgrzm8P541++DLV2fAi
	 CiDg0sxrfr5cdKYOlw6hufTlFewl6rJL8Vf+TElcqJ/M9cfAPdnfv7bWVouPwIwjdL
	 vPjzj194KXg24JaqOg1QAb5iF4uIwuvSq/OE8KEfDSDVFcTDltqBjV2m1K5GE8ArQI
	 BHs3QiA0cC8cdnX7tTumyVvoYyToOi1svB4pk8VIPtnf6Pb850250CVZC5NE32IRBA
	 h/nfxnCL70ukO+TszNYxpfan0NQLaWsbtE4irMz7fodVl2YuEQyjeLfEseDOYlLM7M
	 mYeq/Ap77g5rQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rLIyg-0007SD-2x;
	Thu, 04 Jan 2024 09:21:22 +0100
Date: Thu, 4 Jan 2024 09:21:22 +0100
From: Johan Hovold <johan@kernel.org>
To: Sven Peter <sven@svenpeter.dev>
Cc: Aditya Garg <gargaditya08@live.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Felix Zhang <mrman@mrman314.tech>, linux-bluetooth@vger.kernel.org,
	stable@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Orlando Chamberlain <orlandoch.dev@gmail.com>, kekrby@gmail.com,
	admin@kodeit.net, Janne Grunau <j@jannau.net>,
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel
 MacBooks
Message-ID: <ZZZqgsjeY3R4YlVG@hovoldconsulting.com>
References: <MA0P287MB021769BC136ED0B947683709B867A@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <86B7DC5B-B25A-4D55-BBC7-A1C3EE8AC703@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86B7DC5B-B25A-4D55-BBC7-A1C3EE8AC703@svenpeter.dev>

On Thu, Jan 04, 2024 at 08:50:19AM +0100, Sven Peter wrote:
> > On 4. Jan 2024, at 08:47, Aditya Garg <gargaditya08@live.com> wrote:
> >> On 28-Dec-2023, at 5:41 PM, Johan Hovold <johan@kernel.org> wrote:

> >> Ok, good, then this patch and the one I posted are mostly equivalent
> >> assuming that the BCM4378/4387 return an invalid address during setup.
> >> 
> >> This patch may be preferred as it does not need to rely on such
> >> assumptions, though.

> > So what's the final take on this? Which one is gonna be merged upstream?
> 
> I would’ve preferred this one (possibly with a better commit message)
> since it’s more explicit and doesn’t rely on additional assumptions
> but it looks like Johan’s version was already merged.

Which addresses do BCM4378/4387 return before they are configured?
Should be easy enough to verify that the current check for invalid
addresses catches those or otherwise add them to the list.

Johan

