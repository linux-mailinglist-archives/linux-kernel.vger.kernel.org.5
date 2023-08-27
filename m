Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840ED789AC7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 03:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjH0BT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 21:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjH0BTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 21:19:24 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAB51AC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 18:19:22 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76ef80a503fso137351285a.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 18:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693099161; x=1693703961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp+ESFaO17ciDGEN+mq+mjRmACNHCs76UkVT2MyTkeQ=;
        b=Yx/gyxfFaySdVJJ6ImT3+NSyeedlFeg5Gywyq40X1qi7V972U5vh/P6dkFA+prS7/k
         WBk0HZc4MBSnOVFRXex4R+FQ81ITiHyojpSd9dQa79r8ZzcwPvhCvWghJG76Q1gxlR9n
         /cEBssTnwrDbuA+v8c60IpZsko8GA643f/KNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693099161; x=1693703961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cp+ESFaO17ciDGEN+mq+mjRmACNHCs76UkVT2MyTkeQ=;
        b=WdpRDExZXLH4YHLq6rk97iFJOMgZNL/5pArvuybD/JMHSFmkc2ZztehdshPhBmVlEk
         kgctUdT1Fv5Ni49tskVacDFVX9PZ5jPLdlvzxGk3LRCXUjJWi2I3ewVi91T4WXXWLOyS
         YpKgL4v6c2kp9+o+ARwvqhHcqLBuYt2p82+hvb4Qkc9C2LRQskjCfg9F/Tc6gNUZEgnu
         Mzsx6u1lAve7ORj3pFCVQ2ac0yK7h0UewAsOHBuffDRD6YQ4+YtjCT4fHtK3gpjpQy+x
         JUH+GhOxYRPEyzP/UUIqwHhhBLlyc5mcj19oS5XEgrTBqHEtmE7pGOOJ+NsXks0msROF
         78Jw==
X-Gm-Message-State: AOJu0YyfvGF0b7MULEZXvtH8Tbw+k5tllhuWBYPEddJUkHwWh5KAWCUB
        w7lUEf4Fb8u6v31Zr8w/+p6Ot22tuNZlk5dnKDE=
X-Google-Smtp-Source: AGHT+IGbNVaEGFHRDonmgZdHdFDXfcKGTNamCD81jGxxf5LVOS4XlFlr83FXnP3Hid0rWBM929H/Rw==
X-Received: by 2002:a05:620a:2996:b0:76e:f3a3:4ad0 with SMTP id r22-20020a05620a299600b0076ef3a34ad0mr9920159qkp.18.1693099161085;
        Sat, 26 Aug 2023 18:19:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n19-20020a638f13000000b005572d796b9esm4355340pgd.88.2023.08.26.18.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 18:19:19 -0700 (PDT)
Date:   Sat, 26 Aug 2023 18:19:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] coccinelle: semantic patch to check for potential
 struct_size calls
Message-ID: <202308261813.A26FA1A@keescook>
References: <20230227202428.3657443-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227202428.3657443-1-jacob.e.keller@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm sorry I lost this email! I just found it while trying to clean up
my inbox.

On Mon, Feb 27, 2023 at 12:24:28PM -0800, Jacob Keller wrote:
> include/linux/overflow.h includes helper macros intended for calculating
> sizes of allocations. These macros prevent accidental overflow by
> saturating at SIZE_MAX.
> 
> In general when calculating such sizes use of the macros is preferred. Add
> a semantic patch which can detect code patterns which can be replaced by
> struct_size.
> 
> Note that I set the confidence to medium because this patch doesn't make an
> attempt to ensure that the relevant array is actually a flexible array. The
> struct_size macro does specifically require a flexible array. In many cases
> the detected code could be refactored to a flexible array, but this is not
> always possible (such as if there are multiple over-allocations).
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: cocci@systeme.lip6.fr
> Cc: linux-kernel@vger.kernel.org
> 
>  scripts/coccinelle/misc/struct_size.cocci | 74 +++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/struct_size.cocci

Yes! I'd really like to get something like this into the Coccinelle
scripts.

> diff --git a/scripts/coccinelle/misc/struct_size.cocci b/scripts/coccinelle/misc/struct_size.cocci
> new file mode 100644
> index 000000000000..4ede9586e3c6
> --- /dev/null
> +++ b/scripts/coccinelle/misc/struct_size.cocci
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Check for code that could use struct_size().
> +///
> +// Confidence: Medium
> +// Author: Jacob Keller <jacob.e.keller@intel.com>
> +// Copyright: (C) 2023 Intel Corporation
> +// Options: --no-includes --include-headers
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +// the overflow Kunit tests have some code which intentionally does not use
> +// the macros, so we want to ignore this code when reporting potential
> +// issues.
> +@overflow_tests@
> +identifier f = overflow_size_helpers_test;
> +@@
> +
> +f
> +
> +//----------------------------------------------------------
> +//  For context mode
> +//----------------------------------------------------------
> +
> +@depends on !overflow_tests && context@
> +expression E1, E2;
> +identifier m;
> +@@
> +(
> +* (sizeof(*E1) + (E2 * sizeof(*E1->m)))
> +)
> +
> +//----------------------------------------------------------
> +//  For patch mode
> +//----------------------------------------------------------
> +
> +@depends on !overflow_tests && patch@
> +expression E1, E2;
> +identifier m;
> +@@
> +(
> +- (sizeof(*E1) + (E2 * sizeof(*E1->m)))
> ++ struct_size(E1, m, E2)
> +)

Two notes:

This can lead to false positives (like for struct mux_chip) which
doesn't use a flexible array member, which means struct_size() will
actually fail to build (it requires the 2nd arg to be an array).

This can miss cases that have more than a single struct depth (which is
uncommon but happens). I don't know how to match only "substruct.member"
from "ptr->substruct.member". (I know how to match the whole thing[1],
though.)

That isn't reason not to take this patch, though. It's a good start!

Thanks for writing this up!

-Kees

-- 
Kees Cook
