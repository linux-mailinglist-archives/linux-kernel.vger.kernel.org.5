Return-Path: <linux-kernel+bounces-37731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD6483B488
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252B61F22523
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5022B135A41;
	Wed, 24 Jan 2024 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnylZEIr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D87135406;
	Wed, 24 Jan 2024 22:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706134348; cv=none; b=beV3UGoIy0O/53tdGMDJERaBAIN3QCqa4R6+tVvSBGaVqF5sXiX/ODpEXst+rO0+f/OIwSvEZNdINGR0lxG9qWXPJg6hA5StMbs2j8M7icEv2SWYQHKUs3mWd2astqMuCS92ss5P+gN/HXujGDjwywVdWX6mzYJzRsLy2nF17Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706134348; c=relaxed/simple;
	bh=gc13NGs1cozYsps1K1Aw7bZhty0AXw1eubkb+LJzZZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcFp7WanWZkmuPnZrBXLFsfwhUMN9v+VjNLA3Ie89QLcizLLtYr/MmXoSN14BWo7S9m73SdeE5LXV6ypTf3Lzeu1yezkDr7Ll1A7It1wFAUTNp+5aU+V5pYSkLFz8ywNfMICk6bFi7iI0IxgDt7Hgz1e9iL88hJhc0t/WX7gQeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnylZEIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC775C433C7;
	Wed, 24 Jan 2024 22:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706134348;
	bh=gc13NGs1cozYsps1K1Aw7bZhty0AXw1eubkb+LJzZZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DnylZEIrzTT5YlkpQFG0beg+X37lzo9YLQA68KJZNFySMJy+Yai3KtMhCAB7RFZMO
	 46i0C2iQTyLvzzKYHWCmjSZE15Kot2WAsI84EJUbpgHxi4Ft6D22HUi/bCxDsyJdXC
	 2KdTQp9fMGGs5/lXOenlMuv+dbg921lE5ofaTi8HHPH1+jcQIoyCSIHXmPV0Moe5nG
	 im2jNUZeHol1xO8QpNKjnzc/UzwHfpt+iSq2WT5PrWnD3oarKi4QGhzg1/DWqD1ZCZ
	 f0Js5fOa9AjdJlszpBGSom1WNZqCl1zlz3RtX2MVzEHxkEUYDxwdAvUEm3HAUCeXaN
	 Lit3HSibP79Dg==
Date: Wed, 24 Jan 2024 14:12:25 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Luis Henriques <lhenriques@suse.de>
Cc: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] keys: update key quotas in key_put()
Message-ID: <20240124221225.GD1088@sol.localdomain>
References: <2744563.1702303367@warthog.procyon.org.uk>
 <20240115120300.27606-1-lhenriques@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115120300.27606-1-lhenriques@suse.de>

On Mon, Jan 15, 2024 at 12:03:00PM +0000, Luis Henriques wrote:
> Delaying key quotas update when key's refcount reaches 0 in key_put() has
> been causing some issues in fscrypt testing.  This patches fixes this test
> flakiness by dealing with the quotas immediately, but leaving all the other
> clean-ups to the key garbage collector.  Unfortunately, this means that we
> also need to switch to the irq-version of the spinlock that protects quota.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---
> Hi David!
> 
> I have these changes in my local disk for a while; I wanted to send them
> before EOY break but... yeah, it didn't happen.  Anyway, I'm still sending
> it as an RFC as I'm probably missing something.
> 
>  security/keys/gc.c     |  8 --------
>  security/keys/key.c    | 32 ++++++++++++++++++++++----------
>  security/keys/keyctl.c | 11 ++++++-----
>  3 files changed, 28 insertions(+), 23 deletions(-)

This patch seems reasonable to me, though I'm still thinking about changing
fs/crypto/ to manage its key quotas itself which would avoid the issue entirely.

Note that as I said before, fs/crypto/ does key_put() on a whole keyring at
once, in order to release the quota of the keys in the keyring.  Do you plan to
also change fs/crypto/ to keyring_clear() the keyring before putting it?
Without that, I don't think the problem is solved, as the quota release will
still happen asynchronously due to the keyring being cleared asynchronously.

- Eric

