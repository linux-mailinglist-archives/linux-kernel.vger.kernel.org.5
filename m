Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50E17676B7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjG1UBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjG1UBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6083C1D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690574459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRmfJ1mT/OZN1AggXltoKPDhI99E2rErINEqrU1NhAY=;
        b=gzp8NZZGew3QvUm+G07X/0GTWf1ctu50XRd9R4kW6SMo9uvb/iB9c06KmL+W7QMrGKRwFY
        8lxqKPjnxkG9sqvcG6req6udCRgiyf3YuvkfelXPI4mV23byz7fH+L+CZN9vNQXrAgVOwY
        Oa8Kw6nSGdnFZuy67yjbV18h9v0ovvk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-Fj9Rnf4WMoi_AyPvB1RpCQ-1; Fri, 28 Jul 2023 16:00:56 -0400
X-MC-Unique: Fj9Rnf4WMoi_AyPvB1RpCQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30e6153f0eeso1284713f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690574455; x=1691179255;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRmfJ1mT/OZN1AggXltoKPDhI99E2rErINEqrU1NhAY=;
        b=Cu0VJupxEe8hBYMOPsp0vd1UdHbdlZpBCAdqEi2nhUaOo8s8rj98KddXwsu92HKqFR
         1JG5Mmk+Uc2eLus/tSt9MSjnkVLmtuwO26/xBBuQKVWb9ev2DEzYrBCVU0d318eL3bzC
         r3oWfWcyzx7pJ/llPndH1AoPg4V8m5K+1OpU0PgA65jTzrPlY1DucqC4uN1YOIV4KoIV
         gguAQgrFSx9WLiHr5GRTsW9uQx/P7cFuIsc9vgc+vqCsAAob30VUwnHjVY7sukZ60MbH
         w88D8fMEReq89rqz/2Hr/uBtltTSi/W3wsWb4Lv5lvnwhKDLE7OCzxj4TBRkIivjnQp3
         S7EA==
X-Gm-Message-State: ABy/qLZJ4sm/rhbsw1gMtW/8a9yjV22Bs3m8OTiyCe1jDOl1yzdfs4Cp
        P6OxeJB3wmP2pXGUNC+7t/UacTUFFp8LTIm3vnl8G7YomowoE7gKZQp2nJ4pvizwDsQWGDgoPlK
        LwX/MDEM9lq3o3n3o9J0iCF3F
X-Received: by 2002:a5d:608a:0:b0:314:415:cbf5 with SMTP id w10-20020a5d608a000000b003140415cbf5mr2570948wrt.51.1690574455581;
        Fri, 28 Jul 2023 13:00:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFwSoz0c1U4P2+Nfnhm5RhWG01osLg58XyUDz6FlXhPnV8aFFJ4dJvd5jhMSfz4ev9+IzTvfQ==
X-Received: by 2002:a5d:608a:0:b0:314:415:cbf5 with SMTP id w10-20020a5d608a000000b003140415cbf5mr2570943wrt.51.1690574455226;
        Fri, 28 Jul 2023 13:00:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:6b00:bf49:f14b:380d:f871? (p200300cbc7066b00bf49f14b380df871.dip0.t-ipconnect.de. [2003:cb:c706:6b00:bf49:f14b:380d:f871])
        by smtp.gmail.com with ESMTPSA id i8-20020adfefc8000000b0030ada01ca78sm5634933wrp.10.2023.07.28.13.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 13:00:54 -0700 (PDT)
Message-ID: <cd4823fb-b00d-1029-cbd8-c23789c28858@redhat.com>
Date:   Fri, 28 Jul 2023 22:00:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <eaa67cf6-4896-bb62-0899-ebdae8744c7a@redhat.com>
 <b647fd9a-3d75-625c-9f2c-dd3c251528c4@redhat.com> <ZMQcBWvjVUEBU6mF@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZMQcBWvjVUEBU6mF@x1n>
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

On 28.07.23 21:50, Peter Xu wrote:
> On Fri, Jul 28, 2023 at 09:40:54PM +0200, David Hildenbrand wrote:
>> Hmm. So three alternatives I see:
>>
>> 1) Use FOLL_FORCE in follow_page() to unconditionally disable protnone
>>     checks. Alternatively, have an internal FOLL_NO_PROTNONE flag if we
>>     don't like that.
>>
>> 2) Revert the commit and reintroduce unconditional FOLL_NUMA without
>>     FOLL_FORCE.
>>
>> 3) Have a FOLL_NUMA that callers like KVM can pass.
> 
> I'm afraid 3) means changing numa balancing to opt-in, probably no-go for
> any non-kvm gup users as that could start to break there, even if making
> smaps/follow_page happy again.
> 
> I keep worrying 1) on FOLL_FORCE abuse.
> 
> So I keep my vote on 2).

Linus had a point that we can nowadays always set FOLL_NUMA, even with 
FOLL_FORCE.

... so maybe we want to let GUP always set FOLL_NUMA (even with 
FOLL_FORCE) and follow_page() never set FOLL_NUMA.

That would at least decouple FOLL_NUMA from FOLL_FORCE.

-- 
Cheers,

David / dhildenb

