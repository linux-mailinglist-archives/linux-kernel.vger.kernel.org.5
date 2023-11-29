Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD53E7FD7D5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjK2NVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjK2NVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:21:30 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A37BA8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:21:36 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3316d3d11e1so571302f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701264094; x=1701868894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LxnwmsnLa+zjyTvJgxXUCowe3oX5PXSw6duoQ6d9X54=;
        b=jloCmk7Il+eVCUvsK5TCN5TnpUAAX6bIl334mTOpoImgRjUP2UFGcH8fSv6ZwDAQiv
         YwZRE7/uolQe4bbFilTciqvH248fVpLZ4mWu409QnlLOPZ8ohWIS9wxhoMwfzJFmbWhy
         /NArQvwghJ1UgzwZ9f5KCWu3az1gWu7e4YqFHGDB9GDp1GMOUWB/8I9PD2K+pDuPKNSe
         Fjyn72juOkNbA1FiDxv1Dghc5LN0GZ7ZZKLXZN9/+8Q4etZfed5Cpk02SyPnyaKq9eGq
         bJBpNlk6OEIjcZaG8UM0zjKVXJNWJ/STuZCKwOif+wa8BVzSkgm1iCvpajBpQEXXmoLo
         MJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701264094; x=1701868894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxnwmsnLa+zjyTvJgxXUCowe3oX5PXSw6duoQ6d9X54=;
        b=m/btiMUuNnGKgq4waH4bwfIYxEz5ny3sA0QWpqVb4oeTX6R3m66NMVI15ROSmX/IY8
         P5bEfXs0hVCFZ5efjDSuYAVIGR1yxlEwF5gpY0gA1cnh2ENmym8pna3GFLL4izTBk/vh
         9j48ysyKFrYtHjuIMMcqyPimS65t4sj9/FeJSmIO3xFf0e6rfTTEleS6M88aSqTYvhpN
         P4ALghzs7WXqc6/zkjqhAu0OY38oFyYPMaIJyta6uYXObsxOjDZv5loOz6JsO+NJjvGn
         4UgBKaxiJL+knwO0FyS43nq1/a/y1HD+71JfF0l1idFlW+gzfBSZ8ZzPwi2UyDfNci70
         QV4A==
X-Gm-Message-State: AOJu0YwKNCk19Vb9vsaJazkN02eB/B2UGcW8vCAMXhPHRMehorxJQ7Om
        PoKZy3cWrcHn0Dze3/kFG6+qtA==
X-Google-Smtp-Source: AGHT+IE3QkuinWthwHM4v+mpRfOYIx4YIZdPpX9q/wg8fV/SchAUWX3HGJqx55OjKN5baf6RzeEI4g==
X-Received: by 2002:adf:f682:0:b0:333:145a:4883 with SMTP id v2-20020adff682000000b00333145a4883mr2592094wrp.25.1701264094628;
        Wed, 29 Nov 2023 05:21:34 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c3ac400b0040b538047b4sm2099039wms.3.2023.11.29.05.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 05:21:34 -0800 (PST)
Date:   Wed, 29 Nov 2023 16:21:31 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     James Tai <james.tai@realtek.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v3 2/6] irqchip: Add interrupt controller support for
 Realtek DHC SoCs
Message-ID: <8f87bfca-ab5f-4b32-a400-a90d09b64cf1@suswa.mountain>
References: <20231129054339.3054202-1-james.tai@realtek.com>
 <20231129054339.3054202-3-james.tai@realtek.com>
 <d94c79bf-04c4-4e87-bd7e-a8755508ac89@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d94c79bf-04c4-4e87-bd7e-a8755508ac89@suswa.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 11:21:06AM +0300, Dan Carpenter wrote:
> > +int realtek_intc_probe(struct platform_device *pdev, const struct realtek_intc_info *info)
> > +{
> > +	struct realtek_intc_data *data;
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *node = dev->of_node;
> > +	int ret, i;
> > +
> > +	data = devm_kzalloc(dev, struct_size(data, subset_data, info->cfg_num), GFP_KERNEL);
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	data->base = of_iomap(node, 0);
> > +	if (!data->base) {
> > +		ret = -ENOMEM;
> > +		goto out_cleanup;
> 
> devm_ allocations are cleaned up automatically so there is no need to
> call devm_kfree() before returning.
> 
> regards,
> dan carpenter
> 
> > +	}
> > +
> > +	data->info = info;
> > +
> > +	raw_spin_lock_init(&data->lock);
> > +
> > +	data->domain = irq_domain_add_linear(node, 32, &realtek_intc_domain_ops, data);

Btw, as I was testing the other static checker warning for <= 0, my
static checker really wants this irq_domain_add_linear() to be cleaned
up on the error path.

Otherwise it probably leads to a use after free because we free data
(automatically or manually) but it's still on a list somewhere.

> > +	if (!data->domain) {
> > +		ret = -ENOMEM;
> > +		goto out_cleanup;
> > +	}
> > +
> > +	data->subset_data_num = info->cfg_num;
> > +	for (i = 0; i < info->cfg_num; i++) {
> > +		ret = realtek_intc_subset(node, data, i);
> > +		if (ret) {
> > +			WARN(ret, "failed to init subset %d: %d", i, ret);
> > +			ret = -ENOMEM;
> > +			goto out_cleanup;

This error path.

regards,
dan carpenter


> > +		}
> > +	}
> > +
> > +	platform_set_drvdata(pdev, data);
> > +
> > +	return 0;
> > +
> > +out_cleanup:
> > +
> > +	if (data->base)
> > +		iounmap(data->base);
> > +
> > +	devm_kfree(dev, data);
> > +
> > +	return ret;
> > +}
