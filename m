Return-Path: <linux-kernel+bounces-111065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5470B886783
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E743284358
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC62D12E72;
	Fri, 22 Mar 2024 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NQdGycKH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F5612E4E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711092754; cv=none; b=XxruAAG3WeHA9oiF00dojq2CTVrrm/af5OHHAKE6uxKKXxLaEKZcSbcHQJRNa1XeBtjEcshwj+KdZYKPPSreAWfInnjjFMgoTveiLWxx4TDa366NC3/Qax5nsxhfe8l2tTcDuM7dPSyULMH55aXH0rzOMZLwKPzmcdzBU7OoH1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711092754; c=relaxed/simple;
	bh=dvaHaWF/NSDuciCxk9CaOg5cXqouPwxc5xMlUCVozmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJK+u/+uUu0Prphb1sHht6xZwkTzN3U+87dtKo9U26HmDCMI9MO38VF7RA0xtWfpwTj5aLNcYunw0J8roQU3cI2jBw6m1p/gQkEHVNWVU/IgN9DxadOF92IHyGzZv6l/jDygIgZ4IB0YHPKcth1rga3j5gfpppKNTANt56sNJvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NQdGycKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1222FC433F1;
	Fri, 22 Mar 2024 07:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711092753;
	bh=dvaHaWF/NSDuciCxk9CaOg5cXqouPwxc5xMlUCVozmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQdGycKH+xu6txLmlIXuGu8DBkCSUcDbCT2NAlC/iZrqK8s5KhtWwsVJ5ixI+HX0r
	 5C0qm8ybvOGUsl24PEQNBgoVpxkfXL9JKtjGE6TWx2wD3HwZPPCTYJwrjqVo+JGalK
	 DmB7sh3mzqr4cmWxu5sXDv5dk+1jLjI62f5S6P+o=
Date: Fri, 22 Mar 2024 08:32:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: David Ahern <dsahern@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <2024032248-ardently-ribcage-a495@gregkh>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
 <20240214175735.GG1088888@nvidia.com>
 <20240304160237.GA2909161@nvidia.com>
 <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>

On Thu, Mar 21, 2024 at 09:23:28PM -0600, David Ahern wrote:
> On 3/4/24 9:02 AM, Jason Gunthorpe wrote:
> > On Wed, Feb 14, 2024 at 01:57:35PM -0400, Jason Gunthorpe wrote:
> > 
> >> I also like this, I don't want the outcome of this discussion to be
> >> that only mlx5ctl gets merged. I want all the HW that has this problem
> >> to have support in the mainline kernel.
> > 
> > To this end here is my proposal to move forward with a new
> > mini-subsystem to provide rules for this common approach. Get the
> > existing tools out of hacky unstructured direct hardware access via
> > /sys/XX and into a formalized lockdown compatible system. I've talked
> > to enough people now to think we have a critical mass.
> > 
> 
> It has been almost 3 weeks and no response (to this and other proposals
> in this thread). I have been around Linux long enough to know that
> silence is not acceptance.
> 
> To me, this seems like a sane start for a new subsystem addressing
> challenges with complex, modern devices. To that end:
> 
> Acked-by: David Ahern <dsahern@kernel.org>

It's the middle of the merge window, not much we can actually do and
this patch series itself couldn't be applied as-is, so it's hard to see
what could have happened on my end...

thanks,

greg k-h

