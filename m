Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE217ACA75
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 17:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjIXPUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 11:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIXPUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 11:20:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590CF9B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 08:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695568836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OC7FZ1QXsBgttnW2koSrPf6km1TCtIWkDRa462K3Tt8=;
        b=dfLQGLR6/q7QX4zutLNRciz61AHBtHNFQfXhIEDGV5u5xmqX9sIswVPCnvNaJannaZ9wY1
        TWe8ocNjV2eInnH7SGFiKcSXpSgOhva5d6qSnxjpok6loM9BwnHuHTe6ZV10K3FurxCeVw
        t1OQHn1wH9ngNf5sUtTTfdb5PByysZk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-Ye79ENtRNpC8VuL0PrH0OQ-1; Sun, 24 Sep 2023 11:20:35 -0400
X-MC-Unique: Ye79ENtRNpC8VuL0PrH0OQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30e4943ca7fso3710694f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 08:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695568833; x=1696173633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OC7FZ1QXsBgttnW2koSrPf6km1TCtIWkDRa462K3Tt8=;
        b=BnyktGthW5+ROvsXMj34z8WVd9QE8Lf7UlogYGXlqgJWnePy0noc2ikwWqkSTZmlr+
         /NcXdxjIFh2avP6wOLEyoaEuUh9eTQGFuOqlurSNLtNb7/Wl4lPeqBlepE67rR1/1U2s
         drKsAiza7btZF5qofmXxHXg1JsnUhvOu/8oNu7tRlND9//Uvpal1G/zmDQiyFmXDwd2S
         sPgytpddEfsBQJ3r3ejRa+5ROFfeh4SmHp9ScqUil2CP5BmYSKKYm3cT8uZnSQ7E50Kq
         A9Itvvu5ZbiOSwH9oF4gF7kOBHXURexWReRP4z6gBYQxUD1OtNVj7y7ijWMK9RCCdy7Z
         rtsg==
X-Gm-Message-State: AOJu0Yx/6onZSm7BGPPQBKJQ4vDhMFYWQFVpqrjmTYHzKXAa9nusbtoV
        UPDntx8IQy4AmqLS5iaEpZvKK78CZKLPQmOXkblva2/IXNRkxp22djCuzhYqrCk+fk84O7IPKn1
        iv9v4b+wMWSWkgKKHkAASVX1D9rHKMyWV
X-Received: by 2002:a05:6000:185:b0:321:8d08:855e with SMTP id p5-20020a056000018500b003218d08855emr3649143wrx.24.1695568833343;
        Sun, 24 Sep 2023 08:20:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsqiWL7t0c+NMRRqvOOczRdKyE4sP6LLCdR8ZY1UnXVwDlWDeFOsnOjGJe4ueob0DEyj/m4A==
X-Received: by 2002:a05:6000:185:b0:321:8d08:855e with SMTP id p5-20020a056000018500b003218d08855emr3649132wrx.24.1695568833012;
        Sun, 24 Sep 2023 08:20:33 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id k12-20020a7bc40c000000b00403038d7652sm9783942wmi.39.2023.09.24.08.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 08:20:32 -0700 (PDT)
Message-ID: <c00bf4c1-0bfe-c7f9-4dea-03e9c2e94b71@redhat.com>
Date:   Sun, 24 Sep 2023 17:20:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [GIT PULL] KVM fixes for Linux 6.6-rc3
Content-Language: en-US
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20230924092700.1192123-1-pbonzini@redhat.com>
 <5cfe9a47-f461-9a5e-09e3-b78fef16a6f6@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <5cfe9a47-f461-9a5e-09e3-b78fef16a6f6@huawei.com>
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

On 9/24/23 12:32, Zenghui Yu wrote:
> Hi Paolo,
> 
> On 2023/9/24 17:27, Paolo Bonzini wrote:
>> ARM:
>>
>> * Fix an UV boot crash
>>
>> * Skip spurious ENDBR generation on_THIS_IP_
>>
>> * Fix ENDBR use in putuser() asm methods
>>
>> * Fix corner case boot crashes on 5-level paging
>>
>> * and fix a false positive WARNING on LTO kernels"
> 
> Want to point out that this doesn't describe the *real* kvmarm stuff in
> the original PR [*] and doesn't match what you had written in the merge
> commit. Not sure what has gone wrong.

Used the wrong "git log --merges" incantation to generate the draft, 
which pulled in a message from the last merge commit in origin/master.

I have replaced the tag in place, but the commit is the same.  The new 
tag message is as follows:

---------------------------------
ARM:

* Fix EL2 Stage-1 MMIO mappings where a random address was used

* Fix SMCCC function number comparison when the SVE hint is set

RISC-V:

* Fix KVM_GET_REG_LIST API for ISA_EXT registers

* Fix reading ISA_EXT register of a missing extension

* Fix ISA_EXT register handling in get-reg-list test

* Fix filtering of AIA registers in get-reg-list test

x86:

* Fixes for TSC_AUX virtualization

* Stop zapping page tables asynchronously, since we don't
   zap them as often as before
---------------------------------

Paolo

> [*] https://lore.kernel.org/r/20230914144802.1637804-1-maz@kernel.org
> 
> Zenghui
> 

