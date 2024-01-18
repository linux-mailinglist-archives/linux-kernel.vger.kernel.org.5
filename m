Return-Path: <linux-kernel+bounces-29692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 125DB8311E4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 04:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F341C21C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB6963B5;
	Thu, 18 Jan 2024 03:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+Qu4P/7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ABC568B;
	Thu, 18 Jan 2024 03:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705549431; cv=none; b=LQlzcdlPnUrCNAsQ6TH0lq00ztHxD3uvI7S6aYHCRGyUKqU2zjyeM0o/W4DjvUsjFbOHLQ3MRQNcA1PfsBQuVDpTRsCfDL9J5GbKKGDqYvmWcR+e9tjTssfwMxL864B8BchL9OI+Q9N4Nud/57tcqKpYy6Y2o0a5naZnLkAFmqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705549431; c=relaxed/simple;
	bh=5we4N/QTc9CQm3qRCB+qD9bBssyR+XRbGzzp64rBYeI=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=JgXNQBqospZs+Kphsw9XoIfmPbBj9YIZkuB9fC8vYgddClr09vsTxT40smhlKQDAxjUGwascmSBjYVMhCevnvNeYnXZ6Xvm6TF6ls3x2npdbfUlMN/Gh8DU+3AFEoqU9pSmhPlnGkAqPfkMUdcQFGcN2plWOIfj+ynJBTPeJDjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+Qu4P/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DADC433C7;
	Thu, 18 Jan 2024 03:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705549431;
	bh=5we4N/QTc9CQm3qRCB+qD9bBssyR+XRbGzzp64rBYeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+Qu4P/7/z2hzBs6x1PgVoe7FZJaiikZLcrJjIJj3aiqXqWeYPoRMZA+bCcHsUFJJ
	 IshRqmJ2RZ1WCNkw/ZYqxTrZXB1/jk8yrkApfcYQSGZXzVFSq1b0ugTBOdxtUcBvEt
	 MeK1hWxzi+eUQz0URiPGV4fwdKMBaf6JMQrAe4c/oppN1cH/kXORek5DGB2qb1bsOB
	 Y2iKnVfzpTZVC6GAybz7x3WFAy0mcDFbv2LeKtTm1JHaSBPkFCsIJJxl5SLF0w51qq
	 LEJ7kfAuAqsrVAU25QWBO5SRT349Bti9wVQCYcEsWYeSq1iE1/RWH0Ra3m2TLW3kOe
	 zH1mT9Y+PALYQ==
Date: Wed, 17 Jan 2024 19:43:48 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gaurav Jain <gaurav.jain@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Horia Geanta <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>, Varun Sethi <V.Sethi@nxp.com>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	Aisheng Dong <aisheng.dong@nxp.com>,
	Silvano Di Ninno <silvano.dininno@nxp.com>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [EXT] Re: [PATCH] crypto: caam/hash - fix asynchronous hash
Message-ID: <20240118034348.GA1103@sol.localdomain>
References: <20240116094405.744466-1-gaurav.jain@nxp.com>
 <20240117043308.GA1137@sol.localdomain>
 <AM0PR04MB6004E3B9AB6DB6BE3F6BE48BE7722@AM0PR04MB6004.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB6004E3B9AB6DB6BE3F6BE48BE7722@AM0PR04MB6004.eurprd04.prod.outlook.com>

On Wed, Jan 17, 2024 at 10:48:39AM +0000, Gaurav Jain wrote:
> 
> 
> > -----Original Message-----
> > From: Eric Biggers <ebiggers@kernel.org>
> > Sent: Wednesday, January 17, 2024 10:03 AM
> > To: Gaurav Jain <gaurav.jain@nxp.com>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>; David S . Miller
> > <davem@davemloft.net>; Horia Geanta <horia.geanta@nxp.com>; Pankaj
> > Gupta <pankaj.gupta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Meenakshi
> > Aggarwal <meenakshi.aggarwal@nxp.com>; Aisheng Dong
> > <aisheng.dong@nxp.com>; Silvano Di Ninno <silvano.dininno@nxp.com>; linux-
> > crypto@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-imx <linux-
> > imx@nxp.com>
> > Subject: [EXT] Re: [PATCH] crypto: caam/hash - fix asynchronous hash
> > 
> > Caution: This is an external email. Please take care when clicking links or
> > opening attachments. When in doubt, report the message using the 'Report this
> > email' button
> > 
> > 
> > On Tue, Jan 16, 2024 at 03:14:05PM +0530, Gaurav Jain wrote:
> > > ahash_alg->setkey is updated to ahash_nosetkey in ahash.c so updating
> > > the handling of setkey in caam driver.
> > >
> > > Fixes: 2f1f34c1bf7b ("crypto: ahash - optimize performance when
> > > wrapping shash")
> > > Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
> > > ---
> > >  drivers/crypto/caam/caamalg_qi2.c | 4 ++--
> > >  drivers/crypto/caam/caamhash.c    | 4 ++--
> > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/crypto/caam/caamalg_qi2.c
> > > b/drivers/crypto/caam/caamalg_qi2.c
> > > index a148ff1f0872..93a400e286b4 100644
> > > --- a/drivers/crypto/caam/caamalg_qi2.c
> > > +++ b/drivers/crypto/caam/caamalg_qi2.c
> > > @@ -4571,7 +4571,7 @@ static int caam_hash_cra_init(struct crypto_tfm
> > > *tfm)
> > >
> > >       ctx->dev = caam_hash->dev;
> > >
> > > -     if (alg->setkey) {
> > > +     if (crypto_hash_alg_has_setkey(halg)) {
> > >               ctx->adata.key_dma = dma_map_single_attrs(ctx->dev, ctx->key,
> > >                                                         ARRAY_SIZE(ctx->key),
> > >                                                         DMA_TO_DEVICE,
> > > @@ -4611,7 +4611,7 @@ static int caam_hash_cra_init(struct crypto_tfm
> > *tfm)
> > >        * For keyed hash algorithms shared descriptors
> > >        * will be created later in setkey() callback
> > >        */
> > > -     return alg->setkey ? 0 : ahash_set_sh_desc(ahash);
> > > +     return crypto_hash_alg_has_setkey(halg) ? 0 :
> > > + ahash_set_sh_desc(ahash);
> > >  }
> > >
> > >  static void caam_hash_cra_exit(struct crypto_tfm *tfm) diff --git
> > > a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
> > > index 290c8500c247..4d50356b593c 100644
> > > --- a/drivers/crypto/caam/caamhash.c
> > > +++ b/drivers/crypto/caam/caamhash.c
> > > @@ -1804,7 +1804,7 @@ static int caam_hash_cra_init(struct crypto_tfm
> > *tfm)
> > >       } else {
> > >               if (priv->era >= 6) {
> > >                       ctx->dir = DMA_BIDIRECTIONAL;
> > > -                     ctx->key_dir = alg->setkey ? DMA_TO_DEVICE : DMA_NONE;
> > > +                     ctx->key_dir = crypto_hash_alg_has_setkey(halg)
> > > + ? DMA_TO_DEVICE : DMA_NONE;
> > >               } else {
> > >                       ctx->dir = DMA_TO_DEVICE;
> > >                       ctx->key_dir = DMA_NONE; @@ -1862,7 +1862,7 @@
> > > static int caam_hash_cra_init(struct crypto_tfm *tfm)
> > >        * For keyed hash algorithms shared descriptors
> > >        * will be created later in setkey() callback
> > >        */
> > > -     return alg->setkey ? 0 : ahash_set_sh_desc(ahash);
> > > +     return crypto_hash_alg_has_setkey(halg) ? 0 :
> > > + ahash_set_sh_desc(ahash);
> > >  }
> > >
> > 
> > Thanks.  Did you also consider putting something in struct caam_hash_alg (the
> > struct in which this driver embeds its ahash_alg structure) that indicates whether
> > the algorithm is an HMAC or not?  Other drivers use that solution.
> 
> Crypto/ahash.c has this API to check the setkey so I used to differentiate between HMAC & only hash.
> Let me know if this change is not sufficient, will add the flag in caam_hash_alg.
> 

Currently crypto_hash_alg_has_setkey() isn't used outside of crypto/ahash.c.
Since there's an alternative that matches what the other drivers do, I think I'd
prefer that you did that.  We can then make crypto_hash_alg_has_setkey() a
static function, private to crypto/ahash.c.

- Eric

