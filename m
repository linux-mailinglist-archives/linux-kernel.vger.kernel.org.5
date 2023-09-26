Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5FF7AF0DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjIZQif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbjIZQid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:38:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DEE10A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695746267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=olHH16K9BvQoXzjahxJj5u8UpcYEntLBlINdOts8tao=;
        b=RGmlp5Ia5ZYWS3sCpYOSSkHEuhMGOh5gR+B3VIS9zcQHg97qoin328CQZx2s+7wT36H08D
        rPwwehnS0heTajcNafJS6pSZrUHVjT4CCMv7wugwWwbpfNKNhpcA5AGOe/NsFn2rUgACtw
        JQzXEBgTr7H/Sn0+ETma/WWSfyS9wg4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-GV_VwOrAPa-Y3K83EJU2JA-1; Tue, 26 Sep 2023 12:37:45 -0400
X-MC-Unique: GV_VwOrAPa-Y3K83EJU2JA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32001e60fb3so5307177f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695746264; x=1696351064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=olHH16K9BvQoXzjahxJj5u8UpcYEntLBlINdOts8tao=;
        b=Rrr5AGqZEyDZcmtj1ha7A+jkIrFHXX2LRKmVKI8DPkd7bpRHFZbsULZQaIR61ynV4S
         Frn34kUpxFIx7tDd9WF0zbzezac7CIttOxakXrgHND/D/BMigrnirGjcvemWTNJYEeDr
         rRtMsCDy50SIXsz4BkqLvB+I7Fscl1cbgSuUa6idrKP8LbAle0v9BuOqTm7gWX2NjzLb
         vy58XTKV6l4waEx2IPxF7Xe3LCDBHKboMdBq+mAAtKlW80CK/jaVY+ScbObkecHAAfUU
         a/FtveaekpsImsZqejK90HvlNBExUQ1hNjABpUSFIpSTn3rbzoarDHtZ3rzjM/IZYeHm
         Wi8Q==
X-Gm-Message-State: AOJu0Yw7Ge4yEviR9brGF3h7/G6hhznlinnnvX+kTWuqkx2TsqHzjGWG
        uUicFN2QXGfe9X5FfRKj3Vzqw7Hs1+en4fnxc7UE6jjgbXLStZa9mK27NWF8N1jfN1RRpx9CqRl
        /WW52BBBtZ3vu2J/kvLmuTHla
X-Received: by 2002:adf:cc8e:0:b0:321:57a5:6e6c with SMTP id p14-20020adfcc8e000000b0032157a56e6cmr2519236wrj.34.1695746264310;
        Tue, 26 Sep 2023 09:37:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl/ZH40pmiUvkHdPVTCvZkTGst6ZXTmi2dp95rjHnSSeD0+rkA+891XRo53UHfvkTg5H5IZw==
X-Received: by 2002:adf:cc8e:0:b0:321:57a5:6e6c with SMTP id p14-20020adfcc8e000000b0032157a56e6cmr2519221wrj.34.1695746263945;
        Tue, 26 Sep 2023 09:37:43 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id p8-20020a7bcc88000000b003fbe4cecc3bsm10654668wma.16.2023.09.26.09.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 09:37:43 -0700 (PDT)
Message-ID: <93396a36-30fe-74d6-d812-a93dafa771cb@redhat.com>
Date:   Tue, 26 Sep 2023 18:37:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/4] KVM: x86: refactor req_immediate_exit logic
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
References: <20230924124410.897646-1-mlevitsk@redhat.com>
 <20230924124410.897646-2-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230924124410.897646-2-mlevitsk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/23 14:44, Maxim Levitsky wrote:
> +	if (vcpu->arch.req_immediate_exit)
>   		kvm_make_request(KVM_REQ_EVENT, vcpu);
> -		static_call(kvm_x86_request_immediate_exit)(vcpu);
> -	}

Is it enough for your use case to add a new tracepoint here, instead of 
adding req_immediate_exit to both entry and exit?

Paolo

