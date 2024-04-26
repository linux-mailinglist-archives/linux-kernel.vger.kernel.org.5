Return-Path: <linux-kernel+bounces-160271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5615A8B3B27
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085851F2570D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAD916FF3B;
	Fri, 26 Apr 2024 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNSqnhOC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BB6158D93;
	Fri, 26 Apr 2024 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144728; cv=none; b=IOxGYtk/r7jaVaixKz47+5rtP5GKrcHp2DFBtqzKwLezB2Hn9TyyIoQwVtqNQLjgX9kTSuQxe5pQVgnZ3pBDPIF+efKLD0w+cykSNbAn7QwJynCTpGQDNTPl+neWxzSalLuafyTlvCMTbz6HeL+jFeVy14FiNJqD22NVGnZK3ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144728; c=relaxed/simple;
	bh=1UnZiC3comG4gnEVIiUSo4RJz2Uq3SHSFq173Rv99mU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sGB3K8KXCnlVDbdPjrq1sVsRlmGhBAsTR4CjVAgmemt6qEm3EZzNK4wBx5WwUdKApS8Y3yjb8o4S1l38I17iHa0hCX3rWzZc5hOhwFPpnlQL0wMAxIidhgwlimF3WnrWCVrL0VGIIDmqMs0OUL0NZI+zg4EOdlpIrPwCZX1tGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNSqnhOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63A7C2BD11;
	Fri, 26 Apr 2024 15:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714144727;
	bh=1UnZiC3comG4gnEVIiUSo4RJz2Uq3SHSFq173Rv99mU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mNSqnhOCvVS96laJVrGaGieiyUBAaw7BIIZlQfWJmTtK+o3CRYgilXqax2Q6jFiHb
	 Tkr6khA10hRkujz93BoR88ndIAwlrA0cIr29DtMM/oUSb4BbCWO2xFtmfLxyizgcCi
	 4gZ/C5jQlPnsiBL0F0F4yvbOiva3OAJdCblKfHnnwiVKprBKA7nzRmDRSSlwlLtu64
	 LN2KpL7Hy+MAZWbwNyKe863P9JI9g21F/w3YZn3KuPgVo0JCuXYwi5a9ah53d1KoFk
	 t8qQpCyYncg1/PuC40GaaWT23jN9CdLc0JCAYfZzRsVwf+n9QaHNFcS74kWGCAaFff
	 HgV2PKKVeTjpg==
Date: Sat, 27 Apr 2024 00:18:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: lumingyindetect@126.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
Subject: Re: [PATCH] kernel/trace/trace_probe:Fixed memory leak issues in
 trace_probe.c.
Message-Id: <20240427001843.84a3d367d3654b624c09defe@kernel.org>
In-Reply-To: <20240426091343.1222770-1-lumingyindetect@126.com>
References: <20240426091343.1222770-1-lumingyindetect@126.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi LuMingYin,

Thanks for finding the problem! But please make a commit message
following Documentation/process/submitting-patches.rst


On Fri, 26 Apr 2024 10:13:43 +0100
lumingyindetect@126.com wrote:

> From: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
> 
> At line 1408 of the file /linux/kernel/trace/trace_probe.c, pointer variables named code and tmp are defined. At line 1437, a new dynamic memory area is allocated using the function kcalloc. When the if statement at line 1467 evaluates to true, the program jumps to the out label at line 1469. Within this function, there are two labels: out and fail. The difference between these two labels is that fail additionally frees the dynamic memory area pointed to by the variable code. Therefore, the program should jump to the fail label instead of the out label. This commit fixes this bug.
> 

For example, you must line break after about 70 characters. Also,
please don't use the line number because the line number is easily
changed (function name is OK). Since this bug is very clear mistake,
so you can just explain that as following.

----
 If traceprobe_parse_probe_arg_body() fails to allocate 'parg->fmt', it
 jumps to 'out' instead of 'fail' by mistake. In the result, in this
 case the 'tmp' buffer is not freed and leaks its memory.

 Fix it by jumping to 'fail' in that case.
----
The first paragraph explains what happens, and second one to exaplain
how to fix it.

Also, please add this Fixes tag.

Fixes: 032330abd08b ("tracing/probes: Cleanup probe argument parser")

You can easily find this commit number with git blame.

Thank you,

> Signed-off-by: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
> ---
>  kernel/trace/trace_probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index dfe3ee6035ec..42bc0f362226 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -1466,7 +1466,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
>  		parg->fmt = kmalloc(len, GFP_KERNEL);
>  		if (!parg->fmt) {
>  			ret = -ENOMEM;
> -			goto out;
> +			goto fail;
>  		}
>  		snprintf(parg->fmt, len, "%s[%d]", parg->type->fmttype,
>  			 parg->count);
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

