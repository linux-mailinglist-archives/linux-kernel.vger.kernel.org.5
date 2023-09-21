Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B68F7A9A65
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjIUSjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjIUSi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:38:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E268DA238
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695321114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSWZutc0jBg4LRB6lh/PjnElphckaTmoFsFbI4z61RQ=;
        b=cf65wbhNJu3YB7vhxk/UPAI5cg+vUIQDhh1Ou/ekyP4W+TzZEmtZzz0HHcKzUeBIRr+BH0
        TUpvP4gHXxQPxYIpFfHA7rcHQvtRyPZA7+cYx4AcBIJTlyW6PRgnfzeop4Slda8tOdWpAo
        sj8IVawDCOt+YFGFCUFh3yeY4UjBcPM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-fUim78EzNEKKlMGC_ZynhQ-1; Thu, 21 Sep 2023 06:05:17 -0400
X-MC-Unique: fUim78EzNEKKlMGC_ZynhQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31ffa4da0f5so502850f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 03:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695290716; x=1695895516;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSWZutc0jBg4LRB6lh/PjnElphckaTmoFsFbI4z61RQ=;
        b=f6OhMAkIhZ6JIsjBDRFdcoVvlPAZYY5Zu0dJIuM28qeAmxFlLMJVgTmseVPyx/F/EL
         g3xAMQpnNOGFpAz1E5IJ+ixc4DOlXYWzOgkhCvGXgtRhx2qxGPyZR0Uk3WR2aqpP/3kb
         L+AOj9xn8IAnawpBLmsmVuCF/qdAHKzIHcSkImdidhYUBJlQJs0CojrWzYMwxxZSNVdT
         UCrCaAuZO64524fX/4VKN8TOw2zqBR5A0M2I6K9aaySYVIoeEzNQh4IIXg1Ybn+/+E6L
         dnUIGtaQXSVizqlK44kkECH7c0kZhBBauIaBfjMNciXadzVKNU1qCAoGPv8ZhU7xoa2B
         q0vw==
X-Gm-Message-State: AOJu0YwV6EYT98tbCLkl5EK6k+lRvl3RgflS+8hBhFizdhMf9ns2xsH6
        v+BhdN5jJ2GkSLIhFbaG0rmGiOt/7u7H+aS1hCBOjwC4JSRabRZG8imwDurnbnj9qq8k/1RqmRG
        6ld8rT/OJyshF97ZGzWWJqMBT
X-Received: by 2002:adf:e70b:0:b0:31f:b364:a6ba with SMTP id c11-20020adfe70b000000b0031fb364a6bamr4691477wrm.52.1695290716199;
        Thu, 21 Sep 2023 03:05:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb+xpkOukKwFUqxDHZtMEtfwl9qISBYPAa6ay6agAbXJC9Ql0Yok8DkWeufmD4yqy0T55nBg==
X-Received: by 2002:adf:e70b:0:b0:31f:b364:a6ba with SMTP id c11-20020adfe70b000000b0031fb364a6bamr4691458wrm.52.1695290715836;
        Thu, 21 Sep 2023 03:05:15 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id i9-20020a5d6309000000b003214fc12a30sm1298462wru.106.2023.09.21.03.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 03:05:15 -0700 (PDT)
Message-ID: <01cf00ad-0461-d72f-4b0d-d2093628049d@redhat.com>
Date:   Thu, 21 Sep 2023 12:05:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pattara Teerapong <pteerapong@google.com>,
        David Stevens <stevensd@google.com>,
        Yiwei Zhang <zzyiwei@google.com>,
        Paul Hsia <paulhsia@google.com>
References: <20230916003916.2545000-1-seanjc@google.com>
 <20230916003916.2545000-2-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/3] KVM: x86/mmu: Open code walking TDP MMU roots for
 mmu_notifier's zap SPTEs
In-Reply-To: <20230916003916.2545000-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/23 02:39, Sean Christopherson wrote:
> Use the "inner" TDP MMU root walker when zapping SPTEs in response to an
> mmu_notifier invalidation instead of invoking kvm_tdp_mmu_zap_leafs().
> This will allow reworking for_each_tdp_mmu_root_yield_safe() to do more
> work, and to also make it usable in more places, without increasing the
> number of params to the point where it adds no value.
> 
> The mmu_notifier path is a bit of a special snowflake, e.g. it zaps only a
> single address space (because it's per-slot), and can't always yield.
> 
> Drop the @can_yield param from tdp_mmu_zap_leafs() as its sole remaining
> caller unconditionally passes "true".

Slightly rewritten commit log:

---
The mmu_notifier path is a bit of a special snowflake, e.g. it zaps only a
single address space (because it's per-slot), and can't always yield.
Because of this, it calls kvm_tdp_mmu_zap_leafs() in ways that no one
else does.

Iterate manually over the leafs in response to an mmu_notifier
invalidation, instead of invoking kvm_tdp_mmu_zap_leafs().  Drop the
@can_yield param from kvm_tdp_mmu_zap_leafs() as its sole remaining
caller unconditionally passes "true".
---

and using the "__" macro can be moved to the second patch.

Paolo

