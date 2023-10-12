Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4F57C680C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbjJLIeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjJLId7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:33:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767F290
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697099593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tFBAaGNNwzUAKJQrwPFimGzTzmH3Y9stjQwEsidNPuk=;
        b=adpdRol50FtXPSQ3ysNjngV9wRQnZc0WAUF5kznO/aaJJIU5Y+D1fhiEuRXlxbP2Cs/Ypb
        p+JEu1DKguFxRhRf6kMhGsEMjcLCunATtqKeS1DMrB4uWS/qHaenDjzQyOIqujPx3G4wjP
        jn0diXV3Kv0RbKiIoHYXGk4wszLJEgw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-O8AzaZEUOteEtuRhPBFsew-1; Thu, 12 Oct 2023 04:33:07 -0400
X-MC-Unique: O8AzaZEUOteEtuRhPBFsew-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c038a1e2f6so6983481fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697099586; x=1697704386;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFBAaGNNwzUAKJQrwPFimGzTzmH3Y9stjQwEsidNPuk=;
        b=BcKdQ0VDlL9WwgnZ/whXoi2YK4jYD+KUJyuPqO4i63OSt6/nF68zOs6wszAxZRAm7d
         T2p9gEcQYy9BIARXTbBqeQFNeNUZKYwFhDjTLnBP21ZfZoU7+5Mw2fFL7CSm5rC5hf3q
         fBmOhecWr+LdCiAX3Iwf2X+FN3JOrupvpJsGCpRk2BlRhf6Pz8wVvuX1Pffc2H3BztZP
         nTK8QE8+SyhTVR2kNj+ea+8yXnLgUnxmkg2ftv+W6chwQUSCT37h+uZ1uzwmrHfQpF2H
         GJLXP4AJLEKKEZfzPzsFFoS0gyzPcwCy6Pg2tIHWwiRwnHnGB11W7CI+zZ+3geWpOEBc
         44hQ==
X-Gm-Message-State: AOJu0Yz8+/GyLl5OmWlrFjQHo4wzJo53XJ+y8nM1kADgFbqpVx71h9sz
        TX4Obe8/p9hIKXvq7jC0Gzc+Z03sU6iuADrAjnqVlkaN6j/zqSteQFFM/lIZEsWkrZKD4tYSit9
        cAZoirzlb2ekpthIFUarVZ8pd
X-Received: by 2002:a05:651c:88:b0:2bc:dd96:147c with SMTP id 8-20020a05651c008800b002bcdd96147cmr20352126ljq.34.1697099585841;
        Thu, 12 Oct 2023 01:33:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEP/yCsuTBbRW2UBpXpRJ1WBj8Tdvm+xry9N5pYzpQmfCztnp1gPgIReFyNmdzNKrkEmmgEw==
X-Received: by 2002:a05:651c:88:b0:2bc:dd96:147c with SMTP id 8-20020a05651c008800b002bcdd96147cmr20352104ljq.34.1697099585471;
        Thu, 12 Oct 2023 01:33:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:ee00:b271:fb6c:a931:4769? (p200300cbc70dee00b271fb6ca9314769.dip0.t-ipconnect.de. [2003:cb:c70d:ee00:b271:fb6c:a931:4769])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003feea62440bsm18837414wmi.43.2023.10.12.01.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 01:33:05 -0700 (PDT)
Message-ID: <63d119f7-5adb-861a-00c2-69a92b19ef9b@redhat.com>
Date:   Thu, 12 Oct 2023 10:33:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 0/5] mm, kpageflags: support folio and fix output for
 compound pages
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20231010142801.3780917-1-naoya.horiguchi@linux.dev>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20231010142801.3780917-1-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.10.23 16:27, Naoya Horiguchi wrote:
> Hi everyone,
> 
> This patchset addresses 2 issues in /proc/kpageflags.
> 
>    1. We can't easily tell folio from thp, because currently both pages are
>       judged as thp, and
>    2. we see some garbage data in records of compound tail pages because
>       we use tail pages to store some internal data.
> 
> These issues require userspace programs to do additional work to understand
> the page status, which makes situation more complicated.
> 
> This patchset tries to solve these by defining KPF_FOLIO for issue 1., and
> by hiding part of page flag info on tail pages of compound pages for issue 2.
> 
> I think that technically some compound pages like thp/hugetlb/slab could be
> considered as folio, but in this version KPF_FOLIO is set only on folios

At least thp+hugetlb are most certainly folios. Regarding slab, I 
suspect we no longer call them folios (cannot be mapped to user space). 
But Im not sure about the type hierarchy.

> in pagecache (so "folios in narrower meaning").  I'm not confident about
> this choice, so if you have any idea about this, please let me know.

It does sound inconsistent. What exactly do you want to tell user space 
with the new flag?

-- 
Cheers,

David / dhildenb

