Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC7C7AE711
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjIZHpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIZHp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A824492
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695714276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iwZIo85XdAjM1M+C+foHMnmQfZc7r9SykJlxY0UfF8I=;
        b=a21242IGZ/7xOvcejkzXAf+IkbHm84aSeb5i4jCxCWwIVqhYwChIyE8DpVjkdacA03RuUk
        jUsBUZKYLXci8ucwfX0EhKSmoGDI8N6Zt3K8V9pr97LH90hY/snyCQgB06uiFtKvTT58DE
        4mz5esKcN+f++C7lEK/Fw6EcMEGwyPQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-cDV09dYiN_KYfE9776Sa_w-1; Tue, 26 Sep 2023 03:44:35 -0400
X-MC-Unique: cDV09dYiN_KYfE9776Sa_w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30e3ee8a42eso6058176f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695714274; x=1696319074;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwZIo85XdAjM1M+C+foHMnmQfZc7r9SykJlxY0UfF8I=;
        b=kTq9GfGjUej00zxafet6ewdd3s5mEJpSCb9HuIN9XuwGV7VQEg7A7jfX0/mnKbEYEp
         naCMomIzXKQb/KLw0e+s7MEW/2L/OT96gzp3V7qHTF9s0+u1MuInc25pejfOkxEomWRW
         gbTUsNHQytEr8gR+N1KSFCmpe8rsOW7cqHFUBEY/WKC1ckAI67kt74pivI1sSt3H15Z+
         gXvXM8+xW1Lhhi9gQxV43Qy9RiYe+CU+PSNcanw8YAMdYsJJCfZWsImpJcidbvt3Yhd+
         e6rcjqObNxFwJ+rbR/zBhF/J1kAp2MTxbmqJ6hce4OmBgCP1z0imWqPLp8TUOJ2MxQ+L
         rvLg==
X-Gm-Message-State: AOJu0YwEIthjAyUvvJZ8Xy+oMYCcwmjDL04VuK0NLojXggSIr/zWsaiv
        Ebr/9ITT7Tx7SrwwdaSjxyRZDqa1WGmgTjk2gTjgM8bRj+Qf5G9b0QeJGZ87azUyb3Rbr9SF/eX
        dssifjIhHcoshNqIqUx36Hv3J
X-Received: by 2002:a05:6000:1c7:b0:320:261:b87f with SMTP id t7-20020a05600001c700b003200261b87fmr9123196wrx.62.1695714274038;
        Tue, 26 Sep 2023 00:44:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgdXHXedWju/g2CC4goDU1O6V8Pp13NRe0Wc6WhQBRBDOoq7L4z/I03Hm6bYO3luuaDfip3A==
X-Received: by 2002:a05:6000:1c7:b0:320:261:b87f with SMTP id t7-20020a05600001c700b003200261b87fmr9123177wrx.62.1695714273661;
        Tue, 26 Sep 2023 00:44:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:600:933b:ca69:5a80:230d? (p200300cbc73f0600933bca695a80230d.dip0.t-ipconnect.de. [2003:cb:c73f:600:933b:ca69:5a80:230d])
        by smtp.gmail.com with ESMTPSA id y13-20020adff6cd000000b003180027d67asm13846478wrp.19.2023.09.26.00.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 00:44:33 -0700 (PDT)
Message-ID: <9777812e-c8c8-2105-cd2c-443438786172@redhat.com>
Date:   Tue, 26 Sep 2023 09:44:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] mm: pass page count and reserved to
 __init_single_page
Content-Language: en-US
To:     Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
        rppt@kernel.org
Cc:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230926023341.991124-1-yajun.deng@linux.dev>
 <20230926023341.991124-2-yajun.deng@linux.dev>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230926023341.991124-2-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.09.23 04:33, Yajun Deng wrote:
> When we init a single page, we need to mark this page reserved if it
> does. 

I failed to parse the last part of this sentence.

> And some pages may not need to set page count, such as compound
> pages.

Usually, the refcount of all tail pages *must* be zero. Otherwise, 
get_page_unless_zero() would work on tail pages.

Can you elaborate why it should be okay here?


-- 
Cheers,

David / dhildenb

