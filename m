Return-Path: <linux-kernel+bounces-106590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DEA87F0B3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615FA28385D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7594957862;
	Mon, 18 Mar 2024 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ceug2BPQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA9155C14
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792048; cv=none; b=GuDzhRwGuh0kuN9riZlXYZML6wCfho5Hr5WZ9XO/ZWPpJbA2DZHnFbuA3032uaSpz8VYkhRKjuhXJxjLcgIfw26T6dWbeL5Gpdbz/dRHkJutEdcHJ9JuxNLwyXk+hXQ9Y1SiZsZWo/ArqJxi6012p2D8t9EcfYMj0oeZkJcmEJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792048; c=relaxed/simple;
	bh=el0HPdAPF4mHn0BlNYeNhSj/Fplf86ilRk12/hHw6cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDa2MmxcDS3I1zDO5i4Avii0hm9D7QXkY4LA0zkH0NUlDv2n7ednckwDzzBiPWMjQlVN9vi58equIxr0OQMgdGT9FRa8xctwEbkeOevziZvHQVTHCg/+iMvZPNxTQjJ18UtDycRhgFKv5TZSALHDbq2uL+jhlpyCkvwW4sEFUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ceug2BPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE556C433C7;
	Mon, 18 Mar 2024 20:00:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ceug2BPQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1710792045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x/ouslTaGHLCxb1m+bGhdTdK1PrUUCc7ZDIw9C0aeXY=;
	b=ceug2BPQdk5IAlFjKlflM+G9KtwVWLB93z8vnCZtBAbfbqZIn5P8Hv+q61AMG9xV1Kulz8
	P7fnBvzrGFm9KRmIKizhg0LM5oOUlWn5xbnKQuSRVTmy9fd8T+1hhQWeNEX2CYzE1Sk7w8
	jD/XacaQSEOhyjssoqUtuaXsFyM35UY=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b4eb4cb4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Mar 2024 20:00:44 +0000 (UTC)
Date: Mon, 18 Mar 2024 21:00:42 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Guoyong Wang <guoyong.wang@mediatek.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH] random: Fix the issue of '_might_sleep' function running
 in an atomic contex
Message-ID: <Zfidal8CEZStp3R7@zx2c4.com>
References: <20240318075327.26318-1-guoyong.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240318075327.26318-1-guoyong.wang@mediatek.com>

Hi Guoyong,

On Mon, Mar 18, 2024 at 03:53:27PM +0800, Guoyong Wang wrote:
> 'input_handle_event' runs in an atomic context
> (spinlock). In rare instances, it may call
> the '_might_sleep' function, which could trigger
> a kernel exception.
> 
> Backtrace:
>   [<ffffffd613025ba0>] die+0xa8/0x2fc
>   [<ffffffd613027428>] bug_handler+0x44/0xec
>   [<ffffffd613016964>] brk_handler+0x90/0x144
>   [<ffffffd613041e58>] do_debug_exception+0xa0/0x148
>   [<ffffffd61400c208>] el1_dbg+0x60/0x7c
>   [<ffffffd61400c000>] el1h_64_sync_handler+0x38/0x90
>   [<ffffffd613011294>] el1h_64_sync+0x64/0x6c
>   [<ffffffd613102d88>] __might_resched+0x1fc/0x2e8
>   [<ffffffd613102b54>] __might_sleep+0x44/0x7c
>   [<ffffffd6130b6eac>] cpus_read_lock+0x1c/0xec
>   [<ffffffd6132c2820>] static_key_enable+0x14/0x38
>   [<ffffffd61400ac08>] crng_set_ready+0x14/0x28
>   [<ffffffd6130df4dc>] execute_in_process_context+0xb8/0xf8
>   [<ffffffd61400ab30>] _credit_init_bits+0x118/0x1dc
>   [<ffffffd6138580c8>] add_timer_randomness+0x264/0x270
>   [<ffffffd613857e54>] add_input_randomness+0x38/0x48
>   [<ffffffd613a80f94>] input_handle_event+0x2b8/0x490
>   [<ffffffd613a81310>] input_event+0x6c/0x98

Thanks for reporting this.

I'm wondering, though, rather than introducing a second function, maybe
execute_in_process_context() should just gain a `&& !in_atomic()`.
That'd make things a bit simpler.

However, I'm pretty sure in_atomic() isn't actually a reliable way of
determining that, depending on config. So maybe this should just call
the worker always (if system_wq isn't null).

Alternatively, any chance the call to add_input_randomness() could be
moved outside the spinlock, or does this not look possible?

Jason

