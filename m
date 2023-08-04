Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBDF770B31
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjHDVqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjHDVqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:46:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A68CF7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691185521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=weedpLZSxXWVJh6Mq8AZeRZyHNVXA0yXoLLHsvv4P0Q=;
        b=H3lD0voRETVHJIpYCn9GbCJ2Xg70co4T18DPWZ6NVTAA+SvLVgvSLDPa4O/9xQXAxyAH7/
        cyEPu8QAIgRYojKkR3IewDCxWE1dSFMgZ5PHKrgk2DIqS5A95Q1GKfyuJb6O3weef6BLts
        gcsyhYDGFCviU4dgeT/7BvWQ7CElSDA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-peg0BYo6NZGM_AvL3PLAlw-1; Fri, 04 Aug 2023 17:45:20 -0400
X-MC-Unique: peg0BYo6NZGM_AvL3PLAlw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99bcf6ae8e1so158635266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 14:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691185519; x=1691790319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=weedpLZSxXWVJh6Mq8AZeRZyHNVXA0yXoLLHsvv4P0Q=;
        b=AYe12BjD9dy0f00zoVqVK/Fv3b5iJxrZckLLFc5by8JRFNtDIYnkHbx4V9I0GObajT
         7eH7FmdbKeMuGWsuSz0mjCGa9SiTI/OfFAp1WtqF31EI2j5WNspHr9aSPffeVuwlJ2xu
         b5+/TkiyWaTEm39iOU2FkvRXhC47MrZ9r5SDPfukXdDbtYgWUZSxeeHO8GN3kPoEmyJE
         +BLxaSA/DLaxA5pluqQgFtKKtcUGJEEkN2yM8zWyL6NGDDXZIWpRz8AHj69bi/50lQnG
         Fls5gY5A87WOHShYyymoWMA9f3eq300hxfqiyt0+CRCehqidCsHo6/+0bOpBTNPp9+N6
         68fQ==
X-Gm-Message-State: AOJu0YymFTEM7n9pupyrqli92vif4IAJEEbGrCNX5U7tqNaUsFFzbLaz
        4welBvXb7xxCXuJ53Tb/JZfRhclbvviHpx5ECTzjRT3IAjDLV9UJk0zfGo7EmojzoDcz2Fz0p80
        pQHJHSiUEzD0yfj2QS55/gpVpDwH9bAM0
X-Received: by 2002:a17:906:2d9:b0:99c:b65b:54eb with SMTP id 25-20020a17090602d900b0099cb65b54ebmr298066ejk.59.1691185518916;
        Fri, 04 Aug 2023 14:45:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvXGrDwsX0Hs7WTUd0o9xGL32NZmwRm8rFwc+kRmGyRlbS+oy5ZHScBDkD3HLZjlxT1LRzAg==
X-Received: by 2002:a17:906:2d9:b0:99c:b65b:54eb with SMTP id 25-20020a17090602d900b0099cb65b54ebmr298057ejk.59.1691185518541;
        Fri, 04 Aug 2023 14:45:18 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id u26-20020a170906c41a00b0099bcdfff7cbsm1811438ejz.160.2023.08.04.14.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 14:45:17 -0700 (PDT)
Message-ID: <c5bdcd8e-c6cd-d586-499c-4a2b7528cda9@redhat.com>
Date:   Fri, 4 Aug 2023 23:45:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 11/19] KVM:VMX: Emulate read and write to CET MSRs
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Chao Gao <chao.gao@intel.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, peterz@infradead.org,
        john.allen@amd.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com,
        binbin.wu@linux.intel.com
References: <20230803042732.88515-1-weijiang.yang@intel.com>
 <20230803042732.88515-12-weijiang.yang@intel.com>
 <ZMyJIq4CgXxudJED@chao-email> <ZM1tNJ9ZdQb+VZVo@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ZM1tNJ9ZdQb+VZVo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/23 23:27, Sean Christopherson wrote:
>>> +
>>> +	if (!kvm_cpu_cap_has(X86_FEATURE_SHSTK) &&
>>> +	    !kvm_cpu_cap_has(X86_FEATURE_IBT))
>>> +		return false;
>>> +
>>> +	return msr->host_initiated ||
>>> +		guest_cpuid_has(vcpu, X86_FEATURE_IBT) ||
>>> +		guest_cpuid_has(vcpu, X86_FEATURE_SHSTK);
>
> Similar to my suggestsion for XSS, I think we drop the waiver for host_initiated
> accesses, i.e. require the feature to be enabled and exposed to the guest, even
> for the host.

No, please don't.  Allowing host-initiated accesses is what makes it 
possible to take the list of MSR indices and pass it blindly to 
KVM_GET_MSR and KVM_SET_MSR.  This should be documented, will send a patch.

Paolo

