Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C169C7A4336
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbjIRHn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240265AbjIRHnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8832810D7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695022871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7IT3U4K9VD54bV/WPMZvldY4t7MAmg3y0RzjWgKIMwI=;
        b=Zy35sG6oPsKIC1HDMoVQQKf9La2Ivxb+qA/F/NX6lp6goQJEfC9GE9BQjXRjZxCNgb5huY
        UHQMhIgaQMHsWsAA3Rf3xK4YDZs76XrtHjhbApBIQ9bYgdyZQoyyVkwujDPAX6W7SXkPpz
        F87C1QFMaKAj/dX3eb3TLAIT2tbLpJE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-Mb9WbXKNPOu8gAgchdApmg-1; Mon, 18 Sep 2023 03:41:10 -0400
X-MC-Unique: Mb9WbXKNPOu8gAgchdApmg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-317d5b38194so1757908f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695022869; x=1695627669;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7IT3U4K9VD54bV/WPMZvldY4t7MAmg3y0RzjWgKIMwI=;
        b=usQcxvu8VDrdW5Dxc1zFsMdXFDQq9L4p1rt+2WHAxhERvqgJGXKOmzzoXZdc24gs4x
         Rz+BJMhB/gxNjrwof/7k6Is/9Nz6SO12GStR56tDVGpXMQV3R9fdjykFc5GwN/XqYaje
         FH6LuZEqHhYRGHUHY2c416IUyCoz9CW3BP5v2/lJGCfzRUEC8TzB2juy3RdvR7NP+rCI
         gn0NBOTPAQZkgBNiW4a85enWxofMCjXk6WyQO4aWwJF80G9zxO1ZS2B0ebbLkkVVJsk/
         nzYS650NkBWuOqJxAior5U+qQIUQ1u3nFQptcHSFcoJ9ufRIwcQ9nrClaRVnBw65d++d
         IjwA==
X-Gm-Message-State: AOJu0YyIfRNpIlGZqYYt6VcOKuh5aeNm/ER7hyA4CJN+o99VWVqO51+j
        mIJiSINi62R4BgYbsmwo+cIFLXBi/Us/OVbZTAx2p5Xhbhwbx9e8bO2GAg1KCKxyasLGyez4MCy
        GWNUPW38zG1KgOm6JHMkPtp81k8u//uYn
X-Received: by 2002:a05:6000:8c:b0:31f:335b:f436 with SMTP id m12-20020a056000008c00b0031f335bf436mr7226294wrx.22.1695022869063;
        Mon, 18 Sep 2023 00:41:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4qZ1/Hbp5oUdMog6k+CH3bKyX0UpBGjzWfRSqELqUcOtf5cAiF3B2wK/LkBV6AXN2c2rFBA==
X-Received: by 2002:a05:6000:8c:b0:31f:335b:f436 with SMTP id m12-20020a056000008c00b0031f335bf436mr7226275wrx.22.1695022868667;
        Mon, 18 Sep 2023 00:41:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:3400:ec51:7a3a:274e:cbee? (p200300cbc74b3400ec517a3a274ecbee.dip0.t-ipconnect.de. [2003:cb:c74b:3400:ec51:7a3a:274e:cbee])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600c11ce00b003fee8502999sm14415457wmi.18.2023.09.18.00.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 00:41:08 -0700 (PDT)
Message-ID: <c5d93115-43c1-784b-8e21-70c3cc876778@redhat.com>
Date:   Mon, 18 Sep 2023 09:41:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [syzbot] [mm?] WARNING in page_add_anon_rmap
Content-Language: en-US
To:     syzbot <syzbot+6e4f59235036c3c2e296@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
References: <0000000000008bf71d06059a2276@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <0000000000008bf71d06059a2276@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.09.23 05:57, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    98897dc735cf Add linux-next specific files for 20230914
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1214a152680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1502c503717ada5c
> dashboard link: https://syzkaller.appspot.com/bug?extid=6e4f59235036c3c2e296
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15869ea0680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f1b952680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/00e4c0af5a8a/disk-98897dc7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7b54a00eee56/vmlinux-98897dc7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/100094353b8e/bzImage-98897dc7.xz
> 
> The issue was bisected to:
> 
> commit b8575fa4abaa1dee1a61f1f27a86a02757310a7e
> Author: David Hildenbrand <david@redhat.com>
> Date:   Wed Sep 13 12:51:12 2023 +0000
> 
>      mm/rmap: simplify PageAnonExclusive sanity checks when adding anon rmap
> 

Right, when PTE-mapping a THP we temporarily have an entire mapping and 
a sub-page mapping. It would even be clearer when passing RMAP_EXCLUSIVE 
from __split_huge_pmd_locked(), then setting it manually. But that's a 
different story; lets' fixup that sanity check first.

-- 
Cheers,

David / dhildenb

