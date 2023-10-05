Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACD87BA7D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjJERWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjJERVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:21:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4BB5598
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696526087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vi28Kgz7Bt6IAfBqCstGNVn22DgimJfRwJGSiXFrw5Y=;
        b=Y7ZbYbcre98zJOak0nDl73jgZgU627P6AlDv1DGsK7m9bz75zyRw+M7VWkwWZx1l2FdzX8
        x7uSy8Vh7KjnatzZRtHM5nrcvJj3nfzS5uMpbndj9Tm1D3HWnhrBrK0KxLzmsudwcpn87y
        cAIi4Hp6GuQlxiwfbVqQ7DPDrmTWXzE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-jFKQcAp8N_yqzfXExKAYHw-1; Thu, 05 Oct 2023 13:14:46 -0400
X-MC-Unique: jFKQcAp8N_yqzfXExKAYHw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-534695ab33eso1109180a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 10:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696526085; x=1697130885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vi28Kgz7Bt6IAfBqCstGNVn22DgimJfRwJGSiXFrw5Y=;
        b=RHyUSzFwVsVO7nYTTqF6RPXuMwF6dTLmq2+u8mjoy5+7mFOvY9cHSJoVCbkMNI0XUG
         qX0saa1X6UlQHRp+iJMtNmJ3hclE0QDEM9IeMOIEiv7OjYOwWdKXHS2qPestWqHJZPlW
         cJnzR0l1nNFIug5LS592ypczcJTqIuuuc8U1WEtxka8txn9oRNFl+rhQb/Fi8AMYp2rm
         9RmpL5wHpuaXzASMwWNa08p8QmuPJ8aCN75bvJ01QkTC6/UEBGd2AV4333s/whYKAZTe
         ugJE6+gGb6CbMSKqjpgrCngC8cC9ISQz0t85AAG24M5GeormtrXpl6IPYTlBYOSqQoA9
         5kwg==
X-Gm-Message-State: AOJu0YyyksiKld9F7X4ByNcvj2kulZAgtxFbh3zlSEwgrKpMi2gPjQ37
        zIp8SAzJdtBQvQwgyHRc/kC3xxwEpSe9Xyvm59msSy+SQHZB4zCeSzMucpRzKz7QyDMRkTL7nWL
        LRpLosrOvrC0HqGj/gK40eKj8
X-Received: by 2002:a05:6402:2031:b0:52b:d169:b37a with SMTP id ay17-20020a056402203100b0052bd169b37amr5609272edb.28.1696526085553;
        Thu, 05 Oct 2023 10:14:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFId0jiqDyGCMVktBZoQhEqwkRkqAWSARMsu87vlS5RLXeAUAMy7IzXrPw+Tx2bjAQ6BpjDiQ==
X-Received: by 2002:a05:6402:2031:b0:52b:d169:b37a with SMTP id ay17-20020a056402203100b0052bd169b37amr5609258edb.28.1696526085273;
        Thu, 05 Oct 2023 10:14:45 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id f17-20020a056402161100b00537666d307csm1351182edv.32.2023.10.05.10.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 10:14:44 -0700 (PDT)
Message-ID: <b9a454c9-e8aa-02f0-29d5-57753d797cfb@redhat.com>
Date:   Thu, 5 Oct 2023 19:14:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86: KVM: Add feature flag for AMD's
 FsGsKernelGsBaseNonSerializing
Content-Language: en-US
To:     Jim Mattson <jmattson@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jiaxi Chen <jiaxi.chen@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20231004002038.907778-1-jmattson@google.com>
 <01009a2a-929e-ce16-6f44-1d314e6bcba5@intel.com>
 <CALMp9eR+Qudg++J_dmY_SGbM_kr=GQcRRcjuUxtm9rfaC_qeXQ@mail.gmail.com>
 <20231004075836.GBZR0bLC/Y09sSSYWw@fat_crate.local>
 <8c810f89-43f3-3742-60b8-1ba622321be8@redhat.com>
 <CALMp9eR=URBsz1qmTcDU5ixncUTkNgxJahLbfyZXYr-2RkBPng@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CALMp9eR=URBsz1qmTcDU5ixncUTkNgxJahLbfyZXYr-2RkBPng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 19:06, Jim Mattson wrote:
> On Thu, Oct 5, 2023 at 9:39 AM Paolo Bonzini<pbonzini@redhat.com>  wrote:
> 
>> I agree with Jim that it would be nice to have some bits from Intel, and
>> some bits from AMD, that current processors always return as 1.  Future
>> processors can change those to 0 as desired.
> That's not quite what I meant.
> 
> I'm suggesting a leaf devoted to single bit negative features. If a
> bit is set in hardware, it means that something has been taken away.
> Hypervisors don't need to know exactly what was taken away. For this
> leaf only, hypervisors will always pass through a non-zero bit, even
> if they have know idea what it means.

Understood, but I'm suggesting that these might even have the right 
polarity: if a bit is set it means that something is there and might not 
in the future, even if we don't know exactly what.  We can pass through 
the bit, we can AND bits across the migration pool to define what to 
pass to the guest, we can force-set the leaves to zero (feature 
removed).  Either way, the point is to group future defeatures together.

That said, these bits are only for documentation/debugging purposes 
anyway.  So I like the idea because it would educate the architects 
about this issue, more than because it is actually useful...

Paolo

