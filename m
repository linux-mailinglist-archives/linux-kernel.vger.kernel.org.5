Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3662B75A210
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjGSWiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjGSWiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:38:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD96E1FF1;
        Wed, 19 Jul 2023 15:38:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4224061865;
        Wed, 19 Jul 2023 22:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CB7C433C8;
        Wed, 19 Jul 2023 22:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689806280;
        bh=EYIsH0FwwvOCjfNVFrFmOo04loqux7S4hzWOngeGK28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2ZZlkaqbXqF5tCghFIQGbme+X094m6Q36ydxZchLOHFmaoFOxrTqy3gTmsntLEf5
         40k1+d//K6T+P96Ud5fThiaE37vYNP4ib2jS8rgwNxSRD7qfnHQNSf+ssRSncrdRxw
         q3nnYllnDdl4NTIos9eUrE7RVICCv+PhuhqI/WQSC6kzkVIDK/e841OpV+ZDsUGWib
         vNvIhkE0qe20iOcT1LfrIkD7/DP2L1rwnALZsSNX8o1CpevEAtmgdYjMnYfbohFD6E
         iFl1IZ0bArsBaQuBEjMYCBu/mTC6fczJSwdEa8oVp41EUGFboEBxWZm1ps8uFj7wQs
         lGCMrdQHjymCw==
Received: (nullmailer pid 897856 invoked by uid 1000);
        Wed, 19 Jul 2023 22:37:58 -0000
Date:   Wed, 19 Jul 2023 16:37:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 02/14] of: property: Add fw_devlink support for
 msi-parent
Message-ID: <20230719223758.GA892809-robh@kernel.org>
References: <20230719113542.2293295-1-apatel@ventanamicro.com>
 <20230719113542.2293295-3-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719113542.2293295-3-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 05:05:30PM +0530, Anup Patel wrote:
> This allows fw_devlink to create device links between consumers of
> a MSI and the supplier of the MSI.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/of/property.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index ddc75cd50825..e4096b79a872 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1325,6 +1325,37 @@ static struct device_node *parse_interrupts(struct device_node *np,
>  	return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args.np;
>  }
>  
> +static struct device_node *parse_msi_parent(struct device_node *np,
> +					    const char *prop_name, int index)
> +{
> +	struct of_phandle_args sup_args;
> +	struct device_node *msi_np;
> +
> +	if (!IS_ENABLED(CONFIG_OF_IRQ))
> +		return NULL;

Why do we need this? Sparc is not going to have MSI properties to begin 
with. I guess it saves a little bit of code. Though Sparc doesn't need 
any of this file. Or maybe there's a better kconfig symbol to use here 
if MSIs are not supported?

> +
> +	if (strcmp(prop_name, "msi-parent"))
> +		return NULL;
> +
> +	msi_np = of_parse_phandle(np, prop_name, 0);
> +	if (msi_np) {
> +		if (!of_property_read_bool(msi_np, "#msi-cells")) {
> +			if (index) {
> +				of_node_put(msi_np);
> +				return NULL;
> +			}
> +			return msi_np;
> +		}
> +		of_node_put(msi_np);
> +	}
> +
> +	if (of_parse_phandle_with_args(np, prop_name, "#msi-cells", index,
> +				       &sup_args))
> +		return NULL;
> +
> +	return sup_args.np;
> +}
> +
>  static const struct supplier_bindings of_supplier_bindings[] = {
>  	{ .parse_prop = parse_clocks, },
>  	{ .parse_prop = parse_interconnects, },
> @@ -1359,6 +1390,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
>  	{ .parse_prop = parse_regulators, },
>  	{ .parse_prop = parse_gpio, },
>  	{ .parse_prop = parse_gpios, },
> +	{ .parse_prop = parse_msi_parent, },
>  	{}
>  };
>  
> -- 
> 2.34.1
> 
