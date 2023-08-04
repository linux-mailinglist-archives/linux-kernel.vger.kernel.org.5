Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93099770B9A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjHDWCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjHDWCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:02:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6D318B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 15:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691186480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C4ZlchCpS+xdEdLXvT+0MxcrrN1dXUfPKwcsJ3NX33I=;
        b=fuj6T2xSazRMF8DkJkkvvb9ZMLQ60WNyziaE0QAgPca8eFB7bgoz39Sknj0E2XYtFMvyUr
        CBGeCoVgvJvEzIZHRitTnORRqMM/Nl5rnPuyBJCjzcKKT4X7/S1l55gPZYsBV73p4N3nXy
        /OIZ7RLjMwOsbp9y7q6D4539il0h+zk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-VZoRVs12NROjzZR7OYvG1w-1; Fri, 04 Aug 2023 18:01:18 -0400
X-MC-Unique: VZoRVs12NROjzZR7OYvG1w-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fe356c71d6so2640870e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 15:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691186477; x=1691791277;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4ZlchCpS+xdEdLXvT+0MxcrrN1dXUfPKwcsJ3NX33I=;
        b=FsIDokTUggTXNt4/+1p79g5sasnAFxXukf5MZ8lyzihaQyEyyqH2ErHjX8zln/xhRd
         tcEn1w2lLPDihITj4PuWSY9odqv/qxlUVjrQ++0Obqpx2yaXeOGEN8N7The6i7l4wB+x
         /SsvrR97MCX/4ANxdEXS7Pk9wqWEpDlaD9XofGm5250g2xSBJQOytoVLrw4QHtxNByVc
         vU6cjj9gEa4PH+h4xwbsJoGcWBrZgk1A88cyeX8RyvPG0EmsRny7N96ErL0FW5xgc2++
         Mn2M0WWyopY9++/ZAmpjDOL88slx1Am03hKQ2daiNEe1MIPX3BrSHxaliY/tLEoPmZQX
         J6JA==
X-Gm-Message-State: AOJu0YzV1zC14P/Fy3EAu1NT+hajNDyoi9Vx+C7KRZaWrow7Juvddq/s
        LNs0n/phfUlG3FU6bxdAQwAQgE/7fuv4xt0iwqn22UmSnYzSCkaaMPHagA7la2N9WY2IUtr0Hku
        J9yUF4RWdTN+nUWHBOB3oD40j
X-Received: by 2002:a05:6512:2347:b0:4f9:5580:1894 with SMTP id p7-20020a056512234700b004f955801894mr2395926lfu.15.1691186477248;
        Fri, 04 Aug 2023 15:01:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+X0WyGO3YB7grTu4yDV4Lgm+3Fv/SY4n88cExgzEYZ/7oCme+ofhjKPukd4Wt4mDEkWRpnA==
X-Received: by 2002:a05:6512:2347:b0:4f9:5580:1894 with SMTP id p7-20020a056512234700b004f955801894mr2395917lfu.15.1691186476918;
        Fri, 04 Aug 2023 15:01:16 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id s15-20020aa7c54f000000b00523220e375bsm875875edr.32.2023.08.04.15.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 15:01:16 -0700 (PDT)
Message-ID: <b2440b12-9783-6a86-91e1-066397189e40@redhat.com>
Date:   Sat, 5 Aug 2023 00:01:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Chao Gao <chao.gao@intel.com>
Cc:     Weijiang Yang <weijiang.yang@intel.com>, peterz@infradead.org,
        john.allen@amd.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com,
        binbin.wu@linux.intel.com
References: <20230803042732.88515-1-weijiang.yang@intel.com>
 <20230803042732.88515-9-weijiang.yang@intel.com>
 <ZMuDyzxqtIpeoy34@chao-email>
 <83d767df-c9ef-1bee-40c0-2360598aafa8@intel.com>
 <ZMyR5Ztfjd9EMgIR@chao-email> <ZM1IlPrWz/R6D0O5@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 08/19] KVM:x86: Report KVM supported CET MSRs as
 to-be-saved
In-Reply-To: <ZM1IlPrWz/R6D0O5@google.com>
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

On 8/4/23 20:51, Sean Christopherson wrote:
>>>>> +	case MSR_IA32_PL0_SSP ... MSR_IA32_INT_SSP_TAB:
>>>>> +		if (!kvm_is_cet_supported())
>>>> shall we consider the case where IBT is supported while SS isn't
>>>> (e.g., in L1 guest)?
>>>
>>> Yes, but userspace should be able to access SHSTK MSRs even only IBT is
>>> exposed to guest so far as KVM can support SHSTK MSRs.
>>
>> Why should userspace be allowed to access SHSTK MSRs in this case? L1 may not
>> even enumerate SHSTK (qemu removes -shstk explicitly but keeps IBT), how KVM in
>> L1 can allow its userspace to do that?
>
> +1.  And specifically, this isn't about SHSTK being exposed to the guest, it's about
> SHSTK being _supported by KVM_.  This is all about KVM telling userspace what MSRs
> are valid and/or need to be saved+restored.  If KVM doesn't support a feature,
> then the MSRs are invalid and there is no reason for userspace to save+restore
> the MSRs on live migration.

I think you three are talking past each other.

There are four cases:

- U_CET/S_CET supported by the host and exposed (obvious).

- U_CET/S_CET supported by the host, IBT or SHSTK partially exposed.  The
MSRs should still be guest-accessible and bits that apply to absent features
should be reserved (bits 0-1 for SHSTK, bits 2-63 for IBT).

- U_CET/S_CET supported by the host, IBT or SHSTK not exposed.  The MSRs
should still be host-accessible and writable to the default value.  This is
clearer if you think that KVM_GET_MSR_INDEX_LIST is a system ioctl.  Whether
to allow writing 0 from the guest is debatable.

- U_CET/S_CET not supported by the host.  Then the MSRs should not be
enabled and should not be in KVM_GET_MSR_INDEX_LIST, and also IBT/SHSTK
should not be in KVM_GET_SUPPORTED_CPUID.

In my opinion it is reasonable to require both U_CET and S_CET to be
supported from the beginning in the host in order to support CET.  It
is simpler and keeps the feature matrix at bay.

Paolo

