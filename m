Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD2879877A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 14:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242150AbjIHM7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 08:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjIHM7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:59:08 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6439319AE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 05:59:02 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d7bae413275so4391468276.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 05:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694177941; x=1694782741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXQLIZEpaVX81BOLcyAZczzFkDh+1fJxbCyX5mBfRvs=;
        b=FjeKKLGQ/8VL4QW2qwr1iWVhe9RMK7BbAvOEv2Ub59D0aFajuBlAKXi/kcazpLFPMD
         p3epDXgklsIa9MnHbQz/iw+OBXUguk4AL8BwIj0PDubh6Khs80pRlEwsSDufNU3ESERJ
         Q4XO/wKMlj6myE0c4+5IyQB3ZC0L5x/SCU2mvmoUrAIyFvrJkn9Mjowuzm8zGYLTCgxc
         XbQ6JLkZfXKcii5yGgb2PTeA2xdgtA2JtYuKbutm1FyzjQngag9bDWzkjdYLgUfCWyX1
         ewcYeDxrT0cM+ePMGBY16RCr0Dc+pkQls8YgYssWCQIxScjsb9dShFhHeRvrRtABem85
         lTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694177941; x=1694782741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXQLIZEpaVX81BOLcyAZczzFkDh+1fJxbCyX5mBfRvs=;
        b=BlmTgE4ma1lq7j8hNwFXptUyQodWKgKdMMWCXmiA7yAeaH/j3gE5yCs7pZ/uv/WxTC
         FWC+sL5UtbAjBoa7HJvjea4yAhwc8ZkP4Irs3udABS7db9G447DbzVoBR2O24iffZQyD
         SspO5eaLRXiEerMGtyCfEPi843EXcRt2ma8V5MezIYtuyNWWWdF5UAHSfuPlj0xh71Xi
         C63M/ZH90endUYzkjOJLiaoF6p7JVbBOh7D420X1RuHrvun5riDxdgzj9ll+ABJZ4mZ0
         YlziEW3HvcvQzLrku+/QgQ8MJILhtv69qWtvDAnwbuu907cw97DMZZ38/jiPpLi46b1q
         deVA==
X-Gm-Message-State: AOJu0Yw29etCB4Byv/zDFaRS2Rose6phXwKpmgLcky3cV/Lkn0jjaRBd
        JUSkF849NJGQ7eUp6BhcmtxCIO/QBKT5Y5hkowauqw==
X-Google-Smtp-Source: AGHT+IF0gsvWHMYROGdwrRXSuXcMhrFG0qyK5LXp61YZsunTGu2p0tuVXNoBZ5/N48fzXHg9Psi8hFAgtg5zxS/BkC0=
X-Received: by 2002:a25:8608:0:b0:d07:b677:3349 with SMTP id
 y8-20020a258608000000b00d07b6773349mr2605124ybk.25.1694177941018; Fri, 08 Sep
 2023 05:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230907143302.4940-1-zhizhou.zh@gmail.com>
In-Reply-To: <20230907143302.4940-1-zhizhou.zh@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Sep 2023 14:58:49 +0200
Message-ID: <CACRpkdY=EYQfRrUaw5JL5e0x2p=KurYfwvfunJ+GF1PmupKNqg@mail.gmail.com>
Subject: Re: [PATCH] ARM: mm: fix stack corruption when CONFIG_ARM_PV_FIXUP=y
To:     Zhizhou Zhang <zhizhou.zh@gmail.com>
Cc:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, rppt@kernel.org,
        akpm@linux-foundation.org, vishal.moola@gmail.com, arnd@arndb.de,
        wangkefeng.wang@huawei.com, willy@infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhizhou Zhang <zhizhouzhang@asrmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhizhou,

wow a great patch! I'm surprised no-one has been hit by this before.
I guess we were lucky.

On Thu, Sep 7, 2023 at 4:33=E2=80=AFPM Zhizhou Zhang <zhizhou.zh@gmail.com>=
 wrote:

> From: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
>
> flush_cache_all() save registers to stack at function entry.
> If it's called after cache disabled, the data is written to
> memory directly. So the following clean cache operation corrupted
> registers saved by flush_cache_all(), including lr register.
> calling flush_cache_all() before turn off cache fixed the problem.
>
> Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I would also add
Cc: stable@vger.kernel.org

Then please put this into Russell's patch tracker once review
is complete.

Yours,
Linus Walleij
