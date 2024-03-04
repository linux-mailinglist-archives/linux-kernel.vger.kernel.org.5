Return-Path: <linux-kernel+bounces-91265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E1C870BF9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9F91F2650E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE36D10A28;
	Mon,  4 Mar 2024 20:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JTg4ctT2"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1BA1079D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585899; cv=none; b=Jaeiyd2KaWIPrTK8wk0TP+OUT+BsMAa52g5fyV6mr3ndmwLKwGK7CCcAdJo4rjUosPKgRkSh5nm1BjFKN0mloWcgvB35YFan6PUVlzPC787pICfxIWcQDI8fyCmT8ses2Zj/DGEDY2MmeKs67ry3W25NWLGC1TQT+iuCm3ewrVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585899; c=relaxed/simple;
	bh=vdK6RiW/KweEb9A7JW6V9Ozhw2b+gLO9iT+16Hcypr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqsjxq54yeFT0r9w+5mhYfQdIm/0ZyYJujIW6/SjvgykmH0DctE1YfX0K+fbl5o+I2GrKkSv06cvU+aMsLJq51YWMAFzj6tTdSH8SbiCAJLmPg4V5p3AYQbycsKZqpRrEjXOVcgP8Mkpkh/J96sPRcIB4emJh8ZUgzTSIasgQgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JTg4ctT2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc09556599so46961075ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 12:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709585897; x=1710190697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MBysldzXTflPzomKWRmSMXhF54SNqFAu7g8kqMxzJW8=;
        b=JTg4ctT2hzSBE5HZLwwuwqL52LNpw/pz84iJ+Lm9UnxvXgd8xleoD04qL6ScUAL+gG
         xFETjvJwH1BYAHdMKxxFr7r3hpwUrdz0r85KnBrBJZXSzfqiBY5nKIMH+scCd9ZirZAb
         /+qvENFgdlvIJ1apQ6VXW7x+15GNuzAhR/tAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709585897; x=1710190697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBysldzXTflPzomKWRmSMXhF54SNqFAu7g8kqMxzJW8=;
        b=s5TfJeAHIsjpPPDUsGbh/FNKkqR3lspbVSJE3CfNAXqSy30eL3pVtBVa47XBs5ndk8
         BC6lhWL5vGw6wGS3SsfGCpBlyCeO+kj09qYAQDTGtC1I9oK6Zqi/tT/W8SP6Hi/5oUwR
         mtDyesmPgs0vPxNWnNGAXSpAC7uqtteoY5ue8VapoQJRtUnFZJqW1v1xEU6Fx0vavEZv
         tSH97mwMmfv83GQRaV7CxsZ3MsGeVlcMEctgCVv+ZekMbOKxbNjT4HCv7JGnpYhljy3b
         bKDOSWiK5JlQ9bVIA9Z+niFrXiTlIMZYHnWztPuuZgB9HRPaiVg/lWuQMYKYNCvZ1Mwj
         hSKA==
X-Forwarded-Encrypted: i=1; AJvYcCXGj1cad1OGWDOA9a8U0CSrOfIOAEWqGjBF3pBb4ohlDaAM1Baj1v/ZTTDpgZOKHVdkernjyDQkEdHy0d6AXKnlISYxnOe/UAjE116i
X-Gm-Message-State: AOJu0YxwyVAkzAynThRD3vG8oseLMv8HIatm+5sVCl8jSKYOMnaefPnc
	AhZ0+wdTu0Axq0rhKVh+E8bMTGJTLghIY0x7ykP+TFKoKzzI3RmnPr4LjHH4MQ==
X-Google-Smtp-Source: AGHT+IHa3YpcV8KFwBIJ1K/azj4a+KW8cW4kPPah4+2gIkxeNC+6+YuYOXOCykzg7xOmrXCDdKZsvA==
X-Received: by 2002:a17:902:a3cc:b0:1dc:794e:27b2 with SMTP id q12-20020a170902a3cc00b001dc794e27b2mr10676858plb.56.1709585897109;
        Mon, 04 Mar 2024 12:58:17 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jv11-20020a170903058b00b001dc96c5fa13sm8950726plb.295.2024.03.04.12.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:58:16 -0800 (PST)
Date: Mon, 4 Mar 2024 12:58:15 -0800
From: Kees Cook <keescook@chromium.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
	kernel@collabora.com, kernel-janitors@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] selftest/exec: conform test to TAP format output
Message-ID: <202403041256.80EDE9BA2@keescook>
References: <20240304155928.1818928-1-usama.anjum@collabora.com>
 <20240304155928.1818928-2-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304155928.1818928-2-usama.anjum@collabora.com>

On Mon, Mar 04, 2024 at 08:59:24PM +0500, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/exec/load_address.c | 34 +++++++++------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/testing/selftests/exec/load_address.c b/tools/testing/selftests/exec/load_address.c
> index d487c2f6a6150..17e3207d34ae7 100644
> --- a/tools/testing/selftests/exec/load_address.c
> +++ b/tools/testing/selftests/exec/load_address.c
> @@ -5,6 +5,7 @@
>  #include <link.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include "../kselftest.h"
>  
>  struct Statistics {
>  	unsigned long long load_address;
> @@ -41,28 +42,23 @@ int main(int argc, char **argv)
>  	unsigned long long misalign;
>  	int ret;
>  
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +
>  	ret = dl_iterate_phdr(ExtractStatistics, &extracted);
> -	if (ret != 1) {
> -		fprintf(stderr, "FAILED\n");
> -		return 1;
> -	}
> +	if (ret != 1)
> +		ksft_exit_fail_msg("FAILED: dl_iterate_phdr\n");

I'm for this series, but I do note a weird glitch in the ksft API.
ksft_exit_fail_msg does:

        va_start(args, msg);
        printf("Bail out! ");
        errno = saved_errno;
        vprintf(msg, args);
        va_end(args);

"Bail out!" is not very descriptive. I think I'd rather this should be:

	"FAILED: "

and then that added prefix doesn't need to be added everywhere in this
patch, nor the "error: " prefix in the next patch.

-- 
Kees Cook

