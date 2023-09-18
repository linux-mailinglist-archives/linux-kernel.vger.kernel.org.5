Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2277A45C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbjIRJVW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 05:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238676AbjIRJVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:21:18 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210F8D3;
        Mon, 18 Sep 2023 02:21:13 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-59bdad64411so42757207b3.3;
        Mon, 18 Sep 2023 02:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695028872; x=1695633672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09gDVjymdIZkIvApNhwmLuiLyjh5wNd5lc0HirsSW3Y=;
        b=DXrAnTyYwMme8nzz1QqfnzLa7fMkJJjcIiYAZijzoJf5qwbjiF9SC8gZCKIxS88TdM
         br5CH6gVlssTeTwEhGf9itVVBVcElGGbeTxoNY6PhWNojcBiD5GxHHC3iIovW4STb9h6
         B8PMAS9uyFB/9YT1Ku7jVE8orMdYBUZh/x7P7Wb2KDn0RhDlpsZMnKUvhAWzIN5NQQDN
         YJgfVpwbv1lrIhegKrNIvdQA39TC73l1reqzfir8eZm6eD8mDD7BnKkWVu1hhk9P/Y2g
         sRftWC0UQAsMxG0PpQWxOofAsodMpTQv/oJ5v3FJLK9ccEnR4rC7E+s368yXqknKxqLI
         Ug7w==
X-Gm-Message-State: AOJu0YysG0cLkyzTBwy9dpF5KUBCWBOmCgq9Zr0xPzvpfcNPm08hVXWT
        hbAwaidIWs7SsoDCIfgzT9A9Wd9zalMl4w==
X-Google-Smtp-Source: AGHT+IHsSU/M2sk9N4TIpMbXzZmO+S7pvwhKBqXGKxhkSDK6V0M5FucHo8mmc1wXnvvRT6VzuWFN7w==
X-Received: by 2002:a0d:e84f:0:b0:58c:53ad:ee3f with SMTP id r76-20020a0de84f000000b0058c53adee3fmr8657999ywe.34.1695028871699;
        Mon, 18 Sep 2023 02:21:11 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id s68-20020a0dd047000000b0059bdac3fd08sm2430888ywd.48.2023.09.18.02.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 02:21:11 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59e8d963adbso11011187b3.0;
        Mon, 18 Sep 2023 02:21:11 -0700 (PDT)
X-Received: by 2002:a81:7189:0:b0:592:4f93:e831 with SMTP id
 m131-20020a817189000000b005924f93e831mr8836883ywc.48.1695028870953; Mon, 18
 Sep 2023 02:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230814-void-drivers-soc-renesas-rmobile-sysc-v1-1-6648dfd854de@google.com>
 <CAMuHMdWiC4v9fctp18bRrEH-m_-0VjMg9+XpON8vdRYwniTU3g@mail.gmail.com>
In-Reply-To: <CAMuHMdWiC4v9fctp18bRrEH-m_-0VjMg9+XpON8vdRYwniTU3g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 11:20:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWk_jcZ1V7J68bw11YZ+EjEqAWOKHzanVyxo2zktbMteg@mail.gmail.com>
Message-ID: <CAMuHMdWk_jcZ1V7J68bw11YZ+EjEqAWOKHzanVyxo2zktbMteg@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: rmobile-sysc: fix -Wvoid-pointer-to-enum-cast
 warning
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Wed, Aug 30, 2023 at 10:24 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Aug 15, 2023 at 12:11 AM Justin Stitt <justinstitt@google.com> wrote:
> > When building with clang 18 I see the following warning:
> > |      drivers/soc/renesas/rmobile-sysc.c:193:22: warning: cast to smaller integer
> > |               type 'enum pd_types' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> > |        193 |                 add_special_pd(np, (enum pd_types)id->data);
> >
> > This is due to the fact that `id->data` is a void* and `enum pd_types`
> > has the size of an integer. This cast from pointer-width to int-width
> > causes truncation and possible data loss. Instead, cast to `uintptr_t`
> > which has the same width as void*.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1910
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
>
> scripts/checkpatch.pl:
>
>     WARNING: Reported-by: should be immediately followed by Closes:
> with a URL to the report
>
> Hence changing the Link: tag to a Closes: tag.
>
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: It should be noted that there is likely no data loss occurring in
> > this case since the enum only has a few fields. The narrowing cast from
> > pointer to int will not lose any data.
>
> Indeed, the theoretical narrowing could only happen on a 64-bit
> platform, while this driver is only used on arm32.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.7.

As the Generic PM Domain providers were moved to drivers/pmdomain/
in v6.6-rc2, and now have their own maintainer, I have moved this
commit from renesas-drivers-for-v6.7 to renesas-pmdomain-for-v6.7[1],
with s/soc/pmdomain/ in the oneline-summary.

Ulf: if you prefer, you can still take this patch directly.
Else I will send a PR after rc3 and/or rc5, like I do with my other
renesas-<foo>-for-<version> branches.
Thanks!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=renesas-pmdomain-for-v6.7

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
