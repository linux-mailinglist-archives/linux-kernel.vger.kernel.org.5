Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FFE7880F2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242940AbjHYHgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243203AbjHYHfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E48E1BFA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692948897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3hr5ed3v5MB4RdD55ipl/lNQ6Huad0rgnV+APlqR6H0=;
        b=Jk4bdF3qy0EiF1R98JPy1zCRbaSTm7db50HDYuHp2WGXjKuz17UlpjuUcD52srcgGFD0Kh
        JWAUiEuVx80GrMgBsrBqwgrF/X7b1TROk8+gd1As/Y8mO/S7UJkpNaI96LTCjbxEHg24Hu
        B97tUhBUq27lUqBa/SW94ysqDxdLsZc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-y5tqX1z8PjqviJpdxgHGew-1; Fri, 25 Aug 2023 03:34:55 -0400
X-MC-Unique: y5tqX1z8PjqviJpdxgHGew-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31c7727aa5cso475925f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692948894; x=1693553694;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hr5ed3v5MB4RdD55ipl/lNQ6Huad0rgnV+APlqR6H0=;
        b=fFuB3yp7Crm7GNOqDSSVfv+hwyDTQ2ZOoPFLJI7AWyNLf2ypOfjI2IOHUlbChWfzc4
         7tr0tnoSUO5L3ML3CZiXGBBR6E79StqgUPK1OWwp1JH0knmGJyr38ND193J6RK52NEa/
         39QvzPLKOsffXYHLhq7aoXkDBdSgL9xxumvaTcTbolxHzy5KB4KKBu2aCpuQbw8jPjxa
         Fmvgm2Y91F1Rng3dWQ28g9M94KRDDRdneD5VjqlXlfqBWHMvkUm7DP/jNnpX6cmTI4Q4
         0sRjekebbXWsBVdY2CmlJJV2PekvkelhqU+yD/AT3oLUlMASBX9yZIkXUr3U8vnxwoku
         r/WQ==
X-Gm-Message-State: AOJu0YwvyZ0RAPSuwvWBc9dgMCjISiA+VxC/QhA4NEQwqWNT+S/wIu3F
        oPkZo6jpA90fbtiSvwweN6sMjUiqFQ/sQ75PoMNoGAFx0wxGT0bLRnReZ81EWZLqujzdtFBLzy/
        xuc7wr6ZeprvYqw+K4lcvb4UaseZYgrV7
X-Received: by 2002:adf:ea81:0:b0:319:67da:ed68 with SMTP id s1-20020adfea81000000b0031967daed68mr14045899wrm.7.1692948894570;
        Fri, 25 Aug 2023 00:34:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIpQ1nfAQupYXXZPrppUT3I3qztcxsAxsv4Mnn3weDxbLdcqRhZ7C+qXgrHcgLJ88bzX97ww==
X-Received: by 2002:adf:ea81:0:b0:319:67da:ed68 with SMTP id s1-20020adfea81000000b0031967daed68mr14045887wrm.7.1692948894209;
        Fri, 25 Aug 2023 00:34:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:9200:ce93:b5e6:8aa9:65d4? (p200300cbc70e9200ce93b5e68aa965d4.dip0.t-ipconnect.de. [2003:cb:c70e:9200:ce93:b5e6:8aa9:65d4])
        by smtp.gmail.com with ESMTPSA id w4-20020adfde84000000b003143b14848dsm1369585wrl.102.2023.08.25.00.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 00:34:53 -0700 (PDT)
Message-ID: <9d4d0643-6a7e-22bf-1f54-19646bb7231e@redhat.com>
Date:   Fri, 25 Aug 2023 09:34:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm/vmscan: Use folio_migratetype() instead of
 get_pageblock_migratetype()
Content-Language: en-US
To:     Vern Hao <haoxing990@gmail.com>, akpm@linux-foundation.org
Cc:     zhaoyang.huang@unisoc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vern Hao <vernhao@tencent.com>
References: <20230825040848.1542-1-user@VERNHAO-MC1>
 <aa5d199b-ea12-90f3-91fb-468d74a6f934@redhat.com>
 <ca7199a4-5628-425f-8f0b-8e8123b431b8@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ca7199a4-5628-425f-8f0b-8e8123b431b8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.23 09:31, Vern Hao wrote:
> 
> 在 2023/8/25 15:12, David Hildenbrand 写道:
>> On 25.08.23 06:08, Vern Hao wrote:
>>> From: Vern Hao <vernhao@tencent.com>
>>>
>>> In skip_cma(), we can use folio_migratetype() to replace
>>> get_pageblock_migratetype().
>>>
>>> Fixes: 5da226dbfce3 ("mm: skip CMA pages when they are not available")
>>
>> Why did you think "Fixes" was a good idea?
>>
> The skip_cma() contains the folio argument, and the folio_migratetype()
> is already implemented in the kernel, so I think it's fine to keep it
> consistent.

If this doesn't actually *fix a bug*, then please don't add fixes and 
confuse people looking for actual bugfixes.

See Documentation/process/submitting-patches.rst

-- 
Cheers,

David / dhildenb

