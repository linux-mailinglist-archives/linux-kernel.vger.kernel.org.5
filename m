Return-Path: <linux-kernel+bounces-130760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5DB897CCF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4463D28C852
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729A2611E;
	Thu,  4 Apr 2024 00:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpglnLPO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24191C36;
	Thu,  4 Apr 2024 00:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712188911; cv=none; b=kPoUP19cgXOnmXNiMcnr3pSS2SIiZ8a7Ba5xPkDjlDyePOwAWIShHsH7gBzjqBc5/+nC8kSLqV8WhhOFPY+TkzPpc36tc6v5fjC+lynFGSxe1JsNQKuwYaFGvy07qv2IGv5g/lP+Ga1xvVjcmGFe7/xfTP5IVYiiUSrS9m8KD7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712188911; c=relaxed/simple;
	bh=z6RlBSR5aj4M2kYLHYH9aUI4l4AwRODvROqiMQqGqRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSq1Y8ZshOpXm2iQXp36g8bC2ScHlOXbQH9/Fsb8HV6IYpcVG7azi+ENR4VScP2U86GaOpkkJ79n8wqHzKiSIl8P4E1mqwi+gPzZ9Ub0onbg6yBPkrIBKqPSEhGhyvNttZGvMmPfC1SlqCnNj2rcVtpM6sVkywdOQwf6UcgdqSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpglnLPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DA3C433C7;
	Thu,  4 Apr 2024 00:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712188911;
	bh=z6RlBSR5aj4M2kYLHYH9aUI4l4AwRODvROqiMQqGqRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LpglnLPOmZodZPTZTjRY5E4ssCtYVloOxdPpXR2jLdwQtAR0wfeEutktistu+xoLK
	 RjyTzEsmn+w/J2Ky3I+HoQvNDqohhExcGeLlhJRFCnRRVPX6AlrE6THYSs3XPzuwYg
	 GUC1l2g+fqU7af205uyWZhe/tpWfZhYj1alkg27Uw3e26ogd6nXx7/BzQMHDFDaG8u
	 qA5t8OyxR8Tr1Yjx3E5nMix3TqNuKSoGTo34yYZTklZjY8v+sabJrGwWE3beufbas/
	 OAQ+HOkG8yUl4/1qySycvyvHEEiW2iMKnWKQawyy2MAxVMUaZuES+jZPqufbRA/LZg
	 tHl32Nv6bK6ZA==
Date: Wed, 3 Apr 2024 17:01:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Edward Cree <ecree.xilinx@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>, Saeed Mahameed
 <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jiri Pirko
 <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>, Itay Avraham
 <itayavr@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Aron Silverton
 <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240403170149.7d2b8f2b@kernel.org>
In-Reply-To: <d75ee9d5-36a9-4056-a0f3-0c05b2e744aa@kernel.org>
References: <2024032248-ardently-ribcage-a495@gregkh>
	<510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
	<Zf2n02q0GevGdS-Z@C02YVCJELVCG>
	<20240322135826.1c4655e2@kernel.org>
	<e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
	<20240322154027.5555780a@kernel.org>
	<1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
	<0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
	<20240402184832.GO11187@unreal>
	<cefa2b9a-4227-969e-d31e-c19a552b9c1c@gmail.com>
	<20240403190012.GV11187@unreal>
	<d75ee9d5-36a9-4056-a0f3-0c05b2e744aa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2024 13:31:46 -0600 David Ahern wrote:
> > ... Patches aren't languishing for want of reviewer resources; it's just that it
> >  takes *submitter* time and effort to bring them up to the quality level
> >  that's required, and occasionally the vendor has to (shock! horror!)
> >  tell the world what one of their magic knobs actually *does*. ...
> > 
> > ^^^^ Content
> > This paragraph alone shows that you completely didn't understand the
> > discussion here.
> 
> +1

"didn't understand the discussion" is an ironic thing for you to +1,
David. After all my emails about HNS3 RDMA you somehow concluded today
that I want to make rules for the entire kernel:
https://lore.kernel.org/all/6faa47b0-27c3-47f9-94be-1ec671d9543c@kernel.org/

And I second what Ed said. I have asked multiple vendors preaching
impossibilism in this thread to start posting those knobs. I offered
to do a quick off-list review of the list of knobs they have to give 
a quick yay / nay, so they don't waste time implementing things that
would get nacked. None of the vendors bothered taking me up on that
offer.

