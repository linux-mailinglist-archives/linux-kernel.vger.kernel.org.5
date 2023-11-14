Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858F07EA95A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjKNELe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjKNELb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:11:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF0CD0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699935088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ojS2yvH3DYT4KA+dHgRjGsyo8636ykqiX59l7FiYbWU=;
        b=N4ZHQVW7rNhnv+FW/oNeoi3cWvn5f7i3a29Py3CFSo69gyS95Dxn56dwEltcMtcgIPa8Vk
        Rq2/mi1jL8xPMQeTm8yTH0Vhiyn7j+FZHwNRo3YUaN1TCZzf7EiL6KHfroohBVR5Zw3w+3
        zN9R0Jp212C9xiFmk4OtU5cJY8SZJU0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-sYMOA5SqP52jCwNBeokFsQ-1; Mon, 13 Nov 2023 23:11:23 -0500
X-MC-Unique: sYMOA5SqP52jCwNBeokFsQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 113D8811E7B;
        Tue, 14 Nov 2023 04:11:23 +0000 (UTC)
Received: from localhost (unknown [10.72.112.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3EED2026D6E;
        Tue, 14 Nov 2023 04:11:21 +0000 (UTC)
Date:   Tue, 14 Nov 2023 12:11:18 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH] x86/setup: Use a more concise memblock API
Message-ID: <ZVLzZlHMXeHIO9eG@MiWiFi-R3L-srv>
References: <20231114031418.60745-1-ytcoode@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114031418.60745-1-ytcoode@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/23 at 11:14am, Yuntao Wang wrote:
> When executing relocate_initrd(), the memblock.current_limit field has
> already been set to `max_pfn_mapped << PAGE_SHIFT`, so we can replace
> memblock_phys_alloc_range() with memblock_phys_alloc(), which has the same
> functionality but is more concise.

Fine to me, do we need consider other places in:

numa_alloc_distance()
numa_emulation()

> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  arch/x86/kernel/setup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index ec2c21a1844e..422497c17eec 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -259,8 +259,7 @@ static void __init relocate_initrd(void)
>  	u64 area_size     = PAGE_ALIGN(ramdisk_size);
>  
>  	/* We need to move the initrd down into directly mapped mem */
> -	u64 relocated_ramdisk = memblock_phys_alloc_range(area_size, PAGE_SIZE, 0,
> -						      PFN_PHYS(max_pfn_mapped));
> +	u64 relocated_ramdisk = memblock_phys_alloc(area_size, PAGE_SIZE);
>  	if (!relocated_ramdisk)
>  		panic("Cannot find place for new RAMDISK of size %lld\n",
>  		      ramdisk_size);
> -- 
> 2.42.1
> 

