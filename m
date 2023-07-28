Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB84766F94
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbjG1Of6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbjG1Ofz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0379C3A9B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690554912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T8f2jcEWHe85NAwJ+QYf2QWkY01PugbZbbWPEErvXII=;
        b=HP555RYAGoMulDbepeE3vfE+fAj9BQhSkYdK5vEzeF4PerbuBcggP9IdLDS+UIBYr18WWs
        KlSRKYnF+I7prgeRaxlhb67bzyDi3YqntOP4GPNDYkFj540ZhuCM7NXixdMgugmJYyQ0Yi
        3W6C6BJPezQZyRDrWPlJ/z8RfGEgtZc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-jhzvxM1eNfKD4Es_Ni7Qdw-1; Fri, 28 Jul 2023 10:35:07 -0400
X-MC-Unique: jhzvxM1eNfKD4Es_Ni7Qdw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fa9a282fffso11827455e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690554906; x=1691159706;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8f2jcEWHe85NAwJ+QYf2QWkY01PugbZbbWPEErvXII=;
        b=Kze/odMVdrFdGWccQ1MNQZUVX7vJ6RiopygBI/+6M0IXhFsQzIPMnuNGcRoS2P744F
         tFfy46QRScpEsBD7D/I5YNDtnq8u8RmutqYkK7N5qpcjTCF1DVnVz30qEe5WpgbdQ++v
         W29rcjtTBcZBIEvoIHHNwqrddC90DBofupBo6VErSwmtJkzJihovfH+7RAfkyiXZ5Ar3
         j/lsAEvkyQa9K8MnsOD5oXqyTrNdqyv8jcRmrIXke8Yp8dDRGEYdNYdvRxzAASTZZ9IC
         3nsGL9ogp2s87pNjJZC/jmp/LRCWv3NyUn+s2QN2S++1LJ3kMnz/0iFX9llh296ccQJg
         WYpA==
X-Gm-Message-State: ABy/qLYlYHEQ+lPZ7HEuG4JpsALDw2hNGof2Z+GVuly8WgKhJpQuuwLb
        vl5R4NSVfiCTUT4TDtVhhx0/3DsjB6PFN17UAyKlzf1KeVGw9PcGD1KPdOV9wFX5Hd1ZTXhiIdt
        JUPxtLOMFFN/at1UvFzhn/rAP
X-Received: by 2002:a05:600c:2248:b0:3fb:ffa8:6d78 with SMTP id a8-20020a05600c224800b003fbffa86d78mr1882095wmm.36.1690554906732;
        Fri, 28 Jul 2023 07:35:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGghZKLFi0VL5qxS7EG+DsAnMC4z1b9QjFmvxxsSdSuv02WebYTiWKZNZ14tKbZSFP1Q1dm0w==
X-Received: by 2002:a05:600c:2248:b0:3fb:ffa8:6d78 with SMTP id a8-20020a05600c224800b003fbffa86d78mr1882076wmm.36.1690554906382;
        Fri, 28 Jul 2023 07:35:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:6b00:bf49:f14b:380d:f871? (p200300cbc7066b00bf49f14b380df871.dip0.t-ipconnect.de. [2003:cb:c706:6b00:bf49:f14b:380d:f871])
        by smtp.gmail.com with ESMTPSA id f2-20020a7bc8c2000000b003fbc9b9699dsm4324357wml.45.2023.07.28.07.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 07:35:05 -0700 (PDT)
Message-ID: <8e4d9fa7-7550-87a9-ead1-2d2a8691cdab@redhat.com>
Date:   Fri, 28 Jul 2023 16:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] selftests: mm: ksm: Fix incorrect evaluation of
 parameter
Content-Language: en-US
To:     Ayush Jain <ayush.jain3@amd.com>, akpm@linux-foundation.org,
        shuah@kernel.org, pasha.tatashin@soleen.com,
        zhansayabagdaulet@gmail.com, tyhicks@linux.microsoft.com,
        raghavendra.kodsarathimmappa@amd.com
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Narasimhan.V@amd.com,
        Santosh.Shukla@amd.com
References: <20230728060109.4403-1-ayush.jain3@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230728060109.4403-1-ayush.jain3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.23 08:01, Ayush Jain wrote:
> A missing break in kms_tests leads to kselftest hang when the
> parameter -s is used.
> In current code flow because of missing break in -s, -t parses
> args spilled from -s and as -t accepts only valid values as 0,1
> so any arg in -s >1 or <0, gets in ksm_test failure
> 
> This went undetected since, before the addition of option -t,
> the next case -M would immediately break out of the switch
> statement but that is no longer the case
> 
> Add the missing break statement.
> 
> ----Before----
> ./ksm_tests -H -s 100
> Invalid merge type
> 
> ----After----
> ./ksm_tests -H -s 100
> Number of normal pages:    0
> Number of huge pages:    50
> Total size:    100 MiB
> Total time:    0.401732682 s
> Average speed:  248.922 MiB/s
> 
> Fixes: 9e7cb94ca218 ("selftests: vm: add KSM merging time test")

I think this actually fixes 07115fcc15b4 ("selftests/mm: add new 
selftests for KSM") that added the "t" parsing.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

