Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A697790586
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 08:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351637AbjIBGII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 02:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjIBGIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 02:08:07 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6296B10F5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 23:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693634883;
        bh=KGXS6wf0NXvMG0rOmMY/SungdUqyUjqt8ehUNcjdL/4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=SuAY0z678b8pE+vkMzIOXiKAH/F2CGRC5R0Illp1ZjDLpvOLTyoQcJRhmVcgP5LAi
         H0FX0twjAAsuufmQB1gXW/Aq8khe6Jjl38GICPZ7+zAqqx3Bk96Hbx2Rflo9MA2Qbh
         QBN/VUGaYbBLLA56cxTyTr/BQq9VWjwhMNAN42JIL9XDvxBEBzXkFv5IDMeajTO0/f
         ovxuNxBVdPOIpY+HveEKTcJlIp2/svx1fpcoThryIy2Wn5ADEHgC45ue0agJM5q16/
         /8QTMbWafdDbSlNx5ZBIZcuBxEzjn1MQYsjCRGGn/dLi03w/OBUbovjIpmGNvSnOGe
         25b6idEGBOkqQ==
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        by gnuweeb.org (Postfix) with ESMTPSA id D84DB24B3A7
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 13:08:03 +0700 (WIB)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-500b66f8b27so4770587e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 23:08:03 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzea83VlRRuHT8f+HxMt7/KVffHcSeIqKdQw66fL1X0onKjiI19
        fUvRiXvs4nFfvi7S6QnVY3eP1dHUROSc1BGSkJg=
X-Google-Smtp-Source: AGHT+IHwdYAwiETgdVehokm0E3YRSYOKGsHwXP9tp1jBiGz/WCIJNAIsrHnuiC8BVPFRuuMFkEdVcxndR7yHM2qO6RI=
X-Received: by 2002:a05:6512:3b26:b0:500:b2f6:592 with SMTP id
 f38-20020a0565123b2600b00500b2f60592mr3268630lfv.50.1693634881845; Fri, 01
 Sep 2023 23:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230902055045.2138405-1-ammarfaizi2@gnuweeb.org> <20230902055045.2138405-2-ammarfaizi2@gnuweeb.org>
In-Reply-To: <20230902055045.2138405-2-ammarfaizi2@gnuweeb.org>
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Sat, 2 Sep 2023 13:07:50 +0700
X-Gmail-Original-Message-ID: <CAOG64qNw+ZovcC4+5Sqsvi-m=wyoe47eb5K4KAdbO5hcp8ipAA@mail.gmail.com>
Message-ID: <CAOG64qNw+ZovcC4+5Sqsvi-m=wyoe47eb5K4KAdbO5hcp8ipAA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] tools/nolibc: x86-64: Use `rep movsb` for
 `memcpy()` and `memmove()`
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        David Laight <David.Laight@aculab.com>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 2, 2023 at 12:51=E2=80=AFPM Ammar Faizi wrote:
> +__asm__ (
> +".section .text.nolibc_memmove\n"
> +".weak memmove\n"
> +"memmove:\n"
> +       "movq %rdx, %rcx\n"
> +       "movq %rdi, %rdx\n"
> +       "movq %rdi, %rax\n"
> +       "subq %rsi, %rdx\n"
> +       "cmpq %rcx, %rdx\n"
> +       "jnb  .Lforward_copy\n"
> +       "leaq -1(%rdi, %rcx, 1), %rdi\n"
> +       "leaq -1(%rsi, %rcx, 1), %rsi\n"
> +       "std\n"
> +       "rep movsb\n"
> +       "cld\n"
> +       "retq\n"
> +".Lforward_copy:\n"
> +       "rep movsb\n"
> +       "retq\n"
> +
> +".section .text.nolibc_memcpy\n"
> +".weak memcpy\n"
> +"memcpy:\n"
> +       "movq %rdi, %rax\n"
> +       "movq %rdx, %rcx\n"
> +       "rep movsb\n"
> +       "retq\n"
> +);

Btw, sir, this can be simplified more by merging the forward copy
path, only using two "rep movsb" for both memmove() and memcpy()
should be enough?
```
__asm__ (
".section .text.nolibc_memmove_memcpy\n"
".weak memmove\n"
".weak memcpy\n"
"memmove:\n"
        "movq %rdx, %rcx\n"
        "movq %rdi, %rdx\n"
        "movq %rdi, %rax\n"
        "subq %rsi, %rdx\n"
        "cmpq %rcx, %rdx\n"
        "jnb __nolibc_forward_copy\n"
        "leaq -1(%rdi, %rcx, 1), %rdi\n"
        "leaq -1(%rsi, %rcx, 1), %rsi\n"
        "std\n"
        "rep movsb\n"
        "cld\n"
        "retq\n"

"memcpy:\n"
        "movq %rdi, %rax\n"
        "movq %rdx, %rcx\n"
"__nolibc_forward_copy:\n"
        "rep movsb\n"
        "retq\n"
);
```
Thought?

-- Viro
