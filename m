Return-Path: <linux-kernel+bounces-147982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9638A7C22
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5765B2189F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915E956464;
	Wed, 17 Apr 2024 06:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7Uh4jyw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFACE535C1;
	Wed, 17 Apr 2024 06:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713334411; cv=none; b=BdDTtBxTd1nAJTcbtNuxTIlSDNKgAuxRG3zDx6kF+MT9h2wyRJTHmfQzurd4XJvbcxgjc91qYOfYCSXJZCQZWKRhdsO4X8t9FcuiOu0JZGWrW6N38OVTOWEYAitSaWvohqkSAj1TwyU/JwWjtiaL2jifBlqxzoiP/5K6kQoEXrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713334411; c=relaxed/simple;
	bh=bNB/eXY6+dVydFykPDb6ff7M3Qgc4QuYt3c4o86sTV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkuMIA98mDjjJ4cXgBJ4DMMvQ/lfErZ82nAYndEmt6Ieb2v0ycWAo7ajuhXIG3gDDtmyjtgRPB8xT0pcECswhH+uSKlO0DRZwKv397bwQsNF8QfOro0D8Lf1UknozDLXBguWWA2l0QboXtyIHFyIXYkmVdEVl+XPtpaJ+2rThr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7Uh4jyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F70C072AA;
	Wed, 17 Apr 2024 06:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713334411;
	bh=bNB/eXY6+dVydFykPDb6ff7M3Qgc4QuYt3c4o86sTV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7Uh4jywnTRLlqySQBcH71lozr0vn69p7OB6uqY8Lm959SIjLjUxiQx3HanfAuLjf
	 m3j5LKAnHYbpokiMZfyzDk8krqmwEfqM4aCPZEuMgx6KPrBxhnX8N1qAUsRESu6gDo
	 LCG8H3oxaU/MsZtycSk8a2AvmglPOXdlQVBb63ZoXtqnwqMrZSDaoVvv8XWoz+vrx6
	 /iNuFG7LqHcRr0Cvj9K0Br+W14I7Pio/p27ibfSaUSNBOqpgyrq4DYKkBQsZmQfNbf
	 5U4rKFfk+0eK0QmhzpqetlB9nv6L1Qrh0oVq+TEO+0KSDgLzi8DKabGR+1WzIzlXz6
	 m6rCvpGGhOMrQ==
Date: Tue, 16 Apr 2024 23:13:29 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Mothershead, Hailey" <hailmo@amazon.com>
Cc: "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] crypto: aead, cipher - zeroize key buffer after
 use
Message-ID: <20240417061329.GA47903@quark.localdomain>
References: <20240415221915.20701-1-hailmo@amazon.com>
 <20240415224942.GC5206@sol.localdomain>
 <45EEAC43-DC21-4B79-BE9A-9876A8C59269@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45EEAC43-DC21-4B79-BE9A-9876A8C59269@amazon.com>

On Tue, Apr 16, 2024 at 07:14:28PM +0000, Mothershead, Hailey wrote:
> > On 4/15/24, 3:50 PM, "Eric Biggers" <ebiggers@kernel.org <mailto:ebiggers@kernel.org>> wrote:
> >
> > On Mon, Apr 15, 2024 at 10:19:15PM +0000, Hailey Mothershead wrote:
> > > I.G 9.7.B for FIPS 140-3 specifies that variables temporarily holding
> > > cryptographic information should be zeroized once they are no longer
> > > needed. Accomplish this by using kfree_sensitive for buffers that
> > > previously held the private key.
> > >
> > > Signed-off-by: Hailey Mothershead <hailmo@amazon.com <mailto:hailmo@amazon.com>>
> > > ---
> > > crypto/aead.c | 3 +--
> > > crypto/cipher.c | 3 +--
> > > 2 files changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/crypto/aead.c b/crypto/aead.c
> > > index 16991095270d..c4ece86c45bc 100644
> > > --- a/crypto/aead.c
> > > +++ b/crypto/aead.c
> > > @@ -35,8 +35,7 @@ static int setkey_unaligned(struct crypto_aead *tfm, const u8 *key,
> > > alignbuffer = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
> > > memcpy(alignbuffer, key, keylen);
> > > ret = crypto_aead_alg(tfm)->setkey(tfm, alignbuffer, keylen);
> > > - memset(alignbuffer, 0, keylen);
> > > - kfree(buffer);
> > > + kfree_sensitive(buffer);
> > > return ret;
> > > }
> > >
> > > diff --git a/crypto/cipher.c b/crypto/cipher.c
> > > index b47141ed4a9f..395f0c2fbb9f 100644
> > > --- a/crypto/cipher.c
> > > +++ b/crypto/cipher.c
> > > @@ -34,8 +34,7 @@ static int setkey_unaligned(struct crypto_cipher *tfm, const u8 *key,
> > > alignbuffer = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
> > > memcpy(alignbuffer, key, keylen);
> > > ret = cia->cia_setkey(crypto_cipher_tfm(tfm), alignbuffer, keylen);
> > > - memset(alignbuffer, 0, keylen);
> > > - kfree(buffer);
> > > + kfree_sensitive(buffer);
> > > return ret;
> >
> >
> > Well, the memset()s that you're removing already did the zeroization. This
> > patch seems worthwhile as a code simplification, but please don't characterize
> > it as a bug fix, because it's not.
> >
> >
> > - Eric
> 
> kfree_sensitive uses memzero_explicit() instead of the memset()s used
> above. The memzero_explicit header states -
> 
> * Note: usually using memset() is just fine (!), but in cases
> * where clearing out _local_ data at the end of a scope is
> * necessary, memzero_explicit() should be used instead in
> * order to prevent the compiler from optimising away zeroing.
> 
> It accomplishes this by calling memset() and then adding a barrier. Since
> FIPS requires this data be zeroed out, and the current memset() and
> kfree() don't guarantee this, I do not think the commit message is
> misleading. I can clarify the message with the above information if that
> is preferred.
> 

It's heap data, not local data.  So no, memzero_explicit() isn't actually needed
here.  It would convey the intent better, but it's not actually needed.

- Eric

