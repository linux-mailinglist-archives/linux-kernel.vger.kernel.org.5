Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AADD785FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbjHWSbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238152AbjHWSbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:31:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294E3E57
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692815461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FjjmWq6lbTk8T56RTtAzjKdLtvwQOo42U/71Bxnl1y8=;
        b=iHVtErC2265bFCmpycmbqQIox4Ggi6PDwK0LeGFgDcpG4Ixosv9kEhiV7SiDB2YziyOTqE
        kRy8gPexjINObzX01z2QkjR7aJZX647bNs6uWRfS+cjw8Gt/n0z3HpTssLS+HFR+MB7MBj
        xXLU4stRfPKgdRg9rWN3ZFFD71WTtDE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-aSYqvI3KPjqwuue1tMNZ5w-1; Wed, 23 Aug 2023 14:30:59 -0400
X-MC-Unique: aSYqvI3KPjqwuue1tMNZ5w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-313c930ee0eso3830016f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 11:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692815458; x=1693420258;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FjjmWq6lbTk8T56RTtAzjKdLtvwQOo42U/71Bxnl1y8=;
        b=QZoVS4Ok1+exn6Isfs0NCJ1bhEd4yPRlcLjYnak9yt5oy7UvJ62ez4jy2uEIQ3PA+W
         FpO6HbzMGuFEvdX8muHjqTOQjz1V0Cb4bJC4A7LVFhiGbpFRSf2SX9jPDFw8jkkzKo+A
         mChq9h003uECzgKwYn56K57e5Qc6mgqhJoQ3zzbUu60zbAmorjjwIikVBkHqkXcyAtt9
         /mecQFXPiBSu4bXAL2U8Kjpl/H6UAdS70xdFeDy3splir8Fpnx7JCaJZyIbYZ4BgRSg/
         doY5YNfs6X2XZ2bwl+0s0vn8QqNcnTcuVwOpjHL12nNbFCQOfc80nSzBGKe4IiIctW0i
         Eh0w==
X-Gm-Message-State: AOJu0Yw2QxMPa76RSDjPOkCAq3seUZCL2kIjFGjvuza2y32gZIWbHrZQ
        YBfO91SlPjg7HrjdV1whhoAnolSZtBTjgnCksSCjSDgNjQBxcwUy3VwUj2Zfzlc3a4y7LgstxQ1
        nKtZ4s89v7dBiMh/g50N9lXpm
X-Received: by 2002:a5d:65c5:0:b0:319:7c07:87bf with SMTP id e5-20020a5d65c5000000b003197c0787bfmr11036931wrw.53.1692815458568;
        Wed, 23 Aug 2023 11:30:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5YW6PeWXoqpo8UC3oIa2PjRhpO8TnckdHFiM8LOksY4s1cdCdwuN/zuCB4f7LNLNiYPkqMA==
X-Received: by 2002:a5d:65c5:0:b0:319:7c07:87bf with SMTP id e5-20020a5d65c5000000b003197c0787bfmr11036915wrw.53.1692815458145;
        Wed, 23 Aug 2023 11:30:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:e700:4d5c:81e2:253e:e397? (p200300cbc70ce7004d5c81e2253ee397.dip0.t-ipconnect.de. [2003:cb:c70c:e700:4d5c:81e2:253e:e397])
        by smtp.gmail.com with ESMTPSA id s5-20020adff805000000b003143cb109d5sm19903381wrp.14.2023.08.23.11.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 11:30:57 -0700 (PDT)
Message-ID: <1f6b4edb-b906-e1ba-7c1f-c854472ad304@redhat.com>
Date:   Wed, 23 Aug 2023 20:30:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] proc/ksm: add ksm stats to /proc/pid/smaps
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230823170107.1457915-1-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230823170107.1457915-1-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.08.23 19:01, Stefan Roesch wrote:
> With madvise and prctl KSM can be enabled for different VMA's. Once it
> is enabled we can query how effective KSM is overall. However we cannot
> easily query if an individual VMA benefits from KSM.
> 
> This commit adds a KSM section to the /prod/<pid>/smaps file. It reports
> how many of the pages are KSM pages. Note that KSM-placed zeropages are
> not included, only actual KSM pages.
> 
> Here is a typical output:
> 
> 7f420a000000-7f421a000000 rw-p 00000000 00:00 0
> Size:             262144 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:               51212 kB
> Pss:                8276 kB
> Shared_Clean:        172 kB
> Shared_Dirty:      42996 kB
> Private_Clean:       196 kB
> Private_Dirty:      7848 kB
> Referenced:        15388 kB
> Anonymous:         51212 kB
> KSM:               41376 kB
> LazyFree:              0 kB
> AnonHugePages:         0 kB
> ShmemPmdMapped:        0 kB
> FilePmdMapped:         0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:             202016 kB
> SwapPss:            3882 kB
> Locked:                0 kB
> THPeligible:    0
> ProtectionKey:         0
> ksm_state:          0
> ksm_skip_base:      0
> ksm_skip_count:     0
> VmFlags: rd wr mr mw me nr mg anon
> 
> This information also helps with the following workflow:
> - First enable KSM for all the VMA's of a process with prctl.
> - Then analyze with the above smaps report which VMA's benefit the most
> - Change the application (if possible) to add the corresponding madvise
> calls for the VMA's that benefit the most
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

