Return-Path: <linux-kernel+bounces-102647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AE987B54D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966981C20E41
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ABE5D917;
	Wed, 13 Mar 2024 23:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kf54dss+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9C81E480;
	Wed, 13 Mar 2024 23:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710373217; cv=none; b=OqJAynWQSGqbNRIbp1p4hq3zmGGrt9Eiw19RCKYemPJb0jR0cK+eSAhvuoUIGiQYYt2n7dsyDP1Sjw5IOZ8Iu3XnWvJjq7gOpcCV/w4PJLm/BcvYlsBD49ovd499zW2JWEPJ5qnbNGSQHT2N24+ZTBOvG9My0lhMPJB3Oqb80aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710373217; c=relaxed/simple;
	bh=bBevQkb7YPP8eKXiiVLEbs+eoJqadIbqmY4sDTHH91U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzNwIHHTTbEkqXV+MFktPijoS2fyqoHIIJK+I30RXywPqwJC34fk3inh17Adj86wcFjEDQQ38pydss2hGhn0e22hhK1Xx80pMEQpT3e4iVpBTtw409ocWRc7IG+qWOPkkUShPHHR+AHnK3rWyHPFFzoPC1EIfma5AjhROuI3smI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kf54dss+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0878DC433F1;
	Wed, 13 Mar 2024 23:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710373216;
	bh=bBevQkb7YPP8eKXiiVLEbs+eoJqadIbqmY4sDTHH91U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kf54dss+n/ABSmoGiqBZk5BGhEFnb/GVhwE2XJSpcFjDV7sBDNotMk3B2fbqiBjjb
	 6PZKh0HevT03rhSPcYkuHOQmCx0/PKSxXdZnDhkBhhZd+2N56JPzid+hqVNHRayKkI
	 FnBmZuzjOnx+cZI7f68vVrx2QrYuOegAUpbCQs79vu+ScEo7OOiI6xx5CBa/B+Y5kk
	 6mNZHQ62LXYkvqbrYdncoh3+K23s8oYm58gIcq69VAlDtjgqrvDR8XDPF6XmTwob4m
	 gXTOGVN1zNt2Nefl5ThAvxHg4csNsah8RiP/eN2/zcYe5K+58NJT0P3ER8XDrbx9oR
	 g1QCsE91bTI2w==
Date: Wed, 13 Mar 2024 16:40:14 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: James Prestwood <prestwoj@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
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
Message-ID: <20240313234014.GE1111@sol.localdomain>
References: <CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz>
 <005f998ec59e27633b1b99fdf929e40ccfd401c1.camel@sipsolutions.net>
 <f2dcbe55-0f0e-4173-8e21-f899c6fc802a@gmail.com>
 <20240313194423.GA1111@sol.localdomain>
 <b838e729-dc30-4e18-b928-c34c16b08606@gmail.com>
 <20240313202223.GB1111@sol.localdomain>
 <db86cba4-0e61-441d-8e66-405a13b61a3c@gmail.com>
 <20240313221043.GC1111@sol.localdomain>
 <f0492c92-1015-48e3-bfce-598c7a4843d1@quicinc.com>
 <20240313230611.GD1111@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240313230611.GD1111@sol.localdomain>

On Wed, Mar 13, 2024 at 04:06:11PM -0700, Eric Biggers wrote:
> On Wed, Mar 13, 2024 at 03:51:10PM -0700, Jeff Johnson wrote:
> > On 3/13/2024 3:10 PM, Eric Biggers wrote:
> > > On Wed, Mar 13, 2024 at 02:17:29PM -0700, James Prestwood wrote:
> > >> Hi,
> > >>
> > >> On 3/13/24 1:22 PM, Eric Biggers wrote:
> > >>> On Wed, Mar 13, 2024 at 01:12:54PM -0700, James Prestwood wrote:
> > >>>> Hi,
> > >>>>
> > >>>> On 3/13/24 12:44 PM, Eric Biggers wrote:
> > >>>>> On Wed, Mar 13, 2024 at 10:26:06AM -0700, James Prestwood wrote:
> > >>>>>> Hi,
> > >>>>>>
> > >>>>>> On 3/13/24 1:56 AM, Johannes Berg wrote:
> > >>>>>>> Not sure why you're CC'ing the world, but I guess adding a few more
> > >>>>>>> doesn't hurt ...
> > >>>>>>>
> > >>>>>>> On Wed, 2024-03-13 at 09:50 +0100, Karel Balej wrote:
> > >>>>>>>>     and I use iwd
> > >>>>>>> This is your problem, the wireless stack in the kernel doesn't use any
> > >>>>>>> kernel crypto code for 802.1X.
> > >>>>>> Yes, the wireless stack has zero bearing on the issue. I think that's what
> > >>>>>> you meant by "problem".
> > >>>>>>
> > >>>>>> IWD has used the kernel crypto API forever which was abruptly broken, that
> > >>>>>> is the problem.
> > >>>>>>
> > >>>>>> The original commit says it was to remove support for sha1 signed kernel
> > >>>>>> modules, but it did more than that and broke the keyctl API.
> > >>>>>>
> > >>>>> Which specific API is iwd using that is relevant here?
> > >>>>> I cloned https://kernel.googlesource.com/pub/scm/network/wireless/iwd
> > >>>>> and grepped for keyctl and AF_ALG, but there are no matches.
> > >>>> IWD uses ELL for its crypto, which uses the AF_ALG API:
> > >>>>
> > >>>> https://git.kernel.org/pub/scm/libs/ell/ell.git/
> > >>> Thanks for pointing out that the relevant code is really in that separate
> > >>> repository.  Note, it seems that keyctl() is the problem here, not AF_ALG.  The
> > >>> blamed commit didn't change anything for AF_ALG.
> > >>>
> > >>>> I believe the failure is when calling:
> > >>>>
> > >>>> KEYCTL_PKEY_QUERY enc="x962" hash="sha1"
> > >>>>
> > >>>>  From logs Michael posted on the IWD list, the ELL API that fails is:
> > >>>>
> > >>>> l_key_get_info (ell.git/ell/key.c:416)
> > >>> Okay, I guess that's what's actually causing the problem.  KEYCTL_PKEY_* are a
> > >>> weird set of APIs where userspace can ask the kernel to do asymmetric key
> > >>> operations.  It's unclear why they exist, as the same functionality is available
> > >>> in userspace crypto libraries.
> > >>>
> > >>> I suppose that the blamed commit, or at least part of it, will need to be
> > >>> reverted to keep these weird keyctls working.
> > >>>
> > >>> For the future, why doesn't iwd just use a userspace crypto library such as
> > >>> OpenSSL?
> > >>
> > >> I was not around when the original decision was made, but a few reasons I
> > >> know we don't use openSSL:
> > >>
> > >>  - IWD has virtually zero dependencies.
> > > 
> > > Depending on something in the kernel does not eliminate a dependency; it just
> > > adds that particular kernel UAPI to your list of dependencies.  The reason that
> > > we're having this discussion in the first place is because iwd is depending on
> > > an obscure kernel UAPI that is not well defined.  Historically it's been hard to
> > > avoid "breaking" changes in these crypto-related UAPIs because of the poor
> > > design where a huge number of algorithms are potentially supported, but the list
> > > is undocumented and it varies from one system to another based on configuration.
> > > Also due to their obscurity many kernel developers don't know that these UAPIs
> > > even exist.  (The reaction when someone finds out is usually "Why!?")
> > > 
> > > It may be worth looking at if iwd should make a different choice for this
> > > dependency.  It's understandable to blame dependencies when things go wrong, but
> > > at the same time the choice of dependency is very much a choice, and some
> > > choices can be more technically sound and cause fewer problems than others...
> > > 
> > >>  - OpenSSL + friends are rather large libraries.
> > > 
> > > The Linux kernel is also large, and it's made larger by having to support
> > > obsolete crypto algorithms for backwards compatibility with iwd.
> > > 
> > >>  - AF_ALG has transparent hardware acceleration (not sure if openSSL does
> > >> too).
> > > 
> > > OpenSSL takes advantage of CPU-based hardware acceleration, e.g. AES-NI.
> > > 
> > >> Another consideration is once you support openSSL someone wants wolfSSL,
> > >> then boringSSL etc. Even if users implement support it just becomes a huge
> > >> burden to carry for the project. Just look at wpa_supplicant's src/crypto/
> > >> folder, nearly 40k LOC in there, compared to ELL's crypto modules which is
> > >> ~5k. You have to sort out all the nitty gritty details of each library, and
> > >> provide a common driver/API for the core code, differences between openssl
> > >> versions, the list goes on.
> > > 
> > > What is the specific functionality that you're actually relying on that you
> > > think would need 40K lines of code to replace, even using OpenSSL?  I see you
> > > are using KEYCTL_PKEY_*, but what specifically are you using them for?  What
> > > operations are being performed, and with which algorithms and key formats?
> > > Also, is the kernel behavior that you're relying on documented anywhere?  There
> > > are man pages for those keyctls, but they don't say anything about any
> > > particular hash algorithm, SHA-1 or otherwise, being supported.
> > 
> > <https://lore.kernel.org/all/CA+55aFxW7NMAMvYhkvz1UPbUTUJewRt6Yb51QAx5RtrWOwjebg@mail.gmail.com/>
> > "And we simply do not break user space."
> > -Linus Torvalds
> > 
> > Is this no longer applicable?
> > 
> 
> As I said, the commit, or at least the part of it that broke iwd (it's not clear
> that it's the whole commit), needs to be reverted.
> 
> I just hope that, simultaneously, the iwd developers will consider improving the
> design of iwd to avoid this type of recurring issue in the future.  After all,
> this may be the only real chance for such a discussion before the next time iwd
> breaks.
> 
> Also, part of the reason I'm asking about what functionality that iwd is relying
> on is so that, if necessary, it can be properly documented and supported...
> 
> If we don't know what we are supporting, it is very hard to support it.

I ended up just sending out a patch that does a full revert:
https://lore.kernel.org/linux-crypto/20240313233227.56391-1-ebiggers@kernel.org

Again, regardless of that, these issues with iwd have been recurring, and it is
still worth discussing the best way from a technical perspective to prevent them
from happening in the future...  There's a fairly clear path to achieve that.

- Eric

