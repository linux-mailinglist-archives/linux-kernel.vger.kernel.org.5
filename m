Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D17766C76
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbjG1MEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjG1MDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:03:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7B24C0A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:03:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so20502895e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690545787; x=1691150587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cFEa9MMxPQK3mIe8y2ZSoEZucFBC9apzwzTZ2gpfxUg=;
        b=WOWvFttnchRa1YQWyMjh/IMy1E+sMabw0JaGJJvGCydS8dFaH3Z5BvL0a8M9/Gaqlm
         bU9weHP63TkAt1c9UbvTR1qpReKo/6gk/bWTzDvBzX3qyOKbobVMQskfyOzyHWzAPBdV
         5Xq3fsXeRm60AcWT2yOmlpIwSSN61VV2cId7aJ6uuaGSbPrvVec2ylqpViKMtyKB6h6f
         Ip85NgpHLr8vq8hU9ATm2AvYJImuRAtKyClPjMdxwHQOekq6jaYiYIvfSdeojTQ0dx/W
         g/pw1K/sGQHOXEcklE82JNXjXNTVPTQeR5yDr7rL2oRV8qlAc64F6bDb63CsfrPNNnEo
         /etA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690545787; x=1691150587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFEa9MMxPQK3mIe8y2ZSoEZucFBC9apzwzTZ2gpfxUg=;
        b=k+2VL9LXvJhm2ERc0yGV2AUY+QyZ3esA/BF4Hyi+MnM+6qUxk4YmkCSxm5bvIZ+RtF
         gltW/FdcawisnaqeGP5Zl4n6yBk4zG3bbLpxADuoCEAJH+0HmhZWsgxkEq/K49R2vCCk
         hcHx/vN6g8ExailQ8hc1rwHiHVI6VvmI15Vmz/jZemYBKMWXo/aIe5Jfy11uqAcP2ba+
         Vcn1fLlRf8Sb1VWH5mMdUjljdT9dk+eWBPuLi4ogOblZg/4FwliP3Kq1M7FpGDpWYa9Y
         /TvSKPWRBUbvI/NMhnJD1eMUXzGr8c+H8Q1XqIPG1bS7hXCJBE00ekfn8Vn3qTdEv/dv
         Ovcg==
X-Gm-Message-State: ABy/qLZhsBWfQOy1W8WJ2gWMyaatHX2A5uue1iqMxOIdLSe1yMXHCol2
        ZXyqqxay2Y0kwljs+lRGGOsjUA==
X-Google-Smtp-Source: APBJJlFBGflVyFrjukz9iK7ViiC7zKdOrBH5MmpCzudJpRLM2ZSR4SRJiG1L0RI1UeK1rfUMzqHF3A==
X-Received: by 2002:a7b:c4d4:0:b0:3fc:85c:5ef7 with SMTP id g20-20020a7bc4d4000000b003fc085c5ef7mr1524091wmk.22.1690545786731;
        Fri, 28 Jul 2023 05:03:06 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g17-20020adfe411000000b0031437299fafsm4692479wrm.34.2023.07.28.05.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 05:03:06 -0700 (PDT)
Date:   Fri, 28 Jul 2023 15:03:03 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        patchwork-jzi@pengutronix.de, kernel@pengutronix.de,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] drm/panel-simple: allow LVDS format override
Message-ID: <1cd00596-604d-4fbf-b9d1-9ee0f05cb373@kadam.mountain>
References: <20230523-simplepanel_support_nondefault_datamapping-v3-0-78ede374d3d9@pengutronix.de>
 <20230523-simplepanel_support_nondefault_datamapping-v3-3-78ede374d3d9@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523-simplepanel_support_nondefault_datamapping-v3-3-78ede374d3d9@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 01:54:40PM +0200, Johannes Zink wrote:
> @@ -556,7 +602,7 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
>  	struct device_node *ddc;
>  	int connector_type;
>  	u32 bus_flags;
> -	int err;
> +	int err, ret;

I don't like this at all...

>  
>  	panel = devm_kzalloc(dev, sizeof(*panel), GFP_KERNEL);
>  	if (!panel)
> @@ -601,6 +647,13 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
>  			panel_simple_parse_panel_timing_node(dev, panel, &dt);
>  	}
>  
> +	if (desc->connector_type == DRM_MODE_CONNECTOR_LVDS) {
> +		/* Optional data-mapping property for overriding bus format */
> +		ret = panel_simple_override_nondefault_lvds_datamapping(dev, panel);
> +		if (ret)
> +			goto free_ddc;

This *looks* like we are returning an error but we aren't.  I think we
should be.  If not then we need to have a discussion about that and
add some comments.

regards,
dan carpenter

> +	}
> +
>  	connector_type = desc->connector_type;
>  	/* Catch common mistakes for panels. */
>  	switch (connector_type) {
> 
> -- 
> 2.39.2
