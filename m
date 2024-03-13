Return-Path: <linux-kernel+bounces-102489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E713F87B2D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6EF1F23865
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B3A524BE;
	Wed, 13 Mar 2024 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFlAHNW2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5927051005;
	Wed, 13 Mar 2024 20:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710361346; cv=none; b=kyD7y5f7Tjk7xgCP3NY/hdSUlVyDownKKnWFghgUuZx+7k9hJKmz7FpsV00CSkCc2HxLHkStEk8SwDg9udejT5HECjBR/l16OVYWliS20oODtBwhpAUyUkA3NuXmt/QjN2ReN3lfbLqrrfKUoKpkNWuIryDJ+iOw8UtlLCJId2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710361346; c=relaxed/simple;
	bh=rgukJbYU+P6pCiW7WPZ0odGPFMvz8t4VPdQBD930lsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bhu9IkpsssbsjbQA2KLKAEHwwCXU7B48lDfe4rqEWUQS0OtdMJlR+aGA1o0Zcc2nEl18n3zKrSU2aIeVMqeVQsCImF3Z+UFdahS1Qcf/E+Q0J/aX8jVdfJ6WVWEPzqpz73iQCLsFUHKmUP1bmF8L+TMgHx4/XWQy6ZrgSDDz4F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFlAHNW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA20C433F1;
	Wed, 13 Mar 2024 20:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710361345;
	bh=rgukJbYU+P6pCiW7WPZ0odGPFMvz8t4VPdQBD930lsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFlAHNW2U31SD7nKmJI4b7+wEklDjsk/bQ8BQxWUr206VF6u/NDhARmY7EwziZWHL
	 uJgVdR0u8oJWsY9qOkLBXcvaQbnOCHpSwkW+0tZNeu7an3CwLwVzuJ8M3ZXzQGhx6r
	 pN78QKRGcle4kw748mX/YLsb8xJuqGGiXJ5o+YimikW5hqKEQw2jh7UKz5fxbIBaeV
	 FjN4xBzuITH1CzB8PEfUlA9uicYznEVUw9SW7+8ZZuIantuoR49VinlAU4aSSf8wHo
	 y83rkovNZggjXEvqkM53hVvea0wF74bMh7LULVEAK1qIy+KmP1EihrCLfs61vEqTfZ
	 GCDKedIzuPVWg==
Date: Wed, 13 Mar 2024 13:22:23 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: James Prestwood <prestwoj@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Karel Balej <balejk@matfyz.cz>, dimitri.ledkov@canonical.com,
	alexandre.torgue@foss.st.com, davem@davemloft.net,
	dhowells@redhat.com, herbert@gondor.apana.org.au,
	keyrings@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, mcgrof@kernel.org,
	mcoquelin.stm32@gmail.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, iwd@lists.linux.dev
Subject: Re: [REGRESSION] Re: [PATCH] crypto: pkcs7: remove sha1 support
Message-ID: <20240313202223.GB1111@sol.localdomain>
References: <CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz>
 <005f998ec59e27633b1b99fdf929e40ccfd401c1.camel@sipsolutions.net>
 <f2dcbe55-0f0e-4173-8e21-f899c6fc802a@gmail.com>
 <20240313194423.GA1111@sol.localdomain>
 <b838e729-dc30-4e18-b928-c34c16b08606@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b838e729-dc30-4e18-b928-c34c16b08606@gmail.com>

On Wed, Mar 13, 2024 at 01:12:54PM -0700, James Prestwood wrote:
> Hi,
> 
> On 3/13/24 12:44 PM, Eric Biggers wrote:
> > On Wed, Mar 13, 2024 at 10:26:06AM -0700, James Prestwood wrote:
> > > Hi,
> > > 
> > > On 3/13/24 1:56 AM, Johannes Berg wrote:
> > > > Not sure why you're CC'ing the world, but I guess adding a few more
> > > > doesn't hurt ...
> > > > 
> > > > On Wed, 2024-03-13 at 09:50 +0100, Karel Balej wrote:
> > > > >    and I use iwd
> > > > This is your problem, the wireless stack in the kernel doesn't use any
> > > > kernel crypto code for 802.1X.
> > > Yes, the wireless stack has zero bearing on the issue. I think that's what
> > > you meant by "problem".
> > > 
> > > IWD has used the kernel crypto API forever which was abruptly broken, that
> > > is the problem.
> > > 
> > > The original commit says it was to remove support for sha1 signed kernel
> > > modules, but it did more than that and broke the keyctl API.
> > > 
> > Which specific API is iwd using that is relevant here?
> > I cloned https://kernel.googlesource.com/pub/scm/network/wireless/iwd
> > and grepped for keyctl and AF_ALG, but there are no matches.
> 
> IWD uses ELL for its crypto, which uses the AF_ALG API:
> 
> https://git.kernel.org/pub/scm/libs/ell/ell.git/

Thanks for pointing out that the relevant code is really in that separate
repository.  Note, it seems that keyctl() is the problem here, not AF_ALG.  The
blamed commit didn't change anything for AF_ALG.

> I believe the failure is when calling:
> 
> KEYCTL_PKEY_QUERY enc="x962" hash="sha1"
> 
> From logs Michael posted on the IWD list, the ELL API that fails is:
> 
> l_key_get_info (ell.git/ell/key.c:416)

Okay, I guess that's what's actually causing the problem.  KEYCTL_PKEY_* are a
weird set of APIs where userspace can ask the kernel to do asymmetric key
operations.  It's unclear why they exist, as the same functionality is available
in userspace crypto libraries.

I suppose that the blamed commit, or at least part of it, will need to be
reverted to keep these weird keyctls working.

For the future, why doesn't iwd just use a userspace crypto library such as
OpenSSL?

- Eric

