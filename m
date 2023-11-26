Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E087F949E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 18:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjKZRbv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 26 Nov 2023 12:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZRbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 12:31:49 -0500
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA88CB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 09:31:55 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so45588391fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 09:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701019913; x=1701624713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmBLcu5qy11F4jhHivQd10kXFKmqA7ke47zHNPeSxzo=;
        b=IvSggtJYzVbrEjqAXRiaFN1d0pU6JQRMz7b2jzcYB/By5/4+7Zv+HGTu5KvzKGajGg
         IsA94TYcSfw0nIlSeS/evmrjmIVc7D0+AA8ekQO7FlJJPbtfnCxywv/w3Hio/f9m164A
         Fp2zHFaIyAKR6RLhjH++X+zsF4LhmNqpMkwiPSFWFWtcldrVYzsuK8Ypjs4neQMpsL4N
         4NVyAImbvTaTtYoyLLRbXtAC1iJE5VO7jpPbJEqJg1wljQ4WHTbabgJvJb0SYPHzAkLX
         PkKiAjeV0chw/8a6HkDwPDP+/QvEsmMKMFwvjxS//JGGPzabK7it1pLfr1vyP2PWtavc
         vngA==
X-Gm-Message-State: AOJu0Yyqb0bOm9StF+2GqevOVY3BEgJAIyshHFjvZHmHgAMaOBibYdoV
        2PPR4Sv/XoGlYsWt/1BiycIodzg6CSsF721i
X-Google-Smtp-Source: AGHT+IHsjQbxWgSaMmxrUiSJwx1j8w1DJ4tFJhT7v4d05lCFaX99qM8YZrGO+EWVqTfjUoeKpf4XlA==
X-Received: by 2002:a19:ca0f:0:b0:50b:ad16:38f9 with SMTP id a15-20020a19ca0f000000b0050bad1638f9mr1509187lfg.68.1701019913299;
        Sun, 26 Nov 2023 09:31:53 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id u9-20020a170906c40900b009dd98089a48sm4726926ejz.43.2023.11.26.09.31.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 09:31:52 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-54af4f2838dso2915478a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 09:31:52 -0800 (PST)
X-Received: by 2002:a05:6402:31e5:b0:54a:f8e9:a9a8 with SMTP id
 dy5-20020a05640231e500b0054af8e9a9a8mr6153886edb.20.1701019912624; Sun, 26
 Nov 2023 09:31:52 -0800 (PST)
MIME-Version: 1.0
References: <20231126162009.17934-1-sven@svenpeter.dev>
In-Reply-To: <20231126162009.17934-1-sven@svenpeter.dev>
From:   Neal Gompa <neal@gompa.dev>
Date:   Sun, 26 Nov 2023 12:31:15 -0500
X-Gmail-Original-Message-ID: <CAEg-Je_v78nLMYwH4RzZPE__HDc3T9=uu4hVw4wRDDM7A+RFCw@mail.gmail.com>
Message-ID: <CAEg-Je_v78nLMYwH4RzZPE__HDc3T9=uu4hVw4wRDDM7A+RFCw@mail.gmail.com>
Subject: Re: [PATCH] iommu: dart: Use readl instead of readl_relaxed for consistency
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 11:20 AM Sven Peter <sven@svenpeter.dev> wrote:
>
> While the readl_relaxed in apple_dart_suspend is correct the rest of the
> driver uses the non-relaxed variants everywhere and the single
> readl_relaxed is inconsistent and possibly confusing.
>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/iommu/apple-dart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 59cf256bf40f..c7f047ce0a7a 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -1272,7 +1272,7 @@ static __maybe_unused int apple_dart_suspend(struct device *dev)
>         unsigned int sid, idx;
>
>         for (sid = 0; sid < dart->num_streams; sid++) {
> -               dart->save_tcr[sid] = readl_relaxed(dart->regs + DART_TCR(dart, sid));
> +               dart->save_tcr[sid] = readl(dart->regs + DART_TCR(dart, sid));
>                 for (idx = 0; idx < dart->hw->ttbr_count; idx++)
>                         dart->save_ttbr[sid][idx] =
>                                 readl(dart->regs + DART_TTBR(dart, sid, idx));
> --
> 2.34.1
>
>

Reviewed-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
