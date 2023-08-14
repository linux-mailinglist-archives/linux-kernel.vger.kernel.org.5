Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324D077BDA7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjHNQKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjHNQJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:09:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EAF106
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692029355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lIUJ6WcpfPfRJeXqtbNVGmz8+UrIjkRJsJFZJdxFcxE=;
        b=hCACQNqcZPSobVEmz+zxitr7Msg5DO04s3etwpHx73aHuyyOK6pP0yQAHGYI54Bwb75GqZ
        rl45mkvb6bZwPMzuGHgYU7rbZYf9rOgps+1zmHlhpd+FWxsoJ/FfFobGncrKehQp+fdEn1
        YJ7d3sC3pXrD1LOw97+F3xt6mtTsDug=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-ilJAbIT9PNOdo2Xs7bdwsA-1; Mon, 14 Aug 2023 12:09:13 -0400
X-MC-Unique: ilJAbIT9PNOdo2Xs7bdwsA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fe25f8c4bfso30057785e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692029352; x=1692634152;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lIUJ6WcpfPfRJeXqtbNVGmz8+UrIjkRJsJFZJdxFcxE=;
        b=Vp10Mgmkvl02d4uUnOYXGkSHybVF+CSjbWlqedroc2LdrSZmpOaqlKHGvINB/CTbhw
         NWzpVx3QpZGroCtcCc8f16YhhwTAIgP4Q+u6lceGUN0ZXNUpO1JqOBPgce60CDRy9d4V
         2uKgEwHfsrRZEpvXf/6V0H1ZDISfEy9X6MKH2z77Q5Dhag69AiSa0Ls8cXCBOyyPk7Fh
         s0zXrKEtXCFoGbF6gK4lJM4XF+i6A7OvH1vcGeM3DEeRLtD0Xz10HeaGwyid/uwSbXzJ
         6iwb8BLu1yhlng/8TFwD9/mBbdHWgSDB15xjlYExjpSWhaTXXtSbFAPR3UI2GNi0xc6b
         BzfA==
X-Gm-Message-State: AOJu0YzU3wOtABhSQPftZga6Ub7lpmnfDMajeDwHL0eTGNeLEywqXCkV
        i/Ei4Ur2BfIrsSC4CYwQpNedjL4ivVL0pdbGJnkpDpZPjqcSDaGh7VsbQc7wprVVv01eyuhgnpR
        O3A3eeINmVFvrDVZKXhzzycHA
X-Received: by 2002:a05:600c:450:b0:3fc:e1:24b5 with SMTP id s16-20020a05600c045000b003fc00e124b5mr8086755wmb.23.1692029352115;
        Mon, 14 Aug 2023 09:09:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpis8Bm4xGQ4bbM2facYfh7G+38bFyuSjPO6zsqsG+tLs0PgLhvRyivqwBPf4Zqgl+Iq9+Qg==
X-Received: by 2002:a05:600c:450:b0:3fc:e1:24b5 with SMTP id s16-20020a05600c045000b003fc00e124b5mr8086732wmb.23.1692029351719;
        Mon, 14 Aug 2023 09:09:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:d900:2d94:8433:b532:3418? (p200300d82f2bd9002d948433b5323418.dip0.t-ipconnect.de. [2003:d8:2f2b:d900:2d94:8433:b532:3418])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003fe1fe56202sm14908803wmd.33.2023.08.14.09.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 09:09:11 -0700 (PDT)
Message-ID: <bf85f171-8c0b-80ab-5095-e11e1042b865@redhat.com>
Date:   Mon, 14 Aug 2023 18:09:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] kernel/fork: stop playing lockless games for exe_file
 replacement
Content-Language: en-US
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, koct9i@gmail.com, dave@stgolabs.net
References: <20230813123333.1705833-1-mjguzik@gmail.com>
 <20230814150530.GB17738@redhat.com> <20230814152038.GA2367@redhat.com>
 <52192c2f-c7b1-9c07-7ca2-10fc6bd347b0@redhat.com>
 <20230814155817.GC17738@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230814155817.GC17738@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.23 17:58, Oleg Nesterov wrote:
> On 08/14, David Hildenbrand wrote:
>>
>>> OK, I seem to understand... without mmap_read_lock() it is possible that
>>>
>>> 	- dup_mm_exe_file() sees mm->exe_file = old_exe_file
>>>
>>> 	- replace_mm_exe_file() does allow_write_access(old_exe_file)
>>>
>>> 	- another process does get_write_access(old_exe_file)
>>>
>>> 	- dup_mm_exe_file()->deny_write_access() fails
>>>
>>> Right?
>>
>>  From what I recall, yes.
> 
> Thanks! but then... David, this all is subjective, feel free to ignore, but
> the current code doesn't look good to me, I mean the purpose of mmap_read_lock()
> is very unclear. To me something like
> 
> 	if (old_exe_file) {
> 		/*
> 		 * Ensure that if we race with dup_mm_exe_file() and it sees
> 		 * mm->exe_file == old_exe_file deny_write_access(old_exe_file)
> 		 * can't fail after we do allow_write_access() and another task
> 		 * does get_write_access(old_exe_file).
> 		 */
> 		mmap_read_lock(mm);
> 		mmap_read_unlock(mm);
> 
> 		allow_write_access(old_exe_file);
> 		fput(old_exe_file);
> 	}
> 
> looks more understandable...

I don't particularly care about that code, and if there are ways to make 
it clearer, great.

As long as we can clarify in the patch description why we decided to go 
again the other direction (write lock) and not do what we did in 2015, 
that would be great.

-- 
Cheers,

David / dhildenb

