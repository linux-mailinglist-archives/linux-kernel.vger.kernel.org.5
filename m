Return-Path: <linux-kernel+bounces-4241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 750E5817995
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E891F225E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00895D733;
	Mon, 18 Dec 2023 18:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lcoClL5r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDF91DFDE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 18:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDB5C433C8;
	Mon, 18 Dec 2023 18:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702923877;
	bh=657RT1T9y1phDXkS/PHN8nnyPlTK2iy7Gb6uK7ychM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lcoClL5r5VFKM+Vwx2E8RTpZRVRehkx37EPGW7dnqKX0wceVFir7l7S4oxOh+3KWB
	 TdQ+jFzYNIdNRFQ8cX69IusNvbaA/9i/lw3vCOct1gj8RbHp6NRhgv8bUNlh+9aRdH
	 i7/a0+HnsVql6jO5M/f7JBSj1zX/vN7oCl6Iyz64=
Date: Mon, 18 Dec 2023 10:24:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Eric
 Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v5 3/3] x86/kexec: use pr_err() instead of pr_debug()
 when an error occurs
Message-Id: <20231218102436.4378f51a36525ce770f6cd30@linux-foundation.org>
In-Reply-To: <20231217033528.303333-4-ytcoode@gmail.com>
References: <20231217033528.303333-1-ytcoode@gmail.com>
	<20231217033528.303333-4-ytcoode@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Dec 2023 11:35:28 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:

> When an error is detected, use pr_err() instead of pr_debug() to output
> log message.
> 
> In addition, remove the unnecessary return from set_page_address().
> 
> ...
>
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -424,7 +424,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  	 * command line. Make sure it does not overflow
>  	 */
>  	if (cmdline_len + MAX_ELFCOREHDR_STR_LEN > header->cmdline_size) {
> -		pr_debug("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
> +		pr_err("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
>  		return ERR_PTR(-EINVAL);
>  	}

https://lkml.kernel.org/r/20231213055747.61826-4-bhe@redhat.com has
already changed this to call kexec_dprintk().  I'll skip this patch.


