Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510E27F6EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345077AbjKXIxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXIxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:53:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA5BD6C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700815986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=C0uThSC2gC58N9U//RIaOcD+b/ew24OBZ71JniQGulA=;
        b=XJDeSRn1kOMFa3/ESrFTC94yuJHZEZiJ35zmh9YJoU38kGndFdAg7oDq6p56xWgHX0WA1o
        mBkJGyEibprmPLQq5HMdpYmXzExrPz6IoFr2+9Fp4Q5LnqOVy5YvvpBDeXTMtRC1TktVqe
        znTyPTBbyG6gSjYPLk9f1shStvSttco=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-B80PmkD-MamngFJBt5I85A-1; Fri, 24 Nov 2023 03:53:04 -0500
X-MC-Unique: B80PmkD-MamngFJBt5I85A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-332dfb08436so819684f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700815984; x=1701420784;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0uThSC2gC58N9U//RIaOcD+b/ew24OBZ71JniQGulA=;
        b=TcUuuwosvmAH8Ulw2TXlkY9dWeuHorPuyc5ZoQL8er3P7i6jA6QsCd/EplBTIpFOWs
         EsQ52IsE5+lfDju0NHG5IlnbhXt26N7RKdzquLq2hbXqQ229njPmEMR11wOJpLja0SSB
         f5nQfZ0Bo3OVZYbyj98jNDwQz2Tz3UWNUdvjN/sK6jsMHt0Aumd4RkJPLz2681k5bqA7
         keNizaCGXhv0Lu2tKvlePyzqqj/jdsFRyFo+tZ8/pXjLGQtgsuJOPp0k9NQYY87Hvk83
         a1M/tVkzesumlCGggAW4j++z/OIKOREQ+QJefYLgQ9qYb08jEC1Z1zX+gFrNiu07UYTy
         bwMA==
X-Gm-Message-State: AOJu0Yx4jELXiQ4s7kV/Hua9IHOjuAyMvWKjrgLBAlvYVecKEww278SU
        5sVMwO7bDopdzIDkNh95DkQkUZZvaY+7MBcrNluGwmj+aM380eRgZAhmwHmxf5BXErqKPjZxi5Z
        BbbYqQLNE3l9cdIKiYjk8AnkO
X-Received: by 2002:a05:6000:12c2:b0:32d:9541:b1e3 with SMTP id l2-20020a05600012c200b0032d9541b1e3mr1762316wrx.26.1700815983784;
        Fri, 24 Nov 2023 00:53:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDys9SN22y6z1cdc82cJGIY99LADYGn7J0qL6qHbaQUqvx57Vqasvhv4lwzh4NmcDc8kneOg==
X-Received: by 2002:a05:6000:12c2:b0:32d:9541:b1e3 with SMTP id l2-20020a05600012c200b0032d9541b1e3mr1762293wrx.26.1700815983344;
        Fri, 24 Nov 2023 00:53:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:a000:7426:f6b4:82a3:c6ab? (p200300cbc721a0007426f6b482a3c6ab.dip0.t-ipconnect.de. [2003:cb:c721:a000:7426:f6b4:82a3:c6ab])
        by smtp.gmail.com with ESMTPSA id k24-20020a5d5258000000b00332c0aace23sm3722896wrc.105.2023.11.24.00.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 00:53:02 -0800 (PST)
Message-ID: <1fb403e1-58f0-414c-be36-4872bc0ac0ae@redhat.com>
Date:   Fri, 24 Nov 2023 09:53:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231115163018.1303287-2-ryan.roberts@arm.com>
 <89a9fe07-a5c5-4a99-b588-e6145053c58f@redhat.com>
 <1459f78b-e80c-4f21-bc65-f0ab259d348a@arm.com>
 <08ef2c36-2b9c-4b96-9d1d-68cca0f68ba5@redhat.com>
 <2d027a8d-adfb-481d-89ea-c99139e669aa@arm.com>
 <2618b024-6a95-4bfc-a08d-59d86e9931e5@redhat.com>
 <d639ab17-8f6b-438d-bdcd-91924185b462@redhat.com>
 <118eb2d3-d504-49f0-b7f2-f29b64a8f404@arm.com>
 <15e2c6cb-e86d-417b-b83d-7c7459d5be8f@redhat.com>
 <42f9e03f-86ad-418e-a337-7aef202e6a5b@arm.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <42f9e03f-86ad-418e-a337-7aef202e6a5b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> One could simply skip batching for now on pte_protnone() and focus on the
>> "writable" vs. "not-writable".
> 
> I'm not sure we can simply "skip" batching on pte_protnone() since we will need
> to terminate the batch if we spot it. But if we have to look for it anyway, we
> might as well just terminate the batch when the value of pte_protnone()
> *changes*. I'm also proposing to take this approach for pte_uffd_wp() which also
> needs to be carefully preserved per-pte.

Yes, that's what I meant.

-- 
Cheers,

David / dhildenb

