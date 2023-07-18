Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED11758161
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjGRPxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjGRPxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19CF127
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689695535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vCJR11Z8LE62Lpm8j/WH0EMwgBueVBllyGpJYTK0igw=;
        b=PykKkRImx35xGdEzEbXxM08pIS/G1JZBNoqJBkqFBQExfx2r+GaVgiXX6kreNXsPagqG3l
        yWMzR7LydS59vT2jgFdCpoUWZtEVlrhTzHSMqNe3L+SxoLq2oY5XHRXJJJq9xcx/21xH0B
        pWaUlYagSN4x9cGulzoMt6TSb+oXst0=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-gRe12vDbOA6XIwJcCL4AFw-1; Tue, 18 Jul 2023 11:52:12 -0400
X-MC-Unique: gRe12vDbOA6XIwJcCL4AFw-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4409ff60c89so832774137.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689695528; x=1692287528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCJR11Z8LE62Lpm8j/WH0EMwgBueVBllyGpJYTK0igw=;
        b=bafQYVAhgQJFoDszS262gQdiYmt7cTAFSOw5WkYJS+2hqgR1XssUprM01sKJzAEVix
         yjELjPKo+aQqoUrnEGGKpTQAU5dHltqp1kz9oKhF8OPT2XCg1xBvYdHBbd2ww5Czmnof
         QC0eaM0mS1etRp57SPJ4DsdiO0hzFCpVUz4hR7k06h2kpJn3NhD2uaUNyQDVI2fNqbd4
         G1fAtY4ce5rOQPu9YBND5w5qOSvRatxatyztcxrQZ+b3dq5XNq/6299PQpzFM4zuXNoU
         6VikTrXkECYyRDzXDdjJGP694+1P3/tBhpku7aLy3EWsCxu7zhYn5JbBx/RWvIWmZRH/
         exJA==
X-Gm-Message-State: ABy/qLbDRojM6eETMHHxlbnRlA+lcL8rx5X4ARFOxJohZAvl7BMZk3ax
        3ozKP5pQgU/KITSLGuqLg8Lds8mtCa+kiEOk6EyjC6NWqePKSN1MXayhVNmZ7WdR+0ccyOLIIs0
        z/nrT/AzabQivKGxl2p6I6S/Z9Aa3GSHgG4GP//Cx
X-Received: by 2002:a67:ff01:0:b0:443:791d:b238 with SMTP id v1-20020a67ff01000000b00443791db238mr6483883vsp.9.1689695528403;
        Tue, 18 Jul 2023 08:52:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHx7TnoVha2KQxDUcfbEVH1mqMZlCoaaSbpuFUe/jJOhtq97LtyZ/ltqGMFo5x/i9o+5gqoReLi5dj6ji6SGrI=
X-Received: by 2002:a67:ff01:0:b0:443:791d:b238 with SMTP id
 v1-20020a67ff01000000b00443791db238mr6483867vsp.9.1689695528166; Tue, 18 Jul
 2023 08:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230711154449.1378385-1-eesposit@redhat.com> <ZK/9MlTh435FP5Ji@gambale.home>
 <df7941b9-11ea-9abd-e070-4e9926aecdc3@redhat.com> <CAMw=ZnTSyeL4x1o_GVKNsZdCUe2D2H53quK-TSFhOkuONjC73A@mail.gmail.com>
In-Reply-To: <CAMw=ZnTSyeL4x1o_GVKNsZdCUe2D2H53quK-TSFhOkuONjC73A@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 18 Jul 2023 17:51:56 +0200
Message-ID: <CABgObfb_jGgs-yMSsHtHhEStFDp4f072LN7pW+3dSuVhAP87Ag@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
To:     Luca Boccassi <bluca@debian.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        lennart@poettering.net, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 4:03=E2=80=AFPM Luca Boccassi <bluca@debian.org> wr=
ote:
>> If you try to do this for the OS, however, Linux's "vulnerabilities are
>> just bugs" mantra hits hard---more specifically the reverse: all bugs
>> are potential vulnerabilities.  Sure you can hope for the best, which is
>> what we do with module signing and with the (non-upstream) secure boot
>> lockdown patches.  In the end, however, an unpatched code execution or
>> memory write vulnerability is always a potential rootkit.  While we
>> don't have _too_ many of those, there are enough that the idea of a
>> revocation index becomes completely unfeasible, not too mention those
>> that are fixed silently not because "that's the way Linus does it" but
>> rather because we genuinely didn't think of them as security fixes.
>
> Lockdown is upstream and has been for several years.

Almost (the missing part is automatically locking down the kernel if
running under secure boot, which is what I referred to).

> Grub also gets plenty of bug fixes that are not classed as security
> fixes, and so does Shim, and so does everything else. And they both
> have plenty of user interaction, and plenty of variability. Heck, Grub
> has its own complex configuration language that can take live input at
> boot, _and_ reimplements most of the kernel filesystems!
>
> But anyway, from the point of view of the 3rd party CA plus Shim
> workflow, they are the same, and can be treated the same - sorry, but
> the kernel is not special in any way. The only thing that matters is
> if, given a bug, somebody either observed it being used as a secure
> boot bypass by bad actors in the wild, or was bothered enough to write
> down a self-contained, real and fully working proof of concept for
> secure boot bypass.

Maybe I'm misunderstanding but this makes no sense to me. Any code
execution vulnerability by definition lets the attacker run unsigned
code in the kernel, which is a secure boot bypass. Linux is indeed not
special in this respect; "wait for someone to exploit it and then bump
the number" is at least dubious for Grub as well.

In my opinion there is still a difference though, in that the amount
of untrusted/unsigned userspace code that the kernel is exposed to,
absolutely dwarfs the amount of code and data that a bootloader is
exposed to. For the case of filesystems, for example, Linux is a lot
more optimized, it's multithreaded, it's read/write. Grub is a lot
simpler.

> > So perhaps there could be some kind of protocol that would let a new
> > kernel tell the bootloader "don't boot an older kernel than me in the
> > future".  It could even be an extension to the SBAT spec itself.  I
> > haven't really thought much about it, tbh.  However, I'm quite positive
> > that a revocation index attached to the kernel image cannot really work
> > as a concept, not even if it is managed by the distro.
>
> You are pretty much describing SBAT there. Except for the detail that
> it can't be the component that can be compromised that tells you
> whether it's compromised and you should trust it... A system's SBAT
> policy is a single entity, managed centrally, and deployed everywhere.

Fine, so can the SBAT spec be extended to have some kind of version
that is not a single number? If that is provided, Linux could have the
mechanism to place the kernel version in the .sbat section. But I
agree with Borislav, Greg and others that a single revocation index
simply doesn't cut it.

Paolo

