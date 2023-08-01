Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2E976B97D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjHAQQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjHAQQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:16:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE23198
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690906553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFOWMuiniORO49YwegiVgeiHM1mUI62YaxCFbHJJ65A=;
        b=cF0pi4Rrn5Vow9cylGRut0eituyVduyJkyhBKtVDSgcNw8FQ/nbEU7ins0IHr9Px+tHeyj
        Bs4rhsjARTvHrAWIb+LQgfGh8NOXvTdYqOtG3+k+btfd3TbGuSsROAotXbBaNyIjsXT9s/
        p1sMF/bztKCnRishBS5uHEi3Fbbizvs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-vP-Mt0sKMy62vjV9rIfC7A-1; Tue, 01 Aug 2023 12:15:52 -0400
X-MC-Unique: vP-Mt0sKMy62vjV9rIfC7A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe2a5ced6dso5129025e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 09:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690906551; x=1691511351;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFOWMuiniORO49YwegiVgeiHM1mUI62YaxCFbHJJ65A=;
        b=fk+uztRIoTVl6czR+WnFyoG2L+lzljg6yBb0aBSkw5+xRosYVXt81glp35Zc+blIFZ
         RoVLFw9gh/cGVmNQdJYQLYkmZoV7dLRreKqiSR4VT3Y8pIuvIhfxKoZS5W9pTNv/VcmC
         tM9I8+6kbpEW4/+Myboz9M2QtNkNwlqcT3RDZTvx4Wl3Sa2E52h7an11P1GNq0Mx76sL
         z4yVQlvfS/P8Ik9l20ILKDGnZooZFJ8WqKgcs0fgFQX0KUAWYS6Ww9HrOut820Wx6iAp
         oYsjS54gul+duth5CJsnTvMS53OlvI/WMflB0i35g7nO7iWMbKaL7vKdjRGIXTI5VPdA
         dOlg==
X-Gm-Message-State: ABy/qLa7gGIV44GzAm+UdFF/T/j9F+iXVZ2BNebl2eZoxvqs9U7DWXye
        lkdmk2yjVZfH89x+JvWK1tT/kemI/tWV27uTD1+oZC19VIwb93rqtWJLpEGR8fD+JSNQo0UQOO4
        1TSGtP/zp4cN3oYcxUOr81HvZ
X-Received: by 2002:a05:600c:215a:b0:3fe:1820:2447 with SMTP id v26-20020a05600c215a00b003fe18202447mr2804536wml.21.1690906550839;
        Tue, 01 Aug 2023 09:15:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFevGQtmVAGPlMaUXjii2Ctv0aJTKLmXl6/VsEHj+ZxnwzOQpAFPv/TCZKzFkPu+a5+a4EGfQ==
X-Received: by 2002:a05:600c:215a:b0:3fe:1820:2447 with SMTP id v26-20020a05600c215a00b003fe18202447mr2804514wml.21.1690906550506;
        Tue, 01 Aug 2023 09:15:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:d100:871b:ec55:67d:5247? (p200300cbc705d100871bec55067d5247.dip0.t-ipconnect.de. [2003:cb:c705:d100:871b:ec55:67d:5247])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c025500b003fe1a96845bsm8445619wmj.2.2023.08.01.09.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 09:15:50 -0700 (PDT)
Message-ID: <30d86a2d-4af2-d840-91be-2e68c73a07bd@redhat.com>
Date:   Tue, 1 Aug 2023 18:15:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/8] mm/gup: reintroduce FOLL_NUMA as
 FOLL_HONOR_NUMA_FAULT
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, stable@vger.kernel.org
References: <20230801124844.278698-1-david@redhat.com>
 <20230801124844.278698-2-david@redhat.com> <ZMkpM95vdc9wgs9T@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZMkpM95vdc9wgs9T@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.08.23 17:48, Peter Xu wrote:
> On Tue, Aug 01, 2023 at 02:48:37PM +0200, David Hildenbrand wrote:
>> @@ -2240,6 +2244,12 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
>>   		gup_flags |= FOLL_UNLOCKABLE;
>>   	}
>>   
>> +	/*
>> +	 * For now, always trigger NUMA hinting faults. Some GUP users like
>> +	 * KVM really require it to benefit from autonuma.
>> +	 */
>> +	gup_flags |= FOLL_HONOR_NUMA_FAULT;
> 
> Since at it, do we want to not set it for FOLL_REMOTE, which still sounds
> like a good thing to have?

I thought about that, but decided against making that patch here more 
complicated to eventually rip it again all out in #4.

I fully agree that FOLL_REMOTE does not make too much sense, but let's 
rather keep it simple for this patch.


Thanks!

> 
> Other than that, looks good here.
> 
> Side note: when I was looking at the flags again just to check the
> interactions over numa balancing, I found FOLL_NOFAULT and I highly suspect
> that's not needed, instead it just wants to use follow_page[_mask]() with
> some proper gup flags passed over.. but that's off topic.

Be prepared for my proposal of removing foll_flags from follow_page() ;)

(accompanied by a proper documentation)

Especially as we have FOLL_PIN users of FOLL_NOFAULT, follow_page() is a 
bad fit.

-- 
Cheers,

David / dhildenb

