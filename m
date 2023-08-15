Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BAF77C88F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 09:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjHOHae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 03:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbjHOHaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:30:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E4610C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692084561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GDEU9/G8qrOZdDq+xkFpm65x5rHPDpAyfBEoh8SrIbM=;
        b=P9Hu3tDUTNMZ0FLrZVqgWt4GKchaEmplKYROZ5uY/4K6FqEJLKkSvlg+j7qC6KA1C+pm8w
        y4Eismq8vp7PFr0Efxa+/mOsubJsKzNQ94smuaRWICGJOXPoVF0butz9B/9LkhL3oJGU3Z
        91RtCbA7J/GIyIhuVQE9q1kyf2kSgmE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-7Lw4yjbrMYSoeksnuAhyIQ-1; Tue, 15 Aug 2023 03:29:19 -0400
X-MC-Unique: 7Lw4yjbrMYSoeksnuAhyIQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3195d624c68so2187302f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692084558; x=1692689358;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GDEU9/G8qrOZdDq+xkFpm65x5rHPDpAyfBEoh8SrIbM=;
        b=j6fIFTNj5HHDRNUx+2lK5gki5n+SIvX3nHGV36tNZADJqaM7g9VYSGSFNK8rNncqCo
         x3XysBnX4+dVt+AACJ3BxvZykBs1bIaKaSGPfEmpsrMOG1twQlaqk01JKKSf8EBU4Fkv
         xIqPxgKjebLzb9qJ5NkRGNvDnQNkKHTfc1t9P2b7Oz/2JtGtn8ApR5SpjlZdCQB0ivKo
         fe1ommw78yfIKZGMxWRSh/y7ZDnfye6nlQipc+aGRKzKYvK6hSdHvGIUlKi3a8K/aiDi
         9/b23TFYjZ59UF/ijsuPgRS5fO6Q/x3FUJZTJhMiFVuf9Ve91wdZnJrqGAp7reVhsbbh
         7jkg==
X-Gm-Message-State: AOJu0Yyr/VwjfeF8Ypsw3RmzJ2YlWB6OmE7j9OrgumxGUQBQOHv9v2Vv
        Dx3SAY4mGoaBN68NwdRV0y04eRwT/HnMztnJn+KUjVWDhen0i3KoKqHDBWgchLGJXXyC7JOsX8O
        aGf3VlCmCblElJfbG9rAf+PVy
X-Received: by 2002:a5d:4301:0:b0:319:5e3b:d484 with SMTP id h1-20020a5d4301000000b003195e3bd484mr7683216wrq.45.1692084558193;
        Tue, 15 Aug 2023 00:29:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEEI+wTq6+vzXXuuA9J2opFcmVElEaCNNBWq/iMAo7KsRPyKerkVGllcEvyNEjO883L2YiFQ==
X-Received: by 2002:a5d:4301:0:b0:319:5e3b:d484 with SMTP id h1-20020a5d4301000000b003195e3bd484mr7683202wrq.45.1692084557858;
        Tue, 15 Aug 2023 00:29:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:3100:c642:ba83:8c37:b0e? (p200300cbc7013100c642ba838c370b0e.dip0.t-ipconnect.de. [2003:cb:c701:3100:c642:ba83:8c37:b0e])
        by smtp.gmail.com with ESMTPSA id j1-20020a056000124100b003180822cf8fsm16974798wrx.1.2023.08.15.00.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 00:29:17 -0700 (PDT)
Message-ID: <39b65258-5ab5-fdff-099a-999f5a4350ee@redhat.com>
Date:   Tue, 15 Aug 2023 09:29:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] kernel/fork: stop playing lockless games for exe_file
 replacement
Content-Language: en-US
To:     Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, koct9i@gmail.com, oleg@redhat.com,
        dave@stgolabs.net
References: <20230814172140.1777161-1-mjguzik@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230814172140.1777161-1-mjguzik@gmail.com>
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

On 14.08.23 19:21, Mateusz Guzik wrote:
> xchg originated in 6e399cd144d8 ("prctl: avoid using mmap_sem for
> exe_file serialization"). While the commit message does not explain
> *why* the change, I found the original submission [1] which ultimately
> claims it cleans things up by removing dependency of exe_file on the
> semaphore.
> 
> However, fe69d560b5bd ("kernel/fork: always deny write access to current
> MM exe_file") added a semaphore up/down cycle to synchronize the state
> of exe_file against fork, defeating the point of the original change.
> 
> This is on top of semaphore trips already present both in the replacing
> function and prctl (the only consumer).
> 
> Normally replacing exe_file does not happen for busy processes, thus
> write-locking is not an impediment to performance in the intended use
> case.  If someone keeps invoking the routine for a busy processes they
> are trying to play dirty and that's another reason to avoid any
> trickery.
> 
> As such I think the atomic here only adds complexity for no benefit.
> 
> Just write-lock around the replacement.
> 
> I also note that replacement races against the mapping check loop as
> nothing synchronizes actual assignment with with said checks but I am
> not addressing it in this patch. (Is the loop of any use to begin with?)
> 
> V2:
> - fix up comments
> - tweak commit message
> 
> Link: https://lore.kernel.org/linux-mm/1424979417.10344.14.camel@stgolabs.net/ [1]
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

