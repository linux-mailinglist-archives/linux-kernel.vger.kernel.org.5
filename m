Return-Path: <linux-kernel+bounces-131645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F56898A60
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16816282CCC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82C81C2AF;
	Thu,  4 Apr 2024 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blVn1f/g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341581BDE6;
	Thu,  4 Apr 2024 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242132; cv=none; b=je7IyW9hOBXN59c1VZ9X7iLR+aQk2fkT0CuOAzWZcL4/wprpzYB7AmzLRup9HZwHdU6SOURqw303klEAZU2g8rfvjRACUUcVXGbsXOUp2eG7op9bvFV0FvS3RFPctX3BMMBvVi0YfjA36Lw55QzDeUdUJNltZUcf1fv8/CBQ0Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242132; c=relaxed/simple;
	bh=rVRIqR3/LSX+jFXOSJrMgEG2eSzd5XHIYRaWmk+41kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JlAgPSj7gRWWk8y7x3+xQjatkec2yc3ueo9I3skKgfSMeROfWkTOgSvVNT444Gcf0E7m+a4zEte2c0aW3j07f/Xg6exr1Hl2dUaxIbCwQiOPh2D/OVtjEkRQVinGnSsfkKfXtnMC2zPS8WH7c8OYNVrs0rg6XL2jrVQ0olbv5WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blVn1f/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12664C433C7;
	Thu,  4 Apr 2024 14:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712242131;
	bh=rVRIqR3/LSX+jFXOSJrMgEG2eSzd5XHIYRaWmk+41kQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=blVn1f/gWcaW6tA31PfGDLiXmGMv0hDXOvCB9tTDML5bk4BkZTi0z3c8ha/XqdSOG
	 hZfMuxU6TXJo+RkmtTJLCr01O50LNmJf1jVYwJ+Dc3oDOYHpZ5ALYKNW6WllKI6t3+
	 QDJMF6J67EE2NsZ594IVgbpVvRKHangYZcMZGL+ScifpWMxV8XrGs2Js43HjH33eKy
	 tdVOhF/pjlfruioZf0EKmmPRjqsFhUZaAPwcw2fJQZiTwErrkt352nR3Bjek7n6lA+
	 G/jWy2ztaGDIUClCBK2oqZvRb5VV3uPQL0QJH46QQyUE8a2HF7wI8KttvfcAR1neLn
	 fuvP0uQKSr+4w==
Date: Thu, 4 Apr 2024 07:48:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Edward Cree <ecree.xilinx@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Saeed
 Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jiri Pirko
 <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>, Itay Avraham
 <itayavr@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Aron Silverton
 <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240404074850.19ecd52e@kernel.org>
In-Reply-To: <20240404122338.GI1723999@nvidia.com>
References: <20240322135826.1c4655e2@kernel.org>
	<e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
	<20240322154027.5555780a@kernel.org>
	<1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
	<0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
	<20240402184832.GO11187@unreal>
	<cefa2b9a-4227-969e-d31e-c19a552b9c1c@gmail.com>
	<20240403190012.GV11187@unreal>
	<d75ee9d5-36a9-4056-a0f3-0c05b2e744aa@kernel.org>
	<20240403170149.7d2b8f2b@kernel.org>
	<20240404122338.GI1723999@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 09:23:38 -0300 Jason Gunthorpe wrote:
> > "didn't understand the discussion" is an ironic thing for you to +1,
> > David. After all my emails about HNS3 RDMA you somehow concluded today
> > that I want to make rules for the entire kernel:
> > https://lore.kernel.org/all/6faa47b0-27c3-47f9-94be-1ec671d9543c@kernel.org/  
> 
> What if (hypothetically) I tould you that the congestion control
> settings in the device FW impacted netdev sourced ethernet trafic as
> well? Would you be so sanguine that RDMA should have those settings?

We can lawyer the words until the cows come home.
The team I work on takes care of both RoCE/IB/pick your fav proto
and TCP/IP NICs. It's fairly obvious what is RoCE and what is TCP
or user UDP when there are no incentives to act otherwise :|

> > And I second what Ed said. I have asked multiple vendors preaching
> > impossibilism in this thread to start posting those knobs. I offered
> > to do a quick off-list review of the list of knobs they have to give 
> > a quick yay / nay, so they don't waste time implementing things that
> > would get nacked. None of the vendors bothered taking me up on that
> > offer.  
> 
> As far as configuration/provisioning goes, it is really all or
> nothing.
> 
> If a specific site can configure only 90% of the stuff required
> because you will NAK the missing 10% it then it is still not usable
> and is a wasted effort for everyone.

(a) are you saying that the device needs 100% of the knobs to be used?
    oof, you better warn your prospective customers :S
(b) as Ed pointed out some of the "knobs" are just hacks and lazy
    workarounds so we rejected them for quality reasons; the remaining
    rejects are because the knobs aren't really device specific, but
    vendors don't want to extend existing APIs, as it is easier to
    ship "features" without having a core kernel dependency...

> You have never shown that there is a path to 100% with your approach
> to devlink. In fact I believe you've said flat out that 100% is not
> achievable. Right here you illustrate the fundamental problem again:
> there are configurables that already exist in the device that you will
> NAK for devlink.
> 
> This is fundamentally why no one is taking you up on these generous
> offers to pre-NAK device's designs. You made it explicit that you will
> will NAK something and then it is not 100%.
> 
> Saeed has said repeatedly he wants 100% of the endless configurables
> in mlx5. You have the manual and know what they are, tell him how to
> get to 100% in a few months of work and I will believe you that it is
> not impossible.

Sorry, are you saying that I'm responsible for a providing a solution
to allow arbitrary vendor tools to work and proprietary user space to
communicate directly with the proprietary firmware?

> Then we only have fwctl's support for debugging and other topics to
> argue about :P

