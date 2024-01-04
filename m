Return-Path: <linux-kernel+bounces-16607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5E482410A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAB71C21B9E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794CE21369;
	Thu,  4 Jan 2024 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RssRhhe9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97542134E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dd04a64c-9593-47cd-a3e2-b113b5ac2d86@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704369210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjN30Vqj5W521S5Z6k4o4YhoJ+r40Mx6kiTIK6j9Kuo=;
	b=RssRhhe9CyCzE5fpMuxoeEsZ8W3zNjtTBUElwtQYo+oeBz9ZPD/72H8QCKlx8zdZbRjfwI
	XPWnQEZe4CVRHSppci40KEgbidH9P9XkyqpHj2xglTQNs4gIsmNKoFH/RjSM8aRkinQN/c
	DKxASkDCNxj7Dr520V4iaegOfHWg1w4=
Date: Thu, 4 Jan 2024 11:53:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] ptp: ocp: add Adva timecard support
To: Sagi Maimon <maimon.sagi@gmail.com>, richardcochran@gmail.com,
 jonathan.lemon@gmail.com, vadfed@fb.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org
References: <20240103071039.94132-1-maimon.sagi@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240103071039.94132-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 03/01/2024 07:10, Sagi Maimon wrote:
> Adding support for the Adva timecard.
> The card uses different drivers to provide access to the
> firmware SPI flash (Altera based).
> Other parts of the code are the same and could be reused.
> 
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
> 
>   Addressed comments from:
>   - Jakub Kicinski : https://www.spinics.net/lists/netdev/msg962419.html
>            
>   Changes since version 2:
>   - reformat the commit message to separate the subject from the body of the message.
>   
>   
>   drivers/ptp/ptp_ocp.c | 247 ++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 238 insertions(+), 9 deletions(-)
> 

Hi Sagi!

Thanks for adjusting the code. It looks much better now.
But I still have some questions futher in the mail.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 4021d3d325f9..96f2ab8a9d61 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -34,6 +34,9 @@
>   #define PCI_VENDOR_ID_OROLIA			0x1ad7
>   #define PCI_DEVICE_ID_OROLIA_ARTCARD		0xa000
>   
> +#define PCI_VENDOR_ID_ADVA			0xad5a
> +#define PCI_DEVICE_ID_ADVA_TIMECARD		0x0400
> +
>   static struct class timecard_class = {
>   	.name		= "timecard",
>   };
> @@ -63,6 +66,13 @@ struct ocp_reg {
>   	u32	status_drift;
>   };
>   
> +struct ptp_ocp_servo_conf {
> +	u32	servo_offset_p;
> +	u32	servo_offset_i;
> +	u32	servo_drift_p;
> +	u32	servo_drift_i;
> +};
> +
>   #define OCP_CTRL_ENABLE		BIT(0)
>   #define OCP_CTRL_ADJUST_TIME	BIT(1)
>   #define OCP_CTRL_ADJUST_OFFSET	BIT(2)
> @@ -397,10 +407,14 @@ static int ptp_ocp_sma_store(struct ptp_ocp *bp, const char *buf, int sma_nr);
>   
>   static int ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
>   
> +static int ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
> +
>   static const struct ocp_attr_group fb_timecard_groups[];
>   
>   static const struct ocp_attr_group art_timecard_groups[];
>   
> +static const struct ocp_attr_group adva_timecard_groups[];
> +
>   struct ptp_ocp_eeprom_map {
>   	u16	off;
>   	u16	len;
> @@ -700,6 +714,12 @@ static struct ocp_resource ocp_fb_resource[] = {
>   	},
>   	{
>   		.setup = ptp_ocp_fb_board_init,
> +		.extra = &(struct ptp_ocp_servo_conf) {
> +			.servo_offset_p = 0x2000,
> +			.servo_offset_i = 0x1000,
> +			.servo_drift_p = 0,
> +			.servo_drift_i = 0,
> +		},
>   	},
>   	{ }
>   };
> @@ -831,6 +851,129 @@ static struct ocp_resource ocp_art_resource[] = {
>   	},
>   	{
>   		.setup = ptp_ocp_art_board_init,
> +		.extra = &(struct ptp_ocp_servo_conf) {
> +			.servo_offset_p = 0x2000,
> +			.servo_offset_i = 0x1000,
> +			.servo_drift_p = 0,
> +			.servo_drift_i = 0,
> +		},
> +	},
> +	{ }
> +};
> +
> +static struct ocp_resource ocp_adva_resource[] = {
> +	{
> +		OCP_MEM_RESOURCE(reg),
> +		.offset = 0x01000000, .size = 0x10000,
> +	},
> +	{
> +		OCP_EXT_RESOURCE(ts0),
> +		.offset = 0x01010000, .size = 0x10000, .irq_vec = 1,
> +		.extra = &(struct ptp_ocp_ext_info) {
> +			.index = 0,
> +			.irq_fcn = ptp_ocp_ts_irq,
> +			.enable = ptp_ocp_ts_enable,
> +		},
> +	},
> +	{
> +		OCP_EXT_RESOURCE(ts1),
> +		.offset = 0x01020000, .size = 0x10000, .irq_vec = 2,
> +		.extra = &(struct ptp_ocp_ext_info) {
> +			.index = 1,
> +			.irq_fcn = ptp_ocp_ts_irq,
> +			.enable = ptp_ocp_ts_enable,
> +		},
> +	},
> +	{
> +		OCP_EXT_RESOURCE(ts2),
> +		.offset = 0x01060000, .size = 0x10000, .irq_vec = 6,
> +		.extra = &(struct ptp_ocp_ext_info) {
> +			.index = 2,
> +			.irq_fcn = ptp_ocp_ts_irq,
> +			.enable = ptp_ocp_ts_enable,
> +		},
> +	},
> +	/* Timestamp for PHC and/or PPS generator */
> +	{
> +		OCP_EXT_RESOURCE(pps),
> +		.offset = 0x010C0000, .size = 0x10000, .irq_vec = 0,
> +		.extra = &(struct ptp_ocp_ext_info) {
> +			.index = 5,
> +			.irq_fcn = ptp_ocp_ts_irq,
> +			.enable = ptp_ocp_ts_enable,
> +		},
> +	},
> +	{
> +		OCP_EXT_RESOURCE(signal_out[0]),
> +		.offset = 0x010D0000, .size = 0x10000, .irq_vec = 11,
> +		.extra = &(struct ptp_ocp_ext_info) {
> +			.index = 1,
> +			.irq_fcn = ptp_ocp_signal_irq,
> +			.enable = ptp_ocp_signal_enable,
> +		},
> +	},
> +	{
> +		OCP_MEM_RESOURCE(pps_to_ext),
> +		.offset = 0x01030000, .size = 0x10000,
> +	},
> +	{
> +		OCP_MEM_RESOURCE(pps_to_clk),
> +		.offset = 0x01040000, .size = 0x10000,
> +	},
> +	{
> +		OCP_MEM_RESOURCE(tod),
> +		.offset = 0x01050000, .size = 0x10000,
> +	},
> +	{
> +		OCP_MEM_RESOURCE(image),
> +		.offset = 0x00020000, .size = 0x1000,
> +	},
> +	{
> +		OCP_MEM_RESOURCE(pps_select),
> +		.offset = 0x00130000, .size = 0x1000,
> +	},
> +	{
> +		OCP_MEM_RESOURCE(sma_map1),
> +		.offset = 0x00140000, .size = 0x1000,
> +	},
> +	{
> +		OCP_MEM_RESOURCE(sma_map2),
> +		.offset = 0x00220000, .size = 0x1000,
> +	},
> +	{
> +		OCP_SERIAL_RESOURCE(gnss_port),
> +		.offset = 0x00160000 + 0x1000, .irq_vec = 3,
> +		.extra = &(struct ptp_ocp_serial_port) {
> +			.baud = 9600,
> +		},
> +	},
> +	{
> +			OCP_MEM_RESOURCE(freq_in[0]),
> +			.offset = 0x01200000, .size = 0x10000,
			^^^
			wrong indentation
> +	},
> +	{
> +			OCP_SPI_RESOURCE(spi_flash),
> +			.offset = 0x00310400, .size = 0x10000, .irq_vec = 9,
> +			.extra = &(struct ptp_ocp_flash_info) {
> +				.name = "spi_altera", .pci_offset = 0,
> +				.data_size = sizeof(struct altera_spi_platform_data),
> +				.data = &(struct altera_spi_platform_data) {
> +					.num_chipselect = 1,
> +					.num_devices = 1,
> +					.devices = &(struct spi_board_info) {
> +						.modalias = "spi-nor",
> +					},
> +				},
> +			},

			and this block too, wrong indentation

> +	},
> +	{
> +		.setup = ptp_ocp_adva_board_init,
> +		.extra = &(struct ptp_ocp_servo_conf) {
> +			.servo_offset_p = 0xc000,
> +			.servo_offset_i = 0x1000,
> +			.servo_drift_p = 0,
> +			.servo_drift_i = 0,
> +		},
>   	},
>   	{ }
>   };
> @@ -839,6 +982,7 @@ static const struct pci_device_id ptp_ocp_pcidev_id[] = {
>   	{ PCI_DEVICE_DATA(FACEBOOK, TIMECARD, &ocp_fb_resource) },
>   	{ PCI_DEVICE_DATA(CELESTICA, TIMECARD, &ocp_fb_resource) },
>   	{ PCI_DEVICE_DATA(OROLIA, ARTCARD, &ocp_art_resource) },
> +	{ PCI_DEVICE_DATA(ADVA, TIMECARD, &ocp_adva_resource) },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(pci, ptp_ocp_pcidev_id);
> @@ -917,6 +1061,27 @@ static const struct ocp_selector ptp_ocp_art_sma_out[] = {
>   	{ }
>   };
>   
> +static const struct ocp_selector ptp_ocp_adva_sma_in[] = {
> +	{ .name = "10Mhz",	.value = 0x0000,      .frequency = 10000000},
> +	{ .name = "PPS1",	.value = 0x0001,      .frequency = 1 },
> +	{ .name = "PPS2",	.value = 0x0002,      .frequency = 1 },
> +	{ .name = "TS1",	.value = 0x0004,      .frequency = 0 },
> +	{ .name = "TS2",	.value = 0x0008,      .frequency = 0 },
> +	{ .name = "FREQ1",	.value = 0x0100,      .frequency = 0 },
> +	{ .name = "None",	.value = SMA_DISABLE, .frequency = 0 },
> +	{ }
> +};
> +
> +static const struct ocp_selector ptp_ocp_adva_sma_out[] = {
> +	{ .name = "10Mhz",	.value = 0x0000,  .frequency = 10000000},
> +	{ .name = "PHC",	.value = 0x0001,  .frequency = 1 },
> +	{ .name = "GNSS1",	.value = 0x0004,  .frequency = 1 },
> +	{ .name = "GEN1",	.value = 0x0040 },
> +	{ .name = "GND",	.value = 0x2000 },
> +	{ .name = "VCC",	.value = 0x4000 },
> +	{ }
> +};
> +
>   struct ocp_sma_op {
>   	const struct ocp_selector *tbl[2];
>   	void (*init)(struct ptp_ocp *bp);
> @@ -1363,7 +1528,7 @@ ptp_ocp_estimate_pci_timing(struct ptp_ocp *bp)
>   }
>   
>   static int
> -ptp_ocp_init_clock(struct ptp_ocp *bp)
> +ptp_ocp_init_clock(struct ptp_ocp *bp, struct ptp_ocp_servo_conf *servo_conf)
>   {
>   	struct timespec64 ts;
>   	u32 ctrl;
> @@ -1371,12 +1536,11 @@ ptp_ocp_init_clock(struct ptp_ocp *bp)
>   	ctrl = OCP_CTRL_ENABLE;
>   	iowrite32(ctrl, &bp->reg->ctrl);
>   
> -	/* NO DRIFT Correction */
> -	/* offset_p:i 1/8, offset_i: 1/16, drift_p: 0, drift_i: 0 */
> -	iowrite32(0x2000, &bp->reg->servo_offset_p);
> -	iowrite32(0x1000, &bp->reg->servo_offset_i);
> -	iowrite32(0,	  &bp->reg->servo_drift_p);
> -	iowrite32(0,	  &bp->reg->servo_drift_i);
> +	/* servo configuration */
> +	iowrite32(servo_conf->servo_offset_p, &bp->reg->servo_offset_p);
> +	iowrite32(servo_conf->servo_offset_i, &bp->reg->servo_offset_i);
> +	iowrite32(servo_conf->servo_drift_p, &bp->reg->servo_drift_p);
> +	iowrite32(servo_conf->servo_drift_p, &bp->reg->servo_drift_i);
>   
>   	/* latch servo values */
>   	ctrl |= OCP_CTRL_ADJUST_SERVO;
> @@ -2362,6 +2526,14 @@ static const struct ocp_sma_op ocp_fb_sma_op = {
>   	.set_output	= ptp_ocp_sma_fb_set_output,
>   };
>   
> +static const struct ocp_sma_op ocp_adva_sma_op = {
> +	.tbl		= { ptp_ocp_adva_sma_in, ptp_ocp_adva_sma_out },
> +	.init		= ptp_ocp_sma_fb_init,
> +	.get		= ptp_ocp_sma_fb_get,
> +	.set_inputs	= ptp_ocp_sma_fb_set_inputs,
> +	.set_output	= ptp_ocp_sma_fb_set_output,
> +};
> +
>   static int
>   ptp_ocp_set_pins(struct ptp_ocp *bp)
>   {
> @@ -2441,7 +2613,7 @@ ptp_ocp_fb_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
>   		return err;
>   	ptp_ocp_sma_init(bp);
>   
> -	return ptp_ocp_init_clock(bp);
> +	return ptp_ocp_init_clock(bp, r->extra);
>   }
>   
>   static bool
> @@ -2603,7 +2775,35 @@ ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
>   	if (err)
>   		return err;
>   
> -	return ptp_ocp_init_clock(bp);
> +	return ptp_ocp_init_clock(bp, r->extra);
> +}
> +
> +/* ADVA specific board initializers; last "resource" registered. */
> +static int
> +ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
> +{
> +	int err;
> +
> +	bp->flash_start = 0xA00000;
> +	bp->fw_version = ioread32(&bp->image->version);
> +	bp->sma_op = &ocp_adva_sma_op;
> +
> +	ptp_ocp_fb_set_version(bp);

I believe there is no need to call ptp_ocp_fb_set_version() because it
has very HW specific code which is probably applicable to your HW.
The only thing to add here is to initialize fw information better.
Take a look at ptp_ocp_art_board_init() function which does all the
fw configuration without calling any other function. Just be sure to
setup fw_tag to something unused.
	
> +
> +	ptp_ocp_tod_init(bp);
> +	ptp_ocp_nmea_out_init(bp);
> +	ptp_ocp_signal_init(bp);
> +
> +	err = ptp_ocp_attr_group_add(bp, adva_timecard_groups);
> +	if (err)
> +		return err;
> +
> +	err = ptp_ocp_set_pins(bp);
> +	if (err)
> +		return err;
> +	ptp_ocp_sma_init(bp);
> +
> +	return ptp_ocp_init_clock(bp, r->extra);
>   }
>   
>   static ssize_t
> @@ -3578,6 +3778,35 @@ static const struct ocp_attr_group art_timecard_groups[] = {
>   	{ },
>   };
>   
> +static struct attribute *adva_timecard_attrs[] = {
> +	&dev_attr_serialnum.attr,

You export serialnum attribute here, but you niether configure any
eeprom HW nor filling "serial" for the board object. That is not good.
Do you have any board-specific information in the firmware or how do you
store board specific values?

I would like to have boards report board identifier and it's serial
number via devlink and sysfs to be sure that user-space software can
understand which firmware to use in case of FW upgrades.

> +	&dev_attr_gnss_sync.attr,
> +	&dev_attr_clock_source.attr,
> +	&dev_attr_available_clock_sources.attr,
> +	&dev_attr_sma1.attr,
> +	&dev_attr_sma2.attr,
> +	&dev_attr_sma3.attr,
> +	&dev_attr_sma4.attr,
> +	&dev_attr_available_sma_inputs.attr,
> +	&dev_attr_available_sma_outputs.attr,
> +	&dev_attr_clock_status_drift.attr,
> +	&dev_attr_clock_status_offset.attr,
> +	&dev_attr_ts_window_adjust.attr,
> +	&dev_attr_tod_correction.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group adva_timecard_group = {
> +	.attrs = adva_timecard_attrs,
> +};
> +
> +static const struct ocp_attr_group adva_timecard_groups[] = {
> +	{ .cap = OCP_CAP_BASIC,	    .group = &adva_timecard_group },
> +	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal0_group },
> +	{ .cap = OCP_CAP_FREQ,	    .group = &fb_timecard_freq0_group },
> +	{ },
> +};
> +

Don't forget to configure fw_cap field correctly when you change init
function.

>   static void
>   gpio_input_map(char *buf, struct ptp_ocp *bp, u16 map[][2], u16 bit,
>   	       const char *def)

---
pw-bot: cr

