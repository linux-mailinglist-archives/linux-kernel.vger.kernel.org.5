Return-Path: <linux-kernel+bounces-52225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8F58495AB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231181F24E43
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBFE11CAE;
	Mon,  5 Feb 2024 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDxJWxgt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD3C1170E;
	Mon,  5 Feb 2024 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123013; cv=none; b=MyzrBzOsVv8QjnRv+BGUc+NOSNoDm/Ba/J++Zy2ZXlnikgBozpdIEG0Sbi/aepzsH1q6jbVgAJ+n/PMz22dlDmMb5/EAjnWeBMuE5Z7btWXUHlY6cdUZZ9J/A6evzjqqHEtgXgHAxxVT186x915OhTvntaP/svIzHlm2ESjA07w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123013; c=relaxed/simple;
	bh=n8l8ZDTaGN72EVPrMGmTV9OZ7Qe17Bvaq4fAGCujogI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXxyN2PJFIYshOGfDdyf22z2puEQFS+hy5/GiWYGgQQGyIJSzxHNckS+4nZDSRBlnw6+20MsXx4kEV2ryhNS3hCOPk76lZK99itG7u45cgoN504TNNftrTgxoW4VNZKnMcSyxsXo8jOGlYv7cKZ0+0iHV1+whlMJwZEtUBdpO0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDxJWxgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9320BC433F1;
	Mon,  5 Feb 2024 08:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707123012;
	bh=n8l8ZDTaGN72EVPrMGmTV9OZ7Qe17Bvaq4fAGCujogI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MDxJWxgtCIdPk2zSnox1ju0XLwp5bi4qEEQVS9Gtc00d6Yzysb+QGs/mZgS5R5Obm
	 4rjU0x3ZElfQqvnjqvCByj3NI7vfAyo9xDOOJW37n8+Iffb/xo8fKt425XfufGxeeQ
	 Zcr2gOfgrpe5uOujuYfiqMvifHITVzxuIT/4baIeXUex9fLPipHPAQk8Cy5Jb0y8+W
	 QsdsWe1oH4GtHUfyxJrQOpizr/RFQ3VixwTMevFMIu8igzukjBb80seOVpf5LiP24q
	 3IXmpvYrZfUtPT+ca8+vkfvtPQeajDH/uzOGpWkfVKJQHYshD7HRc5H588N1oIBSGs
	 DUju7HSgt17Aw==
Date: Mon, 5 Feb 2024 08:50:07 +0000
From: Lee Jones <lee@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Pavel Machek <pavel@ucw.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Li Zetao <lizetao1@huawei.com>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] leds: trigger: netdev: Fix kernel panic on interface
 rename trig notify
Message-ID: <20240205085007.GA19855@google.com>
References: <20240203235413.1146-1-ansuelsmth@gmail.com>
 <8d51f09b-e6d2-4ee1-9e7d-b545d561798a@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d51f09b-e6d2-4ee1-9e7d-b545d561798a@lunn.ch>

On Sun, 04 Feb 2024, Andrew Lunn wrote:

> On Sun, Feb 04, 2024 at 12:54:01AM +0100, Christian Marangi wrote:
> > Commit d5e01266e7f5 ("leds: trigger: netdev: add additional specific link
> > speed mode") in the various changes, reworked the way to set the LINKUP
> > mode in commit cee4bd16c319 ("leds: trigger: netdev: Recheck
> > NETDEV_LED_MODE_LINKUP on dev rename") and moved it to a generic function.
> > 
> > This changed the logic where, in the previous implementation the dev
> > from the trigger event was used to check if the carrier was ok, but in
> > the new implementation with the generic function, the dev in
> > trigger_data is used instead.
> > 
> > This is problematic and cause a possible kernel panic due to the fact
> > that the dev in the trigger_data still reference the old one as the
> > new one (passed from the trigger event) still has to be hold and saved
> > in the trigger_data struct (done in the NETDEV_REGISTER case).
> > 
> > On calling of get_device_state(), an invalid net_dev is used and this
> > cause a kernel panic.
> > 
> > To handle this correctly, move the call to get_device_state() after the
> > new net_dev is correctly set in trigger_data (in the NETDEV_REGISTER
> > case) and correctly parse the new dev.
> > 
> > Fixes: d5e01266e7f5 ("leds: trigger: netdev: add additional specific link speed mode")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> This should have 'net' in the subject line, to indicate which tree its
> for.

No, it shouldn't.

Contributors aren't obliged to know anything about merging strategies.

Why does this need to go in via net?

> Otherwise:
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks.  Always very useful.

-- 
Lee Jones [李琼斯]

