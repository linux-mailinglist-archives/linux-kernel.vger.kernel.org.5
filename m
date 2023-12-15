Return-Path: <linux-kernel+bounces-404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6416C81409E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE52283C19
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084B153B8;
	Fri, 15 Dec 2023 03:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsUmDUfe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0963CA7A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702610895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xFjrY9f7lb5ZXGSC5fJ2WhnwT5x2Q7SVpnoNQJclmZ8=;
	b=EsUmDUfexP0uwlkQljL8WoWTXarxv27T648omkZNIp3Be7ge37yGpuTV8uiECbGST/cTzC
	6P41zi0BltBrucIXtBf5WseeIpom+EATM7YI1D6ss8PPkFXJRIYSwAkCHYjZHXv/1qRo4J
	1kq2ndaxWn7shKFpK816tSkqOQpyMM4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-NkTdKl5KPOucS2szYBp4IQ-1; Thu, 14 Dec 2023 22:28:12 -0500
X-MC-Unique: NkTdKl5KPOucS2szYBp4IQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 807EA101A555;
	Fri, 15 Dec 2023 03:28:11 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CB362492BF0;
	Fri, 15 Dec 2023 03:28:10 +0000 (UTC)
Date: Fri, 15 Dec 2023 11:28:07 +0800
From: Baoquan He <bhe@redhat.com>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Takashi Iwai <tiwai@suse.de>, Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH 2/3] x86/crash: use SZ_1M macro instead of hardcoded value
Message-ID: <ZXvHx+HYI4zgV47b@MiWiFi-R3L-srv>
References: <20231214163842.129139-1-ytcoode@gmail.com>
 <20231214163842.129139-3-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214163842.129139-3-ytcoode@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 12/15/23 at 12:38am, Yuntao Wang wrote:
> Use SZ_1M macro instead of hardcoded 1<<20 to make code more readable.
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  arch/x86/kernel/crash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 792231a56d11..249b5876e7ec 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c

Acked-by: Baoquan He <bhe@redhat.com>

> @@ -170,7 +170,7 @@ static int elf_header_exclude_ranges(struct crash_mem *cmem)
>  	int ret = 0;
>  
>  	/* Exclude the low 1M because it is always reserved */
> -	ret = crash_exclude_mem_range(cmem, 0, (1<<20)-1);
> +	ret = crash_exclude_mem_range(cmem, 0, SZ_1M - 1);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.43.0
> 


