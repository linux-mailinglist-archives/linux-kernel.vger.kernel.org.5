Return-Path: <linux-kernel+bounces-60931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2C5850B3F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5411C2102D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A315DF18;
	Sun, 11 Feb 2024 19:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYQRuL0m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362D5C90A;
	Sun, 11 Feb 2024 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707680244; cv=none; b=DtcsJMxt9TL9q13A3cz9CPAXPsYV/wiDzAoI4K8bsQF/G640Px+06ChEefNkzw+AH5t12EIIHzJ0uqzfbXfBccA7tgavZjr+askn1RKTj5XvrKeHm7HSIASqgspwXaSfym3SnFH3hTkYvF4l9zd1wDB9OBrmmoi8PG5+2X1B/a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707680244; c=relaxed/simple;
	bh=5oFPK3XMyl8w2jJth5vxf9+kHoqJQsWI3K4xfwNY57A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LC9XxFoatJgZ40daJhnzzPA21bFxAtVU8fMMqaD+ClQLRgeFrN5z32bl8tiOAckC/WJCi9lsdXHxRYpQ9Ix1A98htw2gK+guMUPRZKMQ3zRqE7A0ZCvX80vUSQhbrXPqbG7cgopdsTn6tr29JwfEV6utZN4I1hzRb6izavF7Qzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYQRuL0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE07C433F1;
	Sun, 11 Feb 2024 19:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707680243;
	bh=5oFPK3XMyl8w2jJth5vxf9+kHoqJQsWI3K4xfwNY57A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tYQRuL0m7cpAzYcUgAoYObc55ZHJtJW73n95KM3172I4fWSmEX72iAucjmH8XSgm+
	 uSb3lVkRiE1nNJQfKOBB31rJ711GaeL+1sdwVnJWGo4uhhzKiXg5LTWIjsBI0qYBIm
	 TAI5hyCo4Ph0mvJXydNEZuB0TziMQB7kSHpWbGq6YwxdTX32ITStpE/LNjrDBE4YmS
	 auOfMvBbRHWMX5NiFGsEwtyI5wPkSJX0dayMvxx6ukoR5xP0x+FtfqJYbdP4xGARhX
	 +aCvXXN/SfBi/Epu2lCfqhrT0/FD77tF34KNKXdMQvsoJi9yiXbT0K8wL6FA8CJwAE
	 GhlmF9oAzEAgQ==
Date: Sun, 11 Feb 2024 19:37:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: andy.shevchenko@gmail.com
Cc: Dinghao Liu <dinghao.liu@zju.edu.cn>, Lars-Peter Clausen
 <lars@metafoo.de>, Alexandru Ardelean <alexandru.ardelean@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: core: fix memleak in iio_device_register_sysfs
Message-ID: <20240211193711.518b76d7@jic23-huawei>
In-Reply-To: <ZckdEDbAqin1Fsgt@surfacebook.localdomain>
References: <20231208073119.29283-1-dinghao.liu@zju.edu.cn>
	<20231210133228.5fd425ea@jic23-huawei>
	<20231217132800.27e83a01@jic23-huawei>
	<ZckdEDbAqin1Fsgt@surfacebook.localdomain>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Feb 2024 21:16:32 +0200
andy.shevchenko@gmail.com wrote:

> Sun, Dec 17, 2023 at 01:28:00PM +0000, Jonathan Cameron kirjoitti:
> > On Sun, 10 Dec 2023 13:32:28 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > On Fri,  8 Dec 2023 15:31:19 +0800
> > > Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
> > >   
> > > > When iio_device_register_sysfs_group() fails, we should
> > > > free iio_dev_opaque->chan_attr_group.attrs to prevent
> > > > potential memleak.
> > > > 
> > > > Fixes: 32f171724e5c ("iio: core: rework iio device group creation")
> > > > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>    
> > > Hi.
> > > 
> > > Looks good to me, but I'd like to leave this one on the list a little
> > > longer to see if anyone else has comments.
> > >   
> > Guess no comments!  
> 
> This patch does not fix anything.
> 
> Yet, it might be considered as one that increases robustness, but with this applied the 
> goto
> https://elixir.bootlin.com/linux/v6.8-rc3/source/drivers/iio/industrialio-core.c#L2007
> can be amended, right?
> 

I'm lost.  That goto results in a call to 
iio_buffers_free_sysfs_and_mask(indio_dev);
which continues to undo stuff from before that call.
Now if it did
iio_device_unregister_sysfs(indio_dev);
(as per the label above it in the cleanup) then I'd agree.

Perhaps I'm misreading the code flow here?

All this code is supposed to be side effect free on error so I'm
keen on the change even if there is another path where it gets cleaned
up that I'm missing.

Jonathan

