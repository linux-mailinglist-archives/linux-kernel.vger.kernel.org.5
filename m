Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5E680DFAB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345389AbjLKXsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 18:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345163AbjLKXsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:48:38 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07441D0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 15:48:45 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-db99bad7745so4667859276.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 15:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702338524; x=1702943324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euwhIsXaz0VLvDyOMBm+aGeo2N9PmOW4/s9hUBEtSZo=;
        b=x4GX/zQ/bn9bZMeZ5vnmGHY9Bgw5VNMkl82qDdU7+7fFWYNnVCWJv7yEwYQDvldJiI
         +ruO/a4Wpd5fxSeOo8+7CIrOO79h2a5Qb0VOu7SVfsOIY8dINIK+AHE3PwQSrBN/CL/s
         US6FfLbb2NsW/H4g3P+5km4V8i6mLeV3jpzmUz0yPDk5kgikznNTM4LmNroElKUJhqpo
         X/aQL49+u+ZxUVh9LaALaOQle//ExuzjBcyudB7CKWmwmxSk2SrToc98KWQkdEuWqH1u
         QrT0S8245VmLA3p22yNloX8RbzfBKEPilN+ArhaF88nvW5vbBsR33XoV00TxokAVYxW+
         7Q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702338524; x=1702943324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euwhIsXaz0VLvDyOMBm+aGeo2N9PmOW4/s9hUBEtSZo=;
        b=NUDF/PpQi982hzyGz5Ua8AyznVIl6D2cuxMtWvxPYfquf2Msv0vO9EqAKx5Ee/tZVA
         nijEqVguoCL4gVwFOVHfjJVbL+ors/S6jiUwyVl0Oi6R8QoZ2/Dls5vyakvBUSQ9IGr3
         rYwFUOOHg9HzMp17O060WXYNkbeyzhMAN0Vqnq/veT5AT7lIC/vFvRCiksptQY6MOiR/
         SnP7PoFFgjlVGRnUUYf8gqS3pgj7fw6QhcAyHJIhsQQr8ZEFTXMoZv1r7j6p7XOpiFAk
         uJAtN075lJRLF1oWXPy8X2XgzGf+XOpRnUSn4ZDuuHgFbWMqWO1pI5yveozI/n99UEsS
         izYA==
X-Gm-Message-State: AOJu0Yz3BI9y+EWUsqXcj115i9FQF/TqdLHIczobPQrvR91f0gNbZlS0
        RT1/msRIRzNm6+2ems3RnduqDv2E4oNnw2d+YndsWQ==
X-Google-Smtp-Source: AGHT+IF3tcL6UUeVPz0zW8dM+eYBEA/+XZsY8k/PjoTsu5zg1gtMmDM1MoplNrzJcbsk6c/SNpSN4vT8MNFw/3YCimY=
X-Received: by 2002:a25:254:0:b0:db5:4715:da36 with SMTP id
 81-20020a250254000000b00db54715da36mr3859002ybc.58.1702338524206; Mon, 11 Dec
 2023 15:48:44 -0800 (PST)
MIME-Version: 1.0
References: <20231211190321.307330-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231211190321.307330-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Dec 2023 00:48:33 +0100
Message-ID: <CACRpkdbbDAph2gUyvPCPD0s6LtjekK8zVBPLMg1ESB_1SMow_A@mail.gmail.com>
Subject: Re: [PATCH v5 00/13] pinctrl: Convert struct group_desc to use struct pingroup
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
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
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 8:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The struct group_desc has a lot of duplication with struct pingroup.
> Deduplicate that by embeddind the latter in the former and convert
> users.
>
> NB. The function_desc is in plan to follow the similar deduplication.
>
> This time test-compiled with old GCC 8 for arm64, besides GCC 13 and
> LLVM 16 for x86_64.

Applied to my pin control devel branch for v6.8.

Yours,
Linus Walleij
