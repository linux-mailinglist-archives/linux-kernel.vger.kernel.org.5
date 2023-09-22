Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3268F7AB188
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 14:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbjIVMBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 08:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIVMBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D806FB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 05:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695384024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lCyzV0KIoxNESvfwuQN1utRCL5h8YShMPxWJnZJbIG4=;
        b=hDvDg/r/mFA/9R7F7jZfe1Fc5I9SXx7d9pNMAXNyw7VGj/erUWPsMxlzay0i2QITRgL+L7
        MW8ir1sD7K1IPAymNl0ZXbTbLm57u0L+86xSzeEXRM2rR72wZ20v7HJsZQmHUZo63dcW6/
        rFSFbz+DfeDwSliLclpAo3N27nr9lJY=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-dqbqCV04N2evkyH4wk1pqA-1; Fri, 22 Sep 2023 08:00:23 -0400
X-MC-Unique: dqbqCV04N2evkyH4wk1pqA-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7a4f58bd3d4so686016241.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 05:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695384022; x=1695988822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCyzV0KIoxNESvfwuQN1utRCL5h8YShMPxWJnZJbIG4=;
        b=iN++MoJOhApGSzETusUq6gZIaf7MN6euvThaJsZqHqBTvEsU7brv/gAa0aJEEgs7Xh
         Oh+7eN59KG9TieA/43EnMZgKQ6Xa4A28UPvHPWXGaqVgORekKQ0NCUykPyfm9KlPZfeG
         a1DCIckN55Zm9J8JArP2S8cvtFwEk1AaEDSFk7hSz1MKRFyyFB2mmHfiersWKEdKp5B0
         OOumo0ev7gxa/PSyAwGfLKlOPtvHy1pqmOR+Rr3dpzYXEEoRCC/E/06dmP+yuzrQpJU/
         NuClDJ1z0herau5O8Yt6BRfSmfqSahIFDTNyPGgdW4TWqikF+uCxSoA/4EGBMqjyFNHw
         tjtA==
X-Gm-Message-State: AOJu0Yy2BpQX6uzY3yL+rXu4Lj5dlLpYpC2A0x9aA4471XFkFw/qlbwv
        mjPmYbIUrCBK5PLIvq+FePKny4QBtu6oX13AIlBD493w53a/rAxFlHEOss3cfr/I3QqRhMMIbpp
        Aomnao5JDGHpQ+00rpTHLPqP7VJe7Lld7x0AeU0s8
X-Received: by 2002:a05:6102:24d:b0:44d:626b:94da with SMTP id a13-20020a056102024d00b0044d626b94damr7977597vsq.32.1695384022472;
        Fri, 22 Sep 2023 05:00:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsXZDDfHeVTNiIQ8Bma5a9RE6h24c4anN8H/CZ1WzHpBhFlgKmCn9zTrkb8lDKXVDRE5cwbESeTWh4l7/SkXE=
X-Received: by 2002:a05:6102:24d:b0:44d:626b:94da with SMTP id
 a13-20020a056102024d00b0044d626b94damr7977579vsq.32.1695384022184; Fri, 22
 Sep 2023 05:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <1b52b557beb6606007f7ec5672eab0adf1606a34.camel@infradead.org>
In-Reply-To: <1b52b557beb6606007f7ec5672eab0adf1606a34.camel@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri, 22 Sep 2023 14:00:10 +0200
Message-ID: <CABgObfZgYXaXqP=6s53=+mYWvOnbgYJiCRct-0ob444sK9SvGw@mail.gmail.com>
Subject: Re: [RFC] KVM: x86: Allow userspace exit on HLT and MWAIT, else yield
 on MWAIT
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        graf@amazon.de, Nicolas Saenz Julienne <nsaenz@amazon.es>,
        "Griffoul, Fred" <fgriffo@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 11:30=E2=80=AFAM David Woodhouse <dwmw2@infradead.o=
rg> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> The VMM may have work to do on behalf of the guest, and it's often
> desirable to use the cycles when the vCPUS are idle.
>
> When the vCPU uses HLT this works out OK because the VMM can run its
> tasks in a separate thread which gets scheduled when the in-kernel
> emulation of HLT schedules away. It isn't perfect, because it doesn't
> easily allow for handling both low-priority maintenance tasks when the
> VMM wants to wait until the vCPU is idle, and also for higher priority
> tasks where the VMM does want to preempt the vCPU. It can also lead to
> noisy neighbour effects, when a host has isn't necessarily sized to
> expect any given VMM to suddenly be contending for many *more* pCPUs
> than it has vCPUs.
>
> In addition, there are times when we need to expose MWAIT to a guest
> for compatibility with a previous environment. And MWAIT is much harder
> because it's very hard to emulate properly.

I don't dislike giving userspace more flexibility in deciding when to
exit on HLT and MWAIT (or even PAUSE), and kvm_run is a good place to
do this. It's an extension of request_interrupt_window and
immediate_exit. I'm not sure how it would interact with
KVM_CAP_X86_DISABLE_EXITS.  Perhaps
KVM_ENABLE_CAP(KVM_X86_DISABLE_EXITS) could be changed to do nothing
except writing to a new kvm_run field? All the kvm->arch.*_in_guest
field would change into a kvm->arch.saved_request_userspace_exit, and
every vmentry would do something like

  if (kvm->arch.saved_request_userspace_exit !=3D
kvm_run->request_userspace_exit) {
     /* tweak intercepts */
  }

To avoid races you need two flags though; there needs to be also a
kernel->userspace communication of whether the vCPU is currently in
HLT or MWAIT, using the "flags" field for example. If it was HLT only,
moving the mp_state in kvm_run would seem like a good idea; but not if
MWAIT or PAUSE are also included.

To set a kvm_run flag during MWAIT, you could reenter MWAIT with the
MWAIT-exiting bit cleared and the monitor trap flag bit (or just
EFLAGS.TF) set. On the subsequent singlestep exit, clear the flag in
kvm_run and set again the MWAIT-exiting bit. The MWAIT handler would
also check kvm_run->request_userspace_exit before reentering.

Paolo

