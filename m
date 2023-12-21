Return-Path: <linux-kernel+bounces-7830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AD581ADE7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4978E286EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BD079E0;
	Thu, 21 Dec 2023 04:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wo9RKi5b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBF26FB9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 04:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703131962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LYwTBqplqqI5GDQJ4vYImBgIRehExp2gFU18Pdx2r5A=;
	b=Wo9RKi5bEPXdf1J4jO3NHnYX5tVfS53mGaOavN9UcUgDFWy1v13EZtMLfdphfawunRazZX
	n+gPes63UrFTnSnk6tuMQV078dhsXH3RfOZ5KC+W2rJ1Zu34ODn9KYchLuRo4PQOEmq8Ol
	tlBjsWEmbiPdYjo7B/pTnq/dliZ84eQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-PbxvE6g8MM-gJ25qgLEakw-1; Wed,
 20 Dec 2023 23:12:38 -0500
X-MC-Unique: PbxvE6g8MM-gJ25qgLEakw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CD242999B21;
	Thu, 21 Dec 2023 04:12:38 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7503840C6EB9;
	Thu, 21 Dec 2023 04:12:37 +0000 (UTC)
Date: Thu, 21 Dec 2023 12:12:34 +0800
From: Baoquan He <bhe@redhat.com>
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, patches@amperecomputing.com
Subject: Re: [PATCH] crash_core: export vmemmap when CONFIG_SPARSEMEM_VMEMMAP
 is enabled
Message-ID: <ZYO7MvpT9yWWfjO7@MiWiFi-R3L-srv>
References: <20231127020727.25296-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127020727.25296-1-shijie@os.amperecomputing.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 11/27/23 at 10:07am, Huang Shijie wrote:
> In memory_model.h, if CONFIG_SPARSEMEM_VMEMMAP is configed,
> kernel will use vmemmap to do the __pfn_to_page/page_to_pfn,
> and kernel will not use the "classic sparse" to do the
> __pfn_to_page/page_to_pfn.
> 
> So export the vmemmap when CONFIG_SPARSEMEM_VMEMMAP is configed.
> This makes the user applications (crash, etc) get faster
> pfn_to_page/page_to_pfn operations too.
> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>  kernel/crash_core.c | 3 +++
>  1 file changed, 3 insertions(+)

Ack this one as it's needed by crash utility patches.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index efe87d501c8c..9653c4177191 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -765,6 +765,9 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_SYMBOL(mem_map);
>  	VMCOREINFO_SYMBOL(contig_page_data);
>  #endif
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +	VMCOREINFO_SYMBOL_ARRAY(vmemmap);
> +#endif
>  #ifdef CONFIG_SPARSEMEM
>  	VMCOREINFO_SYMBOL_ARRAY(mem_section);
>  	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
> -- 
> 2.40.1
> 


