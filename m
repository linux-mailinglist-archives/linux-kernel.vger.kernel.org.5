Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5907F76DFA7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 07:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjHCFS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 01:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjHCFSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 01:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6394F3AAF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 22:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691039877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HP9tTl23R729KjlrPVLqd6TxHoZAIwRS5QaV8zqh1bA=;
        b=HYK/uSlyagX2HuCbSMJlTOaL/oDMRLDZ2WOFs+kMXXSZERItH0B9Do86sAaUdnMr5YMnaa
        j+8XL9/2SZooZq+HA5+ZM+Ps2pZVtSVojWDNPqGkaEsVMz7UOzHcTFoKf+jEZB2xQd2SkY
        yd1/XBf5fCk7iRdj83d/9Q63Z/0Va3g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-7qRHFPhEMgqUfuezyifCqg-1; Thu, 03 Aug 2023 01:17:56 -0400
X-MC-Unique: 7qRHFPhEMgqUfuezyifCqg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-63cceb8c21aso6402586d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 22:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691039876; x=1691644676;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HP9tTl23R729KjlrPVLqd6TxHoZAIwRS5QaV8zqh1bA=;
        b=d6bRmpWMN8PiMxAQPaa7spIY6fY+HW/gsChRv8/Wmd5IBsAN784oFdl7jMEEvRMFx1
         nf8jZXyJsizaPSqlzYcbqlcvMkCOfF0EsQChqHNBbUaJOEeRABWeTpqduC3GlHeH0BMp
         0Y/DPFZxYXVgvC+LbSM6wa8Awjjml+joWCvoEMKQVf5MdeOI+/FuzMpewL1rG/8PT4KO
         tW0RFSTpV6ULO1XOi/ufIp+DTOe2JvR/e/3nM7nX8J0OuZlF2aL01QpYNMb7tS92r+aq
         1fNnUwHUW8GH7qSKRT0jFDymVScFdKT2WNhSY+WCGQjO7UUAKoUOARHGIUY28y7ubceV
         XwgA==
X-Gm-Message-State: ABy/qLYec2h2hrF+dkNicCm4O3vuBEnCZBR+ROGNrm3StzY5b0Ok8QRB
        bBfZW8XuOIZFsraScbFLwbCkXwsoloqbS2Xa8X6JEn8T+tm5OlpVYljts1K8eEAZ7Jr2tc7dP8o
        bjQRiiypjcVjy0B1NEj1E5sD8
X-Received: by 2002:a05:6214:162d:b0:63d:30e9:1c8a with SMTP id e13-20020a056214162d00b0063d30e91c8amr15472201qvw.30.1691039875729;
        Wed, 02 Aug 2023 22:17:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF3hzo95Vyotb/yXcz3owfvMFfcTPETd/Ckk87+3UoEccRx2ZwISo7mgaftQO7PYfaUW1HPVw==
X-Received: by 2002:a05:6214:162d:b0:63d:30e9:1c8a with SMTP id e13-20020a056214162d00b0063d30e91c8amr15472187qvw.30.1691039875482;
        Wed, 02 Aug 2023 22:17:55 -0700 (PDT)
Received: from [192.168.8.105] (tmo-081-137.customers.d1-online.com. [80.187.81.137])
        by smtp.gmail.com with ESMTPSA id c3-20020a0ce143000000b0063d32f515bbsm6095745qvl.127.2023.08.02.22.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 22:17:54 -0700 (PDT)
Message-ID: <615ce4b8-1b82-ba6a-0546-f77e8a93bf3f@redhat.com>
Date:   Thu, 3 Aug 2023 07:17:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org,
        David Matlack <dmatlack@google.com>
References: <20230712075910.22480-1-thuth@redhat.com>
 <20230712075910.22480-3-thuth@redhat.com> <ZMq0nYYDbOX1cOKN@google.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 2/4] KVM: selftests: x86: Use TAP interface in the
 sync_regs test
In-Reply-To: <ZMq0nYYDbOX1cOKN@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 21.55, Sean Christopherson wrote:
> On Wed, Jul 12, 2023, Thomas Huth wrote:
>> The sync_regs test currently does not have any output (unless one
>> of the TEST_ASSERT statement fails), so it's hard to say for a user
>> whether a certain new sub-test has been included in the binary or
>> not. Let's make this a little bit more user-friendly and include
>> some TAP output via the kselftest_harness.h interface.
>> To be able to use the interface, we have to break up the huge main()
>> function here in more fine grained parts - then we can use the
>> TEST_F() macro to define the individual tests. Since these are run
>> with a separate VM now, we have also to make sure to create the
>> expected state at the beginning of each test, so some parts grow
>> a little bit - which should be OK considering that the individual
>> tests are more self-contained now.
>>
>> Suggested-by: David Matlack <dmatlack@google.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   .../selftests/kvm/x86_64/sync_regs_test.c     | 113 +++++++++++++++---
> 
> FYI, there's an in-flight patch[*] to expand this test's coverage, and I plan on
> grabbing that in some form before this one (sorry).  Let me know if there are
> any tweaks that can be done to Michal's patch to make it easier to convert the
> test to tap.
> 
> I'll also try to get Michal's patch into kvm-x86/next sooner than later so that
> you can use that as the basic.

Ok, I'll wait 'til the dust settles and then redo my patch (there is no 
hurry for this, and I'm only doing it in my spare minutes).

Any chance that you could already take at least the other conversion patches 
from my series?

...
>> +TEST_F(sync_regs_test, req_and_verify_all_valid)
>> +{
>> +	struct kvm_vcpu *vcpu = self->vcpu;
>> +	struct kvm_run *run = vcpu->run;
>> +	struct kvm_vcpu_events events;
>> +	struct kvm_sregs sregs;
>> +	struct kvm_regs regs;
>> +	int rv;
>>   
>>   	/* Request and verify all valid register sets. */
>>   	/* TODO: BUILD TIME CHECK: TEST_ASSERT(KVM_SYNC_X86_NUM_FIELDS != 3); */
>>   	run->kvm_valid_regs = TEST_SYNC_FIELDS;
>>   	rv = _vcpu_run(vcpu);
>> +	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
> 
> Just use vcpu_run() instead of _vcpu_run().  And please post that as a separate
> patch, I think/hope it will make the conversion-to-tap patch smaller.

Ok, makes sense.

>> +TEST_F(sync_regs_test, clear_kvm_valid_and_dirty_regs)
>> +{
>> +	struct kvm_vcpu *vcpu = self->vcpu;
>> +	struct kvm_run *run = vcpu->run;
>> +	struct kvm_regs regs;
>> +	int rv;
>> +
>> +	/* Run once to get register set */
>> +	run->kvm_valid_regs = TEST_SYNC_FIELDS;
>> +	rv = _vcpu_run(vcpu);
>> +	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
> 
> At least you're consistent :-)

Just copy-n-pasting the preexistent code ;-)

>> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
>>   
>>   	/* Clear kvm_valid_regs bits and kvm_dirty_bits.
>>   	 * Verify s.regs values are not overwritten with existing guest values
>> @@ -187,9 +246,11 @@ int main(int argc, char *argv[])
>>   	run->kvm_valid_regs = 0;
>>   	run->kvm_dirty_regs = 0;
>>   	run->s.regs.regs.rbx = 0xAAAA;
>> +	vcpu_regs_get(vcpu, &regs);
> 
> Can you split this change to its own patch too?  I'm pretty sure that change
> stands on its own, and slotting it in here made me do a double-take.

Ok.

  Thomas

