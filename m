Return-Path: <linux-kernel+bounces-72268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1DD85B159
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF771C20F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6387D45BE9;
	Tue, 20 Feb 2024 03:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AiFkdDAi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1FD2E63C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708399722; cv=none; b=q+CQcx3NS5PzHFTY2KiJPEdz1jL3fx6DkP9cROOcB6NFANGttMd5uDZEwoZhZ7Xe+jeVq12uU+4oK8bXqgMVUzZ8n1BVaC5DuM0+wovcMLOPiUAVn7yomhZ98ixn2Gt/KUbRUCykSBI/IqedwopwaJwiUAB3+h4YI0REjGNL8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708399722; c=relaxed/simple;
	bh=DTR2uNWVPJnrZHEWTYCURZ4VdPgL3+g3zy3/nkeE8F0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QLxUW33NHiOXTh56YscZxC4gtuv3aLWLXy85wCawwfB9Nq+JzglsENhSkVulcp/B6EHKH4prhGJUPkHfKkuMLaR158MKXtXjsc4wNXPaLTCq1XzJcnXUM34ftN8neQKfR3zYpDTMEEdaoZB0D2ajluOUwaU8PM1cBgBbw3Bp7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AiFkdDAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80CFC433F1;
	Tue, 20 Feb 2024 03:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708399722;
	bh=DTR2uNWVPJnrZHEWTYCURZ4VdPgL3+g3zy3/nkeE8F0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AiFkdDAiORo3LoXDJTBk3/R2v0b0JPK/1Ryn9O4/eCVdFpzrTUO6DVWOF2I2QY1MC
	 9FQipYnHcBKndfpXKMKs/fxQiqJaS3y5gT6xYbnK7Df57ERr+m8kffyBbH5Rw4ArE6
	 src7Nua2lOr6bMjGsn367UICGSH/ZKBCQScCGaVM=
Date: Mon, 19 Feb 2024 19:28:41 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Byungchul Park <byungchul@sk.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com
Subject: Re: [PATCH v4] sched/numa, mm: do not try to migrate memory to
 memoryless nodes
Message-Id: <20240219192841.f1ed44b8c85073511227721c@linux-foundation.org>
In-Reply-To: <20240220023304.GF65758@system.software.com>
References: <20240219041920.1183-1-byungchul@sk.com>
	<87o7ccrghz.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240219174508.bc6256248a163c3ab9a58369@linux-foundation.org>
	<20240220023304.GF65758@system.software.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 11:33:04 +0900 Byungchul Park <byungchul@sk.com> wrote:

> > Yes, this changelog is missing rather a lot of important information.
> > 
> > I pulled together the below, please check.
> 
> To make it more clear, I need to explain it more. I posted the following
> two patches while resolving the oops issue. However, two are going on
> for different purposes.
> 
> 1) https://lkml.kernel.org/r/20240219041920.1183-1-byungchul@sk.com
> 
>    I started this patch as the fix for the oops. However, I found the
>    root cause comes from using -1 as an array index. So let the root 
>    cause fix go with another thread, 2). Nevertheless, 1) is still
>    necessary as a *reasonable optimization* but not the real fix any
>    more.

Well I altered this patch's changelog to tell readers that it is an
optimization.  But one does wonder why it isn't simply a bugfix. 
Attempting to migrate to a memoryless node is clearly as error. 
Presumably the called code handles it somehow, but in what fashion and
at what cost?

> 2) https://lkml.kernel.org/r/20240216111502.79759-1-byungchul@sk.com
> 
>    I found the root cause of the oops comes from using -1 as an array
>    index. So moved all the oops message, Fixes: tag, and cc stable to
>    here. Long story short, 2) is the *real fix* for the oops.
> 

