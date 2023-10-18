Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8567CEB6B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjJRWkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJRWkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:40:15 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E5B113
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:40:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so12390581a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697668812; x=1698273612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z31RrENcT3Hhy0E5og6HBcX5caES7mIPqdSDtyYrG1U=;
        b=u2qXn8OhSKGhvZ64W/TgNrnChW/M0ca3s3qx21bpiTttonuigLa1K8ou+ToCaTMY1T
         mtQyNcN9u8vlR9Ed4Xd2wrbSohaj4EQHVmHpa8uWjr0LmorvtNCZO5SwT541CfPjF3Nd
         S4FtEo6bH+npZzbg+YGSTmiAlV5Sp+m4aDFCeb4zYnp9num3UYQiFLDw5Uj94QFfylnn
         U9ulxH2yP8apKPmwjo+sFxNI7bZx2pBv6ZJ15VHqPv1udljSyw2wkqD2RzCEYyhcTVfi
         IbnvuRIY3TRqptaFDzxYGwWrJ7oFGhd2D5VrF/d8h3nG5ZfRb20D+xEPv+VuCFf+MajI
         Gifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697668812; x=1698273612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z31RrENcT3Hhy0E5og6HBcX5caES7mIPqdSDtyYrG1U=;
        b=QAuZJxQBM3AHDcUlXt/ymO16kLDat2SbOeWV6fgqr81FfB1mqlXIZn6TljW1NQaV++
         e0xgxMGNrBuL0A5Oi/erh7ycvtBWUa6pICKAyPcQt3qVwdIoaV4cFQZXQpwG+5ZsVAyZ
         y75L9euPZ1ao1QOBIUkEmCWj901PT5hmWZCagbishDxo4xm82CVbQfRWstkx56kLs7/I
         eqDZ6fySF9YxmlE8Am6zGy9SIrmjrECaF6Nn0s4hohuBn3RpogCs4sHLuOe7THvmnjlm
         TeNsLxwWvQFfgszQupwW2lZ81k01b5lFSZ0WszM4hgnQ2tNC+zZkC7XY1rPGSSG1/qHf
         1oAQ==
X-Gm-Message-State: AOJu0YzIGInIiPWtSZFnMGk4n+Ems58fT0MhPnK/9oy1vVRaea0xLpWi
        v/qH1J/e+Buh8C020CBH5P8yJqgD6wo48eNkDRhmvg==
X-Google-Smtp-Source: AGHT+IH0xBTpkyaIqW41fCuQjgPF5EQ6reBFxe2nMtEt6ALPr4+x7VzbsUCLJ1SIereHNmuCJlIzzV7NizscD3a+p7E=
X-Received: by 2002:a05:6402:524a:b0:53e:2c49:8041 with SMTP id
 t10-20020a056402524a00b0053e2c498041mr298065edd.8.1697668812117; Wed, 18 Oct
 2023 15:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-strncpy-drivers-nvdimm-btt-c-v1-1-58070f7dc5c9@google.com>
In-Reply-To: <20231018-strncpy-drivers-nvdimm-btt-c-v1-1-58070f7dc5c9@google.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 18 Oct 2023 15:39:59 -0700
Message-ID: <CAFhGd8o-ftoGQ4qvrdGM2tSYWBqvYbF7Qb7O+UfsbzYxVmU6sA@mail.gmail.com>
Subject: Re: [PATCH] block: replace deprecated strncpy with strscpy
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

I have a feeling I may have botched the subject line for this patch.
Can anyone confirm if it's good or not?

Automated tooling told me that this was the most common patch
prefix but it may be caused by large patch series that just
happened to touch this file once.

Should the subject be: nvdimm/btt: ... ?

Judging from [1] I see a few "block" and a few of nvdimm/btt.

On Wed, Oct 18, 2023 at 3:35=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> We expect super->signature to be NUL-terminated based on its usage with
> memcpy against a NUL-term'd buffer:
> btt_devs.c:
> 253 | if (memcmp(super->signature, BTT_SIG, BTT_SIG_LEN) !=3D 0)
> btt.h:
> 13  | #define BTT_SIG "BTT_ARENA_INFO\0"
>
> NUL-padding is not required as `super` is already zero-allocated:
> btt.c:
> 985 | super =3D kzalloc(sizeof(struct btt_sb), GFP_NOIO);
> ... rendering any additional NUL-padding superfluous.
>
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
>
> Let's also use the more idiomatic strscpy usage of (dest, src,
> sizeof(dest)) instead of (dest, src, XYZ_LEN) for buffers that the
> compiler can determine the size of. This more tightly correlates the
> destination buffer to the amount of bytes copied.
>
> Side note, this pattern of memcmp() on two NUL-terminated strings should
> really be changed to just a strncmp(), if i'm not mistaken? I see
> multiple instances of this pattern in this system.
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
>
> Found with: $ rg "strncpy\("
> ---
>  drivers/nvdimm/btt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index d5593b0dc700..9372c36e8f76 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -986,7 +986,7 @@ static int btt_arena_write_layout(struct arena_info *=
arena)
>         if (!super)
>                 return -ENOMEM;
>
> -       strncpy(super->signature, BTT_SIG, BTT_SIG_LEN);
> +       strscpy(super->signature, BTT_SIG, sizeof(super->signature));
>         export_uuid(super->uuid, nd_btt->uuid);
>         export_uuid(super->parent_uuid, parent_uuid);
>         super->flags =3D cpu_to_le32(arena->flags);
>
> ---
> base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
> change-id: 20231018-strncpy-drivers-nvdimm-btt-c-15f93879989e
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>

[1]: https://lore.kernel.org/all/?q=3Ddfn%3Adrivers%2Fnvdimm%2Fbtt.c

Thanks
Justin
