Return-Path: <linux-kernel+bounces-132287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836EB89927C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D84A282A91
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78C617FF;
	Fri,  5 Apr 2024 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdhwxiS6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1B7393;
	Fri,  5 Apr 2024 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712275887; cv=none; b=oBjpH+XK8AulQYygOpXoUoUZBqrOD2GYS7VOSZSxPoTGc2j2bdjSUhednh+gtMrIB3ngvP6D7O06MGM/FOpa9IX4vL3wYnbT8fLWardmrqP3He7TCxaCrm2opQreTGRj+eqWPrGbvtB0oIv0X0jb0Hnl71HGBeut6lyJfpqeSAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712275887; c=relaxed/simple;
	bh=sixHw0qjmJ91KQBby8fLahkmtg5SQTAdxk0eoNbPRXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jq7j9Jj/Zm89gUIl0MH7xhVkp/rpxT+ptJnhSWGr4RWXrRXyBJANEDTCxRGUOHb73X8jOG8Iprodtnop0zWV+0qXhWN1/zW07DJVCdRdcdrRIIsFtKXCyk+qo1OKRbJ57MLik2/gFk+u0PGY4lrXguKAYit8uRrBCiGp1PQ71V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdhwxiS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEA3C433C7;
	Fri,  5 Apr 2024 00:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712275886;
	bh=sixHw0qjmJ91KQBby8fLahkmtg5SQTAdxk0eoNbPRXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gdhwxiS60I8BOwnw4Ii7T9f8fHRfg0lugQM1ZgrCTO9LWWy6iG9UrKJ5h8+pp0yHD
	 hEOJ5WFR9DeR+dYhWWKK56lIedIojKe38g5sekEaULt9KfOGXTissDcgrC0tk5EsN7
	 PrmuQF2xZlZP9wzyZbMKDAvBoZbhncFqsqiKjxD1HkqfrGoq+gtzBX1YyaeMY24GPb
	 6tpMtWNnOe54ee9jRm1MvHmKRcUcM/ZpHuebCGV7B9w/l5igRzLVcH4TiNNnmlP5/m
	 PAAwooWcMJa3/kblfrma4bG8j4R+oPiqpeNAQ0Ws3xVUglFQlhHUFwVoSEp7KRBDKv
	 UQX04eW2AARkw==
Date: Thu, 4 Apr 2024 20:11:23 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-crypto@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v2 6/6] crypto: x86/aes-xts - wire up VAES + AVX10/512
 implementation
Message-ID: <20240405001123.GA1958@quark.localdomain>
References: <20240329080355.2871-1-ebiggers@kernel.org>
 <20240329080355.2871-7-ebiggers@kernel.org>
 <f5461df0-6609-42db-850c-de6a32728fe2@intel.com>
 <20240404233600.GA746@quark.localdomain>
 <c806bffe-6e87-4c51-ac99-4b2612d3c334@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c806bffe-6e87-4c51-ac99-4b2612d3c334@intel.com>

On Thu, Apr 04, 2024 at 04:53:12PM -0700, Dave Hansen wrote:
> On 4/4/24 16:36, Eric Biggers wrote:
> > 1. Never use zmm registers.
> ...
> > 4. Keep the proposed policy as the default behavior, but allow it to be
> >    overridden on the kernel command line.  This would be a bit more flexible;
> >    however, most people don't change defaults anyway.
> > 
> > When you write "Some folks will also surely disagree with the kernel policy
> > implemented here", are there any specific concerns that you anticipate?
> 
> Some people care less about the frequency throttling and only care about
> max performance _using_ AVX512.
> 
> > Note that Intel has acknowledged the zmm downclocking issues on Ice
> > Lake and suggested that using ymm registers instead would be
> > reasonable:>
> https://lore.kernel.org/linux-crypto/e8ce1146-3952-6977-1d0e-a22758e58914@intel.com/
> > 
> > If there is really a controversy, my vote is that for now we just go with option
> > (1), i.e. drop this patch from the series.  We can reconsider the issue when a
> > CPU is released with better 512-bit support.
> 
> (1) is fine with me.
> 
> (4) would also be fine.  But I don't think it absolutely _has_ to be a
> boot-time switch.  What prevents you from registering, say,
> "xts-aes-vaes-avx10" and then doing:
> 
> 	if (avx512_is_desired())
> 		xts-aes-vaes-avx10_512(...);
> 	else
> 		xts-aes-vaes-avx10_256(...);
> 
> at runtime?
> 
> Where avx512_is_desired() can be changed willy-nilly, either with a
> command-line parameter or runtime knob.  Sure, the performance might
> change versus what was measured, but I don't think that's a deal breaker.
> 
> Then if folks want to do fancy benchmarks or model/family checks or
> whatever, they can do it in userspace at runtime.

It's certainly possible for a single crypto algorithm (using "algorithm" in the
crypto API sense of the word) to have multiple alternative code paths, and there
are examples of this in arch/x86/crypto/.  However, I think this is a poor
practice, at least as the crypto API is currently designed, because it makes it
difficult to test the different code paths.  Alternatives are best handled by
registering them as separate algorithms with different cra_priority values.

Also, I forgot one property of my patch, which is that because I made the
zmm_exclusion_list just decrease the priority of xts-aes-vaes-avx10_512 rather
than skipping registering it, the change actually can be undone at runtime by
increasing the priority of xts-aes-vaes-avx10_512 back to its original value.
Userspace can do it using the "crypto user configuration API"
(include/uapi/linux/cryptouser.h), specifically CRYPTO_MSG_UPDATEALG.

Maybe that is enough configurability already?

- Eric

