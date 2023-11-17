Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B387EEB5F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 04:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345658AbjKQDTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 22:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjKQDTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 22:19:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75652D4D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 19:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700191179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jAKFfPiqJuGzP2s6H3e1McPERpD8hKdLrmeMzG7k6Hw=;
        b=ZVvqw9jt6GUS5tj0UDDAfa87si02ENsPtHXsKcFQSuzKXgk0aI8xouf0PMkFE3MLaUWCTv
        mgdEBaAPuKb5oEKce2li79DPxVQA1ZJUfOjeHRVdNGL0HgbJ0706I4jSeC9CClJVxxGhKa
        nglKTzbIn2Mu4L7px5JOe58W6nW3nfI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-cg7_FH0GMG-Nw1yeBV2jkw-1; Thu, 16 Nov 2023 22:19:38 -0500
X-MC-Unique: cg7_FH0GMG-Nw1yeBV2jkw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6b2df09dcdcso516437b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 19:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700191176; x=1700795976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAKFfPiqJuGzP2s6H3e1McPERpD8hKdLrmeMzG7k6Hw=;
        b=gMVmYmjaiAapCHCmBDe2FmMkry0gdkS+P6PwrkuXp/I4CLkqet18Nd540a5iumNBD2
         VE3LgxRz7oSEoDTCz+NzgsJE7E4FGzc7uliuu3Z7I0jAf15FZc38oEN6lCkbBGo9jPzI
         IdRrJykR7cZ662gKte3/Io1gPkprOUvK2o+EdFs3SypFjjK+K4jkVd+8bJKSH7Txv9i1
         E10+h42WZ2bmCEoSe3imVlsizAYJVmhPICa6Ls0HTAu/r8bHXeL67VI2naUZaLr6n9yl
         SEZziVf5uZnEu16oDrPIPMefnV32Oq2Vktr3O7pmJO4JPjYLO5+5/c0XrX7uKqFrekjf
         zCRA==
X-Gm-Message-State: AOJu0YyIJmoLXTWdr4pmcD++3T45eBO9xxuFd2gpXJduKy3UoVTl+s54
        JW6xYOOaydv/Vm4kE9a0/6i1wLV89BWc4yY7HQzU/sQvzRXXW0EymAmrT0TOrz0mblt9uS3DX2t
        v3B4tnok3FzSiS3ZAN7dyprEvKFz86fLx5WlBGQ==
X-Received: by 2002:a05:6a00:8998:b0:6b3:c72d:b01 with SMTP id hx24-20020a056a00899800b006b3c72d0b01mr8240468pfb.1.1700191176692;
        Thu, 16 Nov 2023 19:19:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfpURZkDv/ezuJd6cSD4adKTKntnTXg/JeSPEJHMKPZoI8mQ8dl34F8ROKL9i11G2GXcaKFg==
X-Received: by 2002:a05:6a00:8998:b0:6b3:c72d:b01 with SMTP id hx24-20020a056a00899800b006b3c72d0b01mr8240451pfb.1.1700191176340;
        Thu, 16 Nov 2023 19:19:36 -0800 (PST)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id it14-20020a056a00458e00b006c8721330fesm455416pfb.74.2023.11.16.19.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 19:19:35 -0800 (PST)
Message-ID: <041416db-1cb5-e84f-ce44-9d06707970a8@redhat.com>
Date:   Fri, 17 Nov 2023 11:19:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] KVM: selftests: Initalize sem_vcpu_[cont|stop] before
 each test in dirty_log_test
Content-Language: en-US
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231116093536.22256-1-shahuang@redhat.com>
 <ZVaxXJ4xUW1eyQEL@thinky-boi>
From:   Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <ZVaxXJ4xUW1eyQEL@thinky-boi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On 11/17/23 08:18, Oliver Upton wrote:
> Hi Shaoqin,
> 
> On Thu, Nov 16, 2023 at 04:35:36AM -0500, Shaoqin Huang wrote:
>> When execute the dirty_log_test on some aarch64 machine, it sometimes
>> trigger the ASSERT:
>>
>> ==== Test Assertion Failure ====
>>    dirty_log_test.c:384: dirty_ring_vcpu_ring_full
>>    pid=14854 tid=14854 errno=22 - Invalid argument
>>       1  0x00000000004033eb: dirty_ring_collect_dirty_pages at dirty_log_test.c:384
>>       2  0x0000000000402d27: log_mode_collect_dirty_pages at dirty_log_test.c:505
>>       3   (inlined by) run_test at dirty_log_test.c:802
>>       4  0x0000000000403dc7: for_each_guest_mode at guest_modes.c:100
>>       5  0x0000000000401dff: main at dirty_log_test.c:941 (discriminator 3)
>>       6  0x0000ffff9be173c7: ?? ??:0
>>       7  0x0000ffff9be1749f: ?? ??:0
>>       8  0x000000000040206f: _start at ??:?
>>    Didn't continue vcpu even without ring full
>>
>> The dirty_log_test fails when execute the dirty-ring test, this is
>> because the sem_vcpu_cont and the sem_vcpu_stop is non-zero value when
>> execute the dirty_ring_collect_dirty_pages() function. When those two
>> sem_t variables are non-zero, the dirty_ring_wait_vcpu() at the
>> beginning of the dirty_ring_collect_dirty_pages() will not wait for the
>> vcpu to stop, but continue to execute the following code. In this case,
>> before vcpu stop, if the dirty_ring_vcpu_ring_full is true, and the
>> dirty_ring_collect_dirty_pages() has passed the check for the
>> dirty_ring_vcpu_ring_full but hasn't execute the check for the
>> continued_vcpu, the vcpu stop, and set the dirty_ring_vcpu_ring_full to
>> false. Then dirty_ring_collect_dirty_pages() will trigger the ASSERT.
>>
>> Why sem_vcpu_cont and sem_vcpu_stop can be non-zero value? It's because
>> the dirty_ring_before_vcpu_join() execute the sem_post(&sem_vcpu_cont)
>> at the end of each dirty-ring test. It can cause two cases:
>>
>> 1. sem_vcpu_cont be non-zero. When we set the host_quit to be true,
>>     the vcpu_worker directly see the host_quit to be true, it quit. So
>>     the log_mode_before_vcpu_join() function will set the sem_vcpu_cont
>>     to 1, since the vcpu_worker has quit, it won't consume it.
>> 2. sem_vcpu_stop be non-zero. When we set the host_quit to be true,
>>     the vcpu_worker has entered the guest state, the next time it exit
>>     from guest state, it will set the sem_vcpu_stop to 1, and then see
>>     the host_quit, no one will consume the sem_vcpu_stop.
>>
>> When execute more and more dirty-ring tests, the sem_vcpu_cont and
>> sem_vcpu_stop can be larger and larger, which makes many code paths
>> don't wait for the sem_t. Thus finally cause the problem.
>>
>> Fix this problem is easy, simply initialize the sem_t before every test.
>> Thus whatever the state previous test left, it won't interfere the next
>> test.
> 
> In your changelog you describe what sounds like a semaphore imbalance at
> the time of test completion, yet your proposed fix is to just clobber
> the error and start fresh.
> 

Yes. It's a semaphore imbalance problem.

> Why not nip it at the bud and fix the logic bug instead?

I have another patch which fix the logic bug, I will send it out later.

> 

-- 
Shaoqin

