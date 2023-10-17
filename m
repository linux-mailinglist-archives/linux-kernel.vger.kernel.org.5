Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB557CCF6F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344139AbjJQVl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQVl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:41:56 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2AEA4;
        Tue, 17 Oct 2023 14:41:54 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-27747002244so4938817a91.2;
        Tue, 17 Oct 2023 14:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697578914; x=1698183714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsLD2vmJC/Ua0B2Lh2iXrWVriqxyLaqFrGL437zLTSQ=;
        b=MD1pZ4pkzHbQyFSpoFeNz8nyuZ8nKBfsmBssg4FtNEm5UYl4jktvKCN11BxVkr3eYm
         d7ul/+J8jwxvFDedfGh2IF8zkFUjXIPSRpj5Wt2A6QiKCwgxbUGwExfvx6dcgenNOAiG
         JNV5bsjsyMmRRAjHQAtzBTbLHhFeXehx/AbtW591nx2/ODS/PmeT6/793tKzo7TJf/EW
         6o6e5uD3pcA2TC6qWBjdLw27CRofUPICHwh2QlCw6mQA0fS/CLu+3Vngg2izYJHVaLRP
         jin6NPiso2VsQ4dw+Ux0TQYfJ9S4Ibuiwft7xfhbK53Lfxs/XOIh9Q5BqPCPL71dOizB
         QBag==
X-Gm-Message-State: AOJu0Yzo3ZLFdjw6O96jWGtNStvQ/0sdUeT575yYmssQcyWdLF48rsJm
        b+uympfLhDxOpK5cuUwdFi8=
X-Google-Smtp-Source: AGHT+IFrhbbAu5Wp4iGcXqfqLIlptAynh6VlpW/6avdpfbrXDL3JuMb5xJEltXHK+mwDX0yKuQQq9w==
X-Received: by 2002:a17:90a:2c86:b0:27d:b244:cd28 with SMTP id n6-20020a17090a2c8600b0027db244cd28mr3248852pjd.42.1697578914127;
        Tue, 17 Oct 2023 14:41:54 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8f02:2919:9600:ac09? ([2620:15c:211:201:8f02:2919:9600:ac09])
        by smtp.gmail.com with ESMTPSA id 4-20020a17090a198400b0026cecddfc58sm4066pji.42.2023.10.17.14.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 14:41:53 -0700 (PDT)
Message-ID: <0091a3e7-d3cf-4572-af46-79adbde42ab8@acm.org>
Date:   Tue, 17 Oct 2023 14:41:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] SCSI: Fix issues between removing device and error
 handle
Content-Language: en-US
To:     Wenchao Hao <haowenchao22@gmail.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        louhongxiang@huawei.com
References: <20231016020314.1269636-1-haowenchao2@huawei.com>
 <CAOptpSMSpuU_NDKNPKRk1ZS76KhOfCmSeB7YxbD6jvNpvNGZPg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAOptpSMSpuU_NDKNPKRk1ZS76KhOfCmSeB7YxbD6jvNpvNGZPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/17/23 10:00, Wenchao Hao wrote:
> On Mon, Oct 16, 2023 at 10:04 AM Wenchao Hao <haowenchao2@huawei.com> wrote:
>>
>> I am testing SCSI error handle with my previous scsi_debug error
>> injection patches, and found some issues when removing device and
>> error handler happened together.
>>
>> These issues are triggered because devices in removing would be skipped
>> when calling shost_for_each_device().
> 
> Friendly ping...

The patch series was posted on October 15, 7 PM PDT and the ping has
been posted on October 17, 10 AM PDT. That's less than two days after
the patch series was posted. Isn't that way too soon to post a "ping"?

Thanks,

Bart.

