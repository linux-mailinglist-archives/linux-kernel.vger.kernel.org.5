Return-Path: <linux-kernel+bounces-116385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E01888964A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1B41C3000F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E55312BEB0;
	Mon, 25 Mar 2024 05:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDuph30O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC7613A242;
	Mon, 25 Mar 2024 01:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711331579; cv=none; b=DRtSFwQoXrqHndxpCAFnYezieUlTZw/RH4D7RGBahnnNijG0OHZk8+iJznheXH0TjCgYfPzk0JxHkicyuBlQm1FOAp3ngSnBIOU65MIAJYFtTXZFdvW3kFdzNNlZLR1zWYk0o6eR8vdzm0QAohST2GZfMlNoN7H4eZ3VxZGOO10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711331579; c=relaxed/simple;
	bh=9CybAqVXI7wUwrPLIFH1g82uXiok2SJVjKmOvPbOZC4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lcjdbNhGiCUgZCaWZbx0H9Uc5xE4RKoJUyy77Co/9RVtVbWBYRin4MnkPwBkuMP6NNlrSm9t0LMw2QoPk0QaW4OFjWYIA6uALZvQ5wPWM8axAQf4MfMPEDhq/uVsr0va9G/HwifLfEUvGwmopxCpFXD93DCDT1NGvfZlkYtOhE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDuph30O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543A7C433C7;
	Mon, 25 Mar 2024 01:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711331579;
	bh=9CybAqVXI7wUwrPLIFH1g82uXiok2SJVjKmOvPbOZC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bDuph30OW6lhh6J2GJ+ojf8/x2ql2EXUcrdFEYl4+4QRhmydWKkaSljhzyItvonPi
	 P7Uk9BVWJ8tXyPJpYZRBTqzE42lWotMY1D51Bwhc0s6/LncBbe+sjzezUUYlYlOMZA
	 gZGtyxcBRDxRg3D/obG4k50GRncXj/3MmTisyz2Bg065Kd12LiYJZ8qtEpsdTUEmLt
	 WU3008QY8ND1qxpv2AGoylcXFRJ1tLDeNZMTkSLrhlUu8f+2MpVG0GfRnvjmFMel7J
	 fXYJ0fydnqeGouPSqsxIfoRnkYESIbNQW8Bb0fJEz8vROEU6r+VFQuotwT9mlckPaF
	 ElJLrve/eqASQ==
Date: Mon, 25 Mar 2024 10:52:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/5] support '%pd' and '%pD' for print file name
Message-Id: <20240325105255.8b93f2c9673e08f4dec182ea@kernel.org>
In-Reply-To: <20240322064308.284457-1-yebin10@huawei.com>
References: <20240322064308.284457-1-yebin10@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 14:43:03 +0800
Ye Bin <yebin10@huawei.com> wrote:

> During fault locating, the file name needs to be printed based on the
> dentry/file address. The offset needs to be calculated each time, which
> is troublesome. Similar to printk, kprobe supports printing file names
> for dentry/file addresses.
> 

Hi Ye,

Thanks for update! There is a nit comment but basically OK.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Diff v8 vs v7:
> 1. Add detail change log for patch[1-2];
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

