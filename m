Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC73A7C02FF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjJJRun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjJJRuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:50:40 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA8F9E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:50:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7bcbb95b2so16874717b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696960237; x=1697565037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wt0DtTnO3+KaCKn2zwR8p0ZcMubzhAO9ADduqyKM1oQ=;
        b=ML9yNmVwOvtVpXZtIEK9anwSK0ix96HMzzDkLuhL2wS/gX+FyGSOLsx5eoYeea+K0p
         I4FaYu6Yg6nmKdeXENpz4ehZI9/yC7BJQaj/dAlEUgpU8XN/UbUzaw4VodDXrp/6fWzN
         J46ZSE21bmiS78W9z3j3Nf8XbCFQlxBpHzpyYCwZ3xAQCJZwYmBZ8yINYqrP0QBsNYlu
         Ap/r3j9B+faousXQEgdemOX6Qtqn9MyBN/ZZoliYmwpmFG4/aRr9Sp0XGQJtLyKSWb+4
         j90D2dX0+kOey87T6PXr+3RuQXc2CacRw/L32SGfAfcX8Owol8A+hb0NShb2jLuWdfdk
         SpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696960237; x=1697565037;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wt0DtTnO3+KaCKn2zwR8p0ZcMubzhAO9ADduqyKM1oQ=;
        b=DkbaoyHAB4qOMSThtJCFsoZthOacps7cfkik1zdYcKHTzTgIpsi9NYpwvhs+jEK71X
         f0yAtQkqt55WigG1A7Gc1nIVBsYQRKG0HRqpDX3/LJACxGfxvzrpIOhMHRRwXEPs4+Kf
         zwtYiZ0Pa2A6Tq9keB/ddUTADX6eOFzwm0B8P4L4rtReS+rasa9Rb9qSFRtMod6IWfPD
         MqOClCPwIvZZqH8HxbdGAwtY+OBgrWg8a9npRe8Qs2fjP2R3pQ4bnu1wfMSAGvkGcTrd
         icID6vmOw/F6BOxBaya51WUBMOT10Pk/PU363r8CtyHhRLpJYOZJreb+zBc2EOlIi4Dd
         n5vw==
X-Gm-Message-State: AOJu0YyIr08VfV8hFv5iS2z2Sa5JdoXQ+g5iT2Eb5vRFJ6ga+UHcoFZ2
        lKcfgyEg5CF9PsSAqJXWntOfN4OSFFE=
X-Google-Smtp-Source: AGHT+IGgA61JOHgH3Z1dvmLx5zGrRiY7VFXvqEWzIYehjOa5h+lJe+pf6Ivi84nPzbVE2hOX+/EgP3Rw6/M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:8d46:0:b0:59b:ec33:ec6d with SMTP id
 w6-20020a818d46000000b0059bec33ec6dmr369226ywj.5.1696960237303; Tue, 10 Oct
 2023 10:50:37 -0700 (PDT)
Date:   Tue, 10 Oct 2023 10:50:35 -0700
In-Reply-To: <1ca607bcb4931b7f5e14e6c064264d86e58fd3ce.camel@redhat.com>
Mime-Version: 1.0
References: <20231009212919.221810-1-seanjc@google.com> <e348e75dac85efce9186b6b10a6da1c6532a3378.camel@redhat.com>
 <ZSVju-lerDbxwamL@google.com> <1ca607bcb4931b7f5e14e6c064264d86e58fd3ce.camel@redhat.com>
Message-ID: <ZSWO6x-mFg37uIpq@google.com>
Subject: Re: [PATCH] KVM: SVM: Don't intercept IRET when injecting NMI and
 vNMI is enabled
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Santosh Shukla <santosh.shukla@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023, Maxim Levitsky wrote:
> =D0=A3 =D0=B2=D1=82, 2023-10-10 =D1=83 07:46 -0700, Sean Christopherson =
=D0=BF=D0=B8=D1=88=D0=B5:
> > On Tue, Oct 10, 2023, Maxim Levitsky wrote:
> > > =D0=A3 =D0=BF=D0=BD, 2023-10-09 =D1=83 14:29 -0700, Sean Christophers=
on =D0=BF=D0=B8=D1=88=D0=B5:
> > > > Note, per the APM, hardware sets the BLOCKING flag when software di=
rectly
> > > > directly injects an NMI:
> > > >=20
> > > >   If Event Injection is used to inject an NMI when NMI Virtualizati=
on is
> > > >   enabled, VMRUN sets V_NMI_MASK in the guest state.
> > >=20
> > > I think that this comment is not needed in the commit message. It des=
cribes
> > > a different unrelated concern and can be put somewhere in the code bu=
t
> > > not in the commit message.
> >=20
> > I strongly disagree, this blurb in the APM directly affects the patch. =
 If hardware
> > didn't set V_NMI_MASK, then the patch would need to be at least this:
>=20
> I don't see how 'the blurb in the APM' relates to the removal of the=20
> IRET intercept, which is what this patch is about.

No, it's not *just* about IRET interception.  This patch also guards:

	svm->nmi_masked =3D true;

If the reader doesn't already know that hardware sets V_NMI_BLOCK_MASK on d=
irect
injection, as was the case for me when I stumbled upon this issue, it's not=
 at
all obvious that not doing something analogous to setting nmi_masked is cor=
rect.

I mentioned only IRET interception in the shortlog because that's the only =
practical
impact of the change.  I can massage the shortlog if it's confusing/mislead=
ing,
but I really don't want to drop the reference to hardware setting V_NMI_BLO=
CK_MASK.
