Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805C3788E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjHYRwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbjHYRwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:52:14 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517DA213F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:52:10 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-649a11843b3so7324166d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692985929; x=1693590729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2roYvGxddDhT2UnVE3yi26VcxSvjVBTKoMdz+KfeoM=;
        b=u6S8b9ReK2LOZLdgpJ2ui9fQ4UUxRl/5YculNXNvH96bZ1j3Eh8ILvqjDSCO9ROhEa
         TmftEGGI1D5qJHyaULPQY4lPWkrxf+gdurlVWJvLizBgqaG1LfFCHpICpuGhKF3iVoEi
         U9YUe1PzB6x8nogtFlQYRICCxMBnBAiDSJZ6cpLvYUxmCOhqTpqHQPGK+v2N6mTDbEuu
         PShEVQVqehxgBDYsUcVr1i6zJy9XEBH/PTeTpDOOwswzTDSVuWaU/2ZNzu/mVCeL7RyZ
         s5TtkNthg6PCjfkKdRkLL5RXOUwA36L9EBKhViLm1BD9ZNZXaNqQLWKiWM8s+HBocIku
         3JWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692985929; x=1693590729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2roYvGxddDhT2UnVE3yi26VcxSvjVBTKoMdz+KfeoM=;
        b=RJU+2Y1Pf2tmvPCuAY4Qgk2dJARg2Qs4ETPFIyqmKXtGn/vk76yPLrPPkjItNVzXUd
         oN3M6NVKC9xfuIL6Fqer8gobMgc8pf+Kc+RsSkomiCbE2Pbj6aQ2GDxW+o2haaY18O2+
         Tk9V3MifyADUsBINbtMljm0SYHz7L293zoXOVHz7IWm+zascDoMadEiZiFU1WpvswyeY
         K7zqRLifHb+KegAJHgO12ZML+C77RcvcAW/gPXQuPTUvD8i3yh80H1pqicIJDB6ZSB7f
         1ZwUQYMMXERC7cqEeqDulTtTBRgwbfWnkO6qXmlcY0KKbPpSNh0WAYBVPcEfEt8kxraT
         YzlQ==
X-Gm-Message-State: AOJu0YwVqUDpUdjmoYdi4kFh9y/MFPOwEuArNHYX6P3yXviA3m+BgQ2N
        +HmtooC5M4wlrqIkJKHom6jHP+CBNDs0jKJMUK6OAA==
X-Google-Smtp-Source: AGHT+IGUxNKEZlVXzuLwuAUA/0vZPZltHUF7Znf/9B7x6MsQzluJZzXU6UEqyQjqgMC4h2WrFMhoLuuzJI8xFeZWE8c=
X-Received: by 2002:a0c:8c8a:0:b0:63d:6138:1027 with SMTP id
 p10-20020a0c8c8a000000b0063d61381027mr17142838qvb.42.1692985929325; Fri, 25
 Aug 2023 10:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230825034659.1037627-1-yonghong.song@linux.dev>
In-Reply-To: <20230825034659.1037627-1-yonghong.song@linux.dev>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 25 Aug 2023 10:51:58 -0700
Message-ID: <CAKwvOdk7knYxOzaeq4gWjTiy=zRk4wc1jgq0d6fyFS5x43Cv9g@mail.gmail.com>
Subject: Re: [PATCH] kallsyms: Fix kallsyms_selftest failure
To:     Yonghong Song <yonghong.song@linux.dev>
Cc:     Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>,
        Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com,
        Leizhen <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 8:49=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 016d997131d4..e12d26c10dba 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -188,16 +188,13 @@ static bool cleanup_symbol_name(char *s)
>
>  static int compare_symbol_name(const char *name, char *namebuf)
>  {
> -       int ret;
> -
> -       ret =3D strcmp(name, namebuf);
> -       if (!ret)
> -               return ret;
> -
> -       if (cleanup_symbol_name(namebuf) && !strcmp(name, namebuf))
> -               return 0;
> -
> -       return ret;
> +       /* The kallsyms_seqs_of_names is sorted based on names after
> +        * cleanup_symbol_name() (see scripts/kallsyms.c) if clang lto is=
 enabled.
> +        * To ensure correct bisection in kallsyms_lookup_names(), do
> +        * cleanup_symbol_name(namebuf) before comparing name and namebuf=
.
> +        */
> +       cleanup_symbol_name(namebuf);

Hi Yonghong,
Thanks for your work on this patch.
So if this change is removing the last place where the return value of
cleanup_symbol_name is checked, then perhaps this commit should
additionally change the function signature of cleanup_symbol_name to
have `void` return type.

--=20
Thanks,
~Nick Desaulniers
