Return-Path: <linux-kernel+bounces-36235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86889839DC0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2C6285753
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BDE1FB9;
	Wed, 24 Jan 2024 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lhCUI2Vh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC671872;
	Wed, 24 Jan 2024 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706057644; cv=none; b=ZdC3iwnrYWFr0xkqNNldSFuO8ZDJJpqrg3YFz8smFruv6S7CM/P53Ttwwe7NDrDPWMlvXOMy6kAgxgJ2MZ6kWqn8NpR2E4KWRAzNqcCsYF2F3QQvT7PXpFUfisHVR1KSnn/sLLTWV1xDCTIwsWc2TxonoOPGmzDdAOB2zF6zfuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706057644; c=relaxed/simple;
	bh=D8/fnoZnYDq6gX23XdA37KFCnw+tAaoRYYE4izrTFqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbFSohUiU1dbGvtnD0LhPy82RQEHNi0FhqHDI0Zxb61/FzH4RGVjuwwXyWJYNNp6Sk7NFAjomDhwNoBnnWrvk1w+xgMPionE697IxnDVIhJfzwAfEUzVHLdAut8mXmr4CLz6KYiJojsgc7e01vuy6wgL7/cXeDVTkciGriECFRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lhCUI2Vh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BE1C433F1;
	Wed, 24 Jan 2024 00:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706057643;
	bh=D8/fnoZnYDq6gX23XdA37KFCnw+tAaoRYYE4izrTFqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhCUI2VhTmxzSzbN1xXEt74XXF2PxfMYqSZuoTdftCHMDHoKpWuiZH2qOT9tEmz2J
	 ELwnWtdCJR7lzwd+fzAAoBuf5iaAL/mO1akL5Mc9ex+3s6nxoaDjOezDhRgGFknPf6
	 V82UhHWbGLNwNeKeNLNLgwwaKnAfqUHYfY9ABBDQ=
Date: Tue, 23 Jan 2024 16:54:02 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 2/9] ntsync: Reserve a minor device number and ioctl
 range.
Message-ID: <2024012356-dove-duke-f7f6@gregkh>
References: <20240124004028.16826-1-zfigura@codeweavers.com>
 <20240124004028.16826-3-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124004028.16826-3-zfigura@codeweavers.com>

On Tue, Jan 23, 2024 at 06:40:21PM -0600, Elizabeth Figura wrote:
> Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
> ---

Note, we can't take patches without any changelog text, and you don't
want us to :)

>  Documentation/admin-guide/devices.txt              | 3 ++-
>  Documentation/userspace-api/ioctl/ioctl-number.rst | 2 ++
>  drivers/misc/ntsync.c                              | 3 ++-
>  include/linux/miscdevice.h                         | 1 +
>  4 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
> index 94c98be1329a..041404397ee5 100644
> --- a/Documentation/admin-guide/devices.txt
> +++ b/Documentation/admin-guide/devices.txt
> @@ -376,8 +376,9 @@
>  		240 = /dev/userio	Serio driver testing device
>  		241 = /dev/vhost-vsock	Host kernel driver for virtio vsock
>  		242 = /dev/rfkill	Turning off radio transmissions (rfkill)
> +		243 = /dev/ntsync	NT synchronization primitive device
>  
> -		243-254			Reserved for local use
> +		244-254			Reserved for local use

Why do you need a fixed minor number?  Can't your userspace handle
dynamic numbers?  What systems require a static value?

thanks,

greg k-h

