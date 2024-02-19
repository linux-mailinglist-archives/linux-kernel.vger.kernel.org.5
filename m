Return-Path: <linux-kernel+bounces-70680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC27859B13
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643E62824DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AB45228;
	Mon, 19 Feb 2024 03:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pg7avCM0"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AC1442D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313970; cv=none; b=NsU/aE3M3PUv3rSqbI3DJxsab1hVRH07tOP7nA/jK8mBX4m1U5OZ6GIenemsZ+AB1mvPPSXpW8Ng9/6JoSlUszc9cMS0KyWfna/62XRTFuPHY5+INVmq0r+PwFvH7IW/HewB+KP/uMBZ/OWjsUCh2/Xq27J1jhuBndB+S0GOO+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313970; c=relaxed/simple;
	bh=yh3sl3u1siAwjrRYDBr7FWwn+LbD+MIfPyaILmReQdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4+6x50HZ63gXW4OrOM/ZSHeXX7suFPhiPXUtWH+5ANWsDtRCmGw/HT7wDgzVvmfX3KtjzkMgzjyH5r/goHGVH1XwaU2MD+aC5cC7Nc/GjITwUan8K4Tpg5avAece6822uk3+m19yqJVZc367Pj7XDGEayi2ef8KwbR/oz0wjx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pg7avCM0; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 18 Feb 2024 22:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708313964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tqok9mo0TS7frNbvOhyf86WJQ7mbllPj5AAqXRc89NQ=;
	b=Pg7avCM0nH3zgKh3p1Whz3oCX3uG1HZqlibMiyXeSgx9XZktjMturMqTkS6fEirMAS0ZqP
	uHidBpHv/okLpNcFh42D50t0plyNFhl5Cy7X1477bfS+MTrNjoYCX89CquWMeop+gsZiMR
	m4TJvJ82hllR1NYX1P6w/HQ5rQfS6Y4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Brian Foster <bfoster@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2] bcachefs: Avoid a potential useless over memory
 allocation in bch2_prt_[v]printf()
Message-ID: <pmyezdskyr3t2iyald4diibl6b7lttf46d6sskxfu2wq3pub7r@gmyezjb3wfeu>
References: <4c614db674887346ea418acaeafd6bf86502ec77.1708272713.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c614db674887346ea418acaeafd6bf86502ec77.1708272713.git.christophe.jaillet@wanadoo.fr>
X-Migadu-Flow: FLOW_OUT

On Sun, Feb 18, 2024 at 05:12:28PM +0100, Christophe JAILLET wrote:
> 2 issues related to incorrect available space in the output buffer
> computation may lead to some extra memory allocation.
> 
> 
> First: vsnprintf() takes the size of the buffer, *including* the space for
> the trailing null.
> 
> But printbuf_remaining() returns the number of characters we can print
> to the output buffer, *excluding* the terminating null.
> 
> So, use printbuf_remaining_size(), which includes the space for the
> terminating null.

nope, buggy.

passing printbuf_remaining_size() to snprintf() is correct, but
snprintf() returns the number of charecters wrote _excluding_ the null

> 
> 
> Second: if the return value of vsnprintf() is greater than or equal to the
> passed size, the resulting string is truncated.
> So, in order to see if some extra space is needed, the check needs to be
> changed.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Un-tested
> 
> v2: - Use printbuf_remaining_size() instead of hand-writing it.  [Brian Foster]
>     - Reword the commit log, hoping it is clearer.
>     - Synch with -next-20240215
> 
> v1: https://lore.kernel.org/all/0f40108bed3e084057223bdbe32c4b37f8500ff3.1694845203.git.christophe.jaillet@wanadoo.fr/
> ---
>  fs/bcachefs/printbuf.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/bcachefs/printbuf.c b/fs/bcachefs/printbuf.c
> index b27d22925929..8cee9c2f88c4 100644
> --- a/fs/bcachefs/printbuf.c
> +++ b/fs/bcachefs/printbuf.c
> @@ -55,9 +55,10 @@ void bch2_prt_vprintf(struct printbuf *out, const char *fmt, va_list args)
>  		va_list args2;
>  
>  		va_copy(args2, args);
> -		len = vsnprintf(out->buf + out->pos, printbuf_remaining(out), fmt, args2);
> +		len = vsnprintf(out->buf + out->pos, printbuf_remaining_size(out),
> +				fmt, args2);
>  		va_end(args2);
> -	} while (len + 1 >= printbuf_remaining(out) &&
> +	} while (len >= printbuf_remaining_size(out) &&
>  		 !bch2_printbuf_make_room(out, len + 1));
>  
>  	len = min_t(size_t, len,
> @@ -72,9 +73,10 @@ void bch2_prt_printf(struct printbuf *out, const char *fmt, ...)
>  
>  	do {
>  		va_start(args, fmt);
> -		len = vsnprintf(out->buf + out->pos, printbuf_remaining(out), fmt, args);
> +		len = vsnprintf(out->buf + out->pos, printbuf_remaining_size(out),
> +				fmt, args);
>  		va_end(args);
> -	} while (len + 1 >= printbuf_remaining(out) &&
> +	} while (len >= printbuf_remaining_size(out) &&
>  		 !bch2_printbuf_make_room(out, len + 1));
>  
>  	len = min_t(size_t, len,
> -- 
> 2.43.2
> 

