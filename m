Return-Path: <linux-kernel+bounces-32447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058DE835BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2991C217CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FE91642D;
	Mon, 22 Jan 2024 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOnqDMRd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496DB14F6C;
	Mon, 22 Jan 2024 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909327; cv=none; b=t5Sfz5HNorVcrktsf8AlMjo0QV76sae2q72AvDQY+2LWEPkH6XcOzAR4lvPiGHMxF5ciJUasLer3bsYa/Y1UfpKEj456seFhhaVlj6ZN/SkXcrZLR2w43oiv3BK/c/LLpS1QxaXnOs2xVSe6JjhyQ70mcoFhnbE14Ya3LCUYQW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909327; c=relaxed/simple;
	bh=6q+Ae298LK6Fwx9w1Hxqg+/TcqF4+MMHBmWb7Tw8+hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQ1aSF46tk2aWy4OvE+gENAnpX36Khxre6ANhFgF3WpMnv5uKJSZ47FGArOukW+tj67uEYW0EXe+8fLu6W5OyCbdkmDJOn2fEO+cFlBc53a0sRUOZ//MKboctanu6k7iHoyCWR5lCgKo4Orm+cjwVGy3y2/E2vKVotdSGqSzwcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOnqDMRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B284C43394;
	Mon, 22 Jan 2024 07:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705909326;
	bh=6q+Ae298LK6Fwx9w1Hxqg+/TcqF4+MMHBmWb7Tw8+hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jOnqDMRdvXuWTje7hxQN2dCLE7PzYUq8rAYWennGmg2eWAJlF8wYxF7WITOD93XyX
	 kOi7HC3t/JBdyraClA4q5IQ6eCe0QP9DQEOOLu5rJzGGtUakerutvskNDSebyStAJZ
	 z+mnBJqfh9Fcq+5rh+Kc2KPiYn9xLCRpmCpxOFhvwp4xLOdS0I9/a1r1ZusQ+JEtay
	 eerJbS9dnoFfr2YnDqeIifjrZ8RFwgs3XLP/I8Wfw7PBHR0aHCQTC5FxayDUKgCqE/
	 I+Nux9qFYloyZL8LPJSk6tchB/m6C22f9IUgs1mhO9obbBZ8/pniLuN0IIT85I3k0j
	 4+4RMm18KCn0Q==
Date: Mon, 22 Jan 2024 09:41:40 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Shijie Huang <shijie@amperemail.onmicrosoft.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	gregkh@linuxfoundation.org, patches@amperecomputing.com,
	rafael@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kuba@kernel.org, vschneid@redhat.com,
	mingo@kernel.org, akpm@linux-foundation.org, vbabka@suse.cz,
	tglx@linutronix.de, jpoimboe@kernel.org, ndesaulniers@google.com,
	mikelley@microsoft.com, mhiramat@kernel.org, arnd@arndb.de,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, mark.rutland@arm.com, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org,
	cl@os.amperecomputing.com
Subject: Re: [PATCH] NUMA: Early use of cpu_to_node() returns 0 instead of
 the correct node id
Message-ID: <Za4cNBQBLZujlAlP@kernel.org>
References: <20240119033227.14113-1-shijie@os.amperecomputing.com>
 <Zan9sb0vtSvVvQeA@yury-ThinkPad>
 <1cd078fd-c345-4d85-a92f-04c806c20efa@amperemail.onmicrosoft.com>
 <Zao13I4Bb0tur0fZ@kernel.org>
 <b8786c38-d6c4-4fea-a918-ac6a45682dba@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8786c38-d6c4-4fea-a918-ac6a45682dba@amperemail.onmicrosoft.com>

On Fri, Jan 19, 2024 at 04:50:53PM +0800, Shijie Huang wrote:
> 
> 在 2024/1/19 16:42, Mike Rapoport 写道:
> > Is there a fundamental reason to have early_cpu_to_node() at all?
> 
> The early_cpu_to_node does not work on some ARCHs (which support the NUMA),
> such as  SPARC, MIPS and S390.

My question was why we need early_cpu_to_node() at all and why can't we use
cpu_to_node() early on arches that do have it.
 
> Thanks
> 
> Huang Shijie
> 
> > It seems that all the mappings are known by the end of setup_arch() and the
> > initialization of numa_node can be moved earlier.
> > > > I would also initialize the numa_node with NUMA_NO_NODE at declaration,
> > > > so that if someone calls cpu_to_node() before the variable is properly
> > > > initialized at runtime, he'll get NO_NODE, which is obviously an error.
> > > Even we set the numa_node with NUMA_NO_NODE, it does not always produce
> > > error.
> > > 
> > > Please see the alloc_pages_node().
> > > 
> > > 
> > > Thanks
> > > 
> > > Huang Shijie
> > > 

-- 
Sincerely yours,
Mike.

