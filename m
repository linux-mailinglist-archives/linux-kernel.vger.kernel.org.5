Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613BB76520A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjG0LQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjG0LQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:16:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C458100
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690456531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qifcgH9Iv2t9GD/A6oePig9I4ljzKmhrsNXuaO8xLVg=;
        b=K5yBnE3AXSYCSU+B6pxnkD7mD7eRYb9PbJZELkjxjpOrt+gLPhVCbjamDt94pEDS+YHEbX
        WKkMBIDpUwtXUCDPt7x2bOHqn6douGh/PwNvh4vljGhaIllwFX6LBYaDP4xj7jY9cESH43
        2eFAz/SSCWomIuLJnFOu4+g7AicR+WA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-2Md_GIMeOuqtLoxL2ATVZw-1; Thu, 27 Jul 2023 07:15:30 -0400
X-MC-Unique: 2Md_GIMeOuqtLoxL2ATVZw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-314275b653eso427476f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690456529; x=1691061329;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qifcgH9Iv2t9GD/A6oePig9I4ljzKmhrsNXuaO8xLVg=;
        b=MeLc5JNtI5D9fTsrxZ0qQvek7E+2jK0Yh19kwSwi8uDcCnt3zfJxmkKPf38a0sZXzT
         Nn1E5GTZhuHWh5++orIHU1b8f4GioCBEYqmlyxuAortNc6qVw4fgE27yg0zvZOab6pnq
         xW18XJBVNedB26sIaJf1s7VLeAYcTY0thkZDm/7CNSYyeo2tg2p7daoUs4bsytizKU6w
         0O/T4yQKDanoL50Z/7QmNjZIas050CeRKC5zAc+7i69nlFYVtPT/rdXsWAZPe6L5c9ic
         9qOnAvT7nGpiRf7F+twVqJyfGFYUGJI7gLFDlooDRiT16yVLgf9zzDHDp/8hIth/BYcJ
         mEJA==
X-Gm-Message-State: ABy/qLbC09W9X9V/FTEEFmkSzDkyMe+oEVBxSv82oaHJvgG0baZFKrAH
        9726XQFaqR3IK0bfBujU/Ce3KYmP03L2FP/zLB75xW+Mj7LI9kAS6AsXJfL0XeMV0dUYEuYiPcm
        Y12PxtGJnnSVxwUtcUakh2eYP
X-Received: by 2002:adf:fa8a:0:b0:317:5181:90b3 with SMTP id h10-20020adffa8a000000b00317518190b3mr1552102wrr.55.1690456529399;
        Thu, 27 Jul 2023 04:15:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHoSz45sZWcwdYfJXPvGk//IAenP6lcfMjzRhqJTJqKxgcWSFkM+3ngiMx7s+jfLunp5UJNJw==
X-Received: by 2002:adf:fa8a:0:b0:317:5181:90b3 with SMTP id h10-20020adffa8a000000b00317518190b3mr1552083wrr.55.1690456528974;
        Thu, 27 Jul 2023 04:15:28 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id s6-20020a5d6a86000000b003142ea7a661sm1772109wru.21.2023.07.27.04.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 04:15:28 -0700 (PDT)
Message-ID: <b3e305e9-26c3-d4f4-d0ce-79d79d98afe2@redhat.com>
Date:   Thu, 27 Jul 2023 13:15:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] mm: Fix use-after-free for MMU_GATHER_NO_GATHER
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230727110224.3333682-1-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230727110224.3333682-1-ryan.roberts@arm.com>
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

On 27.07.23 13:02, Ryan Roberts wrote:
> The recent change to batch-zap anonymous ptes did not take into account
> that for platforms where MMU_GATHER_NO_GATHER is enabled (e.g. s390),
> __tlb_remove_page() drops a reference to the page. This means that the
> folio reference count can drop to zero while still in use (i.e. before
> folio_remove_rmap_range() is called). This does not happen on other
> platforms because the actual page freeing is deferred.
> 
> Solve this by appropriately getting/putting the folio to guarrantee it
> does not get freed early.
> 
> Given the new need to get/put the folio in the batch path, let's stick
> to the non-batched path if the folio is not large. In this case batching
> is not helpful since the batch size is 1.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Fixes: 904d9713b3b0 ("mm: batch-zap large anonymous folio PTE mappings")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/linux-mm/20230726161942.GA1123863@dev-arch.thelio-3990X/
> ---
> 
> Hi Andrew,
> 
> This fixes patch 3 in the series at [1], which is currently in mm-unstable. I'm
> not sure whether you want to take the fix or whether I should re-post the entire
> series?
> 

Please repost the complete thing, you're touching some sensible places 
that really need decent review.


-- 
Cheers,

David / dhildenb

