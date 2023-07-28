Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5127676A3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbjG1TxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjG1TxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D964211
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 12:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690573938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2+ypDVV6dSVwbKJr16uhr2IJ9r+AwX9x8+Z/cyB1F4=;
        b=eM3osuXt31FQldwUmW8voIFwRIutCqCZZFBM0U+xFjo95Nk3ZljvmVfByA65KAFBMJkeFU
        Aq9IkybAS2UKeKcSPOE2Jk+Z0UkIoHu9bmgG3j6fIIUcpQKyZZ7h8zCEdGx0hsS08AafbV
        DgLiBkKpgIXb40n9mEKzZxNHMmfk3UY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-WYWSO5c5OReO_7_9xYjedA-1; Fri, 28 Jul 2023 15:52:14 -0400
X-MC-Unique: WYWSO5c5OReO_7_9xYjedA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3178532c6c8so979535f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 12:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690573933; x=1691178733;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2+ypDVV6dSVwbKJr16uhr2IJ9r+AwX9x8+Z/cyB1F4=;
        b=Sf4QujHE2ZIPELWJwGkiHuk7baAc688S7+TyjCqvAC6SgZcF+qwLS0EQ6IZSgBNI7A
         wZDRT7l+k0yF0kjdueWB/TvdbY1+1/aCAsQq8zuaWgE1oi21PzPcPplA8OpE4frOIV1R
         T0XTKUZWdZhoT4hND84TmZTP4wtu+OrS221B9ELqOSLfpu0OtJq5Xu3LcqRPVyoG62ZO
         F6TX6nXnYUYOP2PqxyRZeZxoCBMGXmtzMC9e0VQcyWZcFyyqbrpuAxvl9/vGYykMuB/+
         btzB3HXAwOL89W9hablAxlG5BZb10OAagFyUSjQK8hYPwlDST9jlbBIUuoCIpoRmjrCO
         a80g==
X-Gm-Message-State: ABy/qLavyosV/zjsns0C8zzgu6zSZaCwfniAT0MRJ9nWB2n4y2SUJz5I
        PilFQ51gHO55mJgDeTf6bKOejTFkY1ms2+URanTF1VT3SHrA4J+Vy97yJUjKrZWLgGpoXMvyVK9
        NylZM3x5a+O93Ky6kpzvLtXsM
X-Received: by 2002:a5d:6849:0:b0:313:f347:eea0 with SMTP id o9-20020a5d6849000000b00313f347eea0mr2595039wrw.60.1690573933539;
        Fri, 28 Jul 2023 12:52:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFnzwP4B5xQQLlK2sKSIchVUYqrHrpepiG7G8Hpg27lW/ADY4pc3Ao/iX95LwenFmTIWkhgqA==
X-Received: by 2002:a5d:6849:0:b0:313:f347:eea0 with SMTP id o9-20020a5d6849000000b00313f347eea0mr2595023wrw.60.1690573933205;
        Fri, 28 Jul 2023 12:52:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:6b00:bf49:f14b:380d:f871? (p200300cbc7066b00bf49f14b380df871.dip0.t-ipconnect.de. [2003:cb:c706:6b00:bf49:f14b:380d:f871])
        by smtp.gmail.com with ESMTPSA id o12-20020adfcf0c000000b00301a351a8d6sm5544158wrj.84.2023.07.28.12.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 12:52:12 -0700 (PDT)
Message-ID: <aab2cb18-67e1-e55b-57e0-7e0ac90f3da3@redhat.com>
Date:   Fri, 28 Jul 2023 21:52:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <ZMQZfn/hUURmfqWN@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZMQZfn/hUURmfqWN@x1n>
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

On 28.07.23 21:39, Peter Xu wrote:
> Hi, Linus,
> 
> On Fri, Jul 28, 2023 at 09:18:45AM -0700, Linus Torvalds wrote:
>> The original reason for FOLL_NUMA simply does not exist any more. We
>> know exactly when a page is marked for NUMA faulting, and we should
>> simply *ignore* it for GUP and follow_page().
>>
>> I think we should treat a NUMA-faulting page as just being present
>> (and not NUMA-fault it).
> 
> But then does it means that any gup-only user will have numa balancing
> completely disabled?  Since as long as the page will only be accessed by
> GUP, the numa balancing will never trigger anyway..  I think KVM is
> manipulating guest pages just like that.  Not sure whether it means it'll
> void the whole numa effort there.
> 
> If we allow that GUP from happening (taking protnone as present) I assume
> it'll also stop any further numa balancing on this very page to trigger
> too, because even if some page fault handler triggered on this protnone
> page later that is not GUP anymore, when it wants to migrate the page to
> the other numa node it'll see someone is holding a reference on it already,
> and then we should give up the balancing.
> 
> So to me FOLL_NUMA (or any identifier like it.. just to describe the
> caller's need; some may really just want to fetch the pfn/page) still makes
> sense.  But maybe I totally misunderstood above..

Yes, I agree, took me a bit longer to realize (being a KVM developer :) 
... I'm really ready for the weekend).

So if this series is not acceptable then better revert that commit -- or 
let callers like KVM specify FOLL_NUMA.

-- 
Cheers,

David / dhildenb

