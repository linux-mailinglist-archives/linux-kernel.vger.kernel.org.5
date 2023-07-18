Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83395758416
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjGRSFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjGRSFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:05:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0D5A1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:05:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28A606165F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 18:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578FDC433C7;
        Tue, 18 Jul 2023 18:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689703530;
        bh=T+w+JLxHTVEHg9YoBJPgRg++YjqipJExjPFcJ7KLG90=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=VoBZ33Vs92ylWT9T7sZf2UoOU87pYyxQWD0ywrg8+cx0wJ3EU5VXUnNZu5w2GJy55
         Tnr2qxqvCca3Nx5BnHqwbUV+TL8oln/PKoGy9f4Qa0i+10gwrHFRly2faxq/r0alb8
         1SzUagNlLnVxl5ku69sfaE8l4/OXvL5k/IcHatGcxKpxDKAZ85/6w1xtMesefGZMF3
         6PQwGUuRGSRaBd7sQw0tpfpGehvw/6jyjgWz7QndOsZJpBma1joPhhheDk6NCuJrrq
         BYXcQMCi8lAiUnAnQnJte4sfUqz5EFBOF+a39oH/jg6fA8Ytmw51ggIzA4tUB8+51d
         F5VZ2YCn1Y8Zw==
Date:   Tue, 18 Jul 2023 11:05:23 -0700
From:   Kees Cook <kees@kernel.org>
To:     justinstitt@google.com, Justin Stitt <justinstitt@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] net: dsa: remove deprecated strncpy
User-Agent: K-9 Mail for Android
In-Reply-To: <20230718-net-dsa-strncpy-v1-1-e84664747713@google.com>
References: <20230718-net-dsa-strncpy-v1-1-e84664747713@google.com>
Message-ID: <316E4325-6845-4EFC-AAF8-160622C42144@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 17, 2023 5:04:19 PM PDT, justinstitt@google=2Ecom wrote:
>`strncpy` is deprecated for use on NUL-terminated destination strings [1]=
=2E
>
>Even call sites utilizing length-bounded destination buffers should
>switch over to using `strtomem` or `strtomem_pad`=2E In this case,
>however, the compiler is unable to determine the size of the `data`
>buffer which renders `strtomem` unusable=2E Due to this, `strscpy`
>should be used=2E
>
>It should be noted that most call sites already zero-initialize the
>destination buffer=2E However, I've opted to use `strscpy_pad` to maintai=
n
>the same exact behavior that `strncpy` produced (zero-padded tail up to
>`len`)=2E
>
>Also see [3]=2E
>
>[1]: www=2Ekernel=2Eorg/doc/html/latest/process/deprecated=2Ehtml#strncpy=
-on-nul-terminated-strings
>[2]: elixir=2Ebootlin=2Ecom/linux/v6=2E3/source/net/ethtool/ioctl=2Ec#L19=
44
>[3]: manpages=2Edebian=2Eorg/testing/linux-manual-4=2E8/strscpy=2E9=2Een=
=2Ehtml
>
>Link: https://github=2Ecom/KSPP/linux/issues/90
>Signed-off-by: Justin Stitt <justinstitt@google=2Ecom>

This looks fine to me=2E I think the _pad variant is overkill (this region=
 is already zero-initialized[1]), but it's a reasonable precaution for robu=
stness=2E

Honestly I find the entire get_strings API to be very fragile given the la=
ck of passing the length of the buffer, instead depending on the string set=
 length lookups in each callback, but refactoring that looks like a ton of =
work for an uncertain benefit=2E

Reviewed-by: Kees Cook <keescook@chromium=2Eorg>

-Kees

[1] https://elixir=2Ebootlin=2Ecom/linux/v6=2E3/source/net/ethtool/ioctl=
=2Ec#L1944


--=20
Kees Cook
