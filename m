Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB36A80BDC0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 23:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjLJWxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 17:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJWxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 17:53:12 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0480CE3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 14:53:16 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c38e520e2so56605e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 14:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702248794; x=1702853594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKS/AHcM2NBWqMD4zsEUfP2kt6MSIwHJfrO8WzI99T8=;
        b=2BQuK2lG0+aIH50Ea54CUN31I1TrzncC/ggR0YgAu2SbM6weqjLOXaKo2aSFeFgFBg
         ZUPZs9Me7ZSbqFQzQDyJn5gX/oCSHcKWBfckpo2QyDkkxBjzHZ5iFA4ut6P7OCj83SVM
         U4ewmmkGleUBg31U/cdfenkTUpBoGV3gyREB/BlXdq3thm35rbzXUeR545uuVoaAjZRN
         WM9VAMIV78RQGLc5G5OFlTbUWTRFASVV6wd4BzzN7Bwxc9rn8y9Vs2kgA1jEf3cdzzvx
         hx7dbOzjdVvVWY3EZTthVD3xsfYNTi6ANyCLJXfMAVERg+l6eyW+wg7kK1LxVCeFClSc
         V9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702248794; x=1702853594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKS/AHcM2NBWqMD4zsEUfP2kt6MSIwHJfrO8WzI99T8=;
        b=euXiZUkPVUhPlwlqac0z2rtLkyTnkRCx07AQn1t/Agp7pjRTCmZOTN7EVE8UqgL7+b
         gaok5ABDQzydPy5FXRHXQqpBvGjhZ71un2AjV5thAbc+V8TsEAJHXDxpW7Mi2VMaU6MV
         SLOs4140DiR/YxJorrcL+c47yP2mTaZusa59sUUoF+0rLGM/gK1xOej302EjFZv9KQ9j
         0wXi9edUuzvvR8zDI9PnL7b1VX2u3Xtu/GagUOyO2WXoYaxeD6ntjXsFUm4ALWuoo1MH
         j38JfGZLiZJTFILH8jTrIlZbU4HkRHOqzcUyx+bkfkzhX0OX4xBPQv1z8Ri4JI3beoCX
         CQNQ==
X-Gm-Message-State: AOJu0YxalGJgnoNpQmTMDjaIlq/B+mX/4Xy5PyJjH6H5npm0rEmN6r2M
        iaXQVXTwus7adnRmO6XKPCzmZ/aajmpX94RkdPlNBg==
X-Google-Smtp-Source: AGHT+IHfF/YK8dgWEfqDIfnTDLirkLeJB4fVu6OmnYB7yxbJvNgiVETL/lA8ongHRpHXQrS4L8RMiXwyvPov+eoWnK8=
X-Received: by 2002:a05:600c:5113:b0:40c:329:d498 with SMTP id
 o19-20020a05600c511300b0040c0329d498mr170595wms.1.1702248794289; Sun, 10 Dec
 2023 14:53:14 -0800 (PST)
MIME-Version: 1.0
References: <20220921003201.1441511-11-seanjc@google.com> <20231207010302.2240506-1-jmattson@google.com>
 <ZXHw7tykubfG04Um@google.com>
In-Reply-To: <ZXHw7tykubfG04Um@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Sun, 10 Dec 2023 14:52:59 -0800
Message-ID: <CALMp9eTT97oDmQT7pxeOMLQbt-371aMtC2Kev+-kWXVRDVrjeg@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] KVM: x86: never write to memory from kvm_vcpu_check_block()
To:     Sean Christopherson <seanjc@google.com>
Cc:     alexandru.elisei@arm.com, anup@brainfault.org,
        aou@eecs.berkeley.edu, atishp@atishpatra.org,
        borntraeger@linux.ibm.com, chenhuacai@kernel.org, david@redhat.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, james.morse@arm.com,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mlevitsk@redhat.com,
        oliver.upton@linux.dev, palmer@dabbelt.com,
        paul.walmsley@sifive.com, pbonzini@redhat.com,
        suzuki.poulose@arm.com
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

On Thu, Dec 7, 2023 at 8:21=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
> Doh.  We got the less obvious cases and missed the obvious one.
>
> Ugh, and we also missed a related mess in kvm_guest_apic_has_interrupt().=
  That
> thing should really be folded into vmx_has_nested_events().
>
> Good gravy.  And vmx_interrupt_blocked() does the wrong thing because tha=
t
> specifically checks if L1 interrupts are blocked.
>
> Compile tested only, and definitely needs to be chunked into multiple pat=
ches,
> but I think something like this mess?

The proposed patch does not fix the problem. In fact, it messes things
up so much that I don't get any test results back.

Google has an internal K-U-T test that demonstrates the problem. I
will post it soon.
