Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9C979C95B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjILIKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjILIK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:10:29 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1789B10C3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:10:26 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d7b9c04591fso4496406276.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694506225; x=1695111025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D23QCFFdVljslwRPpscICFpYkj6MKZK1qKf0WOOnjMw=;
        b=Zm/izVhX4Uq1hjjaoZlnPvIw0wCrR1Y+pA2KUPqoIwXQ+5jZSn609zfXJGez2pb6IE
         Hrd9BNuYqu9MjnQuR9ynlTmu6+GEKyWMmtdJx+PJTP3tyAkcSD2Uig44PO157nE8+4qh
         lSN0Ai07nO6o2CEu55vVwNoXqFZaDkgs6CthJ/jcOb83hOdMgnWRxLQhe0a+fWAZTjYo
         TEGLZBChaxLOZYfxN5ac+wIinLaWXe/G0DKRb8PsKUxhyK0LLmSMfvqfh374rL4aZljG
         hcnOmV1SvxVk9X+iv5A0tWj7tljbm2zQKEJf+rxmuhofQR5zPSj4CooXPerH4M80LxY9
         PP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694506225; x=1695111025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D23QCFFdVljslwRPpscICFpYkj6MKZK1qKf0WOOnjMw=;
        b=SlQH5T+b3vkU+wG15PbYzVI7BbE06xkAG/m6PY2gwCImqGvXpZt0Hm3tQ8j7JXSBar
         HivnEgGBN6qkziutUnnJZMDdz9TC0pnelnVXisPwx7yBjmU8t419AwIb3jYkQfaFDl8L
         L+9x3wuXykMIbh+CG4+ke+uTbOE5InGQ8Kr9vCBkZQbGdqICEvzyKfaglS4+7nHClQvC
         auX0GFUBPZUlLW5BOgibgOu3gcL2lbTFHcvUJfnXF8PtwZB2JVbsBZMT+15USffD1DGr
         TbOGTUGWuVq2CGFR9L1iNFLPbBXX8a6NIe25yHtnEGeY2GY/wAsmrqvH1CQ4mnnPzf/J
         2XtQ==
X-Gm-Message-State: AOJu0YxzGkG0p10eT2X8pLFLtBu5Za/eW5lxaYbxWUizWnF1uJVw9p0L
        96RJ1uHIyI+PYP/xvWjSCui67s2mkVt0Qxgh9slN6g==
X-Google-Smtp-Source: AGHT+IFUaI+x8sTgAhtsHEXehUsOGuNAlMUyXBI2fE5fjfuw8ZkM7Ny4FixFpCjeoF3FXKTZXWmOTSFch31+D42wVa4=
X-Received: by 2002:a25:8051:0:b0:d78:538:8017 with SMTP id
 a17-20020a258051000000b00d7805388017mr10943065ybn.61.1694506225296; Tue, 12
 Sep 2023 01:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230905122105.117000-1-hal.feng@starfivetech.com>
In-Reply-To: <20230905122105.117000-1-hal.feng@starfivetech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 10:10:14 +0200
Message-ID: <CACRpkdaKYvs9Gc11Zx+Ev7ygNnpPOpe1G4fdMzyEmUO2-bAzvA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Fix an irq issue and add system pm ops for
 StarFive JH7110 pinctrl drivers
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     Andreas Schwab <schwab@suse.de>, Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 2:22=E2=80=AFPM Hal Feng <hal.feng@starfivetech.com>=
 wrote:

> This patchset fixes some issues arising when CONFIG_PM is enabled
> or suspending to disk.
>
> The first patch fixes failure to set irq after CONFIG_PM is enabled.
>
> The second patch adds system pm ops to save and restore context. So it ca=
n
> ensure that the pins configuration keep consistent with the one before
> suspending.

Patches applied for fixes!

Yours,
Linus Walleij
