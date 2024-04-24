Return-Path: <linux-kernel+bounces-156649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A3F8B063F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6A91F23EF2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC39B158A38;
	Wed, 24 Apr 2024 09:41:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FE3158DAE;
	Wed, 24 Apr 2024 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951666; cv=none; b=J7XIYdNxpbennw0vPOBITLcj53hUURnsd4n6R25E76RrYzr8YLqm8lbiRs63lBP+jpjexZ5ic/7IJ0sdReeBjI6xVD5cn7KevvPLhGrs7DqTAEmEyugQ0GK9qqtBAS4ZTxvxEoJjHmPPnv3xUutqj8hl/IFvpPxqJzYn8qaNUPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951666; c=relaxed/simple;
	bh=gSrK9oT5cvcL2gmn9XEcTtq6o5a913OOroeiHSU+Mzw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i14Wx7RF+T1PR8p0mZ7ae2wnCRMS+6qjw4ysFZAFz3t1/9W9PyiXY0DiVtWX1QhQdbkv3egtwMkXHsOlLHAjbWl3TwsjHPoXiWxvdMAM0RJGFayEamdjX1NltzSow8eyymYuaygbIHq8pYNKeSP/TmGWBUo8LXnFDZ43JMQOlck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F415339;
	Wed, 24 Apr 2024 02:41:29 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BF7F3F64C;
	Wed, 24 Apr 2024 02:40:56 -0700 (PDT)
Date: Wed, 24 Apr 2024 10:40:48 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Joy Chakraborty <joychakr@google.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team
 <linux-imx@nxp.com>, Vladimir Zapolskiy <vz@mleia.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, Orson Zhai <orsonzhai@gmail.com>, Baolin
 Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Vincent Shih <vincent.sunplus@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Rafal Milecki <rafal@milecki.pl>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Michal Simek <michal.simek@amd.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 manugautam@google.com
Subject: Re: [PATCH v2 1/1] nvmem: Change return type of reg read/write to
 ssize_t
Message-ID: <20240424104048.1b02b07e@donnerap.manchester.arm.com>
In-Reply-To: <20240424074242.519895-2-joychakr@google.com>
References: <20240424074242.519895-1-joychakr@google.com>
	<20240424074242.519895-2-joychakr@google.com>
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

On Wed, 24 Apr 2024 07:42:42 +0000
Joy Chakraborty <joychakr@google.com> wrote:

> Change return type of reg_read() and reg_write() callback to ssize_t for
> nvmem suppliers to return number of bytes read/written to the nvmem core.
> 
> Currently nvmem core assumes the amount of data read/written is equal
> to what it has requested from the supplier, this return code facilitates
> better error handling in the nvmem core.
> 
> Signed-off-by: Joy Chakraborty <joychakr@google.com>

There are two problems in the sunxi driver:

> ---
>  drivers/nvmem/apple-efuses.c        |  7 +--
>  drivers/nvmem/bcm-ocotp.c           | 12 ++---
>  drivers/nvmem/brcm_nvram.c          | 10 ++--
>  drivers/nvmem/core.c                | 83 +++++++++++++----------------
>  drivers/nvmem/imx-iim.c             |  6 +--
>  drivers/nvmem/imx-ocotp-ele.c       |  4 +-
>  drivers/nvmem/imx-ocotp-scu.c       | 12 ++---
>  drivers/nvmem/imx-ocotp.c           | 10 ++--
>  drivers/nvmem/jz4780-efuse.c        |  7 +--
>  drivers/nvmem/lan9662-otpc.c        | 12 ++---
>  drivers/nvmem/layerscape-sfp.c      | 11 ++--
>  drivers/nvmem/lpc18xx_eeprom.c      | 14 ++---
>  drivers/nvmem/lpc18xx_otp.c         |  6 +--
>  drivers/nvmem/meson-efuse.c         | 22 +++++---
>  drivers/nvmem/meson-mx-efuse.c      |  6 +--
>  drivers/nvmem/microchip-otpc.c      |  6 +--
>  drivers/nvmem/mtk-efuse.c           |  6 +--
>  drivers/nvmem/mxs-ocotp.c           |  7 +--
>  drivers/nvmem/nintendo-otp.c        |  6 +--
>  drivers/nvmem/qcom-spmi-sdam.c      | 12 ++---
>  drivers/nvmem/qfprom.c              | 14 ++---
>  drivers/nvmem/qoriq-efuse.c         |  6 +--
>  drivers/nvmem/rave-sp-eeprom.c      | 18 +++----
>  drivers/nvmem/rmem.c                |  4 +-
>  drivers/nvmem/rockchip-efuse.c      | 19 +++----
>  drivers/nvmem/rockchip-otp.c        | 19 +++----
>  drivers/nvmem/sc27xx-efuse.c        |  3 +-
>  drivers/nvmem/sec-qfprom.c          |  4 +-
>  drivers/nvmem/snvs_lpgpr.c          | 17 +++---
>  drivers/nvmem/sprd-efuse.c          |  8 +--
>  drivers/nvmem/stm32-bsec-optee-ta.c | 12 ++---
>  drivers/nvmem/stm32-bsec-optee-ta.h | 20 +++----
>  drivers/nvmem/stm32-romem.c         | 26 ++++-----
>  drivers/nvmem/sunplus-ocotp.c       |  4 +-
>  drivers/nvmem/sunxi_sid.c           | 15 +++---
>  drivers/nvmem/u-boot-env.c          |  6 +--
>  drivers/nvmem/uniphier-efuse.c      |  6 +--
>  drivers/nvmem/vf610-ocotp.c         |  7 +--
>  drivers/nvmem/zynqmp_nvmem.c        | 13 ++---
>  include/linux/nvmem-provider.h      |  4 +-
>  40 files changed, 253 insertions(+), 231 deletions(-)

[ ... ]

> 
> diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> index ba14a76208ab..0133263d2adb 100644
> --- a/drivers/nvmem/sunxi_sid.c
> +++ b/drivers/nvmem/sunxi_sid.c
> @@ -36,8 +36,8 @@ struct sunxi_sid {
>  	u32			value_offset;
>  };
>  
> -static int sunxi_sid_read(void *context, unsigned int offset,
> -			  void *val, size_t bytes)
> +static ssize_t sunxi_sid_read(void *context, unsigned int offset,
> +			      void *val, size_t bytes)
>  {
>  	struct sunxi_sid *sid = context;
>  	u32 word;
> @@ -56,7 +56,7 @@ static int sunxi_sid_read(void *context, unsigned int offset,

	(adding more context here)

>
>	val += round_down(bytes, 4);
>	offset += round_down(bytes, 4);
>	bytes = bytes % 4;
>
>	if (!bytes)
>		return 0;
>
>	/* Handle any trailing bytes */
>  	word = readl_relaxed(sid->base + sid->value_offset + offset);
>  	memcpy(val, &word, bytes);
>  
> -	return 0;
> +	return bytes;

So this is only the code path in case the read request was not 4 byte
aligned, so the "return 0;" above must also be changed. But please note
that the bytes parameter is changed, so we either need to save that, or
derive the amount read from something else.

Cheers,
Andre

>  }
>  
>  static int sun8i_sid_register_readout(const struct sunxi_sid *sid,
> @@ -90,10 +90,11 @@ static int sun8i_sid_register_readout(const struct sunxi_sid *sid,
>   * to be not reliable at all.
>   * Read by the registers instead.
>   */
> -static int sun8i_sid_read_by_reg(void *context, unsigned int offset,
> -				 void *val, size_t bytes)
> +static ssize_t sun8i_sid_read_by_reg(void *context, unsigned int offset,
> +				     void *val, size_t bytes)
>  {
>  	struct sunxi_sid *sid = context;
> +	size_t bytes_read = bytes;
>  	u32 word;
>  	int ret;
>  
> @@ -109,7 +110,7 @@ static int sun8i_sid_read_by_reg(void *context, unsigned int offset,
>  	}
>  
>  	if (!bytes)
> -		return 0;
> +		return bytes_read;
>  
>  	/* Handle any trailing bytes */
>  	ret = sun8i_sid_register_readout(sid, offset, &word);
> @@ -118,7 +119,7 @@ static int sun8i_sid_read_by_reg(void *context, unsigned int offset,
>  
>  	memcpy(val, &word, bytes);
>  
> -	return 0;
> +	return bytes_read;
>  }
>  
>  static int sunxi_sid_probe(struct platform_device *pdev)
> diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
> index befbab156cda..2288a2891bb2 100644
> --- a/drivers/nvmem/u-boot-env.c
> +++ b/drivers/nvmem/u-boot-env.c
> @@ -47,8 +47,8 @@ struct u_boot_env_image_broadcom {
>  	DECLARE_FLEX_ARRAY(uint8_t, data);
>  } __packed;
>  
> -static int u_boot_env_read(void *context, unsigned int offset, void *val,
> -			   size_t bytes)
> +static ssize_t u_boot_env_read(void *context, unsigned int offset, void *val,
> +			       size_t bytes)
>  {
>  	struct u_boot_env *priv = context;
>  	struct device *dev = priv->dev;
> @@ -66,7 +66,7 @@ static int u_boot_env_read(void *context, unsigned int offset, void *val,
>  		return -EIO;
>  	}
>  
> -	return 0;
> +	return bytes_read;
>  }
>  
>  static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, int index,
> diff --git a/drivers/nvmem/uniphier-efuse.c b/drivers/nvmem/uniphier-efuse.c
> index 6ad3295d3195..a6c28e03adc2 100644
> --- a/drivers/nvmem/uniphier-efuse.c
> +++ b/drivers/nvmem/uniphier-efuse.c
> @@ -16,8 +16,8 @@ struct uniphier_efuse_priv {
>  	void __iomem *base;
>  };
>  
> -static int uniphier_reg_read(void *context,
> -			     unsigned int reg, void *_val, size_t bytes)
> +static ssize_t uniphier_reg_read(void *context,
> +				 unsigned int reg, void *_val, size_t bytes)
>  {
>  	struct uniphier_efuse_priv *priv = context;
>  	u8 *val = _val;
> @@ -26,7 +26,7 @@ static int uniphier_reg_read(void *context,
>  	for (offs = 0; offs < bytes; offs += sizeof(u8))
>  		*val++ = readb(priv->base + reg + offs);
>  
> -	return 0;
> +	return bytes;
>  }
>  
>  static int uniphier_efuse_probe(struct platform_device *pdev)
> diff --git a/drivers/nvmem/vf610-ocotp.c b/drivers/nvmem/vf610-ocotp.c
> index ee9c61ae727d..4e2bdb38305d 100644
> --- a/drivers/nvmem/vf610-ocotp.c
> +++ b/drivers/nvmem/vf610-ocotp.c
> @@ -143,11 +143,12 @@ static int vf610_get_fuse_address(int base_addr_offset)
>  	return -EINVAL;
>  }
>  
> -static int vf610_ocotp_read(void *context, unsigned int offset,
> -			void *val, size_t bytes)
> +static ssize_t vf610_ocotp_read(void *context, unsigned int offset,
> +				void *val, size_t bytes)
>  {
>  	struct vf610_ocotp *ocotp = context;
>  	void __iomem *base = ocotp->base;
> +	size_t bytes_read = bytes;
>  	u32 reg, *buf = val;
>  	int fuse_addr;
>  	int ret;
> @@ -193,7 +194,7 @@ static int vf610_ocotp_read(void *context, unsigned int offset,
>  		offset += 4;
>  	}
>  
> -	return 0;
> +	return bytes_read;
>  }
>  
>  static struct nvmem_config ocotp_config = {
> diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
> index 8682adaacd69..1502d4998159 100644
> --- a/drivers/nvmem/zynqmp_nvmem.c
> +++ b/drivers/nvmem/zynqmp_nvmem.c
> @@ -56,8 +56,8 @@ struct xilinx_efuse {
>  	u32 pufuserfuse;
>  };
>  
> -static int zynqmp_efuse_access(void *context, unsigned int offset,
> -			       void *val, size_t bytes, enum efuse_access flag,
> +static ssize_t zynqmp_efuse_access(void *context, unsigned int offset,
> +				   void *val, size_t bytes, enum efuse_access flag,
>  			       unsigned int pufflag)
>  {
>  	struct device *dev = context;
> @@ -140,10 +140,10 @@ static int zynqmp_efuse_access(void *context, unsigned int offset,
>  	dma_free_coherent(dev, sizeof(struct xilinx_efuse),
>  			  efuse, dma_addr);
>  
> -	return ret;
> +	return ret < 0 ? ret : bytes;
>  }
>  
> -static int zynqmp_nvmem_read(void *context, unsigned int offset, void *val, size_t bytes)
> +static ssize_t zynqmp_nvmem_read(void *context, unsigned int offset, void *val, size_t bytes)
>  {
>  	struct device *dev = context;
>  	int ret;
> @@ -166,6 +166,7 @@ static int zynqmp_nvmem_read(void *context, unsigned int offset, void *val, size
>  
>  		dev_dbg(dev, "Read chipid val %x %x\n", idcode, version);
>  		*(int *)val = version & SILICON_REVISION_MASK;
> +		ret = SOC_VER_SIZE;
>  		break;
>  	/* Efuse offset starts from 0xc */
>  	case EFUSE_START_OFFSET ... EFUSE_END_OFFSET:
> @@ -182,8 +183,8 @@ static int zynqmp_nvmem_read(void *context, unsigned int offset, void *val, size
>  	return ret;
>  }
>  
> -static int zynqmp_nvmem_write(void *context,
> -			      unsigned int offset, void *val, size_t bytes)
> +static ssize_t zynqmp_nvmem_write(void *context,
> +				  unsigned int offset, void *val, size_t bytes)
>  {
>  	int pufflag = 0;
>  
> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
> index 3ebeaa0ded00..f7e83a59aa2f 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -16,9 +16,9 @@
>  #include <linux/gpio/consumer.h>
>  
>  struct nvmem_device;
> -typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
> +typedef ssize_t (*nvmem_reg_read_t)(void *priv, unsigned int offset,
>  				void *val, size_t bytes);
> -typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
> +typedef ssize_t (*nvmem_reg_write_t)(void *priv, unsigned int offset,
>  				 void *val, size_t bytes);
>  /* used for vendor specific post processing of cell data */
>  typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, int index,


