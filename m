Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969AD7A8666
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbjITOXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjITOXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:23:38 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA42AC6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:23:31 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-79d1a920137so153191239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695219811; x=1695824611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ukh8ZYDZxvX82LAHODROHiMYMv5lCVVYc8LANKub40=;
        b=kFEcw3wGbpXHgOkomTnM6RvVR5NU6pwZgim0jcjudWdA7aR9b/j2AZXr9ekA4v4w5z
         IFP2YtAiOVL8ln626EUFhdXOvPhfNu5sOIVnu/pfRw84nfXecJEkYMnC0WcImqc5s27u
         ++PKT5nSf4hadOXr7SxCbbN+YptMwrb5JNi4TjTOeh+AxeMV1AzLqwM/KuYWRiAcCQBs
         OLZU9CY0LTnQn1DlTMt6XnKm/P5DeRXHmoniRcXwUdqPshrIQvwNiZrvNDaXhcpalkSh
         omJaYLuGN8+Q47Wr/w7rmdgX8+gplTmXtYBJWrKPClDgkm5bDtcgv3L3QZ3F715U2g52
         S85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695219811; x=1695824611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ukh8ZYDZxvX82LAHODROHiMYMv5lCVVYc8LANKub40=;
        b=YLHAJbt8ABWlsHVlL3DdvOhWEz8f04Xu1ixc2M5C+X/2w1vp3IlZmNufC9taiLf8A6
         Y7yQFa1EXjrd25J/WDCOVGalYvgb+6UuZRzUoSSQ55myZvhaaqG3b/hPXx4QaiR5lzUs
         IVJIXYSl+G8iTd/7Wj2wLDHZwRkQFnQVWAh2XL4Neoh4xxX+YB0uFHd7mc38YCJhrjXu
         fCoHV6hwPLfB4CY00Vs2Z3DiqHt6h/+OLK65XJKOdkGKyVTAxHZT8k2SXD4xeoi6xa6R
         qAUV2fE7wIVDCLncQcFepps92+03wYjsY9/S45UsO3h6papcu2GUPXN5KGigbQccnDJY
         /Ecg==
X-Gm-Message-State: AOJu0YyfaXkUbv6SiERZmbWJoErHcRc9nbVG5F8cj26kaewstSMmnXEw
        6c9CPz56VmGrmmgaUYRZf4zm1HxClJLIn6Wtfu6yaQ==
X-Google-Smtp-Source: AGHT+IH786PMfu/2ZDO0ah5PqQNGFON0xE7cEusEQ12eCapSDhxeEImhk1Q1t1OugLU5Q85QLRIn3e3pTJBA63sieJ4=
X-Received: by 2002:a5d:9384:0:b0:791:1739:d525 with SMTP id
 c4-20020a5d9384000000b007911739d525mr2617835iol.20.1695219810990; Wed, 20 Sep
 2023 07:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230720173956.3674987-1-glider@google.com> <20230720173956.3674987-6-glider@google.com>
 <ZN+13iQ4oOgpKhNO@arm.com>
In-Reply-To: <ZN+13iQ4oOgpKhNO@arm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 20 Sep 2023 16:22:51 +0200
Message-ID: <CAG_fn=U+ozF0nwTun=DDLHQzPwBQv6hgn-U+e=-vBGHkKbDyeA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] arm64: mte: add compression support to mteswap.c
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Anyway, it would be nice to see the full picture of what the savings
> relative to the total RAM is. Given that the swap in this instance is
> zram, you have an upper bound of how many pages it can store. I'm just
> trying to assess whether the complexity added here is worth it.
Assuming the average compression rate of 2.5x, and the share of tagged
pages being 20%, we'll be saving 0.375% of the swapped memory:
  20% / 32 * (2.5-1)/2.5
With the compression rate of 4x and 40% of PROT_MTE pages, that would
be 0.9375%, which is tens of megabytes (probably still a little
though).

>
> Maybe not as good as the RLE algorithm here, I was wondering whether we
> could use zswap to save the tags together with the page. I looked some
> time ago at it seemed slightly easier for zswap than zram.

Android uses zram, so unfortunately we'll need to handle both.

> Another
> option is to make the swap format more generic to support metadata
> storage. Yet another option is for the zram to flag that it can compress
> the metadata together with the data (no swap format change needed; when
> decompressing the page, it populates the tags as well).

I haven't looked into this, but this might sound promising. We'll have
to copy the page contents to a temporary buffer holding both the page
data and the metadata, but it might be ok.

Another idea you've mentioned in one of the other patches is to only
compress the data if it fits into 63 bits.
Looks like this alone could yield 2x+ compression for 4K pages, and
will spare us the kmem cache juggling in this patch series.


> --
> Catalin



--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
