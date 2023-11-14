Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E69F7EABB1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjKNIhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjKNIhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:37:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD01A4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699951021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gRa0cgOuGSbx17AxlwEuUbrIiLUWRvMO5s1P7qxyaKw=;
        b=WJehPB8G589HfPqGo1h8vUTa/voNB8r7MRLCNOI19h3LZctq1+9oIYu+G0kjIhFboFazA/
        /7fFkLUUIPy1oZNai4JZOCYx+Q3CGE21Zfkk9emRuV2n/MQ1gaERqWFO3Z1SDkSykASji5
        cyIqLRjfnVJ0iUiJGVLXaZWzf6NpzQo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-fuibdTbmNsKhckfdhdfNWw-1; Tue,
 14 Nov 2023 03:36:58 -0500
X-MC-Unique: fuibdTbmNsKhckfdhdfNWw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA9432932480;
        Tue, 14 Nov 2023 08:36:57 +0000 (UTC)
Received: from localhost (unknown [10.72.112.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F05C925C0;
        Tue, 14 Nov 2023 08:36:56 +0000 (UTC)
Date:   Tue, 14 Nov 2023 16:36:53 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     alexander.shishkin@linux.intel.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, ssengar@linux.microsoft.com,
        tglx@linutronix.de, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] x86/setup: Use a more concise memblock API
Message-ID: <ZVMxpXBrE4p3IqhU@MiWiFi-R3L-srv>
References: <ZVLzZlHMXeHIO9eG@MiWiFi-R3L-srv>
 <20231114073700.126543-1-ytcoode@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114073700.126543-1-ytcoode@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/23 at 03:37pm, Yuntao Wang wrote:
> When executing relocate_initrd()/numa_emulation()/numa_alloc_distance(),
> the memblock.current_limit field has already been set to
> `max_pfn_mapped << PAGE_SHIFT`, therefore we can replace
> memblock_phys_alloc_range() with memblock_phys_alloc(), which has the same
> functionality but is more concise.
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
> v1 -> v2:
> 
> Also replace memblock_phys_alloc_range() in numa_emulation() and
> numa_alloc_distance() with memblock_phys_alloc()

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
>  arch/x86/kernel/setup.c      | 3 +--
>  arch/x86/mm/numa.c           | 3 +--
>  arch/x86/mm/numa_emulation.c | 3 +--
>  3 files changed, 3 insertions(+), 6 deletions(-)
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
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index b29ceb19e46e..29cd8fc8ede1 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -378,8 +378,7 @@ static int __init numa_alloc_distance(void)
>  	cnt++;
>  	size = cnt * cnt * sizeof(numa_distance[0]);
> 
> -	phys = memblock_phys_alloc_range(size, PAGE_SIZE, 0,
> -					 PFN_PHYS(max_pfn_mapped));
> +	phys = memblock_phys_alloc(size, PAGE_SIZE);
>  	if (!phys) {
>  		pr_warn("Warning: can't allocate distance table!\n");
>  		/* don't retry until explicitly reset */
> diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
> index 9a9305367fdd..8acb8d0f7d0f 100644
> --- a/arch/x86/mm/numa_emulation.c
> +++ b/arch/x86/mm/numa_emulation.c
> @@ -447,8 +447,7 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
>  	if (numa_dist_cnt) {
>  		u64 phys;
> 
> -		phys = memblock_phys_alloc_range(phys_size, PAGE_SIZE, 0,
> -						 PFN_PHYS(max_pfn_mapped));
> +		phys = memblock_phys_alloc(phys_size, PAGE_SIZE);
>  		if (!phys) {
>  			pr_warn("NUMA: Warning: can't allocate copy of distance table, disabling emulation\n");
>  			goto no_emu;
> --
> 2.42.1
> 

