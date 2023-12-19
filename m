Return-Path: <linux-kernel+bounces-5095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5637A818688
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DBC1F23E44
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2912315AE3;
	Tue, 19 Dec 2023 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDe2rwg4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7813818622;
	Tue, 19 Dec 2023 11:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8111BC433C7;
	Tue, 19 Dec 2023 11:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702986104;
	bh=cDfdWiJtmGvrJUbve2kGHiBiXY9df2MDs0UH8gsu9X4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDe2rwg4TIs6ightcF3BIQ4XZ3x8mbAYXbgDUUb+QVqC5dJWXMktgxW165/4dXr49
	 vh4dLBWE/Ig0wYT6+Ck0zMgqrBoONaT6X0bCA2psMEYVK+d/RhEujbRTOV4owNafl4
	 yDUR8WT3YN0QQ4/IbZvYu0Pr+0aOvDI6vtdA2YrnsZ7XGNmlrJS2n441/mIjWxcbpM
	 ipXYrfn6+P4PgUa8ec86g9dQ32bvTWoFYwUeGNjcdJE20oc1WrQv63xtzKmAiY6eYD
	 hmVG3mnnNNY2weFnhJuw1flSGR21NOjoyord3u1/s66eWdbbSTonFik2TsVXMkvz9P
	 awhcqY4gBlWXA==
Date: Tue, 19 Dec 2023 11:41:41 +0000
From: Simon Horman <horms@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v4 2/2] ptp: add FemtoClock3 Wireless as ptp
 hardware clock
Message-ID: <20231219114141.GK811967@kernel.org>
References: <20231218165045.27847-1-lnimi@hotmail.com>
 <PH7PR03MB70644D12BC9B5B02AF5ADFC2A090A@PH7PR03MB7064.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR03MB70644D12BC9B5B02AF5ADFC2A090A@PH7PR03MB7064.namprd03.prod.outlook.com>

On Mon, Dec 18, 2023 at 11:50:45AM -0500, Min Li wrote:
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

...

> diff --git a/drivers/ptp/ptp_fc3.c b/drivers/ptp/ptp_fc3.c
> new file mode 100644
> index 000000000..b9ef0c963
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
> +
> +static s64 ns2counters(struct idtfc3 *idtfc3, s64 nsec, u32 *sub_ns)
> +{
> +	s64 sync;
> +	s32 rem;
> +
> +	if (likely(nsec >= 0)) {
> +		sync = div_u64_rem(nsec, idtfc3->ns_per_sync, &rem);
> +		*sub_ns = rem;
> +	} else if (nsec < 0) {
> +		sync = -div_u64_rem(-nsec - 1, idtfc3->ns_per_sync, &rem) - 1;
> +		*sub_ns = idtfc3->ns_per_sync - rem - 1;
> +	}

Hi Min Li,

Clang is a bit unhappy about the constriction above,
because it doesn't see that sync is set for all possible values of nsec.

Could we go for the following, which TBH is easier on my eyes too.

	if (likely(nsec >= 0)) {
		...
	} else {
		...
	}

> +
> +	return sync * idtfc3->ns_per_sync;
> +}
> +
> +static s64 tdc_meas2offset(struct idtfc3 *idtfc3, u64 meas_read)
> +{
> +	s64 coarse, fine;
> +
> +	fine = sign_extend64(FIELD_GET(FINE_MEAS_MASK, meas_read), 12);
> +	coarse = sign_extend64(FIELD_GET(COARSE_MEAS_MASK, meas_read), (39 - 13));
> +
> +	fine = div64_s64(fine * NSEC_PER_SEC, idtfc3->tdc_apll_freq * 62LL);
> +	coarse = div64_s64(coarse * NSEC_PER_SEC, idtfc3->time_ref_freq);
> +
> +	return coarse + fine;
> +}
> +
> +static s64 tdc_offset2phase(struct idtfc3 *idtfc3, s64 offset_ns)
> +{
> +	if (offset_ns > idtfc3->ns_per_sync / 2)
> +		offset_ns -= idtfc3->ns_per_sync;
> +
> +	return offset_ns * idtfc3->tdc_offset_sign;
> +}
> +
> +static int idtfc3_set_lpf_mode(struct idtfc3 *idtfc3, u8 mode)
> +{
> +	int err;
> +
> +	if (mode >= LPF_INVALID)
> +		return -EINVAL;
> +
> +	if (idtfc3->lpf_mode == mode)
> +		return 0;
> +
> +	err = regmap_bulk_write(idtfc3->regmap, LPF_MODE_CNFG, &mode, sizeof(mode));
> +	if (err)
> +		return err;
> +
> +	idtfc3->lpf_mode = mode;
> +
> +	return 0;
> +}
> +
> +static int idtfc3_enable_lpf(struct idtfc3 *idtfc3, bool enable)
> +{
> +	u8 val;
> +	int err;
> +
> +	err = regmap_bulk_read(idtfc3->regmap, LPF_CTRL, &val, sizeof(val));
> +	if (err)
> +		return err;
> +
> +	if (enable == true)
> +		val |= LPF_EN;
> +	else
> +		val &= ~LPF_EN;
> +
> +	return regmap_bulk_write(idtfc3->regmap, LPF_CTRL, &val, sizeof(val));
> +}
> +
> +static int idtfc3_get_time_ref_freq(struct idtfc3 *idtfc3)
> +{
> +	int err;
> +	u8 buf[4];
> +	u8 time_ref_div;
> +	u8 time_clk_div;
> +
> +	err = regmap_bulk_read(idtfc3->regmap, TIME_CLOCK_MEAS_DIV_CNFG, buf, sizeof(buf));
> +	if (err)
> +		return err;
> +	time_ref_div = FIELD_GET(TIME_REF_DIV_MASK, get_unaligned_le32(buf)) + 1;
> +
> +	err = regmap_bulk_read(idtfc3->regmap, TIME_CLOCK_COUNT, buf, 1);
> +	if (err)
> +		return err;
> +	time_clk_div = (buf[0] & TIME_CLOCK_COUNT_MASK) + 1;
> +	idtfc3->time_ref_freq = idtfc3->hw_param.time_clk_freq *
> +				time_clk_div / time_ref_div;
> +
> +	return 0;
> +}
> +
> +static int idtfc3_get_tdc_offset_sign(struct idtfc3 *idtfc3)
> +{
> +	int err;
> +	u8 buf[4];
> +	u32 val;
> +	u8 sig1, sig2;
> +
> +	err = regmap_bulk_read(idtfc3->regmap, TIME_CLOCK_TDC_FANOUT_CNFG, buf, sizeof(buf));
> +	if (err)
> +		return err;
> +
> +	val = get_unaligned_le32(buf);
> +	if ((val & TIME_SYNC_TO_TDC_EN) != TIME_SYNC_TO_TDC_EN) {
> +		dev_err(idtfc3->dev, "TIME_SYNC_TO_TDC_EN is off !!!");
> +		return -EINVAL;
> +	}
> +
> +	sig1 = FIELD_GET(SIG1_MUX_SEL_MASK, val);
> +	sig2 = FIELD_GET(SIG2_MUX_SEL_MASK, val);
> +
> +	if ((sig1 == sig2) || ((sig1 != TIME_SYNC) && (sig2 != TIME_SYNC))) {
> +		dev_err(idtfc3->dev, "Invalid tdc_mux_sel sig1=%d sig2=%d", sig1, sig2);
> +		return -EINVAL;
> +	} else if (sig1 == TIME_SYNC) {
> +		idtfc3->tdc_offset_sign = 1;
> +	} else if (sig2 == TIME_SYNC) {
> +		idtfc3->tdc_offset_sign = -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int idtfc3_lpf_bw(struct idtfc3 *idtfc3, u8 shift, u8 mult)
> +{
> +	u8 val = FIELD_PREP(LPF_BW_SHIFT, shift) | FIELD_PREP(LPF_BW_MULT, mult);
> +
> +	return regmap_bulk_write(idtfc3->regmap, LPF_BW_CNFG, &val, sizeof(val));
> +}
> +
> +static int idtfc3_enable_tdc(struct idtfc3 *idtfc3, bool enable, u8 meas_mode)
> +{
> +	int err;
> +	u8 val = 0;
> +
> +	/* Disable TDC first */
> +	err = regmap_bulk_write(idtfc3->regmap, TIME_CLOCK_MEAS_CTRL, &val, sizeof(val));
> +	if (err)
> +		return err;
> +
> +	if (enable == false)
> +		return idtfc3_lpf_bw(idtfc3, LPF_BW_SHIFT_DEFAULT, LPF_BW_MULT_DEFAULT);
> +
> +	if (meas_mode >= MEAS_MODE_INVALID)
> +		return -EINVAL;
> +
> +	/* Change TDC meas mode */
> +	err = regmap_bulk_write(idtfc3->regmap, TIME_CLOCK_MEAS_CNFG,
> +				&meas_mode, sizeof(meas_mode));
> +	if (err)
> +		return err;
> +
> +	/* Enable TDC */
> +	val = TDC_MEAS_EN;
> +	if (meas_mode == CONTINUOUS)
> +		val |= TDC_MEAS_START;
> +	err = regmap_bulk_write(idtfc3->regmap, TIME_CLOCK_MEAS_CTRL, &val, sizeof(val));
> +	if (err)
> +		return err;
> +
> +	return idtfc3_lpf_bw(idtfc3, LPF_BW_SHIFT_1PPS, LPF_BW_MULT_DEFAULT);
> +}
> +
> +static bool get_tdc_meas(struct idtfc3 *idtfc3, s64 *offset_ns)
> +{
> +	bool valid = false;
> +	u8 buf[9];
> +	u8 val;
> +	int err;
> +
> +	while (true) {
> +		err = regmap_bulk_read(idtfc3->regmap, TDC_FIFO_STS,
> +				       &val, sizeof(val));
> +		if (err)
> +			return false;
> +
> +		if (val & FIFO_EMPTY)
> +			break;
> +
> +		err = regmap_bulk_read(idtfc3->regmap, TDC_FIFO_READ_REQ,
> +				       &buf, sizeof(buf));
> +		if (err)
> +			return false;
> +
> +		valid = true;
> +	}
> +
> +	if (valid)
> +		*offset_ns = tdc_meas2offset(idtfc3, get_unaligned_le64(&buf[1]));
> +
> +	return valid;
> +}
> +
> +static int check_tdc_fifo_overrun(struct idtfc3 *idtfc3)
> +{
> +	u8 val;
> +	int err;
> +
> +	/* Check if FIFO is overrun */
> +	err = regmap_bulk_read(idtfc3->regmap, TDC_FIFO_STS, &val, sizeof(val));
> +	if (err)
> +		return err;
> +
> +	if (!(val & FIFO_FULL))
> +		return 0;
> +
> +	dev_warn(idtfc3->dev, "TDC FIFO overrun !!!");
> +
> +	err = idtfc3_enable_tdc(idtfc3, true, CONTINUOUS);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int get_tdc_meas_continuous(struct idtfc3 *idtfc3)
> +{
> +	int err;
> +	s64 offset_ns;
> +	struct ptp_clock_event event;
> +
> +	err = check_tdc_fifo_overrun(idtfc3);
> +	if (err)
> +		return err;
> +
> +	if (get_tdc_meas(idtfc3, &offset_ns) && offset_ns >= 0) {
> +		event.index = 0;
> +		event.offset = tdc_offset2phase(idtfc3, offset_ns);
> +		event.type = PTP_CLOCK_EXTOFF;
> +		ptp_clock_event(idtfc3->ptp_clock, &event);
> +	}
> +
> +	return 0;
> +}
> +
> +static int idtfc3_read_subcounter(struct idtfc3 *idtfc3)
> +{
> +	u8 buf[5] = {0};
> +	int err;
> +
> +	err = regmap_bulk_read(idtfc3->regmap, TOD_COUNTER_READ_REQ,
> +			       &buf, sizeof(buf));
> +	if (err)
> +		return err;
> +
> +	/* sync_counter_value is [31:82] and sub_sync_counter_value is [0:30] */
> +	return get_unaligned_le32(&buf[1]) & SUB_SYNC_COUNTER_MASK;
> +}
> +
> +static int idtfc3_tod_update_is_done(struct idtfc3 *idtfc3)
> +{
> +	int err;
> +	u8 req;
> +
> +	err = read_poll_timeout_atomic(regmap_bulk_read, err, !req, USEC_PER_MSEC,
> +				       idtfc3->tc_write_timeout, true, idtfc3->regmap,
> +				       TOD_SYNC_LOAD_REQ_CTRL, &req, 1);
> +	if (err)
> +		dev_err(idtfc3->dev, "TOD counter write timeout !!!");
> +
> +	return err;
> +}
> +
> +static int idtfc3_write_subcounter(struct idtfc3 *idtfc3, u32 counter)
> +{
> +	u8 buf[18] = {0};
> +	int err;
> +
> +	/* sync_counter_value is [31:82] and sub_sync_counter_value is [0:30] */
> +	put_unaligned_le32(counter & SUB_SYNC_COUNTER_MASK, &buf[0]);
> +
> +	buf[16] = SUB_SYNC_LOAD_ENABLE | SYNC_LOAD_ENABLE;
> +	buf[17] = SYNC_LOAD_REQ;
> +
> +	err = regmap_bulk_write(idtfc3->regmap, TOD_SYNC_LOAD_VAL_CTRL,
> +				&buf, sizeof(buf));
> +	if (err)
> +		return err;
> +
> +	return idtfc3_tod_update_is_done(idtfc3);
> +}
> +
> +static int idtfc3_timecounter_update(struct idtfc3 *idtfc3, u32 counter, s64 ns)
> +{
> +	int err;
> +
> +	err = idtfc3_write_subcounter(idtfc3, counter);
> +	if (err)
> +		return err;
> +
> +	/* Update time counter */
> +	idtfc3->ns = ns;
> +	idtfc3->last_counter = counter;
> +
> +	return 0;
> +}
> +
> +static int idtfc3_timecounter_read(struct idtfc3 *idtfc3)
> +{
> +	int now, delta;
> +
> +	now = idtfc3_read_subcounter(idtfc3);
> +	if (now < 0)
> +		return now;
> +
> +	/* calculate the delta since the last idtfc3_timecounter_read(): */
> +	if (now >= idtfc3->last_counter)
> +		delta = now - idtfc3->last_counter;
> +	else
> +		delta = idtfc3->sub_sync_count - idtfc3->last_counter + now;
> +
> +	/* Update time counter */
> +	idtfc3->ns += delta * idtfc3->ns_per_counter;
> +	idtfc3->last_counter = now;
> +
> +	return 0;
> +}
> +
> +static int _idtfc3_gettime(struct idtfc3 *idtfc3, struct timespec64 *ts)
> +{
> +	int err;
> +
> +	err = idtfc3_timecounter_read(idtfc3);
> +	if (err)
> +		return err;
> +
> +	*ts = ns_to_timespec64(idtfc3->ns);
> +
> +	return 0;
> +}
> +
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

Please drop the log above, it doesn't seem useful to users.
Likewise elsewhere in this patch.

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

Likewise, please drop the __func__ portion of the log above,
or the entire log message.

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

sync_ns is set but unused in this function.

Flagged by W=1 builds.

> +
> +	counter = sub_ns / idtfc3->ns_per_counter;
> +	return idtfc3_timecounter_update(idtfc3, counter, now_ns);
> +}
> +
> +static int idtfc3_settime(struct ptp_clock_info *ptp, const struct timespec64 *ts)
> +{
> +	struct idtfc3 *idtfc3 = container_of(ptp, struct idtfc3, caps);
> +	int err;
> +
> +	mutex_lock(idtfc3->lock);
> +	err = _idtfc3_settime(idtfc3, ts);
> +	mutex_unlock(idtfc3->lock);
> +
> +	if (err)
> +		dev_err(idtfc3->dev,
> +			"Failed at line %d in %s!", __LINE__, __func__);
> +
> +	return err;
> +}
> +
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

The line above is not indented correctly:

	return idtfc3_timecounter_update(idtfc3, counter, idtfc3->ns + sync_ns +
					 counter * idtfc3->ns_per_counter);

> +}
> +
> +static int idtfc3_adjtime(struct ptp_clock_info *ptp, s64 delta)
> +{
> +	struct idtfc3 *idtfc3 = container_of(ptp, struct idtfc3, caps);
> +	int err;
> +
> +	mutex_lock(idtfc3->lock);
> +	err = _idtfc3_adjtime(idtfc3, delta);
> +	mutex_unlock(idtfc3->lock);
> +
> +	if (err)
> +		dev_err(idtfc3->dev,
> +			"Failed at line %d in %s!", __LINE__, __func__);
> +
> +	return err;
> +}
> +
> +static int _idtfc3_adjphase(struct idtfc3 *idtfc3, s32 delta)
> +{
> +	u8 buf[8] = {0};
> +	int err;
> +	s64 pcw;
> +
> +	err = idtfc3_set_lpf_mode(idtfc3, LPF_WP);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Phase Control Word unit is: 10^9 / (TDC_APLL_FREQ * 124)
> +	 *
> +	 *       delta * TDC_APLL_FREQ * 124
> +	 * PCW = ---------------------------
> +	 *                  10^9
> +	 *
> +	 */
> +	pcw = div_s64((s64)delta * idtfc3->tdc_apll_freq * 124, NSEC_PER_SEC);
> +
> +	put_unaligned_le64(pcw, buf);
> +
> +	return regmap_bulk_write(idtfc3->regmap, LPF_WR_PHASE_CTRL, buf, sizeof(buf));
> +}
> +
> +static int idtfc3_adjphase(struct ptp_clock_info *ptp, s32 delta)
> +{
> +	struct idtfc3 *idtfc3 = container_of(ptp, struct idtfc3, caps);
> +	int err;
> +
> +	mutex_lock(idtfc3->lock);
> +	err = _idtfc3_adjphase(idtfc3, delta);
> +	mutex_unlock(idtfc3->lock);
> +
> +	if (err)
> +		dev_err(idtfc3->dev,
> +			"Failed at line %d in %s!", __LINE__, __func__);
> +
> +	return err;
> +}
> +
> +static int _idtfc3_adjfine(struct idtfc3 *idtfc3, long scaled_ppm)
> +{
> +	u8 buf[8] = {0};
> +	int err;
> +	s64 fcw;
> +
> +	err = idtfc3_set_lpf_mode(idtfc3, LPF_WF);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Frequency Control Word unit is: 2^-44 * 10^6 ppm
> +	 *
> +	 * adjfreq:
> +	 *       ppb * 2^44
> +	 * FCW = ----------
> +	 *          10^9
> +	 *
> +	 * adjfine:
> +	 *       ppm_16 * 2^28
> +	 * FCW = -------------
> +	 *           10^6
> +	 */
> +	fcw = scaled_ppm * BIT(28);
> +	fcw = div_s64(fcw, 1000000);
> +
> +	put_unaligned_le64(fcw, buf);
> +
> +	return regmap_bulk_write(idtfc3->regmap, LPF_WR_FREQ_CTRL, buf, sizeof(buf));
> +}
> +
> +static int idtfc3_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
> +{
> +	struct idtfc3 *idtfc3 = container_of(ptp, struct idtfc3, caps);
> +	int err;
> +
> +	mutex_lock(idtfc3->lock);
> +	err = _idtfc3_adjfine(idtfc3, scaled_ppm);
> +	mutex_unlock(idtfc3->lock);
> +
> +	if (err)
> +		dev_err(idtfc3->dev,
> +			"Failed at line %d in %s!", __LINE__, __func__);
> +
> +	return err;
> +}
> +
> +static int idtfc3_enable(struct ptp_clock_info *ptp,
> +			 struct ptp_clock_request *rq, int on)
> +{
> +	struct idtfc3 *idtfc3 = container_of(ptp, struct idtfc3, caps);
> +	int err = -EOPNOTSUPP;
> +
> +	mutex_lock(idtfc3->lock);
> +		switch (rq->type) {
> +		case PTP_CLK_REQ_PEROUT:
> +			if (!on)
> +				err = 0;
> +			/* Only accept a 1-PPS aligned to the second. */
> +			else if (rq->perout.start.nsec || rq->perout.period.sec != 1 ||
> +				 rq->perout.period.nsec)
> +				err = -ERANGE;
> +			else
> +				err = 0;
> +			break;
> +		case PTP_CLK_REQ_EXTTS:
> +			if (on) {
> +				/* Only accept requests for external phase offset */
> +				if ((rq->extts.flags & PTP_EXT_OFFSET) != (PTP_EXT_OFFSET))
> +					err = -EOPNOTSUPP;
> +				else
> +					err = idtfc3_enable_tdc(idtfc3, true, CONTINUOUS);
> +			} else {
> +				err = idtfc3_enable_tdc(idtfc3, false, MEAS_MODE_INVALID);
> +			}
> +			break;
> +		default:
> +			break;
> +		}

The entire switch block above appears to be indented one tab too many.

> +	mutex_unlock(idtfc3->lock);
> +
> +	if (err)
> +		dev_err(idtfc3->dev, "Failed in %s with err %d!", __func__, err);
> +
> +	return err;
> +}

-- 
pw-bot: changes-requested

