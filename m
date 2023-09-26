Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60BB7AF0DB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbjIZQhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbjIZQhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:37:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F162BF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695746216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kwn+Y2/3Lb7G0UxCRBVpYop5K/bVWNWfnHKf0b40Tss=;
        b=cs+dJnM0r8Ch+Pe+IPuPE2U7UBEQ8IBiaisbbdflmN0kOMOs1aM/ILPR66gNeRbEKEBAgl
        aSQ5zRP3+XRchhv8VtJaM54OAhfW4hHUodxR563JZpdo/McG/HhpseqWDk07JS9IH75jcM
        CRepUv7auYEJWtX7fceCGUtO9ldOCqE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-ju-q8FOnPbCGj7gy66bhDw-1; Tue, 26 Sep 2023 12:36:52 -0400
X-MC-Unique: ju-q8FOnPbCGj7gy66bhDw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40514ce8387so78729595e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695746212; x=1696351012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kwn+Y2/3Lb7G0UxCRBVpYop5K/bVWNWfnHKf0b40Tss=;
        b=FPyB5i201raA7pxd/3Bc1lZG2Ra6HctrvSL25nwjd2z4lePxQ4+08IuMFaWl/LRgqZ
         vUynqIy/G7q60yfE5lJe5NRDje4X89kMXp7v411LcSrkrMY7hVm8/aEwnMUS/XkSMNLm
         /Vy37yvHDw9U29NcPX4Fifo9S/ChONuRh4cCj9ot6+DPtatUD45L6aFMLJ7FXWy3PIZQ
         XJFkltdYeW/nJitbEj9hssupm/jcoRZwfv35QIXgcZKo0jTcMgDxaqTk1GSHXGmTKSkb
         fEEBkCPPH5YAle33cCFv0kh1mQzl0XKumKXvA+b4UjUbWGavMEvXK2c9ADiQfIAsYTNf
         AFUA==
X-Gm-Message-State: AOJu0Ywisln5Z4y9Fq7UdXh7MvRlsAhH5Xe6o9SM5O3te8uzAgxsKIdb
        u98zQa7EMQJf/gpaX/FfuvGufHik826M+fQblTAhsTxY4lDLUfiL+derc2VWfIsb3cl29pdoP+I
        7DT1vneroqzl7vkzOk4eA4OIK
X-Received: by 2002:a05:600c:310d:b0:405:959e:dc79 with SMTP id g13-20020a05600c310d00b00405959edc79mr4523735wmo.37.1695746211872;
        Tue, 26 Sep 2023 09:36:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPe3hnMTPEM/AxRFgRHfDLU7UP3Ocp6QTz9J/GjLvhtxRI/bAlHI/7d0inLqttqPjjFRHJew==
X-Received: by 2002:a05:600c:310d:b0:405:959e:dc79 with SMTP id g13-20020a05600c310d00b00405959edc79mr4523711wmo.37.1695746211487;
        Tue, 26 Sep 2023 09:36:51 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id v19-20020a05600c429300b004047ac770d1sm13421784wmc.8.2023.09.26.09.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 09:36:50 -0700 (PDT)
Message-ID: <ef6a0ebf-cb5f-0bb0-f453-0e9e0fdc87d5@redhat.com>
Date:   Tue, 26 Sep 2023 18:36:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/4] KVM: x86: tracepoint updates
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
References: <20230924124410.897646-1-mlevitsk@redhat.com>
 <ZRIf1OPjKV66Y17/@google.com>
 <abd13162f106c5ce86c211fc9d32d901ab34500b.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <abd13162f106c5ce86c211fc9d32d901ab34500b.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/23 10:28, Maxim Levitsky wrote:
>> trace_kvm_exit is good example, where despite all of the information that is captured
>> by KVM, it's borderline worthless for CPUID and MSR exits because their interesting
>> information is held in registers and not captured in the VMCS or VMCB.
>>
>> There are some on BTF type info issues that I've encountered, but I suspect that's
>> as much a PEBKAC problem as anything.
>>
> While eBPF has its use cases, none of the extra tracepoints were added solely because of
> the monitoring tool and I do understand that tracepoints are a limited resource.
> 
> Each added tracepoint/info was added only when it was also found to be useful for regular
> kvm tracing.

I am not sure about _all_ of them, but I agree with both of you.

On one hand, it would be pretty cool to have eBPF access to registers. 
On the other hand, the specific info you're adding is generic and I 
think there are only a couple exceptions where I am not sure it belongs 
in the generic KVM tracepoints.

Paolo

