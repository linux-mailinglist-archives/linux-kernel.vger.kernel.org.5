Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655E87CC2B9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbjJQMOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344076AbjJQMOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:14:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1AFD09D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697544759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r9V3JZLaxEikaF62tX1Et7+9WXZYKD3fD3akx4xUFJo=;
        b=T7DSDTCBGQCeX54RjVg1oMXPkSc31VTWHw7AnHr4F5yTix9zCScaateZxgHyrdbuX4AMp4
        oe34y7TriPg9VH6OIJCI1hCKGKCCD+W9An5VHcHJM/KiRgyMnqo+F3Tk/Clfa7PzxtXsGm
        BTzDVdoiMi1x4Vym6w43ut18ssvelJM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-0YXA41KVNtKVZ5wHw4kiGg-1; Tue, 17 Oct 2023 08:12:38 -0400
X-MC-Unique: 0YXA41KVNtKVZ5wHw4kiGg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40768556444so37266145e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 05:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544756; x=1698149556;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r9V3JZLaxEikaF62tX1Et7+9WXZYKD3fD3akx4xUFJo=;
        b=Go3dNTIqI9jVAbBaJzTfDlCJlzWwDXN3rJizRSG8YgiqVRbYzZtL5BMwCxOB96XXoQ
         5ulxcD91NKv/lEpxtkmiK5G/dIB6OxQqaYOJUeZKNW9f88FUkNhtkqH3Z4RfH9x4M5rr
         A7t4PKa8h2xaP1HbNaFNC2BzJi1BVL1HBbKGE5g/r05E86Fdsl2KQRnZSvBth4GlNxKG
         rIbpruxSwxm6sibAesCelddTB+ibOHb+NButotpi4t1lj8HTPFD52gSfJibqbDibnZ6I
         d3DKnJkjtK16W1FJpmoV9XMOmOw5ylwp3gdxpJxP4NwOIRuZc3WzIiLCBgXHU38J/nQv
         xOuA==
X-Gm-Message-State: AOJu0YwedvzateYcLacZIfTPuI6RALYoeoi1vBezKk8o0OQyw1nUd1+1
        rSMqPtZbc0mHPEeNdegS0hzu6pIjqbMUBxvE1ED7nDHF4ikrgW/2QhB/nrMH08qrZz4z9t4NnUR
        UvLbcfLCXCBy4jR3ClzlSBoCR
X-Received: by 2002:a05:600c:4f49:b0:405:3b1f:968b with SMTP id m9-20020a05600c4f4900b004053b1f968bmr1448011wmq.21.1697544755921;
        Tue, 17 Oct 2023 05:12:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdNVrUKpGFWzYWzpJA3u4GNUxiXwvGPYPJmW5sHSupRjNla2BA+OtyrKXba8/emikrXq1zTA==
X-Received: by 2002:a05:600c:4f49:b0:405:3b1f:968b with SMTP id m9-20020a05600c4f4900b004053b1f968bmr1447992wmq.21.1697544755573;
        Tue, 17 Oct 2023 05:12:35 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b00406408dc788sm9886178wmq.44.2023.10.17.05.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:12:35 -0700 (PDT)
Message-ID: <d37b9d54a92226185caa427a6dba8dfb947e312d.camel@redhat.com>
Subject: Re: [PATCH v3 0/4] KVM: x86: tracepoint updates
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 17 Oct 2023 15:12:33 +0300
In-Reply-To: <20230928103640.78453-1-mlevitsk@redhat.com>
References: <20230928103640.78453-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

У чт, 2023-09-28 у 13:36 +0300, Maxim Levitsky пише:
> This patch series is intended to add some selected information
> to the kvm tracepoints to make it easier to gather insights about
> running nested guests.
> 
> This patch series was developed together with a new x86 performance analysis tool
> that I developed recently (https://gitlab.com/maximlevitsky/kvmon)
> which aims to be a better kvm_stat, and allows you at glance
> to see what is happening in a VM, including nesting.
> 
> Best regards,
> 	Maxim Levitsky
> 
> Maxim Levitsky (4):
>   KVM: x86: refactor req_immediate_exit logic
>   KVM: x86: add more information to the kvm_entry tracepoint
>   KVM: x86: add information about pending requests to kvm_exit
>     tracepoint
>   KVM: x86: add new nested vmexit tracepoints
> 
>  arch/x86/include/asm/kvm-x86-ops.h |   2 +-
>  arch/x86/include/asm/kvm_host.h    |  10 +--
>  arch/x86/kvm/svm/nested.c          |  22 ++++++
>  arch/x86/kvm/svm/svm.c             |  22 +++++-
>  arch/x86/kvm/trace.h               | 105 +++++++++++++++++++++++++++--
>  arch/x86/kvm/vmx/nested.c          |  27 ++++++++
>  arch/x86/kvm/vmx/vmx.c             |  30 +++++----
>  arch/x86/kvm/vmx/vmx.h             |   2 -
>  arch/x86/kvm/x86.c                 |  34 +++++-----
>  9 files changed, 208 insertions(+), 46 deletions(-)
> 
> -- 
> 2.26.3


Ping on this patch series.

Best regards,
	Maxim Levitsky

