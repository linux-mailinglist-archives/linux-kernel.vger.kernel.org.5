Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5F47E9F28
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjKMOuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjKMOuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:50:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C408D68
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699886968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=22Qf9usLRQOMKK360B0q7WL0ZZErghGcurNBlgR4tt0=;
        b=XHNFE4b9XxN2oLLq7NInXo0j2tba+hK9Rulxu9mRgo9B8szJI8LOyMZNg7tZs0448Q1Y73
        pBYC71CP8LxJtJuAMM/k/Bl6lVLBjPY0SNkpfj/OFBKpDMp0NHCFyMuLmhaLBmC8gXpsRp
        f4/Rky6G//87lD074v7Fy+L97WCA8Es=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-1L18IV5dNLS6vBTjmXR9AA-1; Mon, 13 Nov 2023 09:49:27 -0500
X-MC-Unique: 1L18IV5dNLS6vBTjmXR9AA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-407f9d07b41so28921425e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699886966; x=1700491766;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22Qf9usLRQOMKK360B0q7WL0ZZErghGcurNBlgR4tt0=;
        b=b5gGYAxwvUHa1d0Ta9Du57aU1mcIJ9OlwFL+PMN3rsGu9flO4Z99k/U+73AXqH75LP
         yITPcb+sqkENtYujsc7xckOdzy2zJnRwGbjfTtsvmlXRX5UrjELD+l2OwF/WIFkFr1ew
         4la/W2P1fP1FPgnYJLRO2LbgBBE3gBpjAwaZhY5z6tp7D9SJeXR8I8OjBgw3xEOP4Ew3
         c8H9FUMT86hvPoxm0lhUIqxFmIoPg9xST15HNikGHN8O2FFcpAHj5sBqbO2UkqQSPOsn
         nLiAxyVFp+iEZ/pOWHrnUI6XmVUT8xthcGNh3WOKOfqi9awAZ2DPx0yvym3B8B7EqIPe
         rS1g==
X-Gm-Message-State: AOJu0YyzgyfOB8mmK5toOQx1vlF9w4xW8Z8cyaLsL2qP/1TYqVaD+KuH
        KgGYMhITRYHnknVYHEnh8N+kFCyChsU7rXr4Yl8EZmMNoLbHY+C5uOMc6/RP1zZZDps+A37sNcL
        6lUo9DeMAIRTN8RlGkZ2URjl0
X-Received: by 2002:a05:600c:1ca7:b0:3fe:f667:4e4c with SMTP id k39-20020a05600c1ca700b003fef6674e4cmr5752920wms.12.1699886965899;
        Mon, 13 Nov 2023 06:49:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmj4sjtJsO/bqgbLPNSK+AjKTVENv9BkfMp3f718WA46TOBWD8D5zlvGr2KlOP30ntgGzILg==
X-Received: by 2002:a05:600c:1ca7:b0:3fe:f667:4e4c with SMTP id k39-20020a05600c1ca700b003fef6674e4cmr5752903wms.12.1699886965450;
        Mon, 13 Nov 2023 06:49:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c738:900:e9d2:2326:c69d:a7e2? (p200300cbc7380900e9d22326c69da7e2.dip0.t-ipconnect.de. [2003:cb:c738:900:e9d2:2326:c69d:a7e2])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b004060f0a0fd5sm8300350wmo.13.2023.11.13.06.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 06:49:25 -0800 (PST)
Message-ID: <bce69d21-14cc-4e0b-93a2-425f40ca91ad@redhat.com>
Date:   Mon, 13 Nov 2023 15:49:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: support large folio numa balancing
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     ying.huang@intel.com, wangkefeng.wang@huawei.com,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
References: <a71a478ce404e93683023dbb7248dd95f11554f4.1699872019.git.baolin.wang@linux.alibaba.com>
 <606d2d7a-d937-4ffe-a6f2-dfe3ae5a0c91@redhat.com>
 <517f2a75-638d-4f17-a5c1-719e15507c6a@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <517f2a75-638d-4f17-a5c1-719e15507c6a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.11.23 13:59, Baolin Wang wrote:
> 
> 
> On 11/13/2023 6:53 PM, David Hildenbrand wrote:
>> On 13.11.23 11:45, Baolin Wang wrote:
>>> Currently, the file pages already support large folio, and supporting for
>>> anonymous pages is also under discussion[1]. Moreover, the numa balancing
>>> code are converted to use a folio by previous thread[2], and the
>>> migrate_pages
>>> function also already supports the large folio migration.
>>>
>>> So now I did not see any reason to continue restricting NUMA balancing
>>> for
>>> large folio.
>>
>> I recall John wanted to look into that. CCing him.
>>
>> I'll note that the "head page mapcount" heuristic to detect sharers will
>> now strike on the PTE path and make us believe that a large folios is
>> exclusive, although it isn't.
>>
>> As spelled out in the commit you are referencing:
>>
>> commit 6695cf68b15c215d33b8add64c33e01e3cbe236c
>> Author: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Date:   Thu Sep 21 15:44:14 2023 +0800
>>
>>       mm: memory: use a folio in do_numa_page()
>>       Numa balancing only try to migrate non-compound page in
>> do_numa_page(),
>>       use a folio in it to save several compound_head calls, note we use
>>       folio_estimated_sharers(), it is enough to check the folio sharers
>> since
>>       only normal page is handled, if large folio numa balancing is
>> supported, a
>>       precise folio sharers check would be used, no functional change
>> intended.
> 
> Thanks for pointing out the part I missed.
> 
> I saw the migrate_pages() syscall is also using
> folio_estimated_sharers() to check if the folio is shared, and I wonder
> it will bring about any significant issues?

It's now used all over the place, in some places for making manual 
decisions (e.g., MADV_PAGEOUT works although it shouldn't) and more and 
more automatic places (e.g., the system ends up migrating a folio 
although it shouldn't). The nasty thing about it is that it doesn't give 
you "certainly exclusive" vs. "maybe shared" but "maybe exclusive" vs. 
"certainly shared".

IIUC, the side effect could be that we migrate folios because we assume 
they are exclusive even though they are actually shared. Right now, it's 
sufficient to not have the first page of the folio mapped anymore for 
that to happen.

Anyhow, it's worth mentioning that in the commit message as long as we 
have no better solution for that. For many cases it might be just tolerable.

> 
>> I'll send WIP patches for one approach that can improve the situation
>> soonish.
> 
> Great. Look forward to seeing this:)

I'm still trying to evaluate the performance hit of the additional 
tracking ... turns out there is no such thing as free food ;)

-- 
Cheers,

David / dhildenb

