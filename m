Return-Path: <linux-kernel+bounces-8261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A1581B4A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABCEE1F25E1E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B365D6BB51;
	Thu, 21 Dec 2023 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUoPh49m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015176BB29;
	Thu, 21 Dec 2023 11:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B35C433C7;
	Thu, 21 Dec 2023 11:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703156672;
	bh=TDLMCFaG9iF23iCXhZOU0JoIuuWfRNEqblfM8hy8xvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EUoPh49m8aTvyeCHkfDHfKZrqlD/vPcrGAerxnsdXEcMdnehbZ3ZEedRcT1OtQ2J/
	 hJRc3dC2F3YN3nyu2jmduA/FVttZ1TTXkHraK5E6+QdibhLxoKuA98BGE4VsVwJCCV
	 qj1VT5X1K4Tq4yugwZRBHpi9q5FRsdaxYACIA/m+jdWCYe3wH9g7OCUcsto03Xryio
	 Uz/ws5qB2TKkbDVBQZ9fK1ycCAsVvyepgD713pQ5nCYHsG0wjwoPR19xkWk80gsVc9
	 SUr1+j24/QRRKO0orl6aDu4DFOcLKqm9u2/qNugYpjZuYKVR7d9/ZOlk4Mfz5Ybrvm
	 jp4IMblXnLNdg==
Date: Thu, 21 Dec 2023 11:04:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: pressure: honeywell,mprls0025pa
Message-ID: <20231221110417.0bd5b002@jic23-huawei>
In-Reply-To: <ZYMjhfAbWfw9vUdd@sunspire>
References: <20231219130230.32584-1-petre.rodan@subdimension.ro>
	<20231219130230.32584-2-petre.rodan@subdimension.ro>
	<20231220151645.16ada807@jic23-huawei>
	<ZYMjhfAbWfw9vUdd@sunspire>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 19:25:25 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> hi Jonathan,
> 
> On Wed, Dec 20, 2023 at 03:16:45PM +0000, Jonathan Cameron wrote:
> > On Tue, 19 Dec 2023 15:02:20 +0200
> > Petre Rodan <petre.rodan@subdimension.ro> wrote:  
> > >    honeywell,pmin-pascal:
> > >      description:
> > >        Minimum pressure value the sensor can measure in pascal.
> > > +      To be specified only if honeywell,pressure-triplet is set to "NA".  
> > That just added a backwards compatibility break.  It would be fine
> > if there was a default: NA for honeywell,pressure-triplet or a check that either
> > one or the other was supplied (which I'd prefer).  Thus old bindings will work
> > and new ones also supported.  
> 
> ok, I see your reasoning. but in this second scenario that you prefer how can we
> propery define the 'required:' block? an equivalent to
> 
> required:
>   - compatible
>   - reg
>   - (honeywell,pmin-pascal && honeywell,pmax-pascal) || honeywell,pressure-triplet
>   - honeywell,transfer-function

Yes, it would end up something like that.  There are exclusive or examples in tree.
I think something like dac/adi,ad3552r.yaml
 should work.

oneOf:
  - required:
      - honeywell,pmin-pascal
      - honeywell,pmax-pascal
  - required:
      - honeywell,pressure-triplet

but you will want to try all the cases to make sure that works (my ability to
figure these ones out is tricky).

+ you ideally want to exclude them all being set which is fiddlier.

Some similar examples but they are based on a value in the property. I'm not
sure how you check for it just being defined.

Something along lines of.

allOf:
  - if:
      properties:
        honeywell,pressure-triplet
    then:
      properties:
        honeywell,pmin-pascal: false
        honeywell,pmax-pascal: false

Might work?  I always end up trawling the kernel to find a similar example for cases but
can't find anything closer right now.

Jonathan

   



> 
> 
> thanks,
> peter


