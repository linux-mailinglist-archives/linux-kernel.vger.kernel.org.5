Return-Path: <linux-kernel+bounces-34676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BF1838603
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B701F25EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E571852;
	Tue, 23 Jan 2024 03:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wng2Ly9p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B7A10F1;
	Tue, 23 Jan 2024 03:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705980584; cv=none; b=KD7Fnge+T9POJvAV8qAKe6sx92HBtT8JmbeIorRg4KP7mBmGdiTT+JCIrJqT4MRxC2GiGlCqCW1H3DBGErzk2orKr3LaLYGalpQk+kJPDFgMT3nwDOd/CwbU96FlZoFLNXs6I2urnXRju2kOHr2SLaov3F9i/MeN71pfR+2WhL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705980584; c=relaxed/simple;
	bh=U1v5qrYKbV+f+R8OtytsdZNiZAtmV31IrDUJJyID3bk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Q0YmV5gDg3VwcxQlxqdemhPnPEavoW7fR8gLM5xm078rlHPS7xP/tmnOZocVehg/pCwyaxkUZrpZEsLhM65GL54MzofCKmiwjqND1gVjiXb+0xdY2pL+vuEDBDSTEJFvGwDty4Jq17wiysMICq8W5OQ5Bw/45aDnVB/Ik/pHEGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wng2Ly9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2CEC433C7;
	Tue, 23 Jan 2024 03:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705980583;
	bh=U1v5qrYKbV+f+R8OtytsdZNiZAtmV31IrDUJJyID3bk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Wng2Ly9p0gJUrUy0fOD4sFGGZ3A/c+t4sAUY6sRcNyedhhhAQEuGsBs991gjlQhWi
	 L9W34O7F9D6wLVxhLculzkedvobKw3ENzJv1JQTt2VBpihomaaGQWcWBbsYybwdIJF
	 ig5KyQrCJqCLjUKrpQep0GrdUC5rmFXzYY056mFzRum+NFP1zAAHW6lCBRRBozSmzS
	 IKrxbZ/KFH/jeSI4AjmRfZwnEkxStHujgD3WpURC8HreGp2IRC4gaNEfbGxo/7AosX
	 j93RdCdt5BGaL7DtelBesGtRUoWStsloAYet8odRBsaEEjZhqLKLRgsDIy8/b6GhYk
	 f7F7CMQMRIVtw==
Date: Mon, 22 Jan 2024 19:29:42 -0800
From: Kees Cook <kees@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>, Kees Cook <keescook@chromium.org>
CC: linux-hardening@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Aditya Srivastava <yashsri421@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-crypto@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 46/82] crypto: Refactor intentional wrap-around test
User-Agent: K-9 Mail for Android
In-Reply-To: <20240123030745.GA1097@sol.localdomain>
References: <20240122235208.work.748-kees@kernel.org> <20240123002814.1396804-46-keescook@chromium.org> <20240123030745.GA1097@sol.localdomain>
Message-ID: <C9D472CD-13E1-460B-B8FF-3DD9447804B3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On January 22, 2024 7:07:45 PM PST, Eric Biggers <ebiggers@kernel=2Eorg> w=
rote:
>Just to double check, you really intend to forbid *unsigned* integer wrap=
around?
>This patch's commit message focuses on signed, and barely mentions unsign=
ed=2E
>The actual code changes in this patch only deals with unsigned=2E

I don't mean to forbid wrap-around; we just need to annotate it=2E I can s=
ee how this commit log didn't do a great job explaining this=2E I hope the =
cover letter is more sensible:
https://lore=2Ekernel=2Eorg/linux-hardening/20240122235208=2Ework=2E748-ke=
es@kernel=2Eorg/

>Also, what's the motivation for addressing the 'x + y < x' case but not o=
ther
>cases in the same file?

It's a code pattern we could find easily=2E It's working from the instance=
s found via Coccinelle earlier in the series:
https://lore=2Ekernel=2Eorg/linux-hardening/20240123002814=2E1396804-5-kee=
scook@chromium=2Eorg/

> For example, the le128_add() function which this patch
>modifies has two other intentional wraparounds, which this patch doesn't =
touch=2E

For dedicated wrapping functions we can mark them with __unsigned_wrap:
https://lore=2Ekernel=2Eorg/linux-hardening/20240123002814=2E1396804-6-kee=
scook@chromium=2Eorg/

>Also, the le128_sub() function just below le128_add() is very similar but=
 does
>wraparound in the other direction=2E  That's 6 cases in 20 lines of code,=
 but this
>patch only addresses 1=2E  And of course, lots of other crypto code relie=
s on
>unsigned wraparounds too, which this patch overlooks=2E =20

Right -- finding these kinds of things is where a lot of time will be spen=
t in the future, I suspect=2E :)

> So I'm a bit confused
>about the point of this patch=2E  If we really wanted to explicitly annot=
ate all
>the intentional wraparounds in a particular piece of code, so that the co=
de can
>be run with the corresponding sanitizer enabled, wouldn't it be necessary=
 to
>actually test the code with that sanitizer enabled to find all the cases?

Yes, but there's a lot of code to test -- I'm trying to get the first step=
s done=2E And then once the sanitizers are in good shape, the fuzzers can g=
rind=2E (I'm trying to add some parallelism to this project; this code patt=
ern was known so I figured we could address it now=2E)

-Kees

--=20
Kees Cook

