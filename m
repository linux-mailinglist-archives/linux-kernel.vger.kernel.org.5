Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D9A78DEE8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239781AbjH3TbU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Aug 2023 15:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242392AbjH3IZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:25:13 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE979FB;
        Wed, 30 Aug 2023 01:25:10 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d776e1f181bso5103783276.3;
        Wed, 30 Aug 2023 01:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693383910; x=1693988710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XG62sgnGcJnF0tJvK3oQY2fo6A4TDxZZoS0niAlQiv4=;
        b=eRMhonpmGnX232Do1R5TZv0N/KbRNzA2UPVWBvQmAMw4Biz5fr8lsbMdHphZfHMrma
         UNXtEHg9lTCQV1ggA4KNKJhTQKfO+ZgEK/MJEAV4FTWuYxIvcXxmlC+OABNlr5Q5cRrp
         Np4NuHMKchENUIif4UHBTALWQNVz4Rem7dDXVdS/VLg/y2wAgc0lrW9gmAtuBWwV2/Nd
         2ip81AavPYAT6sqRrOfpuNojZnoRqE0zPPdqGe5gMOb9hN5YkvQIiNSB1Cw603BtPQ0/
         lj4nBL3/J74R68BUrlrH9bAEwrCJuUS3GwL5TWWLUsDgkvHOn5PXWdZd9cL20PLduMzk
         t0JQ==
X-Gm-Message-State: AOJu0YwlDRiFBXNkxZQOOh9dSQ0tvFW8KdolZ5h88oZkLSF/l0AWfdyu
        q/9RpT7qLzVOlLzcdM2gyZUQYZ6nIyu0kw==
X-Google-Smtp-Source: AGHT+IHEKIvo7RqAvDW9hLlit5YrOP/L1nNlkCXkCCq2nKLWOdNpSG/790pQjr+1+cpCxEwgnx5/aQ==
X-Received: by 2002:a25:2fd5:0:b0:d09:f934:f2fe with SMTP id v204-20020a252fd5000000b00d09f934f2femr1262232ybv.18.1693383909791;
        Wed, 30 Aug 2023 01:25:09 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id u6-20020a250946000000b00d7473b81a2csm2490394ybm.26.2023.08.30.01.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 01:25:09 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d7d50ba994eso28980276.1;
        Wed, 30 Aug 2023 01:25:09 -0700 (PDT)
X-Received: by 2002:a25:dcf:0:b0:d6b:8ea4:b8a1 with SMTP id
 198-20020a250dcf000000b00d6b8ea4b8a1mr1475047ybn.12.1693383909143; Wed, 30
 Aug 2023 01:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230814-void-drivers-soc-renesas-rmobile-sysc-v1-1-6648dfd854de@google.com>
In-Reply-To: <20230814-void-drivers-soc-renesas-rmobile-sysc-v1-1-6648dfd854de@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Aug 2023 10:24:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWiC4v9fctp18bRrEH-m_-0VjMg9+XpON8vdRYwniTU3g@mail.gmail.com>
Message-ID: <CAMuHMdWiC4v9fctp18bRrEH-m_-0VjMg9+XpON8vdRYwniTU3g@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: rmobile-sysc: fix -Wvoid-pointer-to-enum-cast
 warning
To:     Justin Stitt <justinstitt@google.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

On Tue, Aug 15, 2023 at 12:11 AM Justin Stitt <justinstitt@google.com> wrote:
> When building with clang 18 I see the following warning:
> |      drivers/soc/renesas/rmobile-sysc.c:193:22: warning: cast to smaller integer
> |               type 'enum pd_types' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> |        193 |                 add_special_pd(np, (enum pd_types)id->data);
>
> This is due to the fact that `id->data` is a void* and `enum pd_types`
> has the size of an integer. This cast from pointer-width to int-width
> causes truncation and possible data loss. Instead, cast to `uintptr_t`
> which has the same width as void*.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1910
> Reported-by: Nathan Chancellor <nathan@kernel.org>

scripts/checkpatch.pl:

    WARNING: Reported-by: should be immediately followed by Closes:
with a URL to the report

Hence changing the Link: tag to a Closes: tag.

> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: It should be noted that there is likely no data loss occurring in
> this case since the enum only has a few fields. The narrowing cast from
> pointer to int will not lose any data.

Indeed, the theoretical narrowing could only happen on a 64-bit
platform, while this driver is only used on arm32.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.7.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
