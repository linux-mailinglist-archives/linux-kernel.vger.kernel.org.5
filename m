Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55DE8011B5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378762AbjLARaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjLARaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:30:15 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8EF1AD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:30:20 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d6b751dabcso7391847b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451820; x=1702056620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VAwqWhtGBymfFWGSRnnaYIZdN2QXYyqbsCWaqHXus74=;
        b=3DJjGyWyqnykttnQCAtneJdAf/T8zEWffb1IQXSxpmDrHIf5ZTkbRAJdr2trdklq9/
         F7sxaggk0VlnyM0QAwEwAsva8fJHg9PW5NbjbP9AWjCJoQPIk3I1SA33G7DmkZO0XlNq
         oe8c7lQ6S2rkWxm7BTfu9Mi7c500hhmlBLC7Rnflip6I3Va/GZ7398zqyB4+LjzZy8pY
         MlSKi86PFFeg74zd4dv8p4cXNB2l9fHFkK75llbpx+pk4EyhGj58yk0zikdO/0VIZysa
         45xaF9PAJ2b8w7YagWRu7IMCUFwyeE8UvrUHWq7VX0VA1B9+Nja8j2F+C1TQw9YDY6AM
         QRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451820; x=1702056620;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VAwqWhtGBymfFWGSRnnaYIZdN2QXYyqbsCWaqHXus74=;
        b=rrr9/TqpNiccSuGLBNtm4cPPCP63FoR0+CAPSKIUWLw5ivBYUcUsSyc8c2rYPgh0yK
         ZvCJfG+whqfNwWCU4L1QuX10xuR0onSl/6eWHYe4BeRyJZ5iMvVLITG7A2KrPANCDX9V
         ahfryxUC7eCG9tJV4E1wCVQNhdtC8IbK2veP/61gMz32sSeA23GX3cI4jGEUqEFeYU+U
         5giRjqQKlDXvECZKt7g6WLWEk8WH6X3mL+ZydodR8yhGt0N5hPit8Otu+3S6fyRp+6lC
         USBnKjlg0/EH1C/48Km3rtf3CfeVDvqppNz+ba1kihjO8POUOH6p8fN3nEyoJd3Q0CqI
         LEew==
X-Gm-Message-State: AOJu0Yx5QNBXyc5IAAJupsCafT8dZ3QF6BRK/UJCudRd8LAWepsO322b
        ELHxqOslPeIxdPGRFFJRqTzZsSCtxjo=
X-Google-Smtp-Source: AGHT+IHyhcKzCnONo7e+a7QXWq3GbY4bKLR6abaqSXFAlCVSPnEer33Z4LVtdS7hrcP1myZX+DFMf5ogeNg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:dfd7:0:b0:5d3:b449:e58e with SMTP id
 i206-20020a0ddfd7000000b005d3b449e58emr168400ywe.6.1701451819845; Fri, 01 Dec
 2023 09:30:19 -0800 (PST)
Date:   Fri, 1 Dec 2023 09:30:18 -0800
In-Reply-To: <20231116133628.5976-1-clopez@suse.de>
Mime-Version: 1.0
References: <20231116133628.5976-1-clopez@suse.de>
Message-ID: <ZWoYKs0OKdSOLOLR@google.com>
Subject: Re: [PATCH v2] KVM: X86: improve documentation for KVM_CAP_X86_BUS_LOCK_EXIT
From:   Sean Christopherson <seanjc@google.com>
To:     "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023, Carlos L=C3=B3pez wrote:
> Improve the description for the KVM_CAP_X86_BUS_LOCK_EXIT capability,
> fixing a few typos and improving grammar for overall clarity.
>=20
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
> ---
> v2: Corrected the name of the KVM_RUN_X86_BUS_LOCK flag
>=20
>  Documentation/virt/kvm/api.rst | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index 7025b3751027..4701370bf46f 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6256,9 +6256,9 @@ More architecture-specific flags detailing state of=
 the VCPU that may
>  affect the device's behavior. Current defined flags::
> =20
>    /* x86, set if the VCPU is in system management mode */
> -  #define KVM_RUN_X86_SMM     (1 << 0)
> +  #define KVM_RUN_X86_SMM          (1 << 0)
>    /* x86, set if bus lock detected in VM */
> -  #define KVM_RUN_BUS_LOCK    (1 << 1)
> +  #define KVM_RUN_X86_BUS_LOCK     (1 << 1)
>    /* arm64, set for KVM_EXIT_DEBUG */
>    #define KVM_DEBUG_ARCH_HSR_HIGH_VALID  (1 << 0)
> =20
> @@ -7582,20 +7582,20 @@ KVM_BUS_LOCK_DETECTION_OFF and KVM_BUS_LOCK_DETEC=
TION_EXIT are supported
>  currently and mutually exclusive with each other. More bits can be added=
 in
>  the future.

Meh, there's a lot of pointless boilerplate in here.  These statements hold=
 true
for almost every KVM capability.

> -With KVM_BUS_LOCK_DETECTION_OFF set, bus locks in guest will not cause v=
m exits
> +With KVM_BUS_LOCK_DETECTION_OFF set, bus locks in guest will not cause V=
M exits
>  so that no additional actions are needed. This is the default mode.

Heh, this is technically wrong.  KVM intercepts #AC when the non-virtualize=
d
split-lock detection is enabled, i.e. bus locks will cause VM-Exit, though =
they
won't be forwarded to userspace.

> -With KVM_BUS_LOCK_DETECTION_EXIT set, vm exits happen when bus lock dete=
cted
> -in VM. KVM just exits to userspace when handling them. Userspace can enf=
orce
> -its own throttling or other policy based mitigations.
> -
> -This capability is aimed to address the thread that VM can exploit bus l=
ocks to
> -degree the performance of the whole system. Once the userspace enable th=
is
> -capability and select the KVM_BUS_LOCK_DETECTION_EXIT mode, KVM will set=
 the
> -KVM_RUN_BUS_LOCK flag in vcpu-run->flags field and exit to userspace. Co=
ncerning
> -the bus lock vm exit can be preempted by a higher priority VM exit, the =
exit
> -notifications to userspace can be KVM_EXIT_BUS_LOCK or other reasons.
> -KVM_RUN_BUS_LOCK flag is used to distinguish between them.
> +With KVM_BUS_LOCK_DETECTION_EXIT set, VM exits happen when a bus lock is
> +detected in VM. KVM just exits to userspace when handling them. Userspac=
e can
> +enforce its own throttling or other policy based mitigations.
> +
> +This capability is aimed to address the fact that a VM can exploit bus l=
ocks to

I liked the attempt to capture that this is a threat mitigation, although t=
he
typo probably made that hard to see.

> +impact the performance of the whole system. Once userspace enables this
> +capability and selects the KVM_BUS_LOCK_DETECTION_EXIT mode, KVM will se=
t the
> +KVM_RUN_X86_BUS_LOCK flag in the vcpu->run->flags field and exit to user=
space.

Oof, the existing wording is nonsensical.  This reads like KVM unconditiona=
lly sets
KVM_RUN_X86_BUS_LOCK whenever the capability is enabled.

> +Concerning the bus lock, a VM exit can be preempted by a higher priority=
 VM
> +exit, so the exit notification to userspace can be KVM_EXIT_BUS_LOCK or =
another
> +reason. KVM_RUN_X86_BUS_LOCK flag is used to distinguish between them.

This is also worded rather weirdly.  It's not so much that VM exits can be
preempted, it's that the CPU can detect a bus lock while also delivering an
unrelated VM exit.

Something like this?

---

This capability allows userspace to force VM exits on bus locks detected in=
 the
guest, irrespective whether or not host has enabled split-lock detection (w=
hich
triggers an #AC exception that KVM intercepts).  This capability is intende=
d to
mitigate attacks where a malicious/buggy guest can exploit bus locks to deg=
rade
the performance of the whole system.=20

If bus lock detection is OFF, KVM doesn't force guest bus locks to VM exit,
although the host kernel's split-lock #AC detection still applies, if enabl=
ed.

If bus lock detection is set to EXIT, KVM enables a CPU feature that ensure=
s
bus locks in the guest trigger a VM exit, and KVM exits to userspace for al=
l
such VM exits, e.g. to allow userspace to throttle the offending guest and/=
or
apply some other policy-based mitigation.  When exiting to userspace, KVM s=
ets
KVM_RUN_X86_BUS_LOCK in vcpu-run->flags, and conditionally sets the exit_re=
ason
to KVM_EXIT_X86_BUS_LOCK.

Note!  Detected bus locks may be coincident with other exits to userspace, =
i.e.
KVM_RUN_X86_BUS_LOCK should be checked regardless of the primary exit reaso=
n if
userspace wants to take action on all detected bus locks.
