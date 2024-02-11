Return-Path: <linux-kernel+bounces-60704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F908508BA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FF71F22669
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241A15A4D1;
	Sun, 11 Feb 2024 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cozt0i8r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0EE39AFA;
	Sun, 11 Feb 2024 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707649405; cv=none; b=SieJ23GdoXN9uvQKpUCIy4R1thtSmMKO9rnMSR4ART4M8xdApae8n+ssoOiJr64+Vj52rXw5xXxr9x8Ms+idov1+p7yrm3ktGdE4m+i5ganiqkE89KnGXjN5v1dshhCwE6pY3auY2vOexDgnnUrXZn8Scn+17l4rnV8V/Rckekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707649405; c=relaxed/simple;
	bh=FDdtAun0HW0ZCG+7jGqPTp9NYni7KLx7GZ2BuE1pnyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcT4A5GeNyzN89f350DOE5mDrhqweO2Muf7zAGhtC6znGe/rcIjqPKcQF1Bsa35kJJ9ycKGF3ZaH80e57CaI9739AI95xVokYNCzxlThSG3+xEuQaABj+dN6MSshTO/oOuvk4yKqyDlsTocHwRbAIy4pQw9H1xC1ofFBBG7PfNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cozt0i8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588E6C433C7;
	Sun, 11 Feb 2024 11:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707649404;
	bh=FDdtAun0HW0ZCG+7jGqPTp9NYni7KLx7GZ2BuE1pnyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cozt0i8rdiBzTyfc2xuxTGSKFdLM5CAqsJ0pdhjVwqF1jfVelDbSUjbQvBOnaR0TQ
	 gMqYno4f2v4F6nzEn8W/URuXQaE3hV/XRAj2oJtRQG6ARHAKv3xFi08YOvQ34vzf67
	 SfaZbt/zuR3dg3jM5iRZuq5yfPTWl+Fpd3//KeEw=
Date: Sun, 11 Feb 2024 11:03:21 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeed@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <2024021139-feast-subtitle-f6e3@gregkh>
References: <20240207072435.14182-1-saeed@kernel.org>
 <20240207070342.21ad3e51@kernel.org>
 <ZcRgp76yWcDfEbMy@x130>
 <20240208181555.22d35b61@kernel.org>
 <2bdc5510-801a-4601-87a3-56eb941d661a@kernel.org>
 <20240209145828.30e1d000@kernel.org>
 <df5d7538-52c6-465c-b250-13532b90c6ae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df5d7538-52c6-465c-b250-13532b90c6ae@kernel.org>

On Fri, Feb 09, 2024 at 10:01:33PM -0700, David Ahern wrote:
> >> BTW, there is already a broadcom driver under drivers/misc that seems to
> >> have a lot of overlap capability wise to this driver. Perhaps a Broadcom
> >> person could chime in.
> > 
> > I'm not aware. Or do you mean bcm-vk? That's a video encoder.
> 
> If that specific piece of S/W is a video encoder, why isn't it under
> drivers/video? Scanning the code it seems to me to fall under the open
> channel between userspace and F/W which is a common paradigm. But I do
> not want this to distract from this patch set; really I was just
> browsing existing drivers for any overlap.

It is an "offload-engine" type of thing that was added before we had the
specific subsystem for it.  It should be moved to drivers/accel/ one of
these days, want to volunteer to help out with that?  :)

thanks,

greg k-h

