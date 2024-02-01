Return-Path: <linux-kernel+bounces-48947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00539846378
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B5D1F23FD4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4737246449;
	Thu,  1 Feb 2024 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1XfYw9e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8758046439;
	Thu,  1 Feb 2024 22:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826809; cv=none; b=pb/WV8Ae5K5v5VrJztAtCWD1FVpiJFqm2y2NjoDIX6bU84uLxFViXlsywYPmw/xnb/vmmZBpC98lC1NDRcjePbHyLpMpEK0Elac0S1BjlBBlz69LjkARQbLiiKlzkpQV4bQcMFHu6EK1/syOSAddzku2kUsPJg0Lr1Q1ici8bIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826809; c=relaxed/simple;
	bh=dbpaJ6xp7dnMzLTQgOGkgQ/59dglQ1pro5UKwxRA1ZI=;
	h=Mime-Version:Content-Type:Date:Subject:From:To:Cc:Message-Id:
	 References:In-Reply-To; b=jhF1Sn0PtpM5IBipeZevE+V9trzkXP5Hl2xZWGY+gncX4QDEaITlPdlzYGr/IkxzLewFFnE414ToSVloYViHybdtUEctyQPrNHaJ3roMoy3lQEEH4Beht+jrPv33rUnT9Ng6eyTcY+wtK6wYOd4nfaNyz4dmB5s9fOiPcplxcxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1XfYw9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5769C433C7;
	Thu,  1 Feb 2024 22:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706826809;
	bh=dbpaJ6xp7dnMzLTQgOGkgQ/59dglQ1pro5UKwxRA1ZI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Q1XfYw9eheza+NUrhrdtku/nykjTnSunIqOZjdzuF5y6IfPJpn8ETdm6pxs6XsyS1
	 9pA8xZNw3L833Awrw4mQQH8n7gluq1R1T5GvA1yn+mbqf2/KSK7JGmPx/DL5NZPlK/
	 kXHL/ewGeFBlFiuzqcpE6u62g6+Cltdv08gtwDDEtUF6LoZQnyugUO6xCgXHtVG4LL
	 O5DUH5iLNKfsC3kGjAvIy1R3R4cId3L0SsWYtDOL+E7vwhBm1iqmD/FbUv24yv2fhK
	 b23FDmjFIATI2K/oEaa0BvAUl/OtW1Vuy21WnPbFgwRE11w6GoL0HTxpoQu9cu2gty
	 /w2VtnOLimZdg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Feb 2024 00:33:25 +0200
Subject: Re: [PATCH 2/3] tpm: ensure tpm is in known state at startup
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Peter Huewe"
 <peterhuewe@gmx.de>
Message-Id: <CYU3H17QGBR0.37HWK14BDMGCD@suppilovahvero>
X-Mailer: aerc 0.15.2
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-3-dpsmith@apertussolutions.com>
In-Reply-To: <20240131170824.6183-3-dpsmith@apertussolutions.com>

On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
> When tis core initializes, it assumes all localities are closed. There
       ~~~~~~~~
       tpm_tis_core

> are cases when this may not be the case. This commit addresses this by
> ensuring all localities are closed before initializing begins.

Remove the last sentence and replace with this paragraph:

"Address this by ensuring all the localities are closed in the beginning
of tpm_tis_core_init(). There are environments, like Intel TXT, which
may leave a locality open. Close all localities to start from a known
state."

BTW, why we should motivated to take this patch anyway?

Since the patch is not marked as a bug fix the commit message must pitch
why it is important to care.

> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
>  include/linux/tpm.h             |  6 ++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index 4176d3bd1f04..5709f87991d9 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1109,7 +1109,7 @@ int tpm_tis_core_init(struct device *dev, struct tp=
m_tis_data *priv, int irq,
>  	u32 intmask;
>  	u32 clkrun_val;
>  	u8 rid;
> -	int rc, probe;
> +	int rc, probe, i;
>  	struct tpm_chip *chip;
> =20
>  	chip =3D tpmm_chip_alloc(dev, &tpm_tis);
> @@ -1170,6 +1170,15 @@ int tpm_tis_core_init(struct device *dev, struct t=
pm_tis_data *priv, int irq,
>  		goto out_err;
>  	}
> =20
> +	/*
> +	 * There are environments, like Intel TXT, that may leave a TPM
> +	 * locality open. Close all localities to start from a known state.
> +	 */
> +	for (i =3D 0; i <=3D TPM_MAX_LOCALITY; i++) {
> +		if (check_locality(chip, i))
> +			tpm_tis_relinquish_locality(chip, i);
> +	}
> +
>  	/* Take control of the TPM's interrupt hardware and shut it off */
>  	rc =3D tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>  	if (rc < 0)
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 4ee9d13749ad..abe0d44d00ee 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -116,6 +116,12 @@ struct tpm_chip_seqops {
>  	const struct seq_operations *seqops;
>  };
> =20
> +/*
> + * The maximum locality (0 - 4) for a TPM, as defined in section 3.2 of =
the
> + * Client Platform Profile Specification.
> + */
> +#define TPM_MAX_LOCALITY		4
> +
>  struct tpm_chip {
>  	struct device dev;
>  	struct device devs;

Is there a dependency to 1/3?

BR, Jarkko

