Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82D8756CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGQTBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjGQTBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1AC189
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689620428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JqQEOv84c+UnnDU8YvvTmNM4mFr4gaeAs15SOenXyqM=;
        b=HlrCUfOc8Ve8CXK+XwvqYBM0cmMr65M7uBW+RXzK3QIywRRz0RPd9hAoa7rYsJegdknEVX
        IzcvAwTpBR72udvfwRTFPQ3Lv0QiTWOgqWb4fnsNS7T6vMDzUvGG2VoB7tcwY6Ijfxfcfg
        3l8ezouMsEGxDuxFMsoVIalqA+PPZAc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-Gv1liU6zNbC99on9Noicpg-1; Mon, 17 Jul 2023 15:00:26 -0400
X-MC-Unique: Gv1liU6zNbC99on9Noicpg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fc020021efso28731255e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689620425; x=1692212425;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JqQEOv84c+UnnDU8YvvTmNM4mFr4gaeAs15SOenXyqM=;
        b=UUBW+Zeh2iAQ3uLyf+Kzk0oMpfcc9ggEiQf0RgjzSBCuAVZ6QH/fsrYO/32uN8TR88
         eCIKypQ0we5olWiMSn8ix3q9aRpWGitmzsDTbzQH7EYI2dhcGQia9PhuYrNcIzvPJuVZ
         MWAivMXSxJZd6G0XX3GAC5rOfAXoBnNTstK2nfb09XT2vIS8IMPn9VgmLOTr9Gi0JehO
         d8vHIQa6vDxHyWpOvcSo+EWMxhyws3/DFk7vCVykAUS30HXSTbH1VHDo6gonhOK6B8Ki
         eASAMbCtbiqFTiJ1ZF76w7isynqCEQ5OJ7W826JY0VHoUZZzcsTFHqCi4exx1Nr2nsU4
         KnDA==
X-Gm-Message-State: ABy/qLaTGHuf+LsvHlToKMpZ1I/TJbiHjWZ+YfgurEMuSvzcwKTnfV7q
        +FrpWdFPa6PAh1xPL1n+q55b47ttezt12ydCY54xdDf9SfNBGSyFxVs/e17lZ/I+Q+52QlY2LH7
        1UbwuHFqVJNlzetL1pwa4iURPXUY+taWn
X-Received: by 2002:a05:600c:ad4:b0:3fc:3f31:4233 with SMTP id c20-20020a05600c0ad400b003fc3f314233mr145963wmr.38.1689620425583;
        Mon, 17 Jul 2023 12:00:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFf33Ive8qeWcm7rG/hA2GBcrWvJPaoBhcxDMZNoii0OlusErYeFkFJ3kCybAN0sBdZ756wDw==
X-Received: by 2002:a05:600c:ad4:b0:3fc:3f31:4233 with SMTP id c20-20020a05600c0ad400b003fc3f314233mr145953wmr.38.1689620425303;
        Mon, 17 Jul 2023 12:00:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id o2-20020a1c7502000000b003fc00892c13sm398658wmc.35.2023.07.17.12.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 12:00:24 -0700 (PDT)
Message-ID: <ebaf79fe-25e4-9d42-4201-547ad7c8d480@redhat.com>
Date:   Mon, 17 Jul 2023 21:00:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: mprotect and hugetlb mappings
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230705230808.GA41006@monkey>
 <ZKX7PerFpnoMT5Pc@casper.infradead.org> <20230705235322.GD41006@monkey>
 <399a6448-184b-1433-3f23-1a599656a713@suse.cz> <20230717185222.GB4741@monkey>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230717185222.GB4741@monkey>
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

On 17.07.23 20:52, Mike Kravetz wrote:
> On 07/17/23 18:19, Vlastimil Babka wrote:
>> On 7/6/23 01:53, Mike Kravetz wrote:
>>> On 07/06/23 00:22, Matthew Wilcox wrote:
>>>> On Wed, Jul 05, 2023 at 04:08:08PM -0700, Mike Kravetz wrote:
>>>>> I was recently asked about the behavior of mprotect on a hugetlb
>>>>> mapping where addr or addr+len is not hugetlb page size aligned.  As
>>>>> one might expect, EINVAL is returned in such cases.  However, the man
>>>>> page makes no mention of alignment requirements for hugetlb mappings.
>>>>>
>>>>> I am happy to submit man page updates if people agree this is the correct
>>>>> behavior.  We might even want to check alignment earlier in the code
>>>>> path as we fail when trying to split the vma today.
>>>>>
>>>>> An alternative behavior would be to operate on whole hugetlb pages within
>>>>> the range addr - addr+len.
>>>>
>>>> After a careful re-reading of the mprotect() man page, I suggest the
>>>> following behaviour ...
>>>>
>>>> addr must be a multiple of the hpage size.  Otherwise -EINVAL.
>>>> len should be rounded up to hpage size.
>>>>
>>>> I wonder how likely this change would be to break userspace code.
>>>> Maybe some test cases.
>>>
>>> My concern is that this is the approach I took with huegtlb MADV_DONTNEED,
>>> and this caused problems discussed and eventually modified here:
>>> https://lore.kernel.org/linux-mm/20221021154546.57df96db@imladris.surriel.com/
>>>
>>> In the MADV_DONTNEED case we were throwing away data.  With mprotect we are
>>> only modifying access to data.
>>
>> That can still confuse some userspace, no? I think realistically we can only
>> document the current implementation better, maybe improve it without
>> changing observed behavior as you suggested wrt the split vma fail. But
>> changing it would be dangerous.
> 
> Thanks for the comments Vlastimil.
> 
> That would be my thought/preferred path forward.  Simply document the
> current behavior, and MAYBE update code to be more explicit.
> 
> Any other thoughts?

I agree.

-- 
Cheers,

David / dhildenb

