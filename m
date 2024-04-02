Return-Path: <linux-kernel+bounces-127831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9659789518A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CC42873CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A7260DFB;
	Tue,  2 Apr 2024 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRyTGaz6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E714B604BB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056444; cv=none; b=DYPCSBBhWK4deJ3Vcc4rElzNQy0n0t4LQ65tiZz9zSrUqbYsGmYpSEhFOzSdtAu34f7butru/5iiwlKBa9XArATO3v6ZwuYLyfh9ogwcDR+TM3IuS465nM0ttJZCp0k6qfbkJgOjiiPj101MGD9peyZUROjeZBvMByxwEOpCSo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056444; c=relaxed/simple;
	bh=yU3K+x6V4mI+yyO9moASq0ZRGkVzd9BUouUOy0FupEg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cYA9RI7wE1JXkukWs/ZS/fIGAMDp36OpZfqEkfi7L5pMUhAtv9bW9aUniRURGmrmmvN8jlvhLI/5AbrkTMzabyQqVQZnivbXEeZUAAokWGcx/4YqH5D+V2YeFHOFXRt8pewqO28KGrtt6xvdlKDItGilq7UppvOEGTwqLAInLAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRyTGaz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB6DC433F1;
	Tue,  2 Apr 2024 11:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712056443;
	bh=yU3K+x6V4mI+yyO9moASq0ZRGkVzd9BUouUOy0FupEg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MRyTGaz6lpX+nputpagH/tmjwEMeTzZCafdimJ5AUMg/jfayewlFDUKRqXoUQ0TNf
	 ZyWpfne0cLPL4VSzCfn935XOlqZR3evboLei5rU1FH52Tuj3ANln68pvR84P/dRFH2
	 Ln2ZYC8mvqCfXIwLpt5uARrWKZ3FSuJQv4cc4IMrLt/DBO2vGLp2gRQlWk2/DJsUjy
	 D+LswAAGDczSFEKWBncXcXvcj2nXVMsMqTxkIO+qpQ2YcauQtz7UNVL8Zdemz8zoPC
	 dhgI9AATdKYm4eLDlXaHlhhuPlGZCUcduuHb04vMrh+N5JsM8aPXKaITqbPD78stLY
	 lPiB28KCav7wQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v2 4/7] riscv: Simplify text patching loops
In-Reply-To: <20240327160520.791322-5-samuel.holland@sifive.com>
References: <20240327160520.791322-1-samuel.holland@sifive.com>
 <20240327160520.791322-5-samuel.holland@sifive.com>
Date: Tue, 02 Apr 2024 13:13:59 +0200
Message-ID: <87h6gkrp8o.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Samuel Holland <samuel.holland@sifive.com> writes:

> This reduces the number of variables and makes the code easier to parse.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> Changes in v2:
>  - Further simplify patch_insn_set()/patch_insn_write() loop conditions
>  - Use min() instead of min_t() since both sides are unsigned long

Thanks for addressing the changes! Nice cleanup!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

