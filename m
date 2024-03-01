Return-Path: <linux-kernel+bounces-87977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E8086DBB1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670061C23627
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FB469943;
	Fri,  1 Mar 2024 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpxgFeRR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822B467E8D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709275969; cv=none; b=OY4VB+RoYKvsCdPaWhWyTDh/B9dlz/BHD0rtauE+NIvpcnAKFrxQGHs5eN9ZiM2acRf95ODNDo8S2YqJac9Fzn2wZoCu25O8rnKJ9GtGx+h4C/Zc3qXH5Ut/pAEcXAorlnHGU+g0Cv5iWS0862v84RJzwoaBbM8fMkscyN9ehAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709275969; c=relaxed/simple;
	bh=EwMO3/EgEVBjGx7Oi/1TMd1aSd3iDTtp5SMubZS0FK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMEBUv9hU7hcnnXRjoroozBlBxiIiOds9Y++hDHAxlsBUDHlgx7EBsJqIllZsqKU8eTchJP9cnYTe3dGL1wdoLSvuTE60bnZ7KXSCaBIm/xkRL+cdfY4iUmsac+lyDyOMpKKeXc9luLqi97hLyPPG9pPulYwpVVCDqKa/BmwbEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TpxgFeRR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709275966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1hAv7LCsa3iLqGJhJsJviM4n+BZxClj9lSP/nAIPeEE=;
	b=TpxgFeRROhm2wlLg6Zl15ci8559vraus+YUL3T8KqPMOdgUX0VpfdEi0RF1WE+gx5f+Hst
	uXv1KW9AuwLE/io6SwGhDDgRVVbyeR74SlrWMUjojhnof0m8jm9BcDCM7YMdg5fTm9J9vA
	Yz9y80CCmDE7AnpW1M3J9JvHlRAIJdc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-k9AfNMFUM463nT0FJ3bfzg-1; Fri, 01 Mar 2024 01:52:44 -0500
X-MC-Unique: k9AfNMFUM463nT0FJ3bfzg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B95183FC6C;
	Fri,  1 Mar 2024 06:52:44 +0000 (UTC)
Received: from localhost (unknown [10.72.116.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D4C21BDB1;
	Fri,  1 Mar 2024 06:52:42 +0000 (UTC)
Date: Fri, 1 Mar 2024 14:52:34 +0800
From: Baoquan He <bhe@redhat.com>
To: "yang.zhang" <gaoshanliukou@163.com>, akpm@linux-foundation.org
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, "yang.zhang" <yang.zhang@hexintek.com>
Subject: Re: [PATCH V3] kexec: copy only happens before uchunk goes to zero
Message-ID: <ZeF7Muc8WyuQ1bPR@MiWiFi-R3L-srv>
References: <20240222092119.5602-1-gaoshanliukou@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222092119.5602-1-gaoshanliukou@163.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

CC Andrew

On 02/22/24 at 05:21pm, yang.zhang wrote:
> From: "yang.zhang" <yang.zhang@hexintek.com>
> 
> When loading segments, ubytes is <= mbytes. When ubytes is exhausted,
> there could be remaining mbytes. Then in the while loop, the buf pointer
> advancing with mchunk will causing meaningless reading even though it
> doesn't harm.
> 
> So let's change to make sure that all of the copying and the rest only
> happens before uchunk goes to zero.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: yang.zhang <yang.zhang@hexintek.com>
> 
> ---
> V2 -> V3:
> - Add more detailed description in the commit message
> v1 -> v2:
> - Only copy before uchunk goes to zero
> 
> V1: https://lore.kernel.org/lkml/20240130101802.23850-1-gaoshanliukou@163.com/
> ---
>  kernel/kexec_core.c | 44 ++++++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index d08fc7b5db97..2fc3d0e3715a 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -800,22 +800,24 @@ static int kimage_load_normal_segment(struct kimage *image,
>  				PAGE_SIZE - (maddr & ~PAGE_MASK));
>  		uchunk = min(ubytes, mchunk);
>  
> -		/* For file based kexec, source pages are in kernel memory */
> -		if (image->file_mode)
> -			memcpy(ptr, kbuf, uchunk);
> -		else
> -			result = copy_from_user(ptr, buf, uchunk);
> +		if (uchunk) {
> +			/* For file based kexec, source pages are in kernel memory */
> +			if (image->file_mode)
> +				memcpy(ptr, kbuf, uchunk);
> +			else
> +				result = copy_from_user(ptr, buf, uchunk);
> +			ubytes -= uchunk;
> +			if (image->file_mode)
> +				kbuf += uchunk;
> +			else
> +				buf += uchunk;
> +		}
>  		kunmap_local(ptr);
>  		if (result) {
>  			result = -EFAULT;
>  			goto out;
>  		}
> -		ubytes -= uchunk;
>  		maddr  += mchunk;
> -		if (image->file_mode)
> -			kbuf += mchunk;
> -		else
> -			buf += mchunk;
>  		mbytes -= mchunk;
>  
>  		cond_resched();
> @@ -866,11 +868,18 @@ static int kimage_load_crash_segment(struct kimage *image,
>  			memset(ptr + uchunk, 0, mchunk - uchunk);
>  		}
>  
> -		/* For file based kexec, source pages are in kernel memory */
> -		if (image->file_mode)
> -			memcpy(ptr, kbuf, uchunk);
> -		else
> -			result = copy_from_user(ptr, buf, uchunk);
> +		if (uchunk) {
> +			/* For file based kexec, source pages are in kernel memory */
> +			if (image->file_mode)
> +				memcpy(ptr, kbuf, uchunk);
> +			else
> +				result = copy_from_user(ptr, buf, uchunk);
> +			ubytes -= uchunk;
> +			if (image->file_mode)
> +				kbuf += uchunk;
> +			else
> +				buf += uchunk;
> +		}
>  		kexec_flush_icache_page(page);
>  		kunmap_local(ptr);
>  		arch_kexec_pre_free_pages(page_address(page), 1);
> @@ -878,12 +887,7 @@ static int kimage_load_crash_segment(struct kimage *image,
>  			result = -EFAULT;
>  			goto out;
>  		}
> -		ubytes -= uchunk;
>  		maddr  += mchunk;
> -		if (image->file_mode)
> -			kbuf += mchunk;
> -		else
> -			buf += mchunk;
>  		mbytes -= mchunk;
>  
>  		cond_resched();
> -- 
> 2.25.1
> 


