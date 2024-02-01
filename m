Return-Path: <linux-kernel+bounces-48631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F779845F0C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4481C1C282C0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AF78405C;
	Thu,  1 Feb 2024 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PRn7bVNv"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07F084047
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810416; cv=none; b=I9b/vRcXM//j3XOn7heAMEkQSshP00U0jvfcB+gN00UYmnC+XxaU37fNvAtHXy21bONdUUFnxcXqbI+UamZAVcpae4z1O0mk9Hao82jAfzbSREqv443LF2SMFV1s9WW1XbHuqOPXVLga3GAdbfEHdbAXlnoZnR6BpWrPyVM0HTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810416; c=relaxed/simple;
	bh=vXFNPWEAkSb5HjgTql71jCtRWR9LKB/oulu5KnNnp8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0JTFjtI+mfuN4JMWZcppLqdSdx4G7AsMyglsnL7MmhvhhzhV2efFDQ1fqKyiUAPIC7CjXF+KPHfyvP27qULhtOXbUjwZL9aa5r4Hfa0TSE/gEf9Khj8cTj3axLhA8fY0DB7DmNt2ubWTzzoYHKLRIUSCFLlRn4zvek0QIovydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PRn7bVNv; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55f2b0c5ae9so1628376a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 10:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706810410; x=1707415210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iUvUiFImH5+fS4vEk7uHsM8b6W2+ekXfbZRgQ7WC0cg=;
        b=PRn7bVNvkMP9f7ocGhi+4oTOUr+uWx87ZsZefpRYveUSXnS6nsIveOFxXfLeP87ZAx
         Z42g3hB9pxd1i8K3jHdOejDcG0el1rx6Ki+B2f3OjpjYXlSS/O9FkEeXF06iImVSArrO
         ooRovwT4htjZ3pxViyESdZpxyLXqGGnaRngLRwdOjf/LDuRzIhTSJ9IrFHEd00YTF8tj
         2IJgxZ0tU5y+OjLBRxwWxXjfAnvN4RcWlpkbMKFkHmtzMXO0Lsj4H6m16iuwG8CjxwOh
         jyRtLMOyvU7mxR7Eu5GWKfw1VGPjNQXTuDOggVoB3fT8qF9B+1qtJEkL9KyWT37yY6cZ
         z0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706810410; x=1707415210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUvUiFImH5+fS4vEk7uHsM8b6W2+ekXfbZRgQ7WC0cg=;
        b=OPOYhO3dl3oE57mp5n8AnSWZybQ0oaA71gQaTCpnsYktEBPf2FbijAEYcLMLp57NvC
         KkXY7i8ac0hp+3aSMOC8FVG0rqgcrX02Gd6yyZ5EWD9Jiz7uAfvZpyCFK/R5kNBDGLGl
         8vARG7fvrFrR+FaxR0UyAJyyeW19v4f7HEX8Lq7wUmt7fjPqROp5NgUVP2oR55yEVDlz
         Fx4jRuGR9InT96bN8PSqkxatxKlGgDCdQiVu8zvmzCAOw20iceEuxB8H2Ex6vtgaTAK3
         kI9AdJY92hN4a7/T2hsKwzKfIpZIJIUBjpYuY/IVr9qfQ4iI0spf7YsB/LoTR1hMpS1D
         SKqA==
X-Gm-Message-State: AOJu0Yz8gEASBkP56r1n7yGOvqVsZbzBGYbu0A2XdNbyDKBxIXd4ie7R
	g4K8AMTDMw7bEaqZB0uk5o2pLmbiavAKEh5g8P/yfI9KSCZbLs40bohdxYwv4Bg=
X-Google-Smtp-Source: AGHT+IGxgCi8AK8Mk83sfbv5yJ+8f80zMi57dZde/tdcI4BmnOhiykhKYR7wzjacWWgf6CjNULVr2A==
X-Received: by 2002:a05:6402:1490:b0:55f:dbb8:9163 with SMTP id e16-20020a056402149000b0055fdbb89163mr374198edv.37.1706810409714;
        Thu, 01 Feb 2024 10:00:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVTgWt4F9kWpJV9Ukqc/m1wnKXg+Y1pytykTfX0QSWAHGEGHPg0ff9wMexj1kwY23h65P8+J7ep1m5oXPoZ8Jex/7cJPF+ZS+tw51dM/HLY0pC62Awg1vLmX6cwB5qt56GTbcSdebIBfCYBElvPfX9G9OwmwBA=
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id c16-20020aa7c990000000b0055ef1d4fcb5sm41232edt.9.2024.02.01.10.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:00:09 -0800 (PST)
Date: Thu, 1 Feb 2024 19:00:07 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 11/14] printk: ringbuffer: Consider committed
 as finalized in panic
Message-ID: <ZbvcJwsIEsii3oi2@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-12-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214214201.499426-12-john.ogness@linutronix.de>

On Thu 2023-12-14 22:47:58, John Ogness wrote:
> A descriptor in the committed state means the record does not yet
> exist for the reader. However, for the panic CPU, committed
> records should be handled as finalized records since they contain
> message data in a consistent state and may contain additional
> hints as to the cause of the panic.
> 
> Add an exception for records in the commit state to not be
> considered non-existing when reading from the panic CPU.

IMHO, it is important to describe effects of this change in more
details. And I think that it actually does not work as expected,
see below.

> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -1875,16 +1877,25 @@ static int desc_read_finalized_seq(struct prb_desc_ring *desc_ring,
>  
>  	/*
>  	 * An unexpected @id (desc_miss) or @seq mismatch means the record
> -	 * does not exist. A descriptor in the reserved or committed state
> -	 * means the record does not yet exist for the reader.
> +	 * does not exist. A descriptor in the reserved state means the
> +	 * record does not yet exist for the reader.
>  	 */
>  	if (d_state == desc_miss ||
>  	    d_state == desc_reserved ||
> -	    d_state == desc_committed ||
>  	    s != seq) {
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * A descriptor in the committed state means the record does not yet
> +	 * exist for the reader. However, for the panic CPU, committed
> +	 * records are also handled as finalized records since they contain
> +	 * message data in a consistent state and may contain additional
> +	 * hints as to the cause of the panic.
> +	 */
> +	if (d_state == desc_committed && !this_cpu_in_panic())
> +		return -EINVAL;

If I get it correctly, this causes that panic CPU would see a
non-finalized continuous line as finalized. And it would flush
the existing piece to consoles.

The problem is that pr_cont() would append the message into
the same record. But the consoles would already wait
for the next record. They would miss the appended pieces.

It might be fixed by finalizing the record before we read
the non-finalized piece. It is doable but it would add
another lock-less scenario. I am not sure if it would work with
the existing barriers or how complicated it would be to
prove the correctness.

Now, in practice, it would allow to flush pieces of continuous lines
printed on panic CPU immediately. It would not affect messages printed
by other CPUs because of a mix of reasons:

   1. The current code tries hard to move the console owner to panic
      CPU. It allows the panic CPU to flush the messages a safe way
      even when other CPUs are stopped or somehow locked.

      It means that the consoles are ideally flushed when the panic CPU
      adds a message.

   2. Only the last record might be in a committed state. Any older
      record is automatically finalized when it reaches the committed
      state.

   3. The previous patch causes that messages from non-panic CPUs
      are skipped when they are not committed or finalized, see
      https://lore.kernel.org/all/20231214214201.499426-11-john.ogness@linutronix.de


Now, this patch would really help only when the panic CPU dies in
the middle of a continuous message or when the final message does
not have a newline character.

Honestly, I think that it is not worth the effort. It would add another
complexity to the memory barriers. The real effect is not easy
to understand. And the benefit is minimal from my POV.


Alternative solutions:

1. Flush the non-finalized continuous line only before reaching
   the infinite loop in panic(). printk() gets disabled
   at this point anyway.

   It would solve only this one scenario, though.


2. Always finalize messages in vprintk_store() when in_panic().

   It would have the desired effect in all panic() situations.
   And it would not add another complexity to the lock-less
   ringbuffer code.


Best Regards,
Petr

