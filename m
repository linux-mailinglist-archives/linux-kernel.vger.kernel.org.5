Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D27811B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441980AbjLMRje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441910AbjLMRjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:39:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEA8B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702489178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=wMIRpMzvlSiW4Uq3ildO6AijIYP6wLHY65QDVFZkhBA=;
        b=TqDpgPEmhuc0amw6sptNjHGCFgTtaFRAnOlcZFc92X6oRrOQja+8uRyhY75EQb3CWzb1ry
        Tp3vLC/JPSHsNlXp8itmLNON4PaBPitvNuoV6aJU+9S++1TrR4T1kIcOOdpGwBD/t62Zng
        LU28Dg1sat7YK5HmAZzPMJEXrYALALE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-MzO-eypdPD6EA4jm5RYX7A-1; Wed, 13 Dec 2023 12:39:37 -0500
X-MC-Unique: MzO-eypdPD6EA4jm5RYX7A-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-551bfafcf4bso1050807a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702489176; x=1703093976;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMIRpMzvlSiW4Uq3ildO6AijIYP6wLHY65QDVFZkhBA=;
        b=vh3jOtdfdlIcGXLaTGjcG8nXWBeUOj6wMGURNIQ3QNAnUqPMRBS6+Xk+uVTQjfImxo
         CYtoRjnjBtdWnjtBGb9opkh9cIpLgRnn+sAAaoyJ0OWmU8POAOzeJLViecFGU9LSF/J/
         dsHRnRNE+jpKkFnlxnH1U2TdTOgufEUbkJxggjiAjjXtMWQ8jqB2cyXu7Cd81M9V6oca
         QWPzcQ9kN5GCw9r5S5qyjsRlOP7fHwn9+vn+Rwg3chTVCBBSYhNprubxYYcMjQu737P7
         8MGsubW1Tgr9jujTfP0NFemqWJ5iTQyeDkUz95tEoHBeHmTq+bCQaavUsuPFEyxLMvSM
         zWYg==
X-Gm-Message-State: AOJu0YzopU+LNglL9/RX4HeJQa95OZxzfsnF9a96ULVOJkoc57D2Dfn1
        yFccG5aqPUFJPFTkeKVKTIKrkgZ8bkiTiK5dbyqcsWvffdwqSm0pf9n9KOKsCLmgpw/JWDKmAuN
        FVGr7MD/hLetRdzjE9q08BiylOqEzTmU5
X-Received: by 2002:a50:aa81:0:b0:54f:64f4:c2da with SMTP id q1-20020a50aa81000000b0054f64f4c2damr5011985edc.11.1702489175936;
        Wed, 13 Dec 2023 09:39:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGu6ssPvrQwbmBqBdkria3LO2iu4eH+D3bNohApbXQ+P+kueeoHLhMBh/6iNtBbxAhA1JkmLA==
X-Received: by 2002:a50:aa81:0:b0:54f:64f4:c2da with SMTP id q1-20020a50aa81000000b0054f64f4c2damr5011977edc.11.1702489175593;
        Wed, 13 Dec 2023 09:39:35 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id dc23-20020a056402311700b005525a9abf73sm171094edb.11.2023.12.13.09.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 09:39:34 -0800 (PST)
Message-ID: <84ad3082-794b-443f-874a-d304934a395b@redhat.com>
Date:   Wed, 13 Dec 2023 18:39:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: selftests: fix supported_flags for aarch64
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Shaoqin Huang <shahuang@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20231208184628.2297994-1-pbonzini@redhat.com>
 <ZXPRGzgWFqFdI_ep@google.com>
 <184e253d-06c4-419e-b2b4-7cce1f875ba5@redhat.com>
 <ZXnoCadq2J3cPz2r@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZXnoCadq2J3cPz2r@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/23 18:21, Sean Christopherson wrote:
> On Tue, Dec 12, 2023, Paolo Bonzini wrote:
>> On 12/9/23 03:29, Sean Christopherson wrote:
>>> On Fri, Dec 08, 2023, Paolo Bonzini wrote:
>>>> KVM/Arm supports readonly memslots; fix the calculation of
>>>> supported_flags in set_memory_region_test.c, otherwise the
>>>> test fails.
>>>
>>> You got beat by a few hours, and by a better solution ;-)
>>>
>>> https://lore.kernel.org/all/20231208033505.2930064-1-shahuang@redhat.com
>>
>> Better but also wrong---and my patch has the debatable merit of more
>> clearly exposing the wrongness.  Testing individual architectures is bad,
>> but testing __KVM_HAVE_READONLY_MEM makes the test fail when running a new
>> test on an old kernel.
> 
> But we already crossed that bridge and burned it for good measure by switching
> to KVM_SET_USER_MEMORY_REGION2, i.e. as of commit
> 
>    8d99e347c097 ("KVM: selftests: Convert lib's mem regions to KVM_SET_USER_MEMORY_REGION2")
> 
> selftests built against a new kernel can't run on an old kernel.  Building KVM
> selftests requires kernel headers, so while not having a hard requirement that
> the uapi headers are fresh would be nice, I don't think it buys all that much.
> 
> If we wanted to assert that x86, arm64, etc. enumerate __KVM_HAVE_READONLY_MEM,
> i.e. ensure that read-only memory is supported as expected, then that can be done
> as a completely unrelated test.

selftests have the luxury of having sync-ed kernel headers, but in 
general userspace won't, and that means __KVM_HAVE_READONLY_MEM would be 
a very poor userspace API.  Fortunately it has "__" so it is not 
userspace API at all, and I don't want selftests to treat it as one.

> IMO, one of the big selling points of selftests over KUT is that we can punt on
> supporting old kernels since selftests are in-tree.  I don't think it's at all
> unreasonable to require that selftests be built against the target kernel, and
> by doing so we can signficantly reduce the maintenance burden.  The kernel needs
> to be backwards compatibile, but I don't see why selftests need to be backwards
> compatible.

It does help sometimes to be able to run old tests on new kernel or vice 
versa.  So even without making that a requirement, it is a nice thing to 
have whenever possible.

Paolo

