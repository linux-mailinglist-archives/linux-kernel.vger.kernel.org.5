Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AF57F9BF5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjK0Img (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjK0Ime (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:42:34 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A85B8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:42:40 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cfafe3d46bso16997625ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701074560; x=1701679360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7ud2f7/LRWS8b7jsTlmNHZSCAPClBeQfNhzDqsVBoE=;
        b=BjI9HlXSXYW68RCUj8t97pWOIQT4m5Vwfm97/oy4jzUMWoJ5UlccYkKuwbaMaBWDYs
         1/TwMbjXe/CBTox7i8MPtFE8a22y7Gh6Ocwuh1+EFXHnINk3uFfcvEhGhj976w5JMXhp
         owiccDhIBEFJYdpEUOTMxrlkFONkNcN+aXk2Zse67HRNr3ktMM7Fd2/NohcxPefzcHyC
         VhlgS3trRWyEKCden6r2PA57lnY6P36QmCcz4h36WAPYwFf+4FrwVKiVVTdsl+43w1Rs
         uI1fposNt1XST00KZwbmPS7gJ9eDcTkOM9tiCl8MNcsQTdIm7lAQHXVl01S8M4FcMU1/
         yyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701074560; x=1701679360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7ud2f7/LRWS8b7jsTlmNHZSCAPClBeQfNhzDqsVBoE=;
        b=HH0/V7wB+oeiw18rUVI0HeAPeJRo7UdqlSy0N+48km7xrKm5NlfxSdSINcmC4PCjEs
         AoQxS+LLq/E7VqiKawYXWKBpqirGlojCHsjQtebEwHMIVGQeh10Mfk+hIA/pNxF8yLao
         CRUg+M6EixrZPoheHPPQZU50uIfmmWUCQxiUjFowvIWUBxqN2qJu7AD3NcHP5rOrx2Dk
         ouYBoSC+MuaZjGi9biM3sV4g7OSqLvS6zxW08fDOEsEDAHH1JI+48hsaAhe82ZEHntp5
         AygvFFrVBClEAQqr8KhinAI1/YhrlJPvEHXioF+oQ1DsKhEBrMbCBCnEAI0NA3wlrfzp
         5PTg==
X-Gm-Message-State: AOJu0YwFR8afzdQwO+htmo2rqHBFjiE0l5ynkgwG5Fm34WpsZt3qxUJU
        ciMHUDF6GjQxjxOyzX0IOeA=
X-Google-Smtp-Source: AGHT+IGrwraFKHVCYi3flUo0orxhlZuJgUKXarA9T/+/eeDuqCOql6b/utXko+5LzdDUaLcbfwdK8g==
X-Received: by 2002:a17:90a:195e:b0:285:2d62:84c4 with SMTP id 30-20020a17090a195e00b002852d6284c4mr12413569pjh.29.1701074559970;
        Mon, 27 Nov 2023 00:42:39 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:19a0:3eee:b37f:15f2])
        by smtp.gmail.com with ESMTPSA id mp21-20020a17090b191500b002801ca4fad2sm7276883pjb.10.2023.11.27.00.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 00:42:39 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To:     david@redhat.com
Cc:     akpm@linux-foundation.org, andreyknvl@gmail.com,
        anshuman.khandual@arm.com, ardb@kernel.org,
        catalin.marinas@arm.com, dvyukov@google.com, glider@google.com,
        james.morse@arm.com, jhubbard@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mark.rutland@arm.com, maz@kernel.org,
        oliver.upton@linux.dev, ryabinin.a.a@gmail.com,
        ryan.roberts@arm.com, suzuki.poulose@arm.com,
        vincenzo.frascino@arm.com, wangkefeng.wang@huawei.com,
        will@kernel.org, willy@infradead.org, yuzenghui@huawei.com,
        yuzhao@google.com, ziy@nvidia.com
Subject: Re: Re: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
Date:   Mon, 27 Nov 2023 21:42:17 +1300
Message-Id: <20231127084217.13110-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <271f1e98-6217-4b40-bae0-0ac9fe5851cb@redhat.com>
References: <271f1e98-6217-4b40-bae0-0ac9fe5851cb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +		for (i = 0; i < nr; i++, page++) {
>> +			if (anon) {
>> +				/*
>> +				 * If this page may have been pinned by the
>> +				 * parent process, copy the page immediately for
>> +				 * the child so that we'll always guarantee the
>> +				 * pinned page won't be randomly replaced in the
>> +				 * future.
>> +				 */
>> +				if (unlikely(page_try_dup_anon_rmap(
>> +						page, false, src_vma))) {
>> +					if (i != 0)
>> +						break;
>> +					/* Page may be pinned, we have to copy. */
>> +					return copy_present_page(
>> +						dst_vma, src_vma, dst_pte,
>> +						src_pte, addr, rss, prealloc,
>> +						page);
>> +				}
>> +				rss[MM_ANONPAGES]++;
>> +				VM_BUG_ON(PageAnonExclusive(page));
>> +			} else {
>> +				page_dup_file_rmap(page, false);
>> +				rss[mm_counter_file(page)]++;
>> +			}
>>   		}
>> -		rss[MM_ANONPAGES]++;
>> -	} else if (page) {
>> -		folio_get(folio);
>> -		page_dup_file_rmap(page, false);
>> -		rss[mm_counter_file(page)]++;
>> +
>> +		nr = i;
>> +		folio_ref_add(folio, nr);
> 
> You're changing the order of mapcount vs. refcount increment. Don't. 
> Make sure your refcount >= mapcount.
> 
> You can do that easily by doing the folio_ref_add(folio, nr) first and 
> then decrementing in case of error accordingly. Errors due to pinned 
> pages are the corner case.
> 
> I'll note that it will make a lot of sense to have batch variants of 
> page_try_dup_anon_rmap() and page_dup_file_rmap().
> 

i still don't understand why it is not a entire map+1, but an increment
in each basepage.

as long as it is a CONTPTE large folio, there is no much difference with
PMD-mapped large folio. it has all the chance to be DoubleMap and need
split.

When A and B share a CONTPTE large folio, we do madvise(DONTNEED) or any
similar things on a part of the large folio in process A,

this large folio will have partially mapped subpage in A (all CONTPE bits
in all subpages need to be removed though we only unmap a part of the
large folioas HW requires consistent CONTPTEs); and it has entire map in
process B(all PTEs are still CONPTES in process B).

isn't it more sensible for this large folios to have entire_map = 0(for
process B), and subpages which are still mapped in process A has map_count
=0? (start from -1).

> Especially, the batch variant of page_try_dup_anon_rmap() would only 
> check once if the folio maybe pinned, and in that case, you can simply 
> drop all references again. So you either have all or no ptes to process, 
> which makes that code easier.
> 
> But that can be added on top, and I'll happily do that.
> 
> -- 
> Cheers,
> 
> David / dhildenb

Thanks
Barry

