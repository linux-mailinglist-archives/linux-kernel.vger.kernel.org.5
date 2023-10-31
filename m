Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A947DC6D9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343529AbjJaHEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343508AbjJaHD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:03:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C92DE;
        Tue, 31 Oct 2023 00:03:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B36C433CC;
        Tue, 31 Oct 2023 07:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698735835;
        bh=KOt/6Bh0881X6hZfLd45iFiPDRPO/IaJmQQYpuDVKI0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qH3NrNOh96Z0KT5JpxiiCbHuAKKZVgpNG+8L6k+NNrguvROADqrZbB3itVpz1X+gp
         iczt8jT1rGDuxzIbPidyppB7NqyIfAYSeIvPvXWeBhU+FKNaBkv2NQptJh03VACA+7
         /pJE+B8r5lS2s37CL/BTD5WvLJygnBbd3hzU8KiqSepB4kzV9rL+5NfCwsWvnHL+Fq
         LS+R6gN5Bhg9Ll01u2O/KpqMsR+kaTkA0WqXtx/a9iJVJCRURy+fG9QxiOFNtvIOqU
         PxRYQWwS+kAT3k9vwN5V/aCyF4pFprGqBvSXpYTWav4+q3i6/MhF70NBTpmGQjvo/K
         R4BJOSC7XPLqA==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3b2f2b9a176so3500919b6e.0;
        Tue, 31 Oct 2023 00:03:55 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz2gBzTreaDElQWQHhwU6KihtpxJFVLPjVvaK7OxzKSr6GAhWR1
        TZbJPoY2eWx6Ko3tl3G52qhiyrLT3O8L0NJen4c=
X-Google-Smtp-Source: AGHT+IFhQbL2GXvlStOCa9WbIcCqYEWgNQXQ5SvyyYzHaZ0dCtw7TrWnmT++4MnCQr/b51E4av5FWAhY1H0ZF2//3r8=
X-Received: by 2002:a05:6870:4c05:b0:1e9:d158:2465 with SMTP id
 pk5-20020a0568704c0500b001e9d1582465mr14892187oab.17.1698735834939; Tue, 31
 Oct 2023 00:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231026072628.4115527-1-sjg@chromium.org> <20231026072628.4115527-4-sjg@chromium.org>
 <CAK7LNASATGRaS-6QxzqTEq7qNVkZPXOBE8pfRBg=2bQGyy3=yw@mail.gmail.com>
 <CAFLszThguWT0u0R0EHfpBro0f-pWDwLOGk+5pQZEVhFYNKH8fQ@mail.gmail.com>
 <ZT/NRvLkvR8uuP5+@shell.armlinux.org.uk> <20231030161209.GU496310@bill-the-cat>
In-Reply-To: <20231030161209.GU496310@bill-the-cat>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 31 Oct 2023 16:03:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ=K9Az9UN0O-tCC6VFwMWgdNJUcHBmmQTn5-Y7_m8OOQ@mail.gmail.com>
Message-ID: <CAK7LNAQ=K9Az9UN0O-tCC6VFwMWgdNJUcHBmmQTn5-Y7_m8OOQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: boot: Support Flat Image Tree
To:     Tom Rini <trini@konsulko.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Simon Glass <sjg@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 1:12=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Mon, Oct 30, 2023 at 03:35:34PM +0000, Russell King (Oracle) wrote:
> > On Sun, Oct 29, 2023 at 05:46:12AM +1300, Simon Glass wrote:
> > > Hi Masahiro,
> > >
> > > Sure, but that is a separate issue, isn't it? We already support
> > > various boot targets in arm64 but not one that includes the DTs, so
> > > far as I can see. The old arm 'uImage' target is pretty out-of-date
> > > now.
> >
> > Does that mean it can be removed? ;)
> >
> > I've NAK'd FIT support on 32-bit Arm in the past, and I remain of the
> > opinion that boot loader specific packaging of the kernel should not
> > be in the kernel but should be external to it - even more so given the
> > multi-platform nature of 32-bit Arm kernels.
>
> I'll point it out here rather than Simon. As part of
> https://github.com/open-source-firmware FIT is a standard and not "boot
> loader specific". And one of the points of a FIT image is that you can
> easily support multi-platform kernels in a single file (without
> optimizing things further, at a cost in tens of milliseconds on a Pi 3
> anyhow) and with user-controlled security.
>
> --
> Tom



It is a copy of the document in U-Boot.

The file was split into two, but the content is the same.


[original in U-Boot]
https://github.com/u-boot/u-boot/blob/v2023.10/doc/usage/fit/source_file_fo=
rmat.rst


[flat-image-tree]
https://github.com/open-source-firmware/flat-image-tree/blob/v0.8/source/ch=
apter1-introduction.rst
https://github.com/open-source-firmware/flat-image-tree/blob/v0.8/source/ch=
apter2-source-file-format.rst





--
Best Regards
Masahiro Yamada
