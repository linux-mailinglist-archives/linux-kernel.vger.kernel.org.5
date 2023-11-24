Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06527F7771
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjKXPQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjKXPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:16:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B001619A6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700839017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qu5XgvxXAyH+ZZ5B41lPzFlUvRTTIlHyTD7FWxrfkec=;
        b=asIsbGXBuASV3PFtTDC+t1pFhgypOweb7cHEP50gzAV8BctEt1HLkKoqq4xmryHEL4v89t
        Gvsd4vGR0L77EIFS43vB5LMVZ/RDUesBSPsfV9kTkGTuPpQZ+XfMPx/AznWGWO3Kjow/gy
        t8vRilnaRaIzjD57l+9fKshtFnIkzeE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-bdXBE9L7PVi9-bT4dAIPXw-1; Fri, 24 Nov 2023 10:16:54 -0500
X-MC-Unique: bdXBE9L7PVi9-bT4dAIPXw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-77891ef5fc9so20299785a.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:16:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700839014; x=1701443814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qu5XgvxXAyH+ZZ5B41lPzFlUvRTTIlHyTD7FWxrfkec=;
        b=HVc/PXLr5ZxsczIr755Isb/tOvY2K4j9lfpV05Lk9rK5KHcn9PaGadyIXxT08rcrCT
         Rntd+V2nwyTireAZFQx3RiuxLx78ZbM60A94nwSxLZO22cUPuS7iBUMvZdRFqoPENdjf
         l6RajTioT/KeA/Zt3z7b97V+aS6Az0I/m0vN4O6hllunwfDI49lTeViuBipHSEOl9tpJ
         zMq/WbXiFKeTYuJbXGJOYxSbn2F+1+4kZVN7HC3eBdD7w/+Tu36ynGvtc5RgLRlWUB3M
         rlXlVK7mZdaKhaa42RMn/x+kSd/Q6ZB9QVtDGj6nifEjdsyaKyNS1HDhsxdlnwEyfa5e
         J1ZQ==
X-Gm-Message-State: AOJu0YwsdORPwy3hWwOCmhL0BYIIRuNPMpM0R41sn9DvrBUO1PIE0an/
        rKF6lyews+QzUhzJAydTGmKxq0/o9wlaIPCRngtM1WIRgnNiIN2jIr9L6r1VR14K3iPkN11uTFn
        Mc+UZUDu6eJcdxkXqwCo+iAF7T+NJKppG
X-Received: by 2002:a05:620a:294b:b0:77d:6a8f:abe with SMTP id n11-20020a05620a294b00b0077d6a8f0abemr3730028qkp.2.1700839014235;
        Fri, 24 Nov 2023 07:16:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiV7RVK5n3/J6Z2BUdBRcsJkNG7QL8NPXj8wfk67EQSwKUHdH0oqC8FQJ6z1t7hbeF9gdeaA==
X-Received: by 2002:a05:620a:294b:b0:77d:6a8f:abe with SMTP id n11-20020a05620a294b00b0077d6a8f0abemr3729999qkp.2.1700839013922;
        Fri, 24 Nov 2023 07:16:53 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b0077d71262d38sm1283844qkg.60.2023.11.24.07.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:16:53 -0800 (PST)
Date:   Fri, 24 Nov 2023 10:16:51 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/Kconfig: Make hugetlbfs a menuconfig
Message-ID: <ZWC-YwFlifVFsUOa@x1n>
References: <20231123223929.1059375-1-peterx@redhat.com>
 <de256121-f613-42d3-b267-9cd9fbfc8946@infradead.org>
 <7830CCC4-B1E4-4CCD-B96B-61744FAF2C79@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7830CCC4-B1E4-4CCD-B96B-61744FAF2C79@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 10:37:06AM +0800, Muchun Song wrote:
> >> +if HUGETLBFS
> >> config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
> >> bool "HugeTLB Vmemmap Optimization (HVO) defaults to on"
> >> default n
> >> @@ -282,6 +275,15 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
> >>  The HugeTLB VmemmapvOptimization (HVO) defaults to off. Say Y here to
> > 
> > Is this small 'v'            ^ a typo?
> 
> Yes. Thanks for pointing it out. Although it is not related to this
> patch, but it will be nice for me to carry this tiny typo fix. Hi,
> Peter, would you like help me do this?

Sure, this patch is indeed more or less moving that around; I can touch
that up.  I'll resend.

Thanks,

-- 
Peter Xu

