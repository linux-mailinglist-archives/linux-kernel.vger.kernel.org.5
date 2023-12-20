Return-Path: <linux-kernel+bounces-6761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1DB819D20
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D53A1C213A8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7E922326;
	Wed, 20 Dec 2023 10:39:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBD620B04;
	Wed, 20 Dec 2023 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A75831FB;
	Wed, 20 Dec 2023 02:40:21 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E2803F5A1;
	Wed, 20 Dec 2023 02:39:34 -0800 (PST)
Date: Wed, 20 Dec 2023 10:39:32 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Brandon Cheo Fusi <fusibrandon13@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Yangtao Li <tiny.windzz@gmail.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] cpufreq: sun50i: Add support for D1's speed bin
 decoding
Message-ID: <20231220103932.1b186610@donnerap.manchester.arm.com>
In-Reply-To: <20231220095141.27883-2-fusibrandon13@gmail.com>
References: <20231220095141.27883-1-fusibrandon13@gmail.com>
	<20231220095141.27883-2-fusibrandon13@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 10:51:40 +0100
Brandon Cheo Fusi <fusibrandon13@gmail.com> wrote:

Hi Brandon,

> Adds support for decoding the efuse value read from D1 efuse speed
> bins, and factors out equivalent code for sun50i.

Thanks for taking care and sharing this approach!

So this seems to be trying to achieve the same goal as this patch:
https://lore.kernel.org/linux-sunxi/20230904-cpufreq-h616-v1-4-b8842e525c43@somainline.org/
That covers the H616, and would at least clash heavily. The H616 series is
stuck on of some stupid bit in the temperature sensor driver, so I
guess the D1 (being easier) would overtake it.

Can you please split your patch below up, to first refactor the existing
code, with just the H6 support in, then in a second patch add the D1
specific parts? Bonus points for looking at the H616 patch and checking
if there are extra requirements over the D1, which should be already
considered in this refactoring patch.

Many thanks,
Andre


> The algorithm is gotten from
> 
> https://github.com/Tina-Linux/linux-5.4/blob/master/drivers/cpufreq/sun50i-cpufreq-nvmem.c#L293-L338
> 
> and maps an efuse value to either 0 or 1, with 1 meaning stable at
> a lower supply voltage for the same clock frequency.
> 
> Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 85 +++++++++++++++++++++-----
>  1 file changed, 70 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index ccf83780f..28afbe558 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -25,6 +25,66 @@
>  
>  static struct platform_device *cpufreq_dt_pdev, *sun50i_cpufreq_pdev;
>  
> +struct sunxi_cpufreq_data {
> +	u32 (*efuse_xlate)(u32 efuse_value);
> +};
> +
> +static u32 sun20i_efuse_xlate(u32 efuse_value)
> +{
> +	u32 ret;
> +
> +	switch (efuse_value) {
> +	case 0x5e00:
> +		/* QFN package */
> +		ret = 0;
> +		break;
> +	case 0x5c00:
> +	case 0x7400:
> +		/* QFN package */
> +		ret = 1;
> +		break;
> +	case 0x5000:
> +	default:
> +		/* BGA package */
> +		ret = 0;
> +	}
> +
> +	return ret;
> +}
> +
> +static u32 sun50i_efuse_xlate(u32 efuse_value)
> +{
> +	efuse_value = (efuse_value >> NVMEM_SHIFT) & NVMEM_MASK;
> +
> +	/*
> +	* We treat unexpected efuse values as if the SoC was from
> +	* the slowest bin. Expected efuse values are 1-3, slowest
> +	* to fastest.
> +	*/
> +	if (efuse_value >= 1 && efuse_value <= 3)
> +		return efuse_value - 1;
> +	else
> +		return 0;
> +}
> +
> +struct sunxi_cpufreq_data sun20i_cpufreq_data = {
> +	.efuse_xlate = sun20i_efuse_xlate,
> +};
> +
> +struct sunxi_cpufreq_data sun50i_cpufreq_data = {
> +	.efuse_xlate = sun50i_efuse_xlate,
> +};
> +
> +static const struct of_device_id cpu_opp_match_list[] = {
> +	{ .compatible = "allwinner,sun50i-h6-operating-points",
> +	  .data = &sun50i_cpufreq_data,
> +	},
> +	{ .compatible = "allwinner,sun20i-d1-operating-points",
> +	  .data = &sun20i_cpufreq_data,
> +	},
> +	{}
> +};
> +
>  /**
>   * sun50i_cpufreq_get_efuse() - Determine speed grade from efuse value
>   * @versions: Set to the value parsed from efuse
> @@ -36,9 +96,11 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
>  	struct nvmem_cell *speedbin_nvmem;
>  	struct device_node *np;
>  	struct device *cpu_dev;
> -	u32 *speedbin, efuse_value;
> +	const struct of_device_id *opp_match;
> +	const struct sunxi_cpufreq_data *opp_data;
> +	u32 *speedbin, efuse_value = 0;
>  	size_t len;
> -	int ret;
> +	int i;
>  
>  	cpu_dev = get_cpu_device(0);
>  	if (!cpu_dev)
> @@ -48,9 +110,8 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
>  	if (!np)
>  		return -ENOENT;
>  
> -	ret = of_device_is_compatible(np,
> -				      "allwinner,sun50i-h6-operating-points");
> -	if (!ret) {
> +	opp_match = of_match_node(cpu_opp_match_list, np);
> +	if (!opp_match) {
>  		of_node_put(np);
>  		return -ENOENT;
>  	}
> @@ -66,17 +127,11 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
>  	if (IS_ERR(speedbin))
>  		return PTR_ERR(speedbin);
>  
> -	efuse_value = (*speedbin >> NVMEM_SHIFT) & NVMEM_MASK;
> +	for (i = 0; i < len; i++)
> +		efuse_value |= ((u32)speedbin[i] << (i * 8));
>  
> -	/*
> -	 * We treat unexpected efuse values as if the SoC was from
> -	 * the slowest bin. Expected efuse values are 1-3, slowest
> -	 * to fastest.
> -	 */
> -	if (efuse_value >= 1 && efuse_value <= 3)
> -		*versions = efuse_value - 1;
> -	else
> -		*versions = 0;
> +	opp_data = opp_match->data;
> +	*versions = opp_data->efuse_xlate(efuse_value);
>  
>  	kfree(speedbin);
>  	return 0;


