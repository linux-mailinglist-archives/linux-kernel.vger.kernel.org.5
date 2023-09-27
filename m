Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CE17B0128
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjI0J62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjI0J60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F4B1A5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695808658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q/ZTPYNPtH4SrQY4cVAUZ68m0I2/9+u1DlsmjX24JFE=;
        b=Kv+rO9aTmZ0kMfkFTXnhbSJumu2fEjBYuObJzrWJBFdMr7aspGm557TRAkEExBAooJ7Td6
        Rqt2ZSj6L9o4zjRyxqeyE5G1eNy7FuZJ2g3ii/5hj8jiEioDmWw9/zupbfS8/tBOfoVY2Y
        /swpGxyQpOghkWEX8kh7LiehyG//Wms=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-gF7Fsc1ZPo-5y7O2_0NWXA-1; Wed, 27 Sep 2023 05:57:36 -0400
X-MC-Unique: gF7Fsc1ZPo-5y7O2_0NWXA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3233a13b47eso2326291f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695808656; x=1696413456;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/ZTPYNPtH4SrQY4cVAUZ68m0I2/9+u1DlsmjX24JFE=;
        b=o9fM0epoYUpyYhZtPQlgvqxX8EjQMqh9hUSWHBiUwigUH7HtjBcrLtzJxSEFFjEiIt
         IKGTIE9cWn11R2c/lEqOkSjavaeRKxv5yn+nCMt6PW53GEbbmaN3XIzhxFNcHu79KkCq
         NQmRmsiiuL21hgq4LIKPo1aFiuvJH1dTJTVSiMT9jTn9z03FToKZdkx25I/06z93GEbx
         hjRIzv3knU3WQfDXIYizUXN+beeO0Wk028Ot6strc0rKlp/CEnqENGFuFuQg1YnYiEp0
         THG4FAXDA8hauVbNGyn+PELpeDcvsx656TG+4TmAZ9dRTi5ofetsO+dRCwrdVOFJO5If
         xnEg==
X-Gm-Message-State: AOJu0YzasI5LO5B2B109Un/2tjkKLbQriE0Cs0ypWtU8F+eZdAU46t18
        UmHQqVioP1ggoYTx3C0tC97qWZyFGBRk8teqaAOgbwGB+PAdOBMnqH6MWUG9UEMN2YoCYKPN4pT
        nfUu2Bt46Z8Einl4njws1Emub
X-Received: by 2002:adf:fc0a:0:b0:31c:7001:3873 with SMTP id i10-20020adffc0a000000b0031c70013873mr1222264wrr.60.1695808655807;
        Wed, 27 Sep 2023 02:57:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiEiCGjZgVFCBi5nd5OAcMtl7WucZUl1jiAmCKPQ4qCeM7T9w14Pb8rIF5sMSX8FMD8yn4WQ==
X-Received: by 2002:adf:fc0a:0:b0:31c:7001:3873 with SMTP id i10-20020adffc0a000000b0031c70013873mr1222248wrr.60.1695808655379;
        Wed, 27 Sep 2023 02:57:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:6900:3a06:bd5:2f7b:e6eb? (p200300cbc74969003a060bd52f7be6eb.dip0.t-ipconnect.de. [2003:cb:c749:6900:3a06:bd5:2f7b:e6eb])
        by smtp.gmail.com with ESMTPSA id m4-20020adff384000000b00321673de0d7sm1385747wro.25.2023.09.27.02.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 02:57:34 -0700 (PDT)
Message-ID: <c00f0fd8-fb46-8008-95c5-5454474d4fff@redhat.com>
Date:   Wed, 27 Sep 2023 11:57:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/4] mm/ksm: add "smart" page scanning mode
To:     Stefan Roesch <shr@devkernel.io>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, hannes@cmpxchg.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230926040939.516161-1-shr@devkernel.io>
 <20230926040939.516161-2-shr@devkernel.io>
 <ae2be79c-a030-a4d2-0d89-15efa17fe77c@redhat.com>
 <qvqwmsx83o68.fsf@devbig1114.prn1.facebook.com>
 <20230926140955.8b2627711116339af80731f2@linux-foundation.org>
 <qvqw5y3w30w4.fsf@devbig1114.prn1.facebook.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <qvqw5y3w30w4.fsf@devbig1114.prn1.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.09.23 02:39, Stefan Roesch wrote:
> 
> Andrew Morton <akpm@linux-foundation.org> writes:
> 
>> On Tue, 26 Sep 2023 09:13:31 -0700 Stefan Roesch <shr@devkernel.io> wrote:
>>
>>>> Thinking about it, what are the cons of just enabling this always and not
>>>> exposing new toggles? Alternatively, we could make this a compile-time option.
>>>>
>>>> In general, LGTM, just curious if we really have to make this configurable.
>>>>
>>>
>>> The only downside I can see is that it might take a longer time for some
>>> pages to be de-duplicated (a new candidate page is added, but its
>>> duplicate is skipped in this round). So it will take longer to
>>> de-duplicate this page.
>>>
>>> I tested with more than one workload, but it might be useful to get some
>>> data with additional workloads. I was thinking of enabling it after one or
>>> two releases.
>>
>> We could keep the tunable and make it default "on"?
> 
> Sounds good to me
> 

+1

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

