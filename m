Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D63758ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjGSHW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGSHW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:22:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE0B2113;
        Wed, 19 Jul 2023 00:22:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC51160C89;
        Wed, 19 Jul 2023 07:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0520BC433CB;
        Wed, 19 Jul 2023 07:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689751348;
        bh=v+KzWx3A540NW8aAgQGBA0OhgGvyrwyOdzXHhvq2quA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NHG0AIdGyV6plj0mYiDIUa1yfQ5R7aui2+xWEKeiQzUzb0dxb6CtzvOOZUtFUK94I
         /HVFlu8bollcLb61dFxUa85WDSiDjERnKi1ERRX0y9/438ka1Q/IeHiRVb7VjqUoI3
         5yyVH21Ou7O+MCquJtxgpf+7lz4qHbMVyayzg2aCqjbpI94Ikpuxv4jla7WwvnjaVp
         plzW8C/0FqZaWEC0XX6N9vNvircV3o+ZxJIC9K5bHt/qfqW8MYwTJ56N+WpmdEjE/m
         HMTpWhR5yxsd3ZVqKjf9Pm/zb8ZYfmlrLBm+qFASmOHzv7sZqXghzgmSbS2ZYCkzqq
         Cess+QHAYBsjw==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51e566b1774so8696607a12.1;
        Wed, 19 Jul 2023 00:22:27 -0700 (PDT)
X-Gm-Message-State: ABy/qLaaQFbU848g2ACF4wKf8XhC56MoOKtIJQbZW2xW+E4mL9EV5fOv
        06MEt6hUloQTfjMvqK7j5SYbTBOE+CXyT9gICuo=
X-Google-Smtp-Source: APBJJlGgFowu6dGDg4naL/LQVEuvtSanlod0S5HMByJDn7shqAJ5E7r/8oPECUcfYfFdSH/QCwseM85/5g1ZvbZFZ1c=
X-Received: by 2002:a50:ef0c:0:b0:51d:d16f:7e52 with SMTP id
 m12-20020a50ef0c000000b0051dd16f7e52mr1734736eds.29.1689751346283; Wed, 19
 Jul 2023 00:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230718153348.3340811-1-chenhuacai@loongson.cn> <261edc6c-e339-faeb-3045-bfe6604d1aef@web.de>
In-Reply-To: <261edc6c-e339-faeb-3045-bfe6604d1aef@web.de>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 19 Jul 2023 15:22:13 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5nNMmYZQXvoog85cgMUd+gM2QMaG3cUhYk_iGzjB=B4Q@mail.gmail.com>
Message-ID: <CAAhV-H5nNMmYZQXvoog85cgMUd+gM2QMaG3cUhYk_iGzjB=B4Q@mail.gmail.com>
Subject: Re: [PATCH v5] LoongArch: Fix CONFIG_CMDLINE_EXTEND and
 CONFIG_CMDLINE_BOOTLOADER handling
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Zhihong Dong <donmor3000@hotmail.com>, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Guo Ren <guoren@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Markus,

On Wed, Jul 19, 2023 at 2:51=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> >                                                   =E2=80=A6, so this pa=
tch add
> > some code to fix it.
>
> Would you like to avoid a typo here?
>
> Will any other imperative change description variant become more helpful?
Thank you for pointing this out, but since Zhihong is the original
author, I don't want to completely rewrite the commit message, so just
fix the typo...

Huacai
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.5-rc2#n94
>
> Regards,
> Markus
