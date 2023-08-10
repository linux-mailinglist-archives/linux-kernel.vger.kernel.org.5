Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02307777D9E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbjHJQFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbjHJQFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531CF30F2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691683455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2xeRtj3kf/cDHXsZACsC9s7MVF5RBhbsWR/SF5fgzvs=;
        b=KrK6Si4krmH0GFbvrLVYpmjMLLFlefpTKSO/ym6ZE0JRLmxcFnsQIJNLet5/ZzrO/0nhIu
        4GQIo/rzzHQGvO2iifBjudSWNY00eLbcQ/axUOzHE0zOgJjUBrn958/yeLSLozcmSmHXQp
        pwbECwFR3/8A2O5SbSPxAiB6AsesgVw=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-XkHBfHlZNrm9rDyyx_AnrA-1; Thu, 10 Aug 2023 12:04:14 -0400
X-MC-Unique: XkHBfHlZNrm9rDyyx_AnrA-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1c0e885754dso843113fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691683453; x=1692288253;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2xeRtj3kf/cDHXsZACsC9s7MVF5RBhbsWR/SF5fgzvs=;
        b=EVjAe7FOTQnO+LlWHX7Af3tLR5g4azzZx8THJJMWDRxbJwS69htFtEPcSMJpuJXX8g
         i7kxm/zHbm+XfsOogT8SsjYrl7cY9N2XBt64tWbJfFLL1DzbtP16WcxLPxbaiBkAF/0m
         LSDPy+XPoQreSkpeyZkuICRfBdZN82pDhIZGB6c1290+2fI99xEIdFqhXoAxeRmOkfxS
         xZeDbEc1W5YHIiQyidS4FhXf0G/GMVCBz9bbUius02/125inAWArcCG+WBWmT1vXas38
         4EN7KqacVnuXdsz3Me4q6EDfBTDVmEKIXnQtD+hSosT7n8Jydn5udIV4m9A8Bc3vGhme
         lZtw==
X-Gm-Message-State: AOJu0Yx09cyT1FubfuJSyWGxUF3MM+OvkZnSSJIhjgm8A2HBPwKrOhTd
        xqx1l/dfFkUNKNzQqghmZ9Ov5y/JLA80RGlVDK9iAL9UAmB3652OvUc8lybjQbhhVFYJyu2zf9S
        sTog1+N4NoawAwvW6ALgEQRWP
X-Received: by 2002:a05:6871:814:b0:1be:deef:748a with SMTP id q20-20020a056871081400b001bedeef748amr3694251oap.50.1691683453378;
        Thu, 10 Aug 2023 09:04:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAS+a5G7Ws0gVldTZb/ex2IEIk5Jlst7RFNazV1Y5r7yShFP9fQOFUQETq+6a0lDS92XDcrA==
X-Received: by 2002:a05:6871:814:b0:1be:deef:748a with SMTP id q20-20020a056871081400b001bedeef748amr3694218oap.50.1691683453061;
        Thu, 10 Aug 2023 09:04:13 -0700 (PDT)
Received: from ?IPv6:2804:431:c7ec:e667:6b7d:ed55:c363:a088? ([2804:431:c7ec:e667:6b7d:ed55:c363:a088])
        by smtp.gmail.com with ESMTPSA id o19-20020a056870a51300b001c02f12abd0sm890118oal.38.2023.08.10.09.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:04:12 -0700 (PDT)
Message-ID: <98f523e515b2adc2aa7bb8d133353bad74e30897.camel@redhat.com>
Subject: Re: [RFC PATCH v5 5/5] riscv/cmpxchg: Implement xchg for variables
 of size 1 and 2
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        guoren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Thu, 10 Aug 2023 13:04:04 -0300
In-Reply-To: <b0cc2cd8-e246-40d1-b091-f40a74b31f61@app.fastmail.com>
References: <20230810040349.92279-2-leobras@redhat.com>
         <20230810040349.92279-7-leobras@redhat.com>
         <b0cc2cd8-e246-40d1-b091-f40a74b31f61@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-08-10 at 08:51 +0200, Arnd Bergmann wrote:
> On Thu, Aug 10, 2023, at 06:03, Leonardo Bras wrote:
> > xchg for variables of size 1-byte and 2-bytes is not yet available for
> > riscv, even though its present in other architectures such as arm64 and
> > x86. This could lead to not being able to implement some locking mechan=
isms
> > or requiring some rework to make it work properly.
> >=20
> > Implement 1-byte and 2-bytes xchg in order to achieve parity with other
> > architectures.
> >=20
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
>=20

Hello Arnd Bergmann, thanks for reviewing!

> Parity with other architectures by itself is not a reason to do this,
> in particular the other architectures you listed have the instructions
> in hardware while riscv does not.

Sure, I understand RISC-V don't have native support for xchg on variables o=
f
size < 4B. My argument is that it's nice to have even an emulated version f=
or
this in case any future mechanism wants to use it.

Not having it may mean we won't be able to enable given mechanism in RISC-V=
.=20

>=20
> Emulating the small xchg() through cmpxchg() is particularly tricky
> since it's easy to run into a case where this does not guarantee
> forward progress.
>=20

Didn't get this part:
By "emulating small xchg() through cmpxchg()", did you mean like emulating =
an
xchg (usually 1 instruction) with lr & sc (same used in cmpxchg) ?

If so, yeah, it's a fair point: in some extreme case we could have multiple
threads accessing given cacheline and have sc always failing. On the other =
hand,
there are 2 arguments on that:

1 - Other architectures, (such as powerpc, arm and arm64 without LSE atomic=
s)
also seem to rely in this mechanism for every xchg size. Another archs like=
 csky
and loongarch use asm that look like mine to handle size < 4B xchg.=20
   =20

>  This is also something that almost no architecture
> specific code relies on (generic qspinlock being a notable exception).
>=20

2 - As you mentioned, there should be very little code that will actually m=
ake
use of xchg for vars < 4B, so it should be safe to assume its fine to not
guarantee forward progress for those rare usages (like some of above mentio=
ned
archs).

> I would recommend just dropping this patch from the series, at least
> until there is a need for it.

While I agree this is a valid point, I believe its more interesting to have=
 it
implemented if any future mechanism wants to make use of this.=20


Thanks!
Leo


