Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D937AB629
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjIVQlC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 22 Sep 2023 12:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjIVQlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:41:00 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3FEA1;
        Fri, 22 Sep 2023 09:40:53 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so8611596a12.1;
        Fri, 22 Sep 2023 09:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695400851; x=1696005651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLMEZvzr2hDeQFoHwg/p7D4qUJztpTY+iNBV1OWqyi4=;
        b=VRqCEvdkdB7dMQHE3daKmLc70sUwDHr4mKUtr+DqWbseLGV5C+EXxtVewjvlGd3oIF
         gdIaU8OO+tZJsUrJnvabAhE9+OEPmjp5Zi2VDGbBEDirSpAgqZoblWnW7laRr93GbImf
         8FszLqXhEud2sU4i+o5IRu9MQ7nlnh9EJoR3gulDEVZkRGVGpHqJLeSL7FJeKacEHxSs
         sesrUy9Yog/9abhuP4t6uVjmsh1+35ii88DKZKe8zpe0kuafcfcJCUahoEmOTOafTU6s
         8yI9zMJEl6MIE4J9htAaeYuDNo0JZI1UNT/nsBnAKw9n+J5/Z0SOdO/Z6R+BOtOXvylk
         F9CA==
X-Gm-Message-State: AOJu0Yz4tAkfPDpb+xwig/7u9ADnslpc/OfZ2gUwuiWrS/fHnWqZAql1
        gFO7cZgBdBCOF1UnnLiZsuYBq5IfSIsp9kUQ
X-Google-Smtp-Source: AGHT+IFPdiTAh0/3s6KCHWLWOyGFRE/c3a1Vt4BnO1YeVs8ODIqgULL0EFbkD2peWHdIy0y4SyLZ0w==
X-Received: by 2002:a17:906:53ca:b0:9ae:699d:8a31 with SMTP id p10-20020a17090653ca00b009ae699d8a31mr299449ejo.33.1695400850821;
        Fri, 22 Sep 2023 09:40:50 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id l15-20020a1709067d4f00b009920a690cd9sm2931908ejp.59.2023.09.22.09.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 09:40:50 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-532addba879so6151274a12.0;
        Fri, 22 Sep 2023 09:40:49 -0700 (PDT)
X-Received: by 2002:a05:6402:5c4:b0:530:8fdb:39c8 with SMTP id
 n4-20020a05640205c400b005308fdb39c8mr4374304edx.15.1695400848925; Fri, 22 Sep
 2023 09:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230922-iommu-type-regression-v2-1-689b2ba9b673@marcan.st>
In-Reply-To: <20230922-iommu-type-regression-v2-1-689b2ba9b673@marcan.st>
From:   Neal Gompa <neal@gompa.dev>
Date:   Fri, 22 Sep 2023 12:40:12 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8b-gJZDs5Q6n=XgU5xyPWiJ3utX9yf0DPN5bfLqUx4PA@mail.gmail.com>
Message-ID: <CAEg-Je8b-gJZDs5Q6n=XgU5xyPWiJ3utX9yf0DPN5bfLqUx4PA@mail.gmail.com>
Subject: Re: [PATCH REGRESSION v2] iommu/apple-dart: Handle DMA_FQ domains in attach_dev()
To:     Hector Martin <marcan@marcan.st>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, stable@vger.kernel.org,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:55 AM Hector Martin <marcan@marcan.st> wrote:
>
> Commit a4fdd9762272 ("iommu: Use flush queue capability") hid the
> IOMMU_DOMAIN_DMA_FQ domain type from domain allocation. A check was
> introduced in iommu_dma_init_domain() to fall back if not supported, but
> this check runs too late: by that point, devices have been attached to
> the IOMMU, and apple-dart's attach_dev() callback does not expect
> IOMMU_DOMAIN_DMA_FQ domains.
>
> Change the logic so the IOMMU_DOMAIN_DMA codepath is the default,
> instead of explicitly enumerating all types.
>
> Fixes an apple-dart regression in v6.5.
>
> Cc: regressions@lists.linux.dev
> Cc: stable@vger.kernel.org
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Fixes: a4fdd9762272 ("iommu: Use flush queue capability")
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
> Changes in v2:
> - Fixed the issue in apple-dart instead of the iommu core, per Robin's
>   suggestion.
> - Link to v1: https://lore.kernel.org/r/20230922-iommu-type-regression-v1-1-1ed3825b2c38@marcan.st
> ---
>  drivers/iommu/apple-dart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 2082081402d3..0b8927508427 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -671,8 +671,7 @@ static int apple_dart_attach_dev(struct iommu_domain *domain,
>                 return ret;
>
>         switch (domain->type) {
> -       case IOMMU_DOMAIN_DMA:
> -       case IOMMU_DOMAIN_UNMANAGED:
> +       default:
>                 ret = apple_dart_domain_add_streams(dart_domain, cfg);
>                 if (ret)
>                         return ret;
>
> ---
> base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
> change-id: 20230922-iommu-type-regression-25b4f43df770
>
> Best regards,
> --
> Hector Martin <marcan@marcan.st>
>

Looks good to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
