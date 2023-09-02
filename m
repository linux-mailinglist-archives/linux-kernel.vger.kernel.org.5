Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2118E790957
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 21:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjIBT2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 15:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjIBT2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 15:28:34 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E57BCDD
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693682911;
        bh=xzvJ73Ozla2X17eboD3yIz9i8bCTsk6QDjxpogr7XlU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=ADcCJAXWeDeQXe28uUOjfAmer6UQGYKYQlheIG8ht1YYPRs4gyrxtqf4g3CfVX6WX
         1HkQIiOBZ9WNx6aWeidRXoprjtxwjodOpvo9ZCq4aGS0dflcdQs5RTIto4RtpCTBy5
         lepevTlvw505cX+GQumcTXo5I1Vj6JyuM7JjLRqDKpEAXTrOQBmiHzJL3ym+3W9tga
         yLHBkqBrelSq8DbKSGvElmrUNCVq9ErDUm+QkD96OsNOpZzI9/NnzILmmweDsryaRm
         R7P69O76qQSMtRUu7KL9iwNmH8DqH+z5Wqptkclk5BLjJ4patQpY92a15tbP4pM3hL
         hTkClc+xVxerw==
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        by gnuweeb.org (Postfix) with ESMTPSA id A527424B3E6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 02:28:31 +0700 (WIB)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-500d13a8fafso402259e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 12:28:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YzTlG/GZxAtvODSHdbQ4LhF3tivbiDpEsOM2Sd6o7in3lCuNUMZ
        48GRJvTb+Sf7CHHSaMktIJqaK+DodoxtYCrRBDs=
X-Google-Smtp-Source: AGHT+IH2EeSV4yBDouB0QJKpfEmim8uV83l6X9lgU6XGoe0hEQNKN2NZjvBxR9KbpStUWnnJQvYZ2usyefjosZWLSYM=
X-Received: by 2002:a05:6512:3131:b0:4ff:9bd9:f69a with SMTP id
 p17-20020a056512313100b004ff9bd9f69amr3329731lfd.65.1693682909507; Sat, 02
 Sep 2023 12:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230902133505.2176434-1-ammarfaizi2@gnuweeb.org> <20230902133505.2176434-3-ammarfaizi2@gnuweeb.org>
In-Reply-To: <20230902133505.2176434-3-ammarfaizi2@gnuweeb.org>
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Sun, 3 Sep 2023 02:28:18 +0700
X-Gmail-Original-Message-ID: <CAOG64qNB+aRU+8VCD5MkM4srQaUnTqzZ7rZ8USxVheDAYzgTsQ@mail.gmail.com>
Message-ID: <CAOG64qNB+aRU+8VCD5MkM4srQaUnTqzZ7rZ8USxVheDAYzgTsQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/4] tools/nolibc: x86-64: Use `rep stosb` for `memset()`
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

On Sat, Sep 2, 2023 at 8:35=E2=80=AFPM Ammar Faizi wrote:
>  __asm__ (
>  ".section .text.nolibc_memmove_memcpy\n"
>  ".weak memmove\n"
>  ".weak memcpy\n"
>  "memmove:\n"
>  "memcpy:\n"
>         "movq %rdx, %rcx\n\t"
>         "movq %rdi, %rax\n\t"
>         "movq %rdi, %rdx\n\t"
>         "subq %rsi, %rdx\n\t"
>         "cmpq %rcx, %rdx\n\t"
>         "jb   .Lbackward_copy\n\t"
>         "rep movsb\n\t"
>         "retq\n"
>  ".Lbackward_copy:"
>         "leaq -1(%rdi, %rcx, 1), %rdi\n\t"
>         "leaq -1(%rsi, %rcx, 1), %rsi\n\t"
>         "std\n\t"
>         "rep movsb\n\t"
>         "cld\n\t"
>         "retq\n"
> +
> +".section .text.nolibc_memset\n"
> +".weak memset\n"
> +"memset:\n"
> +       "xchgl %eax, %esi\n"
> +       "movq  %rdx, %rcx\n"
> +       "pushq %rdi\n"
> +       "rep stosb\n"
> +       "popq  %rax\n"
> +       "retq\n"
>  );

nit: Be consistent. Use \n\t for the memset too.

Apart from that:

Reviewed-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>

-- Viro
