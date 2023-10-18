Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9538B7CE5CF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjJRSDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjJRSDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:03:07 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89BC98;
        Wed, 18 Oct 2023 11:03:06 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-27b22de9b5bso4597519a91.3;
        Wed, 18 Oct 2023 11:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697652186; x=1698256986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HM0rdYmNjfIOEfu2GiH+cN0EGGUs8C6I7JSOM/2oAzs=;
        b=ftLI5xoR/4Km0bZGfXI+kD1uIqJY5esEkBTMmvImQ8DK8VmgAxbPp2GNI8I0YZIkE2
         Wigv52LYqtK5cElG+1X+eivuTxVG6QVT2AvGmFzGly7VJbeHI1O4GS55w2p8ypMUX4zW
         szp6vwOb2xKAcMj/CrsXC9AAqHV/CklLz5BwOW9wHIpNECQuz6+JfEJW8lEd42pa2PNz
         1dTLNWdrAC3ouGjJ3e5Scq6X/2osT1E1p2b4ULHTDjOImttIriGZRGwxz4+Hhopf5Ysk
         tqXqoMQGFRssl3+1SlGwpyw9G1OugpsKKUfX/LNZ5frhKvuyndtVLUjW7rxGoxV2T10H
         rIFg==
X-Gm-Message-State: AOJu0YwKHqFoN+/swmGEyUhMNQ/zIVD8e4hbnjkZ6Hsv9wHzltFMrA8l
        q+A3ixKHxAo/w8L7ns/A/lYcjcAXMrg=
X-Google-Smtp-Source: AGHT+IE1L22qeDW1pW90kpqZO8+O+GUUSVHR7nWH20GrEG5ZV3dOa79SZ/7ZbZJmVGMjVp5Twql0fg==
X-Received: by 2002:a17:90a:d90c:b0:27d:4b71:ed17 with SMTP id c12-20020a17090ad90c00b0027d4b71ed17mr5609066pjv.29.1697652185891;
        Wed, 18 Oct 2023 11:03:05 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:66c1:dd00:1e1e:add3? ([2620:15c:211:201:66c1:dd00:1e1e:add3])
        by smtp.gmail.com with ESMTPSA id 24-20020a17090a191800b00279479e9105sm240995pjg.2.2023.10.18.11.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 11:03:05 -0700 (PDT)
Message-ID: <333764e8-fd11-4ed3-b3b4-eeaa14c5cbeb@acm.org>
Date:   Wed, 18 Oct 2023 11:03:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] SCSI: Fix issues between removing device and error
 handle
Content-Language: en-US
To:     Wenchao Hao <haowenchao22@gmail.com>
Cc:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231016020314.1269636-1-haowenchao2@huawei.com>
 <CAOptpSMSpuU_NDKNPKRk1ZS76KhOfCmSeB7YxbD6jvNpvNGZPg@mail.gmail.com>
 <0091a3e7-d3cf-4572-af46-79adbde42ab8@acm.org>
 <8877db4d-50e2-d814-484b-c2ec501f752b@huawei.com>
 <3e7cd38f-681b-446d-9c16-a694a8d03497@acm.org>
 <CAOptpSMnGyc5cjkxuHvLCsv_DaS8e9maCkCyp=vGne6KDX43eg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAOptpSMnGyc5cjkxuHvLCsv_DaS8e9maCkCyp=vGne6KDX43eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/23 07:40, Wenchao Hao wrote:
> On Wed, Oct 18, 2023 at 9:51 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> On 10/17/23 18:37, Wenchao Hao wrote:
>>> The previous version was posted on 2023/9/28 but not reviewed, so I
>>> ping soon after repost.
>>
>> Since a repost counts as a ping, I think posting a ping soon after
>> reposting is considered aggressive.
> 
> I didn't mean that, then how long is appropriate to post a ping?

It depends on how busy the reviewers are. I wait at least one week
before sending out a ping or reposting a patch series.

Bart.

