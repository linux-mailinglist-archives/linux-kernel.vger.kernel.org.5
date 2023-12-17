Return-Path: <linux-kernel+bounces-2495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 458A6815DE0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 08:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209FB1C219C3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 07:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F511860;
	Sun, 17 Dec 2023 07:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2ERO6rX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C771849;
	Sun, 17 Dec 2023 07:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCC2C433C7;
	Sun, 17 Dec 2023 07:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702797485;
	bh=X6xpH21gdd4WYGs0usyDoYV2mF1KI4snptAZ8ED9dFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s2ERO6rXkv/Uv6ozdFecOVOeBxANLoarwv9SEJiOWQ8ij0sBCfRLfAK0JFBkzP1XR
	 1vwvW+ZjGdGd+YP3KcFWSnZQtSlTIejbmp+oDyCbgcM/SXaRe2HOPysgA3bsLabTxx
	 1TyruoFuNkv3zOIHSBkz/o339La5elklUJckzjxAVOr+O0FJuAj0+LK/O684PkWhYi
	 Un+7DCss85FydP2Kex1HmSFFOw1YzCP8szf5OZejs3TGF30BFQPLsLg/2cyzel6R4H
	 MrvA7wXSjB40LQeSJf5Il8piTtHeMAmCGtFjpjAcM74ZK871MUSpgRwQSmBtLxqHih
	 DA7rUuk5EKC9w==
Date: Sun, 17 Dec 2023 16:18:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Naveen N Rao <naveen@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Srikar Dronamraju <srikar@linux.ibm.com>
Subject: Re: [PATCH v4] trace/kprobe: Display the actual notrace function
 when rejecting a probe
Message-Id: <20231217161801.ec0121c047c163a772cfce1c@kernel.org>
In-Reply-To: <20231214051702.1687300-1-naveen@kernel.org>
References: <20231214051702.1687300-1-naveen@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 10:47:02 +0530
Naveen N Rao <naveen@kernel.org> wrote:

> Trying to probe update_sd_lb_stats() using perf results in the below
> message in the kernel log:
> 	trace_kprobe: Could not probe notrace function _text
> 
> This is because 'perf probe' specifies the kprobe location as an offset
> from '_text':
> 	$ sudo perf probe -D update_sd_lb_stats
> 	p:probe/update_sd_lb_stats _text+1830728
> 
> However, the error message is misleading and doesn't help convey the
> actual notrace function that is being probed. Fix this by looking up the
> actual function name that is being probed. With this fix, we now get the
> below message in the kernel log:
> 	trace_kprobe: Could not probe notrace function update_sd_lb_stats.constprop.0
> 

OK, this looks good to me. let me pick this.

Thank you!

> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> ---
> v4: Use printk format specifier %ps with probe address to lookup the 
> symbol, as suggested by Masami.
> 
>  kernel/trace/trace_kprobe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 3d7a180a8427..0017404d6e8d 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -487,8 +487,8 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
>  		return -EINVAL;
>  
>  	if (within_notrace_func(tk)) {
> -		pr_warn("Could not probe notrace function %s\n",
> -			trace_kprobe_symbol(tk));
> +		pr_warn("Could not probe notrace function %ps\n",
> +			(void *)trace_kprobe_address(tk));
>  		return -EINVAL;
>  	}
>  
> 
> base-commit: 4758560fa268cecfa1144f015aa9f2525d164b7e
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

