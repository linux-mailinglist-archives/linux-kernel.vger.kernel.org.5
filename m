Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B62756E04
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjGQUNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjGQUNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:13:51 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB57137
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:13:48 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-56fff21c2ebso49489247b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689624828; x=1692216828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvmX32zU8Nu+p0waGNgOm71AAY+i07Pz66RGGQaXTI4=;
        b=TW2a91JW8lK5lF2iBDyb423VMHB7QMlgmU4F+iQGe2w8EbUik3ZYW9UKlKomjOj4tf
         sQRhV1SAUZKvdLDOAn9hVyYiY2C6Hf/lbAJWjZ8sP5qq9nKX0DCjzab/WCl8z27bGzxE
         kF2QdhKoABhJfwzkWjD2UFsaFxAQl6krAVfT2GSVtTO7HyX0Gzo3zwwaCOa4Cx6mDIoA
         qYzzplJpNvI1KX+Wm2zmJ0eFlMphPTbZq04g9LOyj8h+LNU7wx0qEnFd8LifFNQW4gdi
         cRsLvXvqtIxRtqdEczKI+eofyQfyE//gDa2HYXAY/pWt9SfPL4gaWExTCVNv+hOIeL28
         ph9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689624828; x=1692216828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvmX32zU8Nu+p0waGNgOm71AAY+i07Pz66RGGQaXTI4=;
        b=QmGBqR4IaWXwduCu+CMeJSY89M78R0ygRH64rHC09c45D2JRlKBweKWCWcpvQDqfDT
         ubYMJPfo6BJA5dZ1xh3uUx2fVwuSdaeTIAVJxhTUCQK9g4JOBLdT2kYYz6jLa7A81bof
         ktw44kZBcv4mFHoU7p67vX9bNPOSjlOUX881J705yOxb2mUX8Os1ZSlEt4aBlzbhschW
         PLfN3dK4INNqUrqB91S5LP7vvO4jtYTE2rnikCarUAgquBjp/7cYbIJRtlkhQQKuEw4W
         vx1+DFS9O5m1iYEAmsr0hjUW0QnjrQZbqgSDjFa4cgmOVsuPac4cyQoUUaT+RX9B0vlV
         oIKQ==
X-Gm-Message-State: ABy/qLZfqfxQ2b8aNd2N4NM+rMi2cTzI5VSx3tCZ6Ij4NRxaVakU+6Um
        yLaA9WzQ2hegRY+8Mcyhys1N/Cvo2PvjBfr0V7OJ
X-Google-Smtp-Source: APBJJlGhTds1F4H7StCSwQsY4qTQeDMOf+WNZ+mPKJNceWZyCzdFeKNXKO5Qm7EYDdTG4lnOzurlRAja2C9Ltt/7bfU=
X-Received: by 2002:a0d:ca0b:0:b0:577:2340:605f with SMTP id
 m11-20020a0dca0b000000b005772340605fmr12508948ywd.2.1689624827830; Mon, 17
 Jul 2023 13:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230710082500.1838896-1-lsahn@wewakecorp.com>
In-Reply-To: <20230710082500.1838896-1-lsahn@wewakecorp.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Jul 2023 16:13:37 -0400
Message-ID: <CAHC9VhQY0Uq_xQ_AwAuZ8gJbS52nQvRONHvCxiR-dGDg3BviRw@mail.gmail.com>
Subject: Re: [PATCH] selinux: optimize major part with a kernel config in selinux_mmap_addr()
To:     Leesoo Ahn <lsahn@ooseel.net>
Cc:     lsahn@wewakecorp.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 4:25=E2=80=AFAM Leesoo Ahn <lsahn@ooseel.net> wrote=
:
>
> The major part, the conditional branch in selinux_mmap_addr() is always t=
o be
> false so long as CONFIG_LSM_MMAP_MIN_ADDR is set to zero at compile time.
>
> This usually happens in some linux distros, for instance Ubuntu, which
> the config is set to zero in release version. Therefore it could be a bit
> optimized with '#if <expr>' at compile time.
>
> Signed-off-by: Leesoo Ahn <lsahn@wewakecorp.com>
> ---
>  security/selinux/hooks.c | 2 ++
>  1 file changed, 2 insertions(+)

First, I agree with Stephen's comments that you should ask your distro
(you mentioned Debian) to move MIN_ADDR higher.  Beyond that, I have
one request, see below ...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d06e350fedee..a049aab6524b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3723,11 +3723,13 @@ static int selinux_mmap_addr(unsigned long addr)
>  {
>         int rc =3D 0;
>
> +#if CONFIG_LSM_MMAP_MIN_ADDR > 0
>         if (addr < CONFIG_LSM_MMAP_MIN_ADDR) {
>                 u32 sid =3D current_sid();
>                 rc =3D avc_has_perm(sid, sid, SECCLASS_MEMPROTECT,
>                                   MEMPROTECT__MMAP_ZERO, NULL);
>         }
> +#endif
>
>         return rc;
>  }

Pre-processor conditionals inside a function are generally something
we don't recommend.  In this case I would suggest doing something like
this:

#if (MMAP_MIN_ADDR > 0)
static int selinux_mmap_addr(...)
{
  /* current func definition */
}
#else /* MMAP_MIN_ADDR > 0 */
static int selinux_mmap_addr(...)
{
  return 0;
}
#endif /* MMAP_MIN_ADDR > 0 */

--=20
paul-moore.com
