Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79167811D52
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379079AbjLMStb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjLMSt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:49:29 -0500
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F13D0;
        Wed, 13 Dec 2023 10:49:36 -0800 (PST)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ce72730548so6500761b3a.1;
        Wed, 13 Dec 2023 10:49:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493375; x=1703098175;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYvsi1BeF9vZr5nFKSjT9VCibEudQ5MsSdiBfCjNBkM=;
        b=AZVviE69W6AAA66gdQ9Fnq+6GinI1VM9AW1s10B47JDHiMNu4KxPJcxW4zLYOdkB/c
         BDIOf97FNX+XWDryud4mf9f+8O41f6va3hHoVK77/71Qf8Cudm22R1gKWlVzwzqPI1Cy
         R7L4Q90c2ZK4jqgwtSNti4638X7uzN9LniWpbzPyjn6Ft1xLfAOdWmQGUTIDpnnhxNL2
         CkE1JBIIBtkghtZpUFzC+MhPIM2FLqUZWLlJmrHT+OImrTsEQmdJWqu+6c6OkHlnlvrw
         YR0+9N9GZCnOLgn8DjpSD4jrQh6kKuaYRyzAOY8zdbbNZhFEekopXZlK6e+sGT/UQ84y
         YgHQ==
X-Gm-Message-State: AOJu0YyoOshyRuZ1kakWXLOsfCIif5HJko+jumbEXKK3hgGA1rfLKKfS
        F13vfJkA6D3col8/H5Fvcro=
X-Google-Smtp-Source: AGHT+IHbTzuBKGDSYgmQol7b/mqaHA3bV6bgpiSsqgzYkZOWUq77+BmvHTJKWeODi3tFFMrCo/GAJQ==
X-Received: by 2002:a05:6a00:2d9d:b0:6cd:d639:b353 with SMTP id fb29-20020a056a002d9d00b006cdd639b353mr10248064pfb.18.1702493375559;
        Wed, 13 Dec 2023 10:49:35 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id o73-20020a62cd4c000000b006c875abecbcsm10687034pfg.121.2023.12.13.10.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:49:34 -0800 (PST)
Date:   Thu, 14 Dec 2023 03:49:33 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] PCI: epf-mhi: Simulate async read/write using iATU
Message-ID: <20231213184933.GB924726@rocinante>
References: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
 <20231127124529.78203-5-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231127124529.78203-5-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Even though iATU only supports synchronous read/write, the MHI stack may
> call async read/write callbacks without knowing the limitations of the
> controller driver. So in order to maintain compatibility, let's simulate
> async read/write operation with iATU by invoking the completion callback
> after memcpy.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 34e7191f9508..7214f4da733b 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -234,6 +234,9 @@ static int pci_epf_mhi_iatu_read(struct mhi_ep_cntrl *mhi_cntrl,
>  
>  	mutex_unlock(&epf_mhi->lock);
>  
> +	if (buf_info->cb)
> +		buf_info->cb(buf_info);
> +
>  	return 0;
>  }
>  
> @@ -262,6 +265,9 @@ static int pci_epf_mhi_iatu_write(struct mhi_ep_cntrl *mhi_cntrl,
>  
>  	mutex_unlock(&epf_mhi->lock);
>  
> +	if (buf_info->cb)
> +		buf_info->cb(buf_info);
> +
>  	return 0;
>  }

Looks good!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
