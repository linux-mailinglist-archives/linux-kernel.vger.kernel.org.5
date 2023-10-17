Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474247CC6FB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbjJQPF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbjJQPFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE989012
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697554430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=mP22VLb0e9SuOsBqS8UjAH5mgIOM+0SAlqtNbVFzoR8=;
        b=ez1/uG0t8NHS/6Nu4sZMcNFns/vzy4f5WSDoxBpZWw03Mv8P+8+FMLYj+9bomXCHWTw4TW
        8IJhq4J9Rzsl7xmMNWeU+ZRDwH1SL0s2Vup/Nvr/DGiDhQ4lNfCPtaPRSZHZ6mn+vPl/2P
        S5Nq5+ytEB0Q3qg1DxWyyo0GwU9tx7U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-tEAO0d58OR6E5ZHohH58ZQ-1; Tue, 17 Oct 2023 10:53:49 -0400
X-MC-Unique: tEAO0d58OR6E5ZHohH58ZQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso39821615e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697554428; x=1698159228;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mP22VLb0e9SuOsBqS8UjAH5mgIOM+0SAlqtNbVFzoR8=;
        b=svuxXGvJZ9UK+E0029jl/9X2ZnHAW6UzqC7TX9iTMe7Q0h5pco+fX1NV3YZ9Tp3+w8
         sGPsc6pzNqaIBs31m5HtbB8F+qQ67gQJQgMsXd5jOasjXz9793NcBGBL3b3LFDglvcIK
         zqFXN2QGna+S0lSWh0Z0pTvyRFZUamWEwPkWWa97xCkjb62di5rQV5ELQxkdTjNmzGCW
         N6cXqa5WpqWYaUaHOFuXr6L43xii5o866/7l0X/o0vQA+YlnEYKSS26W7cb1txH3qgKv
         Am0gY5+4iZKDbgCbvXRokFkrROFm7UUaykG+DZ29P4DIcLp8mxCED631mLmZvo6L06ZJ
         i9KQ==
X-Gm-Message-State: AOJu0YzOz6y040eyJg8pJWN0AM7BViz/9GXHZjx2cPAoCp8zJxrGjrf9
        fl2XVcPXf+CX3Pj7RzY6QKffWMMoDQNHfOKrTxFfC6yYsuN4UZBcHoJLAhETu3WoU1Z2M9k6aHL
        QQaL/2YTSTs+0afAdSF0UonKP
X-Received: by 2002:adf:f303:0:b0:321:6833:b930 with SMTP id i3-20020adff303000000b003216833b930mr2337829wro.16.1697554427982;
        Tue, 17 Oct 2023 07:53:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtIz1FpJ/vPFP7dbaB9hR2MWTGpKsWoEhdzUticduh8bTsT68l1db5jzKwFTo5OwD4+2/iVg==
X-Received: by 2002:adf:f303:0:b0:321:6833:b930 with SMTP id i3-20020adff303000000b003216833b930mr2337810wro.16.1697554427522;
        Tue, 17 Oct 2023 07:53:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:5100:93b1:f654:ad11:cd81? (p200300cbc743510093b1f654ad11cd81.dip0.t-ipconnect.de. [2003:cb:c743:5100:93b1:f654:ad11:cd81])
        by smtp.gmail.com with ESMTPSA id b5-20020a5d4d85000000b00324853fc8adsm1843327wru.104.2023.10.17.07.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 07:53:47 -0700 (PDT)
Message-ID: <17a890e2-a87b-446e-9088-bd608504378b@redhat.com>
Date:   Tue, 17 Oct 2023 16:53:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/sparsemem: fix race in accessing memory_section->usage
Content-Language: en-US
To:     Charan Teja Kalla <quic_charante@quicinc.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com, vbabka@suse.cz,
        mgorman@techsingularity.net, aneesh.kumar@linux.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com>
 <e1102c1b-1773-4e59-8a70-00a7deff2bde@quicinc.com>
 <b4a2bbe8-4181-68ad-1a6c-463fbe64d8f8@quicinc.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b4a2bbe8-4181-68ad-1a6c-463fbe64d8f8@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.23 16:10, Charan Teja Kalla wrote:
> Thanks Pavan!!
> 
> On 10/16/2023 4:03 PM, Pavan Kondeti wrote:
>>> Fix this issue by the below steps:
>>> a) Clear SECTION_HAS_MEM_MAP before freeing the ->usage.
>>> b) RCU protected read side critical section will either return NULL when
>>> SECTION_HAS_MEM_MAP is cleared or can successfully access ->usage.
>>> c) Synchronize the rcu on the write side and free the ->usage. No
>>> attempt will be made to access ->usage after this as the
>>> SECTION_HAS_MEM_MAP is cleared thus valid_section() return false.
>>>
>>> Since the section_deactivate() is a rare operation and will come in the
>>> hot remove path, impact of synchronize_rcu() should be negligble.
>> struct mem_section_usage has other field like pageblock_flags. Do we
>> need to protect its readers with RCU? Also can we annotate usage field
>> in struct mem_section with __rcu and use RCU accessors like
>> rcu_dereference() while using memsection::usage field?
> 
> Good question about the pageblock_flags!! I think we rely on the
> get_pageblock_bitmap() to read the ms->usage->pageblock_flags by passing
> struct page*.
> 
> 1) All the functions that I have come across calling
> get_pageblock_bitmap()/get_pfnblock_flags_mask() passing the page* which
> it get from buddy. I think we are safe here as the device pages(from
> which the problem is coming will never be onlined/added to buddy)
> 
> 2) There are functions in compaction which directly operate on the pfn's
> through pfn_to_online_page(). As for device pages, it is going to return
> NULL, I think we are safe here too.
> 
> 3) alloc_contig_range() which also operate on the pfn's directly, and
> TMK, we will not pass the [start , end) values of this function to
> contains the hole/offlined pages. I think we are safe here too.
> 
> May be David/other reviewers can help in commenting if there are some
> mistakes above.

Sound reasonable to me; most PFN walkers shouldn't deal with pageblock 
flags. alloc_contig_range() is certainly interesting, I suspect it's 
fine but we better double-check.

-- 
Cheers,

David / dhildenb

