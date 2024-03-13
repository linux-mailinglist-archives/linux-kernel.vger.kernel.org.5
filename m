Return-Path: <linux-kernel+bounces-101041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCF887A14A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982681F21CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCC9BE65;
	Wed, 13 Mar 2024 02:04:30 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93431BA27;
	Wed, 13 Mar 2024 02:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710295469; cv=none; b=E2F4ebrVV5Dxr0WAmw6OL6c6UjcrKIX3LefdCwnWWhsTk28qDk0h2ZWsDVyAuHRkXtX4QeMAlmuUDG62CBL+ywuWCzCUhM9os5pWzdQ5Vg/nECMvGTWLGnVbfQWrmcJmppjogJFpcyUFu3LZJ/RkAm+fhm4RE5MGLByuOHFbDzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710295469; c=relaxed/simple;
	bh=wDULuzZl+P6j63jB/yqzoKOth+kn4G3RbXkhT9MytsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NY11T9SBW2O6ncZg9MOWqDQCpf7m0FsoNgXSRFK9ni7LvMWY472SqepE2w4FKdEw6WiA1H0RnjiiP3nU985jKfWSVYznG0QoiyjEC27jKaeoorqgOgOZb06lVbm0HwUmxIqnTju7/U5IgBjF925UjD/gTdpaNGH+6O7Vp9Stva8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rkDyW-006LQl-Fp; Wed, 13 Mar 2024 10:04:13 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 13 Mar 2024 10:04:28 +0800
Date: Wed, 13 Mar 2024 10:04:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Linux Crypto List <linux-crypto@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the crypto tree
Message-ID: <ZfEJrBefjrvPxaIg@gondor.apana.org.au>
References: <20240313115751.36b01158@canb.auug.org.au>
 <ZfEE2GDznBOZDXs4@gondor.apana.org.au>
 <ZfEFKxl8/42oXv0i@gondor.apana.org.au>
 <20240313020112.GB1148@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313020112.GB1148@sol.localdomain>

On Tue, Mar 12, 2024 at 07:01:12PM -0700, Eric Biggers wrote:
>
> The only user of comp_alg_common was the crypto stats, and it was introduced by
> a refactoring of the crypto stats (commit 0a742389bcc0, "crypto: acomp - Count
> error stats differently"), so it seems appropriate to remove it for now.
> 
> If you could go through my patch and explain what other unused code related to
> the crypto stats you might consider to be "infrastructure" that should not be
> removed, that would be helpful.

The first patch should only remove code directly related to
STATS.  Any removal of code that is rendered useless should
be done in one or more subsequent patches.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

