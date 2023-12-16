Return-Path: <linux-kernel+bounces-2144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7553815888
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 10:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9601C246BF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 09:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998641429C;
	Sat, 16 Dec 2023 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHKeopBh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F51A13ACA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702718987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iV/0H/EM6kRSbee5O+9rb42NWYjI9R8lAf+9rlZ09wE=;
	b=VHKeopBh+OjfKog2A9C438eSDIa4Q+SYuv26Z4AYe0Ir8YLQK87flN6ndmjf7zm1TYSCyb
	tbOrg/MwoplvaCwrtq9zdySSCSq1U2FqgHo0UxgWbvFrGTQwssY71X4oVOixzRijP7xrTF
	XgbgsdEMySkkYKY/JguLvM0s48/pvFA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-8DcM_2ESOUq5HsralOMKvQ-1; Sat, 16 Dec 2023 04:29:41 -0500
X-MC-Unique: 8DcM_2ESOUq5HsralOMKvQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F20A1833944;
	Sat, 16 Dec 2023 09:29:40 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A093C1121306;
	Sat, 16 Dec 2023 09:29:39 +0000 (UTC)
Date: Sat, 16 Dec 2023 17:29:35 +0800
From: Baoquan He <bhe@redhat.com>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: akpm@linux-foundation.org, bp@alien8.de, corbet@lwn.net,
	dave.hansen@linux.intel.com, ebiederm@xmission.com, hpa@zytor.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH 1/3 v2] kexec: modify the meaning of the end parameter in
 kimage_is_destination_range()
Message-ID: <ZX1t/4Reai6HdoJf@MiWiFi-R3L-srv>
References: <ZX0JwbQ59XH5rqm9@MiWiFi-R3L-srv>
 <20231216041833.220466-1-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216041833.220466-1-ytcoode@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 12/16/23 at 12:18pm, Yuntao Wang wrote:
> The end parameter received by kimage_is_destination_range() should be the
> last valid byte address of the target memory segment plus 1. However, in
> the locate_mem_hole_bottom_up() and locate_mem_hole_top_down() functions,
> the corresponding value passed to kimage_is_destination_range() is the last
> valid byte address of the target memory segment, which is 1 less.
> 
> There are two ways to fix this bug. We can either correct the logic of the
> locate_mem_hole_bottom_up() and locate_mem_hole_top_down() functions, or we
> can fix kimage_is_destination_range() by making the end parameter represent
> the last valid byte address of the target memory segment. Here, we choose
> the second approach.
> 
> Due to the modification to kimage_is_destination_range(), we also need to
> adjust its callers, such as kimage_alloc_normal_control_pages() and
> kimage_alloc_page().
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
> v1->v2:
>   Fix this issue using the approach suggested by Eric and Baoquan.
> 
>   As this patch is independent of the other patches in this series, I sent
>   out the v2 patch separately. If it's inconvenient for anyone, I can
>   resend the entire series again.
> 
>  kernel/kexec_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index be5642a4ec49..5991b3ae072c 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -276,8 +276,8 @@ int kimage_is_destination_range(struct kimage *image,
>  		unsigned long mstart, mend;
>  
>  		mstart = image->segment[i].mem;
> -		mend = mstart + image->segment[i].memsz;
> -		if ((end > mstart) && (start < mend))
> +		mend = mstart + image->segment[i].memsz - 1;
> +		if ((end >= mstart) && (start <= mend))
>  			return 1;
>  	}
>  
> @@ -372,7 +372,7 @@ static struct page *kimage_alloc_normal_control_pages(struct kimage *image,
>  		addr  = pfn << PAGE_SHIFT;
>  		eaddr = epfn << PAGE_SHIFT;

  		eaddr = epfn << PAGE_SHIFT - 1;

The overall looks good to me, one tiny concern is I would like to
have 'eaddr' changed as above if a specific local variable has been
defined.

>  		if ((epfn >= (KEXEC_CONTROL_MEMORY_LIMIT >> PAGE_SHIFT)) ||
> -			      kimage_is_destination_range(image, addr, eaddr)) {
> +			      kimage_is_destination_range(image, addr, eaddr - 1)) {

Then we have:

 +			      kimage_is_destination_range(image, addr, eaddr)) {


>  			list_add(&pages->lru, &extra_pages);
>  			pages = NULL;
>  		}
> @@ -716,7 +716,7 @@ static struct page *kimage_alloc_page(struct kimage *image,
>  
>  		/* If the page is not a destination page use it */
>  		if (!kimage_is_destination_range(image, addr,
> -						  addr + PAGE_SIZE))
> +						  addr + PAGE_SIZE - 1))
>  			break;
>  
>  		/*
> -- 
> 2.43.0
> 


