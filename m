Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6C57F97A4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjK0Cvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjK0Cvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:51:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B69111
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701053510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IKWQaEsR/p/IgYIkhOghvk9JdKsTzVVqrJ68PyhT4Os=;
        b=aJxRoLQORpvihQpwS2XniCdiO+rZC16Yy0Qpq+gnTz4rw7XPWXXQTUynMhcWzcvFF2NBX4
        OjeB/hRgiTRN4UAH9di75WDur6fxBlV1DuTy/WtEvnHXthGLyCyQtjQI+ZzAzE6vFrmOIt
        Sr9/L1MLWg0z1di1vX42AhJI1jrQUVY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-YUiZv4FFMWGxnDQun8zWTg-1; Sun, 26 Nov 2023 21:51:47 -0500
X-MC-Unique: YUiZv4FFMWGxnDQun8zWTg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1588A852AC0;
        Mon, 27 Nov 2023 02:51:47 +0000 (UTC)
Received: from localhost (unknown [10.72.112.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A30E1C060BB;
        Mon, 27 Nov 2023 02:51:45 +0000 (UTC)
Date:   Mon, 27 Nov 2023 10:51:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     k-hagio-ab@nec.com, lijiang@redhat.com, akpm@linux-foundation.org,
        vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com
Subject: Re: [PATCH] crash_core: export vmemmap when CONFIG_SPARSEMEM_VMEMMAP
 is enabled
Message-ID: <ZWQEP4SczFh+GUHq@MiWiFi-R3L-srv>
References: <20231127020727.25296-1-shijie@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127020727.25296-1-shijie@os.amperecomputing.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/27/23 at 10:07am, Huang Shijie wrote:
> In memory_model.h, if CONFIG_SPARSEMEM_VMEMMAP is configed,
> kernel will use vmemmap to do the __pfn_to_page/page_to_pfn,
> and kernel will not use the "classic sparse" to do the
> __pfn_to_page/page_to_pfn.
> 
> So export the vmemmap when CONFIG_SPARSEMEM_VMEMMAP is configed.
> This makes the user applications (crash, etc) get faster
> pfn_to_page/page_to_pfn operations too.

Are there Crash or makedupfile patches posted yet to make use of this?

> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>  kernel/crash_core.c | 3 +++
>  1 file changed, 3 insertions(+)
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

