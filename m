Return-Path: <linux-kernel+bounces-80580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BB38669EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64621C209A5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3BC1BC4A;
	Mon, 26 Feb 2024 06:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkhixDM4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC2A1B968;
	Mon, 26 Feb 2024 06:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708927783; cv=none; b=HWnigoYgZuo65Rua7v7ar/AkmJx3hI0ZojEMrNfObglieuqXavArT14341CL+WYh0kA4Zqu5lPq/5qtnpOLf66WBRWAZFgCh35gaJzrKxkiErjZQMvUsTP+GP6UWSu83SWyIz4uDpYK2Zpz2lOYFrg6cDWberUnWdvI8IPKDXjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708927783; c=relaxed/simple;
	bh=Wg0yZ4YD42v7JFgC4GCKHPnWFfnRgGsgvkto9DA5mpg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fkJAmbQUNi5I1rAzHZEpt/6TCc38k2oJXVVy8oTpJ8OfjGB4iRacwCrwkyjJvl9jKDET8sg8lwkG4fTCKve+YI/PE0WAc4CmsH7/LvcKazyOMfqBy5ZaBT1/wTZCkXsTlXeVtS6Z3KAbdJc+fMp9TG7cRPpzGNL2OIaXUDsIDcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkhixDM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E751C433C7;
	Mon, 26 Feb 2024 06:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708927782;
	bh=Wg0yZ4YD42v7JFgC4GCKHPnWFfnRgGsgvkto9DA5mpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NkhixDM4clXdmyPifKygz4j+8mlYVFKXuWlUHCsap8pE/3CxfUcMA7zlQ9gjkyxLy
	 Iv4TlijA9xZAQjIgBfU/gUL0uKcC2KdZ8vP8Y63SH/rMmULJFV982dYvrQMOmVHvFs
	 krod4G3aGgoLVClGpryu4iCyZhd5xRg9/ncYvfsKTXYxA0e9fWXewK56PDP9urJrSU
	 jV0g5KLYyIeB0giOvCK43Zpkl+/79BtrkDgCECZyPF5xSJkrf1MLAH2uYRBlc4Peih
	 I3ivGxIqTSSurO9cJFGrZrDwuVW16oNWCmAGi2bM2hB2mGpcGohfkm7dHrWchA5iNa
	 HpoO7UkPk/qxA==
Date: Mon, 26 Feb 2024 15:09:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] selftests/ftrace: Limit length in subsystem-enable
 tests
Message-Id: <20240226150938.7f0d8fd639bab79199d8556b@kernel.org>
In-Reply-To: <20240226031816.88715-1-xiangzao@linux.alibaba.com>
References: <20240226031816.88715-1-xiangzao@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 11:18:16 +0800
Yuanhe Shu <xiangzao@linux.alibaba.com> wrote:

> While sched* events being traced and sched* events continuously happen,
> "[xx] event tracing - enable/disable with subsystem level files" would
> not stop as on some slower systems it seems to take forever.
> Select the first 100 lines of output would be enough to judge whether
> there are more than 3 types of sched events.

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Hi Shuah, can you pick this as a fix?

Thank you,

> 
> Fixes: 815b18ea66d6 ("ftracetest: Add basic event tracing test cases")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
> ---
>  .../selftests/ftrace/test.d/event/subsystem-enable.tc       | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
> index b1ede6249866..b7c8f29c09a9 100644
> --- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
> +++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
> @@ -18,7 +18,7 @@ echo 'sched:*' > set_event
>  
>  yield
>  
> -count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
> +count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
>  if [ $count -lt 3 ]; then
>      fail "at least fork, exec and exit events should be recorded"
>  fi
> @@ -29,7 +29,7 @@ echo 1 > events/sched/enable
>  
>  yield
>  
> -count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
> +count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
>  if [ $count -lt 3 ]; then
>      fail "at least fork, exec and exit events should be recorded"
>  fi
> @@ -40,7 +40,7 @@ echo 0 > events/sched/enable
>  
>  yield
>  
> -count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
> +count=`head -n 100 trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
>  if [ $count -ne 0 ]; then
>      fail "any of scheduler events should not be recorded"
>  fi
> -- 
> 2.39.3
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

