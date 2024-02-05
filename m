Return-Path: <linux-kernel+bounces-53799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D93084A6B4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5441C265A1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42F74F5EC;
	Mon,  5 Feb 2024 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ut4hxglr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367534CB45
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160081; cv=none; b=POrMaz0Dixl4pLCTVY9vH32x3FUH0zB7Kpg9nDwxAN5kSSeD+P6Wxz0wiZewCQ26ROpUvmTzZrqWWZumTy2PuigqjKsIxefbiaYkgjkyVAcUNyJuCswhUEzSvUBGIwQgcs2OtLjLhHT1vTOrsiEdHBeJbZvkw1AcUw8DzgHL3RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160081; c=relaxed/simple;
	bh=ff6AWunrC1YTnVwC7+tydmavyjoH0bOlb1l2ITWKXgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgSfEMoCMINmzTI8qGkV7EkWelNwE3ZgiQzTMfv8gDx+Lgw6em91SofyYBE9n6arwGBE8PPVoiDEe7RXI8vD3oEKxT0r+64owI707G5wY/Nc6PMbl0aE23M9SYn13xlZ7jgFSbeneDWVDEGQbvb0xfU+hNo5PTAPOd3rWKyejk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ut4hxglr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA93C433C7;
	Mon,  5 Feb 2024 19:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707160080;
	bh=ff6AWunrC1YTnVwC7+tydmavyjoH0bOlb1l2ITWKXgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ut4hxglroao+CExPCW5Q/mf/c8Jq7/YBQpk+symifSSsW/FV6gPOIGJffBMJB7cgV
	 KnMTuIP0R38cZleq91e6UYcdpvazaJs6fexAaPKr+AyCfr2CwvMXHlBxQ9bzfZVr5k
	 +7lYka2DjfpG1tiAy9qOpCizAmyu/dELXaj2l/gE=
Date: Mon, 5 Feb 2024 19:07:58 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Jens Taprogge <jens.taprogge@taprogge.org>,
	industrypack-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipack: make ipack_bus_type const
Message-ID: <2024020552-pox-designer-1861@gregkh>
References: <20240204-bus_cleanup-ipack-v1-1-aef5e8f84d01@marliere.net>
 <ZcDzsP8mRl3Rp9bx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcDzsP8mRl3Rp9bx@gmail.com>

On Mon, Feb 05, 2024 at 03:41:52PM +0100, Vaibhav Gupta wrote:
> On Sun, Feb 04, 2024 at 05:00:13PM -0300, Ricardo B. Marliere wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> > move the ipack_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> > 
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> >  drivers/ipack/ipack.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ipack/ipack.c b/drivers/ipack/ipack.c
> > index b1471ba016a5..866bf48d803b 100644
> > --- a/drivers/ipack/ipack.c
> > +++ b/drivers/ipack/ipack.c
> > @@ -187,7 +187,7 @@ static struct attribute *ipack_attrs[] = {
> >  };
> >  ATTRIBUTE_GROUPS(ipack);
> >  
> > -static struct bus_type ipack_bus_type = {
> > +static const struct bus_type ipack_bus_type = {
> >  	.name      = "ipack",
> >  	.probe     = ipack_bus_probe,
> >  	.match     = ipack_bus_match,
> > 
> > ---
> > base-commit: 41b9fb381a486360b2daaec0c7480f8e3ff72bc7
> > change-id: 20240204-bus_cleanup-ipack-7e502021db1f
> > 
> > Best regards,
> > -- 
> > Ricardo B. Marliere <ricardo@marliere.net>
> > 
> 
> Hello Ricardo,
> 
> Thank you for your patch.
> 
> Acked-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> 
> Greg, would you please add it to your misc tree.

Will do, thanks!

greg k-h

