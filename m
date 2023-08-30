Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB8B78DB82
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238964AbjH3Sjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245750AbjH3QLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:11:32 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F355198
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693411889;
        bh=pLOKt2kvMiazDndB8CsqMBCoLURktb9taQtXoSw3vVQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=C2sqw7Zx/A71FKGI2EcmN867FNA3yTRoc2tbu7FiJhMQiy9/xyWfenR2XK5qaMa3P
         x8SPw5wLbt5YlaFc6mXp/4y9lalct9uVs2YxVdX4jlg0oY/H6Byl9v1/u7zPZElE8I
         tL3JS3k7+U9zo3ni8eWjE7uhzuLbG7bODf5jgUoFE00u8MZzBrbhKOE49B/sRxWYWU
         ms/h5jiMd7jWYO93FfnY/IeQyZ8rzXP9jtLn4ndiFeRWczGOZIJQBiid+VwkoP4RQY
         iWH+BriKK6SjLL4jmYkG/sF/pDlSA89fan1/q0PUu2EWVWpgULNp04uOLZC/KbSLTF
         HO8+1McM/V4Yw==
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        by gnuweeb.org (Postfix) with ESMTPSA id 0A6DE24B34B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 23:11:29 +0700 (WIB)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so88697381fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:11:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YyqHdG0nfea72aC4QXLHrVsUXcuzVAfJK0MEY4a6YZKD14XxTqM
        GevNlpCToSOpbHZGMbqn5zk6CL/4muz06qq6yxI=
X-Google-Smtp-Source: AGHT+IE6JCWxr1GWlCZqGELsACZg2tv6XK3Abfeydq9E8xGsuQmh8OSccMCBu/R30yXZOTnQOyftmpewZnxz/eIc8u4=
X-Received: by 2002:a05:6512:31c8:b0:4f8:7897:55e6 with SMTP id
 j8-20020a05651231c800b004f8789755e6mr2285663lfe.45.1693411886874; Wed, 30 Aug
 2023 09:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
 <20230830135726.1939997-3-ammarfaizi2@gnuweeb.org> <CAOG64qNGdPjXHTvrpYxjizOYvMRaB9_2t2raw6DJ3kK852KUHg@mail.gmail.com>
 <ZO9bv+GvgpphtGEi@biznet-home.integral.gnuweeb.org> <ZO9e6h2jjVIMpBJP@1wt.eu>
 <ZO9j9WhSj7PmsM8b@biznet-home.integral.gnuweeb.org> <ZO9lmGoMDh10jdsk@1wt.eu> <ZO9phB2Ehukb1kab@biznet-home.integral.gnuweeb.org>
In-Reply-To: <ZO9phB2Ehukb1kab@biznet-home.integral.gnuweeb.org>
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Wed, 30 Aug 2023 23:11:15 +0700
X-Gmail-Original-Message-ID: <CAOG64qOtLzZQvB1Lsa6N8HvOHRar8fa7uwhOCe=MP4y5Ow-nzw@mail.gmail.com>
Message-ID: <CAOG64qOtLzZQvB1Lsa6N8HvOHRar8fa7uwhOCe=MP4y5Ow-nzw@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:08=E2=80=AFPM Ammar Faizi wrote:
> On Wed, Aug 30, 2023 at 05:51:52PM +0200, Willy Tarreau wrote:
> >     xchg %eax, %esi      1
> >     push %rdx            1
> >     pop %rcx             1
> >     push %rdi            1
> >     rep movsb            2 [sic]
> >     pop %rax             1
> >     ret                  1
> >     ------------- Total: 8 bytes :-)

That's beautiful!

-- Viro
