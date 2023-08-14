Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B83F77BD3A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjHNPjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjHNPik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:38:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F2110CE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692027474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XOwPCyMaYRVkv/+H+FDXXPyuPDLfprd7ZUTCXYLsYrI=;
        b=Yzx25THFPAPEzj2F4IedLDtYcyznJ6MQEyC+9/jmnxB2lMd2OBi6u+d8zV5tB6UmkHeGuV
        L4Xj5WRyH6DsKY9dGsEk2gcgcDDV058g1MqFv0opIRxeDpxVMZu/86vn/bq66vdL4cK1nD
        PxTb61hAzzc1kLpQ0fShgvsEPofaLXs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-RXUI2v2bPcOHNz4je2w1Bw-1; Mon, 14 Aug 2023 11:37:52 -0400
X-MC-Unique: RXUI2v2bPcOHNz4je2w1Bw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fe13f529f5so29463925e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692027471; x=1692632271;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOwPCyMaYRVkv/+H+FDXXPyuPDLfprd7ZUTCXYLsYrI=;
        b=j9NJqryUnw3hIfmNhIL1Op6oPTDGMbLcviHZ/lTc68zifBBd/9bPp4pnrvYBLuXfdW
         dThgN6jJVs7+L4Iw8+ZLLFUGnXp1/DS3gp2KcCrpM/FzJtfkCaCaxJuawVY+GZMiEZ6b
         vgwDI2USLFb3WPWnEKRjt7OQx2iLOE8ERxIQdB58ovekefMAPQGKB7ricvpeOIBHgFgH
         uoI5I0IcUjxqftIzKABen9MaqQgpPBiJTo+5kuLoQayktBdYds7SmTXJpCrlIcUyEeA1
         QmLM7SXYQSiLl3BEMPOvu82OUlTKX2ETSx9jRHbdAjY3zvwAJY6xWePBkiw8iNvRc9x1
         nECg==
X-Gm-Message-State: AOJu0Yyv3l2caXjOpUeY78hivJSTJ74Is5XWHP7yB97U2zmPUnKJyOgV
        ja8m7NtV25+dxb32hqwGtNBLrtNvOaPfjsqqls4EFEy+p/Io8aKpj1FiMbI1CyJAWu8SUbmqgIg
        LcTscb7yK7LZrhhOdnYGAXFrX
X-Received: by 2002:a5d:5088:0:b0:319:6ea5:72db with SMTP id a8-20020a5d5088000000b003196ea572dbmr4412279wrt.67.1692027471170;
        Mon, 14 Aug 2023 08:37:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr5OMD5uHd6IqNk83fSuRAXN3NejVMe7czulJ9Svaw0gCjXLIAFvcko56HBmGUw/N7kV8nsg==
X-Received: by 2002:a5d:5088:0:b0:319:6ea5:72db with SMTP id a8-20020a5d5088000000b003196ea572dbmr4412262wrt.67.1692027470739;
        Mon, 14 Aug 2023 08:37:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:d900:2d94:8433:b532:3418? (p200300d82f2bd9002d948433b5323418.dip0.t-ipconnect.de. [2003:d8:2f2b:d900:2d94:8433:b532:3418])
        by smtp.gmail.com with ESMTPSA id e1-20020adfe381000000b003140f47224csm14706551wrm.15.2023.08.14.08.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 08:37:50 -0700 (PDT)
Message-ID: <52192c2f-c7b1-9c07-7ca2-10fc6bd347b0@redhat.com>
Date:   Mon, 14 Aug 2023 17:37:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] kernel/fork: stop playing lockless games for exe_file
 replacement
Content-Language: en-US
To:     Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, linux-mm@kvack.org, koct9i@gmail.com,
        dave@stgolabs.net
References: <20230813123333.1705833-1-mjguzik@gmail.com>
 <20230814150530.GB17738@redhat.com> <20230814152038.GA2367@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230814152038.GA2367@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.23 17:20, Oleg Nesterov wrote:
> On 08/14, Oleg Nesterov wrote:
>>
>> On 08/13, Mateusz Guzik wrote:
>>>
>>> fe69d560b5bd ("kernel/fork: always deny write access to current MM
>>> exe_file") added another lock trip to synchronize the state of exe_file
>>> against fork, further defeating the point of xchg.
>>>
>>> As such I think the atomic here only adds complexity for no benefit.
>>>
>>> Just write-lock around the replacement.
>>
>> Well, I tend to agree but can't really comment because I forgot everything
>> about these code paths.
>>
>> But I have to admit that I don't understand the code in replace_mm_exe_file()
>> without this patch...
>>
>> 	old_exe_file = xchg(&mm->exe_file, new_exe_file);
>> 	if (old_exe_file) {
>> 		/*
>> 		 * Don't race with dup_mmap() getting the file and disallowing
>> 		 * write access while someone might open the file writable.
>> 		 */
>> 		mmap_read_lock(mm);
>> 		allow_write_access(old_exe_file);
>> 		fput(old_exe_file);
>> 		mmap_read_unlock(mm);
>> 	}
>>
>> Can someone please explain me which exactly race this mmap_read_lock() tries
>> to avoid and how ?
> 
> OK, I seem to understand... without mmap_read_lock() it is possible that
> 
> 	- dup_mm_exe_file() sees mm->exe_file = old_exe_file
> 
> 	- replace_mm_exe_file() does allow_write_access(old_exe_file)
> 
> 	- another process does get_write_access(old_exe_file)
> 
> 	- dup_mm_exe_file()->deny_write_access() fails
> 
> Right?

 From what I recall, yes.

-- 
Cheers,

David / dhildenb

