Return-Path: <linux-kernel+bounces-80363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB19D86675D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5633428182A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 00:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594ED613D;
	Mon, 26 Feb 2024 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+9sOGih"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9765DA50;
	Mon, 26 Feb 2024 00:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708907612; cv=none; b=T16J92TLOx6/9rEcNAJRcck9u4qOMxL0D0wkfHojftuMxV3VGdKlZt24ed+4VPfA0jQ91uIL9F+IGEb+xbV7P+N+I1NLbbZa+Ak9m15paDvhxa1xSqmgBXSLaQLV6HRUesZQu0a5WOLZpmWbkF1+HSpypKDliUAWV/W0iuyjmX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708907612; c=relaxed/simple;
	bh=rtOU2lc+HsYOQndJ3MeM4Y/PfbFlHFZIKYRgh308J7g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HULNBaAPuliM49JaXGkuXYl63L1SD4S18qxxzVtj/hucFLnr/VNODK2+EOK9waa6lu6Au37MltBpLbcKWOftoKuJSTzT26QCnwiaVuI/71Js0GrwnclXgPAKtK9IuYaTsz16BndlpwljbKVmz3NtG1VpvcvrLcmYzYRBqVQ2ji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+9sOGih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4997C433F1;
	Mon, 26 Feb 2024 00:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708907612;
	bh=rtOU2lc+HsYOQndJ3MeM4Y/PfbFlHFZIKYRgh308J7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u+9sOGihObVs/ZbV4B7lN/zKJ9E6FMZjTg/o3rQKxrofuQD2TKgTOQoLNq4jpkjZ5
	 TaCzAHRmq0GmG3awjOztDqeSSy0grnDJJaw1Trs3fJ5aNm8Qy8p4m8TIX5o5Pd7Imp
	 zZ7SSGbGNJL819L4/9WEHrODwX3aXxWmZN/PiIL5kMBuzBpX8daXkp+jq7hNGn0CUT
	 ak6YlFJOPlIzQ2BUWCk2pg0Ltof9FdL237OwFCNznKhBJQybFJbqA2KNAe2qN/qdH7
	 eczI+d2zbMXkhUzgx5s1H9Z+obKwTOh+uMC1/BZ4lzixQUZ1Nr4mk4bFyqwdfkNcXU
	 t3Po/hCg5HfJA==
Date: Mon, 26 Feb 2024 09:33:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] tracing: Add warning if string in __assign_str()
 does not match __string()
Message-Id: <20240226093328.3022e75eb1d349aca51029cd@kernel.org>
In-Reply-To: <20240223161356.63b72403@gandalf.local.home>
References: <20240223161356.63b72403@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 16:13:56 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> In preparation to remove the second parameter of __assign_str(), make sure
> it is really a duplicate of __string() by adding a WARN_ON_ONCE().
> 

Looks good to me. So eventually this is removed when the second parameter
is removed?

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240223154821.77b2426d@gandalf.local.home/
> 
> - If src is NULL it is saved as NULL, no need to not test that too.
> 
>  include/trace/stages/stage6_event_callback.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
> index 0c0f50bcdc56..935608971899 100644
> --- a/include/trace/stages/stage6_event_callback.h
> +++ b/include/trace/stages/stage6_event_callback.h
> @@ -35,6 +35,7 @@
>  	do {								\
>  		char *__str__ = __get_str(dst);				\
>  		int __len__ = __get_dynamic_array_len(dst) - 1;		\
> +		WARN_ON_ONCE((src) != __data_offsets.dst##_ptr_);	\
>  		memcpy(__str__, __data_offsets.dst##_ptr_ ? :		\
>  		       EVENT_NULL_STR, __len__);			\
>  		__str__[__len__] = '\0';				\
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

