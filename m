Return-Path: <linux-kernel+bounces-8400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF1881B6A2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5551C25900
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225217691C;
	Thu, 21 Dec 2023 12:50:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B98768E3;
	Thu, 21 Dec 2023 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D90762F4;
	Thu, 21 Dec 2023 04:50:46 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D29D3F738;
	Thu, 21 Dec 2023 04:49:59 -0800 (PST)
Date: Thu, 21 Dec 2023 12:49:57 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Brandon Cheo Fusi <fusibrandon13@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Yangtao Li <tiny.windzz@gmail.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/3] cpufreq: sun50i: Add support for D1's speed
 bin decoding
Message-ID: <20231221124957.27fa9922@donnerap.manchester.arm.com>
In-Reply-To: <20231221101013.67204-3-fusibrandon13@gmail.com>
References: <20231221101013.67204-1-fusibrandon13@gmail.com>
	<20231221101013.67204-3-fusibrandon13@gmail.com>
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

On Thu, 21 Dec 2023 11:10:12 +0100
Brandon Cheo Fusi <fusibrandon13@gmail.com> wrote:

Hi Brandon,

thanks for the quick turnaround, and for splitting this code up, that
makes reasoning about this much easier!

> Adds support for decoding the efuse value read from D1 efuse speed
> bins, and factors out equivalent code for sun50i.
> 
> The algorithm is gotten from
> 
> https://github.com/Tina-Linux/linux-5.4/blob/master/drivers/cpufreq/sun50i-cpufreq-nvmem.c#L293-L338
> 
> and maps an efuse value to either 0 or 1, with 1 meaning stable at
> a lower supply voltage for the same clock frequency.
> 
> Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 34 ++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index fc509fc49..b1cb95308 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -29,6 +29,33 @@ struct sunxi_cpufreq_data {
>  	u32 (*efuse_xlate)(u32 *speedbin, size_t len);
>  };
>  
> +static u32 sun20i_efuse_xlate(u32 *speedbin, size_t len)

I feel like this prototype can be shortened to:

static u32 sun20i_efuse_xlate(u32 speedbin)

See below.

> +{
> +	u32 ret, efuse_value = 0;
> +	int i;
> +
> +	for (i = 0; i < len; i++)
> +		efuse_value |= ((u32)speedbin[i] << (i * 8));

The cast is not needed. Looking deeper into the original code you linked
to, cell_value[] there is an array of u8, so they assemble a little endian
32-bit integer from *up to* four 8-bit values read from the nvmem.

So I think this code here is wrong, len is the size of the nvmem cells
holding the bin identifier, in *bytes*, so the idea here is to just read
the (lowest) 16 bits (in the D1 case, cf. "reg = <0x00 0x2>;" in the next
patch) from this nvmem cell. Here you are combining two 32-bit words into
efuse_value.

So I think this whole part above is actually not necessary: we are
expecting maximum 32 bits, and nvmem_cell_read() should take care of
masking off unrequested bits, so we get the correct value back already. So
can you try to remove the loop above, and use ...

> +
> +	switch (efuse_value) {

	switch (*speedbin & 0xffff) {

here instead? Or drop the pointer at all, and just use one u32 value, see
the above prototype.

Cheers,
Andre

P.S. This is just a "peephole review" of this patch, I haven't got around
to look at this whole scheme in whole yet, to see if we actually need this
or can simplify this or clean it up.


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
>  static u32 sun50i_efuse_xlate(u32 *speedbin, size_t len)
>  {
>  	u32 efuse_value = 0;
> @@ -46,6 +73,10 @@ static u32 sun50i_efuse_xlate(u32 *speedbin, size_t len)
>  		return 0;
>  }
>  
> +struct sunxi_cpufreq_data sun20i_cpufreq_data = {
> +	.efuse_xlate = sun20i_efuse_xlate,
> +};
> +
>  struct sunxi_cpufreq_data sun50i_cpufreq_data = {
>  	.efuse_xlate = sun50i_efuse_xlate,
>  };
> @@ -54,6 +85,9 @@ static const struct of_device_id cpu_opp_match_list[] = {
>  	{ .compatible = "allwinner,sun50i-h6-operating-points",
>  	  .data = &sun50i_cpufreq_data,
>  	},
> +	{ .compatible = "allwinner,sun20i-d1-operating-points",
> +	  .data = &sun20i_cpufreq_data,
> +	},
>  	{}
>  };
>  


