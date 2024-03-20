Return-Path: <linux-kernel+bounces-108775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5E3880FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D997FB24162
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5723F3EA92;
	Wed, 20 Mar 2024 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWHJny5Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E2920DCC;
	Wed, 20 Mar 2024 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930439; cv=none; b=e0nS/NrsCrPO908cuuXLk40DWCnBgVjYaL1U/6wQpktjIlJMlca0Du6+UnC8Oplt7Kt7hkrc1PBRGVS9IS5JBS++R+3pvw3vkziNdfa5GZ82odG1wRcqKR8VfojoisA28FaNZARCkOzSw3TXsn0y0/GA5dpbYVrvTJtt0HwyAIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930439; c=relaxed/simple;
	bh=m+ppsTnGG/Ma89URp1KraJSSqmWDFSiBo+T3M7bu1o8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UGg7cg4O3zaA+zfISkWiOXbbdCrNimnIBWNpaL9E2mZPXLGkdQGvzogHDD3aAzX91CSblHNgnsf91GMq2A+yOqX/Gz8lQVD4EUBj0ggZwUZxehtUOEfQH0ya+a7aXV1155/oMKfnUvNC7NcIJjXS81Y2rIXQjq8qXCVQ4RTfPqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWHJny5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D84C433C7;
	Wed, 20 Mar 2024 10:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710930439;
	bh=m+ppsTnGG/Ma89URp1KraJSSqmWDFSiBo+T3M7bu1o8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mWHJny5ZLy9yEA/AkzesaYpVIzr+sIW4vhtLD4fFv7bDtLaFaZ6rEnWsFv0ESydIx
	 mQsA0l01rrgK+qB7QbkqYYyQMr0WSG/ObQt0PZtggUE9WRaWbV268Y2OdP76WtGIBU
	 3lJWwT6RjVE28qYB8b1e8qZ0HAYRTLji9nm9YkWGd5FV2OP/r9ymmwF5vYNChq6r3E
	 Wg5UJ+LqJVJzqMPCPm5GW3TqCj/t8879o5Xgbx9RYDskVmoydZxFHuOVY/wU+juMd3
	 WbBYwi7cPYLTh4arX8x236cUDqH9tq7aRgBvatbtWVCKzQoDhxOU1AtVOImzIKE5Zh
	 gUbdJLtfX41/Q==
Date: Wed, 20 Mar 2024 19:27:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Explicitly cast divisor to fix Coccinelle
 warning
Message-Id: <20240320192715.22eeeba84c0fd3a8c2353c79@kernel.org>
In-Reply-To: <20240318105243.117911-2-thorsten.blum@toblux.com>
References: <20240318105243.117911-2-thorsten.blum@toblux.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Mar 2024 11:52:44 +0100
Thorsten Blum <thorsten.blum@toblux.com> wrote:

> Explicitly cast the divisor to u32 to fix a Coccinelle/coccicheck warning
> reported by do_div.cocci.
> 

Hmm, strange, trace_do_benchmark() has another do_div(u64, u64). 

                do {
                        last_seed = seed;
                        seed = stddev;
                        if (!last_seed)
                                break;
                        do_div(seed, last_seed);
                        seed += last_seed;
                        do_div(seed, 2);
                } while (i++ < 10 && last_seed != seed);

Didn't Coccinelle find that?

Thank you,

> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  kernel/trace/trace_benchmark.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
> index 54d5fa35c90a..218b40050629 100644
> --- a/kernel/trace/trace_benchmark.c
> +++ b/kernel/trace/trace_benchmark.c
> @@ -105,7 +105,7 @@ static void trace_do_benchmark(void)
>  		stddev = 0;
>  
>  	delta = bm_total;
> -	do_div(delta, bm_cnt);
> +	do_div(delta, (u32)bm_cnt);
>  	avg = delta;
>  
>  	if (stddev > 0) {
> -- 
> 2.44.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

