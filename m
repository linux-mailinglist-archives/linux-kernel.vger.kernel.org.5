Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3914D77892C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbjHKIsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjHKIsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:48:15 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F344530CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:48:13 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-26b139f4e42so761520a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691743693; x=1692348493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mzkwugj1PfTeot/Ydyi6lk+WxY0NfpqlNKrsXkBIvGI=;
        b=L2Wz9cSaAPuEQ2M96YRMRXQ7OJmYTKQ48tlpEk97VycEYlIyCPBQMbmSjU8JjpmbDv
         cA/oBkRkS7yp2miiqDnNkES9M0snc3KrF37reGRYMVRWFKkYjdefAqhWRJR3SMPqkA1u
         tQtfyRznHJMGuAkDilGnwlKEulICp3FUCCRJ/dwoOqAIp9iq3ytCNDQn1LMssav4b/Gm
         dq5ptZzBlMlYQ0/1WnB/8f5cF2O3ojRzfmE7zSlmip1ubuz7+LTciM9NuD1WNJZhpyuz
         aWB3BsJjG/l+44dM63FdBG3pL7bYJ23ReHuqVX6MsBvkEBlVe76h5zEVOzomSkMo4QFe
         QGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691743693; x=1692348493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mzkwugj1PfTeot/Ydyi6lk+WxY0NfpqlNKrsXkBIvGI=;
        b=LlIhRhWcGnMt992tPcXD3MJnHTHS5CE+s0PirDsosQiPIK7RGGsRZWazQhXIwP8kis
         reNcUWSafGdb9SUZ9cEajjUhbe3eAb8p8E7YWeXsOds1r5Wz7IgJJhahzgXVJ1ynVUl8
         K6axVQSNF+i74i6fm7/0SmfyV21CR+rkgibfAT8hWlGDe3QCJn9jeOJ9I3pdrUhbRuyr
         idK0lGMt9o+D6JANoL3uM6ozOGZFyfJlZdi6ZatNDqTNFuDoiuFu6uq/lNFuMAE/yJ22
         2ML5U+82gHks4tVD8CbgZs9VRP4Ow1P0aGv3W9pwjmXj2h7Xo4hG7Rz8lGi0QISuf9oU
         NVNQ==
X-Gm-Message-State: AOJu0YxMHydx2T7X8rRrrHHkbwhsZYm9VdN+t67yftuHiPS4ubNRcZcx
        9ymPZzmnrV00F25wZ6Rggg+iTGssUcs0hxbykwJ2Tw==
X-Google-Smtp-Source: AGHT+IEbXd3helfDGF+1zEut3HY4vYqFAHIR1HibHpSVXAbT6qyF2FndVTqIoVXYavjwX4yzCJPwUIopcKcIN/Dl5HA=
X-Received: by 2002:a17:90b:17cb:b0:268:21f0:65e7 with SMTP id
 me11-20020a17090b17cb00b0026821f065e7mr540847pjb.49.1691743693392; Fri, 11
 Aug 2023 01:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230811062738.1066787-1-anshuman.khandual@arm.com>
In-Reply-To: <20230811062738.1066787-1-anshuman.khandual@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 11 Aug 2023 09:48:02 +0100
Message-ID: <CAJ9a7Vhh95jMmfKeD40n88GXf3iYC3Hv6y1KJxEYnsKAkem7gQ@mail.gmail.com>
Subject: Re: [PATCH] coresight: etm4x: Ensure valid drvdata and clock before clk_put()
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 at 07:27, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> This validates 'drvdata' and 'drvdata->pclk' clock before calling clk_put()
> in etm4_remove_platform_dev(). The problem was detected using Smatch static
> checker as reported.
>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lists.linaro.org/archives/list/coresight@lists.linaro.org/thread/G4N6P4OXELPLLQSNU3GU2MR4LOLRXRMJ/
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on coresight-next
>
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 703b6fcbb6a5..eb412ce302cc 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -2269,7 +2269,7 @@ static int __exit etm4_remove_platform_dev(struct platform_device *pdev)
>                 etm4_remove_dev(drvdata);
>         pm_runtime_disable(&pdev->dev);
>
> -       if (drvdata->pclk)
> +       if (drvdata && drvdata->pclk && !IS_ERR(drvdata->pclk))
>                 clk_put(drvdata->pclk);
>
>         return 0;
> --
> 2.25.1
>

Reviewed-by: Mike Leach <mike.leach@lnaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
