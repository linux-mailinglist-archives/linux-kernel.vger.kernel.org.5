Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A122757C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjGRMq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjGRMqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:46:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E2A126
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689684370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O8Z3XFdBF3kOpVojfXsWRPlqXS1ROcLcj5XDYHHoy5w=;
        b=I2qSYdtb9X2tK83/3jDnsNuwf1Za0xc9bWbhK+R8asX5nh7jxms1+rnPTM7Yrfu5Ybh8O2
        oA92yBmHPbSDaQajlQTmBQdtSfq0MJMzi2s4ZEJXerLn1YYfgHb2+QXHdgJymFuZhymeqc
        f/EMKko25LvwKXK5ZeZqaQeHovnVfHY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-aTh_obDrPgKdzY1EKCOdcg-1; Tue, 18 Jul 2023 08:46:09 -0400
X-MC-Unique: aTh_obDrPgKdzY1EKCOdcg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-314394a798dso2395675f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689684368; x=1692276368;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8Z3XFdBF3kOpVojfXsWRPlqXS1ROcLcj5XDYHHoy5w=;
        b=Vz/6CWCXIRLukBz4qDCAhH262KE/wmjV8dhsdRVr5ujhQMlTdj1lxWNQ5vUuJ/W8xB
         2RjKvw/OQGpAHd0swIb3026SHL7Ip5uzvzrA6Gmxw4N9aP6LbYbktzmTdEXUGO36aMnS
         kj320eh3M3elk68hG3lmLdT4yHgZBvsJMZz8uMX1dWMHrNAX+ibOAjt5CX3ktqoh28sT
         e4hfQeKiZGk1qA50yeruuxCAaLZYEtwEj9BZ6nMNvBhF8MQ4ZDJlo1m7M50LjAUgmYUQ
         pTlH8B/Ucqs3cT11ld6EQsWliWFaIc1CMlqXCTFGmz/kRyDKoEud43Sr3v33lJevIEKr
         3xrg==
X-Gm-Message-State: ABy/qLZUpSE2kv7A9hG5NYmFoOn1Nh9xrlKp5fh12kJW9aN3VJ/vx+bM
        iWf8T/pQP91TndYZwvLZHGlDMEQMPMvS4pISieeKg8EjLt34+IYOyO2jG8YAxpDmDV/O4oBS6ej
        FP8LD7AjDZtamxCQIBdcuyi4jDhFhOiL/
X-Received: by 2002:a5d:6a51:0:b0:313:f38d:555f with SMTP id t17-20020a5d6a51000000b00313f38d555fmr10114286wrw.24.1689684368622;
        Tue, 18 Jul 2023 05:46:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGbzpijlGdLxaBrXvQyg1PjmdxMOhjmGEfTKC9UepXGAoGbg46L1T/EkPVM1/Ss5e9vEVKjfg==
X-Received: by 2002:a5d:6a51:0:b0:313:f38d:555f with SMTP id t17-20020a5d6a51000000b00313f38d555fmr10114271wrw.24.1689684368314;
        Tue, 18 Jul 2023 05:46:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c740:6200:84e1:eabc:8e2:7429? (p200300cbc740620084e1eabc08e27429.dip0.t-ipconnect.de. [2003:cb:c740:6200:84e1:eabc:8e2:7429])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d56c3000000b0030ae3a6be4asm2365316wrw.72.2023.07.18.05.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 05:46:07 -0700 (PDT)
Message-ID: <412ad509-0312-726a-9c1c-6d6e6df8e98f@redhat.com>
Date:   Tue, 18 Jul 2023 14:46:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/rmap: correct stale comment of rmap_walk_anon and
 rmap_walk_file
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230718092136.1935789-1-shikemeng@huaweicloud.com>
 <76de1682-353b-b8e9-0f09-539988f8ffe0@redhat.com>
 <ZLaI/jfVLVZfr5pc@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZLaI/jfVLVZfr5pc@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.23 14:43, Matthew Wilcox wrote:
> On Tue, Jul 18, 2023 at 12:10:27PM +0200, David Hildenbrand wrote:
>> On 18.07.23 11:21, Kemeng Shi wrote:
>>> 1. update page to folio in comment
>>> 2. add comment of new added @locked
>>>
>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>> ---
>>
>>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> I didn't get the original email, and it's also not in the lore
> archives:
> 
> https://lore.kernel.org/linux-mm/76de1682-353b-b8e9-0f09-539988f8ffe0@redhat.com/T/#u
> 
> Can someone send it along?
> 

Not sure what went wrong there:

https://lore.kernel.org/all/20230718092136.1935789-1-shikemeng@huaweicloud.com/T/#u

-- 
Cheers,

David / dhildenb

