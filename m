Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2274080A769
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574340AbjLHP3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjLHP3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:29:44 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80367173F;
        Fri,  8 Dec 2023 07:29:50 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2ca0c36f5beso27960701fa.1;
        Fri, 08 Dec 2023 07:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702049389; x=1702654189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+K3YCrkZaiNrcUYXyCv6UBN5xE5owY2kTVg/Ts8dS8=;
        b=MNtJh7BM/owvuIDE7gVSaqR4CsZNxzq1l8gHParrq8YxLY+uTxQS265WxOl0BFlDRL
         xyTZ6sdPHK/VqSdaUEINQ9Rk8TSsMUSTQMINEatJufQNRVII5ozMDHVK7qR7KDc+bRwD
         4WazgDygnJLIlvb1JxkxeGBRPKOLpPRxtp54IDBMjnlcEJFZZoLCdNlU+hEhQZdlPhec
         b5vAEHCbC9gmJPWfcZqASyg2vgxc4/PorJJJ0Xs054RAbqVhIIxSnsVQskYPVgnAIM+1
         0h1Q6uSIUFYwzdi8InT5FVuTRBefDu8N4b1lOBJYRN0Ey2SwYYxXJbBCouNvikGpHi15
         fyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702049389; x=1702654189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+K3YCrkZaiNrcUYXyCv6UBN5xE5owY2kTVg/Ts8dS8=;
        b=lCh+MoPFPTXRtMmGTJ5ptf6/JcLXFqEV6kngPsJHxXlsELrM4xH757bK1nY6ZvHF/Q
         xbQudDD3jBqRJdrfkic9avx6l+/Ny03gZIlvKn0EFa/owG+vB1D0szoP6mFEKmGH2eR2
         ipSjguNc1zMfNzJYQTSnWYB1SX5PNZNdn807zvDniMS+PKQRGR2qOlisNsBZmScZHaWw
         Hr4NfdrBkpQkM4TaqFSxwhdsRk8bSZaUMQdt/1ZpUMyB0T8LsLuo/DXN8xIZZUFFkgRH
         RFrzsdaazNv3RPurbdl2oy7wbNbusY21Cg4J0viV3NuCUF1idv5/b1cEn4ayS7Z9unuL
         0d3A==
X-Gm-Message-State: AOJu0Yz+g6mjcT0zrIuRvyGLgDc3PrUO7CGpyuJUEQmM0wf1WO6y/OO7
        vE05dQ0XMBWofw1C6Kyhi4kAF64WMkjnlVytG9JW0UZC
X-Google-Smtp-Source: AGHT+IEcZxoV7Nf4cTA3oYfzCQ4M0whm9W6FSWoO1I2FJKZ6hIHwIi8y54x3a8MDxjKaWJWnBEeUPm5FxoSJMeRpHz4=
X-Received: by 2002:a2e:2e0b:0:b0:2c9:f7a1:2f93 with SMTP id
 u11-20020a2e2e0b000000b002c9f7a12f93mr34313lju.105.1702049388258; Fri, 08 Dec
 2023 07:29:48 -0800 (PST)
MIME-Version: 1.0
References: <20231208143656.1019-1-areber@redhat.com>
In-Reply-To: <20231208143656.1019-1-areber@redhat.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Fri, 8 Dec 2023 07:29:35 -0800
Message-ID: <CANaxB-wro4DRGosRhi1bB2jYdjM+1OihYTsnFOuAi_RKHnOm5w@mail.gmail.com>
Subject: Re: [PATCH v2] tty: allow TIOCSLCKTRMIOS with CAP_CHECKPOINT_RESTORE
To:     Adrian Reber <areber@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 6:37=E2=80=AFAM Adrian Reber <areber@redhat.com> wro=
te:
>
> The capability CAP_CHECKPOINT_RESTORE was introduced to allow non-root
> users to checkpoint and restore processes as non-root with CRIU.
>
> This change extends CAP_CHECKPOINT_RESTORE to enable the CRIU option
> '--shell-job' as non-root. CRIU's man-page describes the '--shell-job'
> option like this:
>
>   Allow one to dump shell jobs. This implies the restored task will
>   inherit session and process group ID from the criu itself. This option
>   also allows to migrate a single external tty connection, to migrate
>   applications like top.
>
> TIOCSLCKTRMIOS can only be done if the process has CAP_SYS_ADMIN and
> this change extends it to CAP_SYS_ADMIN or CAP_CHECKPOINT_RESTORE.
>
> With this change it is possible to checkpoint and restore processes
> which have a tty connection as non-root if CAP_CHECKPOINT_RESTORE is
> set.
>

Acked-by: Andrei Vagin <avagin@gmail.com>

> Acked-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Adrian Reber <areber@redhat.com>
> ---
> Changes in v2:
> - replaced "if (!capable(CAP_SYS_ADMIN) && !capable(CAP_CHECKPOINT_RESTOR=
E))"
>   with "if (!checkpoint_restore_ns_capable(&init_user_ns))" as suggested
>   by Christian Brauner
> - v1: https://lore.kernel.org/linux-serial/20231206134340.7093-1-areber@r=
edhat.com/
> ---
>  drivers/tty/tty_ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
> index 4b499301a3db..85de90eebc7b 100644
> --- a/drivers/tty/tty_ioctl.c
> +++ b/drivers/tty/tty_ioctl.c
> @@ -844,7 +844,7 @@ int tty_mode_ioctl(struct tty_struct *tty, unsigned i=
nt cmd, unsigned long arg)
>                         ret =3D -EFAULT;
>                 return ret;
>         case TIOCSLCKTRMIOS:
> -               if (!capable(CAP_SYS_ADMIN))
> +               if (!checkpoint_restore_ns_capable(&init_user_ns))
>                         return -EPERM;
>                 copy_termios_locked(real_tty, &kterm);
>                 if (user_termios_to_kernel_termios(&kterm,
> @@ -861,7 +861,7 @@ int tty_mode_ioctl(struct tty_struct *tty, unsigned i=
nt cmd, unsigned long arg)
>                         ret =3D -EFAULT;
>                 return ret;
>         case TIOCSLCKTRMIOS:
> -               if (!capable(CAP_SYS_ADMIN))
> +               if (!checkpoint_restore_ns_capable(&init_user_ns))
>                         return -EPERM;
>                 copy_termios_locked(real_tty, &kterm);
>                 if (user_termios_to_kernel_termios_1(&kterm,
>
> base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
> --
> 2.43.0
>
