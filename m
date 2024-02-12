Return-Path: <linux-kernel+bounces-61108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C08850D66
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 06:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8601F220ED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 05:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123BF6FB6;
	Mon, 12 Feb 2024 05:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="UMfTjBFW"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BFB63D1;
	Mon, 12 Feb 2024 05:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707716328; cv=none; b=uI1Y+KdZDiVJTiu6u403f+Bl7oz+jopJE2aZpZEK3Cv9DxyrLcRJ/ZKrgkDa23hF8hzoGVtZ4Cunwcte0qwoyBHbKZwdo/l5u5EOkrx94KMNrgwW8NwhA26rWqdLKjpNkQE4KQp7ix0zUCFTxxJAkXvoBQ2ZEKsxbxKwhXOP6rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707716328; c=relaxed/simple;
	bh=aYRQrR078wUpY+e7Eyetoj2fffaA5I00zmjESLa/c/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XJR3HVDIm90/7Oo7z2o45iEKvPPUr5A8xcpCXtV0THNiWh9BobbkHPhLfrqfxISGI/r5G4iwoi5w8qcNyJBv//O3jqm6h96BRpOTuTKQMzCA5r262DU+y4o5X4Ng+f9kKX4N39DCgzWV9BH6XIIUBIb7gVvHfQPga2RWJEvDkC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=UMfTjBFW; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1707716323;
	bh=WlznTFxLp/HqFR/zHSqL++eDGzo1KkY/I6UV1Hx6DCk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UMfTjBFWpNqTOIZvz6QcIVM3SE6n+B41vf/0Kvn85Pw7GDCUwInzDu6DTsJgwCaVy
	 IMs4YMFg48fl9X+9RJUYaqR25O4+do2ND9cJpe41Y96p+hskf4xgEdJgFzBGjnMkrM
	 XwSc3MT89EHjIjFFkDb9GmTOkaRWzDj9X8jy9+yCBwBUfgwQNFLYO5o6+oaChYUTyd
	 16sI7XC8aQ/58Z/ZAT0jqwMYhxKx2GYl0ue66fznbLpoIJkree2ooJSxmatRgve7ed
	 nIbJPhvT1dXw7cKUOtD+ZGOd64lJlyD73eUMxmeqBWfNp/hm98fGs7DDvpkZlW2dSM
	 aiOq9Dzyo85xQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TYCtV1D1Kz4wyj;
	Mon, 12 Feb 2024 16:38:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.ibm.com>, Vasant Hegde
 <hegdevasant@linux.vnet.ibm.com>, dingsenjie <dingsenjie@yulong.com>,
 linuxppc-dev@lists.ozlabs.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 60/82] powerpc: Refactor intentional wrap-around test
In-Reply-To: <20240123002814.1396804-60-keescook@chromium.org>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-60-keescook@chromium.org>
Date: Mon, 12 Feb 2024 16:38:41 +1100
Message-ID: <87zfw66y3i.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kees Cook <keescook@chromium.org> writes:
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
>
> 	VAR + value < VAR
>
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
>
> Refactor open-coded wrap-around addition test to use add_would_overflow().
> This paves the way to enabling the wrap-around sanitizers in the future.
>
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> Cc: dingsenjie <dingsenjie@yulong.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/powerpc/platforms/powernv/opal-prd.c | 2 +-
>  arch/powerpc/xmon/xmon.c                  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

