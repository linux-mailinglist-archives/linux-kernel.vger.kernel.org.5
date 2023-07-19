Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6675375968B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjGSNWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjGSNWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EC310A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689772916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V3umeikrItXqYLby3sWlC1RURLtfjThCT16UUAL2bp8=;
        b=DC+J5syY5Pu+MSUvxn+ioJpnzU2kE68+XuHbb4Trwl3Tsz+8Gni1LOdXXNBa3g2ltN1OjS
        da2Z6pbK6WUn12MhQe8Mfr/Wxx/yRHEF5rtwI4r5h2NihXFUrtOycHJtlzMwrIQXCwhEqF
        IJvZLOan58KUrXT5cumaUwcqEEKEVsc=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-7gIfwccUMheSNCfdufmNaA-1; Wed, 19 Jul 2023 09:21:55 -0400
X-MC-Unique: 7gIfwccUMheSNCfdufmNaA-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-440aef0aa27so645910137.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689772914; x=1692364914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3umeikrItXqYLby3sWlC1RURLtfjThCT16UUAL2bp8=;
        b=BWazcNcmhB/dwqa4sxsav87cQCzAppJ0x2Y15H7oqKfopGzRkEEaUgDY/vnQDiXM0Z
         mHlgDsUNad2TScElRUlwcoTCw0v45Q6SbYpzgzDEFdzjTk2beZf7WV9Ks0XXGqHv15Zi
         SQ3wsNqBWIADN5QBZiY1JCRllcVeB2y2IXeygPSNNiFtmdExv1mcW/KYLa6rtQHT4Q0o
         j1mTrSxr0MyX+6U9hsUms9/1IqwHMThBG4gc6R5FZZ9sbMknd/AV/miiZFURZ6cbQan7
         IZwEecQNkOox3Kxvz2/uPi6bGYmIwpy0mMRChFKa1FaTLyMVdraOEU7AGv+Lg3TzqsP2
         pvFg==
X-Gm-Message-State: ABy/qLaEx8tHyLTGU+re/tnqAGSE5oH5sRxvBiAPuFwKpY38ILHk1gmr
        7MOIyah7kSe+OxB7zu/ZIYdZ6wEANSOTjNt/KA4n2zuLvVn2lRs5I+P5H1PicAB67Yqe7X7oNCT
        IZ1ODovLx7R8gZpCJboBgqYd4nq0SU5XGwXMRGZT2RlZd4mDrs4Y=
X-Received: by 2002:a05:6102:2ca:b0:445:208:3516 with SMTP id h10-20020a05610202ca00b0044502083516mr6954328vsh.0.1689772914451;
        Wed, 19 Jul 2023 06:21:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlECozSJ30WSNLcKSj/wtqikVuhvH1WNV9MqGkzw60nIj2gLV/7o/N3z6hQQJTMscqqCVsWfK1FFwhA5+T8iauI=
X-Received: by 2002:a05:6102:2ca:b0:445:208:3516 with SMTP id
 h10-20020a05610202ca00b0044502083516mr6954308vsh.0.1689772914190; Wed, 19 Jul
 2023 06:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230711154449.1378385-1-eesposit@redhat.com> <ZK/9MlTh435FP5Ji@gambale.home>
 <df7941b9-11ea-9abd-e070-4e9926aecdc3@redhat.com> <CAMw=ZnTSyeL4x1o_GVKNsZdCUe2D2H53quK-TSFhOkuONjC73A@mail.gmail.com>
 <CABgObfb_jGgs-yMSsHtHhEStFDp4f072LN7pW+3dSuVhAP87Ag@mail.gmail.com> <ZLa/R9tZ0hB0KOXj@redhat.com>
In-Reply-To: <ZLa/R9tZ0hB0KOXj@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed, 19 Jul 2023 15:21:39 +0200
Message-ID: <CABgObfZjVrGOSn8iuFeUBOv3NAU_HB-6vtUTCRcSPW=Guua1jQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
To:     =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc:     Luca Boccassi <bluca@debian.org>, Ard Biesheuvel <ardb@kernel.org>,
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 6:35=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> There's a slight caveat that when parsing sbat shim currently appears
> to store the generation number in a uint16, so the size is somewhat
> limited. Probably still just enough bits to encode a kernel version,
> though changing shim code to uint32 looks easy enough too.

Encoding a kernel version needs a uint32 if you want to make it human
readable; you need at least 10^6 (9.99.999) for the upstream version.

However a SBAT policy based on kernel versions will not allow stable
versions, so it's basically unusable.

One possibility would be to encode the major and minor versions as
different products, so a Fedora package for Linux 6.1.137 would have:

linux.6,1,Linux,https://kernel.org/
linux.6.1,137,Linux 6.1.y,6.1.137,https://kernel.org/
linux.6.1.fc38,302,Fedora,6.1.137-302.fc38,https://koji.fedoraproject.org/k=
oji/packageinfo?packageID=3D8

where old kernel versions can be "prohibited" without consuming too
much space in the policy, for example

linux.5,255       # block all 5.x kernels.
linux.6.1,138    # oh no, 6.1.137 had a *really* bad vulnerability

The questions then are

1) if this satisfies the requirements

2) if upstream people accept to expose the version in this format in
the upstream kernel

> Directly encoding the version number though has implications for
> revokation wrt stable branches though. My impression is that the
> generation number was intentionally separate from a version number,
> so that people could backport particular fixes to a stable branch
> and then declare it to be the same "generation" as the latest
> devel branch, or other stable branches which also included the
> equiv fixes.

Right, but that also requires a central authority that makes up these
revocation indices. This is unlikely to happen for Linux. :)

Paolo

> Obviously that presumes that an old branch can be made secure by
> selectively backporting patches. That is a view which is obviously
> not universally accepted, especially in upstream context, as clearly
> expressed in several mails in this thread. It is what distros would
> typically claim to achieve though. I'm not sure it is possible to
> satisfy both those differing views.
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

