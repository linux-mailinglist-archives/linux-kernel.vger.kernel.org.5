Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB257D7D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344254AbjJZHBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjJZHBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB32A192
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698303660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=/wQYguGCdyJ52i6VaxoBiji/YCKqhFZfcS10MYSq9dE=;
        b=O/P29Ex+iNqJ6a5Bf6aQei7Ce64oTzrRg503pFDGQlOn2i0/SYXtRtzVA9ePc56MOXypsC
        1bnfkFUf4aGi/mXmkv5ldQThd1zp5Vv8PAQ5g8vezOkKaOEoy5r3xO4GcZM6a1YV0Je3+7
        G+XiR73gxfMmXLSKQkXM0AX+GPE0Zm8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-bDu-d81TNH2zw1FEof8BAg-1; Thu, 26 Oct 2023 03:00:59 -0400
X-MC-Unique: bDu-d81TNH2zw1FEof8BAg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32de9f93148so355612f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698303658; x=1698908458;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wQYguGCdyJ52i6VaxoBiji/YCKqhFZfcS10MYSq9dE=;
        b=C0Ra+F8V+CPtGoSHsRSrQnHZFwd8zh1Y3BpdFzNRDIfafkr9yKneO+AL7VS/Ktnr3S
         n3SJn6qkERKe1ltcnQycsEQV03D0v6lD776wqcP/XWfyNwvlUoC1lnGc3ovCcf+1pZX1
         MhfB91dpOMVsCmNwHpVx48OrInd+NkJXF/P0TsLJFU/BsQ78HuXXFHGhRE2PEZJypFpS
         TPqNLffjnzZuyuEvZXUpluZYzK3zoSaLLj5laTEvzatlDrKTDbCkRMJKf0bq23kDPeiG
         gE9mmJeJgM6tC7TKtMr8CR5PMR022N8dn0jzvYIKlnTAJLGHK+Ti/BvDARhnvY85ubxa
         M+fA==
X-Gm-Message-State: AOJu0YyqrsfxGfnDIbs06vFH22OfIg2MX+qN5CrtWsWHjVz4pe55PpH6
        4QMtpg2xik3moNJdKNxJFQOeMNg1l7/WhcKF8PsYhzKv32NWpj3ZA5loLn11PZBxVGDECIURX3d
        0LEgt5JtPxKNDyeuHU0W9L/cj
X-Received: by 2002:adf:f38e:0:b0:321:68fa:70aa with SMTP id m14-20020adff38e000000b0032168fa70aamr12376749wro.9.1698303658202;
        Thu, 26 Oct 2023 00:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgui+2HW15OJ63rN70F4C+ROq6fJZPWAub+kLsAULzDtVRyaaO0YrpjCFP/vCvR5YITs76+w==
X-Received: by 2002:adf:f38e:0:b0:321:68fa:70aa with SMTP id m14-20020adff38e000000b0032168fa70aamr12376708wro.9.1698303657278;
        Thu, 26 Oct 2023 00:00:57 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6e16.dip0.t-ipconnect.de. [91.12.110.22])
        by smtp.gmail.com with ESMTPSA id e16-20020adfe390000000b0032dab20e773sm13545222wrm.69.2023.10.26.00.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 00:00:56 -0700 (PDT)
Message-ID: <2a7b5e72-604a-48e1-9c0e-3b9ad15e7f78@redhat.com>
Date:   Thu, 26 Oct 2023 09:00:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/sparsemem: fix race in accessing memory_section->usage
To:     Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     Pavan Kondeti <quic_pkondeti@quicinc.com>, osalvador@suse.de,
        dan.j.williams@intel.com, vbabka@suse.cz,
        mgorman@techsingularity.net, aneesh.kumar@linux.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com>
 <e1102c1b-1773-4e59-8a70-00a7deff2bde@quicinc.com>
 <b4a2bbe8-4181-68ad-1a6c-463fbe64d8f8@quicinc.com>
 <20231025143541.e7cf114239b84105711a5f70@linux-foundation.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231025143541.e7cf114239b84105711a5f70@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.10.23 23:35, Andrew Morton wrote:
> On Tue, 17 Oct 2023 19:40:15 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:
> 
>>>>   		 * was allocated during boot.
>>>>   		 */
>>>>   		if (!PageReserved(virt_to_page(ms->usage))) {
>>>> +			synchronize_rcu();
>>>>   			kfree(ms->usage);
>>>>   			ms->usage = NULL;
>>>>   		}
>>> If we add NULL checks around ms->usage, this becomes
>>>
>>> tmp = rcu_replace_pointer(ms->usage, NULL, hotplug_locked());
>>> syncrhonize_rcu();
>>> kfree(tmp);
>> Per David input, I am working on using kfree_rcu().
> 
> How's it coming along?
> 
> Given that we're at 6.6-rc7 and given that this issue is causing
> daily crashes in your device farm, I'm thinking that we use the current
> version of your patch for 6.6 and for -stable.  We can look at the
> kfree_rcu() optimization for later kernel releases?

Any particular reason we have to rush this in? It's been seen by one 
company in a testing farm; there were no other reports, especially not 
from production systems. ... and the issue seems to be quite old.

-- 
Cheers,

David / dhildenb

