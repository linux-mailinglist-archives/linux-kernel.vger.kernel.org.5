Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CFF7AAC37
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjIVIPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjIVIPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:15:24 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D8D10D3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:05:22 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7740c8509c8so91227485a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695369921; x=1695974721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/V2Z/CslhRzdOA37v4JNp6KEMOkLHqQEJ+zDSTuOdk=;
        b=bbFE+DePofMlgsy3zaPle6NqsXKqRFg/5iMvkjgoMTbrunk5LBmncTvvKe4V6YtkXw
         /Bm5DsAZ0qWJKv4FhBVo3LIuTd7NNvDp0Q+xH23fZIgK4WPQXskbRlTEOeqth5pgI3hx
         0EuMdJzFWcJeloLaaaV4uTOuFKGr/WHHBXqtTKH6oYSOlLXNLrRmtYQWWLmE6rKIq6lf
         JzC72cSpl+RJjITxLIA497BEfPr1l33gmK5o0xaLeAZmLUdA9KZNUrazmiAQgPAAs6L+
         /mo5LQx+YPIpaqZdMfFq75741zsUtFO25I1pZQQNunbtO7ji4mHrVA1DDF5x4SVJpGYk
         md0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695369921; x=1695974721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/V2Z/CslhRzdOA37v4JNp6KEMOkLHqQEJ+zDSTuOdk=;
        b=azxKwXhurgEHwm8bRZ9ACmKh1JnIXDqxmCIsPnqg3etBaDeMi8Q0NVj1obMo3vPPUl
         H9G5imTH+jpvZdZJKkBECDygmoBygz3Sa6tSwJjhEhXRahYBsimKHhv+zvgXRVsHtSQI
         W3efwr8rDImudXBYB3tHLg8VB1lVS2ow7mr7roZRm4z2q1qQZQCcG0bzkCSTD2VSEO2S
         AOcKBT24GqItYhUUiR6fByelYU8qOlo8M4g1eoSKsok98SwltMwhzlgahmba17ZBJW7s
         RDaEfnePK2xKluupUPmdtDT5U4EA4ff8YqEu51CyTNmfR4GGgzbWCqb0v9ZAANW9WWeZ
         ymoA==
X-Gm-Message-State: AOJu0YxQeGwl6niOTlz1y4X6OlnfptbIPcWgviIcd+VESSY5ynL9WGIs
        WgtDcM8kCEya03TL0hvLl5xkBp9O8lNfqxntZSrr8g==
X-Google-Smtp-Source: AGHT+IG/1BlynTCDQl6R37zLFB6GKkkozyqrRx1CXU+MWF4nPBrbcNA0fag78dv2uwHpW2WMA8vdYPndxiUG9OUvxqw=
X-Received: by 2002:a05:6214:3f89:b0:656:46e1:2937 with SMTP id
 ow9-20020a0562143f8900b0065646e12937mr7842623qvb.40.1695369921054; Fri, 22
 Sep 2023 01:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230720173956.3674987-1-glider@google.com> <20230720173956.3674987-4-glider@google.com>
 <ZN+w+RcanPRx5OVZ@arm.com>
In-Reply-To: <ZN+w+RcanPRx5OVZ@arm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 22 Sep 2023 10:04:45 +0200
Message-ID: <CAG_fn=W7VqQukmVqmFiuDyi-osHpbXiRJR0HH0nrDU=GApyBPA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +MTE assigns tags to memory pages: for 4K pages those tags occupy 128 b=
ytes
> > +(256 4-bit tags each corresponding to a 16-byte MTE granule). By defau=
lt, MTE
> > +carves out 3.125% (1/16) of the available physical memory to store the=
 tags.
> > +
> > +When MTE pages are saved to swap, their tags need to be stored in the =
kernel
> > +memory. If the system swap is used heavily, these tags may take a subs=
tantial
> > +portion of the physical memory, which in the case of a zram-backed swa=
p may
> > +even exceed the memory used to store the swapped pages themselves.
>
> Hmm, I'm not sure about this claim ;). Is the zram so good that it
> manages a 32x compression (4096/128)?

For trivial data, like zero pages, this is possible in theory, but I
am not sure whether zram takes advantage of this. I removed the claim
:)

>
> How much would we save if we only do the compression when it can fit in
> 63 bits?

Good question. What I've observed is that soon after boot roughly 50%
of tag buffers can be compressed into 63 bits.


> > +void mte_tags_to_ranges(u8 *tags, u8 *out_tags, unsigned short *out_si=
zes,
> > +                     size_t *out_len)
> > +{
...
> > +}
> > +EXPORT_SYMBOL_NS(mte_tags_to_ranges, MTECOMP);
>
> What's with the exports here? Are we expecting these functions to be
> called from loadable modules?

Yes, this is for the KUnit test module

>
> --
> Catalin



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
