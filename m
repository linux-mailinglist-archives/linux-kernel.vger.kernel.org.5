Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF47761DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjGYPzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjGYPzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:55:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1012102
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690300465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LoAQxhzmL5AVllS8wiqRHiXap/Dk/xuzfK4mG1WLfl0=;
        b=CyBB4CkSdzPYVmMXQ593rfkBBfebsL2AfgoHbkgqLmhXC3cTgQMXE1q8AWTO42nX7QIh5b
        DIjC8agMCSh+a4vUOUtkLaCSUZrcu60113dBWa6/NQqog0dSJdYzi8qzlS3vdI79LvQE7U
        rEuAZ2tiNkOEy3vnrgsJFwWgvYGK8aI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-ZiZVa5t6MGGpDTY7KXVKpw-1; Tue, 25 Jul 2023 11:54:21 -0400
X-MC-Unique: ZiZVa5t6MGGpDTY7KXVKpw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fe0d910b02so22746e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690300460; x=1690905260;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LoAQxhzmL5AVllS8wiqRHiXap/Dk/xuzfK4mG1WLfl0=;
        b=CiHcUdS6bmY+qAvbrlVazcBafEPw401FI0B8FV7Cyy6lrgZRwat8yoWLn0rsx8auom
         NVTf0rdltsA12+4NRqJhglz5bgxb6VAMFyrwdj+FDE4rKJ3/gcPR8wocSQzLl35SJaGE
         YSriIC6IwIEIuldMTJfauOJ5yp5ayaVjv8yQp5umga/OQjmNHd05pnSZSbDOgkZkDiDq
         ms8wktAfXswG94nB7Om4JPUNxilrnJTJ5uAIWj9l1iKJ1ThnARYsyY8K6i3+HWFhRuwb
         HqQQ9fhjYbGKdtN1R15QI6rosVDSf9LvCKYUYVGbEoENOoOsOr7B6Sq+jOioME1wnwlk
         3fDQ==
X-Gm-Message-State: ABy/qLbWgAVcgRz7zKKJ5IUMzlh6PoJPQXX0E3bNU+L8zBSxKosJGdSA
        1wkWhLRSxVLLdaYduISUmzuvdb77U03YWpgEFhKtUVNNZy/635Ubf4LoW2Tzeyp9W7WRxNV5hOt
        2Yk1o4BrSi6uo4kFiR/qyf1a5
X-Received: by 2002:a05:6512:39ca:b0:4fb:8b78:4a93 with SMTP id k10-20020a05651239ca00b004fb8b784a93mr8787198lfu.7.1690300459904;
        Tue, 25 Jul 2023 08:54:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEmywcP+QkHkkim2d5HtgePDiVNCjDAFUns2tMfnkaP9vtk0/KS0KMhtX1iT9iXaInLa2ug6Q==
X-Received: by 2002:a05:6512:39ca:b0:4fb:8b78:4a93 with SMTP id k10-20020a05651239ca00b004fb8b784a93mr8787187lfu.7.1690300459532;
        Tue, 25 Jul 2023 08:54:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:e900:3b0d:87a6:2953:20d1? (p200300cbc73fe9003b0d87a6295320d1.dip0.t-ipconnect.de. [2003:cb:c73f:e900:3b0d:87a6:2953:20d1])
        by smtp.gmail.com with ESMTPSA id x17-20020adfffd1000000b003141f3843e6sm16751602wrs.90.2023.07.25.08.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 08:54:19 -0700 (PDT)
Message-ID: <1c3f737e-f5c6-b974-3b36-c4a3ada14422@redhat.com>
Date:   Tue, 25 Jul 2023 17:54:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/3] mm: use memmap_on_memory semantics for dax/kmem
Content-Language: en-US
To:     Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jeff Moyer <jmoyer@redhat.com>
References: <20230720-vv-kmem_memmap-v2-0-88bdaab34993@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230720-vv-kmem_memmap-v2-0-88bdaab34993@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.23 09:14, Vishal Verma wrote:
> The dax/kmem driver can potentially hot-add large amounts of memory
> originating from CXL memory expanders, or NVDIMMs, or other 'device
> memories'. There is a chance there isn't enough regular system memory
> available to fit the memmap for this new memory. It's therefore
> desirable, if all other conditions are met, for the kmem managed memory
> to place its memmap on the newly added memory itself.
> 
> The main hurdle for accomplishing this for kmem is that memmap_on_memory
> can only be done if the memory being added is equal to the size of one
> memblock. To overcome this,allow the hotplug code to split an add_memory()
> request into memblock-sized chunks, and try_remove_memory() to also
> expect and handle such a scenario.
> 
> Patch 1 exports mhp_supports_memmap_on_memory() so it can be used by the
> kmem driver.
> 
> Patch 2 teaches the memory_hotplug code to allow for splitting
> add_memory() and remove_memory() requests over memblock sized chunks.
> 
> Patch 3 adds a sysfs control for the kmem driver that would
> allow an opt-out of using memmap_on_memory for the memory being added.
> 

It might be reasonable to rebase this on Aneesh's work. For example, 
patch #1 might not be required anymore.

-- 
Cheers,

David / dhildenb

