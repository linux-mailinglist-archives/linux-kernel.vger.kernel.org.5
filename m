Return-Path: <linux-kernel+bounces-38137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F7383BB55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8413A2885A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEA21759E;
	Thu, 25 Jan 2024 08:10:58 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186981756B;
	Thu, 25 Jan 2024 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170257; cv=none; b=Tf7KUKiYU7LdSjdv+BxcOQw6kHqcEPueK3ThDfO+mj77Crt2aawUk5/J5zuMbIUhrKVCJG4Ws6ZJNk1J8XsBMor1hBpnkMheYaTwY9h+a+7Ho/9Z6pJ3AeJ65n5rsa7h1b7VaXyLiONoW1n5iVkRtXPRpOKtEIl0M+tp0pV7k8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170257; c=relaxed/simple;
	bh=cIdPxH2vkyKy+0ZVR3QifIcpYvOOFuiDKYqG8t4FD7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zl3VCUcA3RHLApiQUSxBbOB8JUFudJNQrPLnVNyIY45e62PoTnJr/pkDZ2tCgJea4SKkWNN5iTRPywfVOwtYd8LD7hHYPoOu9DIo/UQ6M5B+DYIBd7eB05s9/0UMopGOusAyM62coOTWGuKmuJv4Dl9ufEsPPya3kXNN7qJEPlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E75D667373; Thu, 25 Jan 2024 09:10:50 +0100 (CET)
Date: Thu, 25 Jan 2024 09:10:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	tj@kernel.org, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH, RFC] block: set noio context in
 submit_bio_noacct_nocheck
Message-ID: <20240125081050.GA21006@lst.de>
References: <20240124093941.2259199-1-hch@lst.de> <be690355-03c6-42e2-a13f-b593ad1c0edd@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be690355-03c6-42e2-a13f-b593ad1c0edd@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 24, 2024 at 08:40:28AM -0700, Jens Axboe wrote:
> On 1/24/24 2:39 AM, Christoph Hellwig wrote:
> > Make sure all in-line block layer submission runs in noio reclaim
> > context.  This is a big step towards allowing GFP_NOIO, the other
> > one would be to have noio (and nofs for that matter) workqueues for
> > kblockd and driver internal workqueues.
> 
> I really don't like adding this for no good reason. Who's doing non NOIO
> allocations down from this path?

If there is a non-NOIO allocation right now that would be a bug,
although I would not be surprised if we had a few of them.

The reason to add this is a different one:  The MM folks want to
get rid of GFP_NOIO and GFP_NOFS and replace them by these context.

And doing this in the submission path and kblockd will cover almost
all of the noio context, with the rest probably covered by other
workqueues.  And this feels a lot less error prone than requiring
every driver to annotate the context in their submission routines.

