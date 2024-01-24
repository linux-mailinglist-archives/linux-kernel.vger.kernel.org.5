Return-Path: <linux-kernel+bounces-36975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6CB83A9B4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B86DB2355B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597786311D;
	Wed, 24 Jan 2024 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtxvU7aK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93660199B8;
	Wed, 24 Jan 2024 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099263; cv=none; b=uMw1B+pkMpx5dIUVLTpH5QR85NRxh6OS6X7q+iwelk+w1Dytnr2H+DOsaTnCuDHUNt+NNR0PglYp5KI0aSK5nlevFixGiU1Cwjyn2kYyOnJcN+0mti0hjmlCfUVccVvEsaXiDnbb7pNf8+vKzvGluLkZE3lz3m3H9KqVMESHMv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099263; c=relaxed/simple;
	bh=akPPMDTKbd3lNmgDCLSz3b0pXo7lZBIGndIz2Wv8+Ec=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=vAWp7a6LC2RvP4ttKQvm2quVycbY5yAUo/7b1tY/Lacof0JCOWN+rbxcxhexrW3eNRruLhbhei6NETW+yCDywucMDRTVIxXh9gmVi2wySa6Y8GHAtcDGSWJ8pHuOuIwXi1BwPRBs77XBxYPZb0aHq2n//aX0BRATvxM2A39AB7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtxvU7aK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31742C433C7;
	Wed, 24 Jan 2024 12:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706099263;
	bh=akPPMDTKbd3lNmgDCLSz3b0pXo7lZBIGndIz2Wv8+Ec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jtxvU7aKfyBYXcEuGEhEtbcb5X70eA1obVOGYOpynj3kySdXCRtqY0CRDhwyockXS
	 +yZTTtR2yyBH2Uq0HJzWN7vikBIHAm+Fexb58r0HoDqH9NoZ5L1maGuR/bKgO/8j/N
	 7itpDyENSZIQbsqVjBwiSTR4km1bKw7J5nktzSYZCTdMRfwq3CLrEltD+qCgJi4NEW
	 /bALjOK6A2oyiyyTBd8MYVCn2W3ncwo6AjRdb7FuQBdcjoDg+qct5h0lj52AGj71bt
	 rb3ktVYJ3l5xaJfuU72zr2t8x7slQfy9LGdv1JBqp2cNjcr7vSY9MlyQ+EtFfRJof2
	 7srKaG+SSy3Mg==
Date: Wed, 24 Jan 2024 21:27:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "yebin (H)" <yebin10@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/7] tracing/probes: support '%pd' type for print
 struct dentry's name
Message-Id: <20240124212738.04b1beee70ccf5b5148b2ac8@kernel.org>
In-Reply-To: <65B079F2.4000802@huawei.com>
References: <20240123092139.3698375-1-yebin10@huawei.com>
	<20240123092139.3698375-4-yebin10@huawei.com>
	<20240123234013.52b1834908da7be0272e7a73@kernel.org>
	<65B079F2.4000802@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 10:46:10 +0800
"yebin (H)" <yebin10@huawei.com> wrote:

> 
> 
> On 2024/1/23 22:40, Masami Hiramatsu (Google) wrote:
> > On Tue, 23 Jan 2024 17:21:35 +0800
> > Ye Bin <yebin10@huawei.com> wrote:
> >
> >> Similar to '%pd' for printk, use '%pd' for print struct dentry's name.
> >>
> >> Signed-off-by: Ye Bin <yebin10@huawei.com>
> >> ---
> >>   kernel/trace/trace_kprobe.c | 6 ++++++
> >>   kernel/trace/trace_probe.h  | 1 +
> >>   2 files changed, 7 insertions(+)
> >>
> >> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> >> index c4c6e0e0068b..00b74530fbad 100644
> >> --- a/kernel/trace/trace_kprobe.c
> >> +++ b/kernel/trace/trace_kprobe.c
> >> @@ -779,6 +779,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
> >>   	char buf[MAX_EVENT_NAME_LEN];
> >>   	char gbuf[MAX_EVENT_NAME_LEN];
> >>   	char abuf[MAX_BTF_ARGS_LEN];
> >> +	char dbuf[MAX_DENTRY_ARGS_LEN];
> > Hmm, no, I don't like to expand stack anymore. Please allocate it
> > from heap.
> Do I need to change the other buffers on the stacks to allocate memory 
> from heap?

No, that is not needed for this series, but if you want, you can :)

> >>   	struct traceprobe_parse_context ctx = { .flags = TPARG_FL_KERNEL };
> >>   
> >>   	switch (argv[0][0]) {
> >> @@ -930,6 +931,11 @@ static int __trace_kprobe_create(int argc, const char *argv[])
> >>   		argv = new_argv;
> >>   	}
> >>   
> >> +	ret = traceprobe_expand_dentry_args(argc, argv, dbuf,
> >> +					    MAX_DENTRY_ARGS_LEN);
> >> +	if (ret)
> >> +		goto out;
> > And calling this here will not cover the trace_fprobe.
> >
> > Could you call this from traceprobe_expand_meta_args() instead of
> > calling it directly from trace_kprobe? Then it can be used from
> > fprobe_event too.
> >
> > Thank you,
> At first I wanted to implement the extension logic in 
> traceprobe_expand_meta_args(),
> but I found that the code was difficult to understand when I started 
> writing.

Yeah, I also found that is a bit different usage.

> If fprobe_event
> wants to support this function, is traceprobe_expand_dentry_args() also 
> called?

Yes, it is for expanding '$arg*' into '$arg1 $arg2 ...'

> Or re-encapsulate
> an interface to include the logic of different extensions. In this way, 
> the same buffer is used for
> the entire extension process, and the extension function needs to return 
> the information about
> the length of the buffer.

OK, I confirmed that will be too much complicated. Then can you just call
it from where the traceprobe_expand_meta_args() is called, which is 
__trace_fprobe_create()@trace_fprobe.c ?

But those should be simplified later.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

