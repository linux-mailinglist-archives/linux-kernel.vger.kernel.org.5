Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4DF7A1466
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjIODaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjIODaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:30:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6586270C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:29:58 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68fc081cd46so1629865b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694748598; x=1695353398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=foL7uPoELeXThgRtp4NfsBE8jbNLcnM/fz3r3P9dwSA=;
        b=Xm4TIlGgBMVG7YlREoLQzquxcoBJm/KxFvp+4caFPtBleVC4FkMHfR3D3E91bqlfT/
         8JTQcWZogEbjgVmxwBBWwpeytVEFWKU8fSUvLfCAWqvbWkvusRhICBKV2nN9n/zu5Xgb
         8k34S2IJVe19M6JdTfoTUWQmU8JVoaBY9G/sA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694748598; x=1695353398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foL7uPoELeXThgRtp4NfsBE8jbNLcnM/fz3r3P9dwSA=;
        b=HOydgMOMQyZ2yXLHe/bUJl6U68TRdFMOAK57zWfQS2W7iNLFqcwzrUxYHS4PvCIj0I
         aEnP4f36fsQ8kSOGa4KUzOXEqjHqrlhWq+4ElKjm4ikUoDk4xKhNZxrkA5QOcXiJLuul
         KtzMq1I8vD+5aRDBHMvQsNMInq/wz3gnkc3z96Qi3x3B6FHt8g9TVwZRz8aYcwA9MjnY
         znwFkGuMWbymY+Jkj8or6UxEOpI1fSU2JTRL6ksEHIMepdOQ+wsnzyQ1beLY9xrEV5XZ
         Olj2cUVlmpBFwc1MwdnoQGVcFZdZklz0DU1CTGEoMZ7YweZqfoMq7sksMJMu9u7xJaec
         SGcw==
X-Gm-Message-State: AOJu0YwhCMgYlJ5VI3gj/tNRADdHP/6Ob13BoJD+PQVm1gLox87z6viO
        Ug7sJ3t0sYQLeSCNnRm2LtJKzA==
X-Google-Smtp-Source: AGHT+IFUiPPqwu1gNzFfL58DjBiKY5tF49qfpn5IiLp2dlsbMFFWxYolo8hGE+rNBbs9Q0R7lVX1cg==
X-Received: by 2002:a05:6a20:5659:b0:140:a6ec:b56a with SMTP id is25-20020a056a20565900b00140a6ecb56amr602604pzc.3.1694748598402;
        Thu, 14 Sep 2023 20:29:58 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902748500b001a5fccab02dsm2339310pll.177.2023.09.14.20.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:29:57 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:29:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] RDMA/core: Use size_{add,mul}() in calls to
 struct_size()
Message-ID: <202309142029.D432EEB8C@keescook>
References: <ZP+if342EMhModzZ@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP+if342EMhModzZ@work>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 05:27:59PM -0600, Gustavo A. R. Silva wrote:
> Harden calls to struct_size() with size_add() and size_mul().

Specifically, make sure that open-coded arithmetic cannot cause an
overflow/wraparound. (i.e. it will stay saturated at SIZE_MAX.)

> 
> Fixes: 467f432a521a ("RDMA/core: Split port and device counter sysfs attributes")
> Fixes: a4676388e2e2 ("RDMA/core: Simplify how the gid_attrs sysfs is created")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> Changes in v2:
>  - Update changelog text: remove the part about binary differences (it
>    was added by mistake).
> 
>  drivers/infiniband/core/sysfs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
> index ee59d7391568..ec5efdc16660 100644
> --- a/drivers/infiniband/core/sysfs.c
> +++ b/drivers/infiniband/core/sysfs.c
> @@ -903,7 +903,7 @@ alloc_hw_stats_device(struct ib_device *ibdev)
>  	 * Two extra attribue elements here, one for the lifespan entry and
>  	 * one to NULL terminate the list for the sysfs core code
>  	 */
> -	data = kzalloc(struct_size(data, attrs, stats->num_counters + 1),
> +	data = kzalloc(struct_size(data, attrs, size_add(stats->num_counters, 1)),
>  		       GFP_KERNEL);
>  	if (!data)
>  		goto err_free_stats;
> @@ -1009,7 +1009,7 @@ alloc_hw_stats_port(struct ib_port *port, struct attribute_group *group)
>  	 * Two extra attribue elements here, one for the lifespan entry and
>  	 * one to NULL terminate the list for the sysfs core code
>  	 */
> -	data = kzalloc(struct_size(data, attrs, stats->num_counters + 1),
> +	data = kzalloc(struct_size(data, attrs, size_add(stats->num_counters, 1)),
>  		       GFP_KERNEL);
>  	if (!data)
>  		goto err_free_stats;
> @@ -1140,7 +1140,7 @@ static int setup_gid_attrs(struct ib_port *port,
>  	int ret;
>  
>  	gid_attr_group = kzalloc(struct_size(gid_attr_group, attrs_list,
> -					     attr->gid_tbl_len * 2),
> +					     size_mul(attr->gid_tbl_len, 2)),
>  				 GFP_KERNEL);
>  	if (!gid_attr_group)
>  		return -ENOMEM;
> @@ -1205,8 +1205,8 @@ static struct ib_port *setup_port(struct ib_core_device *coredev, int port_num,
>  	int ret;
>  
>  	p = kvzalloc(struct_size(p, attrs_list,
> -				attr->gid_tbl_len + attr->pkey_tbl_len),
> -		    GFP_KERNEL);
> +				size_add(attr->gid_tbl_len, attr->pkey_tbl_len)),
> +		     GFP_KERNEL);
>  	if (!p)
>  		return ERR_PTR(-ENOMEM);
>  	p->ibdev = device;
> -- 
> 2.34.1
> 

-- 
Kees Cook
