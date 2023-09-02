Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81F37907D1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 14:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352144AbjIBM3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 08:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjIBM3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 08:29:21 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C86910E0
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 05:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693657757;
        bh=AtG3Iyi6gTVowxJCuojBnu+RwPVve0jFTSJOwaVC024=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=V3WgnsDxdGMwLTZthOzfVYGxHzW3Wp9FnDzKLX2b8Cb4GEuSz/C1nneShROfgZbXT
         04FOYbSc/2tWrLg2d0fHhnHSxvMXi6BHxpa6XDGaMAh8WPMe9GMXwBtDpiVH8UKKfS
         E8jkYzYQhoRKbXj7By0n3C4ZkoYD/J26jBi4rZuDiTgguSQzYNnF1KAc78GrV4hi1E
         DmIgxsh89iOGoc10WbWaQjgZNN98PXlcTq9KrE7U4Ht5DdhmT5VpzUHu0ToqXqx6xS
         v2PIZ6OKIOWRJIrm5I0DDB2435odWp5XA19gTmIey1oI+rj5QBDtglGXWzTmaUg/Ml
         Y9+/qUM6ysrAg==
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        by gnuweeb.org (Postfix) with ESMTPSA id E40A424B3CE
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 19:29:17 +0700 (WIB)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4ff9b389677so4649589e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 05:29:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YxNeaKDRcNe/66XBn7rxfKjKBj+d9KE3bpPC8HThYFNW3F+Q14g
        Y0gAc+t4Cuvj+DAWBfDFhR4EXgYSIkOeGwT7tak=
X-Google-Smtp-Source: AGHT+IGrcLaLCLG88vP8mjhRCYWMTiV3ovLFTX79COkIJnIT7c77MssSK5c20COPTLsafbBN7tVWC9DIlLMNUOTNFHE=
X-Received: by 2002:a05:6512:3da8:b0:500:91ac:c0b5 with SMTP id
 k40-20020a0565123da800b0050091acc0b5mr4565129lfv.30.1693657755557; Sat, 02
 Sep 2023 05:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230902055045.2138405-1-ammarfaizi2@gnuweeb.org>
 <20230902055045.2138405-2-ammarfaizi2@gnuweeb.org> <CAOG64qNw+ZovcC4+5Sqsvi-m=wyoe47eb5K4KAdbO5hcp8ipAA@mail.gmail.com>
 <ZPLR+mO/6/V7wjAJ@biznet-home.integral.gnuweeb.org> <20230902062237.GA23141@1wt.eu>
 <ZPLYRENvjAub3wq5@biznet-home.integral.gnuweeb.org>
In-Reply-To: <ZPLYRENvjAub3wq5@biznet-home.integral.gnuweeb.org>
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Sat, 2 Sep 2023 19:29:04 +0700
X-Gmail-Original-Message-ID: <CAOG64qOuAfHREhcsC3THmhvH+NjhZRJtxp8gG39NosdhbZQvLA@mail.gmail.com>
Message-ID: <CAOG64qOuAfHREhcsC3THmhvH+NjhZRJtxp8gG39NosdhbZQvLA@mail.gmail.com>
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

On Sat, Sep 2, 2023 at 1:38=E2=80=AFPM Ammar Faizi wrote:
> Ok, I'll do that.

Another micro-optimization. Since the likely case is the forward copy,
make it the case that doesn't take the jump.

Pseudo C:
if (unlikely(dst - src < n))
        backward_copy();
else
        forward_copy();

-- Viro
