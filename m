Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F4F788101
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbjHYHip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242918AbjHYHiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:38:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA141FDD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692949048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pnj66daazMp7cNcIjFO+EqMnKflgV7c8qtO7Inq7NlY=;
        b=aWeMZqQtZCb2gVDxYcKRx35AtybMySniy9GbPo0rJxX9/INjkLNvFmb+fGb51aZlxaLO0Z
        rMdTrrTfFU8QRIcNxGiKE5eyo2EQVxeglGmjKX4bGCape9GV57Fr0KuwpiVUsKtb0XLgQQ
        s8gy2fPNgvRVgTB02s0YsSdD1AIX2xM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-pLOBM8NOMmuq71nXuiEpaA-1; Fri, 25 Aug 2023 03:37:27 -0400
X-MC-Unique: pLOBM8NOMmuq71nXuiEpaA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31c7b8d0f0aso454476f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692949046; x=1693553846;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnj66daazMp7cNcIjFO+EqMnKflgV7c8qtO7Inq7NlY=;
        b=HcTiBSM72mVknGwQlvgZ5q36xSIgezZpeNQFqPX7grT86T7i0G9gAziaI6tv9j3h6S
         kIY3roJjwbMgY5ReEVByS3riHeOEM/UX4DnmMcnR3fT6zHz009o1MbRko8iY9tLsv72M
         MY7qENtV/d2IPzTJveLupIPTEACEgwQ6A18y7PMDA7wubOBnqApc9wMuclfphQ2PpNDm
         3mcSP/vCzD7w1SJWwIXisRR4fubbrXSPWOtxFWTkkRD5Ei0OkuxiVNdspFEy17CQnfWc
         kPRdfSLcC535J8X2UXWi257UlyX/i1q++SpJwrk7VEX9Ir4mZ/vGsL7AtBCG1yUCDpff
         u5Eg==
X-Gm-Message-State: AOJu0YzFo1PM0APn5fug92/irewd7vgnodRXd5OBQdtLaY+Zg02HrumD
        GNAnEEXZSXI54mvnmxCd5ElDlZCjTtA+8qLUjvJ3BltE9pie+hug5dW1lMYNaCxzCBc+Hj7FtWs
        46n9/LVVeqfQa7Fj7YJFdCg3P
X-Received: by 2002:adf:ce02:0:b0:319:6b5e:85e3 with SMTP id p2-20020adfce02000000b003196b5e85e3mr12061985wrn.71.1692949045920;
        Fri, 25 Aug 2023 00:37:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKIgA2U9Vxpsz/IZArf9xGgiPdBdcR2RRWiffD6OYBacfD6fGlz67nU8gaKxQgqhi2iYmv+Q==
X-Received: by 2002:adf:ce02:0:b0:319:6b5e:85e3 with SMTP id p2-20020adfce02000000b003196b5e85e3mr12061973wrn.71.1692949045578;
        Fri, 25 Aug 2023 00:37:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:9200:ce93:b5e6:8aa9:65d4? (p200300cbc70e9200ce93b5e68aa965d4.dip0.t-ipconnect.de. [2003:cb:c70e:9200:ce93:b5e6:8aa9:65d4])
        by smtp.gmail.com with ESMTPSA id w12-20020a5d4b4c000000b0031416362e23sm1408837wrs.3.2023.08.25.00.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 00:37:24 -0700 (PDT)
Message-ID: <a6aaf2cf-1533-e55e-eaaf-75bc5d2056e1@redhat.com>
Date:   Fri, 25 Aug 2023 09:37:24 +0200
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
 <9d4d0643-6a7e-22bf-1f54-19646bb7231e@redhat.com>
 <90562ff0-9689-4d00-848e-87347cacdbae@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <90562ff0-9689-4d00-848e-87347cacdbae@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.23 09:36, Vern Hao wrote:
> 
> 在 2023/8/25 15:34, David Hildenbrand 写道:
>> On 25.08.23 09:31, Vern Hao wrote:
>>>
>>> 在 2023/8/25 15:12, David Hildenbrand 写道:
>>>> On 25.08.23 06:08, Vern Hao wrote:
>>>>> From: Vern Hao <vernhao@tencent.com>
>>>>>
>>>>> In skip_cma(), we can use folio_migratetype() to replace
>>>>> get_pageblock_migratetype().
>>>>>
>>>>> Fixes: 5da226dbfce3 ("mm: skip CMA pages when they are not available")
>>>>
>>>> Why did you think "Fixes" was a good idea?
>>>>
>>> The skip_cma() contains the folio argument, and the folio_migratetype()
>>> is already implemented in the kernel, so I think it's fine to keep it
>>> consistent.
>>
>> If this doesn't actually *fix a bug*, then please don't add fixes and
>> confuse people looking for actual bugfixes.
>>
>> See Documentation/process/submitting-patches.rst
> OK, my bad, i will remove it, thanks.
> 

No need to resend. Andrew can drop that tag when applying.

-- 
Cheers,

David / dhildenb

