Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C408800713
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378193AbjLAJcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378180AbjLAJbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:31:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888721FEB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701422980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=aHQs+9zlQ8PVnO/IT7ptVfgOYh9mlV/hOr1XHdCyFZs=;
        b=KpRcPHrGOVUY0EBwqCgxGv1RT9pqTtduBQKWaeYGKPwOnOXyk3U5fSbeZJvoFyAAoTWWAH
        jlNjnmtohh6KZisupr5PQZk5XRDQgza40TiQn2pt7GokfmPEqSGkD9pohIBJ2YbbPXdLpt
        G/FuIO1sOB4GmzTo+yjV07Vj3OL7O48=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-Wh0vwDRROFu8I04CltYUtA-1; Fri, 01 Dec 2023 04:29:38 -0500
X-MC-Unique: Wh0vwDRROFu8I04CltYUtA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3330881541eso1537953f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 01:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701422977; x=1702027777;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHQs+9zlQ8PVnO/IT7ptVfgOYh9mlV/hOr1XHdCyFZs=;
        b=cAP3nug9sYT3zS2InYMiAIkIFNYzxx6GMN0vDSvPzyt189nKDOequsMBaOEHMoeYTA
         Hr6iz8Op9EBPhlalzEu6O2pvOzEryEaJ3yIvUlXMRl2Gs7zw0hEVXb1AxfD3sJGefNvk
         LJXDs+ElfEh6bV43mxCrkuv/uitqUosbPvmUaFfDuWOdPZGp8B7SIUWg2Xy+k/nF7S8B
         Suc6bj2iGuq8JmYFFdEUJqgNVjkluKh3V6fMikNIzBdtmO8BLF41DpYTfy4d5cPye7Dr
         z+e+0SMpcn2L/ij/L/qeh0CdUUgSK7DncXiJs+VqsI92beJcf8I8DUjwlUFpIZq1VgTs
         ClYQ==
X-Gm-Message-State: AOJu0Yz1wKj0nwNyBrVDRKlJPFcNXTtXYDZ9VoBKTUbLpxRA4h8U0dON
        5oI4/Fhv41Mj6O45zLozDjVPXwQ9j7/hxLtnnP683DbDMdqg5/IGGWWOQPoyTSZIDVCQ7qzd9ri
        2moUDdGTcg7TdHNgSZ+JXfwIq
X-Received: by 2002:a05:6000:1a45:b0:333:2fd2:6f4e with SMTP id t5-20020a0560001a4500b003332fd26f4emr645119wry.88.1701422977202;
        Fri, 01 Dec 2023 01:29:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6bydnphRGhaq+ilbhxPmQBEgxvJKTbvX6HdXyxqISzaG1u0FQwN4zQjzt0whtGPIn363OgA==
X-Received: by 2002:a05:6000:1a45:b0:333:2fd2:6f4e with SMTP id t5-20020a0560001a4500b003332fd26f4emr645087wry.88.1701422976743;
        Fri, 01 Dec 2023 01:29:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c726:4100:c308:78e3:8f80:52ac? (p200300cbc7264100c30878e38f8052ac.dip0.t-ipconnect.de. [2003:cb:c726:4100:c308:78e3:8f80:52ac])
        by smtp.gmail.com with ESMTPSA id y17-20020adfee11000000b003330a1d35b6sm3708872wrn.115.2023.12.01.01.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 01:29:36 -0800 (PST)
Message-ID: <135306b4-2f94-4266-8f72-90315bb846b4@redhat.com>
Date:   Fri, 1 Dec 2023 10:29:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] Supporting GMEM (generalized memory management)
 for external memory devices
Content-Language: en-US
To:     zhuweixi <weixi.zhu@huawei.com>, Dave Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "weixi.zhu@openeuler.sh" <weixi.zhu@openeuler.sh>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "rcampbell@nvidia.com" <rcampbell@nvidia.com>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "mhairgrove@nvidia.com" <mhairgrove@nvidia.com>,
        "ziy@nvidia.com" <ziy@nvidia.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "ogabbay@kernel.org" <ogabbay@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
        "zhi.a.wang@intel.com" <zhi.a.wang@intel.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
        "Zeng, Oak" <oak.zeng@intel.com>
References: <20231128125025.4449-1-weixi.zhu@huawei.com>
 <9308a79d-e312-4e6d-98fe-75dc6d0fbeda@amd.com>
 <CAPM=9tx-d-Au_bjX0vYxv6OwqiSjmbbMC7ebWpTsQgFNddWDuw@mail.gmail.com>
 <a07fd33c6f9e44418c528de06f89707e@huawei.com>
 <188814aa-4f55-40c6-961c-6105c89d76f3@redhat.com>
 <f4ec70345800432caa94d662f49370f6@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f4ec70345800432caa94d662f49370f6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.12.23 03:44, zhuweixi wrote:
> Thanks!

I hope you understood that that was a joke :)

> I am planning to present GMEM in Linux MM Alignment Sessions so I can collect more input from the mm developers.

Sounds good. But please try inviting key HMM/driver developer as well.

Most of the core-mm folks attending that meeting are not that familiar 
with these concepts and they are usually not happy about:

(1) More core-MM complexity for things that can be neatly handled in
     separate subsystems with the existing infrastructure already.

(2) One new way of doing things why the other things remain in place.

(3) New MMAP flags. Usually you have a hard time getting this in.
     Sometimes, there are other ways (e.g., special-purpose file-
     systems).

(4) Changing controversial core-mm design decisions to handle corner
     cases.

-- 
Cheers,

David / dhildenb

