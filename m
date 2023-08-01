Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48DF76AAAB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjHAIQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjHAIP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:15:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB24B1FC9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:15:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1AFC614A7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF43C433C9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690877750;
        bh=rXEVIqqRyRvRsofPskVfpAkSPf5Oa6MWCD1ttlvHZYw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nJM+mH4ZZjaVjFxLIw/YSXO/LhzwkfKMNjl/zKfCbkaMYl8a/HI6K6ozeFk3KyZgV
         PMZ4gm07LBqt15mjMso/fcsu9BaVVT8hW/JsPe4gFerCdaHwyBdISRwaCqE/WqZx7L
         GmVuycGMeticbHsGxaVD+7UOBhMYpooow3G1ePh9YMZDLaAXpI4Csnu7YDPO4/Usxp
         4eec2n1UTPkPrY5cieCHOWt5ONTV3JAdQH+j73u01y/BZdDbqhdR3Awas2GyWvUIMR
         aVNR3+tBgRpzmE6WgT625DtEym4Zm36w/Fw2onpKJD391uhTtZEEoQRpj5R2GlaCGm
         4hUFtIWtJvJJw==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so7705464a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 01:15:50 -0700 (PDT)
X-Gm-Message-State: ABy/qLYsda+d+5cuyava+GbHh29LdP3Ql8+x+xuvyHHEnOJiSEY0v38g
        7jqbwj0toKvWaZRA8a4mDA5y8sBXV5XBzW00/Jg=
X-Google-Smtp-Source: APBJJlHgHHMApVnr9xbZyNrSTOShapMotx6paMrhvvc3K3QGf1P7Sg/XuObWLlLPHFrvWOoriz24itlu+M2mOPo26SA=
X-Received: by 2002:a05:6402:695:b0:51a:5c1d:5c06 with SMTP id
 f21-20020a056402069500b0051a5c1d5c06mr1550663edy.42.1690877748624; Tue, 01
 Aug 2023 01:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230306025308.248987-1-dzm91@hust.edu.cn>
In-Reply-To: <20230306025308.248987-1-dzm91@hust.edu.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 1 Aug 2023 16:15:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Nka2SN4LbbAYySWwJD=HULH7vjRaORqV4twkREfgwgA@mail.gmail.com>
Message-ID: <CAAhV-H4Nka2SN4LbbAYySWwJD=HULH7vjRaORqV4twkREfgwgA@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: loongson: fix memory leak in loongson2_guts_probe
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dongliang,

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
And please resend this patch with title "soc: loongson: fix memory
leak in loongson2_guts_probe()", cc Arnd and soc@kernel.org, because
that is the most appropriate list for this patch.

Huacai

On Mon, Mar 6, 2023 at 10:55=E2=80=AFAM Dongliang Mu <dzm91@hust.edu.cn> wr=
ote:
>
> drivers/soc/loongson/loongson2_guts.c:150 loongson2_guts_probe()
> warn: 'guts->regs' from ioremap() not released on lines: 131,135,139,143.
>
> Fix this by modifying ioremap to devm_ioremap.
>
> Note that, this patch is not tested due to the loongson architecture.
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v1->v2: instead of modifying error handling code, directly change
> ioremap to devm_ioremap.
>  drivers/soc/loongson/loongson2_guts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/loongson/loongson2_guts.c b/drivers/soc/loongson=
/loongson2_guts.c
> index bace4bc8e03b..a053e3fdae09 100644
> --- a/drivers/soc/loongson/loongson2_guts.c
> +++ b/drivers/soc/loongson/loongson2_guts.c
> @@ -107,7 +107,7 @@ static int loongson2_guts_probe(struct platform_devic=
e *pdev)
>         guts->little_endian =3D of_property_read_bool(np, "little-endian"=
);
>
>         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       guts->regs =3D ioremap(res->start, res->end - res->start + 1);
> +       guts->regs =3D devm_ioremap(dev, res->start, res->end - res->star=
t + 1);
>         if (IS_ERR(guts->regs))
>                 return PTR_ERR(guts->regs);
>
> --
> 2.39.2
>
>
