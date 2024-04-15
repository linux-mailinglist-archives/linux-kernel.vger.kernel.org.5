Return-Path: <linux-kernel+bounces-145983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A911E8A5DE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E252835FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5320C1586FE;
	Mon, 15 Apr 2024 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avBbDmwJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED871C36;
	Mon, 15 Apr 2024 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713221663; cv=none; b=QFJ77kDMPacori9Hjsp4+Oc8geBexg1HDhKZd4ZoR6s8OcNH4rnzBnPef8b9ddRCUrQabhLEgI+RUKYnvDzbMvRm/cfqvOT0a/6EQQLdzPgQh8xaMcfibn2/EVbftgBghFRMwuBGtuUckC0mF1DPh9feoHzeh77tpd7TWzwfqxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713221663; c=relaxed/simple;
	bh=Ib36ccBe0DZRA4zcOLRG0Os5eO64FBsFowrSfoGwj28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIFNDmHG6aChWIM3JNSDpYZqCR2zsANtnW5yxYpl5aTFcvALC4CGDO9qcKhCry/lHpUXSsCBxS9cw2XhYSx5lGelf3wFFgIWmOIGAsoovnF63TW7MrkE/eE3OxY1fd6sKd/ZAF845bIXD6MuiiJU00IqzRhHMpo+KM5WmFu9YxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avBbDmwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87643C113CC;
	Mon, 15 Apr 2024 22:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713221663;
	bh=Ib36ccBe0DZRA4zcOLRG0Os5eO64FBsFowrSfoGwj28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=avBbDmwJhHVgnB5taPkfu91amKh/GT4PlZYHkMdXz5JgNdiGfaA2wyYTzl6/LSQmB
	 SBaALOrtKd2KEic7rq8oFnYT9katIkSj81gA4MnTks7hdW/OjU2NMzEmeXb41eMMLk
	 fbr9SzeNP2FLje+KMAFEQH1Hq7L38d+pO4eIaSTuEugi67ot4/e/oLVf1T6+f1RopN
	 CmLplKESPhxzwmFlRDfcnUXsgW1yw73Nfc9Y+gw1pBnNUPPJqaq7Dli22lMSSmRUj9
	 KWSO4TpeloCrscyQdpiHLNfAsVAxncik+BBRYcX+o8MYnGet6jKGu6DPXhUByOHeGl
	 be2xYmiHMd4nw==
Date: Mon, 15 Apr 2024 15:54:20 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	dm-devel@redhat.com, luto@kernel.org, dave.hansen@linux.intel.com,
	tglx@linutronix.de, bp@alien8.de, mingo@kernel.org, x86@kernel.org,
	herbert@gondor.apana.org.au, ardb@kernel.org, elliott@hpe.com,
	dan.j.williams@intel.com, bernie.keany@intel.com,
	charishma1.gairuboyina@intel.com
Subject: Re: [PATCH v9 00/14] x86: Support Key Locker
Message-ID: <20240415225420.GD5206@sol.localdomain>
References: <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20240329015346.635933-1-chang.seok.bae@intel.com>
 <13bb2f0f-5894-4366-be53-44658144a23d@intel.com>
 <20240408014806.GA965@quark.localdomain>
 <8fbab9e8-a2fc-4fb2-a9c3-e7336fa50118@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fbab9e8-a2fc-4fb2-a9c3-e7336fa50118@intel.com>

On Mon, Apr 15, 2024 at 03:16:18PM -0700, Chang S. Bae wrote:
> > First, surely it's the case that in practice, all CPUs that support Key Locker
> > also support AVX?  If so, then there's no need for the Key Locker assembly to
> > use legacy SSE instructions.  It should instead target AVX and use VEX-coded
> > instructions.  This would save some instructions and improve performance.
> 
> Unfortunately, the Key Locker instructions using the AVX states were never
> implemented.

Sure, you could still use VEX-coded 128-bit instructions for everything other
than the actual AES (for example, the XTS tweak computation) though, right?
They're a bit more convenient to work with since they are non-destructive.

- Eric

