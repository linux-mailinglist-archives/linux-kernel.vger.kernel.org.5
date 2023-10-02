Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E04B7B4EF5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbjJBJW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbjJBJW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5781491
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696238525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9SMs8mHNoKs8/KwUwp2IfY8WHFPaduo12w1Xi37QfxA=;
        b=HGiS6E5iuLPB1GKS4EDvchfgAyZGW0afQn6Rb7eemz/dMs8tZkSMbolrpNltoMLwvY95re
        CeAFQYzHnS6yl/Jubocc9Ox7AJLTXOYxMSr9Cp9SHIAE/MsuCYqQ0OQMbwj64d/y+Fuzcw
        29Gerlu7NdFBjgOFTiUJHIOtitTM4vg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-Hpeebgn1NFaNn4EkxUy9jQ-1; Mon, 02 Oct 2023 05:21:49 -0400
X-MC-Unique: Hpeebgn1NFaNn4EkxUy9jQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fef3606d8cso150975515e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 02:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696238508; x=1696843308;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9SMs8mHNoKs8/KwUwp2IfY8WHFPaduo12w1Xi37QfxA=;
        b=OigkHe45sIGj2KlugLAg8yDYHlKnJCeD9S2NOVxkjdYxai47ffPWO5maryKTGUOnH6
         of5tjkwhDB/CVaANp6Qpkr3JT0zgSuZEgosODJkehWLAgNjbnH1nP4CILYvcTTf0uMTK
         YihTDzczZRxKwAZwqQ0R0C4qEaBIc4qwmpK42S1z/kA0h6BDWLdMxGijh+3fnQ9RWEFh
         0dcuheDfDeMryd9fP26e5Htay0ffywr37unJBpscJswnuhkSZWKihChf4BwLn9H3Dcz8
         KBueRkOA4Xm+nNC94fbtGeD5QA3RXNFttIn3Pve7sv1b+se0/bjUrK6xfCECrNSCiVME
         VKAw==
X-Gm-Message-State: AOJu0YzuMXWs9s1M8VStWzhl2yeoJ+P8eKBXpsSdinXCfjLcmaMwNbiF
        KuTbpacbW6M9XX72zEV484uhbEGBzxnevfI1faPfIEYV2N3PHK98Sl9EXBbJ8cxBV8gPvvOCHy0
        SFpK8rqOuhJ5Q/AAIrP7UlF/x
X-Received: by 2002:a1c:f215:0:b0:401:8225:14ee with SMTP id s21-20020a1cf215000000b00401822514eemr9384947wmc.41.1696238508091;
        Mon, 02 Oct 2023 02:21:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpoIYDU+1jiVcXrF63R4snLKaA9DHdUaPschGkCCIHkpc4jwwbfh1yuXRNn7DbT9sCTvXBqw==
X-Received: by 2002:a1c:f215:0:b0:401:8225:14ee with SMTP id s21-20020a1cf215000000b00401822514eemr9384934wmc.41.1696238507655;
        Mon, 02 Oct 2023 02:21:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446? (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de. [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcc88000000b003fbe4cecc3bsm6791845wma.16.2023.10.02.02.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 02:21:47 -0700 (PDT)
Message-ID: <0b6f739b-723a-bc53-03a3-f4a793f339b4@redhat.com>
Date:   Mon, 2 Oct 2023 11:21:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 2/2] dax/kmem: allow kmem to add memory with
 memmap_on_memory
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
 <20230928-vv-kmem_memmap-v4-2-6ff73fec519a@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230928-vv-kmem_memmap-v4-2-6ff73fec519a@intel.com>
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

On 28.09.23 22:30, Vishal Verma wrote:
> Large amounts of memory managed by the kmem driver may come in via CXL,
> and it is often desirable to have the memmap for this memory on the new
> memory itself.
> 
> Enroll kmem-managed memory for memmap_on_memory semantics if the dax
> region originates via CXL. For non-CXL dax regions, retain the existing
> default behavior of hot adding without memmap_on_memory semantics.
> 
> Add a sysfs override under the dax device to control this behavior and
> override either default.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

