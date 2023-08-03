Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69E976E4A6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbjHCJh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjHCJgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962B6421E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691055304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sAtmKskyJZMhBCz6si9v3A7sUPeiZS5ZoWATo1UhLv4=;
        b=EjeH0colkcgtPUxaYn8W27OIAEXtE1H3JF3nqEeuzB2emlqbYNEWYMUYrtJtOsF5cOzaM0
        ciRsVRFO56Wnh2q3COtjgbHl/BuNHTmcmpbvhY2gOSnaHNpHJCIibFi9RwY/SPdkNPEsvq
        qaWjhwNAzlxmFLkJ6xEHpWPuvvBDGuI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-OZtM1sSWNQCTisbay1piHA-1; Thu, 03 Aug 2023 05:35:03 -0400
X-MC-Unique: OZtM1sSWNQCTisbay1piHA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30793c16c78so443412f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 02:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691055302; x=1691660102;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sAtmKskyJZMhBCz6si9v3A7sUPeiZS5ZoWATo1UhLv4=;
        b=UYo0QaXN3fxMikcPiU5wSb1Hg0O+RBZRB9mzbGBe0v2PRL/r4ilcmH1CK8eel+TRX/
         eWGMXpOkx+4+FY99/AovXU6tEoMQ+8TeTFW3Gy4HN0KI5OdbRqqWLCcFgHRfEAzkSId6
         oqim83HsUZA2g+iNg2n9FYyGJ7eFFzcYZaW7RtI0qtmFDHSHVqI91QmE1fGEBEMG1usV
         eOOjUG6QMeHxvWB8MLLQ9XB06UQ4xhu2YdI4089MAnMUydpKBFkRmsCgfB0XnQEf1Ycw
         mxoHphdwZK7lH+qrokIWlf5NOXY1bTLQIkr3E3uBD4KXj3UoatlhDTceAEYWoUW89ylY
         1o7w==
X-Gm-Message-State: ABy/qLa++K3IabxoJHyChb2WRrjhx3xHDLodTXUYAtAhRww+50zjcb3N
        /FNqkcxLMVZ27Xsj7MiNIxPqoLFX6M/oV/fD/TrZ7mOqDegDTez/3S9ALiGtBo4zRSLXsKQs/fn
        iSxe10BRvqazc6HmKkvARe2Gf
X-Received: by 2002:a5d:460f:0:b0:315:9993:1caa with SMTP id t15-20020a5d460f000000b0031599931caamr4886061wrq.12.1691055301826;
        Thu, 03 Aug 2023 02:35:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEGdI3NIQM1lH7tvUgBI+Nd9i5NFPEBDq7F+EJrIYs0fPe0mRJyazlx3oy2QRvXRGihj8dFNA==
X-Received: by 2002:a5d:460f:0:b0:315:9993:1caa with SMTP id t15-20020a5d460f000000b0031599931caamr4886051wrq.12.1691055301420;
        Thu, 03 Aug 2023 02:35:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:9a00:a5f5:5315:b9fa:64df? (p200300cbc7189a00a5f55315b9fa64df.dip0.t-ipconnect.de. [2003:cb:c718:9a00:a5f5:5315:b9fa:64df])
        by smtp.gmail.com with ESMTPSA id p9-20020adfce09000000b0031763fd36c4sm21300996wrn.104.2023.08.03.02.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 02:35:00 -0700 (PDT)
Message-ID: <007ae337-1e92-d43f-6204-5987698aa7bf@redhat.com>
Date:   Thu, 3 Aug 2023 11:34:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] mm: migrate: more folio conversion
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Huang Ying <ying.huang@intel.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20230802095346.87449-1-wangkefeng.wang@huawei.com>
 <bf4b5b30-4ed1-13ed-bba9-234887c9eeb3@redhat.com>
 <32b748d2-3d88-87d6-3797-c82d7bb7a927@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <32b748d2-3d88-87d6-3797-c82d7bb7a927@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.08.23 14:38, Kefeng Wang wrote:
> 
> 
> On 2023/8/2 19:47, David Hildenbrand wrote:
>> On 02.08.23 11:53, Kefeng Wang wrote:
>>> This patch series converts several functions to use folio in migrate.c.
>>
>> Please clearly spell out in the patch descriptions when you are changing
>> mapcount logic and which effects that might have (both, positive and
>> negative) for PTE-mapped THP.
> 
> Oh, I see your comments on another mail[1], the folio_estimated_sharers()
> is not good to evaluate the sharing by multiple processes, will read more
> history of the mail's discussion, maybe just ignore the first three patches.

It might be good enough for some cases right now. My point is that we 
better just clearly spell out the possible effects of such a change.

(so far you didn't even mention them, and that's sub-optimal when buried 
in a "folio" conversion that better shouldn't change the functionality 
without spelling it out)

-- 
Cheers,

David / dhildenb

