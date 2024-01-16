Return-Path: <linux-kernel+bounces-27406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B6D82EF81
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B10B21F31
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E601BC4E;
	Tue, 16 Jan 2024 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDhj0ufm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7D66FBF;
	Tue, 16 Jan 2024 13:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C9BC433C7;
	Tue, 16 Jan 2024 13:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705410616;
	bh=i4dry6M6WDVUsf16531MxNHkF/ieE3KAF4x/oxtezNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDhj0ufmBZ5rhO3OPZzmZDuzn9J90cGHPEF3adOa7IMzTRLXaZV8Khdd0rmAMF7uV
	 xHL3+MkX22jLdE1SRP3SEZdWUmdK/vaubuGSljwLzIZwx851xPFEnxuYQxDMZHmeN4
	 xQFtajGQnZNKQJ0qHzO1I+PRphGmAcAkMhVha4UnfFp2w9QL9TuWOJGylInnhAnxmH
	 RTiGLN1xKE/9HhRETXXIV7h8u0Rw3e3e7IdFE6Aex92sBHh1GepwBotSwxhVGrNvCh
	 Um+7ZN8Ltee3ql6l11b3vrvEY8inpgpGSS/NksYL6I5isd9hQ+MqSqW0149552QpOP
	 djgnIp4WMSTJA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rPjCt-00065Y-1B;
	Tue, 16 Jan 2024 14:10:20 +0100
Date: Tue, 16 Jan 2024 14:10:19 +0100
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
Message-ID: <ZaaAO8SMczq7YUAE@hovoldconsulting.com>
References: <20240116093903.19403-1-johan+linaro@kernel.org>
 <20240116093903.19403-3-johan+linaro@kernel.org>
 <8bb1cad6-6a85-444a-b881-c03ab0051009@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bb1cad6-6a85-444a-b881-c03ab0051009@linaro.org>

On Tue, Jan 16, 2024 at 11:10:21AM +0000, Srinivas Kandagatla wrote:
> Thanks Johan for this patch,
> 
> On 16/01/2024 09:38, Johan Hovold wrote:
> > The LPASS WSA macro codec driver is updating the digital gain settings
> > behind the back of user space on DAPM events if companding has been
> > enabled.
> > 
> > As compander control is exported to user space, this can result in the
> > digital gain setting being incremented (or decremented) every time the
> > sound server is started and the codec suspended depending on what the
> > UCM configuration looks like.
> > 
> > Soon enough playback will become distorted (or too quiet).
> > 
> > This is specifically a problem on the Lenovo ThinkPad X13s as this
> > bypasses the limit for the digital gain setting that has been set by the
> > machine driver.
> > 
> > Fix this by simply dropping the compander gain hack. If someone cares
> > about modelling the impact of the compander setting this can possibly be
> > done by exporting it as a volume control later.
> > 
> This is not a hack, wsa codec requires gain to be programmed after the 
> clk is enabled for that particular interpolator.

Ok, but then it's also broken as, as I mentioned off-list, these
registers are cached so unless companding is enabled, the write on
enable will have no effect.

> However I agree with you on programming the gain that is different to 
> what user set it.
> 
> This is because of unimplemented or half baked implementation of half-db 
> feature of gain control in this codec.
> 
> We can clean that half baked implementation for now and still continue 
> to program the gain values after the clks are enabled.
> 
> lets remove spkr_gain_offset and associated code paths in this codec, 
> which should fix the issue that you have reported and still do the right 
> thing of programming gain after clks are enabled.

Removing the offset which can alter the gain, will cause both of these
writes to become no-ops as the registers are cached (e.g. just as for
the follow-on codec cleanups). So then we might as well just remove
this too.

How is the half-dB feature supposed to work?

And are you sure that you need to reprogram the gain value after
enabling the clock? Everything seems to work without doing so.

Johan

