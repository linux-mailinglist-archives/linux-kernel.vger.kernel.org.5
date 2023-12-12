Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A42180EDF3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376271AbjLLNqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346622AbjLLNqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:46:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59574A1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702388787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=8DODWjUHEOXpo4jstEumop4gYxI3RMhCZ+EH7YA+W/g=;
        b=Jtr6coEBs+yOngQQMec8H3UFE71tD73dv+pq225kdFSk+iDEaVpGrDitjEM1pkvj/GNSIo
        xb8Rcqx6BbJBJk7RT/VWcKpu2fUNoBr+qXMWazv5JoRo3W/mSk2xcgxYvB6NfVyAAgmZVd
        RaCrHaNW2U4vR/IjqOpZ/Mlfbi8cVpU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-LV14k3W7Pkart837sqbWkg-1; Tue, 12 Dec 2023 08:46:26 -0500
X-MC-Unique: LV14k3W7Pkart837sqbWkg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-333501e22caso4648758f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702388785; x=1702993585;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DODWjUHEOXpo4jstEumop4gYxI3RMhCZ+EH7YA+W/g=;
        b=hAONab4K/kMfwolBR2SQkmQTI+afC8aZCS7tQRcLwFKAN8Xjq4Ihc8piM4/kjJPcdi
         325romUP/yndsgZa8aN3mmX12110DcE3gsb6IuHVdLmd3Eq+rs9RLKJfxBp97W7nLc70
         JxQHiT82NL3AP/3JntdPLFhM3FDxGSdCWepRMFFjzAMXHDkoc0xxbI4+2GYzvnSQXcpe
         1d0jtkxw0QZ64lxSAPC683lBhJdRsdwSsgTKL2Xfg/RB+ItN6F10PzQ4wVSjP4Vat8OU
         bw0nODiZQbTAxB7kNoX/ngRVNyHWyrRLoQHm905LKccylr3TbrQtlx3B4LGLhgaBxEKd
         wu9A==
X-Gm-Message-State: AOJu0YyflA2dCMOP309cfnopnH68s1oxaHgtQ2UeqLM/1XQxypOcKkyI
        +1A7Vjw4lLOVWV12h4DG7JJDVY8vSTHXyxz1Whm6o+LbAtig6XNuYKcyDRZ4uXjmlQEncbKbN/0
        sz4+lUixvhU05X1L4ClbHl/83
X-Received: by 2002:a5d:690b:0:b0:333:fd3:1a7f with SMTP id t11-20020a5d690b000000b003330fd31a7fmr3280231wru.52.1702388784970;
        Tue, 12 Dec 2023 05:46:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPcAUkAnVXkT/RFK+r6/G570L2IwjrcW/StIsDaH6zBDs2G0l+T3BpbiPbTtwbrq4MMwYShA==
X-Received: by 2002:a5d:690b:0:b0:333:fd3:1a7f with SMTP id t11-20020a5d690b000000b003330fd31a7fmr3280221wru.52.1702388784645;
        Tue, 12 Dec 2023 05:46:24 -0800 (PST)
Received: from ?IPV6:2003:cb:c74b:ca00:4ca2:ff2c:9092:f070? (p200300cbc74bca004ca2ff2c9092f070.dip0.t-ipconnect.de. [2003:cb:c74b:ca00:4ca2:ff2c:9092:f070])
        by smtp.gmail.com with ESMTPSA id e10-20020adffd0a000000b003334675634bsm10885476wrr.29.2023.12.12.05.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 05:46:24 -0800 (PST)
Message-ID: <525a4d9c-efaf-4663-a354-10f9e3ff2148@redhat.com>
Date:   Tue, 12 Dec 2023 14:46:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm/ksm: document ksm advisor and its sysfs knobs
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231204234906.1237478-1-shr@devkernel.io>
 <20231204234906.1237478-5-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231204234906.1237478-5-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.23 00:49, Stefan Roesch wrote:
> This documents the KSM advisor and its new knobs in /sys/fs/kernel/mm.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> ---
>   Documentation/admin-guide/mm/ksm.rst | 54 ++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
> index e59231ac6bb71..297c4a0d04dee 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -80,6 +80,9 @@ pages_to_scan
>           how many pages to scan before ksmd goes to sleep
>           e.g. ``echo 100 > /sys/kernel/mm/ksm/pages_to_scan``.
>   
> +        The pages_to_scan value cannot be changed if ``advisor_mode`` has
> +        been set to scan-time.
> +
>           Default: 100 (chosen for demonstration purposes)
>   
>   sleep_millisecs
> @@ -164,6 +167,29 @@ smart_scan
>           optimization is enabled.  The ``pages_skipped`` metric shows how
>           effective the setting is.
>   
> +advisor_mode
> +        The ``advisor_mode`` selects the current advisor. Two modes are
> +        supported: none and scan-time. The default is none. By setting
> +        ``advisor_mode`` to scan-time, the scan time advisor is enabled.
> +        The section about ``advisor`` explains in detail how the scan time
> +        advisor works.
> +
> +adivsor_max_cpu
> +        specifies the upper limit of the cpu percent usage of the ksmd
> +        background thread. The default is 70.
> +
> +advisor_target_scan_time
> +        specifies the target scan time in seconds to scan all the candidate
> +        pages. The default value is 200 seconds.
> +
> +advisor_min_pages
> +        specifies the lower limit of the ``pages_to_scan`` parameter of the
> +        scan time advisor. The default is 500.
> +
> +adivsor_max_pages
> +        specifies the upper limit of the ``pages_to_scan`` parameter of the
> +        scan time advisor. The default is 30000.
> +
>   The effectiveness of KSM and MADV_MERGEABLE is shown in ``/sys/kernel/mm/ksm/``:
>   
>   general_profit
> @@ -263,6 +289,34 @@ ksm_swpin_copy
>   	note that KSM page might be copied when swapping in because do_swap_page()
>   	cannot do all the locking needed to reconstitute a cross-anon_vma KSM page.
>   
> +Advisor
> +=======
> +
> +The number of candidate pages for KSM is dynamic. It can be often observed
> +that during the startup of an application more candidate pages need to be
> +processed. Without an advisor the ``pages_to_scan`` parameter needs to be
> +sized for the maximum number of candidate pages. The scan time advisor can
> +changes the ``pages_to_scan`` parameter based on demand.
> +
> +The advisor can be enabled, so KSM can automatically adapt to changes in the
> +number of candidate pages to scan. Two advisors are implemented: none and
> +scan-time. With none, no advisor is enabled. The default is none.
> +
> +The scan time advisor changes the ``pages_to_scan`` parameter based on the
> +observed scan times. The possible values for the ``pages_to_scan`` parameter is
> +limited by the ``advisor_max_cpu`` parameter. In addition there is also the
> +``advisor_target_scan_time`` parameter. This parameter sets the target time to
> +scan all the KSM candidate pages. The parameter ``advisor_target_scan_time``
> +decides how aggressive the scan time advisor scans candidate pages. Lower
> +values make the scan time advisor to scan more aggresively. This is the most
> +important parameter for the configuration of the scan time advisor.
> +
> +The initial value and the maximum value can be changed with ``advisor_min_pages``
> +and ``advisor_max_pages``. The default values are sufficient for most workloads.
> +
> +The ``pages_to_scan`` parameter is re-calculated after a scan has been completed.


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

