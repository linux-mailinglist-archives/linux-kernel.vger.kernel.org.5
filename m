Return-Path: <linux-kernel+bounces-41080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B645D83EB77
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 07:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4FF28509D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 06:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCCA1C2BE;
	Sat, 27 Jan 2024 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkfQKElm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4D613AF8;
	Sat, 27 Jan 2024 06:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706337743; cv=none; b=eSJqdv+lwhp9FIuJUq1HODnKHW782mc/LpFyIwDy2jh6vaHk5/Ei0vVYwuzWKKejqJGWNU/KU66RddzV3dxx9P90a7WFKCQGUGRLA4/HCB+yCykOY8ksEMC07IiqsGMAWaspVMRtBpUoc4+KY6kqaLhUq2MKa2MdSe+D/f1eiAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706337743; c=relaxed/simple;
	bh=IboJjtM8+aiUS1B3v/h57FFTJzkV85q46CFAA+8EypI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPEa5dnXw7SICEnbRVfOUaTEkjtywDRe04EOsOxvYdyZLb+CLjjRzuACz4c6l6+kLCw69a1MdzLu4zx62Vf+JSAukNiT3zDlB8vPCPUWJrhqBjIzs6lEcbTzSIkzG8He0khqHbHqmtYYEUQpem962vxcMYi3U0zJrFTJTHGl/ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkfQKElm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798AFC433C7;
	Sat, 27 Jan 2024 06:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706337742;
	bh=IboJjtM8+aiUS1B3v/h57FFTJzkV85q46CFAA+8EypI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FkfQKElmLDcWiAow65S2qxSa9FVhfowWB9cg/+2wRk8/nmI2MYf9HaqnD1/S9F3R/
	 hRTWlFoWQsaiF+E/lupLdKaTFOgbBNWSK0mUP0qRG2D7Efxz7l9mXFN9JTEDsbjSkX
	 CVXrbN97MWOc3Q4+Ej6Z04cdmcwve8JGYadsI12Tw7yJzlKvbb4kL8g4fVfnpaNEiS
	 5Sfcci2+iFnXFgCsx/Qrzr4UTEq7prPNkqgp579JLGBcukPCoAre8P8Lx7TRf8fMx9
	 DUNV3ihqUs8BmPLEkEvt6OYcJermQG31cDKeNInHWZx43vzG4C98yBwxMO0rN1tPXL
	 FoTN867jrE40w==
Date: Fri, 26 Jan 2024 22:42:20 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Luis Henriques <lhenriques@suse.de>
Cc: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] keys: update key quotas in key_put()
Message-ID: <20240127064220.GB11935@sol.localdomain>
References: <2744563.1702303367@warthog.procyon.org.uk>
 <20240115120300.27606-1-lhenriques@suse.de>
 <20240124221225.GD1088@sol.localdomain>
 <87bk988450.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk988450.fsf@suse.de>

On Fri, Jan 26, 2024 at 04:12:59PM +0000, Luis Henriques wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
> > On Mon, Jan 15, 2024 at 12:03:00PM +0000, Luis Henriques wrote:
> >> Delaying key quotas update when key's refcount reaches 0 in key_put() has
> >> been causing some issues in fscrypt testing.  This patches fixes this test
> >> flakiness by dealing with the quotas immediately, but leaving all the other
> >> clean-ups to the key garbage collector.  Unfortunately, this means that we
> >> also need to switch to the irq-version of the spinlock that protects quota.
> >> 
> >> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> >> ---
> >> Hi David!
> >> 
> >> I have these changes in my local disk for a while; I wanted to send them
> >> before EOY break but... yeah, it didn't happen.  Anyway, I'm still sending
> >> it as an RFC as I'm probably missing something.
> >> 
> >>  security/keys/gc.c     |  8 --------
> >>  security/keys/key.c    | 32 ++++++++++++++++++++++----------
> >>  security/keys/keyctl.c | 11 ++++++-----
> >>  3 files changed, 28 insertions(+), 23 deletions(-)
> >
> > This patch seems reasonable to me, though I'm still thinking about changing
> > fs/crypto/ to manage its key quotas itself which would avoid the issue entirely.
> >
> > Note that as I said before, fs/crypto/ does key_put() on a whole keyring at
> > once, in order to release the quota of the keys in the keyring.  Do you plan to
> > also change fs/crypto/ to keyring_clear() the keyring before putting it?
> > Without that, I don't think the problem is solved, as the quota release will
> > still happen asynchronously due to the keyring being cleared asynchronously.
> 
> Ah, good point.  In the meantime I had forgotten everything about this
> code and missed that.  So, I can send another patch to fs/crypto to add
> that extra call once (or if) this patch is accepted.
> 
> If I'm reading the code correctly, the only place where this extra call is
> required is on fscrypt_put_master_key():
> 
> diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
> index 0edf0b58daa7..4afd32f1aed9 100644
> --- a/fs/crypto/keyring.c
> +++ b/fs/crypto/keyring.c
> @@ -74,6 +74,7 @@ void fscrypt_put_master_key(struct fscrypt_master_key *mk)
>  	 * that concurrent keyring lookups can no longer find it.
>  	 */
>  	WARN_ON_ONCE(refcount_read(&mk->mk_active_refs) != 0);
> +	keyring_clear(mk->mk_users);
>  	key_put(mk->mk_users);
>  	mk->mk_users = NULL;

This will need a NULL check, since keyring_clear() doesn't accept NULL:

	if (mk->mk_users) {
		keyring_clear(mk->mk_users);
		key_put(mk->mk_users);
		mk->mk_users = NULL;
	}

>  	call_rcu(&mk->mk_rcu_head, fscrypt_free_master_key);
> 
> On the other hand, if you're really working towards dropping this code
> entirely, maybe there's not point doing that.

Well, it depends whether this patch (the one for security/keys/) is accepted or
not.  If it's accepted, I think it makes sense to add the keyring_clear() and
otherwise keep the fs/crypto/ code as-is.  If it's not accepted, I think I'll
have to make fs/crypto/ handle the quotas itself.

- Eric

