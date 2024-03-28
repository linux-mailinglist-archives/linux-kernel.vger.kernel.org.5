Return-Path: <linux-kernel+bounces-122857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFAB88FE7E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F7F0B213E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330E57EEF5;
	Thu, 28 Mar 2024 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aR9MULsH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5957E76F;
	Thu, 28 Mar 2024 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627269; cv=none; b=knK9CbCibzT1trf2pWH9joFTAVpoC1bkoStfgqZcPoCYdlTrmVicAonTHfApBjEX+u8rZ3DSWgIfv7V61f56yrCWJdCjeofTscNGydmnEmr8dkrmuv0ZPDIA3qPK5SvilP4BgwE5un7hfHGhve+xhAOoRqdSWzpEQriLi0D5Um4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627269; c=relaxed/simple;
	bh=I1avYsd9ETlkYpKipMeGrNMLkEiqUIC6QVZi8T+EEGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdLQ9AkssHOo8N3hfIjigzhy4hvBgI8v/LplDPSK/Cmu3vpaLqLSRy/NVgm8fC4Zo2Eae9CabWw98rb19/HcQ0R7QDD+72Ia8NN5zZtUDTJnDFMAOxkoTkL5CM/0IfFcZxw7EYS7eh8SDvnZOtW3Rg9HcLL67N/sJGse+UaY3ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aR9MULsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82799C433F1;
	Thu, 28 Mar 2024 12:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711627268;
	bh=I1avYsd9ETlkYpKipMeGrNMLkEiqUIC6QVZi8T+EEGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aR9MULsHFZg8qjpCiOb6GC0EKdcsPIw+hkjBydQxI8NI0RYYEHIV2MEzd/2IDxyRI
	 btjxVcqQXmaOy3ho3AC4oeKNyhSxFBgLIVWfS4PCmLiYKIuk3Q5ANal2awJqPyPFYP
	 XJfahJ1QQajwSbkT+bDxMupBzRhxmqqRKc2t93AM=
Date: Thu, 28 Mar 2024 13:01:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] video: backlight: constify struct class usage
Message-ID: <2024032816-tightrope-lushness-00f1@gregkh>
References: <20240305-class_cleanup-backlight-v1-0-c0e15cc25be1@marliere.net>
 <20240328114131.GB13211@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328114131.GB13211@google.com>

On Thu, Mar 28, 2024 at 11:41:31AM +0000, Lee Jones wrote:
> On Tue, 05 Mar 2024, Ricardo B. Marliere wrote:
> 
> > This is a simple and straight forward cleanup series that aims to make the
> > class structures in backlight constant. This has been possible since 2023
> > [1].
> > 
> > [1]: https://lore.kernel.org/all/2023040248-customary-release-4aec@gregkh/
> > 
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> > Ricardo B. Marliere (2):
> >       video: backlight: make backlight_class constant
> >       video: backlight: lcd: make lcd_class constant
> > 
> >  drivers/video/backlight/backlight.c | 29 ++++++++++++++++-------------
> >  drivers/video/backlight/lcd.c       | 23 +++++++++++++----------
> >  2 files changed, 29 insertions(+), 23 deletions(-)
> 
> No longer apply.
> 
> Please rebase on top of v6.9-rc1 or for-backlight-next.

As I already had this in my local tree, I've sent out a v2 at:
	https://lore.kernel.org/lkml/2024032805-putdown-mushy-a0f9@gregkh/

thanks,

greg k-h

