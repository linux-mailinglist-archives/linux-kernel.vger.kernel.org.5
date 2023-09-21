Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E8A7A9E40
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjIUT7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjIUT6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:58:55 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200B659164
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:28:35 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c135cf2459so8216091fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695317313; x=1695922113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TyP2lCq/bSVDqnymObET8LaEFUP8CozqrWimSDgxYug=;
        b=ZPha1WglicKW3NhmpkFinBGovRPnAnut6/+5aw+ys2hDwVs/7ZW6shT0TbYeFVJJxW
         iU+/lmzJg/QuvD+JZrJWwlICoXCQBBiCRht2/n0XlqiqhWma4GbAgQwly/NGUO3YDMhC
         NXQF/qTWGr8juoHND84RQbsQ6gGw4hog4pW2AmlNC/qifjFkNTrF7uOnwM5ElkJjHHOC
         BYQ7L+zxPMMWXPMDzYUA6AoNLOd6iPdEj9V9vhDpxv8blOwggFLBEsDgyjRZ7O2QXokj
         2/9HADR5s9/2phJiXHgawcIfHb3jX+6Hp4V/xEPqYvpVNFuzEm6rimAeGk+suPhL64rC
         4psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317313; x=1695922113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyP2lCq/bSVDqnymObET8LaEFUP8CozqrWimSDgxYug=;
        b=PrSjuB4mczQOrNWQ/RuDyn7b6N8/JAyQ1tFUo+YGfYb2lwlYlunzDvHk1sQODMzRuo
         cpXgFDFMr+kydse6di127n7huD1mbwd23ninN2RjJiK1tIshIfg4cBPV5GGlET1YpnHH
         uyeM3McpGkA2YPPfREfdSGdAcV6UFYlqDDUIOoXzh6Q6O6IUZtpOBCmY+Tf75UURexMR
         JzD8nfW+xp+LwA5rVFzPsI5qJa67jm2Lf7R5mPyj3fQWf0cwp8f3ysEbPFqdC4136Lt5
         IteMgZwhJ8nn9HzN085RQ8qlFpdzwM42CIEWBEj0eg9WXFyhGvx8aEKAaizY3EBXC4Il
         EkSw==
X-Gm-Message-State: AOJu0YwsrBMAjScUv8mFzKnU0JPNysstNSb6pSymzAumWt0615wMEwc0
        1ba5eLN0WAAE5VJPlluAq61zINQakm598Th+wdY=
X-Google-Smtp-Source: AGHT+IH7MKMHV9VB90sQpv2wzEE59MEaGFNnOBSPTzvhLiKFZK1jcxpcDDQfJlGWhkCqwWfQwxUiEQ==
X-Received: by 2002:a05:6512:2109:b0:503:c45:a6e9 with SMTP id q9-20020a056512210900b005030c45a6e9mr4537033lfr.39.1695297789448;
        Thu, 21 Sep 2023 05:03:09 -0700 (PDT)
Received: from localhost (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id c19-20020a056402121300b0052e9b50dafdsm732376edw.33.2023.09.21.05.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 05:03:07 -0700 (PDT)
Date:   Thu, 21 Sep 2023 14:03:05 +0200
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V2] spi: spi-cadence-quadspi: Fix missing unwind goto
 warnings
Message-ID: <ZQww+c0JIP/EqsXT@suswa>
References: <20230919074658.41666-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919074658.41666-1-d-gole@ti.com>
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_PASS,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 01:16:59PM +0530, Dhruva Gole wrote:
> The following smatch warnings [0] were recently introduced:
> 
> drivers/spi/spi-cadence-quadspi.c:1882 cqspi_probe() warn: missing
> unwind goto?
> 
> Fix these warnings by releasing dma channel and adding a goto fail probe.
> 
> [0] https://lore.kernel.org/all/5e21c351-cd08-443e-8509-aecf242a4da9@kadam.mountain/

Really this should be the Closes: link.  I should edit the zero day
bot emails to send the correct link.

That's going to be slightly more complicated than you might assume...

I'm travelling now so I won't do it today.

regards,
dan carpenter

> 
> Fixes: 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202309140543.03dMbMM5-lkp@intel.com/
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> 
> Link to V1:
> https://lore.kernel.org/all/20230915123103.2493640-1-d-gole@ti.com/
> 

