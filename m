Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2F87903DE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbjIAWzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237598AbjIAWzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCC61734
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 14:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693602438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tv/HA+P8uMR5coJUPcxetvErjhQYiAoKoxyPS6dOGNw=;
        b=Ki+X7QBnQOkzHnHEoJtXVSDRMViFbreNJoAyvNuPinNqJBpEGWfeYZ7dffZqVCdShKy5zE
        9JSPmy56mHyQJyy61jlAqHxyFQnjlmOalup8gNHxQENSqk2e3c6kLAl02FSKyG/NtTTWND
        1Y+GJt95c79E4DX1SgOOephPJ2WDuD8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-pLMEXTKhNXePq1Yqf4YQFw-1; Fri, 01 Sep 2023 17:07:16 -0400
X-MC-Unique: pLMEXTKhNXePq1Yqf4YQFw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fefea09bd0so15570905e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 14:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693602435; x=1694207235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tv/HA+P8uMR5coJUPcxetvErjhQYiAoKoxyPS6dOGNw=;
        b=NS10NNK7ucDa2XkdyUj8VT2Me6CEqeBL5gX3EbViUTLZhFzLX9I6sO4UV5+MzvDKYA
         uHhnaXDSDhMb4FyJCNcRw/DqRu2n3EMsD6ssGOFjexEGlaQ7cBoJ8I3X98AMuYhFXYQ7
         6p7xy9C0dP7vmo6qjSKad/k/taLo3V12oYNp3ub9koaEVQCnZoVYI8H+C/1MOyp/yFzS
         0sUgODwFozLz6I6vcU7VnIgSokVQyR4qsq4ovOiZr1tQX6WDQ3F15zlEILlbrXSq5rLM
         IP8cRBopM5hDKES/bm1jBDZ2IIwkkUlG9lu5H3Uu/CZa42ZyGeu5R0Oo/TatTo62sFYt
         bZEA==
X-Gm-Message-State: AOJu0Yx3ZlW+8nq9bS0o77nkZfcP9qGYqOwso2C4cs7oFZrBNW9bc1oo
        47zDaotjUu1rX1q0v+LyEY9hWrjuohisMJ61vx+3ehWsfEHI79waZM0eVuSxViTllULnbRbR7Lx
        n3kAyHAe9QUBj4SkRTWGmGtkn1s3EGO8t
X-Received: by 2002:a05:600c:2945:b0:3fe:89be:cd3 with SMTP id n5-20020a05600c294500b003fe89be0cd3mr2737391wmd.22.1693602435117;
        Fri, 01 Sep 2023 14:07:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1umVJ3kyzWx1aR5zAxechiQtUD6n1Z300wpjAW1KsAc9X8uX0X7I5CKi/7v4HrUsq70DwLA==
X-Received: by 2002:a05:600c:2945:b0:3fe:89be:cd3 with SMTP id n5-20020a05600c294500b003fe89be0cd3mr2737383wmd.22.1693602434797;
        Fri, 01 Sep 2023 14:07:14 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id p22-20020a1c7416000000b003fe23b10fdfsm9112249wmc.36.2023.09.01.14.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 14:07:13 -0700 (PDT)
Message-ID: <5e33618d-1c06-b42a-0755-bf8661895e9b@redhat.com>
Date:   Fri, 1 Sep 2023 23:07:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [GIT PULL] KVM: x86: MMU changes for 6.6
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <like.xu.linux@gmail.com>
References: <20230830000633.3158416-1-seanjc@google.com>
 <20230830000633.3158416-4-seanjc@google.com> <ZPDNielH+HOYV89u@google.com>
 <CABgObfZoJjz1-CMGCQqNjA8i_DivgevEhw+EqfbD463JAMe_bA@mail.gmail.com>
 <ZPIwtfkVAyFWy41I@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ZPIwtfkVAyFWy41I@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/23 20:43, Sean Christopherson wrote:
>> Ok, I'll apply these by hand.
> In case you haven't taken care of this already, here's an "official" tested fix.
> 
> Like, if you can give your SoB, I'd rather give you full author credit and sub
> me out entirely.

I prefer to squash and possibly face Linus's wrath. :)

Paolo

