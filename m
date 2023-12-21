Return-Path: <linux-kernel+bounces-8298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B382C81B51E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA0ABB20B62
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8B46DD18;
	Thu, 21 Dec 2023 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUzxyK6q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8872D6D1C6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703158949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wO71qD98XeNn6o22z4de+p4+swSxefVPiivSdhVSM3Q=;
	b=NUzxyK6q8iPYgWiGZ2H/fzJQrR0VqfG/AaQK4nCNJOPZ3aPBywBg1NiCS/FlDsSaOaDPqw
	3N72xToLVzuFKarH0bmJHraFnuWbYF4DEvuTnUqZ6yRZdZr5x/egGQtewtJL1MkHkkugoa
	eblp/8qxEdR8X1/NymC4bGS19Si9Yic=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-dSYlwMV3Mn6BjRBhtZiqkg-1; Thu, 21 Dec 2023 06:42:26 -0500
X-MC-Unique: dSYlwMV3Mn6BjRBhtZiqkg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDB2285A588;
	Thu, 21 Dec 2023 11:42:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 38E5F51D5;
	Thu, 21 Dec 2023 11:42:24 +0000 (UTC)
Date: Thu, 21 Dec 2023 19:42:21 +0800
From: Baoquan He <bhe@redhat.com>
To: fuqiang wang <fuqiang.wang@easystack.cn>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] kexec: Fix potential out of bounds in
 crash_exclude_mem_range()
Message-ID: <ZYQknSaxtNt/ZQvI@MiWiFi-R3L-srv>
References: <20231220055733.100325-1-fuqiang.wang@easystack.cn>
 <20231220055733.100325-3-fuqiang.wang@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220055733.100325-3-fuqiang.wang@easystack.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 12/20/23 at 01:57pm, fuqiang wang wrote:
> When the split does not occur on the last array member, the current code
> will not return an error. So the correct array out-of-bounds check should
> be mem->nr_ranges >= mem->max_nr_ranges.
> 
> When the OOB happen, the cmem->ranges[] have changed, so return early to
> avoid it.
> 
> Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
> ---
>  kernel/crash_core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

You may need rebase your work on next/master branch to avoid conflict.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

In the current, below commit exists, then code change in this patch may
not be needed.
86d80cbb61ca crash_core: fix and simplify the logic of crash_exclude_mem_range()

> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index d4313b53837e..b1ab61c74fd2 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -611,6 +611,9 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>  		}
>  
>  		if (p_start > start && p_end < end) {
> +			/* Split happened */
> +			if (mem->nr_ranges >= mem->max_nr_ranges)
> +				return -ENOMEM;
>  			/* Split original range */
>  			mem->ranges[i].end = p_start - 1;
>  			temp_range.start = p_end + 1;
> @@ -626,10 +629,6 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>  	if (!temp_range.end)
>  		return 0;
>  
> -	/* Split happened */
> -	if (i == mem->max_nr_ranges - 1)
> -		return -ENOMEM;
> -
>  	/* Location where new range should go */
>  	j = i + 1;
>  	if (j < mem->nr_ranges) {
> -- 
> 2.42.0
> 


