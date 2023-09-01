Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F2078FB9B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346456AbjIAKL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 06:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjIAKL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4E0FC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 03:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693563041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q456NUShtf2WogSHXj6ov5yi106wsm6xbREboVKzgDk=;
        b=UpSUxSk11Umzq2FcAC254AGwnQiSYxAyZrwsQsTcO3Sv6LF+8ETJeU3iBZxFxdpb9I5tt1
        2Gl8RvAEfROKmYogjWYVYeEcIqNJkU1u/LIWH7beppmwW5S8AKYyCl2ZZWIQj66zyoXOo7
        6NXbNBUjbqp42C+j7Zm3PSmAj5InIn0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-687-QwiV2FkgMJGMDhMCbxQXZA-1; Fri, 01 Sep 2023 06:10:37 -0400
X-MC-Unique: QwiV2FkgMJGMDhMCbxQXZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B42BE3C0D848;
        Fri,  1 Sep 2023 10:10:36 +0000 (UTC)
Received: from localhost (unknown [10.72.113.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 06C42201B07A;
        Fri,  1 Sep 2023 10:10:35 +0000 (UTC)
Date:   Fri, 1 Sep 2023 18:10:32 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, thunder.leizhen@huawei.com,
        dyoung@redhat.com, prudo@redhat.com, samuel.holland@sifive.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v2 6/8] x86: kdump: use generic interface to simplify
 crashkernel reservation code
Message-ID: <ZPG4mKmxaU78u/2k@MiWiFi-R3L-srv>
References: <20230829121610.138107-1-bhe@redhat.com>
 <20230829121610.138107-7-bhe@redhat.com>
 <5b53d460-7134-e292-77ec-967016e89003@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b53d460-7134-e292-77ec-967016e89003@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/23 at 11:43am, Leizhen (ThunderTown) wrote:
......  
> > -static void __init reserve_crashkernel(void)
> > +static void __init arch_reserve_crashkernel(void)
> >  {
> > -	unsigned long long crash_size, crash_base, total_mem;
> > +	unsigned long long crash_base, crash_size, low_size = 0;
> > +	char *cmdline = boot_command_line;
> >  	bool high = false;
> >  	int ret;
> >  
> >  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
> >  		return;
> >  
> > -	total_mem = memblock_phys_mem_size();
> > -
> > -	/* crashkernel=XM */
> > -	ret = parse_crashkernel(boot_command_line, total_mem,
> > -				&crash_size, &crash_base, NULL, NULL);
> > -	if (ret != 0 || crash_size <= 0) {
> > -		/* crashkernel=X,high */
> > -		ret = parse_crashkernel_high(boot_command_line, total_mem,
> > -					     &crash_size, &crash_base);
> > -		if (ret != 0 || crash_size <= 0)
> > -			return;
> > -		high = true;
> > -	}
> > +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
> > +				&crash_size, &crash_base,
> > +				&low_size, &high);
> > +	if (ret)
> > +		return;
> >  
> >  	if (xen_pv_domain()) {
> >  		pr_info("Ignoring crashkernel for a Xen PV domain\n");
> >  		return;
> >  	}
> >  
> > -	/* 0 means: find the address automatically */
> > -	if (!crash_base) {
> > -		/*
> > -		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
> > -		 * crashkernel=x,high reserves memory over 4G, also allocates
> > -		 * 256M extra low memory for DMA buffers and swiotlb.
> > -		 * But the extra memory is not required for all machines.
> > -		 * So try low memory first and fall back to high memory
> > -		 * unless "crashkernel=size[KMG],high" is specified.
> > -		 */
> > -		if (!high)
> > -			crash_base = memblock_phys_alloc_range(crash_size,
> > -						CRASH_ALIGN, CRASH_ALIGN,
> > -						CRASH_ADDR_LOW_MAX);
> > -		if (!crash_base)
> > -			crash_base = memblock_phys_alloc_range(crash_size,
> > -						CRASH_ALIGN, CRASH_ALIGN,
> > -						CRASH_ADDR_HIGH_MAX);
> > -		if (!crash_base) {
> > -			pr_info("crashkernel reservation failed - No suitable area found.\n");
> > -			return;
> > -		}
> > -	} else {
> > -		unsigned long long start;
> > -
> > -		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
> > -						  crash_base + crash_size);
> > -		if (start != crash_base) {
> > -			pr_info("crashkernel reservation failed - memory is in use.\n");
> > -			return;
> > -		}
> > -	}
> > -
> > -	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
> > -		memblock_phys_free(crash_base, crash_size);
> > -		return;
> > -	}
> > -
> > -	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
> > -		(unsigned long)(crash_size >> 20),
> > -		(unsigned long)(crash_base >> 20),
> > -		(unsigned long)(total_mem >> 20));
> > +	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
> > +				    low_size, high);
> >  
> > -	crashk_res.start = crash_base;
> > -	crashk_res.end   = crash_base + crash_size - 1;
> > -	insert_resource(&iomem_resource, &crashk_res);
> > +	return;
> 
> This can be omitted.

Will update, thx.

> 
> >  }
......

