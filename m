Return-Path: <linux-kernel+bounces-21422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CED828EF1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298FA1F25E80
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FE23DB8B;
	Tue,  9 Jan 2024 21:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hINjkS8a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SHOfBMhg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9DA3DB86
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 21:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704836112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Yq9im8aYFIP0Fqu2da/RxbhDMNbYhFshxI5Vyxu8QU=;
	b=hINjkS8ag40vnUkDcgYZRYqEtMzau6NYEk1YIcFpv4LRh51sxKxD8wXQvbGrach6eo9XCb
	zFZpU4qwj4pOHKNczo+/JUCEu5RmPgQfykXU/SxCWbMW/h0CMQBzSi6N5VckB2J9ZQe+kg
	e4Kqlde7gpEDfOub+afuhEML4sIS1lHqH/T3CLrP6LAgSuI37VD7fYpGmzB5cpmUl9ZQCb
	SqwkNzN5kQsufYVPhHD7fC2ciagsQn9EURC7oePsQkM24AJLVAiP7H8o8uHex9dwTqtLma
	3XhLo6kqPQNQFzQZRmxj0y0pVqF13vK9Ro25LOTEV3y1IU63DxtdNypS0QvyIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704836112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Yq9im8aYFIP0Fqu2da/RxbhDMNbYhFshxI5Vyxu8QU=;
	b=SHOfBMhgmM/Lkr2jwScp3JoAhYdwbD8/0LHeXMKMpFbO1C3QrHBdUIrquD6ndwAzJuqZo4
	WEkU4aOOBxvQeTCA==
To: Yukai Wu <wuyukai0403@qq.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Remove unnecessary casts in init_64.c
In-Reply-To: <tencent_16DE28073E2F2BF284331B21ADFA58AB2907@qq.com>
References: <tencent_16DE28073E2F2BF284331B21ADFA58AB2907@qq.com>
Date: Tue, 09 Jan 2024 22:35:12 +0100
Message-ID: <87mstejilr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jan 07 2024 at 12:24, Yukai Wu wrote:
> @@ -150,7 +150,7 @@ static void sync_global_pgds_l5(unsigned long start, unsigned long end)
>  			pgd_t *pgd;
>  			spinlock_t *pgt_lock;
>  
> -			pgd = (pgd_t *)page_address(page) + pgd_index(addr);
> +			pgd = page_address(page) + pgd_index(addr);

This is not equivalent.

Thanks,

        tglx

