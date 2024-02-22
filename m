Return-Path: <linux-kernel+bounces-76023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC1285F20D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E87BB22B05
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35AC179AA;
	Thu, 22 Feb 2024 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUEeSUDj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A042217988
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708587955; cv=none; b=GJUjJXlqF+vJLwPcu3MWUIdhZrYPkUEgRYpXxFxqDbd+AtGyT89fB0Z5exm9d62XX7UR6vX6OTz921kXO0EIYo4+o2U/Jovp7mc9liIGvFp7gF8/wUi8/wzcrgRja5Aw90LZ7+t/34PhGnYfJ0rreuP/wgSrYS86Xvtdtmc6LQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708587955; c=relaxed/simple;
	bh=wH+GN0xPo0yeHLLqezLJvybgqWs4nICGdwacbddb4MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0KdWT46S856l6G/hp0qpLMS+I3b0CgfHYGcAzTRrlZdV6FUIHXfLfZTToNwkI/L1urAHp1nMAg07bvMy/P5QrK5spvW2Gg2rq5TgLPVQ79tIENMovNBaFPm1r0lPgMBiJSjDOS/kSsX9Z5eWcJSTQ+LTzYNKmHALwfO8zqvJBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fUEeSUDj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708587952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CWJNOewjkbYW7x9RFz6EQgzz3x0akjI564V6xJTycn4=;
	b=fUEeSUDjQVuo4xNyMzvssisbIbpzfrEY683TqOD6kWdonRIsbsqM4mSikKkC1udNVBnJit
	VITO1E8REyWTtryFBy5lG55txDt13XRxXkBGv5tKhBjQNd1xyJUd87lpB0DVsUxYhn34Ce
	oqZYLET/qAyolJK9HEg53l2KBdoK1Xc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-BpkYVYw7PvSVZX4hEb9qVw-1; Thu, 22 Feb 2024 02:45:48 -0500
X-MC-Unique: BpkYVYw7PvSVZX4hEb9qVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43DE11021F64;
	Thu, 22 Feb 2024 07:45:48 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 38A011121337;
	Thu, 22 Feb 2024 07:45:27 +0000 (UTC)
Date: Thu, 22 Feb 2024 15:45:38 +0800
From: Baoquan He <bhe@redhat.com>
To: "yang.zhang" <gaoshanliukou@163.com>
Cc: ebiederm@xmission.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	"yang.zhang" <yang.zhang@hexintek.com>
Subject: Re: [PATCH v2] kexec: copy only happens before uchunk goes to zero
Message-ID: <Zdb7ogmu/7IOBN3U@MiWiFi-R3L-srv>
References: <20240220021106.694-1-gaoshanliukou@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220021106.694-1-gaoshanliukou@163.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 02/20/24 at 10:11am, yang.zhang wrote:
> From: "yang.zhang" <yang.zhang@hexintek.com>
> 
> When load segments, all of the copying and the rest
> only happens before uchunk goes to zero.

The code change looks good, while the log can be improved with more
details so that people can more easily get what's wrong and fixed.

===
When loading segments, ubytes is <= mbytes. When ubytes is exhausted,
there could be remaining mbytes. Then in the while loop, the buf pointer
advancing with mchunk will causing meaningless reading even though it
doesn't harm. 

So let's change to make sure that all of the copying and the rest only
happens before uchunk goes to zero.
===

Please take above words as reference to udpate patch log and post v3,
and you can add:

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: yang.zhang <yang.zhang@hexintek.com>
> 
> ---
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


