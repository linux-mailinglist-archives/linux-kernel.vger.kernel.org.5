Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2107779E0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbjHJNrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjHJNrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A865211D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 06:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691675217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Nm6P0fE0MBebZnjI4dCxb0NaHglwmbU763RRswEXI4=;
        b=MKfpSA2AG36GngAgw8GtmQATrfOS/ETgQM7Lt0GQNYurSvwyMrtyKDrvJNZTdvPAQXr23Y
        4YYKsLjhYF1VwSsY6j+L7YvFx0DtK2WRUp4GQLVH4rvTS2y427YgstBQpjpcMuRQmS+DHw
        97zqxIXIp17GmXD18VEvKTli+UcCJL4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-APwfw_NWOKKeDMXEb6LPBg-1; Thu, 10 Aug 2023 09:46:56 -0400
X-MC-Unique: APwfw_NWOKKeDMXEb6LPBg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fc07d4c63eso9494075e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 06:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691675215; x=1692280015;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Nm6P0fE0MBebZnjI4dCxb0NaHglwmbU763RRswEXI4=;
        b=R2bENWPgNWyrT4qtcBkM9kt+vUYPs8HzVaVrTmZaud3ob6WBGGHVxU+CCboJ+BmbVG
         Pf/usx6iQcL0oamD5kdgsNnvITFZM5hCrWkzt/imJ0ZfRLFZhZWkKnJRgZm/psCrOr/q
         Tses5xS0g53wcs+WUViDcDgqLWJpe8V42HRf1yPstoxZqfnqtnr5W029w1N0bZK9ScRh
         atyuvFGMfWOislpUx3TDhqXBKT/x5VeSu6hEYmS1UOFgL09D/cQhGG9RVuagQLiXEVRY
         oDiH3EEL2EskA9e1ds8FL8Z6wj0vkTQMn75Cfp7i/vS58UMo9vkgNr/SonKIVTBIee4L
         ockQ==
X-Gm-Message-State: AOJu0YyFPs0iKJpm8Bb2fyLEM64yg+k6kxjQ7eajqfGAlahlIcw6pmjI
        ObIUNZrvhzP6/YJkvtwfClBR00idWubPkbGcBmfrze1smzeQ6d+bEjXaZE8+A6s3V8mxEm8+6os
        PaN9W3mi1xJamEJ4sokjfdtE9
X-Received: by 2002:a7b:cd0d:0:b0:3fb:e1d0:6417 with SMTP id f13-20020a7bcd0d000000b003fbe1d06417mr1671923wmj.19.1691675215211;
        Thu, 10 Aug 2023 06:46:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuwdM93Ij5gxDgnHssKcNQBAHZMePhPaX2avlGf85t1UCIx0LUt0D/a23oCQ+FMsCikPqNMQ==
X-Received: by 2002:a7b:cd0d:0:b0:3fb:e1d0:6417 with SMTP id f13-20020a7bcd0d000000b003fbe1d06417mr1671907wmj.19.1691675214894;
        Thu, 10 Aug 2023 06:46:54 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id k19-20020a05600c479300b003fe1afb99b5sm2980713wmo.0.2023.08.10.06.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 06:46:54 -0700 (PDT)
Message-ID: <941e45b1-49eb-fcba-20d4-71b1db8041c5@redhat.com>
Date:   Thu, 10 Aug 2023 15:46:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] KVM: x86: Remove WARN sanity check on hypervisor timer
 vs. UNINITIALIZED vCPU
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yikebaer Aizezi <yikebaer61@gmail.com>
References: <20230808232057.2498287-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230808232057.2498287-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 01:20, Sean Christopherson wrote:
>   		/*
> -		 * It should be impossible for the hypervisor timer to be in
> -		 * use before KVM has ever run the vCPU.
> +		 * Don't bother switching APIC timer emulation from the
> +		 * hypervisor timer to the software timer, the only way for the
> +		 * APIC timer to be active is if userspace stuffed vCPU state,
> +		 * i.e. put the vCPU into a nonsensical state.  Only an INIT
> +		 * will transition the vCPU out of UNINITIALIZED (without more
> +		 * state stuffing from userspace), which will reset the local
> +		 * APIC and thus smother the timer anyways, i.e. the APIC timer

"Cancel" is probably more understandable to non-native speakers, though 
undoubtedly less poetic.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> +		 * IRQ(s) will be dropped no matter what.
>   		 */
> -		WARN_ON_ONCE(kvm_lapic_hv_timer_in_use(vcpu));
> -

