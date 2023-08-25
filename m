Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C687880B6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242127AbjHYHN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243008AbjHYHNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:13:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C71FE6B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692947564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9U8KSIvIVRiZ6dAQCz7TZ+og9/5D7HnHvFwx7FgM9aU=;
        b=IZPP6RffETDtXjl706NdNQrK6NwHEjRFnYyOs6zZFQwC9U4XEhIMqm62eHYS4ow8wZJK/w
        UYZKyzs6xut8a/fccL7sraK9WXvnfq8ybdWa2ZenIkZZHBAzMNNDtprkSJiRib1oAaNTBT
        3/l7py+WVy061f9tAQFJukWsDqN3gpA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-xZgb2E7ePaCL2QFJ24OonA-1; Fri, 25 Aug 2023 03:12:42 -0400
X-MC-Unique: xZgb2E7ePaCL2QFJ24OonA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50076a3fd35so694196e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692947561; x=1693552361;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9U8KSIvIVRiZ6dAQCz7TZ+og9/5D7HnHvFwx7FgM9aU=;
        b=Ldb543Y3SjEP3905e0rFuduSwxmW6ZTTAkEo4jnPqiXOt/d9PP9gsLAEWuGQGGH8R6
         FDcMUAHpeK12KrvU3BRmww//p6V9XNT2kGC8OwGY1Y7Zg6lu/D2S4WdKAGA29jlnbSUv
         6PRnQn11KTCSgRq75vG81i47+0DxlWfhswqcm7VdKmCY4/jM73tkQaHap0qqqc1td07i
         iqyB5IR8P1y5J9T+jr/t697or6x/YvDAiNADpkBTDNS1TLUu4EJA907W1ZkZz49bJ5Xp
         GnCT/U1aIMM5ePl/fCny7PH9NSLYRxZ2s4zHNwGyDYL6nThwFgOc/SsoFVu5q1h6j3RL
         FnqA==
X-Gm-Message-State: AOJu0YzAxf2wx0N3529Wh7ifZSVvQ20wtEI6NWqrMANKAMau908mPjlX
        AAoW5dedrul1rCjedew+r7zc3OyV5Ij/pNCW3xDFwVOoYClrBVydS7KQdioZBtwUulyR13rMF2b
        xvsS/nptk3QiTefn4281w3XxE
X-Received: by 2002:a05:6512:baa:b0:4fe:8661:7696 with SMTP id b42-20020a0565120baa00b004fe86617696mr16353595lfv.45.1692947561355;
        Fri, 25 Aug 2023 00:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMANrPj3Nadj7ClSeqNvGFGSceOVb1smPF2jcdQcnF3ZOHLN0fMFYcSi5ljdPGpjDbUcd3DA==
X-Received: by 2002:a05:6512:baa:b0:4fe:8661:7696 with SMTP id b42-20020a0565120baa00b004fe86617696mr16353582lfv.45.1692947560979;
        Fri, 25 Aug 2023 00:12:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:9200:ce93:b5e6:8aa9:65d4? (p200300cbc70e9200ce93b5e68aa965d4.dip0.t-ipconnect.de. [2003:cb:c70e:9200:ce93:b5e6:8aa9:65d4])
        by smtp.gmail.com with ESMTPSA id e14-20020adfef0e000000b00315af025098sm1340554wro.46.2023.08.25.00.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 00:12:40 -0700 (PDT)
Message-ID: <aa5d199b-ea12-90f3-91fb-468d74a6f934@redhat.com>
Date:   Fri, 25 Aug 2023 09:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm/vmscan: Use folio_migratetype() instead of
 get_pageblock_migratetype()
To:     Vern Hao <haoxing990@gmail.com>, akpm@linux-foundation.org
Cc:     zhaoyang.huang@unisoc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vern Hao <vernhao@tencent.com>
References: <20230825040848.1542-1-user@VERNHAO-MC1>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230825040848.1542-1-user@VERNHAO-MC1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.23 06:08, Vern Hao wrote:
> From: Vern Hao <vernhao@tencent.com>
> 
> In skip_cma(), we can use folio_migratetype() to replace get_pageblock_migratetype().
> 
> Fixes: 5da226dbfce3 ("mm: skip CMA pages when they are not available")

Why did you think "Fixes" was a good idea?

-- 
Cheers,

David / dhildenb

