Return-Path: <linux-kernel+bounces-15655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 336FD822FA0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D953C1F24645
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A871A5B1;
	Wed,  3 Jan 2024 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj111nEW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982C11A5A0;
	Wed,  3 Jan 2024 14:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8961AC433C8;
	Wed,  3 Jan 2024 14:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704292564;
	bh=is7O5uMKlFnKVd3x+vpOi0jZoWskFl0wA4r7k43/gWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pj111nEWhbwtnIBXAmtPTKY07uMZLZalmcUisGEP01x91bzK1WMukhkXdmvcbLiz4
	 nzjuKfvPLvnFmmJnrLQ3u5SNnbNuN7NK7IuyAO7jqoF0a4BeqbHjaoYV14ky9gjX7u
	 AQMYN2St2mGoLuzjRd+80Ftvu2tbiJmi8zaOAteCnijOw/MGNC+tQiq1/XqiG9txGu
	 R1dqFESMQMMqdCT57+JD8QAZu4Xa5xXNj+LQwbw3REC5LQfR/1AaGwt0+F/MikT/nw
	 bzj0byS0nAt1ZtobKqk3F5og48OWQeWe5VrN+DFCETjFL6EO7F3nQiUlMw5X/4jtnA
	 qAzRUdUnPCWuQ==
Date: Wed, 3 Jan 2024 08:35:57 -0600
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-riscv@lists.infradead.org,
	Jerry Shih <jerry.shih@sifive.com>, linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Phoebe Chen <phoebe.chen@sifive.com>, hongrong.hsu@sifive.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [RFC PATCH 00/13] RISC-V crypto with reworked asm files
Message-ID: <20240103143557.GA773@quark.localdomain>
References: <20240102064743.220490-1-ebiggers@kernel.org>
 <CAMj1kXEAqxCZ_PNM9a=CyciSHUzDU_yqemKh51oncHyLbYUKtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEAqxCZ_PNM9a=CyciSHUzDU_yqemKh51oncHyLbYUKtA@mail.gmail.com>

On Wed, Jan 03, 2024 at 03:00:29PM +0100, Ard Biesheuvel wrote:
> On Tue, 2 Jan 2024 at 07:50, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > As discussed previously, the proposed use of the so-called perlasm for
> > the RISC-V crypto assembly files makes them difficult to read, and these
> > files have some other issues such extensively duplicating source code
> > for the different AES key lengths and for the unrolled hash functions.
> > There is/was a desire to share code with OpenSSL, but many of the files
> > have already diverged significantly; also, for most of the algorithms
> > the source code can be quite short anyway, due to the native support for
> > them in the RISC-V vector crypto extensions combined with the way the
> > RISC-V vector extension naturally scales to arbitrary vector lengths.
> >
> > Since we're still waiting for prerequisite patches to be merged anyway,
> > we have a bit more time to get this cleaned up properly.  So I've had a
> > go at cleaning up the patchset to use standard .S files, with the code
> > duplication fixed.  I also made some tweaks to make the different
> > algorithms consistent with each other and with what exists in the kernel
> > already for other architectures, and tried to improve comments.
> >
> > The result is this series, which passes all tests and is about 2400
> > lines shorter than the latest version with the perlasm
> > (https://lore.kernel.org/linux-crypto/20231231152743.6304-1-jerry.shih@sifive.com/).
> > All the same functionality and general optimizations are still included,
> > except for some minor optimizations in XTS that I dropped since it's not
> > clear they are worth the complexity.  (Note that almost all users of XTS
> > in the kernel only use it with block-aligned messages, so it's not very
> > important to optimize the ciphertext stealing case.)
> >
> > I'd appreciate people's thoughts on this series.  Jerry, I hope I'm not
> > stepping on your toes too much here, but I think there are some big
> > improvements here.
> >
> 
> As I have indicated before, I fully agree with Eric here that avoiding
> perlasm is preferable: sharing code with OpenSSL is great if we can
> simply adopt the exact same code (and track OpenSSL as its upstream)
> but this never really worked that well for skciphers, due to API
> differences. (The SHA transforms can be reused a bit more easily)
> 
> I will also note that perlasm is not as useful for RISC-V as it is for
> other architectures: in OpenSSL, perlasm is also used to abstract
> differences in calling conventions between, e.g., x86_64 on Linux vs
> Windows, or to support building with outdated [proprietary]
> toolchains.
> 
> I do wonder if we could also use .req directives for register aliases
> instead of CPP defines? It shouldn't matter for working code, but the
> diagnostics tend to be a bit more useful if the aliases are visible to
> the assembler.

.req unfortunately isn't an option since it is specific to AArch64 and ARM
assembly.  So we have to use #defines like x86 does.  Ultimately, the effect is
about the same.

- Eric

