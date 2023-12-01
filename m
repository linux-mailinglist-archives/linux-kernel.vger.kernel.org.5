Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58838013E9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379589AbjLAUG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379559AbjLAUGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:06:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE235FA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701461190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=EcwojL2Q497ViXSvlP5PJWbo0/1rGgWYaH0qUEntYE8=;
        b=Zaxgd7zgjjh98lyS76pUgpb0KVoUIk5lX3rZfoS+5AH5HwYqvbq6KXJ4p0ynKxkPcIjnwR
        xX0zDUjthGt+A8V9i3pAaEYF/+HaBcXh8zAha+mBDhpAhC/G2VIJfAGfRcnSzDugILILts
        Shuu2LH/N8uAkZPekrj7aA1Qpa88nbc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-jJeHTVFBPVWgXhPEMnwOCQ-1; Fri, 01 Dec 2023 15:06:27 -0500
X-MC-Unique: jJeHTVFBPVWgXhPEMnwOCQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50bbcec7b48so2654854e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 12:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701461185; x=1702065985;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcwojL2Q497ViXSvlP5PJWbo0/1rGgWYaH0qUEntYE8=;
        b=HKePwYkkv7INkEhVwQ2SLzFu1r+0lfqP0OD0aXBnMKzf5jwDXCgFaae7xvIz8mYXCT
         Q+LJ72A1NLs4/TtWBDgbjjyl1/txs4vhoI0QHPZSNWJNfOTs16pthqz1IUCvSqH6Q1c1
         fqD289NzMpnEu9VZum01S7POdTWIM72vxEQW7/soNLXJSkVH7fwROZuV7OtUguXi5RP0
         wvi5lTLf7RrEYKtjv/bBX1tAs6S2EYb230UVvJlf1nopEpvpSUFLZjzpnlAll+LJRj2b
         C8fkmdVDj1e6wIGHA78Xa9j28Vh3zRYEnV5/YkG4a9AevzhSOf68iBsKdNXaPXfpV2Nm
         9JXg==
X-Gm-Message-State: AOJu0YyfikjJYnNCH/Ni/F/Wo4BdynEDCbgJ0lTdItj9ghKK8FNVXsbX
        YUIDlRF1j1f98f1w5xzF6vTWxN9IvvOzjuhBXm+tpImVrh7mGoL8ytEQlOOglemaJZ6oI+IgFvO
        yPczBONLNjd4zFILKyBgUCHSV
X-Received: by 2002:a19:f019:0:b0:50b:d764:8803 with SMTP id p25-20020a19f019000000b0050bd7648803mr1143075lfc.79.1701461184722;
        Fri, 01 Dec 2023 12:06:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1sM3/bapkEBgeM7fXSNSzlwVdJuz6+TZ/Y56BP9GLn9zABN/iKrB3j0EWSuiEQ51E4gGJHw==
X-Received: by 2002:a19:f019:0:b0:50b:d764:8803 with SMTP id p25-20020a19f019000000b0050bd7648803mr1143058lfc.79.1701461184222;
        Fri, 01 Dec 2023 12:06:24 -0800 (PST)
Received: from ?IPV6:2003:d8:2f28:7800:30d7:645a:7306:e437? (p200300d82f28780030d7645a7306e437.dip0.t-ipconnect.de. [2003:d8:2f28:7800:30d7:645a:7306:e437])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c471500b0040836519dd9sm6376006wmo.25.2023.12.01.12.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 12:06:23 -0800 (PST)
Message-ID: <2d691c11-fa97-4f56-a4c4-c7f466c81d3a@redhat.com>
Date:   Fri, 1 Dec 2023 21:06:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: Fix misplaced parenthesis of a likely()
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20231201145936.5ddfdb50@gandalf.local.home>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231201145936.5ddfdb50@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.12.23 20:59, Steven Rostedt wrote:
> From: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Running my yearly branch profiler to see where likely/unlikely annotation
> may be added or removed, I discovered this:
> 
> correct incorrect  %        Function                  File              Line
>   ------- ---------  -        --------                  ----              ----
>         0   457918 100 page_try_dup_anon_rmap         rmap.h               264
> [..]
>    458021        0   0 page_try_dup_anon_rmap         rmap.h               265
> 

That looks like a handy tool!

> I thought it was interesting that line 264 of rmap.h had a 100% incorrect
> annotation, but the line directly below it was 100% correct. Looking at the
> code:
> 
> 	if (likely(!is_device_private_page(page) &&
> 	    unlikely(page_needs_cow_for_dma(vma, page))))
> 
> It didn't make sense. The "likely()" was around the entire if statement
> (not just the "!is_device_private_page(page)"), which also included the
> "unlikely()" portion of that if condition.

Yes, that was clearly misplaced.

> 
> If the unlikely portion is unlikely to be true, that would make the entire
> if condition unlikely to be true, so it made no sense at all to say the
> entire if condition is true.
> 
> What is more likely to be likely is just the first part of the if statement
> before the && operation. It's likely to be a misplaced parenthesis. And
> after making the if condition broken into a likely() && unlikely(), both
> now appear to be correct!
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

But

> Cc: stable@vger.kernel.org

stable, really? Why?

> Fixes:fb3d824d1a46c ("mm/rmap: split page_dup_rmap() into page_dup_file_rmap() and page_try_dup_anon_rmap()")

and does it even fix a real bug?

-- 
Cheers,

David / dhildenb

