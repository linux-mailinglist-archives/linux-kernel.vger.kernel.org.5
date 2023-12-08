Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68F580ADDD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574710AbjLHUb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHUbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:31:24 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EAD10E0;
        Fri,  8 Dec 2023 12:31:31 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6d99c3a3a32so1609470a34.3;
        Fri, 08 Dec 2023 12:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702067490; x=1702672290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/vkRtHrUIhvNc94dHT+mJMxUllgbpAsI47gfQ/WkWg=;
        b=UrUOGgaxOZ0waFajGSZz0mNt+fd88JZZxqGK4IKjDHj3/S5PeVU3OLRBL3qSqS4trq
         LUGKoBJu1SuVH0E6pbGxp9g0IYTa3BHiqGAtUBMg6n9EhILi7kF7F4W5lpZ+uhDsRbfc
         n37B82P77O3q85PMym1tfPhY+ad7EfKLQdFGrMX3SGxuP28k8Utvhn4n4NXxTUZhcS27
         GEVhorSyXD575k128S0zLgKDditrQVJsDsLjvVLJZO4CZrWnkrTZQlmODly62GmqmFY/
         UMpYOpK/B6kbIQmKZm9tb7EzA/UBukSBxW8yojSYgU+n0zJHetbWULTcDqs1AhLH2Yh8
         Oj8A==
X-Gm-Message-State: AOJu0YxzXaa1bUQE8YXBH6jUPtgYaSOL6UtGwW1vVixZH/YupOMmW/+D
        aoEv/xfHDqwGqzTMuZ2rDndNnpFpYQ==
X-Google-Smtp-Source: AGHT+IGdbIgqxhhBryWL51enlE+vHu8xlkBOQlHT46ZUQRPrYupw+SdR5iu5LYZkdMIkEC4J7Fmh0g==
X-Received: by 2002:a05:6830:1093:b0:6d9:d689:cd18 with SMTP id y19-20020a056830109300b006d9d689cd18mr635893oto.36.1702067490639;
        Fri, 08 Dec 2023 12:31:30 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c9-20020a056830000900b006d87b167c41sm432894otp.8.2023.12.08.12.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 12:31:30 -0800 (PST)
Received: (nullmailer pid 2653738 invoked by uid 1000);
        Fri, 08 Dec 2023 20:31:28 -0000
Date:   Fri, 8 Dec 2023 14:31:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pintu Kumar <quic_pintu@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, pintu.ping@gmail.com
Subject: Re: [PATCH] of: reserved_mem: fix error log for reserved mem init
 failure
Message-ID: <20231208203128.GA2646347-robh@kernel.org>
References: <20231206151600.26833-1-quic_pintu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206151600.26833-1-quic_pintu@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 08:46:00PM +0530, Pintu Kumar wrote:
> During fdt_init_reserved_mem() when __reserved_mem_init_node()
> fail we are using pr_info to print error.
> 
> So, if we change the loglevel to 4 (or below), this error
> message will be missed.
> 
> Thus, change the pr_info to pr_err for fail case.
> 
> Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> ---
>  drivers/of/of_reserved_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 7ec94cfcbddb..473665e76b6f 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -334,7 +334,7 @@ void __init fdt_init_reserved_mem(void)
>  		if (err == 0) {
>  			err = __reserved_mem_init_node(rmem);
>  			if (err != 0 && err != -ENOENT) {
> -				pr_info("node %s compatible matching fail\n",
> +				pr_err("node %s compatible matching fail\n",

Isn't the message just wrong. If compatible match fails, we return 
ENOENT. The failure here would be from the init function.

>  					rmem->name);
>  				if (nomap)
>  					memblock_clear_nomap(rmem->base, rmem->size);
> -- 
> 2.17.1
> 
