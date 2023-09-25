Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA417AD3FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjIYJAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjIYJAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:00:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8D86100;
        Mon, 25 Sep 2023 02:00:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC8A11424;
        Mon, 25 Sep 2023 02:00:41 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A02E83F5A1;
        Mon, 25 Sep 2023 02:00:00 -0700 (PDT)
Date:   Mon, 25 Sep 2023 09:59:58 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, Alan Ma <tech@biqu3d.com>,
        Luke Harrison <bttuniversity@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rogerio Goncalves <rogerlz@gmail.com>,
        Martin Botka <martin@biqu3d.com>
Subject: Re: [PATCH 4/6] cpufreq: sun50i: Add H616 support
Message-ID: <20230925095958.746d3f69@donnerap.manchester.arm.com>
In-Reply-To: <20230904-cpufreq-h616-v1-4-b8842e525c43@somainline.org>
References: <20230904-cpufreq-h616-v1-0-b8842e525c43@somainline.org>
        <20230904-cpufreq-h616-v1-4-b8842e525c43@somainline.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2023 17:57:04 +0200
Martin Botka <martin.botka@somainline.org> wrote:

Hi Martin,

> AllWinner H616 SoC has few revisions that support different list
> of uV and frequencies.
> 
> Some revisions have the same NVMEM value and thus we have to check
> the SoC revision from SMCCC to differentiate between them.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 149 ++++++++++++++++++++++++++++-----
>  1 file changed, 126 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index 4321d7bbe769..19c126fb081e 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -10,6 +10,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/arm-smccc.h>
>  #include <linux/cpu.h>
>  #include <linux/module.h>
>  #include <linux/nvmem-consumer.h>
> @@ -23,20 +24,94 @@
>  #define NVMEM_MASK	0x7
>  #define NVMEM_SHIFT	5
>  
> +struct sunxi_cpufreq_soc_data {
> +	int (*efuse_xlate)(u32 *versions, u32 *efuse, char *name, size_t len);
> +	u8 ver_freq_limit;
> +};
> +
>  static struct platform_device *cpufreq_dt_pdev, *sun50i_cpufreq_pdev;
>  
> +static int sun50i_h616_efuse_xlate(u32 *versions, u32 *efuse, char *name, size_t len)
> +{
> +	int value = 0;
> +	u32 speedgrade = 0;
> +	u32 i;
> +	int ver_bits = arm_smccc_get_soc_id_revision();
> +
> +	if (len > 4) {
> +		pr_err("Invalid nvmem cell length\n");
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < len; i++)
> +		speedgrade |= (efuse[i] << (i * 8));
> +
> +	switch (speedgrade) {
> +	case 0x2000:
> +		value = 0;
> +		break;
> +	case 0x2400:
> +	case 0x7400:
> +	case 0x2c00:
> +	case 0x7c00:
> +		if (ver_bits <= 1) {
> +			/* ic version A/B */
> +			value = 1;
> +		} else {
> +			/* ic version C and later version */
> +			value = 2;
> +		}
> +		break;
> +	case 0x5000:
> +	case 0x5400:
> +	case 0x6000:
> +		value = 3;
> +		break;
> +	case 0x5c00:
> +		value = 4;
> +		break;
> +	case 0x5d00:
> +	default:
> +		value = 0;
> +	}
> +	*versions = (1 << value);
> +	snprintf(name, MAX_NAME_LEN, "speed%d", value);
> +	return 0;
> +}
> +
> +static int sun50i_h6_efuse_xlate(u32 *versions, u32 *efuse, char *name, size_t len)
> +{
> +	int efuse_value = (*efuse >> NVMEM_SHIFT) & NVMEM_MASK;
> +
> +	/*
> +	 * We treat unexpected efuse values as if the SoC was from
> +	 * the slowest bin. Expected efuse values are 1-3, slowest
> +	 * to fastest.
> +	 */
> +	if (efuse_value >= 1 && efuse_value <= 3)
> +		*versions = efuse_value - 1;
> +	else
> +		*versions = 0;
> +
> +	snprintf(name, MAX_NAME_LEN, "speed%d", *versions);
> +	return 0;
> +}
> +
>  /**
>   * sun50i_cpufreq_get_efuse() - Determine speed grade from efuse value
> + * @soc_data: Struct containing soc specific data & functions
>   * @versions: Set to the value parsed from efuse
> + * @name: Set to the name of speed
>   *
>   * Returns 0 if success.
>   */
> -static int sun50i_cpufreq_get_efuse(u32 *versions)
> +static int sun50i_cpufreq_get_efuse(const struct sunxi_cpufreq_soc_data *soc_data,
> +				    u32 *versions, char *name)
>  {
>  	struct nvmem_cell *speedbin_nvmem;
>  	struct device_node *np;
>  	struct device *cpu_dev;
> -	u32 *speedbin, efuse_value;
> +	u32 *speedbin;
>  	size_t len;
>  	int ret;
>  
> @@ -48,9 +123,9 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
>  	if (!np)
>  		return -ENOENT;
>  
> -	ret = of_device_is_compatible(np,
> -				      "allwinner,sun50i-h6-operating-points");
> -	if (!ret) {
> +	if (of_device_is_compatible(np, "allwinner,sun50i-h6-operating-points")) {
> +	} else if (of_device_is_compatible(np, "allwinner,sun50i-h616-operating-points")) {
> +	} else {
>  		of_node_put(np);
>  		return -ENOENT;
>  	}
> @@ -66,17 +141,9 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
>  	if (IS_ERR(speedbin))
>  		return PTR_ERR(speedbin);
>  
> -	efuse_value = (*speedbin >> NVMEM_SHIFT) & NVMEM_MASK;
> -
> -	/*
> -	 * We treat unexpected efuse values as if the SoC was from
> -	 * the slowest bin. Expected efuse values are 1-3, slowest
> -	 * to fastest.
> -	 */
> -	if (efuse_value >= 1 && efuse_value <= 3)
> -		*versions = efuse_value - 1;
> -	else
> -		*versions = 0;
> +	ret = soc_data->efuse_xlate(versions, speedbin, name, len);
> +	if (ret)
> +		return ret;
>  
>  	kfree(speedbin);
>  	return 0;
> @@ -84,25 +151,30 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
>  
>  static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *match;
> +	const struct sunxi_cpufreq_soc_data *soc_data;
>  	int *opp_tokens;
>  	char name[MAX_NAME_LEN];
>  	unsigned int cpu;
> -	u32 speed = 0;
> +	u32 version = 0;
>  	int ret;
>  
> +	match = dev_get_platdata(&pdev->dev);
> +	if (!match)
> +		return -EINVAL;
> +	soc_data = match->data;
> +
>  	opp_tokens = kcalloc(num_possible_cpus(), sizeof(*opp_tokens),
>  			     GFP_KERNEL);
>  	if (!opp_tokens)
>  		return -ENOMEM;
>  
> -	ret = sun50i_cpufreq_get_efuse(&speed);
> +	ret = sun50i_cpufreq_get_efuse(match->data, &version, name);
>  	if (ret) {
>  		kfree(opp_tokens);
>  		return ret;
>  	}
>  
> -	snprintf(name, MAX_NAME_LEN, "speed%d", speed);
> -
>  	for_each_possible_cpu(cpu) {
>  		struct device *cpu_dev = get_cpu_device(cpu);
>  
> @@ -117,6 +189,16 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
>  			pr_err("Failed to set prop name\n");
>  			goto free_opp;
>  		}
> +
> +		if (soc_data->ver_freq_limit) {
> +			opp_tokens[cpu] = dev_pm_opp_set_supported_hw(cpu_dev,
> +								  &version, 1);

This will overwrite opp_tokens[cpu] from the dev_pm_opp_set_prop_name()
call above. As the DTs stand today, only one of them would actually
provide OPPs, but still they reserve data structures and return discrete
tokens, so all of them would need to be "put" at cleanup/removal.

One solution I found is to pull in the two wrappers of
dev_pm_opp_set_prop_name() and dev_pm_opp_set_supported_hw(), and combine them in one call.
The dev_pm_opp_config struct can have multiple fields set, and
dev_pm_opp_set_config() will try all of them.

> +			if (opp_tokens[cpu] < 0) {
> +				ret = opp_tokens[cpu];
> +				pr_err("Failed to set hw\n");
> +				goto free_opp;
> +			}
> +		}
>  	}
>  
>  	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
> @@ -132,6 +214,8 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
>  free_opp:
>  	for_each_possible_cpu(cpu)
>  		dev_pm_opp_put_prop_name(opp_tokens[cpu]);
> +		if (soc_data->ver_freq_limit)
> +			dev_pm_opp_put_supported_hw(opp_tokens[cpu]);

See above, that does not make sense, since you "put" the same token again
as in the dev_pm_opp_put_prop_name() call right before. Would be
automatically solved by using only one dev_pm_opp_set_config() above.

>  	kfree(opp_tokens);
>  
>  	return ret;
> @@ -140,12 +224,21 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
>  static int sun50i_cpufreq_nvmem_remove(struct platform_device *pdev)
>  {
>  	int *opp_tokens = platform_get_drvdata(pdev);
> +	const struct of_device_id *match;
> +	const struct sunxi_cpufreq_soc_data *soc_data;
>  	unsigned int cpu;
>  
> +	match = dev_get_platdata(&pdev->dev);
> +	if (!match)
> +		return -EINVAL;
> +	soc_data = match->data;
> +
>  	platform_device_unregister(cpufreq_dt_pdev);
>  
>  	for_each_possible_cpu(cpu)
>  		dev_pm_opp_put_prop_name(opp_tokens[cpu]);
> +		if (soc_data->ver_freq_limit)
> +			dev_pm_opp_put_supported_hw(opp_tokens[cpu]);
>  
>  	kfree(opp_tokens);
>  
> @@ -160,8 +253,18 @@ static struct platform_driver sun50i_cpufreq_driver = {
>  	},
>  };
>  
> +static const struct sunxi_cpufreq_soc_data sun50i_h616_data = {
> +	.efuse_xlate = sun50i_h616_efuse_xlate,
> +	.ver_freq_limit = true,

As hinted above, the framework allows for both to be tried, and will do
the right thing depending on what the DT provides, so there is no need for
this flag.

Cheers,
Andre

> +};
> +
> +static const struct sunxi_cpufreq_soc_data sun50i_h6_data = {
> +	.efuse_xlate = sun50i_h6_efuse_xlate,
> +};
> +
>  static const struct of_device_id sun50i_cpufreq_match_list[] = {
> -	{ .compatible = "allwinner,sun50i-h6" },
> +	{ .compatible = "allwinner,sun50i-h6", .data = &sun50i_h6_data },
> +	{ .compatible = "allwinner,sun50i-h616", .data = &sun50i_h616_data },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sun50i_cpufreq_match_list);
> @@ -197,8 +300,8 @@ static int __init sun50i_cpufreq_init(void)
>  		return ret;
>  
>  	sun50i_cpufreq_pdev =
> -		platform_device_register_simple("sun50i-cpufreq-nvmem",
> -						-1, NULL, 0);
> +		platform_device_register_data(NULL, "sun50i-cpufreq-nvmem",
> +						-1, match, sizeof(*match));
>  	ret = PTR_ERR_OR_ZERO(sun50i_cpufreq_pdev);
>  	if (ret == 0)
>  		return 0;
> 

