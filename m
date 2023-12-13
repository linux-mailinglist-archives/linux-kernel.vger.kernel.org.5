Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4136F810864
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378357AbjLMCtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378288AbjLMCtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:49:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9817798
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702435756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=coQ8pvaq2UkX5cEo9LeuOuQYxw7SGcKK+T3HPyA15No=;
        b=F7FbRF122HkJkrGhzIXOS88MTpupKmvGiHrFF7EPgAom/wDkQppJ3Z5DTnvUDzXPz471GJ
        /yksR+GocbGjiH6oYenLrygU1066+waP4SqOwAblH+3eAw1IvZBKoeYlMZHh/jJoTMtoHJ
        R3skccOI+cxmmlbKvXKi8UnKz/ZaIG0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-n-aNT_MWPnmDeaWCx57W_A-1; Tue, 12 Dec 2023 21:49:13 -0500
X-MC-Unique: n-aNT_MWPnmDeaWCx57W_A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACC7A830F96;
        Wed, 13 Dec 2023 02:49:12 +0000 (UTC)
Received: from localhost (unknown [10.72.116.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EFA9D2026D66;
        Wed, 13 Dec 2023 02:49:11 +0000 (UTC)
Date:   Wed, 13 Dec 2023 10:49:08 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kexec: Use ALIGN macro instead of open-coding it
Message-ID: <ZXkbpNubH69pAjg1@MiWiFi-R3L-srv>
References: <20231212142706.25149-1-ytcoode@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212142706.25149-1-ytcoode@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 at 10:27pm, Yuntao Wang wrote:
> Use ALIGN macro instead of open-coding it to improve code readability.
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  kernel/kexec_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index be5642a4ec49..0113436e4a3a 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -430,7 +430,7 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
>  
>  	pages = NULL;
>  	size = (1 << order) << PAGE_SHIFT;
> -	hole_start = (image->control_page + (size - 1)) & ~(size - 1);
> +	hole_start = ALIGN(image->control_page, size);
>  	hole_end   = hole_start + size - 1;
>  	while (hole_end <= crashk_res.end) {
>  		unsigned long i;
> @@ -447,7 +447,7 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
>  			mend   = mstart + image->segment[i].memsz - 1;
>  			if ((hole_end >= mstart) && (hole_start <= mend)) {
>  				/* Advance the hole to the end of the segment */
> -				hole_start = (mend + (size - 1)) & ~(size - 1);
> +				hole_start = ALIGN(mend, size);
>  				hole_end   = hole_start + size - 1;
>  				break;
>  			}
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

