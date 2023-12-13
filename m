Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B299E810A09
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378552AbjLMGMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjLMGMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:12:47 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB47E8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 22:12:52 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50bf3efe2cbso7492512e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 22:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1702447970; x=1703052770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTT65wA8EIe8/ctM3MiQnQZOYGeIHXCjEWPQ3P2f/hI=;
        b=BfbtAoANjXTKCvTkJlLv61ykeu1JCwqw6kmcJuk3RJYnEWVt77F5gKl3QEjb2wfbNf
         6xUx7vudnhtyctjcPInjWAGy+cC6/vyJfVUh6rZzHqeTd1mCdeDG/69LyThhm55TqwYZ
         HoshbOITQZEpMt6lyf7GiWmo4eD5WdOCJPYMIP6AZoT4otyihhnk2nQW4BXdE5lmLOn+
         sbjm4UKtBHm2LGuI9o6fwPbJljbDMS/+OHIuDFXMeQycgutVEcQlfxCEvidMyN7BmnOG
         H0O7ZaWee/FbFgBQRsVj0p6eQ/GAGT+TmpjpxnaG5eAC35/qHHYK/j/lxMkv8YAjGxmo
         5BwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702447970; x=1703052770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTT65wA8EIe8/ctM3MiQnQZOYGeIHXCjEWPQ3P2f/hI=;
        b=ZlGEfgnHuFzj6JyxsEuR0PFIEVe8HqD8C144Jr/K0QG4ZHF/uVifPwmwuOwTTG2PJp
         aFGSXRMhvkkdPUmvjLRproxOqaoW5TlqhEYXxxN0lmzdeW7oqQLQY3fbifQPhk8v4/A+
         ZGpPcpfXYJnHWs+JH2kzyzCbl1X2v5astgHjfLqg2Kc6525o3cZhHwcZiyFZaCd3L6Bt
         I/QPg5xoc4EcUzV4oP5aF/kj0D6ywIgw4LA27IytnWXAdhImr/YlKOFre3/NGVCKJPa0
         53Rdjo6qkkSKP+fznlraZ5YPgjvcAwOrBFSnM+nRHH+Cqp8eRJTeeu4mWum0PgS145s+
         s8tA==
X-Gm-Message-State: AOJu0YxEvPLXVaHRn9bPs8psOn1J00+WD96zcw6CsiqWrnEQmhG9gUi6
        jKNlRa6y7gIZB6UjCmp9pLHGol1K/SV/dF0G98twxZ1YJEJeS2xb
X-Google-Smtp-Source: AGHT+IEcUkNKCZHN8Bp4pT2kYElut7LoUcMXapFH67UcXjx4Ss1cRjj6euMSoOvv2uED2517MvQNOWxGhcxjsF9Ez5E=
X-Received: by 2002:ac2:5fd1:0:b0:50d:ddc:806f with SMTP id
 q17-20020ac25fd1000000b0050d0ddc806fmr1310071lfg.279.1702447970612; Tue, 12
 Dec 2023 22:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20231212214738.work.169-kees@kernel.org>
In-Reply-To: <20231212214738.work.169-kees@kernel.org>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 13 Dec 2023 07:12:39 +0100
Message-ID: <CAMGffEn3eUhMb-RO5eq8gtSqrF3rtf7rEjZAf1XQ6S-goifVZg@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd-srv: Check for unlikely string overflow
To:     Kees Cook <keescook@chromium.org>
Cc:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        kernel test robot <lkp@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 10:47=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> Since "dev_search_path" can technically be as large as PATH_MAX,
> there was a risk of truncation when copying it and a second string
> into "full_path" since it was also PATH_MAX sized. The W=3D1 builds were
> reporting this warning:
>
> drivers/block/rnbd/rnbd-srv.c: In function 'process_msg_open.isra':
> drivers/block/rnbd/rnbd-srv.c:616:51: warning: '%s' directive output may =
be truncated writing up to 254 bytes into a region of size between 0 and 40=
95 [-Wformat-truncation=3D]
>   616 |                 snprintf(full_path, PATH_MAX, "%s/%s",
>       |                                                   ^~
> In function 'rnbd_srv_get_full_path',
>     inlined from 'process_msg_open.isra' at drivers/block/rnbd/rnbd-srv.c=
:721:14: drivers/block/rnbd/rnbd-srv.c:616:17: note: 'snprintf' output betw=
een 2 and 4351 bytes into a destination of size 4096
>   616 |                 snprintf(full_path, PATH_MAX, "%s/%s",
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   617 |                          dev_search_path, dev_name);
>       |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> To fix this, unconditionally check for truncation (as was already done
> for the case where "%SESSNAME%" was present).
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312100355.lHoJPgKy-lkp@i=
ntel.com/
> Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
> Cc: Jack Wang <jinpu.wang@ionos.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
lgtm.
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.=
c
> index 65de51f3dfd9..ab78eab97d98 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -585,6 +585,7 @@ static char *rnbd_srv_get_full_path(struct rnbd_srv_s=
ession *srv_sess,
>  {
>         char *full_path;
>         char *a, *b;
> +       int len;
>
>         full_path =3D kmalloc(PATH_MAX, GFP_KERNEL);
>         if (!full_path)
> @@ -596,19 +597,19 @@ static char *rnbd_srv_get_full_path(struct rnbd_srv=
_session *srv_sess,
>          */
>         a =3D strnstr(dev_search_path, "%SESSNAME%", sizeof(dev_search_pa=
th));
>         if (a) {
> -               int len =3D a - dev_search_path;
> +               len =3D a - dev_search_path;
>
>                 len =3D snprintf(full_path, PATH_MAX, "%.*s/%s/%s", len,
>                                dev_search_path, srv_sess->sessname, dev_n=
ame);
> -               if (len >=3D PATH_MAX) {
> -                       pr_err("Too long path: %s, %s, %s\n",
> -                              dev_search_path, srv_sess->sessname, dev_n=
ame);
> -                       kfree(full_path);
> -                       return ERR_PTR(-EINVAL);
> -               }
>         } else {
> -               snprintf(full_path, PATH_MAX, "%s/%s",
> -                        dev_search_path, dev_name);
> +               len =3D snprintf(full_path, PATH_MAX, "%s/%s",
> +                              dev_search_path, dev_name);
> +       }
> +       if (len >=3D PATH_MAX) {
> +               pr_err("Too long path: %s, %s, %s\n",
> +                      dev_search_path, srv_sess->sessname, dev_name);
> +               kfree(full_path);
> +               return ERR_PTR(-EINVAL);
>         }
>
>         /* eliminitate duplicated slashes */
> --
> 2.34.1
>
