Return-Path: <linux-kernel+bounces-31314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771B3832C51
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B542866C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A571B54BC7;
	Fri, 19 Jan 2024 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Smz9BHF+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AD654BC1;
	Fri, 19 Jan 2024 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705678012; cv=none; b=QcltcyG5TmtdfozmR6ACeC9ww0JopL0/n26FQVJ1fw5oMM0LKOACmSSTi1NRw8Y0ozwpEPetE+k9sZq05FNApbjnsaM3rUyKtmAygrePSMlk1DUqHPM6FKzw7bgYbN/KBSR+TtGZox2fJyQNMwJXeGxp1b2jW8qNWwbAvqfYZEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705678012; c=relaxed/simple;
	bh=X/xd67Fr3PvF8lGpTMnDOMiobvUDHSVg02IBNzMqNGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJpEtpYTquozelyFTV6KSYvk1YcwQpZ8WAHUHQVXBN1ms4gsqa4TJmLzI2YcsrabdiGfdsNhntN9pjOrbM/2pntq7s7G8dQjaPbTC4oHuH8OGiPT4agIVlzAkDeUIb9A0YuAebvGW8eBdyLia6VVP/ZZ4478XqeMyiBSVvAqdzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Smz9BHF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD31C43394;
	Fri, 19 Jan 2024 15:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705678011;
	bh=X/xd67Fr3PvF8lGpTMnDOMiobvUDHSVg02IBNzMqNGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Smz9BHF+haNafasg95JGgtPJYBBHgYlY+/gV8naiOscTv4jh4wJ879u65MnftYq6a
	 HAUOFwKH1cDjAP5MHxOW36tw5KQInht3bZQ1BFVITR9Yzm9vXVmKVdow6S4SYtSqgK
	 5P9fluDHo1/AH/VYLojyr6pEutOZvF53QmF8Xmc9bryktDxd8fom/RgoGR4lzDD5cG
	 FPvOP3M7jePnZwQt9kQ2nPtv/mNf/zvOtRaTKCxC8PanmTYg2fMFrtE0YKiXhr1Y2l
	 +80VKww/UwvBAfTpHO80c6pItmi8s1lvnZOvi9cprM9bVTGTVr9tUZgiS4FYb1QGtl
	 TxW5g3tXcywrw==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rQqlo-0004QS-00;
	Fri, 19 Jan 2024 16:27:00 +0100
Date: Fri, 19 Jan 2024 16:26:59 +0100
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ASoC: qcom: sc8280xp: limit speaker volumes
Message-ID: <ZaqUw-9XulJGKH7v@hovoldconsulting.com>
References: <20240119112420.7446-1-johan+linaro@kernel.org>
 <20240119112420.7446-3-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119112420.7446-3-johan+linaro@kernel.org>

On Fri, Jan 19, 2024 at 12:24:18PM +0100, Johan Hovold wrote:
> The UCM configuration for the Lenovo ThinkPad X13s has up until now
> been setting the speaker PA volume to the minimum -3 dB when enabling
> the speakers, but this does not prevent the user from increasing the
> volume further.
> 
> Limit the digital gain and PA volumes to a combined -3 dB in the machine
> driver to reduce the risk of speaker damage until we have active speaker
> protection in place (or higher safe levels have been established).
> 
> Note that the PA volume limit cannot be set lower than 0 dB or
> PulseAudio gets confused when the first 16 levels all map to -3 dB.

I tracked the down the root cause for this, which appears to be a bug
(feature) in pulseaudio that causes it to reject the dB range if the
maximum is negative:

	https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/merge_requests/447

This happened to work with v3 which limited the PA volume to the single
lowest setting, but would similarly break if anyone wants to set a -1.5
dB limit.

Johan

