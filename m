Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5863763C56
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjGZQZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGZQZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:25:53 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CDB26A1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:25:52 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-63cfe6e0c32so160006d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690388751; x=1690993551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWHwNZ9uX+hEihnuQWpK8SVcYAN54cjh/Df2iSH47JQ=;
        b=ROGlymef1wn/RhheCV1Pb2LH7KxvVHt1Tp0obWzyXZiIEt0XjeG0V1kLnrMx52QAvC
         EYzcFxFDi5k89KCKQFnbqYH3HuI8OOf0eqQWOQltJYuXS64lG6qGvMT5z6R8B/ajdgFI
         FRn51NTxBj7rp3AYaBZ9YaBFLpAfUPTrvUxAq79RCl8yDzyPipb6JHMpPg1VKTnBkv3L
         3/sgUi7QEcC3zgXHkB0JVlqNHs0AVznyzHxhVtsU1gsXPPlgWD9wu+YCk5NjTDKsWAaN
         Y2G1PXjHrdlwtSo8Yfaq4aU6DaWbGoFrAdRZmeR6g6QMDap7mKjjRfXfdlrXoocv21MN
         Zfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690388751; x=1690993551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWHwNZ9uX+hEihnuQWpK8SVcYAN54cjh/Df2iSH47JQ=;
        b=lpHdVpLFnaK8iCwdfQokw3PGsh6FTPN9+np77VhGFIakmSeZ1sjWwrAXJEhxFDt6ve
         C6IEwT3Ylp/h4jP/NxWDHP2+mooJkysg7FQdBUKUpe6oQsZyyql711CC7rj0+g+dKxmT
         BfXKjhYqoNf7f4ddlqB3HS3Jqik4kWdyN/gKkg5GEeaw5Z8adPKIjTsxyKOo46ZY3Q1Y
         tJQAu27l5BM3grEMVNgWefgX3nXPrNQuDMDUdfSUO1NO2myim52ZoNieR0CJA5fplpyj
         MUXWjtbsGQbJRcX44QLq31OCMYc4Wlp59rluP7+Uetz4P/vrJ7tlrheLlJm9X6JB0M8Z
         GK0Q==
X-Gm-Message-State: ABy/qLbrlSZAXjHsEc8sfQTxcQbX3xzGkXUR17XGl31NvfQNcQOEgpcp
        LP5g0rsgV4gd4AKGfCKUJRk2St3MmaPCaAzeBZYFMw==
X-Google-Smtp-Source: APBJJlEQyrumMJ8bfqzv8gbWme2MH6XNwHEa53d41kqpeRLNeX10HG/3Ia1ipT6dRh51lGe/nnZtSP7lExuuaQqQw8s=
X-Received: by 2002:a0c:e00c:0:b0:63c:ee13:4fed with SMTP id
 j12-20020a0ce00c000000b0063cee134fedmr2482192qvk.39.1690388751018; Wed, 26
 Jul 2023 09:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230726143348.724611-1-arnd@kernel.org>
In-Reply-To: <20230726143348.724611-1-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Jul 2023 09:25:39 -0700
Message-ID: <CAKwvOdnk+e_QmE+QpcqzntNVgf8mL+NOPtUggj4F__iTf_XD+A@mail.gmail.com>
Subject: Re: [PATCH] init: keep boot_command_line after init
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 7:33=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The boot command line is not available after the init section gets discar=
ded,
> so adding a permanent reference to it causes a link time warning:
>
> WARNING: modpost: vmlinux: section mismatch in reference: cmdline_load_pr=
oc_show+0x2 (section: .text) -> boot_command_line (section: .init.data)

cmdline_load_proc_show is probably inlined, but should it also be
marked __init?  It's lone call site seems to be __init AFAICT.

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ERROR: modpost: Section mismatches detected.
> Set CONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy to allow them.
>
> Change it to __ro_after_init to prevent it from getting freed.
>
> Fixes: cf9eca90a3397 ("fs/proc: Add /proc/cmdline_load for boot loader ar=
guments")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/init.h | 2 +-
>  init/main.c          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 9a5973324072b..4e97a7a29a4d7 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -143,7 +143,7 @@ struct file_system_type;
>
>  /* Defined in init/main.c */
>  extern int do_one_initcall(initcall_t fn);
> -extern char __initdata boot_command_line[];
> +extern char boot_command_line[];
>  extern char *saved_command_line;
>  extern unsigned int saved_command_line_len;
>  extern unsigned int reset_devices;
> diff --git a/init/main.c b/init/main.c
> index c946ab87783a1..981170da0b1cd 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -135,7 +135,7 @@ EXPORT_SYMBOL(system_state);
>  void (*__initdata late_time_init)(void);
>
>  /* Untouched command line saved by arch-specific code. */
> -char __initdata boot_command_line[COMMAND_LINE_SIZE];
> +char boot_command_line[COMMAND_LINE_SIZE] __ro_after_init;
>  /* Untouched saved command line (eg. for /proc) */
>  char *saved_command_line __ro_after_init;
>  unsigned int saved_command_line_len __ro_after_init;
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
