Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDD27792B3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbjHKPRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjHKPRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62F030CA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691767026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PjgG9L91w6qmgYTaep8DhZMo3htJ0LqTmmQ9RNCiHlc=;
        b=VLXGnaAriwKbQTjUfvQpR9xwZjvhSSQlsAoyJatTgBjP+fpy+gOhoj1htup+r26dSEEEgU
        5OQHqz7+n/t9DjyKjHvECh0CgC+ZBIxNq9frV+GgCpoEdKbwRmE8SVB2crffCGb5mAAsvV
        FZtbqfzqzHovT+uI8jHHyf9ApRxJmO0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-qRXN3q3lMzqesEny0Udkbw-1; Fri, 11 Aug 2023 11:17:05 -0400
X-MC-Unique: qRXN3q3lMzqesEny0Udkbw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-315af0252c2so1262685f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691767024; x=1692371824;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PjgG9L91w6qmgYTaep8DhZMo3htJ0LqTmmQ9RNCiHlc=;
        b=FVEV1zEzk+wMPfuYKCqXAMVF2UHZ1Db3V/bnzxE2TVydiICEIUHCo1Y1IPxYWsz5wf
         Zujg5vYmJ1rP5eum6dVI5a+OXOlfx7EeQ+PaY9EKiJGrH1dADy7hgBtF07/zppXZc1tJ
         uIPJ5OJ1Df7QvLVA3b2RRo/JMrVsNQ86hBtxMc62fEZP5s4FZTie4ovjsF6eyPijiUEu
         HhuZN2cKoiGRdXunFkHFyMQDd/iTRH2l7tkwkm4IsUIh7m3cOkcTfRO9xCYa2Ria2YCF
         TWnYVcL4FAC8CdcMDNmuS27Txj/E7m3rY8yfvHiElaLLGsGI35mFTzZ+veOLA8EZF6WP
         vbtw==
X-Gm-Message-State: AOJu0YxEspEye0gljOIrM/LIGUDWIhXoTBE06OevFsh0SYDwmkPyYoQz
        ZqplzvE+8Z+Tn8TjNnsHlmvUl31nOyyU29qXgc3Xn32vcDza4nsts9JbEP9QOMhqXVFO9V9gS5F
        hZqaJlSVgsxcLf+48Sfxog5Cn
X-Received: by 2002:a5d:4531:0:b0:317:6704:72c with SMTP id j17-20020a5d4531000000b003176704072cmr1630646wra.52.1691767024290;
        Fri, 11 Aug 2023 08:17:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN1l577HlgGm3un1BlQaTqy0RuKhYqAZhoovVJzfygHufzHFUri/fMA0KPEcJFIcvnnaU5TQ==
X-Received: by 2002:a5d:4531:0:b0:317:6704:72c with SMTP id j17-20020a5d4531000000b003176704072cmr1630623wra.52.1691767023758;
        Fri, 11 Aug 2023 08:17:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:3000:973c:c367:3012:8b20? (p200300cbc71a3000973cc36730128b20.dip0.t-ipconnect.de. [2003:cb:c71a:3000:973c:c367:3012:8b20])
        by smtp.gmail.com with ESMTPSA id e1-20020adfe381000000b003140f47224csm5739246wrm.15.2023.08.11.08.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 08:17:03 -0700 (PDT)
Message-ID: <50ba595b-d992-cadf-9064-6b99347fa348@redhat.com>
Date:   Fri, 11 Aug 2023 17:17:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
References: <20230809083256.699513-1-david@redhat.com> <ZNQD4pxo8svpGmvX@x1n>
 <ZNRYx8GhYftE4Xeb@casper.infradead.org>
 <7e31254d-8889-7e79-50e1-2630bd493d59@redhat.com> <ZNVbIyHcqeKUDuSg@x1n>
 <ZNVcfdH8+N5Q83J/@casper.infradead.org>
 <73d6d29f-9947-9b50-3b94-77f1ee547387@redhat.com> <ZNZNuooaFH9P4raS@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
In-Reply-To: <ZNZNuooaFH9P4raS@x1n>
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

On 11.08.23 17:03, Peter Xu wrote:
> On Thu, Aug 10, 2023 at 11:59:25PM +0200, David Hildenbrand wrote:
>> On 10.08.23 23:54, Matthew Wilcox wrote:
>>> On Thu, Aug 10, 2023 at 05:48:19PM -0400, Peter Xu wrote:
>>>>> Yes, that comment from Hugh primarily discusses how we could possibly
>>>>> optimize the loop, and if relying on folio_nr_pages_mapped() to reduce the
>>>>> iterations would be racy. As far as I can see, there are cases where "it
>>>>> would be certainly a bad idea" :)
>>>>
>>>> Is the race described about mapcount being changed right after it's read?
>>>> Are you aware of anything specific that will be broken, and will be fixed
>>>> with this patch?
>>>
>>> The problem is that people check the mapcount while holding no locks;
>>> not the PTL, not the page lock.  So it's an unfixable race.
>>>
>>>> Having a total mapcount does sound helpful if partial folio is common
>>>> indeed.
>>>>
>>>> I'm curious whether that'll be so common after the large anon folio work -
>>>> isn't it be sad if partial folio will be a norm?  It sounds to me that's
>>>> the case when small page sizes should be used.. and it's prone to waste?
>>>
>>> The problem is that entire_mapcount isn't really entire_mapcount.
>>> It's pmd_mapcount.  I have had thoughts about using it as entire_mapcount,
>>> but it gets gnarly when people do partial unmaps.  So the _usual_ case
>>> ends up touching every struct page.  Which sucks.  Also it's one of the
>>> things which stands in the way of shrinking struct page.
>>
>> Right, so one current idea is to have a single total_mapcount and look into
>> removing the subpage mapcounts (which will require first removing
>> _nr_pages_mapped, because that's still one of the important users).
>>
>> Until we get there, also rmap code has to do eventually "more tracking" and
>> might, unfortunately, end up slower.
>>
>>>
>>> But it's kind of annoying to explain all of this to you individually.
>>> There have been hundreds of emails about it over the last months on
>>> this mailing list.  It would be nice if you could catch up instead of
>>> jumping in.
>>
>> To be fair, a lot of the details are not readily available and in the heads
>> of selected people :)
>>
>> Peter, if you're interested, we can discuss the current plans, issues and
>> ideas offline!
> 
> Thanks for offering help, David.
> 
> Personally I still am unclear yet on why entire_mapcount cannot be used as
> full-folio mapcounts, and why "partial unmap" can happen a lot (I don't
> expect), but yeah I can try to catch up to educate myself first.

Using fork() is the easiest way. mremap(), MADV_DONTNEED, munmap, ...

You might end up having to scan page tables and/or the rmap to figure 
out which mapcount to adjust, which we should absolutely avoid.


> The only issue regarding an offline sync-up is that even if David will help
> Peter on catching up the bits, it'll not scale when another Peter2 had the
> same question..  So David, rather than I waste your time on helping one
> person, let me try to catch up with the public threads - I'm not sure how
> far I can go myself;

Sure. But note that it's a moving target, and some discussions have been 
going on for a long time. I recall there were various discussions, 
including LSF/MM, mm biweekly meeting, and more. So even if you scan 
through all that, you might either get outdated or incomplete information.

-- 
Cheers,

David / dhildenb

