Return-Path: <linux-kernel+bounces-128554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E588895C5A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C83D1C228FB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14B615B57E;
	Tue,  2 Apr 2024 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0adb/s0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E052C9D;
	Tue,  2 Apr 2024 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085606; cv=none; b=Bh2oKZg/XBn1TgiOdLFiE0hV0+iGBUy9Tf7BBwzsg0iwN/W4bcra1Mcj6tsF87BhB9pW61ssquR33s8X2tJFtmjo8PI53+FdKWtQsppTqujQCpAElEE/1otEoRAhYHWZOTe14hf6SW+V2BEfya4Q5rGyEC/qyU6srN6Ajs4OeSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085606; c=relaxed/simple;
	bh=xLpJZ8NXTAClbq6nSFG+T4k+KQApXOEcPjNpsIydk5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVxHL4DA0WCD/TVIFlDKL+wohB5sqBSMYXBUC+Tt4LffzvxajZ5LTi6pxs1i5rG1J6+HLRic7O3+9L1PGgsk/BIlq1e11kcvPvZEvfWIsE4Y+V6IHYm/p5xc29cLmtp7/qV/JRI0iylSkW+2j/vkaltCcxH5HTPXGN0ixxXlMnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0adb/s0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1A7C433C7;
	Tue,  2 Apr 2024 19:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712085605;
	bh=xLpJZ8NXTAClbq6nSFG+T4k+KQApXOEcPjNpsIydk5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0adb/s0fi7dJ67UdTzGLdygrJ2ZX0HWC/tXcURGkKtdWdISqYJtafCWlE9Mh5YTO
	 qDXTx3Jfv1cGXEyPbZ9GVq9lFOA6EYOw4p6YxvVXl9sV2uzSulZkiN8Zysl6ms9L6U
	 Ay3IkK7hZakzcO9QRjzwh3a40bdltUP88bl5mC9i/3ahT9PcJzS04ejgd0sLFWQ+j8
	 K5SyxKR7z+UOG4MwVMynuo5XHr+FXJn+7KkcelB23h0yLQPSMXsRemTH1GK098y2t3
	 1BabJFgNM1CxN8JR0eUTGBWzRSO3NmK/4aJG9uzHG8ZtveaIledTSzx3+crH4DORYU
	 8GL+MjlA6nStg==
Date: Tue, 2 Apr 2024 22:20:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240402192001.GQ11187@unreal>
References: <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG>
 <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <20240401123003.GC73174@unreal>
 <20240401075003.70f5cb4b@kernel.org>
 <20240401181033.GB11187@unreal>
 <20240401120420.4d33a89b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401120420.4d33a89b@kernel.org>

On Mon, Apr 01, 2024 at 12:04:20PM -0700, Jakub Kicinski wrote:
> On Mon, 1 Apr 2024 21:10:33 +0300 Leon Romanovsky wrote:
> > > Sorry, I have a completely different reading of that thread.
> > > Thanks for bringing it up, tho.  
> > 
> > Different people have different opinions, and it is fine.
> 
> Agreed! I think the core of our disagreement is whether and when
> one set of people get to force their set of choices on other people.
> Far be it from me to try to force my opinions in RDMA or the kernel
> as a whole.
> 
> > > As I said multiple times I agree that configuring custom parameters
> > > in RDMA is a necessity. Junxian's approach of putting such code in
> > > the RDMA driver / subsystem is more than reasonable. Even better,
> > > it looks like the API is fairly narrowly defined.  
> > 
> > It was a tiny example, which emphasizes the need for a common way.
> > 
> > If we were listen to average RDMA driver author, we would find ourselves
> > with gazillion different sysfs knobs which do nothing except sending
> > raw data to FW. As a subsystem, we don't want to waste our time in
> > not-beneficial to the subsystem code.
> 
> No disagreement here either, there's a trade-off here between what
> you call waste of time and what I'd call fostering organic
> collaboration. Even without taking your priorities into account -
> whether reviewing device APIs is beneficial is (a) subjective, 
> (b) subsystem dependent, so you should be allowed to make your choice
> (within the bounds of Linus's trust). But what I keep arguing is that
> so should we :|

Internal device API is a different story, and I assure you that we are
very close in our views here. Probably main difference is that I'm very
lax for first user and very strict for the second one, while you are more
stricter than me even for the first one.

I gave an example from HNS for API to configure FW without any subsystem
involvement and there is no real way to push to collaboration here without
standardization.

Thanks

