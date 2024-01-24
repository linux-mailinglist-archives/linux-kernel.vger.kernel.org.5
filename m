Return-Path: <linux-kernel+bounces-37799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9FC83B597
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C96AFB22641
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EAA136666;
	Wed, 24 Jan 2024 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9crZG72"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AFF7E771;
	Wed, 24 Jan 2024 23:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706139055; cv=none; b=Wiola5iWRZlEqml3cuGri2osA+6u+GC9/cyatCBnbXbjuZhdqEGf3HMU22dOeNbDHBZN/Tyg+m56hyGMJ9xwqp0/aOprKbML3Gn17uvjT/fynASlgqrBeYG1XyILQgoM7laFwhQA6QKzt1Q8IgERCR7LGwUognWpYh35feiA3o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706139055; c=relaxed/simple;
	bh=soJQajv5hWHBtkP0ngNF1lxQ1aDvaD2aJ71sXUKd0QA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PNEMyhREqgCggtqIgapRcQqQNusThfpJd/TTysLjd6VXwsIfCYsC4HfRKqW4gcADnqdTC0C3KL4EEyrJ5e74Wjcnh2LzDpxQLhZEN9diH3w8kZsqVxpQRcGKAisEHPZzRBWxb3GJbKb12Gtpv3hKAXT4LHulNeTjPEMdOkE4GFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9crZG72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9C9C433F1;
	Wed, 24 Jan 2024 23:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706139054;
	bh=soJQajv5hWHBtkP0ngNF1lxQ1aDvaD2aJ71sXUKd0QA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p9crZG72VtU5pUkqjebisl7t/RKPEgqzRTPCS3ml4IGxH7I610DGn1lciTuQMNsNV
	 lAwQH/c+6Y3JmfShX9uPu8nBSSV2bOl9uiTGE+jXqsW69cu8ms5aX4uABgIhNEsHKD
	 nxV5PrsNMK9m91vkY737KJYVOBgMMW3QKUA0eM/opZQfAdeqW4fK36//0S5UXi0MLJ
	 vN7GgYtKvNBmtlcDf4qlMqs56b+PwQ9692oDVlxnKUZ78SLZWhBUpQfHz8ou4cLvT/
	 wWhVwMN9yGofau+YDRwn5NY4AA5/N5jiAkgwIGu+isUlyIw8kD9l0wWbnd5lke6f9t
	 9k9Kd7OetCxFg==
Date: Thu, 25 Jan 2024 08:30:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "yebin (H)" <yebin10@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 7/7] selftests/ftrace: add test cases for VFS type
 "%pd" and "%pD"
Message-Id: <20240125083050.5aca0f58c3936206ec1827f9@kernel.org>
In-Reply-To: <65B08249.6050704@huawei.com>
References: <20240123092139.3698375-1-yebin10@huawei.com>
	<20240123092139.3698375-8-yebin10@huawei.com>
	<20240124103201.6dd8d466b1b734796418c1c4@kernel.org>
	<65B08249.6050704@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 11:21:45 +0800
"yebin (H)" <yebin10@huawei.com> wrote:

> 
> 
> On 2024/1/24 9:32, Masami Hiramatsu (Google) wrote:
> > On Tue, 23 Jan 2024 17:21:39 +0800
> > Ye Bin <yebin10@huawei.com> wrote:
> >
> >> This patch adds test cases for new print format type "%pd/%pD".The test cases
> >> test the following items:
> >> 1. Test README if add "%pd/%pD" type;
> >> 2. Test "%pd" type for dput();
> >> 3. Test "%pD" type for vfs_read();
> >>
> >> Signed-off-by: Ye Bin <yebin10@huawei.com>
> >> ---
> >>   .../ftrace/test.d/kprobe/kprobe_args_vfs.tc   | 79 +++++++++++++++++++
> >>   1 file changed, 79 insertions(+)
> >>   create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
> >>
> >> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
> >> new file mode 100644
> >> index 000000000000..1d8edd294dd6
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
> >> @@ -0,0 +1,79 @@
> >> +#!/bin/sh
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# description: Kprobe event VFS type argument
> >> +# requires: kprobe_events
> >> +
> >> +case `uname -m` in
> >> +x86_64)
> >> +  ARG1=%di
> >> +;;
> >> +i[3456]86)
> >> +  ARG1=%ax
> >> +;;
> >> +aarch64)
> >> +  ARG1=%x0
> >> +;;
> >> +arm*)
> >> +  ARG1=%r0
> >> +;;
> >> +ppc64*)
> >> +  ARG1=%r3
> >> +;;
> >> +ppc*)
> >> +  ARG1=%r3
> > You can merge this ppc* and ppc64* cases :)
> >
> >> +;;
> >> +s390*)
> >> +  ARG1=%r2
> >> +;;
> >> +mips*)
> >> +  ARG1=%r4
> >> +;;
> >> +loongarch*)
> >> +  ARG1=%r4
> >> +;;
> >> +riscv*)
> >> +  ARG1=%a0
> > Anyway, I wonder why don't you use '$arg1' instead of these registers.
> > Is there any reason?
> >
> > Thank you,
> I looked at the parameter parsing code again, and using "$arg1" requires 
> the kernel to
> enable the CONFIG_HAVE_FUNCTION_ARG_ACCESS_API configuration.

Yes, and it is recommended (required) for supporting kprobe event
via ftrace. So, if you see any error on this test, that machine should
implement it.

Thank you,

> >> +;;
> >> +*)
> >> +  echo "Please implement other architecture here"
> >> +  exit_untested
> >> +esac
> >> +
> >> +: "Test argument %pd/%pD in README"
> >> +grep -q "%pd/%pD" README
> >> +
> >> +: "Test argument %pd with name"
> >> +echo "p:testprobe dput name=${ARG1}:%pd" > kprobe_events
> >> +echo 1 > events/kprobes/testprobe/enable
> >> +grep -q "1" events/kprobes/testprobe/enable
> >> +echo 0 > events/kprobes/testprobe/enable
> >> +grep "dput" trace | grep -q "enable"
> >> +echo "" > kprobe_events
> >> +echo "" > trace
> >> +
> >> +: "Test argument %pd without name"
> >> +echo "p:testprobe dput ${ARG1}:%pd" > kprobe_events
> >> +echo 1 > events/kprobes/testprobe/enable
> >> +grep -q "1" events/kprobes/testprobe/enable
> >> +echo 0 > events/kprobes/testprobe/enable
> >> +grep "dput" trace | grep -q "enable"
> >> +echo "" > kprobe_events
> >> +echo "" > trace
> >> +
> >> +: "Test argument %pD with name"
> >> +echo "p:testprobe vfs_read name=${ARG1}:%pD" > kprobe_events
> >> +echo 1 > events/kprobes/testprobe/enable
> >> +grep -q "1" events/kprobes/testprobe/enable
> >> +echo 0 > events/kprobes/testprobe/enable
> >> +grep "vfs_read" trace | grep -q "enable"
> >> +echo "" > kprobe_events
> >> +echo "" > trace
> >> +
> >> +: "Test argument %pD without name"
> >> +echo "p:testprobe vfs_read ${ARG1}:%pD" > kprobe_events
> >> +echo 1 > events/kprobes/testprobe/enable
> >> +grep -q "1"  events/kprobes/testprobe/enable
> >> +echo 0 > events/kprobes/testprobe/enable
> >> +grep "vfs_read" trace | grep -q "enable"
> >> +echo "" > kprobe_events
> >> +echo "" > trace
> >> -- 
> >> 2.31.1
> >>
> >
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

