Return-Path: <linux-kernel+bounces-104776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DA387D377
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27438B20328
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2779B4E1D1;
	Fri, 15 Mar 2024 18:19:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBF0376F3;
	Fri, 15 Mar 2024 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710526784; cv=none; b=Coue3E/apdMLvQblGg64HniZuEY1befaXt+ego+ATZqp0j9jYLIgLNY8zPrdVRj89p+SrcDauIQUOp29v77zk0WVa1dUwp4Pin2+HfK8KYk92qVTooLnsvGBcT2O0DliUwUqlx43Fw5NBUxDpoLJcynxiruD6iTNNcqH8400h5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710526784; c=relaxed/simple;
	bh=dbsvbfIgWkiMbG+rujc9xyqiUlyvV2JC/ZSuiZJeuvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlR+GP9QJ0I9agBACtxXXC61tg8546TEOYAH24Nkt4Q5PrcAMhEbdAVBGv/z3kSwLMGuNQBQmZITtHDLD/IsvTlB/Q2Wu6zQ2RRz18s+898YCXqaW+Fr91UQOQpUtjsJYTnYnYzxlvZohdfGRRb66p9KqP2ydeuvL5modRdqq30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E57BC433C7;
	Fri, 15 Mar 2024 18:19:42 +0000 (UTC)
Date: Fri, 15 Mar 2024 18:19:39 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Walmsley <paul@pwsan.com>,
	Will Deacon <will@kernel.org>, jisheng.teoh@starfivetech.com,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	locus84@andestech.com, peterlin@andestech.com
Subject: Re: linux-next: manual merge of the risc-v tree with the arm64 tree
Message-ID: <ZfSRO9JeFTxEeM8Q@arm.com>
References: <20240315103146.225b653b@canb.auug.org.au>
 <mhng-cfc51b24-8f65-4b87-a258-71a9893cb6fe@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-cfc51b24-8f65-4b87-a258-71a9893cb6fe@palmer-ri-x1c9a>

On Fri, Mar 15, 2024 at 10:21:13AM -0700, Palmer Dabbelt wrote:
> On Thu, 14 Mar 2024 16:31:46 PDT (-0700), Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the risc-v tree got a conflict in:
> > 
> >   drivers/perf/Kconfig
> > 
> > between commits:
> > 
> >   c2b24812f7bc ("perf: starfive: Add StarLink PMU support")
> >   f0dbc6d0de38 ("perf: starfive: Only allow COMPILE_TEST for 64-bit architectures")
> > 
> > from the arm64 tree and commit:
> > 
> >   bc969d6cc96a ("perf: RISC-V: Introduce Andes PMU to support perf event sampling")
> > 
> > from the risc-v tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> 
> Sorry, I guess maybe I should have looked at my queue before agreeing to
> send the starfive PMU patches via the arm64 tree.  The Andes stuff touches a
> bunch of other RISC-V bits, but I'm happy to do a shared tag or something if
> folks want.
> 
> Otherwise I'll just point this out to Linus when I send my PR -- I'm going
> to hold off on that this morning, as I just realized I should have taken
> this GUP fix and thus want to let things bake a little longer.

The arm64 tree went in yesterday already. If you want, you can merge
the arm64 for-next/perf tree into yours before sending the PR to Linus.
Otherwise, the conflict is trivial, just give Linus a heads-up.

-- 
Catalin

