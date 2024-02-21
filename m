Return-Path: <linux-kernel+bounces-75467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D6285E91A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E21D1C20BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731671EB41;
	Wed, 21 Feb 2024 20:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NhXTm9Ss"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B064453A1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547770; cv=none; b=DiaHGISGRbQY9axAUt7N1h7ImAXDQIYNtzfhoonk0rBKyyaKhsw2Xi3zS/yk9p3iN7FXHGA3XPUQ5GZVuDLs/j2QFFvkfC4TY0k/lmMEUZOdHlBGuLBFpT2sbFmdKiANm5JOpUHWZZtsahTiY8LSXHBKZ3VVXLoAUIskZelvJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547770; c=relaxed/simple;
	bh=hWY1Y7gwaHsCt+60O0plbbDiTxgt1/isDaR9hySz3Bo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QMqpyIzffGrLr/Iq/ZTeFYrxYd0wBaeZ8+rUfXJHUbUpMv6vU4lAR7nHSMeHtLsrLaIcfVLqXq6rmnslhY9L6t9rIMfXPEneIGY8X1TksdCt6DV1d99nXd1wA8+cFO5XG3d/9NTGKjCBA+atHC78MC5SifP59EVracSHnNCBq4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NhXTm9Ss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFE0C433F1;
	Wed, 21 Feb 2024 20:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708547770;
	bh=hWY1Y7gwaHsCt+60O0plbbDiTxgt1/isDaR9hySz3Bo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NhXTm9Ss+RtkoPhR9wtAeLEzXXMWA+4u6rw8ILNyykZ9foBpB4ny8n/PFimlKdEY6
	 LXlO6hlrVfgSbm0HQ6HtxVv8I17FVhBaYhkC+6xF8aZb7w7ZUoNalfj4gSNTZz1NCg
	 tKwNt2lg7LFKJR3fvlZcAtPNbNG2IXowaer4P7WY=
Date: Wed, 21 Feb 2024 12:36:09 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Barry Song
 <v-songbaohua@oppo.com>
Subject: Re: [PATCH] mm/swapfile:__swap_duplicate: drop redundant WRITE_ONCE
 on swap_map for err cases
Message-Id: <20240221123609.3cd20c3dc2d6adeaf5d3ffc8@linux-foundation.org>
In-Reply-To: <20240221091028.123122-1-21cnbao@gmail.com>
References: <20240221091028.123122-1-21cnbao@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 22:10:28 +1300 Barry Song <21cnbao@gmail.com> wrote:

> From: Barry Song <v-songbaohua@oppo.com>
> 
> The code is quite hard to read, we are still writing swap_map after
> errors happen. Though the written value is as before,
> 
>  has_cache = count & SWAP_HAS_CACHE;
>  count &= ~SWAP_HAS_CACHE;
>  [snipped]
>  WRITE_ONCE(p->swap_map[offset], count | has_cache);
> 
> It would be better to entirely drop the WRITE_ONCE for both
> performance and readability.
> 
> ...
>
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3320,6 +3320,9 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
>  	} else
>  		err = -ENOENT;			/* unused swap entry */
>  
> +	if (err)
> +		goto unlock_out;
> +
>  	WRITE_ONCE(p->swap_map[offset], count | has_cache);
>  
>  unlock_out:

I agree, but why add the goto?

--- a/mm/swapfile.c~mm-swapfile-__swap_duplicate-drop-redundant-write_once-on-swap_map-for-err-cases-fix
+++ a/mm/swapfile.c
@@ -3335,10 +3335,8 @@ static int __swap_duplicate(swp_entry_t
 	} else
 		err = -ENOENT;			/* unused swap entry */
 
-	if (err)
-		goto unlock_out;
-
-	WRITE_ONCE(p->swap_map[offset], count | has_cache);
+	if (!err)
+		WRITE_ONCE(p->swap_map[offset], count | has_cache);
 
 unlock_out:
 	unlock_cluster_or_swap_info(p, ci);
_


