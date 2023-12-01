Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7A9800279
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 05:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377300AbjLAESa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 23:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLAES0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 23:18:26 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD439BC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 20:18:32 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso4793a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 20:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701404311; x=1702009111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZqvo4x8iXRWvdlWCCwPUoFZxsdTCLZYZNCKhWWJF24=;
        b=spv8qDn3QJEVIP3CjErjfMPVMbNoQZ0k/JYs35TH5JUhAqbOpABvni98MtvDNib+WT
         IwyPnzSJbdftRyjYo/jqHetZosZGTy+XUXWCGIqp1AB3tWzmoqUmWUAUIlXhwph0rCbt
         wK8muv9ig8UANjGLIrUWGLWP6ynAaCpTV6N99748pSr09pfCOeUE2LW2TLztc2jo2L7p
         exhwxOo5KT9wkYBAA70UXRE32Z6hOyC1MSCnQmMTpXehYMr2tpdcraGUIRKJ3sLIrI8M
         xPskD+c6t0ryYMyrcCvR3pE5WebqG5PINl5DpRRM+rDHOjalYQaBJ6NpYNQWUjnaNrTk
         XZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701404311; x=1702009111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZqvo4x8iXRWvdlWCCwPUoFZxsdTCLZYZNCKhWWJF24=;
        b=A6fNXxiG8wSrm+o4h5EscB0B7lV/qSIfmPA6hgJYgEajQxHH8exhzgoQ+DPTSpz5fR
         zgXheE7gOLYS4EwbwE3dw31Irr8O8zDKg3Zj0l7JrENm6a+SFq6cUrpWiVPiVA5A9Nop
         6MwyBIrIg0v7Xjqzxx47O+qMACroYZKCn1p/c2xDHrb7SQj9KHxgP20eC6vYYK2yPk3s
         tLMcPSITDawlb1E9oVADVnOKMtY1hgPOUonm9+TlyAIDAzPCaTV/v2eotXBFq5nZVQPE
         36tW/XlT60SBD4LQiUcQ/X8BTH0G9Q1rUJ4UKGLytJ3/iRh25/OvE4s1BP0/nZnOBk76
         5d5g==
X-Gm-Message-State: AOJu0Yzskx0tuE1tHqruXKM+PKE82dfzqF4xiclYJ5aCrmwt9WcpNXyd
        KQ53Q83WMKx2QuMvMG7dw4HIDpKiy6OhclKq5rKyhA==
X-Google-Smtp-Source: AGHT+IGapZ/OnjAJsQiGEb22LvTvAz9POLEgdFXGy4wqfYX6TsUfAFHVFhNm6/qZmkkcb8zYCV89hhhYT4jmU+6P7wE=
X-Received: by 2002:a50:9f42:0:b0:54b:c986:2bc8 with SMTP id
 b60-20020a509f42000000b0054bc9862bc8mr33798edf.7.1701404311177; Thu, 30 Nov
 2023 20:18:31 -0800 (PST)
MIME-Version: 1.0
References: <20231024001636.890236-1-jmattson@google.com> <170137622057.658898.161602473001495929.b4-ty@google.com>
In-Reply-To: <170137622057.658898.161602473001495929.b4-ty@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 30 Nov 2023 20:18:19 -0800
Message-ID: <CALMp9eT2YiD=q3QwV5o7cWt+iBH-CUM5LNmhREcX7PJ1F_HhBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: x86: Advertise CPUID.(EAX=7,ECX=2):EDX[5:0] to userspace
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 5:54=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, 23 Oct 2023 17:16:35 -0700, Jim Mattson wrote:
> > The low five bits {INTEL_PSFD, IPRED_CTRL, RRSBA_CTRL, DDPD_U, BHI_CTRL=
}
> > advertise the availability of specific bits in IA32_SPEC_CTRL. Since KV=
M
> > dynamically determines the legal IA32_SPEC_CTRL bits for the underlying
> > hardware, the hard work has already been done. Just let userspace know
> > that a guest can use these IA32_SPEC_CTRL bits.
> >
> > The sixth bit (MCDT_NO) states that the processor does not exhibit MXCS=
R
> > Configuration Dependent Timing (MCDT) behavior. This is an inherent
> > property of the physical processor that is inherited by the virtual
> > CPU. Pass that information on to userspace.
> >
> > [...]
>
> Applied to kvm-x86 misc, with macros to make Jim queasy (but they really =
do
> guard against copy+paste errors).

They are also quite effective at guarding against code search. :)

> [1/2] KVM: x86: Advertise CPUID.(EAX=3D7,ECX=3D2):EDX[5:0] to userspace
>       https://github.com/kvm-x86/linux/commit/eefe5e668209
> [2/2] KVM: x86: Use a switch statement and macros in __feature_translate(=
)
>       https://github.com/kvm-x86/linux/commit/80c883db87d9
>
> --
> https://github.com/kvm-x86/linux/tree/next
