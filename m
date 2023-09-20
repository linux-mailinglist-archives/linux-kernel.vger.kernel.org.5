Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CAB7A70F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjITDV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjITDVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:21:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207C9B9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 20:21:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9ae22bf33a0so99758766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 20:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695180076; x=1695784876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Yw61MTv6sQm8GtqaAIRGAI4x3jcX/Zyv9SKpJ6pf7k=;
        b=4QCx/IPBWbtWvCQmBWJrBoEpFj9ZrEBZ+ZbK62lpiL4hXTT5AIiPDnBdViwIdZKsth
         LvuFCHkHMSMJnM5TIOFcaEMawcMUqGd2b/sDnNngcyxRgEtMm0fOwIctkwRHBhQMiTHz
         FpnQVc/2qSoRRaW+LVahObYnjoQnvpFYb2iSOm4I1fz+bHbKJCnvTnUSOXD2tVqmI014
         VjW8dwirjP7/IwP+bc6Z86X5kidrU7E/A009K3adgSFQzKfncpA9ejR5QI2fooBgqc7Z
         K9OJI3R9k7Rv+r40b5YGnKHCZut89qmjyjahzboEhHJ3Qc5Hc0JovWejnuJBi4IcOKta
         O7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695180076; x=1695784876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Yw61MTv6sQm8GtqaAIRGAI4x3jcX/Zyv9SKpJ6pf7k=;
        b=mdRN9U5G+wkFte0iswklA7jHLlhq16lxIHVElcKUAk6G+Gjq65bDgSx0jZqg+EJ7xc
         GuMLSwoyc30x6mQpsr8yCpDU7VZL3TJok0o1eOnUDWwnGE5nloIs/sQZzJs76FsvhxZR
         f4jo86JQZMJP8bUYxNF3ILQsVGQe/WhZrvNCe5IMRvr3j9PRJK+ILKW8pwEtNeBOq+Kw
         rB0q0GK8OeFsUtmDw3K5jcviymyL94TfoPUbQf/16X3a5QMWUBSEAv0ZaGoVll8piBUE
         vhGCVj0Jou4nSQlT2ECvzEG+HIui/Gw6gLamrizbnXktXvNBDMHu9iv2pMkuUabMTwBX
         2npA==
X-Gm-Message-State: AOJu0YxW1uvouIL7sllP7NiXUErA7Jbiq2tNXjTuktjctLcyJLwlyti0
        Kn2R69ucbq+zJ9Du4psG4IU8XsKRUglZSYw26UrEdA==
X-Google-Smtp-Source: AGHT+IHMLnSnmT3l5z402SdcHOUQGHXplrhO6L7OGZuDHejnWRGlJ5nLuxUCpELtUgZec6SOmzt3G7yonrl/xNH2GvM=
X-Received: by 2002:a17:906:329b:b0:9ad:b37f:9615 with SMTP id
 27-20020a170906329b00b009adb37f9615mr2030017ejw.29.1695180076517; Tue, 19 Sep
 2023 20:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230919192156.121503-1-azeems@google.com>
In-Reply-To: <20230919192156.121503-1-azeems@google.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 19 Sep 2023 20:21:05 -0700
Message-ID: <CAFhGd8oDsU6wyEqXLQVgTWALp9Hun=3gjcki+ZFSu7ihjpZ_XA@mail.gmail.com>
Subject: Re: [PATCH v2] vt: Replace strlcpy with strscpy
To:     Azeem Shaikh <azeems@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:22=E2=80=AFPM Azeem Shaikh <azeems@google.com> w=
rote:
>
> strlcpy() reads the entire source buffer first and returns the size of
> the source string, not the destination string, which can be accidentally
> misused [1].
>
> The copy_to_user() call uses @len returned from strlcpy() directly
> without checking its value. This could potentially lead to read
> overflow. There is no existing bug since @len is always guaranteed to be
> greater than hardcoded strings in @func_table[kb_func]. But as written
> it is very fragile and specifically uses a strlcpy() result without sanit=
y
> checking and using it to copy to userspace.
>
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcp=
y
> [2] https://github.com/KSPP/linux/issues/89
>
> Signed-off-by: Azeem Shaikh <azeems@google.com>
Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
> v2:
>  * Return -ENOSPC instead of -EFAULT in case of truncation.
>  * Update commit log to clarify that there is no exploitable bug but inst=
ead the code uses a fragile anti-pattern.
>
> v1:
>  * https://lore.kernel.org/all/20230830160410.3820390-1-azeemshaikh38@gma=
il.com/
>
>  drivers/tty/vt/keyboard.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 1fe6107b539b..12a192e1196b 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -2079,12 +2079,15 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __=
user *user_kdgkb, int perm)
>                         return -ENOMEM;
>
>                 spin_lock_irqsave(&func_buf_lock, flags);
> -               len =3D strlcpy(kbs, func_table[kb_func] ? : "", len);
> +               len =3D strscpy(kbs, func_table[kb_func] ? : "", len);
>                 spin_unlock_irqrestore(&func_buf_lock, flags);
>
> +               if (len < 0) {
> +                       ret =3D -ENOSPC;
> +                       break;
> +               }
>                 ret =3D copy_to_user(user_kdgkb->kb_string, kbs, len + 1)=
 ?
>                         -EFAULT : 0;
> -
>                 break;
>         }
>         case KDSKBSENT:
> --
> 2.42.0.459.ge4e396fd5e-goog
>
>

whitespace nitpicks: A newline after the newly added if-statement's
ending curly brace as well as reinstating the removed newline in your
diff might make the code look "better".

Thanks
Justin
