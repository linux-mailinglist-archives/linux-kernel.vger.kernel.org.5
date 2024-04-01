Return-Path: <linux-kernel+bounces-126973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DECF89452C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA0A281FE6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5411F524B8;
	Mon,  1 Apr 2024 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEtZqFxV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F69249E4;
	Mon,  1 Apr 2024 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998262; cv=none; b=UyFVuU7ZG3z72ke8IPxmNAayUBgkR01MpaBce6P8tpOrU80ty+6kqKVnWEkTo8cb5Hyr0zOvxhleM3Mf3gO48y27iKNqBEdMmPKhPMpL85uXUZG0NV+ORu2BsHTRaiHkPFTKcTcIpPS34gXh0dlswbZniWi8aMV4nc+cDz5n1ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998262; c=relaxed/simple;
	bh=AgTHelVsz+bSEWE8bp2UzifCO3HT/TL0k8z89kPZWx4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDCKjim72ddtk6Y7CmM+JdfzWOC/5wOJY8t1ODgEqWzWakomCpuiVkuAHL6z/fIvcVBmp6NUFCiUrOURHp6KXLuKnChNPWw9GMF/mIHky8IouuKTrasi98QgErXB+Lfz6APWE8FmLZt9yBuat1mGZESDIiHRkLd281vfVS1yZlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEtZqFxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8329DC433C7;
	Mon,  1 Apr 2024 19:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711998262;
	bh=AgTHelVsz+bSEWE8bp2UzifCO3HT/TL0k8z89kPZWx4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NEtZqFxVDPiQStJtMES0JB/NfEqkor7ZgBCpa+95nYcRaLw0JMoMEHC3TZtCXpj6w
	 cSKhcXYTWXcAfF+Szrs8ZjGHr19yDM2lQsA5mreQWq3HYIdwmz4qJpQB89kG6Rqx2d
	 Hd+ors9yNwRXrkkAFDZoOTTJZZZtR9aD20xXfAle9shsWaA3ME2/8L7O8lz7UO06Ij
	 JD0fUzFOnRccH+xrK6Jua/oKR7k9gJjkpkTZuHkBjBkv42cXyrWIOAySs+uLCLIQJQ
	 zETJFd4y+PgfUth9jleAUqxLMeKAKit49sSg7PoX4Q93XOhCvNw3IrynCAVVtx4Bzg
	 ygFaahykuUccQ==
Date: Mon, 1 Apr 2024 12:04:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jason Gunthorpe <jgg@nvidia.com>, Christoph
 Hellwig <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
 <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Aron Silverton <aron.silverton@oracle.com>,
 linux-kernel@vger.kernel.org, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Junxian Huang <huangjunxian6@hisilicon.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240401120420.4d33a89b@kernel.org>
In-Reply-To: <20240401181033.GB11187@unreal>
References: <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
	<2024032248-ardently-ribcage-a495@gregkh>
	<510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
	<Zf2n02q0GevGdS-Z@C02YVCJELVCG>
	<20240322135826.1c4655e2@kernel.org>
	<e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
	<20240322154027.5555780a@kernel.org>
	<1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
	<20240401123003.GC73174@unreal>
	<20240401075003.70f5cb4b@kernel.org>
	<20240401181033.GB11187@unreal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Apr 2024 21:10:33 +0300 Leon Romanovsky wrote:
> > Sorry, I have a completely different reading of that thread.
> > Thanks for bringing it up, tho.  
> 
> Different people have different opinions, and it is fine.

Agreed! I think the core of our disagreement is whether and when
one set of people get to force their set of choices on other people.
Far be it from me to try to force my opinions in RDMA or the kernel
as a whole.

> > As I said multiple times I agree that configuring custom parameters
> > in RDMA is a necessity. Junxian's approach of putting such code in
> > the RDMA driver / subsystem is more than reasonable. Even better,
> > it looks like the API is fairly narrowly defined.  
> 
> It was a tiny example, which emphasizes the need for a common way.
> 
> If we were listen to average RDMA driver author, we would find ourselves
> with gazillion different sysfs knobs which do nothing except sending
> raw data to FW. As a subsystem, we don't want to waste our time in
> not-beneficial to the subsystem code.

No disagreement here either, there's a trade-off here between what
you call waste of time and what I'd call fostering organic
collaboration. Even without taking your priorities into account -
whether reviewing device APIs is beneficial is (a) subjective, 
(b) subsystem dependent, so you should be allowed to make your choice
(within the bounds of Linus's trust). But what I keep arguing is that
so should we :|

