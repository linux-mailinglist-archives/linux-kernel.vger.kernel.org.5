Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547C479F9B0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 06:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbjINE7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 00:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjINE7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 00:59:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657641BCA;
        Wed, 13 Sep 2023 21:59:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41CBC433CB;
        Thu, 14 Sep 2023 04:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694667542;
        bh=wLkWD04B2xa7TQx0D5bra1Q6voiVSSnJawGwOHhDU5o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p/CeThb8Ogiec2Ix26s9RcxL50HMIXOLb/uw3MU/sv5Zm3HvbEDs7imVbs+V5VeBM
         V27rUnWRAGwzPbXCnfU/eC0NWDhruNVLl4YeuTTpDLswR7GsFVSm9UTR13JdVIs9b7
         jbwsbvsmNG2Kdx4qxRU6iCeQ/lmgYY6lWE6N9DHX+U5RU2oagTTEwxSnaihF/v4sEL
         dQzLhktxDTY1TLGY3Fdzb2Uw57oDwqtNhvb8DfyFnlIxyiRvv6LNeqDSt60xtAAxBK
         D6wJT9A8GOnbUf/wKWjOaZ1ncIf6XjoantUNdbLV7L4rnEs2xdPe5ZxGzfJeUSB/Jg
         ChhJiIWTe8FPw==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3a9f87adfe1so317842b6e.1;
        Wed, 13 Sep 2023 21:59:02 -0700 (PDT)
X-Gm-Message-State: AOJu0YxDpz0yL/QoYqXyAtLFxDWIpXMuXAauyCrbYQGidqqB048P3EPd
        q0KxpeRu0UnAAa1w7Ux/VaSGaxcH6QVJsAo3R2Q=
X-Google-Smtp-Source: AGHT+IHZXwwODW3Y9+QVD8PZUEWVkMRt30jsX95KeliUBIRj3Lz5NQiQAY870OUDAhQW02cRCea/+dky6t2nPwzEVpA=
X-Received: by 2002:a05:6870:9726:b0:1d5:b9e1:d378 with SMTP id
 n38-20020a056870972600b001d5b9e1d378mr5460840oaq.24.1694667542260; Wed, 13
 Sep 2023 21:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230722044806.3867434-1-masahiroy@kernel.org>
 <20230722044806.3867434-11-masahiroy@kernel.org> <4780dc94-653b-7ae4-0f50-45af625726e7@hisilicon.com>
In-Reply-To: <4780dc94-653b-7ae4-0f50-45af625726e7@hisilicon.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 14 Sep 2023 13:58:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNASvgVBZ+zdPX4ExjbYc9rzSFm-VNoN_L=Q2aWj+t_mrnA@mail.gmail.com>
Message-ID: <CAK7LNASvgVBZ+zdPX4ExjbYc9rzSFm-VNoN_L=Q2aWj+t_mrnA@mail.gmail.com>
Subject: Re: [PATCH 11/19] kbuild: rpm-pkg: use a dummy string for _arch when undefined
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 4:09=E2=80=AFPM chenxiang (M) <chenxiang66@hisilico=
n.com> wrote:
>
> Hi,
>
> I build the latest kernel (6.6-rc1) for arm64 platform on x86 server
> (with cross complile), and the complile command is as following:
>
> export
> PATH=3D$PATH:/opt/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu/bin/
> export ARCH=3Darm64
> export CROSS_COMPILE=3Daarch64-linux-gnu-
>
> make -j64 Image (ok)
>
> make binrpm-pkg -j64 (failed)
>
> But when complile binrpm-pkg, it is failed and the error info is as
> following:
>
> rpmbuild -bb kernel.spec --define=3D'_topdir
> /home/chenxiang/kernel/mainline/linux-next/rpmbuild' --target
> aarch64-linux --build-in-place --noprep --define=3D'_smp_mflags %{nil}'
> $(rpm -q rpm >/dev/null 2>&1 || echo --nodeps) --without devel
> rpmbuild: --build-in-place: unknown option


I cannot reproduce it on my build environment,
but the error message:

  rpmbuild: --build-in-place: unknown option

describes the issue.


Which version of rpmbuild did you use?

Using a newer version fixes the issue?









--
Best Regards
Masahiro Yamada
