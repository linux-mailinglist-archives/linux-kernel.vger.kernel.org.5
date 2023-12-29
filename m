Return-Path: <linux-kernel+bounces-13221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CFA820155
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8380A282DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D0113FFB;
	Fri, 29 Dec 2023 20:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rGlAIj2w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4888213FF1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 20:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB32C433C8;
	Fri, 29 Dec 2023 20:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703880615;
	bh=nRJweA6alfblDRh8g5qaz56eqzwAOoHvkXgtYYOUkNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rGlAIj2wbFYkvEoxn4AeYdP5GKwYAAt13/i217HbUQf2vgdpmB7H4ki/UePSuCZyO
	 P5kuYIMwkIatC8cLtfBhQ0gd3LlTnzcf2/gG4Qc0ia5Oh9VeuyGW0/HmHMeVnyPqj3
	 3VuCOhbnLMPRSrALGrF/FzWDWUHjRXuBSGYAB1X0=
Date: Fri, 29 Dec 2023 12:10:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: bhe@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 dyoung@redhat.com, hbathini@linux.ibm.com, hpa@zytor.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 seanjc@google.com, tglx@linutronix.de, tiwai@suse.de, vgoyal@redhat.com,
 x86@kernel.org
Subject: Re: [PATCH] crash_core: optimize crash_exclude_mem_range()
Message-Id: <20231229121014.fd090f8c616a34fbb45f7843@linux-foundation.org>
In-Reply-To: <20231219163418.108591-1-ytcoode@gmail.com>
References: <20231218092902.9fae480cfcad3874e9e7236f@linux-foundation.org>
	<20231219163418.108591-1-ytcoode@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 00:34:18 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:

> Because memory ranges in mem->ranges are stored in ascending order, when we
> detect `p_end < start`, we can break the for loop early, as the subsequent
> memory ranges must also be outside the range we are looking for.
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
> Hi Andrew,
> 
> Patch "[PATCH 2/2] crash_core: fix out-of-bounds access check in
> crash_exclude_mem_range()" can be ignored, use this patch instead.
> 

Some reviewer input on this would be helpful please?

> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -575,9 +575,12 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>  		p_start = mstart;
>  		p_end = mend;
>  
> -		if (p_start > end || p_end < start)
> +		if (p_start > end)
>  			continue;
>  
> +		if (p_end < start)
> +			break;
> +
>  		/* Truncate any area outside of range */
>  		if (p_start < start)
>  			p_start = start;
> -- 
> 2.43.0

