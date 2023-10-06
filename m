Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C6F7BB722
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjJFMCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjJFMCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:02:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1E3CA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696593676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kCYNyulRpx1YyhVOL3Le9TlBc2wHmh6Ikm1+wxMUQTM=;
        b=bqRfCYmWLPMz6GIwyA176vyhWmGfvTsB+kBGbXb1fkEy9ohHZyfBWBeLoQn8m2fH5cLnJI
        rz7HqJCCxUE5kYriW6aEqdc7jA6/uJoFqoG6seBGbVnxrUL6aL1ZgrAR/nHXpy4Mo5HzSc
        ydePACf9Cgjph64vr4+cDy9PMpZ1t98=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-i5QmRvkgNBa2Tw7LccCbWw-1; Fri, 06 Oct 2023 08:01:12 -0400
X-MC-Unique: i5QmRvkgNBa2Tw7LccCbWw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40566c578b7so15095225e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 05:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696593671; x=1697198471;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCYNyulRpx1YyhVOL3Le9TlBc2wHmh6Ikm1+wxMUQTM=;
        b=OifiVOHeW2mVmIWzW7ZA6sjCWrYYO5VycNrzhJoSXBg2d7FAiTchjPrVowhj6PNXze
         xgqzjUhJZI2Y9NxzS2fa/vdPluwRO2cZdInnm7aE7SwW4hpUbbZXuv9mgQdxgtRT1ovY
         8CDiGYpmr9xAJtAlCZYDf8mCTmSx3Tl+xlespidbDB2QnhdSu7/53jqcX8DInOYEAtZy
         cNR1i9KZw6oSDdyRaydMnnzxBYdu+vG1rDhQSiqdBM4sfV6wXpUf7co/N8nQy84aE2mG
         Z4Z6bV44Bdssgv2+xu+JVG3IW+eO5cUGNKddpkgwkZkBxu0WwRVM+1ZFdyTDtBCDQlCt
         0NFg==
X-Gm-Message-State: AOJu0YwA8ypvtJ6pJyi/rZe+jTwlg7UHazo9EtXoTiKIrSTQSUWM/ylC
        1ALRtb4MUDZ9OjJa8QtvG2HPKsdw3VOy6+dTlyliPFgG35Y1A/T9TfM4QNyipK4iR5oqUcp2kn9
        bt9AowkecUfKknqgnMuW4A7aL
X-Received: by 2002:adf:ea8f:0:b0:317:6175:95fd with SMTP id s15-20020adfea8f000000b00317617595fdmr7669954wrm.43.1696593670827;
        Fri, 06 Oct 2023 05:01:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIHkTSWEYQCqhtcnXwQbXXcji0NvYj5HwDLBbmOfLGxJeobULC9BGehmgcvKkiU172hpNvnA==
X-Received: by 2002:adf:ea8f:0:b0:317:6175:95fd with SMTP id s15-20020adfea8f000000b00317617595fdmr7669924wrm.43.1696593670256;
        Fri, 06 Oct 2023 05:01:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:ee00:4e24:cf8e:3de0:8819? (p200300cbc715ee004e24cf8e3de08819.dip0.t-ipconnect.de. [2003:cb:c715:ee00:4e24:cf8e:3de0:8819])
        by smtp.gmail.com with ESMTPSA id m15-20020adfe94f000000b0031984b370f2sm1500366wrn.47.2023.10.06.05.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 05:01:09 -0700 (PDT)
Message-ID: <4509a3b4-16a6-f63e-1dd5-e20c7eadf87d@redhat.com>
Date:   Fri, 6 Oct 2023 14:01:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231004190249.829015-1-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 0/4] mm/ksm: Add ksm advisor
In-Reply-To: <20231004190249.829015-1-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.10.23 21:02, Stefan Roesch wrote:
> What is the KSM advisor?
> =========================
> The ksm advisor automatically manages the pages_to_scan setting to
> achieve a target scan time. The target scan time defines how many seconds
> it should take to scan all the candidate KSM pages. In other words the
> pages_to_scan rate is changed by the advisor to achieve the target scan
> time.
> 
> Why do we need a KSM advisor?
> ==============================
> The number of candidate pages for KSM is dynamic. It can often be observed
> that during the startup of an application more candidate pages need to be
> processed. Without an advisor the pages_to_scan parameter needs to be
> sized for the maximum number of candidate pages. With the scan time
> advisor the pages_to_scan parameter based can be changed based on demand.
> 
> Algorithm
> ==========
> The algorithm calculates the change value based on the target scan time
> and the previous scan time. To avoid pertubations an exponentially
> weighted moving average is applied.
> 
> The algorithm has a max and min
> value to:
> - guarantee responsiveness to changes
> - to avoid to spend too much CPU
> 
> Parameters to influence the KSM scan advisor
> =============================================
> The respective parameters are:
> - ksm_advisor_mode
>    0: None (default), 1: scan time advisor
> - ksm_advisor_target_scan_time
>    how many seconds a scan should of all candidate pages take
> - ksm_advisor_min_pages
>    minimum value for pages_to_scan per batch
> - ksm_advisor_max_pages
>    maximum value for pages_to_scan per batch
> 
> The parameters are exposed as knobs in /sys/kernel/mm/ksm.
> By default the scan time advisor is disabled.

What would be the main reason to not have this enabled as default?

IIUC, it is kind-of an auto-tuning of pages_to_scan. Would "auto-tuning" 
describe it better than "advisor" ?

[...]

> How is defining a target scan time better?
> ===========================================
> For an administrator it is more logical to set a target scan time.. The
> administrator can determine how many pages are scanned on each scan.
> Therefore setting a target scan time makes more sense.
> 
> In addition the administrator might have a good idea about the
> memory sizing of its respective workloads.

Is there any way you could imagine where we could have this just do 
something reasonable without any user input? IOW, true auto-tuning?

I read above:
 > - guarantee responsiveness to changes
 > - to avoid to spend too much CPU

whereby both things are accountable/measurable to use that as the input 
for auto-tuning?


I just had a family NMI, so my todo list is quite lengthy. Hoping I cna 
take a closer look next week.

-- 
Cheers,

David / dhildenb

