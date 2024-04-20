Return-Path: <linux-kernel+bounces-152103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BA28AB925
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE1B1F21C3D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C3A8F6E;
	Sat, 20 Apr 2024 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atFBnK6E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2DC205E28;
	Sat, 20 Apr 2024 03:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713582295; cv=none; b=er2hgr8wlyiRfPQVcHpPhxVCrwap9FNgSvwdtXjOPC7tvEPR9yZa9vrzV9C9AljZzTTVoKh4TZUbbJ9rbcGe2v9kxf3Fqk3tBOC1ISiVIxOCANwcvsX+R97lvKGfRK6I+ODwAmFPqwiG0PjQRz+CP/kKYYFBc0DZTl++U+XIpys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713582295; c=relaxed/simple;
	bh=WbPpzdjbBiwI2Jfez6mZaSQBsQU2SmMw9X7F05j4mFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+VXg8YxHd/UUhwj3jAK9l5ilLNOWdb11gr+kD4B/6HbfuUuHm52PwbE0UQnsuaNrVdJbjbWyoMUf97cGLRGvkmb/obBBy29uqNNWj/MZde8YWNMpkGZe3OOVrDjxVfi2qmRlBlQSOEdye/Jk3IHPiA06sHmfbGDcfjsZNY8Ka8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atFBnK6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C4FC072AA;
	Sat, 20 Apr 2024 03:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713582294;
	bh=WbPpzdjbBiwI2Jfez6mZaSQBsQU2SmMw9X7F05j4mFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=atFBnK6E0ItEwY6oHulDqlahLlygY0eKZ3GujMDdlX/95whRY8RhrSxIkQDgWYtwL
	 rjEhwtaXkeJQ17USQTeY5nZjECO3TVadPgbFpu4kNJM7myckfdvJJ+GCLS77wIBuN/
	 uxzAkRJjlrz/ZJ8wQ4KQb7MTlgsplSfuyku+9TnP0gaf5FMeCc48b3gaJsUd5TlWRa
	 6+iEQnasE5vr9mYvjsba6FK0IPpokMJC24SnP5Ze7GGRJcwK4AVjQLOc4yDrC7Wg6g
	 HFt3JLirQ6995M1u3UYnj3jbjE0EuLxaElFu2f/D0p6pHxwTFmLTgu+Fhlt5OQZg0F
	 Atq3gPKPm8tgw==
Date: Fri, 19 Apr 2024 20:04:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: syzbot+8e03da5d64bc85098811@syzkaller.appspotmail.com,
 ajk@comnets.uni-bremen.de, davem@davemloft.net, edumazet@google.com,
 linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net,v3] net: hams: Fix deadlock caused by unsafe-irq
 lock in sp_get()
Message-ID: <20240419200453.13301f29@kernel.org>
In-Reply-To: <20240419191438.30724-1-aha310510@gmail.com>
References: <0000000000005e18f00615207de6@google.com>
	<20240419191438.30724-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Apr 2024 04:14:38 +0900 Jeongjun Park wrote:
> read_lock() present in sp_get() is interrupt-vulnerable, so the function needs to be modified.

I was going to make the same comments as on the other submission 
but then I realized this doesn't even build.

Please don't spam the list with completely untested code. You can
submit patches to syzbot for testing without CCing the list
or developers.

> Reported-by: syzbot+8e03da5d64bc85098811@syzkaller.appspotmail.com
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  drivers/net/hamradio/6pack.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
> index 6ed38a3cdd73..fee583b1e59a 100644
> --- a/drivers/net/hamradio/6pack.c
> +++ b/drivers/net/hamradio/6pack.c
> @@ -373,11 +373,11 @@ static struct sixpack *sp_get(struct tty_struct *tty)
>  {
>  	struct sixpack *sp;
>  
> -	read_lock(&disc_data_lock);
> +	read_lock_irq(&disc_data_lock);
>  	sp = tty->disc_data;
>  	if (sp)
>  		refcount_inc(&sp->refcnt);
> -	read_unlock(&disc_data_lock);
> +	read_unlock_irq(&disc_data_lock);
>  
>  	return sp;
>  }


