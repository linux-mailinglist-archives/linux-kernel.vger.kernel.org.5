Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1007AAAC3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjIVHuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjIVHuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507891A2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695368944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mUrChINedqPMXcgm7a4g3Fw1rlxjkk+Lujf8OPdqplc=;
        b=iWCkoFqu3+XGO+oc3m4+xsCC37vIk+vh2Z/3jUS6afnELI0Pph54NV6pQzlcjICB1gCwwf
        0Jh89eurWXUkUSymJyNXX6N1A69zil/AEXcufXK9MwJSXvlz+S4JGKtYZHyfMJP1RJMzZF
        6v6GNyzORhJZ0W7LgN0aw7JlqS/Z7Gg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-2fFisIm1PlajNRkuEGHdpQ-1; Fri, 22 Sep 2023 03:49:02 -0400
X-MC-Unique: 2fFisIm1PlajNRkuEGHdpQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3200942185dso1030430f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695368941; x=1695973741;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUrChINedqPMXcgm7a4g3Fw1rlxjkk+Lujf8OPdqplc=;
        b=fXH4/TA/YTGtmyW0PnC9SUocx9zBxQOodColWZxrc0A1lNg5yGAgmYrue7CvZmAf7m
         qVzGkuRETfSEBE7CMSuh/SnqORKuq6HwETPf7lzXkq3vzbB6WsOR96mx4TEWGBvxc2TX
         cy70na30QsHNS/EsN3KkSluUID9aZLQgmi9qzPcxPgcCCTaLfWR/UH42h2iki+CYMuq0
         iHUxsGTFeaP1Uce605M1DCibYcACIE+mvP/cJ65dUE6XxaaeNxPAmapPC9EX80s8ZB71
         A+DJI28MFK/w/83oa475umz186RZpHtGpoUmU/ymqaTU+cUo3dzRPvUOGQ2JXWihIylQ
         mjjQ==
X-Gm-Message-State: AOJu0Yy71YUZpMAnlC38Eqbn4rftZGp0VTyhbFNIMzKyKAHi26ynP96o
        hdGYrCDj7WijHgnUVi9kex4hMFZNEmG6LiqNPdekgF7HaPKGAYpyiGkf9Xe5jXxCYVHVsBx7lKe
        y99yzG8a3BgVDNNXvj+TrHwAx
X-Received: by 2002:a5d:5966:0:b0:313:e391:e492 with SMTP id e38-20020a5d5966000000b00313e391e492mr1358470wri.17.1695368941622;
        Fri, 22 Sep 2023 00:49:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsL+j01Pw5XaxmoyefOCVvRg5dYpJ8WuCHDVdp80uhbCqWq+8WMVJspNAvm9myjLNXXZO0zA==
X-Received: by 2002:a5d:5966:0:b0:313:e391:e492 with SMTP id e38-20020a5d5966000000b00313e391e492mr1358452wri.17.1695368941281;
        Fri, 22 Sep 2023 00:49:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:7100:dfaf:df8b:54b9:7303? (p200300cbc71a7100dfafdf8b54b97303.dip0.t-ipconnect.de. [2003:cb:c71a:7100:dfaf:df8b:54b9:7303])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d6b51000000b0031980294e9fsm3738383wrw.116.2023.09.22.00.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 00:49:00 -0700 (PDT)
Message-ID: <2ed9a6c5-bd36-9b9b-7022-34e7ae894f3a@redhat.com>
Date:   Fri, 22 Sep 2023 09:48:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/4] mm: pass set_count and set_reserved to
 __init_single_page
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, glider@google.com, elver@google.com,
        dvyukov@google.com, rppt@kernel.org, osalvador@suse.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
References: <20230922070923.355656-1-yajun.deng@linux.dev>
 <20230922070923.355656-2-yajun.deng@linux.dev>
 <ZQ1Gg533lODfqvWd@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZQ1Gg533lODfqvWd@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.23 09:47, Matthew Wilcox wrote:
> On Fri, Sep 22, 2023 at 03:09:20PM +0800, Yajun Deng wrote:
>> -		__init_single_page(page, pfn, zone, nid);
>> +		__init_single_page(page, pfn, zone, nid, true, false);
> 
> So Linus has just had a big rant about not doing bool flags to
> functions.  And in particular _multiple_ bool flags to functions.
> 
> ie this should be:
> 
> #define INIT_PAGE_COUNT		(1 << 0)
> #define INIT_PAGE_RESERVED	(1 << 1)
> 
> 		__init_single_page(page, pfn, zone, nid, INIT_PAGE_COUNT);
> 
> or something similar.
> 
> I have no judgement on the merits of this patch so far.  Do you have
> performance numbers for each of these patches?  Some of them seem quite
> unlikely to actually help, at least on a machine which is constrained
> by cacheline fetches.

The last patch contains

before:
node 0 deferred pages initialised in 78ms

after:
node 0 deferred pages initialised in 72ms

Not earth-shattering :D Maybe with much bigger machines relevant?

-- 
Cheers,

David / dhildenb

