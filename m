Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2577FA643
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjK0QWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjK0QWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:22:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91021BC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701102139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=9x4yEF+SMk5bxbv+mMp97aSs0GOdQASEORhGUUMfvqQ=;
        b=gpc7cja8/L/EAz/iBlUV0+g/lqOxC+VI2pBI612IpRNNxlAT+6MwV4zXzMncianWu+6obg
        Z/flZAyN310S82gzDy9iaDZ3XyF5H5G0Z7shrJ9FihbI9CVIpCzTOuKkpo9bJZRSbtSt2H
        ZJs0ndknqHYdBIjnDNaZHUCjjNjT8ts=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-_Ik2EdpsMg6rWW1IKtG4mw-1; Mon, 27 Nov 2023 11:22:18 -0500
X-MC-Unique: _Ik2EdpsMg6rWW1IKtG4mw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c53ea92642so40162411fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701102136; x=1701706936;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9x4yEF+SMk5bxbv+mMp97aSs0GOdQASEORhGUUMfvqQ=;
        b=v1tUkLecK96a9UJePi3xe3rbAjsK9+5t3OaFCIJ/rummsre/VjuSsJdKqARXlE6YiK
         cHWM1xDQFIbGhQLCWIiYuV+9Smbtq4BrE4UkcXFfqk47IuunskaPaF3priRZvKdjWEpA
         LsfAjL8FQYMYKA9J/NEh34DgSIP9CGIn7d+joOxHEUfS3TFfKVCRabJFmDgepMkUpb17
         nKTjIc2OXgjYvWIG8KpOsQnxCUTzjNLzE0sBnFAa7lAV2YXBVegcAuGFIJadEkiJm2kn
         7Uz9/I0PKrasXlhCbhPEN6N/vXZys992auB5RMUKGonE+5S0B9LWGxZqoSX8rk6HEIx5
         3MiQ==
X-Gm-Message-State: AOJu0YytWr2HHCC98X28iEumga+jJ2lcfeVw+E9iDViBGe8H2VGwDLTz
        69vat9QI4l0aPaS2KAajID8TS0DtsA/Ioi3U+YKx8xaik86YzR309dHWTgLoQc/995VZWQNb88C
        2zIATIzU5tU12bZc/O07V9iip
X-Received: by 2002:a2e:3c1a:0:b0:2c0:2ab7:9ab1 with SMTP id j26-20020a2e3c1a000000b002c02ab79ab1mr7775540lja.35.1701102136580;
        Mon, 27 Nov 2023 08:22:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbho917u+8ouFnHlkw/5IcyJ0OX8vzWDII0l8SWP9GShaFaH60YLu96uIxzj5vMniW6Hk/Ug==
X-Received: by 2002:a2e:3c1a:0:b0:2c0:2ab7:9ab1 with SMTP id j26-20020a2e3c1a000000b002c02ab79ab1mr7775519lja.35.1701102136180;
        Mon, 27 Nov 2023 08:22:16 -0800 (PST)
Received: from ?IPV6:2003:cb:c745:2a00:d74a:a8c5:20b6:3ec3? (p200300cbc7452a00d74aa8c520b63ec3.dip0.t-ipconnect.de. [2003:cb:c745:2a00:d74a:a8c5:20b6:3ec3])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b004076f522058sm15112542wms.0.2023.11.27.08.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 08:22:15 -0800 (PST)
Message-ID: <90c1b3c7-cdf7-40fa-ae06-5565c1d760ee@redhat.com>
Date:   Mon, 27 Nov 2023 17:22:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: Fix follow_devmap_p[mu]d() on page==NULL handling
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>
References: <20231123180222.1048297-1-peterx@redhat.com>
 <20231124112059.3519d6fdfe71f846f8bf726f@linux-foundation.org>
 <ZWO-x_ElKe6qtsIq@x1n>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZWO-x_ElKe6qtsIq@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.11.23 22:55, Peter Xu wrote:
> On Fri, Nov 24, 2023 at 11:20:59AM -0800, Andrew Morton wrote:
>> On Thu, 23 Nov 2023 13:02:22 -0500 Peter Xu <peterx@redhat.com> wrote:
>>
>>> This is a bug found not by any report but only by code observations.
>>>
>>> When GUP sees a devpmd/devpud and if page==NULL is returned, it means a
>>> fault is probably required.  Here falling through when page==NULL can cause
>>> unexpected behavior.
>>>
>>
>> Well this is worrisome.  We aren't able to construct a test case to
>> demonstrate this bug?  Why is that?  Is it perhaps just dead code?
> 
> IIUC it's not dead code. Take the example of follow_devmap_pmd(), it can
> return page==NULL at least when seeing write bit missing:
> 
> 	if (flags & FOLL_WRITE && !pmd_write(*pmd))
> 		return NULL;
> 
> AFAICT it can happen if someone does "echo 4 > /proc/$PID/clear_refs" when
> the mm contains the devmap pmd.  Same to pud.
> 
> It'll be nice if someone that works with dax would like to verify it.  In
> my series (refactor hugetlb gup, part 2) IIUC some hugetlb selftest can
> start to trigger this path, but I'll need to check.  So far it's dax-only.

It certainly looks weird to continue there. Triggering it by mmaping 
some devdax device might be possible (e.g., using devdax emulation).

We know the PMD is present and the PMD is devmap. We take the pmd lock, 
and in follow_devmap_pmd() we recheck both.

I suspect the original idea was: if it's suddenly no longer present or 
no longer devmap, it was replaced by a PTE table. So we know a deeper 
level is there and can simply continue instead of triggering a fault.

But that does not seem to be the case, because I suspect the PMD could 
have been zapped (MADV_DONTNEED?) in the meantime, and the "writability" 
check is similarly weird.

So I assume the patch from Peter is ok: even if the PMD got replaced by 
a PTE table, we'd trigger a fault and simply retry.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

