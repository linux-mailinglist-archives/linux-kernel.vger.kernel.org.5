Return-Path: <linux-kernel+bounces-71016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D4E859F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B1D0B2243B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5F52377A;
	Mon, 19 Feb 2024 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVjvwDb0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC792375A;
	Mon, 19 Feb 2024 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334235; cv=none; b=fszfeA6UoJfy46luy2cwbnAjwyvDL0zNal4PboYmyGwai1GOU9VB7kDPArdwJrlBmP4YO6PeeepEqC/7XcSiKKAhcsQHIIRfZcctmWNR7hfrtToHjqzmUOhdmfA5FFD8bf5S61dTRaS0q9zqcr+Pzm+UdqVA1vxK3tg7L1SIEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334235; c=relaxed/simple;
	bh=dD3INK0771hk25i6LkvIjVMoJ3kpzAlg/X0uVYDQORA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSZdPs5UhEPujx5v6+7QMrZJ9RBAK99WxAERP09/MOoxjCNpvqYDki1DUMKytjYbu2heUerXoYmBB8FBuc0recOHw2bA408x4r4Wuo/xjS/0zf+UirP/GlikCPH7DBitU1TzhxQvjIEzUa2ij6cBG4cuL4DTXgHQcOw970ExqX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVjvwDb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A44FC43394;
	Mon, 19 Feb 2024 09:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708334235;
	bh=dD3INK0771hk25i6LkvIjVMoJ3kpzAlg/X0uVYDQORA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVjvwDb0GFMfrllhHFnP7TNXuxovgdiUO9KzIIfjPZViwPxRUphxP/Tz5jMlHPwXx
	 a4ZIaldT0DZmjTGzrf8sUTUhIUIGP+r4NxMG8rw+MGxmDkZq3hfd1VW6jTYzbQwmCi
	 LrJsiMKtM5poAcFs4EJHaysoM0VGw2Pm/CrKdDKgZxoRxdfQuizaGGUT+UX0D5JgRl
	 72chEzlbuC4mlBn+7+m6VTtWKXaDtqx7AxGsMsk6f1Z4DKOS3ycY+L9IXJvyAb7pBj
	 YczfjptHCQJUP/91NvD3KwaQ++eMFMXk1seJgCOH4HIB4K7gh+dVenm8APoQGS9IV5
	 XTVluns0kF44w==
Date: Mon, 19 Feb 2024 09:17:09 +0000
From: Will Deacon <will@kernel.org>
To: Daniel Mentz <danielmentz@google.com>
Cc: "ni.liqiang" <niliqiang.io@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	"jin . qi" <jin.qi@zte.com.cn>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/iommu: Ensure that the queue base address is
 successfully written during SMMU initialization.
Message-ID: <20240219091709.GA4105@willie-the-truck>
References: <20240218050224.33426-1-niliqiang.io@gmail.com>
 <CAE2F3rA1Lb_ayrLQTw+urtNSMoBg9q6CmcSsP7_dZwbfiYygsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rA1Lb_ayrLQTw+urtNSMoBg9q6CmcSsP7_dZwbfiYygsw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Feb 18, 2024 at 09:44:47PM -0800, Daniel Mentz wrote:
> On Sat, Feb 17, 2024 at 9:02 PM ni.liqiang <niliqiang.io@gmail.com> wrote:
> > If there are no memory barriers, how can we ensure this order?
> 
>  The SMMU registers are accessed using Device-nGnRE attributes. It is
> my understanding that, for Device-nGnRE, the Arm architecture requires
> that writes to the same peripheral arrive at the endpoint in program
> order.

Yup, that's correct. The "nR" part means "non-Reordering", so something
else is going on here.

Will

