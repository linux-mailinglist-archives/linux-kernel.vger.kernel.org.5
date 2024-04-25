Return-Path: <linux-kernel+bounces-158576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9948B2257
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B821C21060
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8129F149C5E;
	Thu, 25 Apr 2024 13:15:19 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B691494B4;
	Thu, 25 Apr 2024 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714050919; cv=none; b=ZGRKCSqiRxja5a2BJl+sORzXisrpZVvojP04Ng+FdyoM3VTvmbEcKTeBSgeoNdZq6D9O+wWlzsdBUqg2cQPiN0LNlA3zWyL7xjFo0HGXIXoKFTYSERZ1Kx3TXd1ftXKaqI7PzOU0SlXh446/7OlYEk2o3F+ZC3zyKnMnjsWTmmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714050919; c=relaxed/simple;
	bh=a8oXnegoRuH7QSHKQT/j9X3v7gxfYFvlmdSHuZ9hPO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnM8YsQexV1J2+WDTqnylwTkUsQVhRJ8GpOm6yc6LPNBc1ohmo8PfeJToyfzxmprQei2dWP6sS+6WDbKGpGJlmf2hi7tA617V+yKJy5fh1eEZM//PTptPWVa4CwDKlZIT622nFI6Vi2WUKqVSc6Gz5MsVUoixp38uJb07/Qtazc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0B8FA68C4E; Thu, 25 Apr 2024 15:08:45 +0200 (CEST)
Date: Thu, 25 Apr 2024 15:08:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>
Subject: Re: API break, sysfs "capability" file
Message-ID: <20240425130844.GA6022@lst.de>
References: <ZhRSVSmNmb_IjCCH@gardel-login> <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com> <ZhT5_fZ9SrM0053p@gardel-login> <20240409141531.GB21514@lst.de> <d7a2b07c-26eb-4d55-8aa7-137168bd0b49@kernel.dk> <Zh6IpqnSfGHXMjVa@gardel-login> <b74f99e8-5a50-4e93-987f-0bcfc0c27959@kernel.dk> <Zh6KZ7ynHuOd0mgQ@gardel-login> <c3a6a639-bf15-4f8b-abbd-978d9836d93c@kernel.dk> <5ef0ac71-21dd-46d7-a0c1-1b1b391e51a8@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ef0ac71-21dd-46d7-a0c1-1b1b391e51a8@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 24, 2024 at 10:09:35AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> Jens, quick question: what's the plan forward here and who will realize
> what you outlined?
> 
> I'm asking, as afaics nothing happened for a week (hope I didn't miss
> anything!). Sure, it's not a regression from the last cycle or so, so
> it's not that urgent. But hch's "It is not a regression at all" last
> week made me worry that this in the end might not be solved unless
> somebody has it on the todo list. Normally I would have CCed Linus at
> that point anyway to get his stance, but from your statements it sounds
> like this is unnecessary here.

I'll get to adding a real interface in a bit.  Sorry, I've been
a little too busy the last days.


