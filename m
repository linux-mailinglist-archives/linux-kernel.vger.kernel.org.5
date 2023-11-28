Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AD87FC2F1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345443AbjK1SSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjK1SSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:18:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4C0171D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701195520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=HxVGkUi40fD+bY8XFTsWiy5i2JO708utHgh/Nj87AWo=;
        b=EysV0TW75s9uoMOwvvxpxl6vm9MomBb7U8lo3d9WzdeBK5Jp6T8lg8mOgYFlkTKS2t5Pyq
        OSuW/Y8TX43kU97+pV56dvESQYZ5+rpVcwrAfbwPIFNP6bAhc/u9quVtok+w86NuUfR8Ib
        5No5nz0G2wsHM8tJiuBV5SOFLXHRHLU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-2gbrT06wNd-HtJyAGt3AKQ-1; Tue, 28 Nov 2023 13:18:36 -0500
X-MC-Unique: 2gbrT06wNd-HtJyAGt3AKQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c9af182fc9so14564701fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:18:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701195515; x=1701800315;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxVGkUi40fD+bY8XFTsWiy5i2JO708utHgh/Nj87AWo=;
        b=dUoPf3oohBeBHZetXprIZ04+nOU23j365e0rEMSrTKSHXsJdUwH81wDBY16hpm/9F+
         cZZeXs/kNHK7KcJZ/5IM8ZbY1s1ag2nqAAJ2vtLE0+dsWeJGG2la5f1Q4LL1xg+dfDMt
         ndh5dZ+5EI/NFAcw7l5+mZa+uI2nwXTh+kQBrlCfy6axQVR+JOUtWjqeev7hOAI9RRJh
         2d7UY/qzaigkk5bEfaa3SgRl9RYNXZvDKCoU5O1PXOPz9Ve/f6nM7SJLcbe9YefGKccM
         hwDdGW11Z1PZfnXMSYUizy1AZtFKBtJgkLWKOlOgVn3gn24pFuRVFPhcib1fxdBKVOgy
         o4Dw==
X-Gm-Message-State: AOJu0YxdEJuzbNdpTZFjVf1+LsWQlOTeJSQc9mCglHUkgm+U8Oz2NK2C
        FaDj7NRaVFEK84NIYhNMvsyHu1C0+/P75kOeFAp9fMRWAn75t/s2yKEeOg1sVhhIpbh2jQpHeYZ
        8sJQJXlCwsVtvLbSl5q0UKKlS
X-Received: by 2002:a05:651c:104e:b0:2c9:bac6:40b with SMTP id x14-20020a05651c104e00b002c9bac6040bmr584335ljm.45.1701195514933;
        Tue, 28 Nov 2023 10:18:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfihuoO6zp/heGYXNJqSIEOEGTjyplogFo+8tVPja3pZX1Oxg5QYwATpKJbY4owlZQqQ7Qew==
X-Received: by 2002:a05:651c:104e:b0:2c9:bac6:40b with SMTP id x14-20020a05651c104e00b002c9bac6040bmr584319ljm.45.1701195514512;
        Tue, 28 Nov 2023 10:18:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:1d00:99ec:9656:7475:678d? (p200300cbc7081d0099ec96567475678d.dip0.t-ipconnect.de. [2003:cb:c708:1d00:99ec:9656:7475:678d])
        by smtp.gmail.com with ESMTPSA id n8-20020a05600c3b8800b0040b398f0585sm15866120wms.9.2023.11.28.10.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 10:18:34 -0800 (PST)
Message-ID: <44729651-d762-4c11-ad70-517258821289@redhat.com>
Date:   Tue, 28 Nov 2023 19:18:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix oops when filemap_map_pmd() without prealloc_pte
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
References: <6ed0c50c-78ef-0719-b3c5-60c0c010431c@google.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6ed0c50c-78ef-0719-b3c5-60c0c010431c@google.com>
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

On 17.11.23 09:49, Hugh Dickins wrote:
> syzbot reports oops in lockdep's __lock_acquire(), called from
> __pte_offset_map_lock() called from filemap_map_pages(); or when I run
> the repro, the oops comes in pmd_install(), called from filemap_map_pmd()
> called from filemap_map_pages(), just before the __pte_offset_map_lock().
> 
> The problem is that filemap_map_pmd() has been assuming that when it
> finds pmd_none(), a page table has already been prepared in prealloc_pte;
> and indeed do_fault_around() has been careful to preallocate one there,
> when it finds pmd_none(): but what if *pmd became none in between?
> 
> My 6.6 mods in mm/khugepaged.c, avoiding mmap_lock for write, have made
> it easy for *pmd to be cleared while servicing a page fault; but even
> before those, a huge *pmd might be zapped while a fault is serviced.
> 
> The difference in symptomatic stack traces comes from the "memory model"
> in use: pmd_install() uses pmd_populate() uses page_to_pfn(): in some
> models that is strict, and will oops on the NULL prealloc_pte; in other
> models, it will construct a bogus value to be populated into *pmd, then
> __pte_offset_map_lock() oops when trying to access split ptlock pointer
> (or some other symptom in normal case of ptlock embedded not pointer).
> 
> Reported-and-tested-by: syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-mm/0000000000005e44550608a0806c@google.com/
> Link: https://lore.kernel.org/linux-mm/20231115065506.19780-1-jose.pekkarinen@foxhound.fi/
> Fixes: f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault() codepaths")


Quite an old one

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

