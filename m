Return-Path: <linux-kernel+bounces-50976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B28184848B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 09:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CC828B5CD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 08:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87095C914;
	Sat,  3 Feb 2024 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c57KYkkV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A11018AED;
	Sat,  3 Feb 2024 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706949370; cv=none; b=a8kpuYMipd5m3p3IoZzIVVKF65I/WrZKniKeNMUJM4Ov/2GoMxvis9p6os0E2KWTh8UxWKkgbIgHrjyLWfGvk3bWD74yTyG8T/IB3nt7ypQgDp2LcpfPSKH6rlZv5V1NTv+MQnHOqiGLd60/dHx89rFvGm7eB7qEEgDU0rsnciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706949370; c=relaxed/simple;
	bh=OebqqDe2OlNfuBtKrA2Fp5NrNdfMmgRR0lEDATDNxjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvNOmLeVWVa3I0OTOZw5Wf16V+qKfUomnesjCi5+T0Bhgl7KGQn3p8UCOq42Upm4ICdcMO2oRPc7Gz7PvkbbH/qA/8+vIXpj5O6FEtYp2CBLqZRJqAN8hvjoZnjD9Gz+eMml4zCd2Rb3Fn46HGr3/4HHERmR5OgZnS1gFOiotKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c57KYkkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D83C433F1;
	Sat,  3 Feb 2024 08:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706949369;
	bh=OebqqDe2OlNfuBtKrA2Fp5NrNdfMmgRR0lEDATDNxjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c57KYkkVPqqrokvDQtm1sj0j77mgbmS3lGSlsPbfDVoefIQoMSPzBEjqYlqzRHZZM
	 3NM60BEci5Nn93/V+71Jf5PB8hV4UvKW+fcNAfB4V+ZrE0Fo/yl1jC9bTRrI0dXOLN
	 SlKcx7VEItswRYP6THbLa4zAxTBv9vk5tFlw9wb5OQpWbkPd7LgSAFHJc+d00ddaL1
	 26XLGnfBTdseCexgHfuKhTKvrWRwzeRGHHiKUhyA+P/gS72mXegcXVxXiSnvlsYJMs
	 qc5isvtBauDQTI/9ajrRshRl419Ikh3wYN1e5UCkN9A2upsCqksPhYzX3cU++2j7d2
	 qw7RRTZRHanYQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rWBVW-000000000M0-2H7G;
	Sat, 03 Feb 2024 09:36:14 +0100
Date: Sat, 3 Feb 2024 09:36:14 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Stable backport request (was: [PATCH v5 0/4] ASoC: qcom: volume
 fixes and codec cleanups)
Message-ID: <Zb36_mlapsfSLHEy@hovoldconsulting.com>
References: <20240122181819.4038-1-johan+linaro@kernel.org>
 <170596045583.161959.6600754837297158632.b4-ty@kernel.org>
 <ZbjxUF2IV3A5zNw5@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbjxUF2IV3A5zNw5@hovoldconsulting.com>

Hi Greg and Sasha,

On Tue, Jan 30, 2024 at 01:53:37PM +0100, Johan Hovold wrote:
> On Mon, Jan 22, 2024 at 09:54:15PM +0000, Mark Brown wrote:
> > On Mon, 22 Jan 2024 19:18:15 +0100, Johan Hovold wrote:
> > > To reduce the risk of speaker damage the PA gain needs to be limited on
> > > machines like the Lenovo Thinkpad X13s until we have active speaker
> > > protection in place.
> > > 
> > > Limit the gain to the current default setting provided by the UCM
> > > configuration which most user have so far been using (due to a bug in
> > > the configuration files which prevented hardware volume control [1]).
> > > 
> > > [...]
> > 
> > Applied to
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> alsa-ucm-conf 1.2.11 was released yesterday, which means that it is now
> very urgent to get the speaker volume limitation backported to the
> stable trees.
> 
> Could you please try to make sure that these fixes get to Linus this
> week?

This series (and a related headphone codec fix) were merged into Linus's
tree yesterday.

I saw that the 6.7.4 stable patches were sent out for review over night,
but could it be possible to squeeze in also the following four fixes in
6.7.4 (and 6.6.16)?

	c481016bb4f8 ASoC: qcom: sc8280xp: limit speaker volumes
	4d0e8bdfa4a5 ASoC: codecs: wcd938x: fix headphones volume controls
	46188db080bd ASoC: codecs: lpass-wsa-macro: fix compander volume hack
	b53cc6144a3f ASoC: codecs: wsa883x: fix PA volume control

These are needed for proper volume control and, importantly, to prevent
users of the Lenovo ThinkPad X13s from potentially damaging their
speakers when the distros ship the latest UCM configuration files which
were released on Monday.

Johan

