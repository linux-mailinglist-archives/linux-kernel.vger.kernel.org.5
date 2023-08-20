Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D26781D07
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 10:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjHTI40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 04:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHTI4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 04:56:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B9B3C3D;
        Sun, 20 Aug 2023 01:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32DD260CF6;
        Sun, 20 Aug 2023 08:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866CDC433C7;
        Sun, 20 Aug 2023 08:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692521608;
        bh=2fcnYc+DPi7N078Nrnev0eC6FFyWTStx0R/jAZ0wnGE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OcjtCchmHqaSRlcf6B4nJETr+PPwx8Rk9ORgRVcnjpN8maBSiwPXAk/eAzD1Dw7Wb
         BWYvEtX2UyU2FsKPkoa4isiQ2aW4ueTOUqfn5Ide6sWbeQK8rVXkWz99yV6uLzGGaN
         gbRQAtWZSs619aju8H4L/UgXjD5WML2oOkeJYFP+jgBL0AwI1MXGbM2hi9Vv0ySr/n
         LNXi6KjC1GRjhO69IPJhIYGomAX89Z1oH+QF8s5MTc2vb1O7xdoU5F4mC8ytgemLEn
         rUHBj5UoPAASPCkAneQ7w1bIIJuLfPuELlXdSemMlD8Ga2VkffW/g50FzIKNYQvC00
         CIWn8y7R2DZ2Q==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50078eba7afso548117e87.0;
        Sun, 20 Aug 2023 01:53:28 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzzr/Fyojadlx7/8nxRZ+hWY9uBeOGMqa7ZJv0iaT1PM6fWcH8U
        PcRGFMAoFyX53Ys7SuVMqORRnuk4g+4bTHDIDp0=
X-Google-Smtp-Source: AGHT+IHIQBvZk0tggq3wdl/6vX/l1YNnfbVKsIHLJNwauWo0pSb8ZrGkOiVuesxGmXS0o9HbGSQRDvP7mXj/A6PmgaQ=
X-Received: by 2002:a19:2d54:0:b0:500:2543:eef7 with SMTP id
 t20-20020a192d54000000b005002543eef7mr1502727lft.25.1692521606526; Sun, 20
 Aug 2023 01:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <1692434183-2054-1-git-send-email-yangtiezhu@loongson.cn> <1692434183-2054-4-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1692434183-2054-4-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 20 Aug 2023 16:53:14 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5_3NeAEqiBgXqxwhUbTGRhEO0fL2bY4KCOJ6J=cf9Emw@mail.gmail.com>
Message-ID: <CAAhV-H5_3NeAEqiBgXqxwhUbTGRhEO0fL2bY4KCOJ6J=cf9Emw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] MIPS: Return earlier in die() if notify_die()
 returns NOTIFY_STOP
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
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

Hi, Tiezhu,

On Sun, Aug 20, 2023 at 7:21=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> After the call to oops_exit(), it should not panic or execute
> the crash kernel if the oops is to be suppressed.
>
> Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/mips/kernel/traps.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 8e528a8..fd770dc 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -412,6 +412,9 @@ void die(const char *str, struct pt_regs *regs)
>
>         oops_exit();
>
> +       if (ret =3D=3D NOTIFY_STOP)
> +               return;
> +
>         if (in_interrupt())
>                 panic("Fatal exception in interrupt");
>
> @@ -421,8 +424,7 @@ void die(const char *str, struct pt_regs *regs)
>         if (regs && kexec_should_crash(current))
>                 crash_kexec(regs);
>
> -       if (ret !=3D NOTIFY_STOP)
> -               make_task_dead(SIGSEGV);
> +       make_task_dead(SIGSEGV);
Then you call make_task_dead() at the end unconditionally, and die()
becomes a noreturn function again.

Huacai
>  }
>
>  extern struct exception_table_entry __start___dbe_table[];
> --
> 2.1.0
>
