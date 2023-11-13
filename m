Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FFF7E9EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjKMOnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMOni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:43:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A60171A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699886569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=0MSYzgKdRzAIvSTCFRaow8/UJbg0QmjK6vKAtAvVEk0=;
        b=BzbxCy24Mg3nRsM1LQ0eEdaTMcUNVXfH48qQxW1PJkXOaz9JCYgQC+n5r8RMij8BYFFOXE
        kzlRl1lcwK0kv6LqNJGiyFMahBSdT0ESNqUa+tqiDNSsru0FWqFvVxALaMr/DHftVPr/hu
        TmKytqdvT/+U+3CsDOuo6TeIxoi2aSQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-cc_6qjYUPBStctZbR76GyQ-1; Mon, 13 Nov 2023 09:42:47 -0500
X-MC-Unique: cc_6qjYUPBStctZbR76GyQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-407d3e55927so29664695e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699886566; x=1700491366;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MSYzgKdRzAIvSTCFRaow8/UJbg0QmjK6vKAtAvVEk0=;
        b=WZZz7c1/39flpj6Sazn6gN3i7nSYnA1IKTJftRaUqns3VqhMeUB+TDxdzUEmE/h/L1
         rwyUlbr6YA9qju363jy6sXQgKC2/MZXiuUutWOkTWA1C2ZcWi00Z9S3c4KGqaxzNEhX2
         DB5dxYoLIA+GY7iEoUn6N+xPOeUKdEdS6V0GuOY9mT7F1y1CzlVcovo2SprUrBs+TZIb
         cvVFeDUGHyV+ywkmlsH4ziNyINoSYmJgqz+q2hmU7HDAyUQDeljuBeVgi1K49+4B+Lrl
         yn5wpM/V8q9UKEbJBXU1PZwW+9c/u+wXx9g9SBBT90XTn1CDED1eJ6VuVDatYYGSRWzx
         X7xA==
X-Gm-Message-State: AOJu0YxTaMZQZu/SYaskhI/SNwpsWq6F7P7BPdPhVM4N34Qlm9o1zjkp
        YymMD8xGld6vB5Bhz1UCFYYdnJiWWo0WXhUzoqE1c+O+7G4S9z3z7m4uaC2kHdQR3iHjGm7aUUA
        sDBzKAFXNjyWfZj/p4/tDKjFj
X-Received: by 2002:a05:600c:600a:b0:405:e492:8aef with SMTP id az10-20020a05600c600a00b00405e4928aefmr5896559wmb.40.1699886566540;
        Mon, 13 Nov 2023 06:42:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0W5bq64qycpev3lU5/rXQHk0KcSKsfMnaQXqcZpeSfYmyn+DmfB1AW/fInmzXsa3jVw3Jrw==
X-Received: by 2002:a05:600c:600a:b0:405:e492:8aef with SMTP id az10-20020a05600c600a00b00405e4928aefmr5896537wmb.40.1699886566139;
        Mon, 13 Nov 2023 06:42:46 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6f99.dip0.t-ipconnect.de. [91.12.111.153])
        by smtp.gmail.com with ESMTPSA id m16-20020a7bca50000000b0040841e79715sm8155647wml.27.2023.11.13.06.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 06:42:45 -0800 (PST)
Message-ID: <fcf4e8b3-0ed9-44b6-8bcf-76671acec297@redhat.com>
Date:   Mon, 13 Nov 2023 15:42:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG?] mm/secretmem: memory address mapped to memfd_secret can be
 used in write syscall.
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     David Wang <00107082@163.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <61159548.60cf.18baec1fd65.Coremail.00107082@163.com>
 <60081af2-d580-4f82-9233-3d3d7dd883bc@redhat.com> <ZVIj_cDIzat39lQ6@mit.edu>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZVIj_cDIzat39lQ6@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.11.23 14:26, Theodore Ts'o wrote:
> On Mon, Nov 13, 2023 at 10:15:05AM +0100, David Hildenbrand wrote:
>>
>> According to the man page:
>>
>> "The  memory areas backing the file created with memfd_secret(2) are visible
>> only to the processes that have access to the file descriptor. The memory
>> region is removed from the kernel page tables and only the page tables  of
>> the  processes  holding  the file descriptor map the corresponding physical
>> memory.  (Thus, the pages in the region can't be accessed by the kernel
>> itself, so that, for example, pointers  to  the region can't be passed to
>> system calls.)
>>
>> I'm not sure if the last part is actually true, if the syscalls end up
>> walking user page tables to copy data in/out.
> 
> The idea behind removing it from the kernel page tables is so that
> kernel code running in some other process context won't be able to
> reference the memory via the kernel address space.  (So if there is
> some kind of kernel zero-day which allows arbitrary code execution,
> the injected attack code would have to play games with page tables
> before being able to reference the memory --- this is not
> *impossible*, just more annoying.)
> 
> But if you are doing a buffered write, the copy from the user-supplied
> buffer to the page cache is happening in the process's context.  So
> "foreground kernel code" can dereference the user-supplied pointer
> just fine.

Right, so the statement in the man page is imprecise.

-- 
Cheers,

David / dhildenb

