Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0D379DA99
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjILVN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjILVN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:13:56 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3FA10CC;
        Tue, 12 Sep 2023 14:13:52 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qgAhe-0007po-1g;
        Tue, 12 Sep 2023 21:13:46 +0000
Date:   Tue, 12 Sep 2023 22:13:35 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/2] mfd: syscon: allow reset control for syscon
 devices
Message-ID: <ZQDUf3BkFUNsNqF7@makrotopia.org>
References: <20230105005010.124948-1-jk@codeconstruct.com.au>
 <20230105005010.124948-3-jk@codeconstruct.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105005010.124948-3-jk@codeconstruct.com.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

On Thu, Jan 05, 2023 at 08:50:10AM +0800, Jeremy Kerr wrote:
> Simple syscon devices may require deassertion of a reset signal in order
> to access their register set. Rather than requiring a custom driver to
> implement this, we can use the generic "resets" specifiers to link a
> reset line to the syscon.
> 
> This change adds an optional reset line to the syscon device
> description, and deasserts the reset if detected.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> ---
> v2:
>  * do reset control in the early of_syscon_register() path, rather than
>    the platform device init, which isn't used.
> v3:
>  * use a direct reset_control_deassert rather than handling in the
>    regmap
> v4:
>  * collapse unnecessary `else` block
> ---
>  drivers/mfd/syscon.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index bdb2ce7ff03b..57b29c325131 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -20,6 +20,7 @@
>  #include <linux/platform_data/syscon.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/reset.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/slab.h>
>  
> @@ -31,6 +32,7 @@ static LIST_HEAD(syscon_list);
>  struct syscon {
>  	struct device_node *np;
>  	struct regmap *regmap;
> +	struct reset_control *reset;

You are reserving a field 'reset' in this struct but then never use it.
I stumbled upon this because I was wondering if it'd make sense to have
something like

int syscon_reset(struct syscon *syscon)
{
	if (!syscon->reset)
		return -EOPNOTSUPP;

	return reset_control_reset(syscon->reset);
}

But then, of course, why not have syscon_reset_assert, *_deassert, ... ?
Wrapping the reset control ops, of course, would have the advantage the
syscon driver would be able to track whether reset is asserted.

However, making the reset shared also allows the syscon user to use the
reset as well and is mich easier to implement:

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 57b29c3251312..55f3f855f0305 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -32,7 +32,6 @@ static LIST_HEAD(syscon_list);
 struct syscon {
 	struct device_node *np;
 	struct regmap *regmap;
-	struct reset_control *reset;
 	struct list_head list;
 };
 
@@ -130,15 +129,16 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 				goto err_attach_clk;
 		}
 
-		reset = of_reset_control_get_optional_exclusive(np, NULL);
+		reset = of_reset_control_get_shared(np, NULL);
 		if (IS_ERR(reset)) {
 			ret = PTR_ERR(reset);
-			goto err_attach_clk;
+			if (ret != -ENOENT)
+				goto err_attach_clk;
+		} else {
+			ret = reset_control_deassert(reset);
+			if (ret)
+				goto err_reset;
 		}
-
-		ret = reset_control_deassert(reset);
-		if (ret)
-			goto err_reset;
 	}
 
 	syscon->regmap = regmap;
---

Let me know what you think.


>  	struct list_head list;
>  };
>  
> @@ -40,7 +42,7 @@ static const struct regmap_config syscon_regmap_config = {
>  	.reg_stride = 4,
>  };
>  
> -static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
> +static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
>  {
>  	struct clk *clk;
>  	struct syscon *syscon;
> @@ -50,6 +52,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  	int ret;
>  	struct regmap_config syscon_config = syscon_regmap_config;
>  	struct resource res;
> +	struct reset_control *reset;
>  
>  	syscon = kzalloc(sizeof(*syscon), GFP_KERNEL);
>  	if (!syscon)
> @@ -114,7 +117,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  		goto err_regmap;
>  	}
>  
> -	if (check_clk) {
> +	if (check_res) {
>  		clk = of_clk_get(np, 0);
>  		if (IS_ERR(clk)) {
>  			ret = PTR_ERR(clk);
> @@ -124,8 +127,18 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  		} else {
>  			ret = regmap_mmio_attach_clk(regmap, clk);
>  			if (ret)
> -				goto err_attach;
> +				goto err_attach_clk;
>  		}
> +
> +		reset = of_reset_control_get_optional_exclusive(np, NULL);
> +		if (IS_ERR(reset)) {
> +			ret = PTR_ERR(reset);
> +			goto err_attach_clk;
> +		}
> +
> +		ret = reset_control_deassert(reset);
> +		if (ret)
> +			goto err_reset;
>  	}
>  
>  	syscon->regmap = regmap;
> @@ -137,7 +150,9 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  
>  	return syscon;
>  
> -err_attach:
> +err_reset:
> +	reset_control_put(reset);
> +err_attach_clk:
>  	if (!IS_ERR(clk))
>  		clk_put(clk);
>  err_clk:
> @@ -150,7 +165,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  }
>  
>  static struct regmap *device_node_get_regmap(struct device_node *np,
> -					     bool check_clk)
> +					     bool check_res)
>  {
>  	struct syscon *entry, *syscon = NULL;
>  
> @@ -165,7 +180,7 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
>  	spin_unlock(&syscon_list_slock);
>  
>  	if (!syscon)
> -		syscon = of_syscon_register(np, check_clk);
> +		syscon = of_syscon_register(np, check_res);
>  
>  	if (IS_ERR(syscon))
>  		return ERR_CAST(syscon);
> -- 
> 2.38.1
> 
