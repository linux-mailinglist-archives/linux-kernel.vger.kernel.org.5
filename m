Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF787887F8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242744AbjHYM7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242591AbjHYM7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B162132
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692968287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GBNFTvdriLPppzHDS0vd7lqIVYVAXCvQTC0sUYC9WhM=;
        b=U9iFhhjMFdhEHS/thnPQUJxR9eIsRCT4g+HhgseWHwbACaovOkoCNpv/EoYpiXumeKNYtu
        UzREJgsYSBv9jJPzk7AA1HeilTXUHARWgbuAxS40opkW1TjM6Gn+m5WLiJlKrKhE/DZZUc
        D/c6/HxYYnCucejrY83WpTc2UZxR0AY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-UqUrqzZOMG2ADdwFQATasw-1; Fri, 25 Aug 2023 08:58:06 -0400
X-MC-Unique: UqUrqzZOMG2ADdwFQATasw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f41a04a297so7307835e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692968285; x=1693573085;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBNFTvdriLPppzHDS0vd7lqIVYVAXCvQTC0sUYC9WhM=;
        b=Cjg6RLNeI+Y2au7yvnJZa2iu+qFWWlQNKpaIfj5AO1eX674/gOv10nkf5qzeGN4pQ2
         P/tmPsq9OISNjwacVoFG35lh9FNA5a8CJ4UGD9tgTCFcayCIfFIG5zUUCtV0xFaCEwfo
         fO5EgbCvf9owNf9GX+9nx6XXifgyo4j0jL9LxjjQZXXQ80mYeJusDQxX659zC4Yp53vj
         N64wWrHTmwtIJ8wzF38p//ZyMGVvJmXRLILYaYY8OoXIOalcNnSKYdvoCtv1vDACy/UL
         cBz9x2MA+5TOyXFA/FE0K+Hmwxa43V+usTXKBnIoXw2mD+icOuVK6JZCsvZlosd/+WT8
         lr6A==
X-Gm-Message-State: AOJu0YyPjp5rbwNuFwQnhNXT9hUexqs2xJCqhTJH634yaJtd8wafFs5l
        kIfNM5JUNhzxp27JNHVMf6M/7mtcNfVQQWbKmj9Z9eZDRSomkIcioMB3AluIRSelo5jZREGJu0X
        eyLrA40oudxKnh9ODYJ9rwMum
X-Received: by 2002:a05:600c:3799:b0:3f5:878:c0c2 with SMTP id o25-20020a05600c379900b003f50878c0c2mr14208407wmr.3.1692968285180;
        Fri, 25 Aug 2023 05:58:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIWzFG8Vg+V8chVstmx3m6+6mqzbpA3c0OYtwpWWOzh8XQfnAz6aBjRxNoEBn9X7lmQTXB9A==
X-Received: by 2002:a05:600c:3799:b0:3f5:878:c0c2 with SMTP id o25-20020a05600c379900b003f50878c0c2mr14208394wmr.3.1692968284772;
        Fri, 25 Aug 2023 05:58:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:9200:ce93:b5e6:8aa9:65d4? (p200300cbc70e9200ce93b5e68aa965d4.dip0.t-ipconnect.de. [2003:cb:c70e:9200:ce93:b5e6:8aa9:65d4])
        by smtp.gmail.com with ESMTPSA id a16-20020a5d5090000000b0031432f1528csm2175306wrt.45.2023.08.25.05.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 05:58:04 -0700 (PDT)
Message-ID: <9f967665-2cbd-f80b-404e-ac741eab1ced@redhat.com>
Date:   Fri, 25 Aug 2023 14:58:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [EXTERNAL] Re: [PATCH v3] mm/thp: fix "mm: thp: kill
 __transhuge_page_enabled()"
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Zach O'Keefe <zokeefe@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Saurabh Sengar <ssengar@linux.microsoft.com>
References: <20230821234844.699818-1-zokeefe@google.com>
 <37c2b525-5c2c-d400-552c-9ccb91f4d7bf@redhat.com>
 <CAAa6QmSHF6-9aFa68WDcb+WATh2Yz=wXyp8VBLDNv6yPp2SS5Q@mail.gmail.com>
 <3e08d48b-7b70-cc7f-0ec1-12ad9b1a33db@redhat.com>
 <CAAa6QmSNvx7wbZzfhFOyhODTMoBbf6PimnOf2xeAw5NkD1eXVg@mail.gmail.com>
 <PUZP153MB06350A5DC9CCB8448C98E4EEBE1DA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <3408ff54-f353-0334-0d66-c808389d2f01@redhat.com>
 <ZOijSwCa9NFD6DZI@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZOijSwCa9NFD6DZI@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.23 14:49, Matthew Wilcox wrote:
> On Fri, Aug 25, 2023 at 09:59:23AM +0200, David Hildenbrand wrote:
>> Especially, we do have bigger ->huge_fault changes coming up:
>>
>> https://lkml.kernel.org/r/20230818202335.2739663-1-willy@infradead.org
>>
>> If the driver is not in the tree, people don't care.
>>
>> You really should try upstreaming that driver.
>>
>>
>> So this patch here adds complexity (which I don't like) in order to keep an
>> OOT driver working -- possibly for a short time. I'm tempted to say "please
>> fix your driver to not use huge faults in that scenario, it is no longer
>> supported".
>>
>> But I'm just about to vanish for 1.5 week into vacation :)
>>
>> @Willy, what are your thoughts?
> 
> Fundamentally there was a bad assumption with the original patch --
> it assumed that the only reason to support ->huge_fault was for DAX,
> and that's not true.  It's just that the only drivers in-tree which
> support ->huge_fault do so in order to support DAX.

Okay, and we are willing to continue supporting that then and it's 
nothing we want to stop OOT drivers from doing.

Fine with me; we should probably reflect that in the patch description.

> 
> Keeping a driver out of tree is always a risky and costly proposition.
> It will continue to be broken by core kernel changes, particularly
> if/when it does unusual things.
> 

Yes.

> I think the complexity is entirely on us.  I think there's a simpler way
> to handle the problem, but I'd start by turning all of this "admin and
> app get to control when THP are used" nonsense into no-ops.

Well, simpler, yes, but also more controversial :)

-- 
Cheers,

David / dhildenb

