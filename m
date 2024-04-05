Return-Path: <linux-kernel+bounces-132327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A9A899323
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874FC1C22543
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA81B14F6C;
	Fri,  5 Apr 2024 02:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PjC2XAxj"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337312B82
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 02:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712284035; cv=none; b=UuQDKBNNTkS5e/3dZgqja1bLwdyrz6S5HXaeEkKKVbFzI4HowDik7RiNfAIPq5/Y1YI+p/guhTlMEoZUSVv+MZc2f3wwMFYNra8F8ZkKeQJfg2GY0C6H/SSNu3JFLEx9DsuHAKuiycaSAlkRaXpNZVchQjidnRCDpiABRKr/o60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712284035; c=relaxed/simple;
	bh=NiS5deyMvevKlNkCo0sSnhd4ZIm3jHMnIcGkBixMHOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtlnsTXzmjG+zTiofoQ0Aj2VBigDMxO0Aw6J8LICXdhFM41R/HgTKuRDuVUSdZItqhAPiN1NZ0PhnZeb+IiepuHS9vTxJ1pXrt63MU/9tR08dqEQmEnkyzVIW1eywjnDjLUvbi3sLLaWuY/rZlyD+wNrkmYIFQtgMIAfxpU7sCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PjC2XAxj; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4352Qphf021537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Apr 2024 22:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1712284015; bh=recwD/IQWzE/0BMPOsDL3jZNvegzzgNj1gF0H+r6mNs=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=PjC2XAxj+KeDdXAOrm1O+Gtd9HoTbW7SWKp+Fzb1zGt15Byhbn0CEhyhnbChayawz
	 SPtJyycGkfuCqyugqw+QorL0w9qDItKOS1fZePAd0UBturG+UnPXqJvwsvC/NQKp9X
	 GtQ98StBPqed1u6nEzzuiJbigHchuH/OpmzGcWv4AsrgKjIWEjuy3PwaNrpbrWB/4S
	 0wMNSw8ZCbBWVgSrMeOWP/AisdkoaNYTb+4xig8qwHwLa8yRkwVWtGpr7aVAwIWomK
	 SOGms6fiUARYoaOi17duory7yeX3PmC5lNiKkSps/dNvXApcD650DnEOt4clurPcHc
	 cnBRFxihiUBAg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id CB38C15C00DE; Thu,  4 Apr 2024 22:26:51 -0400 (EDT)
Date: Thu, 4 Apr 2024 22:26:51 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Mikhail Ukhin <mish.uxin2012@yandex.ru>
Cc: stable@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michail Ivanov <iwanov-23@bk.ru>,
        Pavel Koshutin <koshutin.pavel@yandex.ru>,
        Artem Sadovnikov <ancowi69@gmail.com>
Subject: Re: [PATCH] ext4: fix i_data_sem unlock order in ext4_ind_migrate()
Message-ID: <20240405022651.GB13376@mit.edu>
References: <20240404095000.5872-1-mish.uxin2012@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404095000.5872-1-mish.uxin2012@yandex.ru>

On Thu, Apr 04, 2024 at 12:50:00PM +0300, Mikhail Ukhin wrote:
> Fuzzing reports a possible deadlock in jbd2_log_wait_commit.
> 
> The problem occurs in ext4_ind_migrate due to an incorrect order of
> unlocking of the journal and write semaphores - the order of unlocking
> must be the reverse of the order of locking.
> 
> Found by Linux Verification Center (linuxtesting.org) with syzkaller.

This doesn't make any sense.  Lock order matters; the order in which
you unlock shouldn't (and doesn't) make a difference.  This is also
something which lockdep doesn't complain about --- because it's not a
problem.

So how was this "found by syzkaller"?

					- Ted

