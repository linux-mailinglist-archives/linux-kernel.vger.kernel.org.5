Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF9D75993D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjGSPMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjGSPMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:12:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FD1E6F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689779482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AHRnuCablbWqrA+Hti70vOGADpZIM1PYpR/CUGSTLvI=;
        b=J2PSHkjsqcndq1rZrvQMZv+hQhs6txYG/JxhgRmHGKpuYcwu8e7rJ42UW0NS9vB7bkWZPd
        vg4gRn40Ysi5ALxyRNaqzsmEcgltkTc3bAQW1J3YdZ0CB0W8yT+eQxUdnl+4eQfEGEaUSa
        MQ+qDGvcF536yNCg7UE2WKF+8uTlc3A=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-WoFWUrGtPQSJKDXMQBW6YA-1; Wed, 19 Jul 2023 11:11:20 -0400
X-MC-Unique: WoFWUrGtPQSJKDXMQBW6YA-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5634c4df8c4so9302587eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689779479; x=1692371479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHRnuCablbWqrA+Hti70vOGADpZIM1PYpR/CUGSTLvI=;
        b=ZEt5cQgmIV8fS/pWH+LMH+aggWdaqi8l6296Kow6rwMhxiyDHG3ZktT6UxkKbcRQW4
         GADZ0AbUnlUqPY8V0ZEAMeR+U0lJgGPO65jHPyqus0cc+ca5j4JHFnOpmTTg2+JWQZRz
         88OnruQaT9jPgb8neS6rpa73o5ncCBeP+ql3aiXEOMpV1wQUpSPp9vPyiWddlacLtkSg
         ZUBnUh8UAtFnsgy0MPMjgu+Lex/3tQyXKT5xWlRt9OtaHYPdXpyHVVpLreX5Rp7nHmpV
         3dtgyZNkiwl/HEd4qDFnHtp78peCnQEKruhVa+U6J+X3VtaXtwFnCxmgCQ58ldAANSLG
         pmIQ==
X-Gm-Message-State: ABy/qLZkvkyeXE6fJOKh5kIwhxWSfH4uHyh53PX+wlAB3r5ZIL6G4xBe
        1FyewXGsn6hJEVIFp3S3xjYhng7YWk02kx4kNyqXAm3i6eo7OOOxC5N8Gf90zQcU/9ITQ85H7oG
        ahVjDDc2wuYTMgvuMDEX3CtcdNIZniFIoEUAb70rH
X-Received: by 2002:a05:6358:3402:b0:134:ec9d:ef18 with SMTP id h2-20020a056358340200b00134ec9def18mr2670027rwd.28.1689779479386;
        Wed, 19 Jul 2023 08:11:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHglypeNUFvOetpqJlHqRyqAFcAlBHSc84SbOUCTi+2hXaMAz9AjtAZFw42SZ3qFKh0HMfUb78Re84SSyC+Bsk=
X-Received: by 2002:a05:6358:3402:b0:134:ec9d:ef18 with SMTP id
 h2-20020a056358340200b00134ec9def18mr2670004rwd.28.1689779479053; Wed, 19 Jul
 2023 08:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230711154449.1378385-1-eesposit@redhat.com> <ZK/9MlTh435FP5Ji@gambale.home>
 <df7941b9-11ea-9abd-e070-4e9926aecdc3@redhat.com> <CAMw=ZnTSyeL4x1o_GVKNsZdCUe2D2H53quK-TSFhOkuONjC73A@mail.gmail.com>
 <CABgObfb_jGgs-yMSsHtHhEStFDp4f072LN7pW+3dSuVhAP87Ag@mail.gmail.com>
 <ZLa/R9tZ0hB0KOXj@redhat.com> <CABgObfZjVrGOSn8iuFeUBOv3NAU_HB-6vtUTCRcSPW=Guua1jQ@mail.gmail.com>
 <CAMw=ZnR6DBPxwdbP9jJRLzkryaoz++Nkxx5KV-3RdHL5PXKoqQ@mail.gmail.com>
In-Reply-To: <CAMw=ZnR6DBPxwdbP9jJRLzkryaoz++Nkxx5KV-3RdHL5PXKoqQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed, 19 Jul 2023 17:11:07 +0200
Message-ID: <CABgObfYRFsL__HCEb+AyzR2xfS_XAJHqnqtMef7bhuPWJOW6Cw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
To:     Luca Boccassi <bluca@debian.org>
Cc:     =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 3:34=E2=80=AFPM Luca Boccassi <bluca@debian.org> wr=
ote:
> > Right, but that also requires a central authority that makes up these
> > revocation indices. This is unlikely to happen for Linux. :)
>
> It will happen, the only question is how painful it is going to be to
> maintain it. The revocation payload is unique and global, and it could
> not be otherwise. Just like DBX is published centrally, and just like
> Shim signing is done centrally.

If you are intending to go with the generation number, that
essentially means tracking vulnerabilities and that's a business that
Linux developers don't want to be in. And in fact, neither DBX nor
shim signing is managed by (upstream) open source projects. That
raises many other questions:

- What is the right place for that generation number authority and for
the registry of vulnerable kernel versions? Is it shim/mokutil, and if
so are the developers on board with doing that? How are SBAT updates
currently distributed?

- Distros will have to be the ones setting the SBAT policy. If the
central authority will use the "exploit in active use" policy (which
IMNSHO is nothing but security theater), are all distros that consume
ukify fine with that or do they want to actually start tracking kernel
vulnerabilities?

- Sorry for beating on the "Linux is different" dead horse, but what
happens if people for whatever reason don't want to run the latest
kernel? If a stable kernel update breaks hotplugging of external
displays and fixes a code execution vulnerability in a weird device
driver, do I have to fiddle with mokutil in order to keep my external
display working? Or replace "breaks hotplugging of external displays"
with "breaks the NVIDIA driver".

In any case, I think there's agreement that it's not a Linux developer
problem, so the discussion can continue elsewhere.

Paolo

