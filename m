Return-Path: <linux-kernel+bounces-64257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85291853CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FCD1C236C6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EAF62813;
	Tue, 13 Feb 2024 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JMB6NJ4T"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43F464A92
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858267; cv=none; b=sn/ZiWTVEq+B4mA+Mt3HIUrrhOOxkNmP6UjcnxAVzc4ms5u5ZhpAjb5lYKUwu5CRFCKgJTov3X+BuSsKlIWsPrWcJxxlW0wPWbxCVsy6JGQs+REmXEkz/YzxxoZExtBHJ36IdM/Mu0+dY7oxAeCg9bNznx+wdUj5Um47ZznhRxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858267; c=relaxed/simple;
	bh=unxZOrs9XDbzoXsCj96S95ndlfevfpGn8crX2VsMceo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAROmvPjhso8TZK+8qyEu7sUwvuDL/xsMiqkoQtuNjKHJ9hH7QjotYh9r69ITZYJWfEi6AqDvDlrHdCmY0OOD0Wvb/D6Nysuwb4TG1nkhWRQH0UWLxjBwlT8APl6omLcfbvEkuZK/ubrAwVk6qGanwbB6PRYYxBHCw+1bZRkSxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JMB6NJ4T; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso1065023276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707858264; x=1708463064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6WpcrNvlFPgLJQNuLJ6h+eMksOi6n36MRReQFJjkwlI=;
        b=JMB6NJ4TwDe4C2jjPbeLOlRDA8BUi20jfZw72JnfXG1tGxGSw+Mpv6VYsqejKzy8c1
         cFTvAE4INDnReg68hGisEKVkURPi5SjvuJM4B40D3W2PXVjmWhR8tsRiP1JmMNxllYOI
         zF5xmBY9l6W3a4HZU9VE2xvhHm40qB3HHv5IHSgRi+/0wCPDxa66hRaXVLT1SJQ1gqir
         mwg5SzvGOjGDd6qNoO64EqO7JAhMI+yQxLsVsOuLcG57WXoOn3YQZxCxSfnM7nrP7urv
         mexT+gZut7zNLt3Ji9NK1e1y4X2Z54Cij2U8XkdxE22KYUKXIvA0GbQQ0MgZSFoPS5Dj
         /TVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707858264; x=1708463064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WpcrNvlFPgLJQNuLJ6h+eMksOi6n36MRReQFJjkwlI=;
        b=sHAdZotuZnFhA+k82BjLH6L1ThYA9S27flq0UtEMXhzX95MWHoPg0R4l3rQPI/uj2c
         3YMzKZHK30zbtD9TpKbZFk2uQWH4sDLGBTmsJthh+SerR3cOirV5WBfjCdoNEYVqXQt1
         OEFllkadyC0DI5vAcuJqfBmY3z2/INTk8gYQdarxLFbCqSwl0hfpn+Dw3txlqMpfMVei
         MwrGxsAlc6d1O+AkwlvKQ/cqoV/5sdzCw6MIDkP/0cANYaHxYPMiB8eCOTSHcT+wN9w6
         oPpuJIjo9BxpfrE4qHqZFwUuX29FnBv2mqTkz+43VAO1CzP1+a7pHN+luUHmnvN45Mew
         7veg==
X-Forwarded-Encrypted: i=1; AJvYcCVOy8PpvJ5g4L/I9ToGiNBGQZym4b9QHY/GWF5pyTmG9dqIgWJv5XPAxa6uGjsEz60Q4o+kGhHzGk9Gbnh6LSUPfVp5c+rs4gXkqhgg
X-Gm-Message-State: AOJu0Yx+qGH0GhEhV2/gIykbr9bZfnFFyyOuNusHj6MsZbor8QeP97Nb
	63AQStroUoWTmFkBIyKbUWw9szUYn7cW3npveBjVOj+uaRE0+P2AHPRj7ZhFpW0=
X-Google-Smtp-Source: AGHT+IGuhB7i7Can7GRRRP7ZoLvLMIK+FNyBhgPsmOzQYSQiDEPs9JYTpO+KUBpE+u8T7iLWINCm6Q==
X-Received: by 2002:a81:838b:0:b0:604:69ee:5b4c with SMTP id t133-20020a81838b000000b0060469ee5b4cmr674166ywf.18.1707858262387;
        Tue, 13 Feb 2024 13:04:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmvajECjHBVC7eK1T3+mN2RBiopPph9GnxGfJw2yyyl11dZUu5JKrWODyKI0eKUdKqynzV/pJZKL83VThrGokefoaqgeZs8bYX4XDEBme3v8GaoFszV2jwuwn0P3ithjtKKsP6uLb1YIAR3UalNS6rO4TUwNIlKFxbIRGlzvBqetmEgFq2ZoONoGI6woxU/UKbWo3pU7c6Wk87alI/E60DJpVAHHh7
Received: from ghost ([50.146.0.2])
        by smtp.gmail.com with ESMTPSA id v137-20020a81488f000000b0060792690431sm299939ywa.105.2024.02.13.13.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:04:21 -0800 (PST)
Date: Tue, 13 Feb 2024 16:04:20 -0500
From: Charlie Jenkins <charlie@rivosinc.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Helge Deller <deller@gmx.de>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH] parisc: Fix ip_fast_csum
Message-ID: <ZcvZVGCNd0qMkMbY@ghost>
References: <20240210175526.3710522-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210175526.3710522-1-linux@roeck-us.net>

On Sat, Feb 10, 2024 at 09:55:26AM -0800, Guenter Roeck wrote:
> IP checksum unit tests report the following error when run on hppa/hppa64.
> 
>     # test_ip_fast_csum: ASSERTION FAILED at lib/checksum_kunit.c:463
>     Expected ( u64)csum_result == ( u64)expected, but
>         ( u64)csum_result == 33754 (0x83da)
>         ( u64)expected == 10946 (0x2ac2)
>     not ok 4 test_ip_fast_csum
> 
> 0x83da is the expected result if the IP header length is 20 bytes. 0x2ac2
> is the expected result if the IP header length is 24 bytes. The test fails
> with an IP header length of 24 bytes. It appears that ip_fast_csum()
> always returns the checksum for a 20-byte header, no matter how long
> the header actually is.
> 
> Code analysis shows a suspicious assembler sequence in ip_fast_csum().
> 
>  "      addc            %0, %3, %0\n"
>  "1:    ldws,ma         4(%1), %3\n"
>  "      addib,<         0, %2, 1b\n"	<---
> 
> While my understanding of HPPA assembler is limited, it does not seem
> to make much sense to subtract 0 from a register and to expect the result
> to ever be negative. Subtracting 1 from the length parameter makes more
> sense. On top of that, the operation should be repeated if and only if
> the result is still > 0, so change the suspicious instruction to
>  "      addib,>         -1, %2, 1b\n"
> 
> The IP checksum unit test passes after this change.
> 
> Cc: Charlie Jenkins <charlie@rivosinc.com>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Prerequisite for this patch is
> https://lore.kernel.org/lkml/20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com/
> 
> No idea how that was not detected before. Maybe I am missing something.
> 
> Note that test_csum_ipv6_magic still fails on 32-bit parisc systems
> after this patch has been applied. That is a different problem.
> 
>  arch/parisc/include/asm/checksum.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
> index 3c43baca7b39..f705e5dd1074 100644
> --- a/arch/parisc/include/asm/checksum.h
> +++ b/arch/parisc/include/asm/checksum.h
> @@ -40,7 +40,7 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
>  "	addc		%0, %5, %0\n"
>  "	addc		%0, %3, %0\n"
>  "1:	ldws,ma		4(%1), %3\n"
> -"	addib,<		0, %2, 1b\n"
> +"	addib,>		-1, %2, 1b\n"
>  "	addc		%0, %3, %0\n"
>  "\n"
>  "	extru		%0, 31, 16, %4\n"
> -- 
> 2.39.2
> 

I got my parisc setup working and this does indeed fix the issue.

Tested-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


