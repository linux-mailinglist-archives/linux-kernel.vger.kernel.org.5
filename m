Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32AA784582
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbjHVP27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjHVP26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D77DCD1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692718092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W7u/YZ/Wut0bLQVB3sIyShhombPvduPeoIFrUf/4TCs=;
        b=UdPc4Pft9tipryYd0mHz+CP5mHtw1szhDDDnThMMLOrsyCosvre7TGmhWB11sVjKWrIER6
        RQ6no4YTxzZstwj3dpviSeCwOs5Ah4bk5/OB5bgc/wPfDAiqt//I4P785NVXJLyOY7GMUs
        BiVbqd7k79hzFEkiEBTNjFJp2Vmd+es=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-0srHqEbeMZS16EGzljkElw-1; Tue, 22 Aug 2023 11:28:11 -0400
X-MC-Unique: 0srHqEbeMZS16EGzljkElw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31ad607d383so2943011f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718090; x=1693322890;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7u/YZ/Wut0bLQVB3sIyShhombPvduPeoIFrUf/4TCs=;
        b=gyaUL2yRQsCeeQbGz3uPYrazI/bjsGEjmnpKeiBVRHfbcQEu9G2pkE1mk/ckMQwLT8
         hi7ajEGKW8Ros8bpKp3Kod9UpcN2ir5i6Tr5C5P2mepYJorVkTMviosC1xrd0R5vtua0
         95jCV7xiL1lPlbNEdI43juuPTlqQbdRVY3+/D1nQWJartMIU4sv/JoaA98IHYvpQDsJN
         DSNsoNueTe+GyCnI+zbfIE2vZcA22Q/eaOJtMnOcirvApCugsfFSol9PQokIInmDlJeZ
         AeLaO8j33PC2UGMJxTdErCJ1THr/pkC8WlYEmWd5OH79SUO0tLNQdRC9m+f4tjp3FohG
         EX1g==
X-Gm-Message-State: AOJu0YwOuGjZzYIGk66Jeu+KDYoPTWxWmx9i0Cf+lwziz9IXeAK/wGQR
        Zk7rdJW85ns5G8WeKfL8j1rLvANVpsYXxXxF06EhKu/L+jqpLSbGzAIlzC2oweUKN7zTKYgv9wX
        m+JRRHpsxUOdTOMUTeC6HLhr5
X-Received: by 2002:a5d:684b:0:b0:317:597b:9f92 with SMTP id o11-20020a5d684b000000b00317597b9f92mr7482709wrw.57.1692718089918;
        Tue, 22 Aug 2023 08:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhmcY7QpIcuWsmvQMDNEnSwssc+JVnL70SZ7OEjsgpDCceuGn/p5O/9IhA+49A189R7TloOg==
X-Received: by 2002:a5d:684b:0:b0:317:597b:9f92 with SMTP id o11-20020a5d684b000000b00317597b9f92mr7482669wrw.57.1692718089535;
        Tue, 22 Aug 2023 08:28:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:7400:83da:ebad:ba7f:c97c? (p200300cbc706740083daebadba7fc97c.dip0.t-ipconnect.de. [2003:cb:c706:7400:83da:ebad:ba7f:c97c])
        by smtp.gmail.com with ESMTPSA id d4-20020adffd84000000b003141f96ed36sm16156605wrr.0.2023.08.22.08.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 08:28:09 -0700 (PDT)
Message-ID: <ae86ecd2-08b9-1865-ad80-591cb4f4d83f@redhat.com>
Date:   Tue, 22 Aug 2023 17:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH mm-unstable] mm/khugepaged: fix collapse_pte_mapped_thp()
 versus uffd
Content-Language: en-US
To:     Jann Horn <jannh@google.com>, Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <4d31abf5-56c0-9f3d-d12f-c9317936691@google.com>
 <CAG48ez1XAePj5MUG8AUmnTjRLcxKre-NGYV82kB68-X8Rh6fxA@mail.gmail.com>
 <f2dc6d6b-c516-932-1598-a58e2afffe9a@google.com>
 <CAG48ez0S-RjAapaDiJ+oZXpn1vs9niWx54iqzusUScS-BYu0hw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAG48ez0S-RjAapaDiJ+oZXpn1vs9niWx54iqzusUScS-BYu0hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.23 16:39, Jann Horn wrote:
> On Tue, Aug 22, 2023 at 4:51 AM Hugh Dickins <hughd@google.com> wrote:
>> On Mon, 21 Aug 2023, Jann Horn wrote:
>>> On Mon, Aug 21, 2023 at 9:51 PM Hugh Dickins <hughd@google.com> wrote:
>>>> Just for this case, take the pmd_lock() two steps earlier: not because
>>>> it gives any protection against this case itself, but because ptlock
>>>> nests inside it, and it's the dropping of ptlock which let the bug in.
>>>> In other cases, continue to minimize the pmd_lock() hold time.
>>>
>>> Special-casing userfaultfd like this makes me a bit uncomfortable; but
>>> I also can't find anything other than userfaultfd that would insert
>>> pages into regions that are khugepaged-compatible, so I guess this
>>> works?
>>
>> I'm as sure as I can be that it's solely because userfaultfd breaks
>> the usual rules here (and in fairness, IIRC Andrea did ask my permission
>> before making it behave that way on shmem, COWing without a source page).
>>
>> Perhaps something else will want that same behaviour in future (it's
>> tempting, but difficult to guarantee correctness); for now, it is just
>> userfaultfd (but by saying "_armed" rather than "_missing", I'm half-
>> expecting uffd to add more such exceptional modes in future).
> 
> Hm, yeah, sounds okay. (I guess we'd also run into this if we ever
> wanted to make it possible to reliably install PTE markers with
> madvise() or something like that, which might be nice for allowing
> userspace to create guard pages without unnecessary extra VMAs...)

I'm working on something similar that goes a bit further than just guard 
pages. It also installs PTE markers into page tables, inside existing 
large VMAs.

Initially, I'll only tackle anon VMAs, though.

-- 
Cheers,

David / dhildenb

