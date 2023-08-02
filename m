Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DC376CC00
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbjHBLs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbjHBLs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AC626B0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690976860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+1l7tAWisMMjZc/EIQh02XSaQWm+1mCIN4U3FEANOvA=;
        b=NrRAaKrl2+1bEWyWfSVKcJ5k6fbodmToVYGGMm01u2orq3LXRkNaQQ0Z13OQTT/+ixNW4H
        EUQH1tKln1XfqwOC7YHyNDkobxBuVYDL/kybyFNH1N3dd7r/vd9mPxKYZVLAi9f4sU4zYD
        DkRlB4YisBZoDlRuoTez7AR3oewkyzw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-2l2oSEE5MZCg2WJ1vgZDqA-1; Wed, 02 Aug 2023 07:47:37 -0400
X-MC-Unique: 2l2oSEE5MZCg2WJ1vgZDqA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b9fa64dba8so18143321fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 04:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690976855; x=1691581655;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1l7tAWisMMjZc/EIQh02XSaQWm+1mCIN4U3FEANOvA=;
        b=AfKq14Lmfs8hKPvALtvr860jcf3uZECXKnjg3kv/XRNK+liE7aJ6XJOayfF/8VMhgn
         hlikECSKxlEY+K+ASTIqlO0bqXqdLdsGKU7m4JFLbauiU0Tafh3tRUZHGmaNpmzPMEmG
         DyKaid4NTm2IPOig3jRsw6Hu9DWFfM7O+sbma8+vhjs1QQWraY7Mghwv7UKWWtGH1tEZ
         RhSpxX6FsDgALpiwotjxBSg/DePwgXkUeJYNMlCN16jPt6+pufibCXL8vHZut2Q/l5P6
         tkn8X1va5TOfai4EIgqwg6/ug9FvlKEJ/j/aIF8nvcbkESyTtQb+Za7svhybCQluTZNo
         uYKQ==
X-Gm-Message-State: ABy/qLbWphDPVMiX9Qm1JoJD+Nvh8dhMMq5DChHeY1A++1yvlQANInxj
        fp915hG6VIHypPKBnhH/s8+IPOOqzYqFKQm/JwbbDN4kVo88A+bNQlgaTBnxvwguJNSGZoujvHj
        YEGY9E/bniCvMdrk5wTpH7ruj
X-Received: by 2002:a2e:7c0f:0:b0:2b6:d9dd:f65f with SMTP id x15-20020a2e7c0f000000b002b6d9ddf65fmr4365706ljc.17.1690976855478;
        Wed, 02 Aug 2023 04:47:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE62uvhsrIl6me/jizRDV61pFoCtjdYNitfdPIIIeK2V1eh4TanfpZi+wwU/tUD2NAqIS4Lyg==
X-Received: by 2002:a2e:7c0f:0:b0:2b6:d9dd:f65f with SMTP id x15-20020a2e7c0f000000b002b6d9ddf65fmr4365690ljc.17.1690976855093;
        Wed, 02 Aug 2023 04:47:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:e00:b8a4:8613:1529:1caf? (p200300cbc70b0e00b8a4861315291caf.dip0.t-ipconnect.de. [2003:cb:c70b:e00:b8a4:8613:1529:1caf])
        by smtp.gmail.com with ESMTPSA id l22-20020a7bc456000000b003fc06169ab3sm1491685wmi.20.2023.08.02.04.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 04:47:34 -0700 (PDT)
Message-ID: <bf4b5b30-4ed1-13ed-bba9-234887c9eeb3@redhat.com>
Date:   Wed, 2 Aug 2023 13:47:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] mm: migrate: more folio conversion
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Huang Ying <ying.huang@intel.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20230802095346.87449-1-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230802095346.87449-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.08.23 11:53, Kefeng Wang wrote:
> This patch series converts several functions to use folio in migrate.c.

Please clearly spell out in the patch descriptions when you are changing 
mapcount logic and which effects that might have (both, positive and 
negative) for PTE-mapped THP.

-- 
Cheers,

David / dhildenb

