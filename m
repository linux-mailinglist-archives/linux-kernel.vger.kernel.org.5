Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A62975CDF6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjGUQQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjGUQPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:15:54 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286D13C3D;
        Fri, 21 Jul 2023 09:15:12 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-78654448524so91760139f.2;
        Fri, 21 Jul 2023 09:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689956111; x=1690560911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UN38LW4zyrB67GHxIyM5/PZR9y0nR4K1jRGOtGjbhZ4=;
        b=ooDeCS1g2KxixIooM5qzNESfw9+HymNift3o8gM/sqe9EuRh7974w/FCGcPJM1ArSQ
         JHnyg+AvA8w3VYGoR3sGlx0NvxBWJemtkNceP6YmlCW2pmq7dp4902v9LWnfOvTWxwXE
         RUKMhVEi6x9wRs8kXDhRtBHBP4ONJtNKkfB75CtpnfGj5y5S1J87txGsqAyvs301QOrF
         EeEIpKJCGWpTAXRneYzx4K7+DH3sursxW48jQroriFM07k6qLdO0AGiweJ9nBAOqpvR/
         uxir0ju6TRYPKg6lDMg+QxjbAAmcHTJBh2MIVI5yGAbZyfjx7DASJrmoG3F4j1rfST6E
         jwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689956111; x=1690560911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UN38LW4zyrB67GHxIyM5/PZR9y0nR4K1jRGOtGjbhZ4=;
        b=lLbK+YF5GVGt7IYd8ID4RcBYE6V+DNtOQTdXNp6gods7OajRTomuum/GkL4jqTWWM/
         ++y92/iV2IMnGhGXzU/KDTdSLuwZ/+P0nmHndVlAKIOjpM2bZVH7oP75pF/HMYf9jGmc
         ryPUzaZl+i4mW1E8snaOpClTPwpLsUt/zoW+bLpcp2EJ77RjmoxVxK1UYPddGo1O+ixl
         +1SwLNwOXoAdIa6OtZT0BJQ/6SvdIHJhfi4Pc50nYnatj8aJNhYWZEsf/tkA18mafFnw
         P5Pskserdb2DPxWRZWPRygqDPX8PVivRQHb1PNlJwhdETvp1fpJEZReisyvloz39+5Rj
         HMHA==
X-Gm-Message-State: ABy/qLZB2p8m4exIKCZylo+oAxXVuCIhzPeRWjjd4T0+j26ZrD25dnFA
        Glaw/yh09WGpuIhpFQxY6YU=
X-Google-Smtp-Source: APBJJlGbgfScEbLyFOrC5y+mjOmztQ+E7YlL4sK2cWTLINX40nD5KSePjMly1W+eJTMPBdbhDWFMqw==
X-Received: by 2002:a05:6602:38a:b0:774:8f64:82a8 with SMTP id f10-20020a056602038a00b007748f6482a8mr468418iov.18.1689956111214;
        Fri, 21 Jul 2023 09:15:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z13-20020a5ec90d000000b0078647b08ab0sm1162012iol.6.2023.07.21.09.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:15:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 21 Jul 2023 09:15:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>
Subject: Re: [PATCH 2/2] clk: Introduce kunit wrapper around
 __clk_determine_rate
Message-ID: <a03ae5b7-9235-40a7-9e29-9033678ffea0@roeck-us.net>
References: <20230721-clk-fix-kunit-lockdep-v1-0-32cdba4c8fc1@kernel.org>
 <20230721-clk-fix-kunit-lockdep-v1-2-32cdba4c8fc1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721-clk-fix-kunit-lockdep-v1-2-32cdba4c8fc1@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 09:09:33AM +0200, Maxime Ripard wrote:
> Some kunit tests are meant to test the behaviour of providers but don't
> run those functions with the clk prepare_lock held which results in
> lockdep warning.
> 
> __clk_determine_rate is one of the functions being executed from a test
> which should have the lock held. Let's introduce a wrapper around it
> meant to be used only by kunit tests.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/linux-clk/2b594e50-2bbf-4a2d-88e6-49fc39f3957a@roeck-us.net/
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Link: https://lore.kernel.org/oe-lkp/202301310919.b9d56ee3-yujie.liu@intel.com
> Fixes: 262ca38f4b6e ("clk: Stop forwarding clk_rate_requests to the parent")
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/clk/clk.c            | 25 +++++++++++++++++++++++++
>  drivers/clk/clk_test.c       |  2 +-
>  include/linux/clk-provider.h | 10 ++++++++++
>  3 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 8ee9bd02af76..8fdbfec6bd85 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1669,6 +1669,31 @@ int __clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
>  }
>  EXPORT_SYMBOL_GPL(__clk_determine_rate);
>  
> +#if IS_ENABLED(CONFIG_KUNIT)
> +/**
> + * __clk_kunit_determine_rate - get the closest rate actually supported by a clock
> + * @hw: determine the rate of this clock
> + * @req: target rate request
> + *
> + * Useful for clk_ops such as .set_rate and .determine_rate. Only usable
> + * in a kunit test context. Use __clk_determine_rate() otherwise.
> + */
> +int __clk_kunit_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
> +{
> +	int ret;
> +
> +	if (!kunit_get_current_test())
> +		return -EINVAL;
> +
> +	clk_prepare_lock();
> +	ret = __clk_determine_rate(hw, req);
> +	clk_prepare_unlock();
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(__clk_kunit_determine_rate);
> +#endif
> +
>  /**
>   * clk_hw_round_rate() - round the given rate for a hw clk
>   * @hw: the hw clk for which we are rounding a rate
> diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
> index a64f7036baa3..b835e08892b4 100644
> --- a/drivers/clk/clk_test.c
> +++ b/drivers/clk/clk_test.c
> @@ -2232,7 +2232,7 @@ static void clk_leaf_mux_set_rate_parent_determine_rate(struct kunit *test)
>  
>  	clk_kunit_init_rate_request(hw, &req, DUMMY_CLOCK_RATE_2);
>  
> -	ret = __clk_determine_rate(hw, &req);
> +	ret = __clk_kunit_determine_rate(hw, &req);
>  	KUNIT_ASSERT_EQ(test, ret, 0);
>  
>  	KUNIT_EXPECT_EQ(test, req.rate, DUMMY_CLOCK_RATE_2);
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index efdebfa3fce9..43049f2c1dd2 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -1352,6 +1352,16 @@ void clk_hw_get_rate_range(struct clk_hw *hw, unsigned long *min_rate,
>  void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
>  			   unsigned long max_rate);
>  
> +#if IS_ENABLED(CONFIG_KUNIT)
> +int __clk_kunit_determine_rate(struct clk_hw *hw, struct clk_rate_request *req);
> +#else
> +static inline int __clk_kunit_determine_rate(struct clk_hw *hw,
> +					     struct clk_rate_request *req)
> +{
> +	return -ENOENT;
> +}
> +#endif
> +
>  static inline void __clk_hw_set_clk(struct clk_hw *dst, struct clk_hw *src)
>  {
>  	dst->clk = src->clk;
> 
> -- 
> 2.41.0
> 
