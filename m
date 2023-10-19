Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA397D00C9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346319AbjJSRip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbjJSRio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BEDCF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697737080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gi6qQG6+k6miM/ETdb6eGWM+MaqC/fZ3UHWAFSbxhBA=;
        b=fuFc2XEsYLL6HE4zp5Dp5d/yoGupm5lnT0X1zJCECUsbsgr13cHgtT8Q2WF0WLpVxA80Rj
        GfsH8r6r/BhFnvnXGhKNjzu3fPlsOgLe2rp+KMC7BKT8jdbMdHNWcDK1+h+vn/VWjjgA+1
        c5LrjOSnmPBCXHFSAjED8/LQcyALIB8=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-Aart1ZJVMxeq0T7Nc_9Zsw-1; Thu, 19 Oct 2023 13:37:58 -0400
X-MC-Unique: Aart1ZJVMxeq0T7Nc_9Zsw-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-7af53ed577fso3179361241.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697737078; x=1698341878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gi6qQG6+k6miM/ETdb6eGWM+MaqC/fZ3UHWAFSbxhBA=;
        b=dKS8AXkC2PDOvni4y8SyuOHEu6l2BblTggvoI6IBFB4O9NVSRb54MMa3RL/xfx92XD
         woaWdMydv9b2YJEjIwDkB/eTH7+klw6e3g6qeEy1tcH1DO9cE0bsCWdfKuu7Ons4/f0q
         RiL04pNezh3N7oSNHiub/b4mku/ca5klvw2jsBzUm6jrDaGjQoNIhgfyO3JxU/LES1vC
         b+JrF6sLQRE2TqK5JLS37DxTj/dp4KIh5QgRBrk8mdtpsG2K4aCHRNRRGfhfrHn8cXY8
         ADMLHDQ9+5+QcDO2zlBd4JcYlno49tfDk2ZrZjLFKbGnEqXdpjVhZESwGDHEan6HAyut
         SFpQ==
X-Gm-Message-State: AOJu0YyZtncPAW/X3NlXWqtR5KTz+qBKzfsz3YAg95W7fZZ7wIb0Cl+G
        m4eHxfls5KjeQGLuQWKNmtHarYn97Zli6N2balCxI2t62swqofrRR+mOGmBYsSwbvacPJntpYQf
        UCzuifHvJApkqp00751u0d7Y8e1yjgAaqagITfEd7
X-Received: by 2002:a67:c31d:0:b0:452:69e9:a4c with SMTP id r29-20020a67c31d000000b0045269e90a4cmr3488181vsj.3.1697737078093;
        Thu, 19 Oct 2023 10:37:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd/ItZJ9H2rOQBekrGX0IeKLlt0n8weZBmS7X601ob/SrMx/YHAiz7R1mAEjR03dYJuXg3Y/8jodzoIMJv+7U=
X-Received: by 2002:a67:c31d:0:b0:452:69e9:a4c with SMTP id
 r29-20020a67c31d000000b0045269e90a4cmr3488170vsj.3.1697737077800; Thu, 19 Oct
 2023 10:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <0ffde769702c6cdf6b6c18e1dcb28b25309af7f7.1695659717.git.maciej.szmigiero@oracle.com>
 <ZRHRsgjhOmIrxo0W@google.com> <8c6a1fc8-2ac5-4767-8b02-9ef56434724e@maciej.szmigiero.name>
 <ZRHckCMwOv3jfSs7@google.com> <ac402dd4-8bf3-87a8-7ade-50d62997ce97@amd.com>
 <e8993457-9e28-434a-b4e8-25ffcbee6517@maciej.szmigiero.name>
 <ZR3-90IQqb3mSV-b@google.com> <04cae79f-cd04-4cfe-b6ca-8b02d96350f9@maciej.szmigiero.name>
 <ZR9Yb25A5zOhzDol@google.com>
In-Reply-To: <ZR9Yb25A5zOhzDol@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 19 Oct 2023 19:37:46 +0200
Message-ID: <CABgObfYW1TpkUkuQrnZdwJPJSUtxZqUAYVeyneo7+rvXHS+Tsw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Ignore MSR_AMD64_BU_CFG access
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Borislav Petkov <bp@alien8.de>, kvm@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 2:44=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
> > We already do similar ignoring in KVM for MSR_AMD64_BU_CFG2, MSR_AMD64_=
DC_CFG
> > and MSR_F15H_EX_CFG, so doing this {BU_CFG2,TW_CFG} MSR filtering in QE=
MU would
> > be inconsistent with these.
>
> Not if QEMU filters those too. :-)
>
> The MSR filter mechanism wasn't a thing back when KVM added "support" for=
 those
> MSR, so I don't feel that punting to userspace would be inconsistent.  It=
's more
> along the lines of asking/requiring userspace to utilize a new tool to so=
lve a
> problem that is best solved in userspace, with a few outliers that got
> grandfathered in.

As long as it is enough to ignore the value and read as zero, IMO there
is an advantage in doing so in KVM, because it centralizes the update to
one place instead of requiring changes to all userspace implementations
(those that can run Windows can be counted on one hand, granted, but
still).

If we get into giving semantics to really-model-specific registers, the
disadvantages would be way more pronounced, however. I don't think we
should get any of those MSRs into KVM_GET_MSR_INDEX_LIST ever, and
we shouldn't implement them in KVM if KVM_SET_MSR has to do anything.
Also, we probably shouldn't implement them in KVM if KVM_GET_MSR
has to ever return anything but zero.

We almost have one of those, a "feature MSR" bit that is used to pass
down information on whether LFENCE serializes execution; but it's not
supported by KVM_GET_MSR/KVM_SET_MSR. I'd retcon this happily as
"we don't want any stateful chicken bit MSRs in the kernel", and I'm
in favor of removing it if there are no complaints, now that AMD has
defined a bit in 0x80000021 for this purpose.

We have the microcode revision, which we had to add because
of the side-channel mess of a few years ago.
And we also have MSR_AMD64_OSVW_ID_LENGTH and
MSR_AMD64_OSVW_STATUS, but those technically are vendor-
specific but not model-specific and have an associated CPUID bit. I
think those are as close as we get to being a mistake, but still (barely
so) on the acceptable side.

Paolo

