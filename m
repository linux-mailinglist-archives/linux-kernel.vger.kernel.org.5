Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F8A7D1BD9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 11:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjJUJAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 05:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjJUJA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 05:00:28 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3E0D5E
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 02:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1697878821; bh=ib6PvBAEB831b6B1F4AscuAf5fSl2DvQCEkNQMATHLE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=JqbLO0gwBqZuMtj/UuyuYFa/W96RGsHLnJB3MukjOQT73L5lqOZZ0BA11SYdS+/+P
         wa3BWZkoAozM2Q7tP3ZTXTL7PWc6fNOpJz/CswKMw7WJwS7DDbVZP/NT9nkl+rbAq2
         oPX2DlyYE6RUo6wjgJXUJF+WhvVYpxyWbLBnZ/94=
Date:   Sat, 21 Oct 2023 11:00:20 +0200 (GMT+02:00)
From:   =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Message-ID: <633402b0-7167-465f-99c6-d959b5f48073@t-8ch.de>
In-Reply-To: <20231020-nolibc-waitpid-flags-v1-1-8137072dae14@kernel.org>
References: <20231020-nolibc-waitpid-flags-v1-1-8137072dae14@kernel.org>
Subject: Re: [PATCH] tools/nolibc: Add Linux specific waitpid() flags
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <633402b0-7167-465f-99c6-d959b5f48073@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Oct 20, 2023 23:57:01 Mark Brown <broonie@kernel.org>:

> Linux defines a few custom flags for waitpid(), make them available to
> nolibc based programs.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> tools/include/nolibc/types.h | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
> index 8cfc4c860fa4..801ea0bb186e 100644
> --- a/tools/include/nolibc/types.h
> +++ b/tools/include/nolibc/types.h
> @@ -109,7 +109,10 @@
> #define WIFSIGNALED(status) ((status) - 1 < 0xff)
>
> /* waitpid() flags */
> -#define WNOHANG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
> +#define WNOHANG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00000001
> +#define __WNOTHREAD=C2=A0 0x20000000
> +#define __WALL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x40000000
> +#define __WCLONE=C2=A0=C2=A0=C2=A0=C2=A0 0x80000000

Wouldn't it be easier to include linux/wait.h instead?

In general quite a few defines from types.h
are actually copies from UAPI headers.

>
> /* standard exit() codes */
> #define EXIT_SUCCESS 0
>
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20231020-nolibc-waitpid-flags-80ac075ab978
>
> Best regards,
> --
> Mark Brown <broonie@kernel.org>

