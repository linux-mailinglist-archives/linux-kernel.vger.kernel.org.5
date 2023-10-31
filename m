Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4467DCCAA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbjJaMNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjJaMNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F6491
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 05:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698754366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bGV25K3nUnQ+2KxGVOhDHO+SWa9Obf8EAYV7RnLmQDU=;
        b=W/H04JMtr6gixcwqHI1ABeRP/KGl3xGTci7culxD1FgME8ygF7zWJV8TLXFxtHhp5TIQb6
        5ZJ86YSVU+RWlvBXjl/tpuOX1tguGyVnq9LN/URrImvzF5xKyGo4tAO04d++5PhTKBz1YZ
        bRnvRvpdp69Bm5pub1GlhIlns+kcLUE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-Faric4d0MdCqBYpAKSgDSg-1; Tue, 31 Oct 2023 08:12:44 -0400
X-MC-Unique: Faric4d0MdCqBYpAKSgDSg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4094cc441baso7338015e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 05:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698754363; x=1699359163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGV25K3nUnQ+2KxGVOhDHO+SWa9Obf8EAYV7RnLmQDU=;
        b=sia5e3mcDB3GEggHO4v+ppe3MUN2R53BbFMli4xSOUpH7bs3ly2EVpnx6SFLYJ2YDk
         E2CnHIMRhwQaHhYInAnedTo+m3qiiiwgcXPXDDLid/cd/e2Cx84/kfX2MFUahP+nUzBA
         A/InQWBfdDxoEF28EHFnXjNzuAa8Q+klblzxciWOxw+ZuT2ky0O5nMgxUsON4QP41TUl
         FsMZfAXOeGHht4dDaZNPDQfDpWQSqjHsOCKuM63TBxHVnqXqH00aSTXPqg0fYQ7n3SB6
         EbM/ttFeQfQUsyu3zjlOx7pa5J4g2vOWSr+9DHKbUkR0NVcKo8jrQ63YUqeraJ4V1KTu
         Vqgw==
X-Gm-Message-State: AOJu0YzxYj2XGPFbKPcivWOd4eFuF6kaV381xc6TG2MVFzF17r9jLYoM
        rTxtu1ZF9asEzgllNgvwkQBvEiQ9kwbyQOglpOysPElweI2uQJHQWDEgdQdLVZ6w0y9MdP0PA22
        5x2B2zbFVFzbyzto68PhRdAy4VhKfLd1UoAGvEpaR
X-Received: by 2002:a05:600c:35c9:b0:407:3b6d:b561 with SMTP id r9-20020a05600c35c900b004073b6db561mr10853435wmq.9.1698754362830;
        Tue, 31 Oct 2023 05:12:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIXLDnDne2ryAOzcO1wdHSl4RB/oKVIMQikIcfIJxAKfx07OeucoM5k7KMFboLCviAMlkUfGNEBEfrrFED8Qc=
X-Received: by 2002:a05:600c:35c9:b0:407:3b6d:b561 with SMTP id
 r9-20020a05600c35c900b004073b6db561mr10853418wmq.9.1698754362417; Tue, 31 Oct
 2023 05:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAE8KmOw1DzOr-GvQ9E+Y5RCX1GQ1h1Bumk5pB++9=SjMUPHxBg@mail.gmail.com>
 <ZT_HeK7GXdY-6L3t@google.com>
In-Reply-To: <ZT_HeK7GXdY-6L3t@google.com>
From:   Prasad Pandit <ppandit@redhat.com>
Date:   Tue, 31 Oct 2023 17:45:28 +0530
Message-ID: <CAE8KmOxKkojqrqWE1RMa4YY3=of1AEFcDth_6b2ZCHJHzb8nng@mail.gmail.com>
Subject: Re: About patch bdedff263132 - KVM: x86: Route pending NMIs
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sean,

On Mon, 30 Oct 2023 at 20:41, Sean Christopherson <seanjc@google.com> wrote:
>> if a fix patch like below would be acceptable OR reverting above patch is
>> more reasonable?
>
> No, a revert would break AMD's vNMI.

* Okay, that confirmation helps.

>> -               kvm_make_request(KVM_REQ_NMI, vcpu);
>> +               if (events->nmi.pending)
>> +                       kvm_make_request(KVM_REQ_NMI, vcpu);
>
> This looks sane, but it should be unnecessary as KVM_REQ_NMI nmi_queued=0 should
> be a (costly) nop.  Hrm, unless the vCPU is in HLT, in which case KVM will treat
> a spurious KVM_REQ_NMI as a wake event.  When I made this change, my assumption
> was that userspace would set KVM_VCPUEVENT_VALID_NMI_PENDING iff there was
> relevant information to process.  But if I'm reading the code correctly, QEMU
> invokes KVM_SET_VCPU_EVENTS with KVM_VCPUEVENT_VALID_NMI_PENDING at the end of
> machine creation.
>
> Hmm, but even that should be benign unless userspace is stuffing other guest
> state.  E.g. KVM will spuriously exit to userspace with -EAGAIN while the vCPU
> is in KVM_MP_STATE_UNINITIALIZED, and I don't see a way for the vCPU to be put
> into a blocking state after transitioning out of UNINITIATED via INIT+SIPI without
> processing KVM_REQ_NMI.
>
> Please provide more information on what is breaking and/or how to reproduce the
> issue.  E.g. at the very least, a trace of KVM_{G,S}ET_VCPU_EVENTS.   There's not
> even enough info here to write a changelog.
>

* I see, I'll try to understand in more detail about what's really
happening and will get back asap.

Thank you.
---
  - Prasad

