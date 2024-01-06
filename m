Return-Path: <linux-kernel+bounces-18456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D72825DCF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 03:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A75FFB23056
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 02:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E40E15AB;
	Sat,  6 Jan 2024 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCN2Prq2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FE1136F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 02:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704506981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ralLWF95EMwMr9Y7Fs/3WcboK17YpbM9ruojoVv6Wh4=;
	b=RCN2Prq2Vuf7Rq1MlkhbEk3B4s43+qoizBi+Jg32LLMuWYJB7HF/sXniVdk96ySgfTzaX5
	ffRMRLTd51v1+UZu1RX4x0g6FF5QqaDR7aqaacxUWWe9GMjVYnp9a82/4KjbhUgYoIWT9h
	oh0eyw5Jyp+msVRgv6l6xp7y/SVs8A4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-kxv7lDphNcaJwhh3PvQing-1; Fri, 05 Jan 2024 21:09:34 -0500
X-MC-Unique: kxv7lDphNcaJwhh3PvQing-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6005985A588;
	Sat,  6 Jan 2024 02:09:34 +0000 (UTC)
Received: from localhost (unknown [10.72.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C9B0B3C27;
	Sat,  6 Jan 2024 02:09:32 +0000 (UTC)
Date: Sat, 6 Jan 2024 10:09:29 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Youling Tang <tangyouling@kylinos.cn>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdump: Defer the insertion of crashkernel resources
Message-ID: <ZZi2WXVmXHcmd17c@MiWiFi-R3L-srv>
References: <20231229080213.2622204-1-chenhuacai@loongson.cn>
 <20240105084911.b64f43b12b0c7e25436cb093@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105084911.b64f43b12b0c7e25436cb093@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 01/05/24 at 08:49am, Andrew Morton wrote:
> On Fri, 29 Dec 2023 16:02:13 +0800 Huacai Chen <chenhuacai@loongson.cn> wrote:
> 
> > In /proc/iomem, sub-regions should be inserted after their parent,
> > otherwise the insertion of parent resource fails. But after generic
> > crashkernel reservation applied, in both RISC-V and ARM64 (LoongArch
> > will also use generic reservation later on), crashkernel resources are
> > inserted before their parent, which causes the parent disappear in
> > /proc/iomem. So we defer the insertion of crashkernel resources to an
> > early_initcall().
> > 
> > ...
> >
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -377,7 +377,6 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
> >  
> >  	crashk_low_res.start = low_base;
> >  	crashk_low_res.end   = low_base + low_size - 1;
> > -	insert_resource(&iomem_resource, &crashk_low_res);
> >  #endif
> >  	return 0;
> >  }
> > @@ -459,8 +458,19 @@ void __init reserve_crashkernel_generic(char *cmdline,
> >  
> >  	crashk_res.start = crash_base;
> >  	crashk_res.end = crash_base + crash_size - 1;
> > -	insert_resource(&iomem_resource, &crashk_res);
> >  }
> > +
> > +static __init int insert_crashkernel_resources(void)
> > +{
> > +	if (crashk_res.start < crashk_res.end)
> > +		insert_resource(&iomem_resource, &crashk_res);
> > +
> > +	if (crashk_low_res.start < crashk_low_res.end)
> > +		insert_resource(&iomem_resource, &crashk_low_res);
> > +
> > +	return 0;
> > +}
> > +early_initcall(insert_crashkernel_resources);
> >  #endif
> >  
> >  int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
> 
> I'm thinking 
> 
> Fixes: 0ab97169aa0 ("crash_core: add generic function to do reservation").

Yes.

> 
> Also, is this a regression?  Were earlier kernels OK?

It's a regression, will impact arm64 in v6.6 kernel. Add below too?

Cc: <stable@vger.kernel.org> # 6.6.x


