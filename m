Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170CD7560DB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjGQKsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjGQKsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:48:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AAA11C;
        Mon, 17 Jul 2023 03:48:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEA1961022;
        Mon, 17 Jul 2023 10:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAE1C433C8;
        Mon, 17 Jul 2023 10:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689590884;
        bh=JgkDVEQnUcZsTjy93XKQFB/XGARPfZgBaldLVAKREBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LqUU8DAXEdkqhy5bBNxcy4gUOnP3ls2VdQ88D3tVYnKAxRWyLRYfDTaOK1Q2nWgMA
         dorRX4BAdRwvDPGfa7mB5VDQMt+qajE2Amd/S9bj2eCv82uuZQb5TtTBrb0tDwcjZr
         fKpDC1jvqLf3j0G1ZgIIQy2gbqTQG7fdca57N3boL6PeI/LD3CJXYq+3uexgxbbYKj
         DVgfzsHMyW2QXMJwD0Q6HiI7X7K2JuMQqRM6fXTxBvTXS4kqEVdA74Mi4siza8jzkQ
         KwBmDnN9z9p3DzNerMZ5AP5jj3/kAlwrMKYhsr+goZ/k4Rtal8APtJTxie0XWTPjwM
         xcPRnRX5K5mjQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qLLlx-0007Ck-1b;
        Mon, 17 Jul 2023 12:48:10 +0200
Date:   Mon, 17 Jul 2023 12:48:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: camss: Intepret OF graph connections more
 sensibly
Message-ID: <ZLUcaQN6hCjjulTv@hovoldconsulting.com>
References: <20230614-topic-camss_grpah-v2-1-57d9d5e49038@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614-topic-camss_grpah-v2-1-57d9d5e49038@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 05:37:52PM +0200, Konrad Dybcio wrote:
> Not all endpoints of camss have to be populated. In fact, most of the
> time they shouldn't be as n-th auxilliary cameras are usually ewaste.
> 
> Don't fail probing the entire camss even even one endpoint is not
> linked and throw an error when none is found.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes in v2:
> - Use if-else instead of the ternary operator (Bryan)
> - Drop "RFC"
> - Link to v1: https://lore.kernel.org/r/20230614-topic-camss_grpah-v1-1-5f4b516310fa@linaro.org
> ---
>  drivers/media/platform/qcom/camss/camss.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 1ef26aea3eae..8b75197fa5d7 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -1084,9 +1084,8 @@ static int camss_of_parse_ports(struct camss *camss)
>  
>  		remote = of_graph_get_remote_port_parent(node);
>  		if (!remote) {
> -			dev_err(dev, "Cannot get remote parent\n");
> -			ret = -EINVAL;
> -			goto err_cleanup;
> +			of_node_put(node);

This is broken and could potentially lead to a use after free.

Specifically, the iteration macro already takes care of putting this
reference.

> +			continue;
>  		}
>  
>  		csd = v4l2_async_nf_add_fwnode(&camss->notifier,
> @@ -1105,7 +1104,10 @@ static int camss_of_parse_ports(struct camss *camss)
>  		num_subdevs++;
>  	}
>  
> -	return num_subdevs;
> +	if (num_subdevs)
> +		return num_subdevs;
> +
> +	return -EINVAL;

Please change this so that you test for the error condition rather than
its inverse for symmetry. That is

	if (!num_subdevs)
		return -EINVAL;

	return num_subdevs;

Returning EINVAL (invalid argument) is perhaps not the best choice, but
the driver already does so here and in other places so keeping it for
now should be fine.

>  err_cleanup:
>  	of_node_put(node);

Johan
