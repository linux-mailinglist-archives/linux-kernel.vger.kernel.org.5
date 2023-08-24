Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9562E7868D7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbjHXHoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240413AbjHXHoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283A81738
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692862981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5s48SD/B2F0Ftk5JWefiJvJIc+1vBQ/s0rDAcOKmVoY=;
        b=J5cSBRSLCuPNGBwCdX/G9+uwOd+ZxNApKvhmTblkHPk34qa86r4i4X55jg1DD9PmI/UM55
        Z2PNg61G1LttVCBYKwMCt4McB4z7yd/jOslP50DpYd5fuI62KYH/JQSst5d0bwB2wazTn5
        W5j3N73JsVGeheWRapf7CjkQwo/0nJI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-_-temDwZP5Gnr6QxX_tokA-1; Thu, 24 Aug 2023 03:39:40 -0400
X-MC-Unique: _-temDwZP5Gnr6QxX_tokA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fef1bbfe93so26335615e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692862780; x=1693467580;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5s48SD/B2F0Ftk5JWefiJvJIc+1vBQ/s0rDAcOKmVoY=;
        b=MiyXDHFrSu8lupEmiCQRKgABH/A+m42ENSKlVX1zgUerm0rBamlwQs5BYSHhYPlAtJ
         pHjwFCQZExbWqAGyBXlKK3xIPPGoGEfQGNCPShZfPmz2L2s2ghCdKazYZtFBxr+3tLst
         0hCRWA/biwQjSrux1/EhU+OjMpMq30Z3u8c6dPUl11RDgIvQeFLq2ZPGNXWenulQJ/lt
         R+H0h0V171OVDi/ucFgNwUegTvC81bqFW6UauCU8ka7oO3j0ZriyTssklXM8sU+TbwGl
         wPOdALwEIYYoGtaxgyGcbfZd94jNxLLfrOYoK37cO7CNanHapbqJPtpDTZyxSqrKurTu
         nPVw==
X-Gm-Message-State: AOJu0YzZT0cKc3dHgmpl1QdmYyNcm0CcCzV4gpWKwgbp2boEaB6Wefv0
        MpdbH/XwQ0GXadWe3sHoqdTizBa1CC+WIznQMEHHv8iLKDCZTZfYyT3LSzWMq2YdxNzbQqkBrQ9
        1RSfLf8khsaUHwB8k6GiZZbt3
X-Received: by 2002:a1c:4c04:0:b0:3fe:18d8:a61b with SMTP id z4-20020a1c4c04000000b003fe18d8a61bmr11390491wmf.29.1692862779815;
        Thu, 24 Aug 2023 00:39:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLxTscJLrFh6zuUUx3KeVEVNTXJwVK0dPYddTo7jXOTp6kH/W26upSHp6IHCAMKrFL3GR8Sg==
X-Received: by 2002:a1c:4c04:0:b0:3fe:18d8:a61b with SMTP id z4-20020a1c4c04000000b003fe18d8a61bmr11390477wmf.29.1692862779463;
        Thu, 24 Aug 2023 00:39:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:6200:16ba:af70:999d:6a1a? (p200300cbc709620016baaf70999d6a1a.dip0.t-ipconnect.de. [2003:cb:c709:6200:16ba:af70:999d:6a1a])
        by smtp.gmail.com with ESMTPSA id f23-20020a7bc8d7000000b003fe2de3f94fsm1576513wml.12.2023.08.24.00.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 00:39:38 -0700 (PDT)
Message-ID: <37c2b525-5c2c-d400-552c-9ccb91f4d7bf@redhat.com>
Date:   Thu, 24 Aug 2023 09:39:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
Content-Language: en-US
To:     Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
        Yang Shi <shy828301@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20230821234844.699818-1-zokeefe@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230821234844.699818-1-zokeefe@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.23 01:48, Zach O'Keefe wrote:
> The 6.0 commits:
> 
> commit 9fec51689ff6 ("mm: thp: kill transparent_hugepage_active()")
> commit 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
> 
> merged "can we have THPs in this VMA?" logic that was previously done
> separately by fault-path, khugepaged, and smaps "THPeligible" checks.
> 
> During the process, the semantics of the fault path check changed in two
> ways:
> 
> 1) A VM_NO_KHUGEPAGED check was introduced (also added to smaps path).
> 2) We no longer checked if non-anonymous memory had a vm_ops->huge_fault
>     handler that could satisfy the fault.  Previously, this check had been
>     done in create_huge_pud() and create_huge_pmd() routines, but after
>     the changes, we never reach those routines.
> 
> During the review of the above commits, it was determined that in-tree
> users weren't affected by the change; most notably, since the only relevant
> user (in terms of THP) of VM_MIXEDMAP or ->huge_fault is DAX, which is
> explicitly approved early in approval logic.  However, there is at least
> one occurrence where an out-of-tree driver that used
> VM_HUGEPAGE|VM_MIXEDMAP with a vm_ops->huge_fault handler, was broken.

... so all we did is break an arbitrary out-of-tree driver? Sorry to 
say, but why should we care?

Is there any in-tree code affected and needs a "Fixes:" ?

-- 
Cheers,

David / dhildenb

