Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894C078CA79
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbjH2RNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbjH2RNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:13:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E630FC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693329147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wp6NVU/HH5u0YUMAAE2I/gwkb6z0iMtEnAqVfmJMByA=;
        b=OohTuNecGuUJodpnd1tH0cqNfS7BAmAkhSMq3hx3I/KcXUfA2TsNOesUCNM8jkDVaB6jkR
        uWmvjwOHXaNuKPWLk11Q1HOyKk/BzfoxBEDNBtqJgIq2n0ZJYZzNuTBLHb/6KCAr0pN3e9
        tAdQvVNIa8ICzdM3QyTWQTii2iY92Io=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-avaTAYaGO-CwoH4Llzzfmw-1; Tue, 29 Aug 2023 13:12:25 -0400
X-MC-Unique: avaTAYaGO-CwoH4Llzzfmw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3180237cef3so3023180f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329144; x=1693933944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wp6NVU/HH5u0YUMAAE2I/gwkb6z0iMtEnAqVfmJMByA=;
        b=Bm3w/HL+sNoY0e50OX7YVzCGmCKDC1zVBGvk5wIHIBdSs7muB1n3zxudiBDvLxwlFi
         AA8a5Sv78I0/tUjfs/iNfdGdmKeaOX85Osg5gex2LXcojsTr2zoie3EWLDDYEn5Nt7Tp
         dg6rSBY3TyoEqwCCnBLWogDWFzRwYnDESBhiu4edJfwBrKe/Ctd8LLeXi9JCxyxv+PiI
         UnIX/VlDEj2EbBebhLIcaVxyE8Ol8+VMgnW3E+nLx4Ptsgfs4R2gxTeWOTjn62C/57dl
         7wGHTCABiw1fIDJXNyyrYRvONx3NSiVIrnLpPEmal6xNquCOjlFEZyHl1VcqcgANFF+F
         ABRA==
X-Gm-Message-State: AOJu0Yw+7nVrXXZZVPcgpAkHCo65/gmrbDeEIMJWxIgbP7qXLunLYxPp
        TVkH15GzSQOySXwqo/Z/mNL4Rp/PhblQZASFLqDTbr+f3IubWF48SHofZWnnXvTOSG3VqZnlLSQ
        DXju6A6ojx7uXGZpyiF7Nsat8
X-Received: by 2002:a5d:6382:0:b0:319:7788:5027 with SMTP id p2-20020a5d6382000000b0031977885027mr22068086wru.59.1693329144235;
        Tue, 29 Aug 2023 10:12:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvKWn7oc8cn1caVkrWHBl2cCderLcj1+GCitzKIJIYbS0PNIo3Fkz9Uxk+P6u4M8FOKmY8fQ==
X-Received: by 2002:a5d:6382:0:b0:319:7788:5027 with SMTP id p2-20020a5d6382000000b0031977885027mr22068071wru.59.1693329143928;
        Tue, 29 Aug 2023 10:12:23 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
        by smtp.googlemail.com with ESMTPSA id q7-20020adff787000000b003188358e08esm14168194wrp.42.2023.08.29.10.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 10:12:23 -0700 (PDT)
Message-ID: <aff7354d-af68-c283-b607-029218af183b@redhat.com>
Date:   Tue, 29 Aug 2023 19:12:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] KVM: VMX: Refresh available regs and IDT vectoring info
 before NMI handling
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <like.xu.linux@gmail.com>
References: <20230825014532.2846714-1-seanjc@google.com>
 <169327846893.3063999.9479426554624511592.b4-ty@google.com>
Content-Language: en-US
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <169327846893.3063999.9479426554624511592.b4-ty@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/23 05:11, Sean Christopherson wrote:
> Applied to kvm-x86 vmx, gonna try to squeeze this into the initial 6.6 pull
> request as I got confirmation from another reporter that this fixed their
> problem[*].  I'll make sure to make note of this patch in the pull request to
> Paolo, worst case scenario I'll drop this one commit if Paolo spots something.
> 
> https://lore.kernel.org/all/SY4P282MB10841E53BAF421675FCE991D9DE0A@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM/
> 
> [1/1] KVM: VMX: Refresh available regs and IDT vectoring info before NMI handling
>        https://github.com/kvm-x86/linux/commit/50011c2a2457

I'm back, so feel free to add even the

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

