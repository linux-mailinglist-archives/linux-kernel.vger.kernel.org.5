Return-Path: <linux-kernel+bounces-72321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EEE85B1F7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B001C21AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554B945942;
	Tue, 20 Feb 2024 04:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NL9MXB4R"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E86F42A88
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708404514; cv=none; b=CwisGQpVp7DrAJQxDKkkE+DalmtTvHGs/X2Ogue8ohrBMnH825MXoob0w4k3DdcAbe+X/ty9I9JjOsl4C3ji1Tq52ATa+SZmmXLVEmU6lC+BXS9u21DcXyMinF1gzYJQlmmZk+ukQc9G2rLyFP4Ya2Uq3c1p3/Nyztv+wHbA2tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708404514; c=relaxed/simple;
	bh=k80QW4KMM0dlIma8WfB/XgEsUMJYKO6sz2HzDACE/BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYE7lIz9BuuZb+If66aZoa1+FDYPoR6cdGPhhdOs5LqvJc5VUEVgoGf0YN5JMm859QPgyfZWVF0mcVSvaDVjggV3xJvBfh09Em2T4J/l1n1oyayMUOyrsG6V7+d5t7/5w8tb7pG1f+OQRCLSTLQBQsHF0tKCj25ztgLqLwVoqFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NL9MXB4R; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e2dbf54b2eso2912051a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708404510; x=1709009310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jgS61vvoieCh96Pyw6Wg1Bq29NiAhJXuWe15wbQDYlI=;
        b=NL9MXB4Rh/Rhhkr2kp2/1LlfJmuB/q4azbiaXReucLXOFDMgB8cHRwuMkg/iRguLkg
         iws9lYtvMwRtdBJG7d+TJ4OKmwK5elVIsCHw2rxk8mEKxHV6uYJM9NysIT5EEnfy4SBO
         dMVI/DewYRdfCP1/k0kjMBiyXX9KzD428vzGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708404510; x=1709009310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgS61vvoieCh96Pyw6Wg1Bq29NiAhJXuWe15wbQDYlI=;
        b=NbuyS8QyTw6tDqWWXIHwnZ7QJPW2rJkcQa0mh49AM/814dFKw9G/dCiNEAIGURf9RT
         vX2q5h0bR+5xY9654Lx+gDAFLxesnhOztQGzQ0TcJIDhT+PzXnrHcS0z92Z3tJzVWTGk
         LoOIPLQqjSwxThkb+Z9JgjASNsg/lYmCp8+j/EFzWRRv/qcjJwZaTknHu6MNKOd1C+20
         t3Cw8/PvxZ1Qd9nvzM6gWxt4Bp+lV+6TPiWMFD1po9jwBoGhs6BAqyReoYD+woYudF6j
         MuHYMOq4LoFBVwKvcjBjfhCt4VfWtYAxZQCttMuE6MdsAHXqfhhsygymOjw8pa30cG5b
         XPag==
X-Forwarded-Encrypted: i=1; AJvYcCWM3TbsKKrCT+7qsFwGA7biVVMhTMrxW1vleZn4GSVyqt17FqQerryRUCTMzPlVbfEmEVv0zAv5XOerPk50SHnn4Y6ogBxX2e/544z4
X-Gm-Message-State: AOJu0Yxu2XWM/PL9lO+mqZybvL73k9t6yg0RXFYIZ6pq/ujV6/irPoxf
	BKMjP9yTH+QauO6zZMf/a97zEktZS62VzlPpbGxdSduq78lQ6MZs9mGZT8KnjQ==
X-Google-Smtp-Source: AGHT+IEgZPXOONfCtdpczp8/iew+ezzFdh6y1wy/Mw4HUoKQHFiC6feQQ/lw2cCujWgHZKaTMS0qbQ==
X-Received: by 2002:a05:6358:6f0b:b0:178:6211:871 with SMTP id r11-20020a0563586f0b00b0017862110871mr16643003rwn.0.1708404510078;
        Mon, 19 Feb 2024 20:48:30 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:8998:e92c:64ca:f09f])
        by smtp.gmail.com with ESMTPSA id ok3-20020a17090b1d4300b00299d619bf2dsm811441pjb.9.2024.02.19.20.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 20:48:29 -0800 (PST)
Date: Tue, 20 Feb 2024 13:48:25 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: nphamcs@gmail.com, yosryahmed@google.com,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, hannes@cmpxchg.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/zsmalloc: remove migrate_write_lock_nested()
Message-ID: <20240220044825.GD11472@google.com>
References: <20240219-b4-szmalloc-migrate-v1-0-34cd49c6545b@bytedance.com>
 <20240219-b4-szmalloc-migrate-v1-2-34cd49c6545b@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219-b4-szmalloc-migrate-v1-2-34cd49c6545b@bytedance.com>

On (24/02/19 13:33), Chengming Zhou wrote:
>  static void migrate_write_unlock(struct zspage *zspage)
>  {
>  	write_unlock(&zspage->lock);
> @@ -2003,19 +1997,17 @@ static unsigned long __zs_compact(struct zs_pool *pool,
>  			dst_zspage = isolate_dst_zspage(class);
>  			if (!dst_zspage)
>  				break;
> -			migrate_write_lock(dst_zspage);
>  		}
>  
>  		src_zspage = isolate_src_zspage(class);
>  		if (!src_zspage)
>  			break;
>  
> -		migrate_write_lock_nested(src_zspage);
> -
> +		migrate_write_lock(src_zspage);
>  		migrate_zspage(pool, src_zspage, dst_zspage);
> -		fg = putback_zspage(class, src_zspage);
>  		migrate_write_unlock(src_zspage);
>  
> +		fg = putback_zspage(class, src_zspage);

Hmm. Lockless putback doesn't look right to me. We modify critical
zspage fileds in putback_zspage().

>  		if (fg == ZS_INUSE_RATIO_0) {
>  			free_zspage(pool, class, src_zspage);
>  			pages_freed += class->pages_per_zspage;
> @@ -2025,7 +2017,6 @@ static unsigned long __zs_compact(struct zs_pool *pool,
>  		if (get_fullness_group(class, dst_zspage) == ZS_INUSE_RATIO_100
>  		    || spin_is_contended(&pool->lock)) {
>  			putback_zspage(class, dst_zspage);
> -			migrate_write_unlock(dst_zspage);
>  			dst_zspage = NULL;
>  
>  			spin_unlock(&pool->lock);
> @@ -2034,15 +2025,12 @@ static unsigned long __zs_compact(struct zs_pool *pool,
>  		}
>  	}
>  
> -	if (src_zspage) {
> +	if (src_zspage)
>  		putback_zspage(class, src_zspage);
> -		migrate_write_unlock(src_zspage);
> -	}
>  
> -	if (dst_zspage) {
> +	if (dst_zspage)
>  		putback_zspage(class, dst_zspage);
> -		migrate_write_unlock(dst_zspage);
> -	}

