Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0BC780FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378439AbjHRQGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378370AbjHRQGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:06:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC23E42;
        Fri, 18 Aug 2023 09:06:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D66B96229C;
        Fri, 18 Aug 2023 16:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB79C433CB;
        Fri, 18 Aug 2023 16:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692374782;
        bh=EoYVlCSaMjt1FNqDa7AtSicffrGdqGkmFF3s27VbJWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IKiPudNZh1rYFPelfnBrJQyXYPyOaWa15O7WLSHhH3f+8P7j6ndeVeToo2QM27w0M
         e7PvXHStfzUaeSar4K4e4lzZva7h1th9NUB0W1KJ+kz2+37vzQco3IiIEDt2XaeALm
         e2R+k2jaH8ofwu9aifqBWKUTqcyyWmVaf4di7F9Vbfm8bwHVPT6pSjR2eeaf14zgZj
         6KzafLcaV09IL0UAizOy/qjMEdYPbDzjLg8qQr/+LOigfQwj97yi16z3akM5KwNs+2
         0Ui+59gcL0iFsnTtT9LasiBospMLYKywGWdfRvl7eE8Vb+lhFfV2UCm7SPuJsvc60p
         cCJn+JWLYjslw==
Date:   Fri, 18 Aug 2023 17:06:16 +0100
From:   Lee Jones <lee@kernel.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        peng.fan@oss.nxp.com, rafael.j.wysocki@intel.com,
        Jerome Neanne <jneanne@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: Re: [PATCH v2 2/6] mfd: rk8xx: Specify restart mode
Message-ID: <20230818160616.GA986605@google.com>
References: <20230809-pca9450-reboot-v2-0-b98b4f8139d5@skidata.com>
 <20230809-pca9450-reboot-v2-2-b98b4f8139d5@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230809-pca9450-reboot-v2-2-b98b4f8139d5@skidata.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2023, Benjamin Bara wrote:

> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> The current restart handler registration does not specify whether the
> restart is a cold or a warm one. Instead, cold ones are typically
> registered with a HIGH prio. Now, as do_kernel_restart() knows about the
> type, the priorization is implicitly done (cold restarts are executed
> first) and the reboot_mode kernel parameter (which is currently mostly
> ignored) can be respected.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
> v2:
> - improve commit message
> - use registration helper instead
> ---
>  drivers/mfd/rk8xx-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
> index 11a831e92da8..7faf8e1189f7 100644
> --- a/drivers/mfd/rk8xx-core.c
> +++ b/drivers/mfd/rk8xx-core.c
> @@ -696,9 +696,9 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
>  		switch (rk808->variant) {
>  		case RK809_ID:
>  		case RK817_ID:
> -			ret = devm_register_sys_off_handler(dev,
> -							    SYS_OFF_MODE_RESTART, SYS_OFF_PRIO_HIGH,
> -							    &rk808_restart, rk808);
> +			ret = devm_register_cold_restart_handler(dev,
> +								 &rk808_restart,
> +								 rk808);

These wraps are now superfluous.

>  			if (ret)
>  				dev_warn(dev, "failed to register rst handler, %d\n", ret);
>  			break;
> 
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]
