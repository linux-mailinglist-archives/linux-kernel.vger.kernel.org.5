Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D976D78710A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241341AbjHXOGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240831AbjHXOGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:06:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2346219BB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692885939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/kdlyY1rxLStA0sZIf31nmHBWQd408u/RI4yuAsVY9M=;
        b=a/q0qDcF2I4mc4xDsKi4c8kPJ+s+IbHAZjgivyeU3cM4xae9FdnFWrozmUFh6mom1P9m9I
        JU2Xf0U3zPkkIqFMAB83vlEgywghbvc8+6BpZYUadGTByyt83KNBUM/Tn92x8g6pgpwKzh
        x8MoRisLZrEJtUA54QNQq0vB/3Ji4LU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-zka2SKsfMAqz6nyH7tcMWw-1; Thu, 24 Aug 2023 10:05:36 -0400
X-MC-Unique: zka2SKsfMAqz6nyH7tcMWw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3ff00714328so15932895e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692885933; x=1693490733;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kdlyY1rxLStA0sZIf31nmHBWQd408u/RI4yuAsVY9M=;
        b=d8VN3RMcFbcXIKPaKw+gYBXvX9EpVf3KMjBhTWBN23cQof9qUrrCn1Qdmhidz1eup8
         l9xa8MK/RKNQNtOKigxrjndA0559FstpiP1pFxuaKROt97YVGtscn/dDsTL53R9qbHQn
         fDdc3onep78Ig//G9CkDb4VoYSAPrkWuri6jJkVQkgA5/Hx6q3vWIPnAeFK0ts1Vc15E
         +GIJ89FCn7VTa/HuAqcnmt998UeJMPIAgzmDn8awNLh+OJDBHptRansHP7K3BFabrmVZ
         XSn3OZpPO/nGptQhN4ZAEt9UB/rXNMIJyv5ctQX3pyygeENyVXnU7+an3kbrrBmUn0Dx
         ZC3A==
X-Gm-Message-State: AOJu0Yzc27A0LU9HVDhF0yn0AIOrAhEvuAYnd+ENrLHSUAmO7mXt/+Ce
        vwqmhDeAo+tiDN2bB41kULdMLLu7NE751V8gNIMxr6PrNOIKam9ymSNxpIs2zalfiJ7btoo+IPu
        POMf+JbQx+2FdjE3a+cYExHBt
X-Received: by 2002:a1c:7303:0:b0:3fa:8db4:91ec with SMTP id d3-20020a1c7303000000b003fa8db491ecmr11345476wmb.10.1692885933594;
        Thu, 24 Aug 2023 07:05:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH01Vq2LWrop3ypAQ3hCvb48NoDnpC9x+5DOwowE3VE9xlmzqmQzGCt57dBR6Fg9yGpp96bAA==
X-Received: by 2002:a1c:7303:0:b0:3fa:8db4:91ec with SMTP id d3-20020a1c7303000000b003fa8db491ecmr11345446wmb.10.1692885933092;
        Thu, 24 Aug 2023 07:05:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:6200:16ba:af70:999d:6a1a? (p200300cbc709620016baaf70999d6a1a.dip0.t-ipconnect.de. [2003:cb:c709:6200:16ba:af70:999d:6a1a])
        by smtp.gmail.com with ESMTPSA id k16-20020a7bc410000000b003fee849df23sm2744831wmi.22.2023.08.24.07.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 07:05:32 -0700 (PDT)
Message-ID: <3e08d48b-7b70-cc7f-0ec1-12ad9b1a33db@redhat.com>
Date:   Thu, 24 Aug 2023 16:05:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
Content-Language: en-US
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     linux-mm@kvack.org, Yang Shi <shy828301@gmail.com>,
        linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20230821234844.699818-1-zokeefe@google.com>
 <37c2b525-5c2c-d400-552c-9ccb91f4d7bf@redhat.com>
 <CAAa6QmSHF6-9aFa68WDcb+WATh2Yz=wXyp8VBLDNv6yPp2SS5Q@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAAa6QmSHF6-9aFa68WDcb+WATh2Yz=wXyp8VBLDNv6yPp2SS5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.23 15:59, Zach O'Keefe wrote:
> On Thu, Aug 24, 2023 at 12:39 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 22.08.23 01:48, Zach O'Keefe wrote:
>>> The 6.0 commits:
>>>
>>> commit 9fec51689ff6 ("mm: thp: kill transparent_hugepage_active()")
>>> commit 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
>>>
>>> merged "can we have THPs in this VMA?" logic that was previously done
>>> separately by fault-path, khugepaged, and smaps "THPeligible" checks.
>>>
>>> During the process, the semantics of the fault path check changed in two
>>> ways:
>>>
>>> 1) A VM_NO_KHUGEPAGED check was introduced (also added to smaps path).
>>> 2) We no longer checked if non-anonymous memory had a vm_ops->huge_fault
>>>      handler that could satisfy the fault.  Previously, this check had been
>>>      done in create_huge_pud() and create_huge_pmd() routines, but after
>>>      the changes, we never reach those routines.
>>>
>>> During the review of the above commits, it was determined that in-tree
>>> users weren't affected by the change; most notably, since the only relevant
>>> user (in terms of THP) of VM_MIXEDMAP or ->huge_fault is DAX, which is
>>> explicitly approved early in approval logic.  However, there is at least
>>> one occurrence where an out-of-tree driver that used
>>> VM_HUGEPAGE|VM_MIXEDMAP with a vm_ops->huge_fault handler, was broken.
>>
>> ... so all we did is break an arbitrary out-of-tree driver? Sorry to
>> say, but why should we care?
>>
>> Is there any in-tree code affected and needs a "Fixes:" ?
> 
> The in-tree code was taken care of during the rework .. but I didn't
> know about the possibility of a driver hooking in here.

And that's the problem of the driver, no? It's not the job of the kernel 
developers to be aware of each out-of-tree driver to not accidentally 
break something in there.

> 
> I don't know what the normal policy / stance here is, but I figured
> the change was simple enough that it was worth helping out.

If you decide to be out-of-tree, then you have be prepared to only 
support tested kernels and fix your driver when something changes 
upstream -- like upstream developers would do for you when it would be 
in-tree.

So why can't the out-of-tree driver be fixed, similarly to how we would 
have fixed it if it would be in-tree?

-- 
Cheers,

David / dhildenb

