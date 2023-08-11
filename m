Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23932779A7D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 00:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbjHKWM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 18:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbjHKWMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:12:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C5F2D57;
        Fri, 11 Aug 2023 15:12:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90EB0671D7;
        Fri, 11 Aug 2023 22:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1C7C43391;
        Fri, 11 Aug 2023 22:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691791969;
        bh=ztw9IXTA9/o6jaHf5DITJvd7l5VINrbwaZzjvo3d3O0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VlZQbnZw09wcQ44V1aBYNpiCQsw138Dcl6b112zHVe5BIoN3dvVeGdcgU4Rgh1539
         Po6S35ZNC3Yl5WChH5pjAk5YBd4GkFY1TdIu3kS997MjPh1zxSV5L4owq/fQZJFtKY
         BFMWwatlZ8USddyC+1WtcWYnc6eMqCNGJu/uNLo8UWxPGDx/ZNhxKSrKr1eVkSdqlX
         aEp6X7OfW5fsJpsmoOPI024cDbv625iJ03+l4nQxYdlI/9nEi55L8zpS/Q5+VaEjCM
         bC48iKpO5Zqy6Nz0CdKnQAXZireCptH0kTr8ndtba8Xp373/NoTeXHIiwV7CI9A24X
         SuDWJ0ghQBcvg==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6bca38a6618so2231660a34.3;
        Fri, 11 Aug 2023 15:12:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YyV9aRFgF4SZEaX7wA3rV1CVxU/lPB1cM2i5IB6KkroxB3UPeQt
        oSB283UWAzWGFejwUmKlke+uURgYcfS+CRZBkUQ=
X-Google-Smtp-Source: AGHT+IEfdh6kicIrknsxiZKaSFGvZfQmiVUjcpL/vCCk+9ZURRj1QpbiA7Cy9bUe7RrCZOfhVLBG72d4hMvpBQTz44w=
X-Received: by 2002:a05:6870:82a4:b0:1c0:d0e8:8ff0 with SMTP id
 q36-20020a05687082a400b001c0d0e88ff0mr3207005oae.17.1691791968250; Fri, 11
 Aug 2023 15:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230810141947.1236730-1-arnd@kernel.org> <20230810141947.1236730-16-arnd@kernel.org>
In-Reply-To: <20230810141947.1236730-16-arnd@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 12 Aug 2023 07:12:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNARfEmFk0Du4Hed19eX_G6tUC5wG0zP+L1AyvdpOF4ybXQ@mail.gmail.com>
Message-ID: <CAK7LNARfEmFk0Du4Hed19eX_G6tUC5wG0zP+L1AyvdpOF4ybXQ@mail.gmail.com>
Subject: Re: [PATCH 15/17] arch: fix asm-offsets.c building with -Wmissing-prototypes
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "David S. Miller" <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Qing Zhang <zhangqing@loongson.cn>,
        Donglin Peng <pengdonglin@sangfor.com.cn>,
        Qi Hu <huqi@loongson.cn>, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 3:30=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When -Wmissing-prototypes is enabled, the some asm-offsets.c files fail
> to build, even when this warning is disabled in the Makefile for normal
> files:
>
> arch/sparc/kernel/asm-offsets.c:22:5: error: no previous prototype for 's=
parc32_foo' [-Werror=3Dmissing-prototypes]
> arch/sparc/kernel/asm-offsets.c:48:5: error: no previous prototype for 'f=
oo' [-Werror=3Dmissing-prototypes]
>
> Address this by making use of the same trick we have on other architectur=
es,
> renaming the unused global function to main(), which has an implicit
> prototype.


main() only works for one function call, but
there are some cases where splitting the code
into some functions makes the code cleaner.




> On loongarch, there are many functions in this file, so the trick does
> not work, adding explicit declarations works around it in a slightly
> more ugly way but is the best I could come up with here.

I do not like repeating the function names.

Could you try "static + __used" as in
arch/x86/kernel/asm-offsets.c ?





--
Best Regards
Masahiro Yamada
