Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65421784BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjHVVHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjHVVHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:07:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB545CF3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692738381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eozuvkXZf7lt2j4GJR5fEMVPoz5joKAi735jAZphMzo=;
        b=BAb2chtr9jmuQF5TF6QDuWcbsUTQ76d9cS4AeyY/6s0XOKW6dcE3q+UTThGPxKWgwOHUGZ
        17XScQKR2J2mMyRNQ6T6885wXIXK7g4ClkNQ98nLy8Oh/0SlmKnveaeIAh3nl6o8kWNpmn
        vQCDDgfA8gnic7SnEgoPVD9ItSwQW9c=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-8S8a3y05OKuv6OpUkkBPFA-1; Tue, 22 Aug 2023 17:06:19 -0400
X-MC-Unique: 8S8a3y05OKuv6OpUkkBPFA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fe3c8465e0so5260151e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692738374; x=1693343174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eozuvkXZf7lt2j4GJR5fEMVPoz5joKAi735jAZphMzo=;
        b=bpLe/zYw+C7fQBjgMr4uAeAbXh6IwCuwlFvTnN1rhOMk1wwQtxKtwvnPW67fT8Hqyk
         62l33NRpHgY58WqjQxDLfu1n95nip8ex54F+KrPTKfoaptZg83g+b3BBMUU19DalojdS
         sGmSnKkieSBrRYiAGxLXcU8fnrN1rzU+MBz++Eqtl65nOefts79s0VhH0M/SMVehYYI7
         os8kCdXl+JknRDAPoKWAf4E0BzXbJpNG9XiMtErz4L0eGjp3bSu+UlnYjnuPxZlwjeDV
         cmjDBDIxsP3VZDdzoHz3VSx24cms95b9WqXal87neiAmJ8aVKveZ5USo/QMnvynZKei2
         pjsA==
X-Gm-Message-State: AOJu0Ywl7ebul2NF59MrbF/KklyJZSkNROkC4E6BrxynaAMwpDHs7ooX
        uksTT9ruTsZqceKzWBBEEu9L+mD+aJA5u/ZFwkhs1Vq5TTJZWnOF3+xP43noXkBsVW9gMDpqyNA
        yS2/spIrS3RMrtd8oJPTL4E4IGe345mQOwUIhlxx8
X-Received: by 2002:ac2:55a7:0:b0:500:8fcd:c3b5 with SMTP id y7-20020ac255a7000000b005008fcdc3b5mr1464016lfg.12.1692738374175;
        Tue, 22 Aug 2023 14:06:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeNyF1wlvbOJcWPDTAWORFiO3zXf51SnVR8DhrtgaVaRfNn3Wuj/OWqV2eXbAGJfYHTm1809Rq9Jm3OA9QzNg=
X-Received: by 2002:ac2:55a7:0:b0:500:8fcd:c3b5 with SMTP id
 y7-20020ac255a7000000b005008fcdc3b5mr1464006lfg.12.1692738373861; Tue, 22 Aug
 2023 14:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
 <CAKwvOd=p_7gWwBnR_RHUPukkG1A25GQy6iOnX_eih7u65u=oxw@mail.gmail.com>
 <CAO-hwJLio2dWs01VAhCgmub5GVxRU-3RFQifviOL0OTaqj9Ktg@mail.gmail.com> <CAFhGd8qmXD6VN+nuXKtV_Uz14gzY1Kqo7tmOAhgYpTBdCnoJRQ@mail.gmail.com>
In-Reply-To: <CAFhGd8qmXD6VN+nuXKtV_Uz14gzY1Kqo7tmOAhgYpTBdCnoJRQ@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 22 Aug 2023 23:06:02 +0200
Message-ID: <CAO-hwJJ_ipXwLjyhGC6_4r-uZ-sDbrb_W7um6F2vgws0d-hvTQ@mail.gmail.com>
Subject: Re: selftests: hid: trouble building with clang due to missing header
To:     Justin Stitt <justinstitt@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 10:57=E2=80=AFPM Justin Stitt <justinstitt@google.c=
om> wrote:
>
[...]
> > > > Here's the invocation I am running to build kselftest:
> > > > `$ make LLVM=3D1 ARCH=3Dx86_64 mrproper headers && make LLVM=3D1 AR=
CH=3Dx86_64
> > > > -j128 V=3D1 -C tools/testing/selftests`
> >
> > I think I fixed the same issue in the script I am running to launch
> > those tests in a VM. This was in commit
> > f9abdcc617dad5f14bbc2ebe96ee99f3e6de0c4e (in the v6.5-rc+ series).
> >
> > And in the commit log, I wrote:
> > ```
> > According to commit 01d6c48a828b ("Documentation: kselftest:
> > "make headers" is a prerequisite"), running the kselftests requires
> > to run "make headers" first.
> > ```
> >
> > So my assumption is that you also need to run "make headers" with the
> > proper flags before compiling the selftests themselves (I might be
> > wrong but that's how I read the commit).
>
> In my original email I pasted the invocation I used which includes the
> headers target. What are the "proper flags" in this case?
>

"make LLVM=3D1 ARCH=3Dx86_64 headers" no?

But now I'm starting to wonder if that was not the intent of your
combined "make mrproper headers". I honestly never tried to combine
the 2. It's worth a try to split them I would say.

Cheers,
Benjamin

