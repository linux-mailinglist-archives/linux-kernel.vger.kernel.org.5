Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D3C7E69BA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjKILeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKILeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:34:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF5910A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 03:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699529610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b0/quQNOBlAdk14iiPX40Ta6yaF3Yz+E6qmQXuIdetM=;
        b=g8L2ovXJyYTmof6W69vvX06CNHc2dWSd+K4TgyoFT7JnY3HQtRRXHmTau6bPFClZCMCKcY
        EFkRRGaMZ5uinkXL04AxvC7adEq477nUqekeu/629JFGH70R/pXX/IBvRC+q9h2ue8xYvi
        0UJJvTwdubRYSnoJoEwbrvgOjgr72KM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-m0wFpr0qOsO55vv1NyscXg-1; Thu, 09 Nov 2023 06:33:29 -0500
X-MC-Unique: m0wFpr0qOsO55vv1NyscXg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-670237ba89aso12913146d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 03:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699529608; x=1700134408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0/quQNOBlAdk14iiPX40Ta6yaF3Yz+E6qmQXuIdetM=;
        b=FvRKT9aCztRU9toKkKzULUHRtto+e3+lYpLKlJfUv29KJL/OweZcqTi2ULHh3XsXzh
         VKCXGDHWwgNW3xOq8rX7sX5cRAO3el0K8+HITBOLOAfXOfvdBcnpVZJIQgrFUbdGoPdD
         g4vn2C+nTHYVjn3s8jc/aR7q0u1sDL/J5bwJcMb2K4Vj3Ew4nGzBB8RCvKxLmpO3ReOJ
         jUgYiCfNr2kB8/sGjBN0xeSTH5BTXFmeImDg0pMbaiOwRWzyezx/SOYQ2sMfDFmswKK8
         8UhSQsHjPdeCNDW+NHjX74k8l5Q5PFQT5Ljo0ebMZZxf8+rXmEZCrxj0qqxaDTsYkYbZ
         yT/w==
X-Gm-Message-State: AOJu0Ywut9bG3qSmIFO4eXHToHTDT8q1+rgxrlY0k3lQ3ylLpwRR4snc
        UQIiqCq43TzqZtfC2NK/Ok/df99f5s5YraDqGJC83doVbm9P8xNI08mxLhCsf0ZUP2QCf+bQJTh
        s6andMIMaNoHsGHLJlEedFh8=
X-Received: by 2002:ad4:4f26:0:b0:66c:fd38:2266 with SMTP id fc6-20020ad44f26000000b0066cfd382266mr10980585qvb.25.1699529608615;
        Thu, 09 Nov 2023 03:33:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjyn1I+jQkjnsW+kMx1XvjQpiOy2FQXtJYFQHQt3wvgj7QX0Oz2mZdg85jfwAtjAIH9fCnqQ==
X-Received: by 2002:ad4:4f26:0:b0:66c:fd38:2266 with SMTP id fc6-20020ad44f26000000b0066cfd382266mr10980575qvb.25.1699529608394;
        Thu, 09 Nov 2023 03:33:28 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-31-107.cust.vodafonedsl.it. [2.34.31.107])
        by smtp.gmail.com with ESMTPSA id pp25-20020a056214139900b00655e428604esm1979952qvb.137.2023.11.09.03.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 03:33:28 -0800 (PST)
Message-ID: <1fbdf0d8-d8c5-4616-ab49-bda4112771e8@redhat.com>
Date:   Thu, 9 Nov 2023 12:33:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fpga: remove module reference counting from core
 components
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xu Yilun <yilun.xu@linux.intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Alan Tull <atull@opensource.altera.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231027152928.184012-1-marpagan@redhat.com>
 <ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050>
 <ae202b70-b106-4805-9ce0-ffbb2738bb04@redhat.com>
 <ZUuu1CgVd4h3Qqu7@yilunxu-OptiPlex-7050>
 <2023110839-jam-relapsing-7f5d@gregkh>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <2023110839-jam-relapsing-7f5d@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-08 17:20, Greg Kroah-Hartman wrote:
> On Wed, Nov 08, 2023 at 11:52:52PM +0800, Xu Yilun wrote:
>>>>>
>>>>> In fpga_region_get() / fpga_region_put(): call get_device() before
>>>>> acquiring the mutex and put_device() after having released the mutex
>>>>> to avoid races.
> 
> Why do you need another reference count with a lock?  You already have
> that with the calls to get/put_device().
>

My understanding is that the lock is there not for reference counting
but to prevent concurrent reprogramming of the region by in-kernel API
consumers.

>>>> Could you help elaborate more about the race?
>>>>
>>>
>>> I accidentally misused the word race. My concern was that memory might
>>> be released after the last put_device(), causing mutex_unlock() to be
>>> called on a mutex that does not exist anymore. It should not happen
>>> for the moment since the region does not use devres, but I think it
>>> still makes the code more brittle.
>>
>> It makes sense.
>>

Thanks,
Marco

