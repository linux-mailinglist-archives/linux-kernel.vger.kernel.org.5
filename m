Return-Path: <linux-kernel+bounces-28692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D95D8301E5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A891C24889
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835A3134C8;
	Wed, 17 Jan 2024 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwfFyoFP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ED67499;
	Wed, 17 Jan 2024 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705482498; cv=none; b=BcIT+z3nPaZZBnG86wOrsJS7RRIFeOGhMbkuqccufMun/G61XfaaKaFpKDqZ+AU70nSFlx+OM4cOVqVlfzW2Bpoysm+ZXtjLZlfXLPXEbOPzW8C1Si10W6yp8pTEDPik/KEEeDsuCeLz/JnpvaF6vCc5ys61IE9H0ZehjnJExKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705482498; c=relaxed/simple;
	bh=/dPCBxX9NtYra0koFE41eeYgs1qT5c5J5e0WBloEftE=;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rwXcoegeUIx/IVJqYsyx/Ta29DMbASz4OdXnPsDwyXoQog7bKOyglSt/MiYCqwRhmW8xImscKQga1C3Kewwv73mbw/inlqGCuZE+qh4qfw1YpzYq/HgvisizGkW5WVqOchPJbDwFQ1Ct2fQkG9k7sONJ1VsR5pYOkD8wcf6tiYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwfFyoFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E08C433F1;
	Wed, 17 Jan 2024 09:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705482498;
	bh=/dPCBxX9NtYra0koFE41eeYgs1qT5c5J5e0WBloEftE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EwfFyoFPPJKIQlb/mKFQXjLoA42JHsJe7581uZAyH5PiUdNVZg9NuN7VRq6I/2yja
	 +cgOn8V40goecsaz8cSraOaKDWK5tRQO9FU1Drtxhnar24j84hA1xrNhk3OiXwN2iN
	 /a3hbEXzo8FB631BxwHPNohViqSGmghGJGieF8HIsqLl5UYEecSN2SVXvuVqvG3hW+
	 0krW5ShJR2yPOVZBoJRHKK9A/Tn2mrwrUYfoe9H+L1dRxH36ci2FyUdOOrQsBNdjkx
	 dyRAq3gbqN9DFYHH3kUBqSimdqTiV+8eAhxTsWhBN4KxnxqUQ5RM28S2Hs6mpTIgV7
	 ix+zZs5w4rX/A==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rQ1uI-0008AG-3C;
	Wed, 17 Jan 2024 10:08:23 +0100
Date: Wed, 17 Jan 2024 10:08:22 +0100
From: Johan Hovold <johan@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Mark Brown <broonie@kernel.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/7] ASoC: codecs: lpass-wsa-macro: fix compander volume
 hack
Message-ID: <ZaeZBjKezfdslS2L@hovoldconsulting.com>
References: <20240116093903.19403-1-johan+linaro@kernel.org>
 <20240116093903.19403-3-johan+linaro@kernel.org>
 <8bb1cad6-6a85-444a-b881-c03ab0051009@linaro.org>
 <ZaaAO8SMczq7YUAE@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaaAO8SMczq7YUAE@hovoldconsulting.com>

On Tue, Jan 16, 2024 at 02:10:19PM +0100, Johan Hovold wrote:
> On Tue, Jan 16, 2024 at 11:10:21AM +0000, Srinivas Kandagatla wrote:

> > This is not a hack, wsa codec requires gain to be programmed after the 
> > clk is enabled for that particular interpolator.
> 
> Ok, but then it's also broken as, as I mentioned off-list, these
> registers are cached so unless companding is enabled, the write on
> enable will have no effect.

I was obviously confused here, and indeed tests reveal that those writes
are needed for any prior updates to take effect (e.g. volume changes
while the codec is runtime suspended).

I've just sent a v2 here:

	https://lore.kernel.org/lkml/20240117090331.31111-1-johan+linaro@kernel.org/

Johan

