Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4F37D47F8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjJXHIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjJXHIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:08:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC11710C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698131278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=7apdod2xRDLnAqAvIVcJhLqptWlfuCchyTyTJa1szBg=;
        b=IBk7b+ZFk25p89nA/PcvnXR/9Bgk4wkBDPRhx20ViPI/p2wJflGvDFukmMey0MGCWDssgY
        B4NB2dlZ3ojwPzmj4ldOF/A+0Kk9XFTKsrxggOrtwFytHRfOSiOLeIDdq9TjwDCKNic9Xh
        /CszcXr70KA470mlrN0Rrr5xjHOv6Lw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-p8zpeHwYOl-ZmT_pihzvvg-1; Tue, 24 Oct 2023 03:07:56 -0400
X-MC-Unique: p8zpeHwYOl-ZmT_pihzvvg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31fd48da316so1903357f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698131274; x=1698736074;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7apdod2xRDLnAqAvIVcJhLqptWlfuCchyTyTJa1szBg=;
        b=PZQkUH8a1rPZCiZ34hlErLnyg+VEyE8iJSuIdsGOXOIl/1kCXtYdR+XD5HMBcU5Xdr
         6xsdYp6CFgp/A2m8JIJCJrR/YSIEE7Yb8wKrsFnEx6Abq3Gvq+7JryDO270Ya+O2Muem
         XLHzVO4tQ0jClNaZYTwqXoxqy6Fk+XCh/yr/1EyEmum+YPr5XJWvME8+bfuCl5K+qp8F
         +JFgMNHRB6Hb1fMCGE5DivaTFCo88jQjI2vXPSeaX2BDtj4T0oktUmuRyJTjLd9doeIO
         B9oWy6DqGJrqINV05gddMN5hd5vOMKn64FWpsgCnNkmfjYqiwri//sy/hnR7hSO0rmUK
         AB1Q==
X-Gm-Message-State: AOJu0Yw+u/gh5GLMD3F6SwTg4NVYsisotADFOI4HeV0FORfMyFOz6A/U
        y/Pm4Spb3Qzb+xCp7oeMub8Iaue9FttmhT+9xHvaUnKzA9MH/tvyZkfw6tJQEikTcV1weHpgDD/
        ewpdf1NwgGVMkET7hENDdhuNGgx2UT3jw
X-Received: by 2002:adf:e10a:0:b0:319:867e:97d7 with SMTP id t10-20020adfe10a000000b00319867e97d7mr9213545wrz.52.1698131274242;
        Tue, 24 Oct 2023 00:07:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYTcXzUu4sJJlpZ81zKBxUq5hYh6Zdcb0iHKPRKNblWg0yTHVvNyyG369tzBVyI6LKdxo3+Q==
X-Received: by 2002:adf:e10a:0:b0:319:867e:97d7 with SMTP id t10-20020adfe10a000000b00319867e97d7mr9213518wrz.52.1698131273789;
        Tue, 24 Oct 2023 00:07:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:ac00:f27c:e128:f876:f17e? (p200300cbc741ac00f27ce128f876f17e.dip0.t-ipconnect.de. [2003:cb:c741:ac00:f27c:e128:f876:f17e])
        by smtp.gmail.com with ESMTPSA id r4-20020adff704000000b0032d88e370basm9294541wrp.34.2023.10.24.00.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 00:07:53 -0700 (PDT)
Message-ID: <356a0ae7-6fba-4065-bdb3-5da184074f60@redhat.com>
Date:   Tue, 24 Oct 2023 09:07:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm:vmscan: the dirty folio in folio_list skip
 unmap
To:     zhiguojiang <justinjiang@vivo.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20231019131446.317-1-justinjiang@vivo.com>
 <20231019131446.317-2-justinjiang@vivo.com>
 <2d847d76-2e33-4296-992f-1a6d00c66ff5@redhat.com>
 <02e73251-33ff-4632-9d2c-bc268f397202@vivo.com>
 <ZTH+7ZJyPnyZOe7V@casper.infradead.org>
 <380bc753-5ee7-4bc7-a76e-a804d5179d87@vivo.com>
 <ZTZlR2qJivLIdgsB@casper.infradead.org>
 <4eacc9e4-65ba-4fd9-bd30-575b0f23b63e@vivo.com>
 <ZTZuui+0Ppe6cjgC@casper.infradead.org>
 <ec6b681b-132e-4323-93eb-5925b0ca7ace@vivo.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ec6b681b-132e-4323-93eb-5925b0ca7ace@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.10.23 04:04, zhiguojiang wrote:
> 
> 
> 在 2023/10/23 21:01, Matthew Wilcox 写道:
>> On Mon, Oct 23, 2023 at 08:44:55PM +0800, zhiguojiang wrote:
>>> 在 2023/10/23 20:21, Matthew Wilcox 写道:
>>>> On Mon, Oct 23, 2023 at 04:07:28PM +0800, zhiguojiang wrote:
>>>>>> Are you seeing measurable changes for any workloads?  It certainly seems
>>>>>> like you should, but it would help if you chose a test from mmtests and
>>>>>> showed how performance changed on your system.
>>>>> In one mmtest, the max times for a invalid recyling of a folio_list dirty
>>>>> folio that does not support pageout and has been activated in
>>>>> shrink_folio_list() are: cost=51us, exe=2365us.
>>>>>
>>>>> Calculate according to this formula: dirty_cost / total_cost * 100%, the
>>>>> recyling efficiency of dirty folios can be improved 53.13%、82.95%.
>>>>>
>>>>> So this patch can optimize shrink efficiency and reduce the workload of
>>>>> kswapd to a certain extent.
>>>>>
>>>>> kswapd0-96      (     96) [005] .....   387.218548:
>>>>> mm_vmscan_lru_shrink_inactive: [Justin] nid 0 nr_scanned 32 nr_taken 32
>>>>> nr_reclaimed 31 nr_dirty  1 nr_unqueued_dirty  1 nr_writeback 0
>>>>> nr_activate[1]  1 nr_ref_keep  0 f RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>>>>> total_cost 96 total_exe 2365 dirty_cost 51 total_exe 2365
>>>>>
>>>>> kswapd0-96      (     96) [006] .....   412.822532:
>>>>> mm_vmscan_lru_shrink_inactive: [Justin] nid 0 nr_scanned 32 nr_taken 32
>>>>> nr_reclaimed  0 nr_dirty 32 nr_unqueued_dirty 32 nr_writeback 0
>>>>> nr_activate[1] 19 nr_ref_keep 13 f RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>>>>> total_cost 88 total_exe 605  dirty_cost 73 total_exe 605
>>>> I appreciate that you can put probes in and determine the cost, but do
>>>> you see improvements for a real workload?  Like doing a kernel compile
>>>> -- does it speed up at all?
>>> Can you help share a method for testing thread workload, like kswapd?
>> Something dirt simple like 'time make -j8'.
> Two compilations were conducted separately, and compared to the
> unmodified compilation,
> the compilation time for adding modified patches had a certain
> reduction, as follows:
> 
> Compilation command:
> make distclean -j8
> make ARCH=x86_64 x86_64_defconfig
> time make -j8
> 
> 1.Unmodified Compilation time:
> real    2m40.276s
> user    16m2.956s
> sys     2m14.738s
> 
> real    2m40.136s
> user    16m2.617s
> sys     2m14.722s
> 
> 2.[Patch v2 1/2] Modified Compilation time:
> real    2m40.067s
> user    16m3.164s
> sys     2m14.211s
> 
> real    2m40.123s
> user    16m2.439s
> sys     2m14.508s
> 
> 3 [Patch v2 1/2] + [Patch v2 2/2] Modified Compilation time:
> real    2m40.367s
> user    16m3.738s
> sys     2m13.662s
> 
> real    2m40.014s
> user    16m3.108s
> sys     2m14.096s
> 

To get expressive numbers two iterations are usually not sufficient. How 
much memory does you system have? Does vmscan even ever get active?

-- 
Cheers,

David / dhildenb

