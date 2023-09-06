Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C8E7940CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbjIFPz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjIFPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:55:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6DA1721
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 08:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694015675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eeDKq3ECaHNWNxw65ZgN03/C+YbqsXWSUMZgTn+QyYk=;
        b=GBahdXOUO9ZE2B4yxWSaQM+bzPnnW7s5x0saSivg/R1mONAtdNHe25YkDwtlaYd4O7Mkqw
        iWR4nwceNXLYt/PNTMlX6uTF4mlNkfboA3bVZMeGc0c7Tqk5g9YcDk5Pf3DTRKG6+jVS/7
        dkD7E/L2Res/uu/s0AsK9UTfBuUsiFk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-ps95Bd4RMF2-x6YsxpHtvA-1; Wed, 06 Sep 2023 11:54:34 -0400
X-MC-Unique: ps95Bd4RMF2-x6YsxpHtvA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40298cbbcdbso89665e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 08:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694015672; x=1694620472;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eeDKq3ECaHNWNxw65ZgN03/C+YbqsXWSUMZgTn+QyYk=;
        b=B+kPW4cM6aEN/DdzdDfvfeQOuwfO5uQWEaU4WvVe53Akf4ycre98+thHU5AnaLYzmH
         RSHLwRgXIl6tXBlkI5HQ1FVqFUEVZiM0vFWf5vSbMRcLKoKay/+UJQ7PRhTCL4FNNt1w
         HScAM8HCZrrFxjgSHkovf6HK7PgvNnu2wAKpBxRfs2QVd+nkHYhmyakNMgC/jh0MAfDe
         kL7zDJ0FX7rmzcELBal9VT2osDDgs66CliADann/6ECZz3LN2FKzCFjLCJmpAiiD+X8d
         THvdoECD4OCXHxlV/EUbh9JIxQYCeDCc8qymxpOo2HChcVCV0OqICpDKHbgihblL5V60
         VFBA==
X-Gm-Message-State: AOJu0YwqH4cgN7n5sJcMjQWtdZaZa+EaRVYYzqQNwQnQXs6YWegu8+jn
        aORYv0xDDSRMKc60K0r57xQbS6tZP7M2H4wW1YLdNFlgZASx1lSLZMS3DaV6zFnB4wCWL53m4l5
        rEWDx8bZT5jImoJxhRmLBzzJfk4V19qCa
X-Received: by 2002:a7b:cbc6:0:b0:401:cc0b:29c8 with SMTP id n6-20020a7bcbc6000000b00401cc0b29c8mr2572240wmi.29.1694015672473;
        Wed, 06 Sep 2023 08:54:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrLCtJ4YgN1r/HXIKsk2nkNTq/w0OTbziE4FXQB7QLaxkNBywTH3YhhMm7vQ+/IwEMga/Z1w==
X-Received: by 2002:a7b:cbc6:0:b0:401:cc0b:29c8 with SMTP id n6-20020a7bcbc6000000b00401cc0b29c8mr2572227wmi.29.1694015672180;
        Wed, 06 Sep 2023 08:54:32 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003fa96fe2bd9sm23296044wmd.22.2023.09.06.08.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 08:54:31 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Kyle Meyer <kyle.meyer@hpe.com>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hasen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmatlack@google.com, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, steve.wahl@hpe.com
Subject: Re: [PATCH] KVM: x86: Increase KVM_MAX_VCPUS to 4096
In-Reply-To: <ZNuxtU7kxnv1L88H@google.com>
References: <20230815153537.113861-1-kyle.meyer@hpe.com>
 <ZNuxtU7kxnv1L88H@google.com>
Date:   Wed, 06 Sep 2023 17:54:30 +0200
Message-ID: <87v8cns3ex.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Aug 15, 2023, Kyle Meyer wrote:
>> Increase KVM_MAX_VCPUS to 4096 when MAXSMP is enabled.
>> 
>> Notable changes (when MAXSMP is enabled):
>> 
>> * KMV_MAX_VCPUS will increase from 1024 to 4096.
>> * KVM_MAX_VCPU_IDS will increase from 4096 to 16384.
>> * KVM_HV_MAX_SPARSE_VCPU_SET_BITS will increase from 16 to 64.
>> * CPUID[HYPERV_CPUID_IMPLEMENT_LIMITS (0x40000005)].EAX will now be 4096.
>> 
>> * struct kvm will increase from 39408 B to 39792 B.
>> * struct kvm_ioapic will increase from 5240 B to 19064 B.
>> 
>> * The following (on-stack) bitmaps will increase from 128 B to 512 B:
>> 	* dest_vcpu_bitmap in kvm_irq_delivery_to_apic.
>> 	* vcpu_mask in kvm_hv_flush_tlb.
>> 	* vcpu_bitmap in ioapic_write_indirect.
>> 	* vp_bitmap in sparse_set_to_vcpu_mask.
>> 
>> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
>> ---
>> Virtual machines with 4096 virtual CPUs have been created on 32 socket
>> Cascade Lake and Sapphire Rapids systems.
>> 
>> 4096 is the current maximum value because of the Hyper-V TLFS. See
>> BUILD_BUG_ON in arch/x86/kvm/hyperv.c, commit 79661c3, and Vitaly's
>> comment on https://lore.kernel.org/all/87r136shcc.fsf@redhat.com.
>
> Mostly out of curiosity, do you care about Hyper-V support?   If not, at some
> point it'd probably be worth exploring a CONFIG_KVM_HYPERV option to allow
> disabling KVM's Hyper-V support at compile time so that we're not bound by the
> restrictions of the TLFS.
>

(sorry for necroposting)

While adding CONFIG_KVM_HYPERV to disable all-things-Hyper-V may make
sense for some deployments (and as we already have CONFIG_KVM_XEN), I
don't think we should forbid KVM_MAX_VCPUS > 4096 when it is enabled:
'general purpose' (distro) kernels are used both for hosting large Linux
guests and Windows guests. Instead, I'd suggest we define
KVM_MAX_HV_VCPUS as MIN(KVM_MAX_VCPUS, 4096) and then e.g. fail
KVM_SET_CPUID[,2] if we already have > 4096 vCPUs + fail
kvm_arch_vcpu_create() if we already have something-hyperv enabled on
the already created vCPUs.

-- 
Vitaly

