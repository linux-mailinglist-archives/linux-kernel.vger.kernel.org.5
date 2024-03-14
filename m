Return-Path: <linux-kernel+bounces-103644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F118C87C263
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817C828318D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0029874C05;
	Thu, 14 Mar 2024 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ht9X5C9U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BA774439;
	Thu, 14 Mar 2024 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710439556; cv=none; b=HNW5OnGlLMxi7zaKMBaMafG0I6nQQp5xehoF56lrcbTJdFen/Dy/3PlcysvoL3Z8xChBVSzSvoUgsyJV2gL8LCaRW8WgFehqYtyd1B+2IYH40B0D8hhqJ7481e22xWA0v1rA6EVYhYuYyGKg6U1YRMxevbyLbTxE8A3QnGHFJgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710439556; c=relaxed/simple;
	bh=+5F0dYBLm4qTYsNO4dL5yh/7Iya3KdTlD5xoAX0TxFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DD17feJKN6bX44RoZEN+AaizN+TMvAht4FVx0kkOlgwsdNr8e1h6QOwVL8ggoePoXvbn0kna0wScZ7A1Myw2271fAgvJO5yGxC8V7ojO1PXhoBByDETj+MU/wJYoVtCXRpFPHNF7yIMk17ONY1mPz6UcRwD4MFbDbavb9TLsVNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ht9X5C9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46005C433F1;
	Thu, 14 Mar 2024 18:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710439555;
	bh=+5F0dYBLm4qTYsNO4dL5yh/7Iya3KdTlD5xoAX0TxFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ht9X5C9UZLTlDtbocmcuWURz3t7EKaNb6bffyuTknrTcXioBlpve/6nhp11MOXifR
	 Bs+x0ZRUEK72l8GQ6cbSBJW/rrdISxLOySoJnxZ56ThFOL9A9xFtPUjMV5FlYI3YRD
	 wjdgU2bOm0/qalGPe6QPbed1oz510lRGBLUwapyOMMOWxMzViVtK4nVarXl66nYz4Y
	 HlnWiTwA3+zRhyYXXG2WI8+jJr//ICi3rdYGLznpSgTaVu214RLdr/Xgw0jpU69KUN
	 42Kj96ho/on9z0CiX1d0drrc95gk9JbP9QtkUmiSUT3N7Rbc0ga+JR7CExEHTeNo+n
	 zUEbruhKqyFnw==
Date: Thu, 14 Mar 2024 11:05:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 alexandre.torgue@foss.st.com, andrew@lunn.ch, corbet@lwn.net,
 davem@davemloft.net, dtatulea@nvidia.com, edumazet@google.com,
 gal@nvidia.com, hkallweit1@gmail.com, jacob.e.keller@intel.com,
 jiri@resnulli.us, joabreu@synopsys.com, justinstitt@google.com,
 kory.maincent@bootlin.com, leon@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, liuhangbin@gmail.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com,
 paul.greenwalt@intel.com, przemyslaw.kitszel@intel.com,
 rdunlap@infradead.org, richardcochran@gmail.com, saeed@kernel.org,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev, vladimir.oltean@nxp.com,
 wojciech.drewek@intel.com
Subject: Re: [PATCH RFC v2 6/6] tools: ynl: ethtool.py: Output timestamping
 statistics from tsinfo-get operation
Message-ID: <20240314110553.1c5310c9@kernel.org>
In-Reply-To: <87ttl9fhyd.fsf@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
	<20240309084440.299358-1-rrameshbabu@nvidia.com>
	<20240309084440.299358-7-rrameshbabu@nvidia.com>
	<20240312165544.75ced7e1@kernel.org>
	<87plvxbqwy.fsf@nvidia.com>
	<20240313174707.38a71c84@kernel.org>
	<87ttl9fhyd.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 23:07:22 -0700 Rahul Rameshbabu wrote:
> What's your expectation for how the request structure would look like? I
> have tried the following.
> 
>   if args.show_time_stamping:
>       req = {
>         'header': {
>           'flags': 'stats',
>         },
>       }
> 
>   if args.show_time_stamping:
>       req = {
>         'header': {
>           'flags': {
>              'stats': True,
>           },
>         },
>       }
> 
> I tried looking through the lib/ynl.py code, but I did not understand
> how the 'flags' type was specifically handled.

Rebased on latest net-next?

I used this:

/tools/net/ynl/cli.py \
	--spec Documentation/netlink/specs/ethtool.yaml \
	--do fec-get --json '{"header":{"dev-index": 2, "flags": "stats"}}'

