Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528B97A0BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240011AbjINRiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbjINRh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:37:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6101FE6;
        Thu, 14 Sep 2023 10:37:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C7FC433C7;
        Thu, 14 Sep 2023 17:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694713074;
        bh=kNoJwNNb+anv+m0iLQSwLee3B2sYCwMMrFpkwIAiBWY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uD+ZL5JxDpJe+vg1w2KccHC7J8whDiODG1OWCnVlaEq4QIi+wev9uXHnPFplroIOb
         BNeXMLhglDFjWkgPu9xzKXbh7SXKWZen5ML2/+zPmV6NIsWtTjnkwXHbIu1AUN4k/N
         XW5g069Q/FGHN2+dVujVX8eWrCYW2je5jkWQv/gUXDHN3Pv1albHPoWok31Omkthex
         u/UGerBDixDw5wfxq6eseMoFaKR41pivz6f+mmMK9cM5czngBUCVu57dChPvSBeIM1
         LloVwKO275RD/xfS6bVAueKMog6on4Fcvtu2orF5ilp6mZU3Nl7q8Ycb9Gz72fCIl6
         GHXELwVSv2yyA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1d643db2c98so293877fac.0;
        Thu, 14 Sep 2023 10:37:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YwhY4KZM0K2JVPZcgN6XyndS1uXbR/PTD+KN8K5Soznf4VNdhIH
        MwN5TNRHfkubOtPAS2KBXsudUKizZaqQwWpewx8=
X-Google-Smtp-Source: AGHT+IGcoDkn0Qn0FNgQ+iKnDCpTZsQ47f7mcHWHg8DbBsXQsn9u9FQKsOZoa88UpLornY8eDbnfgOmD5zJjZwfM3EU=
X-Received: by 2002:a05:6870:46a7:b0:1c0:c42f:6db2 with SMTP id
 a39-20020a05687046a700b001c0c42f6db2mr6732641oap.37.1694713073555; Thu, 14
 Sep 2023 10:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230911080129.38BA12016B@lion.mk-sys.cz>
In-Reply-To: <20230911080129.38BA12016B@lion.mk-sys.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 15 Sep 2023 02:37:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNASTc80bZY1Kvk4rwRk=jL0uCaOfc0ggmWv5O994WD=rsg@mail.gmail.com>
Message-ID: <CAK7LNASTc80bZY1Kvk4rwRk=jL0uCaOfc0ggmWv5O994WD=rsg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: avoid long argument lists in make modules_install
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 5:01=E2=80=AFPM Michal Kubecek <mkubecek@suse.cz> w=
rote:
>
> Running "make modules_install" may fail with
>
>   make[2]: execvp: /bin/sh: Argument list too long
>
> if many modules are built and INSTALL_MOD_PATH is long. This is because
> scripts/Makefile.modinst creates all directories with one mkdir command.
> Use $(foreach ...) instead to prevent an excessive argument list.
>
> Fixes: 2dfec887c0fd ("kbuild: reduce the number of mkdir calls during mod=
ules_install")
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> ---

Applied to linux-kbuild/fixes.
Thanks.



>  scripts/Makefile.modinst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index c59cc57286ba..346f5ec50682 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -113,7 +113,7 @@ quiet_cmd_sign :=3D
>  endif
>
>  # Create necessary directories
> -$(shell mkdir -p $(sort $(dir $(install-y))))
> +$(foreach dir, $(sort $(dir $(install-y))), $(shell mkdir -p $(dir)))
>
>  $(dst)/%.ko: $(extmod_prefix)%.ko FORCE
>         $(call cmd,install)
> --
> 2.42.0
>


--=20
Best Regards
Masahiro Yamada
