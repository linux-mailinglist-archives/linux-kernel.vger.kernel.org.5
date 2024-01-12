Return-Path: <linux-kernel+bounces-24594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B8E82BE9E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D6C1F2433B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701CB5EE95;
	Fri, 12 Jan 2024 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JVxv3hk5"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF245EE88
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a271a28aeb4so694053566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 02:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705055316; x=1705660116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HU5eAL0BNu0Tz9jf6MkeJhwqR+ZIbtt2u9TiSiZUMjg=;
        b=JVxv3hk5rj7ZAjUSNCdzPIMUm5yzkqwhHZHA9NHsudQY2SwRSxEKqNxPS6bl0pQGDS
         hNpqExt5B6vEmQFM+H32WaH/eh1teoIz/zuW2M/zYi6rjjwV/JjfSJwkozuPIi/CkWu8
         vzY9yrSn9SfSyK0Hk5tccsvn0v0ndG6LIdELXGK2we94C03MqHKXWmimzZRVKlAO406U
         eHx+iitnmawv5lAdgsYpBneOn2nbsREbbZYnD+XrBWkCqZoHlILYm8E0cqJltTbFKJ3y
         jfStkS6MierDqMzkKDaRZ5E/fXN7hTRUJBeeTMpdXZWew3OTmCIa0GYD6WHooEmzz+e7
         wEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705055316; x=1705660116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HU5eAL0BNu0Tz9jf6MkeJhwqR+ZIbtt2u9TiSiZUMjg=;
        b=HPpNQzGgsmj5BlJQwWHcWBfMRCX4MXPQlAGwDzkOBuBqrIi2HHE4Bm3mTobDdU3W3q
         d4+wXTjKybHLgqxzz32XBii1NL5cQGzvXgkAfgCcnTjzkhgJ/+774c5iLAKnsSRQVEfv
         k/r5fsxhBK5ungZe5T/3tCEUqm3uXlLMTuqZ8ecws+GTwixf8XCC5fIFzymDgZNGpd1F
         qixCtlSp6r5H1vzObQg899yj8GJloHOSJH8els4mAngeqnv5q2YcJGSfN6Up05RGZ2zG
         hfxEcxv9NZ+K6wY8ye2kEHzrXO6D0jfNSpWpAXux7KlrnXmdBPl2hSYcn6cSDxSiq+g2
         /XHw==
X-Gm-Message-State: AOJu0Yx/pyWGK16SmGQTQsbBEVatQxP8Ou5t+JIuUzR2p+jeLVnGMdVq
	SUvFV8oFlOi9na61swf9VD481f+q4LDo9Q==
X-Google-Smtp-Source: AGHT+IEkR2RoLcfPw1dJAPRjYQXVAEkVqUH1e9tJL1plqF0H0O5Da3og+MiV6ON7t17HNjno2lwuTw==
X-Received: by 2002:a17:906:b7c8:b0:a2c:572c:b5e7 with SMTP id fy8-20020a170906b7c800b00a2c572cb5e7mr500040ejb.63.1705055315764;
        Fri, 12 Jan 2024 02:28:35 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id k7-20020a17090627c700b00a19b7362dcfsm1625006ejc.139.2024.01.12.02.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 02:28:35 -0800 (PST)
Date: Fri, 12 Jan 2024 11:28:33 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>,
	kernel test robot <oliver.sang@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH printk v3 02/14] printk: Adjust mapping for 32bit seq
 macros
Message-ID: <ZaEUUZ6PICA54qVH@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214214201.499426-3-john.ogness@linutronix.de>

On Thu 2023-12-14 22:47:49, John Ogness wrote:
> Note: This change only applies to 32bit architectures. On 64bit
>       architectures the macros are NOPs.
> 
> __ulseq_to_u64seq() computes the upper 32 bits of the passed
> argument value (@ulseq). The upper bits are derived from a base
> value (@rb_next_seq) in a way that assumes @ulseq represents a
> 64bit number that is less than or equal to @rb_next_seq.
> 
> Until now this mapping has been correct for all call sites. However,
> in a follow-up commit, values of @ulseq will be passed in that are
> higher than the base value. This requires a change to how the 32bit
> value is mapped to a 64bit sequence number.
> 
> Rather than mapping @ulseq such that the base value is the end of a
> 32bit block, map @ulseq such that the base value is in the middle of
> a 32bit block. This allows supporting 31 bits before and after the
> base value, which is deemed acceptable for the console sequence
> number during runtime.
> 
> Here is an example to illustrate the previous and new mappings.
> 
> For a base value (@rb_next_seq) of 2 2000 0000...
> 
> Before this change the range of possible return values was:
> 
> 1 2000 0001 to 2 2000 0000
> 
> __ulseq_to_u64seq(1fff ffff) => 2 1fff ffff
> __ulseq_to_u64seq(2000 0000) => 2 2000 0000
> __ulseq_to_u64seq(2000 0001) => 1 2000 0001
> __ulseq_to_u64seq(9fff ffff) => 1 9fff ffff
> __ulseq_to_u64seq(a000 0000) => 1 a000 0000
> __ulseq_to_u64seq(a000 0001) => 1 a000 0001
> 
> After this change the range of possible return values are:
> 1 a000 0001 to 2 a000 0000
> 
> __ulseq_to_u64seq(1fff ffff) => 2 1fff ffff
> __ulseq_to_u64seq(2000 0000) => 2 2000 0000
> __ulseq_to_u64seq(2000 0001) => 2 2000 0001
> __ulseq_to_u64seq(9fff ffff) => 2 9fff ffff
> __ulseq_to_u64seq(a000 0000) => 2 a000 0000
> __ulseq_to_u64seq(a000 0001) => 1 a000 0001
> 
> [ john.ogness: Rewrite commit message. ]
> 
> Reported-by: Francesco Dolcini <francesco@dolcini.it>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202311171611.78d41dbe-oliver.sang@intel.com
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202311161555.3ee16fc9-oliver.sang@intel.com
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Great catch! It must have been complicated to debug this.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


