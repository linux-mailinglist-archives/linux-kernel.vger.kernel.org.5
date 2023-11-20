Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C077F1547
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjKTOHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjKTOH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:07:29 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C1BA0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:07:22 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b587bd1a63so2659873b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700489242; x=1701094042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dtTFOxKWbZfwNolFiplUiXEYr9h+c2cIVO+Z2ob7Zak=;
        b=VLteHyqaHkaCCbKxoRUdUP8u8qj3+D5EonvTxj3anHI3ZA3WQMX4R4RpHBCzQxh+qw
         DXmfyiXJR4I1HeRWx8VDUgsQn3tiYOXTe632VhqMMqP9cCem4MB6SDbSFsCY8AGv3XZY
         0KloY5Nt4OdNylPLprBW+OT723vXuRRZi4Quq0713iZiZXEl6KNJN0pxMc2L3WveepNX
         A7zXtdXe1uWJk9nQS0Sso9c4V6Z731TD4gOtW6PgXVwEEbosk+EMPlLzJJbotbsf4oeh
         kmQmlVOzgYCvvMSLf6vI//itveXYdvy2HzFs5f3Sh+hp/1K5qA7kOZTchwHaLrWKSmhZ
         1hkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700489242; x=1701094042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtTFOxKWbZfwNolFiplUiXEYr9h+c2cIVO+Z2ob7Zak=;
        b=a/F/Z3adm+qt1RwtFnPTdncUQ3V7PCaZoeajRXJmqu8ZvOdGEorqosCpb43CixNSBP
         VH+p/fYnxo3G6Tg65mLFtrpT3DoExWgMCEy4yrTc1q0ID9UkkQTwTTY2tAVSzRkNdXOy
         P+rWQt4952W0OSW4Dfvo6TM0EZqGet24vS2vu+esAySAYHo2bmsc4CHwWpBnxWMkN2JQ
         TsvPgJGWB2+8SbBFvNJjxqKY7QZwVjyRnTKtYJOhV2IkvlwnbtiDsEYKqefbr0NRDYjP
         yq/WVcppqvmOUKyGhxUyepPr4WtzaiNjHfwH11grxpvs2DkoEkkdLmI61vZP7vZFk9K7
         Fzlw==
X-Gm-Message-State: AOJu0Yy+59gi+Uhkc7JbDiZm08l7PzIRRsPbxyuTVffmHZzkNEwJ1oHD
        V+cHYcuCA+7folCbGK9jzpSUlA==
X-Google-Smtp-Source: AGHT+IGKsTGLM718ckD3rnBPLZlMZ9DtHCfdorOXO342ru0cGWgBCz3/aJihfBC2iGk2diECJZvEYw==
X-Received: by 2002:a05:6808:2123:b0:3b2:f344:3a41 with SMTP id r35-20020a056808212300b003b2f3443a41mr3189406oiw.2.1700489241828;
        Mon, 20 Nov 2023 06:07:21 -0800 (PST)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id dd1-20020a056808604100b003a747ea96a8sm1262478oib.43.2023.11.20.06.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 06:07:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r54vo-000Hxj-A2;
        Mon, 20 Nov 2023 10:07:20 -0400
Date:   Mon, 20 Nov 2023 10:07:20 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com, kunwu.chan@hotmail.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Set variable amd_dirty_ops to static
Message-ID: <20231120140720.GB10140@ziepe.ca>
References: <20231120095342.1102999-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120095342.1102999-1-chentao@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 05:53:42PM +0800, Kunwu Chan wrote:
> Fix the followng warning:
> drivers/iommu/amd/iommu.c:67:30: warning: symbol
>  'amd_dirty_ops' was not declared. Should it be static?
> 
> This variable is only used in its defining file, so it should be static.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/iommu/amd/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
