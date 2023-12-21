Return-Path: <linux-kernel+bounces-8434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E4D81B717
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FCB7B222C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA5773182;
	Thu, 21 Dec 2023 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3ujxu66"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B34D73489
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703164483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1eNoYJka76W6z/XIQNg+OgUP1x/5sVSGmIF7sB3PyIM=;
	b=R3ujxu667YT4xSxNx/5hAh4bvS1jjF+Rms+Qic0uAp50hR58AWkEQkvY5vVUXzsDPj+h1X
	mzblnrGzYWYFIkdbrptmtgy3uNBXR+d3fn7HDUnTYt8sxRQbbgRQTXBQsaDT6OXwdlDN+j
	tJCjqw7ihqjEj1s52fjur9KCC/EtTvo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-9gOrF8nDO3O1s7WKoG1OmQ-1; Thu,
 21 Dec 2023 08:14:39 -0500
X-MC-Unique: 9gOrF8nDO3O1s7WKoG1OmQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B5AD3816B4E;
	Thu, 21 Dec 2023 13:14:39 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D7ACC2166B31;
	Thu, 21 Dec 2023 13:14:38 +0000 (UTC)
Date: Thu, 21 Dec 2023 21:14:35 +0800
From: Baoquan He <bhe@redhat.com>
To: fuqiang wang <fuqiang.wang@easystack.cn>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/kexec: Fix potential out of bounds in
 crash_setup_memmap_entries()
Message-ID: <ZYQ6O/57sHAPxTHm@MiWiFi-R3L-srv>
References: <20231220055733.100325-1-fuqiang.wang@easystack.cn>
 <20231220055733.100325-2-fuqiang.wang@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220055733.100325-2-fuqiang.wang@easystack.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 12/20/23 at 01:57pm, fuqiang wang wrote:
> In memmap_exclude_ranges(), there will exclude elfheader from
> crashk_res. In the current x86 architecture code, the elfheader is
> always allocated at crashk_res.start. It seems that there won't be a
> split a new range. But it depends on the allocation position of
> elfheader in crashk_res. To avoid potential out of bounds in future, Set
> the array size to 2.

If so, I would suggest to add extra slot for low 1M too in
fill_up_crash_elf_data() lest the low 1M could be changed in the future,
e.g [start, 1M].

> 
> But similar issue will not exist in fill_up_crash_elf_data(). Because
> the range to be excluded is [0, 1M], start (0) is special and will not
> appear in the middle of existing cmem->ranges[]. I added a comment to
> explain it.
> 
> Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
> ---
>  arch/x86/kernel/crash.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index c92d88680dbf..1c15d0884c90 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -149,6 +149,13 @@ static struct crash_mem *fill_up_crash_elf_data(void)
>  	/*
>  	 * Exclusion of crash region and/or crashk_low_res may cause
>  	 * another range split. So add extra two slots here.
> +	 *
> +	 * Exclusion of low 1M may not cause another range split, because the
> +	 * range of exclude is [0, 1M] and the condition for splitting a new
> +	 * region is that the start, end parameters are both in a certain
> +	 * existing region in cmem and cannot be equal to existing region's
> +	 * start or end. Obviously, the start of [0, 1M] cannot meet this
> +	 * condition.
>  	 */
>  	nr_ranges += 2;
>  	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
> @@ -282,9 +289,15 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>  	struct crash_memmap_data cmd;
>  	struct crash_mem *cmem;
>  
> -	cmem = vzalloc(struct_size(cmem, ranges, 1));
> +	cmem = vzalloc(struct_size(cmem, ranges, 2));
>  	if (!cmem)
>  		return -ENOMEM;
> +	cmem->max_nr_ranges = 2;
> +
> +	/* Exclude some ranges from crashk_res and add rest to memmap */
> +	ret = memmap_exclude_ranges(image, cmem, crashk_res.start, crashk_res.end);
> +	if (ret)
> +		goto out;
>  
>  	memset(&cmd, 0, sizeof(struct crash_memmap_data));
>  	cmd.params = params;
> @@ -320,11 +333,6 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>  		add_e820_entry(params, &ei);
>  	}
>  
> -	/* Exclude some ranges from crashk_res and add rest to memmap */
> -	ret = memmap_exclude_ranges(image, cmem, crashk_res.start, crashk_res.end);
> -	if (ret)
> -		goto out;

And you didn't mention moving above code block up in log. I would
suggest keeping it as is because it looks more reasonable to be adjacent
to the following cmem->ranges[] handling.

> -
>  	for (i = 0; i < cmem->nr_ranges; i++) {
>  		ei.size = cmem->ranges[i].end - cmem->ranges[i].start + 1;
>  
> -- 
> 2.42.0
> 


