Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16009750D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjGLQF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjGLQF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:05:57 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF96A1BE2;
        Wed, 12 Jul 2023 09:05:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3094910b150so7792635f8f.0;
        Wed, 12 Jul 2023 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689177954; x=1691769954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2UhWtOknxAONFk0+utWHnQitKmiwh4ry/tqUazjREk=;
        b=bNhU0hXZyRBn0cyaqVhfAfcG4Er1AHGgnbVeFRJ/Swz0fIiFdPPPbfezGhTAgmGGb9
         G1KSoT5dS7Sen7NB/GLXXXubKj7ZBhP1lIRoMMa0SLq6hYsFj+7ag71P3pTQsQci+xEA
         ar4cGr83BfP3YwGM1tc75iVIU1SlilqzoqoQV/HekdFxXuSK39HA2U/btaqmSTQ0VSId
         HJJGz5WJG6kJ7r3bgDeo8q/Mmz0GSGluJtjfM11ewp/4Vm0mRZkGo2rrbjeQspkPnVVG
         WCIXag+JwQdZgdXF/pDx8HOVMxxzgfOy4DAO9jH7ajevcfSNS39c3ErD0XRPKBTzFd75
         p+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689177954; x=1691769954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2UhWtOknxAONFk0+utWHnQitKmiwh4ry/tqUazjREk=;
        b=iobvl1iwcePQZwxMSjAikmwVMK47rzswMcYiDibt65ncQesgZ7Wnwk24CWZpDIB4w6
         Y+Motd/dOyQISi4OPCgHuo6Ye/sygbfiaXFSm/Gv/D3tLhc7HprSBUighuLcl2zYC3/s
         bK+F4s5wu7A+YK6EApBt8Ejmp4k/JmjmyAlgq1UyhNPAC4KeSOhvTZGIhx37m2jXaHoI
         yD86vvpjGaQBlTOYLoy4pE4KRO3PZY1nVyBiyZ9/Cl241j1XYxec2lcj+1+V6UcdXDxv
         5fE3ti3s/wRO3RhobpzdPoOOJGZeMjXJReQ3BRMrAyn5lGVjEqGt2rBIlDDGlG1PkTnq
         TAwQ==
X-Gm-Message-State: ABy/qLY5aAoDz9EYlxwoMeWBblLn2w+Lpqb73xgy1EYPPVEnwYJK5M9p
        mHj7FmzZX1dbpxLa4OP63X4=
X-Google-Smtp-Source: APBJJlHsiKo6ByCouYojx1vB4RKxt1mZjIVaLkmFeXvoaDzpU5qzdIrG+dCWPX8MGwpXLNkLRoM9iA==
X-Received: by 2002:a5d:6909:0:b0:313:f235:cd17 with SMTP id t9-20020a5d6909000000b00313f235cd17mr14934684wru.40.1689177953987;
        Wed, 12 Jul 2023 09:05:53 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm5446714wrx.48.2023.07.12.09.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 09:05:47 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Yangtao Li <frank.li@vivo.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/19] cpufreq: sun50i: Convert to platform remove callback
 returning void
Date:   Wed, 12 Jul 2023 18:05:40 +0200
Message-ID: <2159659.Icojqenx9y@jernej-laptop>
In-Reply-To: <20230712093322.37322-1-frank.li@vivo.com>
References: <20230712093322.37322-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 12. julij 2023 ob 11:33:04 CEST je Yangtao Li napisal(a):
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Jernej =C5=A0krabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> b/drivers/cpufreq/sun50i-cpufreq-nvmem.c index 4321d7bbe769..32a9c88f8ff6
> 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -137,7 +137,7 @@ static int sun50i_cpufreq_nvmem_probe(struct
> platform_device *pdev) return ret;
>  }
>=20
> -static int sun50i_cpufreq_nvmem_remove(struct platform_device *pdev)
> +static void sun50i_cpufreq_nvmem_remove(struct platform_device *pdev)
>  {
>  	int *opp_tokens =3D platform_get_drvdata(pdev);
>  	unsigned int cpu;
> @@ -148,13 +148,11 @@ static int sun50i_cpufreq_nvmem_remove(struct
> platform_device *pdev) dev_pm_opp_put_prop_name(opp_tokens[cpu]);
>=20
>  	kfree(opp_tokens);
> -
> -	return 0;
>  }
>=20
>  static struct platform_driver sun50i_cpufreq_driver =3D {
>  	.probe =3D sun50i_cpufreq_nvmem_probe,
> -	.remove =3D sun50i_cpufreq_nvmem_remove,
> +	.remove_new =3D sun50i_cpufreq_nvmem_remove,
>  	.driver =3D {
>  		.name =3D "sun50i-cpufreq-nvmem",
>  	},




