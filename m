Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13BD7D8533
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345324AbjJZOtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbjJZOtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:49:50 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D975C1705
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:49:24 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7788ebea620so76775785a.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698331763; x=1698936563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/HMCohvCVUItBLSF49y4DS1f8h5XhHVmI3a8fPrH4+E=;
        b=16LZ6Jv3dCZJ/Fg6NaWqLUcU62gRAH19jnoAkh1QUK56NddZENOIIyTzQCahlGK3rG
         v91ddSoySBvA+v7d8Pmduu5a2yaHip0fwf5bIJpmkjYCKZOKEc0XET24X98+gzBARPiT
         qXzetYXchm1QukxbOhPEObUQKkyJ1E3jXBnAphYj2FKvqv3gNqB7/HjLGmHbvjMIbxoO
         hYBIB0NY1DjlQkgxBpFIT4p1tV1ZUssBAXGTFZPdxC079k1u1AoGohJI1ClMfPTFhy/B
         NjcHYj0h2q2PHHTv9C86BMCp/QrJr4oTwQBHiLXLwAWpLUts2SnghoORIwlVu+n8LO1l
         aImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698331763; x=1698936563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HMCohvCVUItBLSF49y4DS1f8h5XhHVmI3a8fPrH4+E=;
        b=djSQ2XO2fPG6OQzARrCCQUn1wniuMh1bFCn774lQzk5S8seElN4OJbiE3NuSEdXruY
         XlA9T+hnNwVAH8qZJLHMX1Lsllz32eSe6QwERj6YDNAzFUSrWr06+gp3XroAdmWHS5uH
         So9B6R1lGLxZtXC8i8kHfWvih/k++zv1heUi7cY7YqHD52E2JIkPmokykFLWr5JarCEE
         Cj9IAMnTeHe3C8sA0lZ4eGcoKT02WhcnAvgHPcoJfosPn/f8njIE9SBEL4I/sSFRqQOi
         t6vFN3FKiz/Fu4OY6TM+OVS9pNcng1vv4S/IiNjfxBK4uD2bnUeZ5BfQpu2U7pr0A3wq
         Ie0g==
X-Gm-Message-State: AOJu0YytpqLU8JFGjc+PGpINPSf8OPrm8nW/r1zUDcvIGZTAj5H0W22q
        GbL3ST1tZ82TKDxKoiWJmCLiYdHRTATHfYTD4tybnA==
X-Google-Smtp-Source: AGHT+IEIC7Z+z102uc46/c6ZE8FUnXFStsvrJayHmo6CykcpNg2r/g0g+Q9GDObPHilkMEyrCGAv2BxUwmOjSFJpfQw=
X-Received: by 2002:a05:6214:5093:b0:66d:2eb6:f3f6 with SMTP id
 kk19-20020a056214509300b0066d2eb6f3f6mr22576167qvb.32.1698331762820; Thu, 26
 Oct 2023 07:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231026135912.1214302-1-glider@google.com> <ZTp2oLST3nR9AZk4@smile.fi.intel.com>
In-Reply-To: <ZTp2oLST3nR9AZk4@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 26 Oct 2023 16:48:46 +0200
Message-ID: <CAG_fn=VSYNk=k1kqKo1vQ7Bd87x9evy6GQBfjdNatOp51x8DZQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] lib/bitmap: add bitmap_{read,write}()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
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

>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> One nit below, though.
>
> ...
>
> > +/**
> > + * bitmap_write - write n-bit value within a memory region
> > + * @map: address to the bitmap memory region
> > + * @value: value to write, clamped to nbits
> > + * @start: bit offset of the n-bit value
> > + * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG.
> > + *
> > + * bitmap_write() behaves as-if implemented as @nbits calls of __assign_bit(),
> > + * i.e. bits beyond @nbits are ignored:
> > + *
> > + *   for (bit = 0; bit < nbits; bit++)
> > + *           __assign_bit(start + bit, bitmap, val & BIT(bit));
> > + *
> > + * For @nbits > BITS_PER_LONG no writes are performed.
>
> nbits == 0 hasn't been mentioned.

I can mention it explicitly, but it is already covered by the for-loop
above: if nbits==0, no bits are assigned.

>
> (no, the main nit below)
>
> > + */
> > +static inline void bitmap_write(unsigned long *map,
> > +                             unsigned long value,
> > +                             unsigned long start, unsigned long nbits)
>
> While noticing strange indentation (you have space for the parameter on
> the previous line,

I believe I do not, maybe that's something on your side?
There are tabs in the source, and in the original email.

> I realized that this is a counter-intuitive interface.
> Can you actually make value the last parameter?

It is consistent with bitmap_set_value8(map, value, start), and in all
the functions above @nbits is the last parameter.
