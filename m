Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1067EDFCA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjKPL06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjKPL04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:26:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F8C85
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:26:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EBAC43395;
        Thu, 16 Nov 2023 11:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700134012;
        bh=4QnrU+T7A4PPFaa324goRY8z/JD/4JlPeYt9ZszkaI8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fJ27a72FLlMzBMTqWhGsgEK125XpfAhy41DiOq5j41Ywtd0vIaLGPrhviCIsC5GuI
         6TEiyybEpgLOpRjCH3eZ5wmXbP96/KVoLHVUDef18KGycnTxYz94gp6MzSeVO2rOO0
         1jYvLjxnO3vs+sHY+o1FQXLmF/VxkJzOcNYwp4lUQr9B0T9W0DAdrJwAOdfCSXOr5+
         vT4Z/RKeS2m+SRKbUuX6XGCTuwDVgHVDM16KD0sabGV2AVjgiHit9RERmHOHwhuisP
         OXgeSaE9EEIGk1FGdgmAdndZmWnPKKe88xLHbplaHHDvvThRoNvTdTfeinZlelZThp
         OxltEIalEz+nQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-58a0154b4baso883329eaf.1;
        Thu, 16 Nov 2023 03:26:52 -0800 (PST)
X-Gm-Message-State: AOJu0YymdJP9tD9E8Fx5OJCWTxzc2KcOqOgCDDwlCKL9IxPa+B8gEqAK
        Fc+BAEaBNoNwteurA0pRgxsmNBDnVBxzb6O6KJA=
X-Google-Smtp-Source: AGHT+IGDcffi8phs1WBi/QHk+wGSokV1cI3UwAr+Cpu2pzIdMN/vSgc3IfVJajHC6EZ1RwfhIY9LcMv8V4pwNqe0QXo=
X-Received: by 2002:a05:6870:460d:b0:1e9:668f:46d0 with SMTP id
 z13-20020a056870460d00b001e9668f46d0mr596839oao.19.1700134011815; Thu, 16 Nov
 2023 03:26:51 -0800 (PST)
MIME-Version: 1.0
References: <20231110120722.15907-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20231110120722.15907-1-lukas.bulwahn@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 16 Nov 2023 20:26:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNATE5Vp44OuZ5K7Z7Cs8d5yKfUrUNAjEqOD1Bb5kLMdeLQ@mail.gmail.com>
Message-ID: <CAK7LNATE5Vp44OuZ5K7Z7Cs8d5yKfUrUNAjEqOD1Bb5kLMdeLQ@mail.gmail.com>
Subject: Re: [PATCH] linux/export: clean up the IA-64 KSYM_FUNC macro
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Helge Deller <deller@gmx.de>, linux-kbuild@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 9:07=E2=80=AFPM Lukas Bulwahn <lukas.bulwahn@gmail.=
com> wrote:
>
> With commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture"),
> there is no need to keep the IA-64 definition of the KSYM_FUNC macro.
>
> Clean up the IA-64 definition of the KSYM_FUNC macro.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Applied to linux-kbuild/fixes.
Thanks.


>  include/linux/export-internal.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/include/linux/export-internal.h b/include/linux/export-inter=
nal.h
> index 45fca09b2319..69501e0ec239 100644
> --- a/include/linux/export-internal.h
> +++ b/include/linux/export-internal.h
> @@ -50,9 +50,7 @@
>             "   .previous"                                              "=
\n"    \
>         )
>
> -#ifdef CONFIG_IA64
> -#define KSYM_FUNC(name)                @fptr(name)
> -#elif defined(CONFIG_PARISC) && defined(CONFIG_64BIT)
> +#if defined(CONFIG_PARISC) && defined(CONFIG_64BIT)
>  #define KSYM_FUNC(name)                P%name
>  #else
>  #define KSYM_FUNC(name)                name
> --
> 2.17.1
>


--=20
Best Regards
Masahiro Yamada
