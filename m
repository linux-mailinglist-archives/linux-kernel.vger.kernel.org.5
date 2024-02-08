Return-Path: <linux-kernel+bounces-58459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E67484E6C5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B911C2480F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA052823AB;
	Thu,  8 Feb 2024 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mH1dGVaF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081B373164
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413288; cv=none; b=EUGM4bfVtqZHvbrtUfeC8UkVXBIcTq5iIsCRADoqM8TYUzlUYrXd7R0oLN0MmEvRamgI1GMOtees+HPTJ8kbkkGZB0KZNK3vdkMrZiuKbvMNiJJjzlT/9U9h79yNLf4slzcGuqTPGdB4xcXiQXbCOo5qfqp2uJhBbhSNN8yx+SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413288; c=relaxed/simple;
	bh=PbK9lZkGvTCDpgvmYCYNtp1ktrj17ouTcNWuLsrQ2To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLaMRGN13TMb/nBLSLZ1sRBz2FY5Dcb6tnNIz2rEw9Z+pbKexmdvUNdoJ9loUQU0tsV0tqcAPXu5luBjK5WY/rqYusBFLL4Uends9XPNSM6apbHxUwzpmLPiBT7gUcLA8vRzerOYcfl1TFlxKOk+TKMnDGpCkw6Z/YR6RdH4Fcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mH1dGVaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C73C433F1;
	Thu,  8 Feb 2024 17:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707413287;
	bh=PbK9lZkGvTCDpgvmYCYNtp1ktrj17ouTcNWuLsrQ2To=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mH1dGVaFvNzPLCkvgXp9aFMLOiqI1A0jvrVFS0q4TmJhJQuR1p6BbVSVTiaH4SC5T
	 q9j+yd9CqMfmphaB2UiczhFy/BiMU5HMcM7GAj5cRK9qLtj5Xj6THfCHimnC+pQL0f
	 6r/FxE2Tfyf/Ekel3kQQTXlKuExESL7Ee6r5/iyE=
Date: Thu, 8 Feb 2024 17:28:04 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tejun Heo <tj@kernel.org>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: make wq_subsys const
Message-ID: <2024020820-chaos-scale-33cf@gregkh>
References: <20240206-bus_cleanup-workqueue-v1-1-72b10d282d58@marliere.net>
 <2024020752-tannery-frozen-04ea@gregkh>
 <ZcOxE2nznfq7dcNh@slm.duckdns.org>
 <2024020813-wool-haste-fe6d@gregkh>
 <ZcUHYUVnVTwb_ZSF@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcUHYUVnVTwb_ZSF@slm.duckdns.org>

On Thu, Feb 08, 2024 at 06:54:57AM -1000, Tejun Heo wrote:
> On Thu, Feb 08, 2024 at 10:10:56AM +0000, Greg Kroah-Hartman wrote:
> > On Wed, Feb 07, 2024 at 06:34:27AM -1000, Tejun Heo wrote:
> > > On Wed, Feb 07, 2024 at 10:12:34AM +0000, Greg Kroah-Hartman wrote:
> > > > On Tue, Feb 06, 2024 at 03:05:06PM -0300, Ricardo B. Marliere wrote:
> > > > > Now that the driver core can properly handle constant struct bus_type,
> > > > > move the wq_subsys variable to be a constant structure as well,
> > > > > placing it into read-only memory which can not be modified at runtime.
> > > > > 
> > > > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > > > > ---
> > > > > The maintainer asked [1] for this patch to be received through the
> > > > > driver-core tree.
> > > > > [1]: https://lore.kernel.org/all/ZcEeOueCbrltxr_b@slm.duckdns.org/
> > > > 
> > > > There is no cross-tree dependency at all, but hey, I'll take it, no
> > > > worries...
> > > 
> > > Ah, my bad. I branched out wq/for-6.9 before rc1 and was assuming the
> > > dependent commit was still in the driver core branch. I should have just
> > > pulled linus#master.
> > 
> > The dependent changes are in 6.4, so before -rc1 would have been ok as
> > well :)
> 
> Hmmm....
> 
>  > git log -1 --oneline 32f78abe59c7
>  32f78abe59c7 driver core: bus: constantify subsys_register() calls
>  > git describe --contains 32f78abe59c7
>  v6.8-rc1~61^2~10

Ugh, sorry, you are totally right.  Too many different "make X const"
series are floating around now, my fault.  I'll go suck this in now to
end the pointless discussion where I am proven wrong multiple times :)

greg k-h

