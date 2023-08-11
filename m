Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD25D77932F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjHKPda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjHKPd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4734F30CD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691767962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KoDQPpSBax1LLhCBa7z0nPjBBUXe32UXUur+MUFne6M=;
        b=gVg8FU4wrZz5vKRFIP44UDenWuZNk9k3Nco1hIrmFjpNKCS0+j4gPEjxVigxcZ/svcWnrb
        aut8JlDKLbAD2DKaF1tbhD+D4cKMnzPFWbd7A209l2xLDb+pN4VLhLdYm0lYLziK6uUA8u
        iQEYJ5SReeIjbxFVqVLlzHM9Ou+cmY8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-RAt6i1PUM925nSx1OJqzqg-1; Fri, 11 Aug 2023 11:32:40 -0400
X-MC-Unique: RAt6i1PUM925nSx1OJqzqg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe73990c03so12885935e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691767959; x=1692372759;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KoDQPpSBax1LLhCBa7z0nPjBBUXe32UXUur+MUFne6M=;
        b=O/JnlXoSpAyxH4JAONf1NREavPjo7ZzWK3N32ljR83S2NZCApYyZPz7KwDeWf1xBOC
         VzFmrBubwjEktR56H0RiG8UTXnt97htxZeQlCqIQw70+LFCaFSEl28DOPASFK4O7dmoG
         dBwTg/gT1Q9hq2sVrzuPYyaUW2AEjOP8PJRvb5zrt+Y8vLU+Oy4GI4kCog06HSgyjHgL
         rpzACAkF84y8D5hvVQQtJZRsOiYitbkjQuWZfpvmrACDuNlrTiJ1+yuwVp29HU0p3FBq
         wwEocZT1VUE+YAuMA09H0HZcmJHi4CQ/jcWPMrFh336SiSPqdeIwwVytAOFXztyZRnL3
         MSEA==
X-Gm-Message-State: AOJu0Ywu2iERcECMJFVO4AJYAtfm/VuqgN0g2vs/2vH/ou4AgfPK6COr
        Az26VG+X3ThXS+MLD28JLlxf4gt3YFRDTr8GKdhy/xtGo2vgqdLNr2PJj04IJOYZbbIv0iPlMEW
        1+LjfBBnlg0r7G7Y/M48G4oFY
X-Received: by 2002:a05:600c:218:b0:3fb:b5dc:dab1 with SMTP id 24-20020a05600c021800b003fbb5dcdab1mr1936905wmi.39.1691767959738;
        Fri, 11 Aug 2023 08:32:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0EQWQte4L/bLxPKHwjW9vvzlkJLxja3udxYBIo62C9T+VFPb8pcxrqoMMS3wLa3JyEqeDNQ==
X-Received: by 2002:a05:600c:218:b0:3fb:b5dc:dab1 with SMTP id 24-20020a05600c021800b003fbb5dcdab1mr1936889wmi.39.1691767959410;
        Fri, 11 Aug 2023 08:32:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:3000:973c:c367:3012:8b20? (p200300cbc71a3000973cc36730128b20.dip0.t-ipconnect.de. [2003:cb:c71a:3000:973c:c367:3012:8b20])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d6641000000b00314367cf43asm5762156wrw.106.2023.08.11.08.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 08:32:38 -0700 (PDT)
Message-ID: <b001adf2-238d-1708-673d-6f512a53e1e9@redhat.com>
Date:   Fri, 11 Aug 2023 17:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
References: <20230809083256.699513-1-david@redhat.com> <ZNQD4pxo8svpGmvX@x1n>
 <e5e29217-11d3-a84b-9e29-44acc72222f3@redhat.com>
 <155bd03e-b75c-4d2d-a89d-a12271ada71b@arm.com> <ZNUbNDiciFefJngZ@x1n>
 <db3c4d94-a0a9-6703-6fe0-e1b8851e531f@redhat.com> <ZNVPJ9xxd2oarR3I@x1n>
 <ZNVbObUGbos73ZJ5@casper.infradead.org>
 <8222bf8f-6b99-58f4-92cc-44113b151d14@redhat.com> <ZNZRTmvkAlm4yeAd@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
In-Reply-To: <ZNZRTmvkAlm4yeAd@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.23 17:18, Peter Xu wrote:
> On Fri, Aug 11, 2023 at 12:27:13AM +0200, David Hildenbrand wrote:
>> On 10.08.23 23:48, Matthew Wilcox wrote:
>>> On Thu, Aug 10, 2023 at 04:57:11PM -0400, Peter Xu wrote:
>>>> AFAICS if that patch was all correct (while I'm not yet sure..), you can
>>>> actually fit your new total mapcount field into page 1 so even avoid the
>>>> extra cacheline access.  You can have a look: the trick is refcount for
>>>> tail page 1 is still seems to be free on 32 bits (if that was your worry
>>>> before).  Then it'll be very nice if to keep Hugh's counter all in tail 1.
>>>
>>> No, refcount must be 0 on all tail pages.  We rely on this in many places
>>> in the MM.
>>
>> Very right.
> 
> Obviously I could have missed this in the past.. can I ask for an example
> explaining why refcount will be referenced before knowing it's a head?

I think the issue is, when coming from a PFN walker (or GUP-fast), you 
might see "oh, this is a folio, let's lookup the head page". And you do 
that.

Then, you try taking a reference on that head page. (see try_get_folio()).

But as you didn't hold a reference on the folio yet, it can happily get 
freed + repurposed in the meantime, so maybe it's not a head page anymore.

So if the field would get reused for something else, grabbing a 
reference would corrupt whatever is now stored in there.

-- 
Cheers,

David / dhildenb

