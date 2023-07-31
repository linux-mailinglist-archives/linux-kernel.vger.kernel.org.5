Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290D076A01F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjGaSPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGaSPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:15:01 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6744A198A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:15:00 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d09ba80fbcaso4995438276.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690827299; x=1691432099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NhrG3ebunqqW/6fNvydCmbdIW5aLv6UuHyoJLzPhvU=;
        b=tldtOfPyvntdk2HF/kg3s7SdAP0QaF8msWK3JVFpDXcVBo9uim8imXk6qLdunFRQFz
         w5VcSdpIN+AujQgh0zySWo6ZPrUl5zbZ4NneL+3Yz2mqD8JNcVrZjVGWaKaT9ny6KVTY
         SHyQb5mdXV4HIbnf4RA43pdntiBR519rPKoOfkEnAUjcGNlMAJHxfsuSIuVfsas1JFMR
         HwVCTUxs+qnPIqOtdLY+Sjj8b8qgLOzW28T8YWColjn5XcfN7AT/qbQpHuN/lJDUppAY
         RG7R2ME/OanCsSY3b1/vYDWKvYekeesolZmTxvgDs8gFq87lZyEOZV2E1s3RH3qyhquA
         3Hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690827299; x=1691432099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NhrG3ebunqqW/6fNvydCmbdIW5aLv6UuHyoJLzPhvU=;
        b=J4sSngC1NYMFy6kVp3E/H52TcXkcAaCBsZTpJkpjRoILCZQ2i4ito3QLTOhV9qc/4W
         UgaKIdYuj1phSaPm2moCx9gh0QpRuuPTBCRo++lRFKppX9N0yc6dRHwSf+js5GyPQAp7
         DJ9ePD5v2Pxxy2eygc5oX+DSNN1MQ77LgLwYX32LY1J5sZT0gwy4DQ2gUzd8bDoYkYJX
         o0duQV3w3qGNjOQg/0QyMIRH79jvEOoPxmorvrC79at/qId/ho9BYfjtNXhCUmBqaf3X
         6/AetUSy9+DRU9z5UEs5n510X/Tcjrt44GXve9BLetYm+FcdQemcd37D9mVzyw2go+Xq
         7NQQ==
X-Gm-Message-State: ABy/qLaRZHfmEQ/+9qtcA7z1D3xO5cgvwfrO1UAZ7lKjl1omPPTRpJvy
        OwO3TvmgLs1GtOdz/FYTkWA5Yi9OGVF9H9RzV3yH5w==
X-Google-Smtp-Source: APBJJlGIZWGKvTQYHo1n6R8G7XvGTwdV9smwAb/lAv3joMhn1JrPkus+Hp6j/DhQPokMTNgtjPMmHvQuHyGNfB0lcbI=
X-Received: by 2002:a25:ccc4:0:b0:d12:1094:2036 with SMTP id
 l187-20020a25ccc4000000b00d1210942036mr10193347ybf.43.1690827299443; Mon, 31
 Jul 2023 11:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230731030740.12411-1-rdunlap@infradead.org>
In-Reply-To: <20230731030740.12411-1-rdunlap@infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 31 Jul 2023 11:14:46 -0700
Message-ID: <CAJuCfpGQzpWptS0WBBzw8XesPFb5MeG5UVLFDce72wfXNA1joQ@mail.gmail.com>
Subject: Re: [PATCH] PSI: select KERNFS as needed
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 8:07=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Users of KERNFS should select it to enforce its being built, so
> do this to prevent a build error.
>
> In file included from ../kernel/sched/build_utility.c:97:
> ../kernel/sched/psi.c: In function 'psi_trigger_poll':
> ../kernel/sched/psi.c:1479:17: error: implicit declaration of function 'k=
ernfs_generic_poll' [-Werror=3Dimplicit-function-declaration]
>  1479 |                 kernfs_generic_poll(t->of, wait);
>
> Fixes: aff037078eca ("sched/psi: use kernfs polling functions for PSI tri=
gger polling")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: lore.kernel.org/r/202307310732.r65EQFY0-lkp@intel.com
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Suren Baghdasaryan <surenb@google.com>

Thanks!


> ---
>  init/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> diff -- a/init/Kconfig b/init/Kconfig
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -629,6 +629,7 @@ config TASK_IO_ACCOUNTING
>
>  config PSI
>         bool "Pressure stall information tracking"
> +       select KERNFS
>         help
>           Collect metrics that indicate how overcommitted the CPU, memory=
,
>           and IO capacity are in the system.
