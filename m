Return-Path: <linux-kernel+bounces-110119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633A4885A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948761C2158A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE7584FAB;
	Thu, 21 Mar 2024 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQcY/XZx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04AD58AA8;
	Thu, 21 Mar 2024 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029685; cv=none; b=KdR1IZeJwn04oRPW0dgALi7ShX96ZjAvxK5L63f0T+iWvwD+1GAd8sbzUgA2OXyIPaYdHje/e4xv3t+ajPkdgDt+Hyk8F/Z06dsLq82RFoynPR2TcgBkjCj2pTrwMDiexr0/cw3fPYvl6bLh4bt71UGJbvJS3mbxVsABdOQ/FDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029685; c=relaxed/simple;
	bh=mjkgvhCWGrB27Mwgl5C+Sb3MVYeWBRHoVzoOU2G3hu0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X07KAi9iv2NBe5qZgMRKRZZ5CRFM+zv1oJHazcZ2v53JW46y4lAoLcuaYKm1oTbMlrHoMzs7b2JfY3gtyjtvRB9i9QPPe8016XcC2sYUQljv+Bx0CdFGMzv2GM97FCkYnlQGlFVD3Sp3f70FeeelQBNxf6wY0UI/zANvAHXKnpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQcY/XZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EE4C43390;
	Thu, 21 Mar 2024 14:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711029685;
	bh=mjkgvhCWGrB27Mwgl5C+Sb3MVYeWBRHoVzoOU2G3hu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qQcY/XZxsoR9t7KTYXuEYyF1qmYP/r7oZlL0IKIwtkky1i/275hXClvYekEWSnlwH
	 Q3fPaSOCxj8mqSMxm+IcD3S6f4EpIa56HOMqPob2x8+2zyrra6U9riEe/y6s7SG9V5
	 zYmucCW7Lg0TNliZOASiGPTd6nwRcs2SkKYb01+N1Gbw9fCLNIL2txLe/G/Uhet6cj
	 pQjWp1ORoTWBj9AWiWTsmgZlthRskqkrHTybq2VLghYQ4xdUOMJk2Kp/a2UZzQNa/P
	 6OFaeSdq0gWXq9SCjP6ZaeW7L1QRTCz1tyAH12crYH2FMotozdYyRCZCSIdIGaAPgk
	 ltMLFrnOMZkZg==
Date: Thu, 21 Mar 2024 23:01:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/5] support '%pd' and '%pD' for print file name
Message-Id: <20240321230121.074b5058ff4cd97dd59a30ad@kernel.org>
In-Reply-To: <20240320132924.2802187-1-yebin10@huawei.com>
References: <20240320132924.2802187-1-yebin10@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ye,

On Wed, 20 Mar 2024 21:29:19 +0800
Ye Bin <yebin10@huawei.com> wrote:

> During fault locating, the file name needs to be printed based on the
> dentry/file address. The offset needs to be calculated each time, which
> is troublesome. Similar to printk, kprobe supports printing file names
> for dentry/file addresses.

Thanks for update! This series looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Let me pick this and test. 

Thank you!

> 
> Diff v7 vs v6:
> 1. Squash [1/8] to [3/8] patches into 1 patch;
> 2. Split readme_msg[] into each patch;
> 
> Diff v6 vs v5:
> 1. Add const for 'bufsize' in PATCH [1];
> 2. Move PATCH 'tracing/probes: support '%pd/%pD' type for fprobe' after
> PATCH "tracing/probes: support '%pd' type for print struct dentry's name".
> 3. Add requires '"%pd/%pD":README' for testcase.
> 
> Diff v5 vs v4:
> 1. Use glob_match() instead of str_has_suffix(), so remove the first patch;
> 2. Allocate buffer from heap for expand dentry;
> 3. Support "%pd/%pD" print type for fprobe;
> 4. Use $arg1 instead of origin register in test case;
> 5. Add test case for fprobe;
> 
> Diff v4 vs v3:
> 1. Use "argv[i][idx + 3] == 'd'" instead of "argv[i][strlen(argv[i]) - 1] == 'd'"
> to judge print format in PATCH[4/7];
> 
> Diff v3 vs v2:
> 1. Return the index of where the suffix was found in str_has_suffix();
> 
> Diff v2 vs v1:
> 1. Use "%pd/%pD" print format instead of "pd/pD" print format;
> 2. Add "%pd/%pD" in README;
> 3. Expand "%pd/%pD" argument before parameter parsing;
> 4. Add more detail information in ftrace documentation;
> 5. Add test cases for new print format in selftests/ftrace;
> 
> 
> Ye Bin (5):
>   tracing/probes: support '%pd' type for print struct dentry's name
>   tracing/probes: support '%pD' type for print struct file's name
>   Documentation: tracing: add new type '%pd' and '%pD' for kprobe
>   selftests/ftrace: add kprobe test cases for VFS type "%pd" and "%pD"
>   selftests/ftrace: add fprobe test cases for VFS type "%pd" and "%pD"
> 
>  Documentation/trace/kprobetrace.rst           |  8 ++-
>  kernel/trace/trace.c                          |  2 +-
>  kernel/trace/trace_fprobe.c                   |  6 ++
>  kernel/trace/trace_kprobe.c                   |  6 ++
>  kernel/trace/trace_probe.c                    | 63 +++++++++++++++++++
>  kernel/trace/trace_probe.h                    |  2 +
>  .../ftrace/test.d/dynevent/fprobe_args_vfs.tc | 40 ++++++++++++
>  .../ftrace/test.d/kprobe/kprobe_args_vfs.tc   | 40 ++++++++++++
>  8 files changed, 164 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_args_vfs.tc
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
> 
> -- 
> 2.31.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

