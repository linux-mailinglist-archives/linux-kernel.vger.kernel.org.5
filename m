Return-Path: <linux-kernel+bounces-2297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E662815AAE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 18:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481741F23CD2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0B930F95;
	Sat, 16 Dec 2023 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bb+gxqNG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7403031A62;
	Sat, 16 Dec 2023 17:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FBFC433C7;
	Sat, 16 Dec 2023 17:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702748557;
	bh=Ay2QNVsNTU6j2GMaTNAhYy4JMuUy7ClKkYEkpFyMsxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bb+gxqNGvyByYwbbyL3AFUiisXcAxAgwnaLLO9CjB2SbIoeikWYnYpgn0WMXAFoCm
	 Ht0Eq/ACYADwaGl8N4YLMtpp1d2Jfcmb7izhZpp7vdkYo+9tjkg1c92bWvWTvr11wY
	 Is/Npoak1g1Iri6CA8iO/iGg9bMW4WtSU6TFa8IMoP7V+/G30zEEKky9L3V+B51eb9
	 KBb2AyKhg1QGhG+fLEKI/zMA8NuVIiVnWcjUkH51UF+DX93MPwjyoh7prjhpkSjl/A
	 a4wMOthqk9BDh8uOwLOBGyP7/K9AW6XnwwMpPW+umL4ujTDNKhuErCIYi3nHX7/OWR
	 P+N1gOrdIV38g==
Date: Sat, 16 Dec 2023 17:42:33 +0000
From: Simon Horman <horms@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v3 2/2] ptp: add FemtoClock3 Wireless as ptp
 hardware clock
Message-ID: <20231216174233.GA48471@kernel.org>
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

...

> diff --git a/drivers/ptp/ptp_fc3.c b/drivers/ptp/ptp_fc3.c

...

> +static inline s64 ns2counters(struct idtfc3 *idtfc3, s64 nsec, u32 *sub_ns)

Sorry, I missed this in my earlier response.

Please don't use inline in .c files unless htere is a demonstrable
reason to do so. Rather, please leave inlining up to the compiler.

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
> +
> +	return sync * idtfc3->ns_per_sync;
> +}
> +
> +static inline s64 tdc_meas2offset(struct idtfc3 *idtfc3, u64 meas_read)
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
> +static inline s64 tdc_offset2phase(struct idtfc3 *idtfc3, s64 offset_ns)
> +{
> +	if (offset_ns > idtfc3->ns_per_sync / 2)
> +		offset_ns -= idtfc3->ns_per_sync;
> +
> +	return offset_ns * idtfc3->tdc_offset_sign;
> +}

...

> +static inline bool get_tdc_meas(struct idtfc3 *idtfc3, s64 *offset_ns)
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
> +static inline int check_tdc_fifo_overrun(struct idtfc3 *idtfc3)
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

...

> +static int idtfc3_remove(struct platform_device *pdev)
> +{
> +	struct idtfc3 *idtfc3 = platform_get_drvdata(pdev);
> +
> +	ptp_clock_unregister(idtfc3->ptp_clock);

FWIIW, I'm slightly surprised that more cleanup isn't needed.

> +
> +	return 0;
> +}
> +
> +static struct platform_driver idtfc3_driver = {
> +	.driver = {
> +		.name = "rc38xxx-phc",
> +	},
> +	.probe = idtfc3_probe,
> +	.remove	= idtfc3_remove,
> +};
> +
> +module_platform_driver(idtfc3_driver);

...

