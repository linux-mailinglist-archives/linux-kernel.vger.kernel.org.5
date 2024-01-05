Return-Path: <linux-kernel+bounces-18366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0112C825C1B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A400628510C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4507122EF1;
	Fri,  5 Jan 2024 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+B23zuI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEED225CF;
	Fri,  5 Jan 2024 21:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94668C433C7;
	Fri,  5 Jan 2024 21:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704490029;
	bh=MSvK0YSrVz1QlpLijrS22XUNQU4szhEzReI8uN+n+0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+B23zuI3xK/gY/o0sxfFa5ya/2Cspmo9ntle+URDTEnEQzSI1YoaR5ljGMKLvlVy
	 HgFmR/m/7oKMgffSnYSExmWqcNF6+YVena8OHwzFQD7hw2rfp2jhCYKdkH97urS0Bu
	 yyXxo1dOxE7cq27F9kb7KA5fCgsCUOxm9T5QTO0nAXnEeBf/zbJ3Wdu+ND4HHVOGW+
	 dYDpgOVG/nAp+ZgBh45W/8/Z2AkPpl5U0O56SuMZdNMR0qFGbY53iPSZJ8aps0pVm2
	 tksIXIMeVzux/YZIYmlKePiC/phj0zftAmKrTjEf9dYkQ4WNzSa3VAOn7msSYgFX2A
	 M2G5bWuIENhIA==
Date: Fri, 5 Jan 2024 21:27:04 +0000
From: Simon Horman <horms@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v7 2/2] ptp: add FemtoClock3 Wireless as ptp
 hardware clock
Message-ID: <20240105212704.GB31813@kernel.org>
References: <20240105152313.24235-1-lnimi@hotmail.com>
 <PH7PR03MB706426DF26B4443DF1350E07A0662@PH7PR03MB7064.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR03MB706426DF26B4443DF1350E07A0662@PH7PR03MB7064.namprd03.prod.outlook.com>

On Fri, Jan 05, 2024 at 10:23:13AM -0500, Min Li wrote:
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

some minor suggestions from my side.

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

IMHO messages like the one above offer no value to users.
I would remove it and similar messages.

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

nit: sync_ns is set but unused in this function.
     I think you can remove sync_ns from this function and simply do:

	ns2counters(idtfc3, offset_ns + now_ns, &sub_ns);


> +
> +	counter = sub_ns / idtfc3->ns_per_counter;
> +	return idtfc3_timecounter_update(idtfc3, counter, now_ns);
> +}

...

