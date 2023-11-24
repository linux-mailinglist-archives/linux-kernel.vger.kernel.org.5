Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8F47F6F13
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345123AbjKXJCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXJCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:02:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C309F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700816536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=rXJvn1sSfUzZsfnB2WepVWx25OOFts/fLN21lSBa1qA=;
        b=XnxHnJOvTMSliK9MnsdzzTuR/mE0mhPbYdywO16nO0zxyDn4e772Mezi96PikW9yjpU8OU
        I/oVdXveB9QYr3SThqhSlKtYxFCqU5GNRJ0uR6+QevkhMCwciSe7ol1lB0whf3E1KzwQRz
        UeUYk6Fs8LJ8iflqbBvDLgR5uuUdFEA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-oVPlcrAoPnaTGFIUVOJ_YQ-1; Fri, 24 Nov 2023 04:02:14 -0500
X-MC-Unique: oVPlcrAoPnaTGFIUVOJ_YQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c8767e6074so13853121fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:02:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700816533; x=1701421333;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXJvn1sSfUzZsfnB2WepVWx25OOFts/fLN21lSBa1qA=;
        b=Ql0+miS6EpVd68ATj6OP2uuAeWPQhCOEd8oKNEZBEvov+Owlv8DC2EA/R7qTqsy37L
         KFqIycI/L6MxZAwhzGrMsVciV7l+zsX/pFCOFra+sIyzZKns5bpswP0YuEhRe5K36hW5
         QgZBpOxkRgE9aw2mET2imHXjBw+oQkM0iZakvPodZlvEd3A/lFFXuprZIsJCX7SVvnMx
         EHarvi2t1DyaD1MH5xMw/A+IyBy1bAq0RZWtIxkIAStwcfxscOD0JHsMK7sVrBaouMG/
         GEA52/ZUuu7ZAgv/cPTS/Wn4GyvVbrraoEAhtpFmAOZJn4aPX1dg3L/t9BB0glEEys3F
         JK9w==
X-Gm-Message-State: AOJu0Yzu/41/CIwk+0DHKaLd2yGxLUGO+waVNMAUyBf8ZRzyhlbr7x2E
        iQEp6pE2MINSt4Mv0f3WRBVf+rVHFqD0gyN0mbA+lSuVuHssBfZ3QhvM9c4CqNnaSkZ4R1fU9dh
        /NdTusxk19ItOKlxeQSm4ye7g
X-Received: by 2002:a05:651c:104d:b0:2c5:3b1:c084 with SMTP id x13-20020a05651c104d00b002c503b1c084mr1310092ljm.42.1700816532734;
        Fri, 24 Nov 2023 01:02:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwViDwrLjEKVfH7oqW89QvgTZMHYfht5S+/OaXAifqULppzGsunNf3SN6A2T+A5A4P0kS+RQ==
X-Received: by 2002:a05:651c:104d:b0:2c5:3b1:c084 with SMTP id x13-20020a05651c104d00b002c503b1c084mr1310058ljm.42.1700816532326;
        Fri, 24 Nov 2023 01:02:12 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:a000:7426:f6b4:82a3:c6ab? (p200300cbc721a0007426f6b482a3c6ab.dip0.t-ipconnect.de. [2003:cb:c721:a000:7426:f6b4:82a3:c6ab])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b0040a507f546fsm5198631wmq.8.2023.11.24.01.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 01:02:11 -0800 (PST)
Message-ID: <659f0f6b-0fe2-4238-a6ae-5fd310c1a4ba@redhat.com>
Date:   Fri, 24 Nov 2023 10:02:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <ZV9267tQEhoPzCru@casper.infradead.org>
 <7f76ee6c-f0e6-443b-bcff-3637895dec66@redhat.com>
 <ZV97RO3i02+NmwD2@casper.infradead.org>
 <7d4efbe8-5690-4db0-be06-399353679982@redhat.com>
 <F516C7FB-3B40-421B-B0DA-E865806EE6B9@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <F516C7FB-3B40-421B-B0DA-E865806EE6B9@nvidia.com>
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

>> So we're really only concerned about:
>> * AnonHugePages
>> * ShmemHugePages
>> * FileHugePages
>>
>> The question is if we really want to continue extending/adjusting the old meminfo interfaces and talk about how to perform accounting there.
>>
>> Because, as we learned, we might get a new file-based sysfs based interface, because Greg seems to be against exposing new values in the old single-file-based one.
> 
> I am not aware of this. And it is interesting. Do you have a pointer?

Sure:

https://lore.kernel.org/all/2023110216-labrador-neurosis-1e6e@gregkh/T/#u

> 
>>
>> In a new one, we have all freedom to expose what we actually want nowadays, and can just document that the old interface was designed with the assumption that there is only a single THP size.
> 
> This sounds like a good strategy and hopefully we could design the new THP interface
> more future proof.

Yes!

-- 
Cheers,

David / dhildenb

