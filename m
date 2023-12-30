Return-Path: <linux-kernel+bounces-13325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0215820385
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 04:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB651283775
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 03:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C4A23AE;
	Sat, 30 Dec 2023 03:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IETRLd9/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0A01FA0;
	Sat, 30 Dec 2023 03:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CEB4C433C7;
	Sat, 30 Dec 2023 03:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703908278;
	bh=VmHUTGM7aUkCwtaREvb2oEHYRyKp2dpYapW36y8fVsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IETRLd9/8x1XdEH6vckYtcj+6m+nrONX26HaiYsB2i/PwwV5wuZTrbBwkx4PRCVx6
	 8K6Xbp6W8MB0Ekuy/BH74/8uS72kXdb0MXq/h8epX1NzPPBuLTUHzNE0fTS8x7J4++
	 uiBypkSDkTJOoAiWOR35ew0lgAQHsGRZNol0/OPLr9cCU0hEVvj+ukH7yGUoRfQ+QC
	 YwUz1Pq03w52eiuLXxbrvziBLdzKz90cStOWIR0kBJYgAnnpiU3WedhDu+A7eMlrmG
	 ytmZa2mbxQYWpONhvooW/ChkHikK3W56Ii65Azg7IX4BdHGXXmkyvGqvFDmp4BKemY
	 dKW79xDOkzGdQ==
Date: Fri, 29 Dec 2023 21:51:12 -0600
From: Eric Biggers <ebiggers@kernel.org>
To: Jerry Shih <jerry.shih@sifive.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	conor.dooley@microchip.com, ardb@kernel.org, conor@kernel.org,
	heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH v3 00/12] RISC-V: provide some accelerated cryptography
 implementations using vector extensions
Message-ID: <20231230035112.GC770@quark.localdomain>
References: <20231205092801.1335-1-jerry.shih@sifive.com>
 <20231222054827.GE52600@quark.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222054827.GE52600@quark.localdomain>

Hi Jerry,

On Thu, Dec 21, 2023 at 11:48:27PM -0600, Eric Biggers wrote:
> Hi Jerry,
> 
> On Tue, Dec 05, 2023 at 05:27:49PM +0800, Jerry Shih wrote:
> > Changelog v2:
> >  - Turn to use simd skcipher interface for AES-CBC/CTR/ECB/XTS and
> >    Chacha20.
> 
> If I understand correctly, the RISC-V kernel-mode vector support now seems to be
> heading down the path of supporting softirq context, as I had suggested
> originally.  With patches 1-2 of Andy Chiu's latest patchset
> "[v7, 00/10] riscv: support kernel-mode Vector"
> (https://lore.kernel.org/linux-riscv/20231221134318.28105-1-andy.chiu@sifive.com).
> applied, the kernel has basic support for kernel-mode vector, including in
> softirq context.
> 
> With that being the case, "skcipher" algorithms can just use the RISC-V vector
> unit unconditionally, given that skcipher only supports task and softirq
> context.  Therefore, can you consider undoing your change that added fallbacks
> using the simd helper (crypto/simd.c)?  Thanks!
> 

I had a go at incorporating my suggestions into your patchset, and rebasing the
patchset onto riscv/for-next plus the first two patches of "[v9, 00/10] riscv:
support kernel-mode Vector".  You can get the result from branch "riscv-crypto"
of https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git.
Everything seems to work (tested in QEMU, as usual).

Please consider using it when you send out v4; thanks!  I can even send it out
myself, if you want, but I assume you're still "owning" the patchset.

- Eric

