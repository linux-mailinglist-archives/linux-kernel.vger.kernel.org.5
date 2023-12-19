Return-Path: <linux-kernel+bounces-5900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2380819144
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42F71C23D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8EF39AC4;
	Tue, 19 Dec 2023 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PFIpb+JI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9C73987A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC87C433C8;
	Tue, 19 Dec 2023 20:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703017313;
	bh=LTznM+nJnvfhzKJWRfp37Jsxl2aZjoXM7HdJ4keOzxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PFIpb+JI2WpqXlzcb8/eNuVhDXIZHv61W1U1GOkLLqBTA7ZwRlYwkKSx4lNBnz8zc
	 K+J1kmoB0HqliqBhULCX6Ti76mZEnAhypX2buDp6tQWqZ9IDbQfIXB2WO1k9sM8tsx
	 sHX2EW+qrG7XZIcF52/aPHU4raQG/PPIsXuBaWI0=
Date: Tue, 19 Dec 2023 12:21:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: bhe@redhat.com, bp@alien8.de, corbet@lwn.net,
 dave.hansen@linux.intel.com, ebiederm@xmission.com, hpa@zytor.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH] x86/kexec: use pr_err() instead of kexec_dprintk() when
 an error occurs
Message-Id: <20231219122151.aa4ae562537abf74067588fe@linux-foundation.org>
In-Reply-To: <20231219072902.90104-1-ytcoode@gmail.com>
References: <20231218102436.4378f51a36525ce770f6cd30@linux-foundation.org>
	<20231219072902.90104-1-ytcoode@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 15:29:01 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:

> When an error is detected, use pr_err() instead of kexec_dprintk() to
> output log message.
>
> In addition, remove the unnecessary return from set_page_address().

The above describes what the code does, which is already quite clear
from looking at the code.

Please write changelogs and code comments which describe *why* the code
does something, rather than *what* it does.

>
>
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -429,7 +429,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  	 * command line. Make sure it does not overflow
>  	 */
>  	if (cmdline_len + MAX_ELFCOREHDR_STR_LEN > header->cmdline_size) {
> -		kexec_dprintk("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
> +		pr_err("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");

ie, what are the reasons for this change?

>  		return ERR_PTR(-EINVAL);
>  	}
>  
> diff --git a/mm/highmem.c b/mm/highmem.c
> index e19269093a93..bd48ba445dd4 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -799,8 +799,6 @@ void set_page_address(struct page *page, void *virtual)
>  		}
>  		spin_unlock_irqrestore(&pas->lock, flags);
>  	}
> -
> -	return;
>  }
>  
>  void __init page_address_init(void)
> -- 
> 2.43.0

