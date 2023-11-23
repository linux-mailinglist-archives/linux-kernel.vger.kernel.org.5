Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BAF7F66D6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjKWTAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjKWTAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:00:47 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A2CD60
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 11:00:53 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a00cbb83c80so170607066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 11:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700766052; x=1701370852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=717qANo9IFyyNeZDc8GQKEAbOtQz1mcsrQpltrJlB1o=;
        b=Xk7CfAlVyNKkX2Vsz77WJJPRrDVYtTIeRxT7W4JtfD2+wEcdVmDplQWrCZLk3hxycK
         8aiKxPvtMjd7E6Sd0qNILxCNQDVGlEJUroia75Mnm5Txk+2EGLEGmyCWQfsf9ZrdzODW
         glMoWu0iIZimI0zkDDgFPpxKlx1fbP7BlXsCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700766052; x=1701370852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=717qANo9IFyyNeZDc8GQKEAbOtQz1mcsrQpltrJlB1o=;
        b=EK6kH560abzpD0C3YHH/RQIJFjcLqFy97/lGGr6gw9ZzGDG4yj9AmLVPMDki2jmkuO
         V/mAGCuGGJg4J2QftVC7o1Fv+7TaU+jsGHvzQW3AcfIuplK4Dtj/lox7MXnxHhN9c/79
         ZsBo49DZEl60pGVb41zcw6D2UhnJR9t3kYdJYZEaJVFVD5iMi9cHYeTU5QSHQ/AMvnaz
         gxx5TqPYudnJ7hzL22vaTooEj0hZopTuPLGRjYbW8g+sDnYMh44ZZ7V1zfSPIjIgafth
         9EM9nkBRByoKdH8cutniHJYOIK2iteLiqeasym1ShE4b/WlO3ujQthAleQ2YEERpM+cT
         1zbA==
X-Gm-Message-State: AOJu0YySG62DPdCuaehbC+jL9RBd84Fm/DDnYXKz3VZpHIlYWtITZ+r/
        emKni3Y1CWfLriU/jvXDqQX1GeMlCDqPZApYiMGC0CmX
X-Google-Smtp-Source: AGHT+IFPQzSowAd7V/nPo9KdNcP1n0K9G3C1IGmIaq9BAH1lJ+yECBYIj8rxRzRfxSHSuPDZZxX61g==
X-Received: by 2002:a17:906:1f02:b0:9ff:a532:b122 with SMTP id w2-20020a1709061f0200b009ffa532b122mr182236ejj.7.1700766051987;
        Thu, 23 Nov 2023 11:00:51 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709064a4100b009fc3845adc1sm1096040ejv.154.2023.11.23.11.00.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 11:00:51 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so168829466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 11:00:50 -0800 (PST)
X-Received: by 2002:a17:906:6bcd:b0:a03:7de1:374f with SMTP id
 t13-20020a1709066bcd00b00a037de1374fmr179408ejs.25.1700766050187; Thu, 23 Nov
 2023 11:00:50 -0800 (PST)
MIME-Version: 1.0
References: <20231122163700.400507-1-michael.roth@amd.com> <170073547546.398.2637807593174571076.tip-bot2@tip-bot2>
In-Reply-To: <170073547546.398.2637807593174571076.tip-bot2@tip-bot2>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Nov 2023 11:00:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=JDhLdEry=U1-iO1foL_j5T37qVE6_MEHqvj31HO1Lw@mail.gmail.com>
Message-ID: <CAHk-=wg=JDhLdEry=U1-iO1foL_j5T37qVE6_MEHqvj31HO1Lw@mail.gmail.com>
Subject: Re: [tip: x86/mm] x86/mm: Ensure input to pfn_to_kaddr() is treated
 as a 64-bit type
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 at 02:31, tip-bot2 for Michael Roth
<tip-bot2@linutronix.de> wrote:
>
> On 64-bit platforms, the pfn_to_kaddr() macro requires that the input
> value is 64 bits in order to ensure that valid address bits don't get
> lost when shifting that input by PAGE_SHIFT to calculate the physical
> address to provide a virtual address for.

Bah. The commit is obviously fine, but can we please just get rid of
that broken pfn_to_kaddr() thing entirely?

It's a bogus mis-spelling of pfn_to_virt(), and I don't know why that
horrid thing exists. In *all* other situations we talk about "virt"
for kernel virtual addresses, I don't know where that horrid "kaddr"
came from (ie "virt_to_page()" and friends).

Most notably, we have "virt_to_pfn()" being quite commonly used. We
don't even have that kaddr_to_pfn(), which just shows *how* bogus this
whole "pfn_to_kaddr()" crud is.

The good news is that there aren't a ton of users. Anybody willing to
just do a search-and-replace and get rid of this pointless and wrong
thing?

Using "pfn_to_virt()" has the added advantage that we have a generic
implementation of it that isn't duplicated pointlessly for N
architectures, and that didn't have this bug:

  static inline void *pfn_to_virt(unsigned long pfn)
  {
        return __va(pfn) << PAGE_SHIFT;
  }
  #define pfn_to_virt pfn_to_virt

Hmm?

Amusingly (or sadly), we have s390 holding up the flag of sanity, and having

    #define pfn_to_kaddr(pfn)  pfn_to_virt(pfn)

and then we'd only need to fix the hexagon version of that macro
(since Hexagon made its own version, with the old bug - but I guess
Hexagon is 32-bit only and hopefully never grows 64-bit (??) so maybe
nobody cares).

           Linus
