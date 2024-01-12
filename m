Return-Path: <linux-kernel+bounces-24318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5489782BAF0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745531C21D9B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5492B5B5D3;
	Fri, 12 Jan 2024 05:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDURiJiU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47FC5B5A3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 05:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705038121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g6BSFRepca9WGGc5Fa5O/uOTZnuhNDHcJLcyaQXXfX4=;
	b=eDURiJiUxpslLKjsd+D8wp/a0M0K6NJqZOMtzp+IIpSowyk+q4wJMlUkc9LtJIfY/Wy8AE
	O/E6xHq+oev7Ey9QMHz65A+xD2sx1IETktDRBrqgdomELGHV/iRb6ARzqDVe5CiPukxF/J
	DsRz4s4rRyaj0Dc5wXv5bqnscNf+ie8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-3isU-4a_PDSNjcCvGJ2gNA-1; Fri, 12 Jan 2024 00:41:56 -0500
X-MC-Unique: 3isU-4a_PDSNjcCvGJ2gNA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AA6C85A588;
	Fri, 12 Jan 2024 05:41:55 +0000 (UTC)
Received: from localhost (unknown [10.72.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EC2FD2026D66;
	Fri, 12 Jan 2024 05:41:53 +0000 (UTC)
Date: Fri, 12 Jan 2024 13:41:50 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Fix a warning in the
 crash_save_vmcoreinfo_init()
Message-ID: <ZaDRHtdVsXJTYyul@MiWiFi-R3L-srv>
References: <20240111192329.449189-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111192329.449189-1-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 01/11/24 at 08:23pm, Uladzislau Rezki (Sony) wrote:
> The vmcoreinfo_append_str() function expects "long unsigned int"
> type as a second argument(0x%lx) to print a beginning of vmalloc
> start address which is defined as a VMALLOC_START macro.
> 
> For some architectures it can be considered as "int" type, for
> example m68 generates a compile warning message. To fix it cast
> a second argument to "unsigned long".
> 
> Fixes: 9bdb180b2d ("mm/vmalloc: remove vmap_area_list")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401120218.y469Puyf-lkp@intel.com/
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/crash_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index b60de490c1fc..49b31e59d3cc 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -748,7 +748,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
>  #endif
>  	VMCOREINFO_SYMBOL(_stext);
> -	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
> +	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", (unsigned long) VMALLOC_START);

Thanks for the fix.

Acked-by: Baoquan He <bhe@redhat.com>

>  
>  #ifndef CONFIG_NUMA
>  	VMCOREINFO_SYMBOL(mem_map);
> -- 
> 2.39.2
> 


