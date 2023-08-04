Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62DF77027E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjHDOD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjHDODY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:03:24 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217DCB9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:03:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bfcf4c814so299371266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 07:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691157798; x=1691762598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7E1jKcQUlva+o/O3jCVAIqQBqhNgqf2DwG652AY1uBE=;
        b=d+guD+foRw6idKN1BVl6ryeXnQb1p+KPJhxiNAQD5EGrP072c028+Xf4T9vgezRbFL
         lh+Zk7NmWPL9cFEK0+K1ADlob6nd4g4rtGxMuRw515DCVVqpXj8ic7oLeISenXxSmnco
         UEL0bd5OhRzBDWfqnic5MjCK1+QJ5MbAZ0U8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691157798; x=1691762598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7E1jKcQUlva+o/O3jCVAIqQBqhNgqf2DwG652AY1uBE=;
        b=krRedc39HKzxmHk2ZQhPX0UjBUN27u1tyM36Nb1dS/UNkoXF8sJCEf0lrWxC7l40Hv
         U0OKd/GHsVwICAdYbqcEN7Gr/yGf7paxFbCPZErz4ekQh41mrKgVm6TU2SPRGaW8Zxx7
         zUF30cJKVmZzDC9y5h7kR0Ks/ST2FxOCnfD1L3SybD0sjTEK/m9PDZpLt1QNkQEdzvS9
         pFg4iAZfkQNCQ0jNpHZS2t6PVkwg1rJwrJXrhHWaUe+32DO4GGnLdnirkjAqIJ/U5CWC
         HjGWOlezyGiBhZjh5wwSYaGXk3rUHPuMJNn8y8cCVZ7SMxAxwseqS83/8iOpuk+48dUi
         ze+A==
X-Gm-Message-State: AOJu0YyX5NncgoEl788UXGTG2nULvKDbH+YWvjpqMRuFzMNHfieTMHbX
        TLf1mhP0pAZOReLFoXPeJF1k9HNJXP/OgXy99nkIsyNB
X-Google-Smtp-Source: AGHT+IFkfK+ad24YSp2BelX13Q7LeZKnLngHVTO1DVYdX26j8K3LDYHJbWHFVwMvr+ZJufFq3r1EaA==
X-Received: by 2002:a17:907:272a:b0:99b:4378:a5aa with SMTP id d10-20020a170907272a00b0099b4378a5aamr1599647ejl.49.1691157798282;
        Fri, 04 Aug 2023 07:03:18 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id m5-20020a1709061ec500b0098dfec235ccsm1346300ejj.47.2023.08.04.07.03.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 07:03:16 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so12541a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 07:03:16 -0700 (PDT)
X-Received: by 2002:a50:d610:0:b0:522:41c9:9b9 with SMTP id
 x16-20020a50d610000000b0052241c909b9mr59059edi.5.1691157796350; Fri, 04 Aug
 2023 07:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230804132800.2270896-1-arnd@kernel.org>
In-Reply-To: <20230804132800.2270896-1-arnd@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 4 Aug 2023 07:03:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WL5JjwbZ86De1GY_0-_j4C0emP652z0ZanDfv-qikeaw@mail.gmail.com>
Message-ID: <CAD=FV=WL5JjwbZ86De1GY_0-_j4C0emP652z0ZanDfv-qikeaw@mail.gmail.com>
Subject: Re: [PATCH 1/2] watchdog/hardlockup: avoid unused-function warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Pingfan Liu <kernelfans@gmail.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 4, 2023 at 6:28=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The newly added hardlockup_all_cpu_backtrace_proc_handler() function is d=
efined
> in some configurations that don't actually call it:
>
> kernel/watchdog.c:112:12: error: 'hardlockup_all_cpu_backtrace_proc_handl=
er' defined but not used [-Werror=3Dunused-function]
>   112 | static int hardlockup_all_cpu_backtrace_proc_handler(struct ctl_t=
able *table, int write,
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Hide the definition when either CONFIG_SMP or CONFIG_SYSCTL are disabled =
and
> the function is not actually needed.
>
> Fixes: 838b3b76220d5 ("watchdog/hardlockup: avoid large stack frames in w=
atchdog_hardlockup_check()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/watchdog.c | 2 ++
>  1 file changed, 2 insertions(+)

Thanks for the fix. In this case I'll assume that Andrew will drop the
v2 of my patch and replace it with v4 [1], which shouldn't have this
issue.

[4] https://lore.kernel.org/r/20230804065935.v4.2.I501ab68cb926ee33a7c87e06=
3d207abf09b9943c@changeid
