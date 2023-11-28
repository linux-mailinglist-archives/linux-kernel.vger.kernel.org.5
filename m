Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696DF7FB09F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjK1DTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1DTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:19:11 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8191B6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:18:52 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cff3a03dfaso3619945ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701141532; x=1701746332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aNAGTjDRK2uz3X+viYd2HPrnhIXsIDutv38NEyAwfLU=;
        b=P0rrhgeyIkmkcSqf59VsFPcoBcJCNhSTVL61uAmJo/ohBl+vkCOzJ2zslmDiOV2tra
         hVzbriShZgyNbgIzQo1uusDH4+cURR1BTkNSCfI7FK7kYx3+eNBhGNR2Zn2GEPPI1Jzd
         wYDg0TcstXU4sME9I8zoPczQAfsA65/LbrPBmxYtXWTvR2L0jqCtBmchwFlv+gRYrjeT
         RuLggYwEe7RQWye5gOgp/PtLZ1ecAyYOYKd/4ZCu6r2Qs4txlkxbqgFjOnO3IU96z7bi
         2Zip/PMlrU+05jJO3EyutitBggVJK3Z9RDFy356ItWmh5xLUUjClM+CvYerdZm4mAerw
         8l0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701141532; x=1701746332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aNAGTjDRK2uz3X+viYd2HPrnhIXsIDutv38NEyAwfLU=;
        b=lTIcCrBJd/IT0txCr6W+NUh7csLBsvTV+G2nXOwmnQkvSmWqLIM1I40tSqyQIHhSpG
         j450EM16LaYfA+ikIRfG9pllyiSPzPc7EnmXJ1CFpiBR0CZKj/Vl1zXJm4L1AzYFzLeU
         Gae7TwFZBtsc9qjxpUfeXFlbDUzhJGD5308TE31EI8CCrvR37pbRrINLSdqFgazYBQbx
         zMj5D5srPb2XzduCuLEyCffkhQXNEANN/R3NBgv4P6G12oaxeoBot/w74+IaT6HfESuU
         daJOWBKvQFI5gKmrSkUIgJD9gt4MtepC3m66XPHBdfGbl97Dtg4q+D0nWxR/3lOJDofM
         50pA==
X-Gm-Message-State: AOJu0Yw6ZUPMT6ZW9+sMG0014NsZnIv9bFnhMh797h24cJ1W/iXCCl4i
        wZS2irdKNe2FjuPgmGJ+WZtXQw==
X-Google-Smtp-Source: AGHT+IEU2v6RHw7nOwM2iEsqET1AbJ+q4/VVGdLzlV2v8RO/RggvDpt1YEjOrqGTGgVyw8E5nkDCXg==
X-Received: by 2002:a17:903:2308:b0:1ce:6312:5373 with SMTP id d8-20020a170903230800b001ce63125373mr14356179plh.0.1701141532190;
        Mon, 27 Nov 2023 19:18:52 -0800 (PST)
Received: from [10.4.104.221] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f54400b001cfca674329sm3140094plf.90.2023.11.27.19.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 19:18:51 -0800 (PST)
Message-ID: <db1b593a-41d9-444a-b3f4-f6bffe98634b@bytedance.com>
Date:   Tue, 28 Nov 2023 11:18:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] hugetlb: parallelize hugetlb page allocation
 on boot
Content-Language: en-US
To:     David Rientjes <rientjes@google.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Gang Li <gang.li@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231123133036.68540-1-gang.li@linux.dev>
 <5c0e27f2-5826-4537-a1ab-1debfab65b9a@redhat.com>
 <28e28c2a-e72d-a181-e87a-39cecc8c3c76@google.com>
 <9d5de524-28ee-4d71-9493-f77967ea213c@redhat.com>
 <783f8bac-55b8-5b95-eb6a-11a583675000@google.com>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <783f8bac-55b8-5b95-eb6a-11a583675000@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/25 04:00, David Rientjes wrote:
> On Fri, 24 Nov 2023, David Hildenbrand wrote:
> 
>> And there, the 65.2s won't be noise because that 12TB system is up by a snap
>> of a finger? :)
>>
> 
> In this single boot test, total boot time was 373.78s, so 1GB hugetlb
> allocation is 17.4% of that.

Thank you for sharing these data. Currently, I don't have access to a 
machine of such large capacity, so the benefits in my tests are not as 
pronounced.

I believe testing on a system of this scale would yield significant 
benefits.

> 
> Would love to see what the numbers would look like if 1GB pages were
> supported.
> 

Support for 1GB hugetlb is not yet perfect, so it wasn't included in v1. 
But I'm happy to refine and introduce 1GB hugetlb support in future 
versions.

