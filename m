Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91F87F7141
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345402AbjKXKSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345728AbjKXKSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:18:32 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDB210F5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:18:05 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5cc3dd21b0cso16387777b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700821085; x=1701425885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xe7iByES8qCcfT1IfYNFaShLSvrVUDFw50wM8vwtGhs=;
        b=y0MEdI7EHts4uF/isdmDFTtTGZzOpe6XZRUlT4bnZlmi+z8jT2bgyTejtglnxO9N38
         PyjPF0QCy9KqQEBUbaO3L68e7vAzJ9EIPNPFwjz/fAd2jfSwzi/ocRwoO4x4qRPisCYg
         Ms43zhEkuyLL5WSACdD29u2aNfzfFzMZS9thH8LISc3AbKNgTenxKxqqbwzU4sbNcOXl
         Xr7UPj6hZGvuVCOlOvcfutwYDStQNLAvEo0jkrOHxKe3OIMTDSnISfr49RURHyHPa501
         VShz1iC03befwAK8VkqrCGIFIhf+znF1JbZKQN2I0s080KdT/Gw1ZKBxmjSxCjmY3gJJ
         ec5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700821085; x=1701425885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xe7iByES8qCcfT1IfYNFaShLSvrVUDFw50wM8vwtGhs=;
        b=Hvb56hGybjZfPkviTQ2mcdCtNe+ooSzQ5P+O0fQNXV2Efl+41JflEk+GZOL24s92iZ
         G6ycWEcJ4XouiZ9lDWKcWiJqJ/SXG/z89KXCu1uCEvLtyQQ5G9FyfrYbEAa+i5vBJ64v
         rm/EG5qv8ZYUpOiT55lMkdXfddRltrzbzi3jmpxoTE4tG/SQMSQSjUKzp2jGpfvoLvit
         ai34kVpHYCT4OHxN6RkDixZ8iqZWZfUQSVCiHyUS3ntytA7l8EGT+1quoFp94CtgbqBp
         IGF/VWH0XGiHNKz27ZHmc+Qv2pM928zdd6lSj2QHMJfHXUoNcAuloKfvFQ66XlAp7fMV
         Jk/A==
X-Gm-Message-State: AOJu0YyEQwBXd9/8RIos5BwkqXNtnnSo6gyGYZEMqToE9/ncE8/FLj6b
        Okx8Kpmm0Xl1DkUTOIH1OjBfxKd0YJ8xkzxO6AJGwA==
X-Google-Smtp-Source: AGHT+IG8iaEyiFM59ESevDjE9vPuHHbQDr1w/P/tGmZWOMIBN3A2ZiFwbVfmEed56HUcIuuKQk+nI+Fh1ToiAf1nTUE=
X-Received: by 2002:a25:6d7:0:b0:db0:2f97:8757 with SMTP id
 206-20020a2506d7000000b00db02f978757mr1792022ybg.38.1700821084607; Fri, 24
 Nov 2023 02:18:04 -0800 (PST)
MIME-Version: 1.0
References: <20231123193355.3400852-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231123193355.3400852-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 Nov 2023 11:17:53 +0100
Message-ID: <CACRpkdbEoAvTs4c5e910bsBZej2Gs6H+SPLAXUnKM2qRk+5MTw@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] pinctrl: Convert struct group_desc to use struct pingroup
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 8:34=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The struct group_desc has a lot of duplication with struct pingroup.
> Deduplicate that by embeddind the latter in the former and convert
> users.
>
> Linus, assuming everything is fine, I can push this to my tree.
> Or you can apply it (assumming all CIs and people are happy with
> the series).

I would give people some time to test the changes and ACK it,
but admittedly it's a very tasty patch set and I am eager to merge
it ASAP.

Shall we give people a week and then we merge it?

> NB. This series contains previously sent patches for Qualcomm and
> Nuovoton. Here the updated version for Qualcomm that splits previous
> patch to two and fixes compilation warnings.

Fair enough, I'll just use this series.

> NB. The function_desc is in plan to follow the similar deduplication.

Yes!

Yours,
Linus Walleij
