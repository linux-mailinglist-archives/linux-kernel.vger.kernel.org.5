Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08E47A284A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbjIOUlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjIOUku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:40:50 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465DF18D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:40:45 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-502defbb0c3so4274728e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694810443; x=1695415243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Alq0BDEsyekB/QXpHaK8s7l3AYbrPUHormmRBLs8sRE=;
        b=Kzf8nQDEUCAQgzRoCyKyoHqCp6Z0m9x7JcjuBVlna4QIMRNJkdoZVW7WTdQd3CFj52
         iahyOIlrp4UhV/dgNgb3q/98Ss/W5bIcTJ+eZKyVTGX00KgliNUhZLGI7X3BfOeWFktZ
         sglnA1xpbSrvFYf4csZas2bzPkzIniUmxarss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694810443; x=1695415243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Alq0BDEsyekB/QXpHaK8s7l3AYbrPUHormmRBLs8sRE=;
        b=usL7xZWfsaEM7mv459vfKh0/K0hwMrHDv2rJKoDt0F/cX0uXx3LNNoASL4tNahqeDw
         THwhtP6Iym1btgRRHSILPSElkYe0GlKpO6vRxAkWX0YvF/4hCKh/V4dM05CSuLAms6hl
         G/znmTZt0hYD7wyCgIJTWQbvnf7U0Qra9QAfpm4UrJXi7AQuQW5CIMFbuTyAOBD4pDKj
         V3qiO4g6rK/FI36DfQb94xS2VcGXgW6P7nqgw+2h5biapaCaATY25yCAKlbmCQasjYSk
         fXwHWH1dTsKcglHqKC/coNW71IrYmT8FqdL5TKlg/lbQ5n1gNmiw52HYGakZ7lWGC68k
         0GHg==
X-Gm-Message-State: AOJu0YwEVWtE2SLSazBtxwa9hJtVyC16my8qE3zxnpVnw1C4joQSHtUv
        g0ketCky5lAEDZRf+UBIIk0SclrxB2TTRf6jmzSrUGlD
X-Google-Smtp-Source: AGHT+IHbZEnI2l/zzpj8k7kLEPwOMjG3l99wVW6ypC0Cm1Sgu6K3Rgt5wy++e8+mwXrsFgNUAFHUeg==
X-Received: by 2002:ac2:46c2:0:b0:500:c2d8:a2a2 with SMTP id p2-20020ac246c2000000b00500c2d8a2a2mr2382210lfo.46.1694810443288;
        Fri, 15 Sep 2023 13:40:43 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id d25-20020ac244d9000000b00500ba43a43asm745698lfm.86.2023.09.15.13.40.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 13:40:42 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso40891491fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:40:42 -0700 (PDT)
X-Received: by 2002:a2e:9f4f:0:b0:2bc:ff44:b85e with SMTP id
 v15-20020a2e9f4f000000b002bcff44b85emr2659012ljk.30.1694810442091; Fri, 15
 Sep 2023 13:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <07c32bf1-6c1a-49d9-b97d-f0ae4a2b42ab@p183> <CAHk-=whO1+-4ALjFWSE0kzytz1kEbWPvy3xWvcUP1dJ4t-QqkA@mail.gmail.com>
 <CACMJSetxQi+t3SBXu6OvBbmxV8AbX2CfdSA9JvF1chLJSU9Ppw@mail.gmail.com>
 <CAHk-=wgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuESs1JyA@mail.gmail.com>
 <CACMJSevZQgik7S-62fz9H7+Mib+W0CgYMV4GyWjYV7N_E6iHVQ@mail.gmail.com> <CACMJSevrJ5KSPAZVheXkNaYj8KQFD8ck55kU_E4vEj4vzR8wnQ@mail.gmail.com>
In-Reply-To: <CACMJSevrJ5KSPAZVheXkNaYj8KQFD8ck55kU_E4vEj4vzR8wnQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 13:40:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com>
Message-ID: <CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com>
Subject: Re: Buggy __free(kfree) usage pattern already in tree
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 13:04, Bartosz Golaszewski
<bartosz.golaszewski@linaro.org> wrote:
>
> One more question wrt the __free() coding style.

I don't think we really have much of a coding style yet.

We currently literally have _one_ use of that __free() thing, and it
was problematic.

Which is why I'd like to start off fairly strict, but I'm not sure we
should make it a "coding style" yet.

IOW, my current thinking is "let's always have the constructor and
destructor together", and see how it ends up going.

Not because I think it's necessarily any kind of final rule, but
because I think our whole cleanup thing is new enough that I think
we're better off being a bit inflexible, and having a syntax where a
simple "grep" ends up showing pretty much exactly what is going on wrt
the pairing.

                  Linus
