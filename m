Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042A378DE1D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbjH3S5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244813AbjH3OIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:08:22 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDE5122
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693404499;
        bh=2rPjSj4uwqIpKtOZtB9CZIjdRYw0Gfa1l2U++6sPXLI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=g07yWZlvRC0xVnKrJ2qCKZuJqL/F7wK5UDSGolEsBIfnPlQsCRz6SvpmavEL7pHT7
         VG7dmix+TihOirgxoD8te1QG4deqBs8GR/ASkE8mUerDj0uTmOCA2/MGHHH/fwohxu
         S5hyIdxcJsKUFiX75uvwXJejS4XuuV7DngxaOnC5kxm+Lnvitep01LCj9XJISGgJm5
         kv9YKuy3p2yGxyuwZoMpI2kMqt4jcaAVRRyE72NmsNVoHzxm3RfJlt5fBqS8+dnP0l
         2Ixs7mI8LmRC8LRcqNBZnaXoztPSg5bYvj8eSOd4SA25+SUGykEVerCD4oI6/jHOSV
         3xYxM2ahr/1Mg==
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        by gnuweeb.org (Postfix) with ESMTPSA id 2A28224B32C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 21:08:19 +0700 (WIB)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-500c37d479aso2916103e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:08:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YyhTksJLXueAg3kaQFWcb7LGUUfV3mqNyrtsQnhjYY8ZoYPciKv
        te+eY1NsNd93mzxlA8T1rVkXJwkCUPrxC9oR/4A=
X-Google-Smtp-Source: AGHT+IEbVPGFfSyhPzFLepWZwQvMOr16fe1WwB+fGC2q4nCTtbZAeJaaXsWM58fM5+tjMmjOPDmmCUJBM9ZOrGCQ0wE=
X-Received: by 2002:a05:6512:402a:b0:500:9977:bdce with SMTP id
 br42-20020a056512402a00b005009977bdcemr1945766lfb.62.1693404497078; Wed, 30
 Aug 2023 07:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org> <20230830135726.1939997-3-ammarfaizi2@gnuweeb.org>
In-Reply-To: <20230830135726.1939997-3-ammarfaizi2@gnuweeb.org>
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Wed, 30 Aug 2023 21:08:05 +0700
X-Gmail-Original-Message-ID: <CAOG64qMkQJ-znXbeBz=zubhbonzEKtzJ5y6xQZPvXUpkC-=TDg@mail.gmail.com>
Message-ID: <CAOG64qMkQJ-znXbeBz=zubhbonzEKtzJ5y6xQZPvXUpkC-=TDg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/5] tools/nolibc: x86-64: Use `rep stosb` for `memset()`
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
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

On Wed, Aug 30, 2023 at 8:57=E2=80=AFPM Ammar Faizi wrote:
> +".section .text.nolibc_memset\n"
> +".weak memset\n"
> +"memset:\n"
> +       "movq %rsi, %rax\n"
> +       "movq %rdx, %rcx\n"
> +       "movq %rdi, %rdx\n"
> +       "rep stosb\n"
> +       "movq %rdx, %rax\n"
> +       "retq\n"

The first instruction could be:

   movl %esi, %eax

That's smaller. Also, the second argument of memset() is an int
anyway, so there is no need to have a full 64-bit copy of %rsi in
%rax.

-- Viro
