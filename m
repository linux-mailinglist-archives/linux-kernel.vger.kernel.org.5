Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD12777391
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjHJJAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjHJJAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA56211E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691657993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4mg2JCBqsL99mMNAl8TPlreyaVZP4GA221Xi/aiCfPU=;
        b=aWKe5FpzSAqbSC72XnxcUvaFWYzPLnhAb9DFFNxXpa+QsrHKd6jlg+fB12kyTXMsUCKKF5
        S5YqannsXN1Z26FJXAI6522N3gV3Lht8dQJL4+Og1hYR2Nuj1h5ovNSjajJF56lU+OY0wR
        U/t7V7VmTiIfKYlDCGdtBx9bda3/AeE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-5rSgaPC_OLyW5Kpbsua9DQ-1; Thu, 10 Aug 2023 04:59:50 -0400
X-MC-Unique: 5rSgaPC_OLyW5Kpbsua9DQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe2fc65f1fso4155895e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691657989; x=1692262789;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mg2JCBqsL99mMNAl8TPlreyaVZP4GA221Xi/aiCfPU=;
        b=QnC7KSfJDhv0IqLB2ASff2FWrp3fCAxm/ZX8Nq/S2DJufVI+ZF3OM2eGab8U0tkZz5
         kkoSt01FX5ICXnJqxZMsSViOSLkcKpM+seaBBC+bmC+SieOHsbVuBsc23ph0aMGBA9iT
         HSbF2hzNQOqUaHSkzZWu19TiK224NSS5uHmFUSO6oTsyHn+eGIiDeRfXCWkHr0TsTOzz
         eFe4EL3D4DblfL1qrBkMmlVfaSMMxT+oON/5DOvwYPNuS8wIf/oxl/4UPjJEFQ6+26jK
         0wHpECNhonU9cgXvyHytyNAjifs5wpT7on5gk1+SXiKWzFVg5s5DTr2ODHcr/Yr0Br+T
         Ol9w==
X-Gm-Message-State: AOJu0Yyr61A17DPKLR5M7Qm4weTyIhSOnUVsDXN70kBTXN/tEdlNVqAi
        u8vy+R2Z8SpfZemmCIHQncrakTcivcdjyyM+7MgM/Cecl5ogADdNI0hzGZmZTVnUglJO6psQCn3
        N1ZI7Z3bKc2im1dFGa9Igp56M
X-Received: by 2002:a05:600c:152:b0:3fb:b5c0:a079 with SMTP id w18-20020a05600c015200b003fbb5c0a079mr1394152wmm.21.1691657989397;
        Thu, 10 Aug 2023 01:59:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQtBdu8t2biwmqY3nfOHl7eknPBJXAl+kUsgy5C/reo859h3nbXb6oqXr8VhyfvcvCmtHJKA==
X-Received: by 2002:a05:600c:152:b0:3fb:b5c0:a079 with SMTP id w18-20020a05600c015200b003fbb5c0a079mr1394126wmm.21.1691657988980;
        Thu, 10 Aug 2023 01:59:48 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600c290900b003fe539b83f2sm4349427wmd.42.2023.08.10.01.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 01:59:48 -0700 (PDT)
Message-ID: <e5e29217-11d3-a84b-9e29-44acc72222f3@redhat.com>
Date:   Thu, 10 Aug 2023 10:59:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
References: <20230809083256.699513-1-david@redhat.com> <ZNQD4pxo8svpGmvX@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
In-Reply-To: <ZNQD4pxo8svpGmvX@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.23 23:23, Peter Xu wrote:
> Hi, David,
> 
> Some pure questions below..

Hi Peter,

thanks for having a look!

[...]

>> With sub-PMD THP becoming more important and things looking promising
>> that we will soon get support for such anon THP, we want to avoid looping
>> over all pages of a folio just to calculate the total mapcount. Further,
>> we may soon want to use the total mapcount in other context more
>> frequently, so prepare for reading it efficiently and atomically.
> 
> Any (perhaps existing) discussion on reduced loops vs added atomic
> field/ops?

So far it's not been raised as a concern, so no existing discussion.

For order-0 pages the behavior is unchanged.

For PMD-mapped THP and hugetlb it's most certainly noise compared to the 
other activities when (un)mapping these large pages.

For PTE-mapped THP, it might be a bit bigger noise, although I doubt it 
is really significant (judging from my experience on managing 
PageAnonExclusive using set_bit/test_bit/clear_bit when (un)mapping anon 
pages).

As folio_add_file_rmap_range() indicates, for PTE-mapped THPs we should 
be batching where possible (and Ryan is working on some more rmap 
batching). There, managing the subpage mapcount dominates all other 
overhead significantly.

> 
> I had a feeling that there's some discussion behind the proposal of this
> patch, if that's the case it'll be great to attach the link in the commit
> log.

There were (mostly offline) discussions on how to sort out some other 
issues that PTE-mapped THP are facing, and how to eventually get rid of 
the subpage mapcounts (once consumer being _nr_pages_mapped as spelled 
out in the patch description). Having a proper total mapcount available 
was discussed as one building block.

I don't think I have anything of value to link that would make sense for 
the patch as is, as this patch is mostly independent from all that.

-- 
Cheers,

David / dhildenb

