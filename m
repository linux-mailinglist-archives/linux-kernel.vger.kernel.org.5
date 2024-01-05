Return-Path: <linux-kernel+bounces-17441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED63824D47
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626F928303B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D316F53B9;
	Fri,  5 Jan 2024 02:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bu94Y8tO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023453A2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 02:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704423192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZRlwj1Ne+ckEJ9+O0haqeqR8YbulRGDUzYmUOikZZo=;
	b=bu94Y8tOTF4D1JnVB++R7r4/1LBmTPcLWxpCE4RgYN+WVRySzv3P9w6bOnZfAJiWq62XTn
	RnYn1K5wYTK9qH+5Y2DmyY+h2We1kjCF42xqJHLOxlBAu3+A07K7RNIVcVd1blIPq4BfdP
	RMzySbH8MA5bDTHHHPkJXqGupWII9lY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-I_5iScchPtqKMQsL2pjSaA-1; Thu,
 04 Jan 2024 21:53:09 -0500
X-MC-Unique: I_5iScchPtqKMQsL2pjSaA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD218380662A;
	Fri,  5 Jan 2024 02:53:08 +0000 (UTC)
Received: from localhost (unknown [10.72.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D327492BC7;
	Fri,  5 Jan 2024 02:53:05 +0000 (UTC)
Date: Fri, 5 Jan 2024 10:53:01 +0800
From: Baoquan He <bhe@redhat.com>
To: Huacai Chen <chenhuacai@loongson.cn>, akpm@linux-foundation.org
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Youling Tang <tangyouling@kylinos.cn>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdump: Defer the insertion of crashkernel resources
Message-ID: <ZZdvDYg6sk8P2JWn@MiWiFi-R3L-srv>
References: <20231229080213.2622204-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229080213.2622204-1-chenhuacai@loongson.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Huacai,

On 12/29/23 at 04:02pm, Huacai Chen wrote:
> In /proc/iomem, sub-regions should be inserted after their parent,
> otherwise the insertion of parent resource fails. But after generic
> crashkernel reservation applied, in both RISC-V and ARM64 (LoongArch
> will also use generic reservation later on), crashkernel resources are
> inserted before their parent, which causes the parent disappear in
> /proc/iomem. So we defer the insertion of crashkernel resources to an
> early_initcall().
> 
> 1, Without 'crashkernel' parameter:
> 
>  100d0100-100d01ff : LOON0001:00
>    100d0100-100d01ff : LOON0001:00 LOON0001:00
>  100e0000-100e0bff : LOON0002:00
>    100e0000-100e0bff : LOON0002:00 LOON0002:00
>  1fe001e0-1fe001e7 : serial
>  90400000-fa17ffff : System RAM
>    f6220000-f622ffff : Reserved
>    f9ee0000-f9ee3fff : Reserved
>    fa120000-fa17ffff : Reserved
>  fa190000-fe0bffff : System RAM
>    fa190000-fa1bffff : Reserved
>  fe4e0000-47fffffff : System RAM
>    43c000000-441ffffff : Reserved
>    47ff98000-47ffa3fff : Reserved
>    47ffa4000-47ffa7fff : Reserved
>    47ffa8000-47ffabfff : Reserved
>    47ffac000-47ffaffff : Reserved
>    47ffb0000-47ffb3fff : Reserved
> 
> 2, With 'crashkernel' parameter, before this patch:
> 
>  100d0100-100d01ff : LOON0001:00
>    100d0100-100d01ff : LOON0001:00 LOON0001:00
>  100e0000-100e0bff : LOON0002:00
>    100e0000-100e0bff : LOON0002:00 LOON0002:00
>  1fe001e0-1fe001e7 : serial
>  e6200000-f61fffff : Crash kernel
>  fa190000-fe0bffff : System RAM
>    fa190000-fa1bffff : Reserved
>  fe4e0000-47fffffff : System RAM
>    43c000000-441ffffff : Reserved
>    47ff98000-47ffa3fff : Reserved
>    47ffa4000-47ffa7fff : Reserved
>    47ffa8000-47ffabfff : Reserved
>    47ffac000-47ffaffff : Reserved
>    47ffb0000-47ffb3fff : Reserved
> 
> 3, With 'crashkernel' parameter, after this patch:
> 
>  100d0100-100d01ff : LOON0001:00
>    100d0100-100d01ff : LOON0001:00 LOON0001:00
>  100e0000-100e0bff : LOON0002:00
>    100e0000-100e0bff : LOON0002:00 LOON0002:00
>  1fe001e0-1fe001e7 : serial
>  90400000-fa17ffff : System RAM
>    e6200000-f61fffff : Crash kernel
>    f6220000-f622ffff : Reserved
>    f9ee0000-f9ee3fff : Reserved
>    fa120000-fa17ffff : Reserved
>  fa190000-fe0bffff : System RAM
>    fa190000-fa1bffff : Reserved
>  fe4e0000-47fffffff : System RAM
>    43c000000-441ffffff : Reserved
>    47ff98000-47ffa3fff : Reserved
>    47ffa4000-47ffa7fff : Reserved
>    47ffa8000-47ffabfff : Reserved
>    47ffac000-47ffaffff : Reserved
>    47ffb0000-47ffb3fff : Reserved

This looks like a great catch. I am curious where arm64 and loongarch
insert the system RAM range into iomem before crashk_res and
crashk_low_res. On x86, it should be done by pci or acpi init which is
earlier than crashkernel parsing and inserting into iomem, just went\
through codes, haven't adding debugging code to print.

> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  kernel/crash_core.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index d4313b53837e..755d8d4ef5b0 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -377,7 +377,6 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
>  
>  	crashk_low_res.start = low_base;
>  	crashk_low_res.end   = low_base + low_size - 1;
> -	insert_resource(&iomem_resource, &crashk_low_res);
>  #endif
>  	return 0;
>  }
> @@ -459,8 +458,19 @@ void __init reserve_crashkernel_generic(char *cmdline,
>  
>  	crashk_res.start = crash_base;
>  	crashk_res.end = crash_base + crash_size - 1;
> -	insert_resource(&iomem_resource, &crashk_res);
>  }
> +
> +static __init int insert_crashkernel_resources(void)
> +{
> +	if (crashk_res.start < crashk_res.end)
> +		insert_resource(&iomem_resource, &crashk_res);
> +
> +	if (crashk_low_res.start < crashk_low_res.end)
> +		insert_resource(&iomem_resource, &crashk_low_res);
> +
> +	return 0;
> +}
> +early_initcall(insert_crashkernel_resources);
>  #endif
>  
>  int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
> -- 
> 2.39.3
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


