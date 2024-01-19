Return-Path: <linux-kernel+bounces-31327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0337E832C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE3F2824FB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E439E54BE2;
	Fri, 19 Jan 2024 15:51:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A63A54BCB;
	Fri, 19 Jan 2024 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705679483; cv=none; b=UDvy9nGg6Nu3qOTaZb5T9vvt96WKDHZJU8Ax+60Fob3rlKY+SZ8vs/E5Il9LuuNidR+sfZw0T07aC32t1AA8L89z0YK1oUwCNNiEwneUN52ZzxrWbCXfGIcNOAg8W5+CVdHhv0VNrGsRbqa6fNoMATYjFvJWPfOxpYSdgxgZ9aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705679483; c=relaxed/simple;
	bh=uL8bmAJV9MR6t5URe6D74sB4jCxEuSzYMTv3ufe3d70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nfr37f5UUcht8FEoIOH7AiwuzWcTfOzkqAPNFM0KW+JmYck2MdJpvv4gIKZxxIRNyFnSwJUiIztJoEJn3m8XxT7w9bd+1ydc/jP5vv98eV8K1aS9JFuC9il7j2k5Yy0jVA6IrpV+72jpiglC34W1V1LPqejrB3+PaivSnKmBhIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391F5C43394;
	Fri, 19 Jan 2024 15:51:22 +0000 (UTC)
Date: Fri, 19 Jan 2024 10:52:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Ye Bin <yebin10@huawei.com>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] support '%pd' and '%pD' for print file name
Message-ID: <20240119105243.05082e5b@gandalf.local.home>
In-Reply-To: <20240119234356.1598e760edbfa58f5440a941@kernel.org>
References: <20240119013848.3111364-1-yebin10@huawei.com>
	<20240119234356.1598e760edbfa58f5440a941@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jan 2024 23:43:56 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Thanks for your proposal!
> 
> Generically, I think this type of hack is not good for the tracing
> because there are already some ways to do that. e.g.
>  - Use perf probe to specify dentry->name:string or file->name:string 
>  - Use BTF to specify in the same way (but only for function entry)
> And those are more obvious what it does.
> 
> However, if this is implemented in more generic syntax, it will be
> acceptable.
> For example, type specifying with "arg1:printfmt(%pD)" will be
> more generic because it is apparently one of the printfmt and output
> string. Or, maybe we can just allow to use ":%pD" as a fetch type
> (start with '%' means the printfmt)

Yes, I like this idea a lot. Please add the '%' keyword/token to change how
to display this in the print format.

We may need to add more than one token though. Is that supported?

  $arg1:u32:%08x

or that could also be:

  $arg1:%08x:u32

That is, the order should not be important.

Thoughts?

-- Steve


> 
> Also, could you update readme_msg[] in kernel/trace/trace.c if
> you add a type, and add a testcase of selftests/ftrace, for this
> feature? Documentation should also be updated with more syntax
> information.

