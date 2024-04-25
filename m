Return-Path: <linux-kernel+bounces-158769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF138B24AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD13E287DD9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8CE1494BC;
	Thu, 25 Apr 2024 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsmNNe9U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3993614A4D7;
	Thu, 25 Apr 2024 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057646; cv=none; b=M/Bnd/tFZ8/zfQlqttXXGO6H3Z67UJHRc6F0ZFOPujGl6oSkZhrEbE5dAtBZsKnhBNQx9jaKQRWc8vqSNaV4I09qD5MmjQGane+PMXGxait303fOmv+xX2faUMzX5pUjjcbhDeL36JthYj8XUmFdRpO0XxUyBFhaEG8ogDIelI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057646; c=relaxed/simple;
	bh=3HaJ982+LvRQFGm7HWvZdOyHnH1lP26jjUNa9dheZXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUjFxVQ95iyYOVPaZ6UonPiTddSc2VTx5uVvKJ2U/i1xQzQBgs6GKqe4i9/jrYtfCQouHDaABvid4VAsVYNT9PTQ6BRCQH55HqKSWOihUiQgOJ8/prCiKlSYBkQroNplYCe6unxohT7mhjJAmPT8QIxoumQXQHNFsphxaDvvqjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsmNNe9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B75AC113CC;
	Thu, 25 Apr 2024 15:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714057645;
	bh=3HaJ982+LvRQFGm7HWvZdOyHnH1lP26jjUNa9dheZXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HsmNNe9UozPgIPoy9mWGmNdUYAfB4O0PAx/pUcnAsQXUzlliouKJEEqjbk0w5rtlB
	 JBC/spq7bf3GCk3k0TSNEyR5/JtzMQvU+wJGkW7qMfIh8XE5k4IXfDVBENDm/TKs7W
	 Zz8L8NRmAhGXlJ1t608f26K5iaB9um6QjOgIbYOqBa6pSQTcyfcYxnmrVBcK/0iR2r
	 kjg8PaFJx0WkXT2JLcNK40MuHLRPRZ4lnsBirn9hB4PIfVnfIF+V3jDL4C6sZNdnqL
	 jyp5JQuC7pN9z+z5kBLcoCRsj/kLNd1GnrDj4j7wpHRodQpSHC4c9e267SZyA5QObZ
	 y5nkyvXN4KQiQ==
Date: Thu, 25 Apr 2024 08:07:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v3 0/3] net: pse-pd: Fixes for few small issues
Message-ID: <20240425080724.15be46e9@kernel.org>
In-Reply-To: <20240425165708.62637485@kmaincent-XPS-13-7390>
References: <20240423-fix_poe-v3-0-e50f32f5fa59@bootlin.com>
	<ZiebQLdu9dOh1v-T@nanopsycho>
	<20240425103110.33c02857@kmaincent-XPS-13-7390>
	<20240425070619.601d5e40@kernel.org>
	<20240425163002.5894c5e5@kmaincent-XPS-13-7390>
	<20240425074205.28677540@kernel.org>
	<20240425165708.62637485@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 16:57:08 +0200 Kory Maincent wrote:
> On Thu, 25 Apr 2024 07:42:05 -0700
> > > Do you want me to like post a v5 with the "pw-bot: cr" tag? But if I put the
> > > tag only on the cover letter it won't work then.
> > > Maybe on all patches?    
> > 
> > Probably not worth posting for a test. I'll try to be more careful when
> > applying in the future, we can experiment with real postings.
> >   
> > > Was it the same for the PoE support patch series?    
> > 
> > Yeah, I had to apply that one manually.  
> 
> Does this patch series is on the same state?
> https://lore.kernel.org/netdev/20240422-feature_ptp_netnext-v11-0-f14441f2a1d8@bootlin.com/

That one was fine:

https://patchwork.kernel.org/project/netdevbpf/cover/20240422-feature_ptp_netnext-v11-0-f14441f2a1d8@bootlin.com/

Are you thinking it's the extra From in the cover letter?

