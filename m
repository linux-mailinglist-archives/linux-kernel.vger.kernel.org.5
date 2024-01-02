Return-Path: <linux-kernel+bounces-14775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0094D822206
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10BFD1C22A3C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D66415E98;
	Tue,  2 Jan 2024 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EPh7L4Hw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDF916400;
	Tue,  2 Jan 2024 19:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C833CC433C8;
	Tue,  2 Jan 2024 19:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1704223878;
	bh=PpLk4en3PtlVWanOtZnA79EAQW/E6LW7oiPi+rIhTNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EPh7L4HwyIMY5uAmrct1hUT1x9Yd6UGYe6iZryQlAtjyyXi2g62Pxy0ZRO7vhWK7W
	 H1aRiwc1bkii6twji3wm70/PYmDYLPnzpIGo0PebFpzhFNi1aGRkzHG5tdkCDJww+D
	 Q99tIo5e+bBb5jlMMlJGiXI0ZF2PFttzFEdyamXw=
Date: Tue, 2 Jan 2024 11:31:17 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, Ahelenia =?UTF-8?Q?Ziemia=C5=84ska?=
 <nabijaczleweli@nabijaczleweli.xyz>, Li kunyu <kunyu@nfschina.com>, Michal
 Hocko <mhocko@suse.com>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Suren Baghdasaryan <surenb@google.com>,
 Zhang Zhengming <zhang.zhengming@h3c.com>, Zhou Kete <zhou.kete@h3c.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel: relay: Improve exception handling in
 relay_create_buf()
Message-Id: <20240102113117.b2b4ffa2998eb51b674b0304@linux-foundation.org>
In-Reply-To: <ef8b36bf-d9d7-46a4-9648-7cc8aaa8a980@web.de>
References: <ef8b36bf-d9d7-46a4-9648-7cc8aaa8a980@web.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Dec 2023 10:38:10 +0100 Markus Elfring <Markus.Elfring@web.de> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 31 Dec 2023 10:26:25 +0100
> 
> The kfree() function was called in one case by
> the relay_create_buf() function during error handling
> even if the passed data structure member contained a null pointer.
> This issue was detected by using the Coccinelle software.
> 
> Thus use another label.
> 
> ...
>
> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -161,14 +161,15 @@ static struct rchan_buf *relay_create_buf(struct rchan *chan)
> 
>  	buf->start = relay_alloc_buf(buf, &chan->alloc_size);
>  	if (!buf->start)
> -		goto free_buf;
> +		goto free_padding;
> 
>  	buf->chan = chan;
>  	kref_get(&buf->chan->kref);
>  	return buf;
> 
> -free_buf:
> +free_padding:
>  	kfree(buf->padding);
> +free_buf:
>  	kfree(buf);
>  	return NULL;
>  }

kfree(NULL) is an OK thing to do, and is a well-known pattern.  Can we
arrange for Coccinelle to understand this?

