Return-Path: <linux-kernel+bounces-16035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FA282374A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53613B2425D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F461DA35;
	Wed,  3 Jan 2024 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gz/p9MW9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCF11DA2C;
	Wed,  3 Jan 2024 21:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA87C433C7;
	Wed,  3 Jan 2024 21:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704318681;
	bh=wFZCcR/vAARfo3nJl86sOjbtJABriCt7XbbSfUIfxwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gz/p9MW9Q0Vpcv8sl0kgS8hBMXeFgfHWV/w9eMrWHoapUjSJhAZifONEt1FPQ4iC3
	 6A1qORhhdEC1msYHv4KRyapQdyJvRVsOfybKBLXMRQPTVZCaYXaDbr3/FgkYmqZ9j5
	 XkWz7pRZfQemyVNyrnG32u37gBBlsNm02ebERdOihAVjxAJJN3Lmz8AqUN/qEupkZl
	 b7f7+jW0wGlWpmHAkT8xfHVEI8P0OJxAqqFXOlAcI+LUjbAdruTUZHo1AmjhbsiRbu
	 tx3vtx8mg/XzqaHdpEuf9Qpecq+Dk7NmXyT8j4fjLOatnP1kT2GC8GG98FVWfCn9Zs
	 5f2V2Mrl3OLww==
Date: Wed, 3 Jan 2024 14:51:19 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] x86/tools: objdump_reformat.awk: Skip bad instructions
 from llvm-objdump
Message-ID: <20240103215119.GB155391@dev-arch.thelio-3990X>
References: <20231205-objdump_reformat-awk-handle-llvm-objdump-bad_expr-v1-1-b4a74f39396f@kernel.org>
 <20240103181542.GA629234@dev-arch.thelio-3990X>
 <20240103181852.GDZZWlDJMVvqAZdpfV@fat_crate.local>
 <20240103205506.GA152662@dev-arch.thelio-3990X>
 <20240103212616.GGZZXQ+IKGPb+EqVcu@fat_crate.local>
 <20240103214804.GA155391@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103214804.GA155391@dev-arch.thelio-3990X>

On Wed, Jan 03, 2024 at 02:48:09PM -0700, Nathan Chancellor wrote:
> On Wed, Jan 03, 2024 at 10:26:16PM +0100, Borislav Petkov wrote:
> > On Wed, Jan 03, 2024 at 01:55:06PM -0700, Nathan Chancellor wrote:
> > > On Wed, Jan 03, 2024 at 07:18:52PM +0100, Borislav Petkov wrote:
> > > > On Wed, Jan 03, 2024 at 11:15:42AM -0700, Nathan Chancellor wrote:
> > > > > Ping? I am still seeing this issue.
> > > > 
> > > > Does this need a Fixes tag and needs to go to Linus now or are you fine
> > > > with 6.8-rc0?
> > > 
> > > This is only needed due to the recent changes from Sam and myself in
> > > x86/build
> > 
> > I don't understand: those three commits seem unrelated to LLVM objdump
> > outputting "<unknown>".
> > 
> > Or are you saying that you've *started* running the insn decoder selftest
> > with llvm's objdump and those three commits are addressing differences
> > in the output and this outstanding commit is needed too for the bad
> > opcode case?
> 
> Prior to commit 5225952d74d4 ("x86/tools: Remove chkobjdump.awk"), the
> insn decoder selftest would not actually run with llvm-objdump
> altogether because chkobjdump.awk would fail (because it was only
> written for GNU objdump). The two commits prior to 5225952d74d4 were
> cleaning up differences between the output of each objdump
> implementations and this change should have been a part of that work as
> well, I just did not build enough configurations to see it. Hopefully
> that clears things up.

For the record, this explanation really should have been in the commit
message of 5225952d74d4 but I guess I was not thinking at the time.

Cheers,
Nathan

