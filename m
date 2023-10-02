Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEB77B4F0C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbjJBJ3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbjJBJ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C9EA7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696238929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJJ/7KPwaOb8i7teRUVDmyTyd/EZIX0vx+LShsb9z+w=;
        b=a+dSmxnG21gSW3Ax1FZg4quhY5IOr7PANjy6SuHaAoJX9bk6TeWyU7wGRR2dlYMmmb6xen
        /aVRcig3zrBcyLGt0g6KwFVmPqWFcDnynEUvCNRj1kLQAX0KvOvKmZZapZEy3eTFjD/9E2
        Xucs6FXIlcdi5uH4SRnuEM+b2XJwHMs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-3muGqdNxP6Gy4hdul09A2A-1; Mon, 02 Oct 2023 05:28:48 -0400
X-MC-Unique: 3muGqdNxP6Gy4hdul09A2A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4065ca278b3so20452275e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 02:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696238927; x=1696843727;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJJ/7KPwaOb8i7teRUVDmyTyd/EZIX0vx+LShsb9z+w=;
        b=Bt+t8Rv6OHYHAlTPL+8jeanWsvnhX0ybnYpHRxMqfL7hQ2IGZVqoY0GeYIltzazczu
         2zBOrbdSrOKcYmTOooa5JeBU/WJeRCAEI3ywPvXxJmD/noRK8glTz97Gcb20+ba5/bMj
         aj019830yJqKxogUeM/rgmH+tWxOgl175jH7y39pcjRSV2G/bWFx87Uu1h9aa1/l0HT3
         LhCqdfw6hrvz2BYC1/T5CuoeBAwexwB/4OgMCKJA+HUgixj+6pUROb1vzyWrddqd7ndv
         +d0xh4hQAvKI5Q6xL9lnJUAoim4/H+Z8OrATslgv/9Uvy2iQwh93iKT75WuwPidJQ4vq
         BVUQ==
X-Gm-Message-State: AOJu0YxZuLuKoyzB0Ao/yuGjc8JF8m/8KkV2qR7z53g3OudJTaJwRNck
        xeZy9niHvMuUVgJSVwckmZkc08lF1lt8jdn0rngKXwTmMP6UaYobKTiHWCG4CnKi6juWxoZiKqS
        A2YNe4ttOPCcjEMTy+jBYQmi9
X-Received: by 2002:a7b:cbc8:0:b0:3ff:ca80:eda3 with SMTP id n8-20020a7bcbc8000000b003ffca80eda3mr8982374wmi.10.1696238927141;
        Mon, 02 Oct 2023 02:28:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmhn8B8uW4T+AICrNUjuxaqcAcDPKrxy0MVMZxpv82pLtYtPKE8QMU+0CJ7y3jMcfBPVswXw==
X-Received: by 2002:a7b:cbc8:0:b0:3ff:ca80:eda3 with SMTP id n8-20020a7bcbc8000000b003ffca80eda3mr8982347wmi.10.1696238926766;
        Mon, 02 Oct 2023 02:28:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446? (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de. [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c489100b003fc16ee2864sm6835636wmp.48.2023.10.02.02.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 02:28:46 -0700 (PDT)
Message-ID: <efe2acfd-f22f-f856-cd2a-32374af2053a@redhat.com>
Date:   Mon, 2 Oct 2023 11:28:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/2] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
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
        Michal Hocko <mhocko@suse.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jeff Moyer <jmoyer@redhat.com>
References: <20230928-vv-kmem_memmap-v4-0-6ff73fec519a@intel.com>
 <20230928-vv-kmem_memmap-v4-1-6ff73fec519a@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230928-vv-kmem_memmap-v4-1-6ff73fec519a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +
> +static int __ref try_remove_memory(u64 start, u64 size)
> +{
> +	int rc, nid = NUMA_NO_NODE;
> +
> +	BUG_ON(check_hotplug_memory_range(start, size));
> +
> +	/*
> +	 * All memory blocks must be offlined before removing memory.  Check
> +	 * whether all memory blocks in question are offline and return error
> +	 * if this is not the case.
> +	 *
> +	 * While at it, determine the nid. Note that if we'd have mixed nodes,
> +	 * we'd only try to offline the last determined one -- which is good
> +	 * enough for the cases we care about.
> +	 */
> +	rc = walk_memory_blocks(start, size, &nid, check_memblock_offlined_cb);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * For memmap_on_memory, the altmaps could have been added on
> +	 * a per-memblock basis. Loop through the entire range if so,
> +	 * and remove each memblock and its altmap.
> +	 */
> +	if (mhp_memmap_on_memory()) {
> +		unsigned long memblock_size = memory_block_size_bytes();
> +		u64 cur_start;
> +
> +		for (cur_start = start; cur_start < start + size;
> +		     cur_start += memblock_size)
> +			__try_remove_memory(nid, cur_start, memblock_size);
> +	} else {
> +		__try_remove_memory(nid, start, size);
> +	}
> +
>   	return 0;
>   }

Why is the firmware, memblock and nid handling not kept in this outer 
function?

We really shouldn't be doing per memory block what needs to be done per 
memblock: remove_memory_block_devices() and arch_remove_memory().


-- 
Cheers,

David / dhildenb

