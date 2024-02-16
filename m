Return-Path: <linux-kernel+bounces-68629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C30857D7F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13158B221BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8008129A77;
	Fri, 16 Feb 2024 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDm3bOiY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3C1E4A0;
	Fri, 16 Feb 2024 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089454; cv=none; b=VteWeCr2We/p1uzRMl7rZK4yS2ptb2YwDCwUgDlzxp6V+9BKmhi0s99oR5DcYdFAWilXNQFYodj++dZZPQlZ3LnhRsjHHzEMAasmxrqpOiJ4MEhVx1fQPJMaWcdcJt6e+bcW+dpCVbxy4nHJhTBWjAN/Fb1FfqymxeS0Wn+bGsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089454; c=relaxed/simple;
	bh=AVfeqQmabhCsEwDXgdtcghK9DNj+wvmCdcJSg6+5wys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmGfnCGTYibZfMXzBoy6sjOrh98lyxX6wwvvIHL4A/m/hTRirjd8N13YhoTjU/mRuLhT/ifN7C82OsM/30Y7qML6bn914N08gIdlWhbeEAknhb8LCc8x4QJOOl/1gan5WLdJcwKGY23+FBG3LUxFGv8doVgSssIsaUe6Tp1vGq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDm3bOiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A48BC433C7;
	Fri, 16 Feb 2024 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708089453;
	bh=AVfeqQmabhCsEwDXgdtcghK9DNj+wvmCdcJSg6+5wys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UDm3bOiYZsFxCXXc+P0xuyh3cp5zEz0unbQ6MzRKkTJvMXLOnamzjt3RoMs2N+ToJ
	 Nw3ac4JqW7sF63R1HcPZWnALdh/wkZndr5iRaddG0tmBotF5GHdI9sGMFQhss4Alfy
	 iMh1y4aGB3gzljMPGVdAnKOdt237oZYGEJRYt9Msf/PCXFXQs1CJN0v9mu9BgIXApn
	 nfmYLlxndNek6efeIaaukFgOGIinmuplZgNM45GSPEYyhFPdmvrXiBXyeIaDIvRBX+
	 vL89hxVAnVS2CU5Cfrwk1xTsHM7FeY4LxjQtXxu5TzSqSdIEGrOAUKpBZjigtu8U7g
	 3xdRUUVJkDoug==
Date: Fri, 16 Feb 2024 13:17:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Li peiyu <579lpy@gmail.com>, Nuno
 Sa <nuno.sa@analog.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] iio: humidity: hdc3020: add threshold events
 support
Message-ID: <20240216131721.745f039e@jic23-huawei>
In-Reply-To: <20240214085350.19382-1-dima.fedrau@gmail.com>
References: <20240214085350.19382-1-dima.fedrau@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 09:53:42 +0100
Dimitri Fedrau <dima.fedrau@gmail.com> wrote:

> Based on Fix:
> a69eeaad093d "iio: humidity: hdc3020: fix temperature offset" in branch
> fixes-togreg

This applies fine independent of that (they will meet each other upstream!)
so I'll take this via my tree now rather than waiting to get that dependency
after a pull request  / rebase.  It will also actually get built in next
where the missing Kconfig / Makefile fix is in place.

Applied to the togreg branch of iio.git. Normally I'd push it out as testing but
given I haven't yet queued anything up today and this won't get built
until it hits next I've pushed it out as togreg directly after a quick local
build test.

Thanks,

Jonathan

> 
> Changes in V2:
>   - Fix alphabetical order of includes(Christophe)
>   - Fix typo: change varibale name "HDC3020_R_R_RH_THRESH_LOW_CLR" to
>     HDC3020_R_T_RH_THRESH_LOW_CLR to match variable name pattern(Christophe)
>   - Add constants HDC3020_MIN_TEMP and HDC3020_MAX_TEMP for min/max threshold
>     inputs (Christophe)
>   - Change HDC3020_MIN_TEMP to -40, as stated in the datasheet(Javier)
> 
> Changes in V3:
>   - drop u8 register pairs and switch to 16bit defines(Jonathan)
>   - create helper functions to avoid code duplication(Jonathan)
>   - Add interrupt bindings in example
>   - use the decimal part for setting thresholds(Javier)
>   - use return in switch cases hdc3020_read_thresh(Jonathan)
>   - fix interrupt handler:(Jonathan)
>     - return IRQ_HANDLED when we get a read back failure
>     - take the timestamp into a local variable
>   - fix multiline comments(Jonathan)
>   - use fixed value "hdc3020" instead of dev_id in probe
>   - clear interrupt after registering the interrupt handler
>   - remove interrupt polarity
> 
> Changes in V4:
>   - fix commit message of patch "iio: humidity: hdc3020: switch to 16bit
>     register defines". (Jonathan)
>   - add missing include in bindings example. (Javier, Rob)
>   - added copyright information
> 
> Dimitri Fedrau (3):
>   iio: humidity: hdc3020: switch to 16bit register defines
>   dt-bindings: iio: humidity: hdc3020: add interrupt bindings in example
>   iio: humidity: hdc3020: add threshold events support
> 
>  .../bindings/iio/humidity/ti,hdc3020.yaml     |   3 +
>  drivers/iio/humidity/hdc3020.c                | 445 ++++++++++++------
>  2 files changed, 312 insertions(+), 136 deletions(-)
> 


