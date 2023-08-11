Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3B77797DF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbjHKTja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjHKTj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:39:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEDD30EC;
        Fri, 11 Aug 2023 12:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1D5467963;
        Fri, 11 Aug 2023 19:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC39FC433C7;
        Fri, 11 Aug 2023 19:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691782767;
        bh=KlwAT+8owcpMdnQoWuulieq8nFxzS2oyPEO3DiXeFW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z3nihHLjbHFVoqzDHPMTR4ppsDou+K/fjjJuT5oZdZMs/DYOIS1/IwrEUdK5EoDrN
         JeHk9ib8CYs5KMnBmxm51fYJAZKclwJqM5Lx90sZk0+LY+h/dzVZe78pBRPAPoAOLB
         3vOc2yoXidHXB0O/tDsEFbgijkGn5nAbzqJwmpAEUAM/TUBKfR+HAQGycUJbcsZWWP
         5I/chqhcVJFEXjX6EdiUT0OppW+ZkTmOzYpxR32+5gm0B/+9lf3tuYxS6E2Fkp7ZaH
         CNr98EKkPM4glQLedBrXXxlgprlRTUnrsdCa8Ia6/NWMg/MTkgKcr9ITk34gxMEK+D
         8M6XHbiI449Rw==
Received: (nullmailer pid 4003553 invoked by uid 1000);
        Fri, 11 Aug 2023 19:39:24 -0000
Date:   Fri, 11 Aug 2023 13:39:24 -0600
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
Subject: Re: [PATCH v7 02/15] of: property: Add fw_devlink support for
 msi-parent
Message-ID: <20230811193924.GA3997669-robh@kernel.org>
References: <20230802150018.327079-1-apatel@ventanamicro.com>
 <20230802150018.327079-3-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802150018.327079-3-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 08:30:05PM +0530, Anup Patel wrote:
> This allows fw_devlink to create device links between consumers of
> a MSI and the supplier of the MSI.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/of/property.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index ddc75cd50825..bc20535deed7 100644
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
> +	if (IS_ENABLED(CONFIG_SPARC))
> +		return NULL;
> +
> +	if (strcmp(prop_name, "msi-parent"))
> +		return NULL;
> +
> +	msi_np = of_parse_phandle(np, prop_name, 0);
> +	if (msi_np) {
> +		if (!of_property_read_bool(msi_np, "#msi-cells")) {

Use of_property_present() to check presence.

However, this check is wrong. #msi-cells is optional and assumed to be 0 
if not present. There's another flavor of of_parse_phandle_with_args() 
that allows specifying a default cell count, so I think you can get rid 
of all this checking.

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
