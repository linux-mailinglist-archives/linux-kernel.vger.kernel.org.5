Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E160776A125
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjGaTXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGaTXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:23:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165111BC5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690831351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3XHpXZQfPdcBCB40xD4cQo5HE4yndD5B/+tRyE4teEw=;
        b=VQAdpjcAeN6YItaZAm5NoKnli4N0JB5kcuBz2IoiPSgZMfTyRC5UGRMsfMbwWOTCAf6cyM
        8KRWfa3VpYcar5nlCIwpXKhLQ9AT8VBnqqxWeHuOfhoqkszqdiGAbD/6EtlAGMYnRjycLM
        34NJ0iFZkGis9Gx7uWbOEf8lLCYQ4sM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-1GyVyPnDMXylJRZAX9HgyQ-1; Mon, 31 Jul 2023 15:22:29 -0400
X-MC-Unique: 1GyVyPnDMXylJRZAX9HgyQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe25f8c4bfso3230625e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690831348; x=1691436148;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XHpXZQfPdcBCB40xD4cQo5HE4yndD5B/+tRyE4teEw=;
        b=ZoAmmtLkt68H+KD6Ozg0+vAdPCqQ4iaHkwC50W4Ga0wUIQXAmX2sWZnFmDJ6LjWpeP
         xqnAPYn2Zvk/7IdYvJzMiEyoZcinCSnTKCjmBtP3iK9bDVGlqaTRcQ9I402FWLCV+sTd
         zAPhfJ0hG78Zqy0j9Y7+Zgk2urMcZv3fClnNdAWcLq6AfKa7Tu1pXvBbVjVXvmxgAvCs
         ytXG5cM+oV9U72aJgPB3c5xAfWo/ZX9y+slz+wh3E3t4LHshubxigP0C138GAqvFp//B
         VgWIadCzVpz8Pcnbvd2wLqh9Wz+Ls/J+fXAe8oN3QeV8HlvDnxzpLLKvoUZ/rx5q0kkr
         OwNg==
X-Gm-Message-State: ABy/qLYgLy1WIz2CoPNG9e4GmINpcXaFOcLn3Wq37k36AauChTi1nQHY
        9Xo8zbikwgCyiin9/b4AH4HtASS2LnupGT/8um8q/yvHB8uYn7cSWMhe9A12xAYQG9s278+luHz
        nbbiWl5GSGw2fByZnmm5J5lun
X-Received: by 2002:a5d:5389:0:b0:313:ea59:7ded with SMTP id d9-20020a5d5389000000b00313ea597dedmr527975wrv.24.1690831348687;
        Mon, 31 Jul 2023 12:22:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE3VWK9O6PVe8wtmdproWt76/+jiswldybLURzUXx9vkkftywxOeU5n+v/yJOUJccBkcxNCsQ==
X-Received: by 2002:a5d:5389:0:b0:313:ea59:7ded with SMTP id d9-20020a5d5389000000b00313ea597dedmr527965wrv.24.1690831348285;
        Mon, 31 Jul 2023 12:22:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c723:4c00:5c85:5575:c321:cea3? (p200300cbc7234c005c855575c321cea3.dip0.t-ipconnect.de. [2003:cb:c723:4c00:5c85:5575:c321:cea3])
        by smtp.gmail.com with ESMTPSA id i15-20020adffdcf000000b003145559a691sm13875824wrs.41.2023.07.31.12.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 12:22:27 -0700 (PDT)
Message-ID: <9a26ce23-9ac7-b111-b700-db0905203c73@redhat.com>
Date:   Mon, 31 Jul 2023 21:22:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <412bb30f-0417-802c-3fc4-a4e9d5891c5d@redhat.com>
 <66e26ad5-982e-fe2a-e4cd-de0e552da0ca@redhat.com> <ZMfc9+/44kViqjeN@x1n>
 <a3349cdb-f76f-eb87-4629-9ccba9f435a1@redhat.com>
 <CAHk-=wiREarX5MQx9AppxPzV6jXCCQRs5KVKgHoGYwATRL6nPg@mail.gmail.com>
 <a453d403-fc96-e4a0-71ee-c61d527e70da@redhat.com>
 <CAHk-=whxpKc_zOiJ9n-MA9s0wxvU9vRST+iuNYGkHHB6ux48Rg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
In-Reply-To: <CAHk-=whxpKc_zOiJ9n-MA9s0wxvU9vRST+iuNYGkHHB6ux48Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.07.23 21:07, Linus Torvalds wrote:
> On Mon, 31 Jul 2023 at 12:00, David Hildenbrand <david@redhat.com> wrote:
>>
>> So in the "!writable" case, we would always call
>> get_user_pages_unlocked() and never honor NUMA faults.
> 
> Ok, so kvm doesn't just use the fast version. Oh well. It was an idea..

Certainly an interesting one, thanks for thinking about possible 
alternatives! Unfortunately, KVM is an advanced GUP user to managed 
secondary MMUs.

I'll get the FOLL_HONOR_NUMA_FAULT patches ready tomorrow and we can 
discuss if that looks better.

(btw, the whole reasoning about "HW would refuse to use these pages" was 
exactly the whole reason I went into the FOLL_FORCE direction ... but 
it's really better to make FOLL_FORCE deal with VMA protection only)

-- 
Cheers,

David / dhildenb

