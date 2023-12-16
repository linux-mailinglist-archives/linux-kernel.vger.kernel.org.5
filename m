Return-Path: <linux-kernel+bounces-2285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3857B815A86
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6DF71F23964
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D4A3067E;
	Sat, 16 Dec 2023 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzOQJ/4i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8224D25753;
	Sat, 16 Dec 2023 16:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E910C433C7;
	Sat, 16 Dec 2023 16:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702745663;
	bh=et2dufk1JAl2d5SC0mxEbRHj4izs/VfdpHsks5fnkYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FzOQJ/4iSpAvwIxRTqhUM15ILhka1mHrGJfOhgRkkzicZnAiRbsrf065DFyfqmR8A
	 b8XZDyZFPajgRrhMAbPcWPPpSwRFROaL8aHdq4HxTMY95b/uipb2vlsoMAFUXrjB05
	 EPeNVN1dVqtnweIxNe2lJVQdD3U5rQ9ruZ4v5JFn4bUtgqSvUPk4xRHjJiPp9UJD71
	 t8DumVi9rZgi72fKhgq5JbUKDJSJDUHN+MaYRn+k5R4IFItGwX24aa2MyaQ68brpu4
	 BU1zFn9ZCpRr0AxhKQDSCyKkebruWXR/yLw0BH6qG+Jqk8WYrQMAvLe9PcN34/blPO
	 wENT5kG4KIsag==
Date: Sat, 16 Dec 2023 16:54:18 +0000
From: Simon Horman <horms@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v3 2/2] ptp: add FemtoClock3 Wireless as ptp
 hardware clock
Message-ID: <20231216165418.GO6288@kernel.org>
References: <20231214163625.17939-1-lnimi@hotmail.com>
 <PH7PR03MB7064D4543F1EE6E0A45053C8A08CA@PH7PR03MB7064.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR03MB7064D4543F1EE6E0A45053C8A08CA@PH7PR03MB7064.namprd03.prod.outlook.com>

On Thu, Dec 14, 2023 at 11:36:25AM -0500, Min Li wrote:
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

Hi Min Li,

thanks for your patch.
Please find some feedback from me inline.

...

> diff --git a/drivers/ptp/ptp_fc3.c b/drivers/ptp/ptp_fc3.c
> new file mode 100644
> index 000000000..f5614c46c
> --- /dev/null
> +++ b/drivers/ptp/ptp_fc3.c
> @@ -0,0 +1,1036 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * PTP hardware clock driver for the FemtoClock3 family of timing and
> + * synchronization devices.
> + *
> + * Copyright (C) 2023 Integrated Device Technology, Inc., a Renesas Company.
> + */
> +#include <linux/firmware.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/ptp_clock_kernel.h>
> +#include <linux/delay.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/timekeeping.h>
> +#include <linux/string.h>
> +#include <linux/of.h>
> +#include <linux/bitfield.h>
> +#include <linux/mfd/rsmu.h>
> +#include <linux/mfd/idtRC38xxx_reg.h>
> +#include <asm/unaligned.h>
> +
> +#include "ptp_private.h"
> +#include "ptp_fc3.h"
> +
> +MODULE_DESCRIPTION("Driver for IDT FemtoClock3(TM) family");
> +MODULE_AUTHOR("IDT support-1588 <IDT-support-1588@lm.renesas.com>");
> +MODULE_VERSION("1.0");
> +MODULE_LICENSE("GPL");
> +
> +/*
> + * The name of the firmware file to be loaded
> + * over-rides any automatic selection
> + */
> +static char *firmware;
> +module_param(firmware, charp, 0);

I'm mildly surprised to see module_param being added to upstream code.

> +
> +static inline s64 ns2counters(struct idtfc3 *idtfc3, s64 nsec, u32 *sub_ns)
> +{
> +	s64 sync;
> +	s32 rem;
> +
> +	if (likely(nsec >= 0)) {
> +		sync = div_u64_rem(nsec, idtfc3->ns_per_sync, &rem);
> +		*sub_ns = rem;
> +	} else if (nsec < 0) {

nit: I think '} else {' would suffice here.

> +		sync = -div_u64_rem(-nsec - 1, idtfc3->ns_per_sync, &rem) - 1;
> +		*sub_ns = idtfc3->ns_per_sync - rem - 1;
> +	}
> +
> +	return sync * idtfc3->ns_per_sync;
> +}

...

> +static int idtfc3_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
> +{
> +	struct idtfc3 *idtfc3 = container_of(ptp, struct idtfc3, caps);
> +	int err;
> +
> +	mutex_lock(idtfc3->lock);
> +	err = _idtfc3_gettime(idtfc3, ts);
> +	mutex_unlock(idtfc3->lock);
> +
> +	if (err)
> +		dev_err(idtfc3->dev, "Failed at line %d in %s!",
> +			__LINE__, __func__);

I don't think error messages of this form are appropriate for
upstream driver code. Please either log something that is
informative to users (as distinct from developers0, or omit
the log messages.

Likewise elsewhere in ptp_fc3.c.
And please consider updating ptp_clockmatrix.c too.

> +
> +	return err;
> +}
> +
> +static int _idtfc3_settime(struct idtfc3 *idtfc3, const struct timespec64 *ts)
> +{
> +	s64 offset_ns, now_ns, sync_ns;
> +	u32 counter, sub_ns;
> +	int now;
> +
> +	if (timespec64_valid(ts) == false) {
> +		dev_err(idtfc3->dev, "%s: invalid timespec", __func__);

Ditto.
And please consider updating ptp_idt82p33.c too.

> +		return -EINVAL;
> +	}
> +
> +	now = idtfc3_read_subcounter(idtfc3);
> +	if (now < 0)
> +		return now;
> +
> +	offset_ns = (idtfc3->sub_sync_count - now) * idtfc3->ns_per_counter;
> +	now_ns = timespec64_to_ns(ts);
> +	sync_ns = ns2counters(idtfc3, offset_ns + now_ns, &sub_ns);
> +
> +	counter = sub_ns / idtfc3->ns_per_counter;
> +	return idtfc3_timecounter_update(idtfc3, counter, now_ns);
> +}

...

> +static int _idtfc3_adjtime(struct idtfc3 *idtfc3, s64 delta)
> +{
> +	/*
> +	 * The TOD counter can be synchronously loaded with any value,
> +	 * to be loaded on the next Time Sync pulse
> +	 */
> +	s64 sync_ns;
> +	u32 sub_ns;
> +	u32 counter;
> +
> +	if (idtfc3->ns + delta < 0) {
> +		dev_err(idtfc3->dev, "%lld ns adj is too large", delta);
> +		return -EINVAL;
> +	}
> +
> +	sync_ns = ns2counters(idtfc3, delta + idtfc3->ns_per_sync, &sub_ns);
> +
> +	counter = sub_ns / idtfc3->ns_per_counter;
> +	return idtfc3_timecounter_update(idtfc3, counter, idtfc3->ns + sync_ns +
> +									counter * idtfc3->ns_per_counter);

nit: the indentation of the line above is not correct.

	return idtfc3_timecounter_update(idtfc3, counter, idtfc3->ns + sync_ns +
					 counter * idtfc3->ns_per_counter);

...

> +static int idtfc3_enable_ptp(struct idtfc3 *idtfc3)
> +{
> +	int err;
> +
> +	idtfc3->caps = idtfc3_caps;
> +	snprintf(idtfc3->caps.name, sizeof(idtfc3->caps.name), "IDT FC3W");
> +	idtfc3->ptp_clock = ptp_clock_register(&idtfc3->caps, NULL);
> +
> +	if (IS_ERR(idtfc3->ptp_clock)) {
> +		err = PTR_ERR(idtfc3->ptp_clock);
> +		idtfc3->ptp_clock = NULL;
> +		return err;
> +	}
> +
> +	err = idtfc3_set_overhead(idtfc3);
> +	if (err)
> +		return err;

I think that ptp_clock probably needs to be unregistered here
(completely untested!):


	err = idtfc3_set_overhead(idtfc3);
	if (err)
		goto err_unregister;

	...

err_unregister:
	ptp_clock_unregister(idtfc3->ptp_clock);
err_no_clock:
	idtfc3->ptp_clock = NULL;
	return err;

> +
> +	err = idtfc3_init_timecounter(idtfc3);
> +	if (err)
> +		return err;

And here.

> +
> +	dev_info(idtfc3->dev, "TIME_SYNC_CHANNEL registered as ptp%d",
> +		 idtfc3->ptp_clock->index);
> +
> +	return 0;
> +}
> +
> +static int idtfc3_load_firmware(struct idtfc3 *idtfc3)
> +{
> +	char fname[128] = FW_FILENAME;
> +	const struct firmware *fw;
> +	struct idtfc3_fwrc *rec;
> +	u16 addr;
> +	u8 val;
> +	int err;
> +	s32 len;
> +
> +	idtfc3_default_hw_param(&idtfc3->hw_param);
> +
> +	if (firmware) /* module parameter */
> +		snprintf(fname, sizeof(fname), "%s", firmware);
> +
> +	dev_info(idtfc3->dev, "requesting firmware '%s'\n", fname);
> +
> +	err = request_firmware(&fw, fname, idtfc3->dev);
> +
> +	if (err) {
> +		dev_err(idtfc3->dev,
> +			"requesting firmware failed with err %d!\n", err);
> +		return err;
> +	}
> +
> +	dev_dbg(idtfc3->dev, "firmware size %zu bytes\n", fw->size);
> +
> +	rec = (struct idtfc3_fwrc *)fw->data;
> +
> +	for (len = fw->size; len > 0; len -= sizeof(*rec)) {
> +		if (rec->reserved) {
> +			dev_err(idtfc3->dev,
> +				"bad firmware, reserved field non-zero\n");
> +			err = -EINVAL;
> +		} else {
> +			val = rec->value;
> +			addr = rec->hiaddr << 8 | rec->loaddr;
> +
> +			rec++;
> +
> +			err = idtfc3_set_hw_param(&idtfc3->hw_param, addr, val);
> +		}
> +
> +		if (err != -EINVAL) {
> +			err = 0;
> +
> +			/* Max register */
> +			if (addr >= 0xE88)
> +				continue;
> +
> +			err = regmap_bulk_write(idtfc3->regmap, addr,
> +						&val, sizeof(val));
> +		}
> +
> +		if (err)
> +			goto out;
> +	}

I think that in kernel code it is preferred to handle errors up-front by
returning, and so on, rather than nesting. In this case I think that leads
to a simpler flow (at least for my eyes).

Completely untested!

	for (len = fw->size; len > 0; len -= sizeof(*rec)) {
		if (rec->reserved) {
			dev_err(idtfc3->dev,
				"bad firmware, reserved field non-zero\n");
			err = -EINVAL;
			goto out;
		}

		val = rec->value;
		addr = rec->hiaddr << 8 | rec->loaddr;
		rec++;

		err = idtfc3_set_hw_param(&idtfc3->hw_param, addr, val);
		if (err == -EINVAL)
			goto out;

		/* Max register */
		if (addr >= 0xE88)
			continue;

		err = regmap_bulk_write(idtfc3->regmap, addr,
					&val, sizeof(val));
		if (err)
			goto out;
	}

> +
> +	err = idtfc3_configure_hw(idtfc3);
> +out:
> +	release_firmware(fw);
> +	return err;
> +}
> +
> +static int idtfc3_read_device_id(struct idtfc3 *idtfc3, u16 *device_id)
> +{
> +	int err;
> +	u8 buf[2] = {0};
> +
> +	err = regmap_bulk_read(idtfc3->regmap, DEVICE_ID,
> +			       &buf, sizeof(buf));

nit: the above fits on one line (< columns wide)

> +	if (err) {
> +		dev_err(idtfc3->dev, "%s failed with %d", __func__, err);
> +		return err;
> +	}
> +
> +	*device_id = get_unaligned_le16(buf);
> +
> +	return 0;
> +}

...

> +static int idtfc3_probe(struct platform_device *pdev)
> +{
> +	struct rsmu_ddata *ddata = dev_get_drvdata(pdev->dev.parent);
> +	struct idtfc3 *idtfc3;
> +	int err;
> +
> +	idtfc3 = devm_kzalloc(&pdev->dev, sizeof(struct idtfc3), GFP_KERNEL);
> +
> +	if (!idtfc3)
> +		return -ENOMEM;
> +
> +	idtfc3->dev = &pdev->dev;
> +	idtfc3->mfd = pdev->dev.parent;
> +	idtfc3->lock = &ddata->lock;
> +	idtfc3->regmap = ddata->regmap;
> +
> +	mutex_lock(idtfc3->lock);
> +
> +	err = idtfc3_check_device_compatibility(idtfc3);
> +	if (err) {
> +		mutex_unlock(idtfc3->lock);
> +		return err;
> +	}
> +
> +	err = idtfc3_load_firmware(idtfc3);
> +	if (err) {
> +		if (err == -ENOENT) {
> +			mutex_unlock(idtfc3->lock);

Please use a goto label to handle the unlock error cases.

> +			return -EPROBE_DEFER;
> +		}
> +		dev_warn(idtfc3->dev, "loading firmware failed with %d", err);
> +	}
> +
> +	err = idtfc3_enable_ptp(idtfc3);
> +	if (err) {
> +		dev_err(idtfc3->dev, "idtfc3_enable_ptp failed with %d", err);
> +		mutex_unlock(idtfc3->lock);
> +		return err;
> +	}
> +
> +	mutex_unlock(idtfc3->lock);
> +
> +	if (err) {

I don't think execution can ever get here.

...

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

nit: It may not be relevant, but FWIIW the above layout has a number
     of holes in it according to pahole.

> +
> +#endif /* PTP_IDTFC3_H */
> diff --git a/include/linux/mfd/idtRC38xxx_reg.h b/include/linux/mfd/idtRC38xxx_reg.h

...

> +#define TDC_FIFO_READ_REQ	(0xB2F)
> +#define TDC_FIFO_READ		(0xB30)
> +#define COARSE_MEAS_MASK	GENMASK(39, 13)
> +#define FINE_MEAS_MASK		GENMASK(12, 0)

The above masks are applied to 64 bit entities, and in the
case of COARSE_MEAS_MASK the mask uses more than 32 bits.
However, on some systems GENMASK may produce 32 bit masks.
I think that using GENMASK_ULL is appropriate here.

...

