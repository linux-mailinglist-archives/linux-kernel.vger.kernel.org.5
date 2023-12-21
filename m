Return-Path: <linux-kernel+bounces-8749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CD581BBB7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA921C244F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0705258224;
	Thu, 21 Dec 2023 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEJl7ONK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C2E58219;
	Thu, 21 Dec 2023 16:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82354C433C8;
	Thu, 21 Dec 2023 16:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703175368;
	bh=OwON6BSUO01DLEqWe8FDyxpOo9+ASV5bGIDHEtl7Q6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BEJl7ONKUfmwqm48GXAC4dR83mYi/nKLhbgyUTjyvvhRgoAd7CQEyLyueqLyUcKHI
	 Au3PiZqNMMXVp5RVoFcRHsDMxTYSYJrlhUzdszzqRNRWNWPVCHCpr5krtXPkpDICsY
	 hWRgUOFDF1K4TfDFu/mgnjwvXRo+9SAI7NJbUyYLsNr2ucIxTgNjGLDPG7T0yvIRdq
	 O/e58TBW9uixW6WcqWO58cbL5cKtDS2yoDrfFj9F4S9KpWknjb7wqNxwp4InwQzCjA
	 r2WWKz1FIGCx4qU6c985UsOG9h0t5orLiZ1vvvqsXXjL1j31jtSL2HfDbG+IaYF9s+
	 Zb8KxHbYt2x3A==
Date: Thu, 21 Dec 2023 16:16:04 +0000
From: Lee Jones <lee@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v5 2/2] ptp: add FemtoClock3 Wireless as ptp
 hardware clock
Message-ID: <20231221161604.GP10102@google.com>
References: <20231220145917.7076-1-lnimi@hotmail.com>
 <PH7PR03MB70640D32D7AEC51BFE83A02FA096A@PH7PR03MB7064.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR03MB70640D32D7AEC51BFE83A02FA096A@PH7PR03MB7064.namprd03.prod.outlook.com>

On Wed, 20 Dec 2023, Min Li wrote:

> From: Min Li <min.li.xe@renesas.com>
> 
> The RENESAS FemtoClock3 Wireless is a high-performance jitter attenuator,
> frequency translator, and clock synthesizer. The device is comprised of 3
> digital PLLs (DPLL) to track CLKIN inputs and three independent low phase
> noise fractional output dividers (FOD) that output low phase noise clocks.
> 
> FemtoClock3 supports one Time Synchronization (Time Sync) channel to enable
> an external processor to control the phase and frequency of the Time Sync
> channel and to take phase measurements using the TDC. Intended applications
> are synchronization using the precision time protocol (PTP) and
> synchronization with 0.5 Hz and 1 Hz signals from GNSS.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  drivers/ptp/Kconfig                |   12 +
>  drivers/ptp/Makefile               |    1 +
>  drivers/ptp/ptp_fc3.c              | 1036 ++++++++++++++++++++++++++++
>  drivers/ptp/ptp_fc3.h              |   45 ++
>  include/linux/mfd/idtRC38xxx_reg.h |  273 ++++++++

Why MFD?  Where else is this being used?

>  5 files changed, 1367 insertions(+)
>  create mode 100644 drivers/ptp/ptp_fc3.c
>  create mode 100644 drivers/ptp/ptp_fc3.h
>  create mode 100644 include/linux/mfd/idtRC38xxx_reg.h
> 
> diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
> index 5dd5f188e..604541dcb 100644
> --- a/drivers/ptp/Kconfig
> +++ b/drivers/ptp/Kconfig
> @@ -155,6 +155,18 @@ config PTP_1588_CLOCK_IDTCM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called ptp_clockmatrix.
>  
> +config PTP_1588_CLOCK_FC3W
> +	tristate "RENESAS FemtoClock3 Wireless as PTP clock"
> +	depends on PTP_1588_CLOCK && I2C
> +	default n
> +	help
> +	  This driver adds support for using Renesas FemtoClock3 Wireless
> +	  as a PTP clock. This clock is only useful if your time stamping
> +	  MAC is connected to the RENESAS chip.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called ptp_fc3.
> +
>  config PTP_1588_CLOCK_MOCK
>  	tristate "Mock-up PTP clock"
>  	depends on PTP_1588_CLOCK
> diff --git a/drivers/ptp/ptp_fc3.h b/drivers/ptp/ptp_fc3.h
> new file mode 100644
> index 000000000..897101579
> --- /dev/null
> +++ b/drivers/ptp/ptp_fc3.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * PTP hardware clock driver for the FemtoClock3 family of timing and
> + * synchronization devices.
> + *
> + * Copyright (C) 2023 Integrated Device Technology, Inc., a Renesas Company.
> + */
> +#ifndef PTP_IDTFC3_H
> +#define PTP_IDTFC3_H
> +
> +#include <linux/ktime.h>
> +#include <linux/ptp_clock.h>
> +#include <linux/regmap.h>
> +
> +#define FW_FILENAME	"idtfc3.bin"
> +
> +#define MAX_FFO_PPB	(244000)
> +#define TDC_GET_PERIOD	(10)
> +
> +struct idtfc3 {
> +	struct ptp_clock_info	caps;
> +	struct ptp_clock	*ptp_clock;
> +	struct device		*dev;
> +	/* Mutex to protect operations from being interrupted */
> +	struct mutex		*lock;
> +	struct device		*mfd;

parent

Also, you can derive this from 'dev' above.  You don't need both.

> +	struct regmap		*regmap;
> +	struct idtfc3_hw_param	hw_param;
> +	u32			sub_sync_count;
> +	u32			ns_per_sync;
> +	int			tdc_offset_sign;
> +	u64			tdc_apll_freq;
> +	u32			time_ref_freq;
> +	u16			fod_n;
> +	u8			lpf_mode;
> +	/* Time counter */
> +	u32			last_counter;
> +	s64			ns;
> +	u32			ns_per_counter;
> +	u32			tc_update_period;
> +	u32			tc_write_timeout;
> +	s64			tod_write_overhead;
> +};
> +
> +#endif /* PTP_IDTFC3_H */
> diff --git a/include/linux/mfd/idtRC38xxx_reg.h b/include/linux/mfd/idtRC38xxx_reg.h
> new file mode 100644
> index 000000000..edddaae61
> --- /dev/null
> +++ b/include/linux/mfd/idtRC38xxx_reg.h
> @@ -0,0 +1,273 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Register Map - Based on PolarBear_CSRs.RevA.xlsx (2023-04-21)
> + *
> + * Copyright (C) 2023 Integrated Device Technology, Inc., a Renesas Company.
> + */
> +#ifndef HAVE_IDTRC38XXX_REG
> +#define HAVE_IDTRC38XXX_REG

MFD not HAVE.

> +
> +/* GLOBAL */

Everything in here is global?

> +#define SOFT_RESET_CTRL		(0x15) /* Specific to FC3W */
> +#define MISC_CTRL		(0x14) /* Specific to FC3A */
> +#define APLL_REINIT		BIT(1)
> +#define APLL_REINIT_VFC3A	BIT(2)
> +
> +#define DEVICE_ID		(0x2)
> +#define DEVICE_ID_MASK		(0x1000) /* Bit 12 is 1 if FC3W and 0 if FC3A */
> +#define DEVICE_ID_SHIFT		(12)
> +
> +/* FOD */
> +#define FOD_0		(0x300)
> +#define FOD_0_VFC3A	(0x400)
> +#define FOD_1		(0x340)
> +#define FOD_1_VFC3A	(0x440)
> +#define FOD_2		(0x380)
> +#define FOD_2_VFC3A	(0x480)
> +
> +/* TDCAPLL */
> +#define TDC_CTRL		(0x44a) /* Specific to FC3W */
> +#define TDC_ENABLE_CTRL		(0x169) /* Specific to FC3A */
> +#define TDC_DAC_CAL_CTRL	(0x16a) /* Specific to FC3A */
> +#define TDC_EN			BIT(0)
> +#define TDC_DAC_RECAL_REQ	BIT(1)
> +#define TDC_DAC_RECAL_REQ_VFC3A	BIT(0)
> +
> +#define TDC_FB_DIV_INT_CNFG		(0x442)
> +#define TDC_FB_DIV_INT_CNFG_VFC3A	(0x162)
> +#define TDC_FB_DIV_INT_MASK		GENMASK(7, 0)
> +#define TDC_REF_DIV_CNFG		(0x443)
> +#define TDC_REF_DIV_CNFG_VFC3A		(0x163)
> +#define TDC_REF_DIV_CONFIG_MASK		GENMASK(2, 0)
> +
> +/* TIME SYNC CHANNEL */
> +#define TIME_CLOCK_SRC		(0xa01) /* Specific to FC3W */
> +#define TIME_CLOCK_COUNT	(0xa00) /* Specific to FC3W */
> +#define TIME_CLOCK_COUNT_MASK	GENMASK(5, 0)
> +
> +#define SUB_SYNC_GEN_CNFG	(0xa04)
> +
> +#define TOD_COUNTER_READ_REQ		(0xa5f)
> +#define TOD_COUNTER_READ_REQ_VFC3A	(0x6df)
> +#define TOD_SYNC_LOAD_VAL_CTRL		(0xa10)
> +#define TOD_SYNC_LOAD_VAL_CTRL_VFC3A	(0x690)
> +#define SYNC_COUNTER_MASK		GENMASK(51, 0)
> +#define SUB_SYNC_COUNTER_MASK		GENMASK(30, 0)
> +#define TOD_SYNC_LOAD_REQ_CTRL		(0xa21)
> +#define TOD_SYNC_LOAD_REQ_CTRL_VFC3A	(0x6a1)
> +#define SYNC_LOAD_ENABLE		BIT(1)
> +#define SUB_SYNC_LOAD_ENABLE		BIT(0)
> +#define SYNC_LOAD_REQ			BIT(0)
> +
> +#define LPF_MODE_CNFG		(0xa80)
> +#define LPF_MODE_CNFG_VFC3A	(0x700)
> +enum lpf_mode {
> +	LPF_DISABLED = 0,
> +	LPF_WP       = 1,
> +	LPF_HOLDOVER = 2,
> +	LPF_WF       = 3,
> +	LPF_INVALID  = 4
> +};
> +#define LPF_CTRL	(0xa98)
> +#define LPF_CTRL_VFC3A	(0x718)
> +#define LPF_EN		BIT(0)
> +
> +#define LPF_BW_CNFG	(0xa81)
> +#define LPF_BW_SHIFT	GENMASK(7, 3)
> +#define LPF_BW_MULT		GENMASK(2, 0)
> +#define LPF_BW_SHIFT_DEFAULT	(0xb)
> +#define LPF_BW_MULT_DEFAULT		(0x0)
> +#define LPF_BW_SHIFT_1PPS		(0x5)
> +
> +#define LPF_WR_PHASE_CTRL	(0xaa8)
> +#define LPF_WR_PHASE_CTRL_VFC3A	(0x728)
> +#define LPF_WR_FREQ_CTRL	(0xab0)
> +#define LPF_WR_FREQ_CTRL_VFC3A	(0x730)
> +
> +#define TIME_CLOCK_TDC_FANOUT_CNFG	(0xB00)
> +#define TIME_SYNC_TO_TDC_EN	BIT(0)
> +#define SIG1_MUX_SEL_MASK	GENMASK(7, 4)
> +#define SIG2_MUX_SEL_MASK	GENMASK(11, 8)
> +enum tdc_mux_sel {
> +	REF0 = 0,
> +	REF1 = 1,
> +	REF2 = 2,
> +	REF3 = 3,
> +	REF_CLK5 = 4,
> +	REF_CLK6 = 5,
> +	DPLL_FB_TO_TDC = 6,
> +	DPLL_FB_DIVIDED_TO_TDC = 7,
> +	TIME_CLK_DIVIDED = 8,
> +	TIME_SYNC = 9,
> +};
> +
> +#define TIME_CLOCK_MEAS_CNFG	(0xB04)
> +#define TDC_MEAS_MODE	BIT(0)
> +enum tdc_meas_mode {
> +	CONTINUOUS = 0,
> +	ONE_SHOT = 1,
> +	MEAS_MODE_INVALID = 2,
> +};
> +
> +#define TIME_CLOCK_MEAS_DIV_CNFG	(0xB08)
> +#define TIME_REF_DIV_MASK	GENMASK(29, 24)
> +
> +#define TIME_CLOCK_MEAS_CTRL	(0xB10)
> +#define TDC_MEAS_EN	BIT(0)
> +#define TDC_MEAS_START	BIT(1)
> +
> +#define TDC_FIFO_READ_REQ	(0xB2F)
> +#define TDC_FIFO_READ		(0xB30)
> +#define COARSE_MEAS_MASK	GENMASK(39, 13)
> +#define FINE_MEAS_MASK		GENMASK(12, 0)
> +
> +#define TDC_FIFO_CTRL		(0xB12)
> +#define FIFO_CLEAR		BIT(0)
> +#define TDC_FIFO_STS		(0xB38)
> +#define FIFO_FULL		BIT(1)
> +#define FIFO_EMPTY		BIT(0)
> +#define TDC_FIFO_EVENT		(0xB39)
> +#define FIFO_OVERRUN		BIT(1)
> +
> +/* DPLL */
> +#define MAX_REFERENCE_INDEX	(3)
> +#define MAX_NUM_REF_PRIORITY	(4)
> +
> +#define MAX_DPLL_INDEX	(2)
> +
> +#define DPLL_STS		(0x580)
> +#define DPLL_STS_VFC3A		(0x571)
> +#define DPLL_STATE_STS_MASK	(0x70)
> +#define DPLL_STATE_STS_SHIFT	(4)
> +#define DPLL_REF_SEL_STS_MASK	(0x6)
> +#define DPLL_REF_SEL_STS_SHIFT	(1)
> +
> +#define DPLL_REF_PRIORITY_CNFG			(0x502)
> +#define DPLL_REFX_PRIORITY_DISABLE_MASK		(0xf)
> +#define DPLL_REF0_PRIORITY_ENABLE_AND_SET_MASK	(0x31)
> +#define DPLL_REF1_PRIORITY_ENABLE_AND_SET_MASK	(0xc2)
> +#define DPLL_REF2_PRIORITY_ENABLE_AND_SET_MASK	(0x304)
> +#define DPLL_REF3_PRIORITY_ENABLE_AND_SET_MASK	(0xc08)
> +#define DPLL_REF0_PRIORITY_SHIFT		(4)
> +#define DPLL_REF1_PRIORITY_SHIFT		(6)
> +#define DPLL_REF2_PRIORITY_SHIFT		(8)
> +#define DPLL_REF3_PRIORITY_SHIFT		(10)
> +
> +enum dpll_state {
> +	DPLL_STATE_MIN             = 0,
> +	DPLL_STATE_FREERUN         = DPLL_STATE_MIN,
> +	DPLL_STATE_LOCKED          = 1,
> +	DPLL_STATE_HOLDOVER        = 2,
> +	DPLL_STATE_WRITE_FREQUENCY = 3,
> +	DPLL_STATE_ACQUIRE         = 4,
> +	DPLL_STATE_HITLESS_SWITCH  = 5,
> +	DPLL_STATE_MAX             = DPLL_STATE_HITLESS_SWITCH
> +};
> +
> +/* REFMON */
> +#define LOSMON_STS_0		(0x81e)
> +#define LOSMON_STS_0_VFC3A	(0x18e)
> +#define LOSMON_STS_1		(0x82e)
> +#define LOSMON_STS_1_VFC3A	(0x19e)
> +#define LOSMON_STS_2		(0x83e)
> +#define LOSMON_STS_2_VFC3A	(0x1ae)
> +#define LOSMON_STS_3		(0x84e)
> +#define LOSMON_STS_3_VFC3A	(0x1be)
> +#define LOS_STS_MASK		(0x1)
> +
> +#define FREQMON_STS_0		(0x874)
> +#define FREQMON_STS_0_VFC3A	(0x1d4)
> +#define FREQMON_STS_1		(0x894)
> +#define FREQMON_STS_1_VFC3A	(0x1f4)
> +#define FREQMON_STS_2		(0x8b4)
> +#define FREQMON_STS_2_VFC3A	(0x214)
> +#define FREQMON_STS_3		(0x8d4)
> +#define FREQMON_STS_3_VFC3A	(0x234)
> +#define FREQ_FAIL_STS_SHIFT	(31)
> +
> +/* Firmware interface */
> +#define TIME_CLK_FREQ_ADDR	(0xffa0)
> +#define XTAL_FREQ_ADDR		(0xffa1)
> +
> +/*
> + * Return register address and field mask based on passed in firmware version
> + */
> +#define IDTFC3_FW_REG(FW, VER, REG)	(((FW) < (VER)) ? (REG) : (REG##_##VER))
> +#define IDTFC3_FW_FIELD(FW, VER, FIELD)	(((FW) < (VER)) ? (FIELD) : (FIELD##_##VER))
> +enum fw_version {
> +	V_DEFAULT = 0,
> +	VFC3W     = 1,
> +	VFC3A     = 2
> +};
> +
> +/* XTAL_FREQ_ADDR/TIME_CLK_FREQ_ADDR */
> +enum {
> +	FREQ_MIN     = 0,
> +	FREQ_25M     = 1,
> +	FREQ_49_152M = 2,
> +	FREQ_50M     = 3,
> +	FREQ_100M    = 4,
> +	FREQ_125M    = 5,
> +	FREQ_250M    = 6,
> +	FREQ_MAX
> +};
> +
> +struct idtfc3_hw_param {
> +	u32 xtal_freq;
> +	u32 time_clk_freq;
> +};
> +
> +struct idtfc3_fwrc {
> +	u8 hiaddr;
> +	u8 loaddr;
> +	u8 value;
> +	u8 reserved;
> +} __packed;

How much of the last 300 lines are actually being used?

> +static inline void idtfc3_default_hw_param(struct idtfc3_hw_param *hw_param)
> +{
> +	hw_param->xtal_freq = 49152000;
> +	hw_param->time_clk_freq = 25000000;
> +}

This is an odd use of an inline function.

Why not define them and use them else where?

> +static inline int idtfc3_set_hw_param(struct idtfc3_hw_param *hw_param,
> +				      u16 addr, u8 val)
> +{
> +	if (addr == XTAL_FREQ_ADDR)
> +		switch (val) {
> +		case FREQ_49_152M:
> +			hw_param->xtal_freq = 49152000;
> +			break;
> +		case FREQ_50M:
> +			hw_param->xtal_freq = 50000000;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	else if (addr == TIME_CLK_FREQ_ADDR)
> +		switch (val) {
> +		case FREQ_25M:
> +			hw_param->time_clk_freq = 25000000;
> +			break;
> +		case FREQ_50M:
> +			hw_param->time_clk_freq = 50000000;
> +			break;
> +		case FREQ_100M:
> +			hw_param->time_clk_freq = 100000000;
> +			break;
> +		case FREQ_125M:
> +			hw_param->time_clk_freq = 125000000;
> +			break;
> +		case FREQ_250M:
> +			hw_param->time_clk_freq = 250000000;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	else
> +		return -EFAULT;
> +
> +	return 0;
> +}

As above.  Why is this being shoved in here?

> +#endif

-- 
Lee Jones [李琼斯]

