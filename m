Return-Path: <linux-kernel+bounces-110198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CC9885B67
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7702DB23D75
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0018615A;
	Thu, 21 Mar 2024 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V45EFkmi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0F785943;
	Thu, 21 Mar 2024 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033683; cv=none; b=di7mZM8oNIJshm0AGpaudQhl6X5ZaoPyHjCZAyRZjIe/nhvJ5F1zMRvj/goFy8YjCPUNcD4KrT7HoRFjUQBWK3BAS8/gp+jySBNdLRaQc7uytZY7iN/sNFUnzbzj3oM/nccS9dj+G1WumMIY5toR5Ix1V7oVd328Et2ffJ6RYno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033683; c=relaxed/simple;
	bh=kczXDJweyGTIC8tzWtWD2AZb+o9Us2JG2kLARbHa5cQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Xl80bmu2UlcdAanNCdTyv0JuUfqdkuNwV6SRBWyKKqaMGWs/WtO+ihcimxHLkf4VX/NobgvrgWw5qsmBIkcwVA1f/QBsY+BZNI6fzgY0CJFbCPn1ohMt2QzRZuyCglbMswDdqKQJMUfYBEKP+fKutRvkJ8HF457fO/fROSKqoXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V45EFkmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F182C433C7;
	Thu, 21 Mar 2024 15:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711033683;
	bh=kczXDJweyGTIC8tzWtWD2AZb+o9Us2JG2kLARbHa5cQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V45EFkmiuP2VpKwzezCuW5lPt2r4tM7xH52efB91sQJKIZwTAjaPnR3kUelvFPhPW
	 24NiVWe+Dy+ONOiL8OkYxlyPeXPglplFry7sJsWMnw5eycG0iMwvQ7BWL8O/tgafJd
	 LcTL23WnTtAO8dsNH8pe3GZqav19DU8FNn8VZITXTQoM7B6XaeICBtq8HB0WoL1tjH
	 +URtM/OuvbNNY3/DuBtIQ/GbGlAt85lfgbWuMaGM9h8eV+RJecWZwVPcZmGvGxkiNG
	 k1HGzhYMmf1/GP2AwOiOQRjWRXxq7ldaUCcgiFL+oguNWKc442sxxgMGzX56Fn8vNt
	 3HY3BPZeN8SUw==
Date: Fri, 22 Mar 2024 00:07:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ye Bin <yebin10@huawei.com>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/5] tracing/probes: support '%pd' type for print
 struct dentry's name
Message-Id: <20240322000759.ec04bca3bb2afdfaef37a545@kernel.org>
In-Reply-To: <20240321101547.1f4e68ab@gandalf.local.home>
References: <20240320132924.2802187-1-yebin10@huawei.com>
	<20240320132924.2802187-2-yebin10@huawei.com>
	<20240321101547.1f4e68ab@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 10:15:47 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 20 Mar 2024 21:29:20 +0800
> Ye Bin <yebin10@huawei.com> wrote:
> 
> > Support print type '%pd' for print dentry's  name.
> > 
> 
> The above is not a very detailed change log. A change log should state not
> only what the change is doing, but also why.
> 
> Having examples of before and after would be useful in the change log.

Hm, OK. Ye, something like this.
-----
Support print type '%pd' for print dentry's name. For example "name=$arg1:%pd"
casts the `$arg1` as (struct dentry *), dereferences the "d_name.name" field
and stores it to "name" argument as a kernel string. Here is an example;

echo 'p:testprobe dput name=$arg1:%pd' > kprobe_events 
echo 1 > events/kprobes/testprobe/enable 
cat trace
..
              sh-132     [004] .....   333.333051: testprobe: (dput+0x4/0x20) name="enable"


Note that this expects the given argument (e.g. $arg1) is an address of struct
dentry. User must ensure it.
-----

And add similar changelog on [2/5]. 

Thank you,

> 
> > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > ---
> >  kernel/trace/trace.c        |  2 +-
> >  kernel/trace/trace_fprobe.c |  6 +++++
> >  kernel/trace/trace_kprobe.c |  6 +++++
> >  kernel/trace/trace_probe.c  | 50 +++++++++++++++++++++++++++++++++++++
> >  kernel/trace/trace_probe.h  |  2 ++
> >  5 files changed, 65 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index b12f8384a36a..ac26b8446337 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> 
> 
> > +/* @buf: *buf must be equal to NULL. Caller must to free *buf */
> > +int traceprobe_expand_dentry_args(int argc, const char *argv[], char **buf)
> > +{
> > +	int i, used, ret;
> > +	const int bufsize = MAX_DENTRY_ARGS_LEN;
> > +	char *tmpbuf = NULL;
> > +
> > +	if (*buf)
> > +		return -EINVAL;
> > +
> > +	used = 0;
> > +	for (i = 0; i < argc; i++) {
> > +		if (glob_match("*:%pd", argv[i])) {
> > +			char *tmp;
> > +			char *equal;
> > +
> > +			if (!tmpbuf) {
> > +				tmpbuf = kmalloc(bufsize, GFP_KERNEL);
> > +				if (!tmpbuf)
> > +					return -ENOMEM;
> > +			}
> > +
> > +			tmp = kstrdup(argv[i], GFP_KERNEL);
> > +			if (!tmp)
> > +				goto nomem;
> > +
> > +			equal = strchr(tmp, '=');
> > +			if (equal)
> > +				*equal = '\0';
> > +			tmp[strlen(argv[i]) - 4] = '\0';
> > +			ret = snprintf(tmpbuf + used, bufsize - used,
> > +				       "%s%s+0x0(+0x%zx(%s)):string",
> > +				       equal ? tmp : "", equal ? "=" : "",
> > +				       offsetof(struct dentry, d_name.name),
> > +				       equal ? equal + 1 : tmp);
> 
> What would be really useful is if we had a way to expose BTF here. Something like:
> 
>  "%pB:<struct>:<field>"
> 
> The "%pB" would mean to look up the struct/field offsets and types via BTF,
> and create the appropriate command to find and print it.

Would you mean casing the pointer to "<struct>"?


> 
> That would be much more flexible and useful as it would allow reading any
> field from any structure without having to use gdb.
> 
> -- Steve
> 
> 
> > +			kfree(tmp);
> > +			if (ret >= bufsize - used)
> > +				goto nomem;
> > +			argv[i] = tmpbuf + used;
> > +			used += ret + 1;
> > +		}
> > +	}
> > +
> > +	*buf = tmpbuf;
> > +	return 0;
> > +nomem:
> > +	kfree(tmpbuf);
> > +	return -ENOMEM;
> > +}
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

