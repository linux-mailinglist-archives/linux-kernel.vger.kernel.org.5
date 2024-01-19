Return-Path: <linux-kernel+bounces-31576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D726833045
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D4C1F240A2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD3058ABA;
	Fri, 19 Jan 2024 21:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXIcRZiF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558DD58AA1;
	Fri, 19 Jan 2024 21:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699698; cv=none; b=dKQtuKbrJsQ6p85KuU+U8dtolwrD2Wr/4tdO1MhGHhiIAhHkpXomD6awxULCujFDHTmkBlrWXNcGzt6REX0RhJe7/KYlJFDscovnzhUNyUaZy/M+kpYqwvB+TMgsrKTy/SUFapgWkPIOFH3rqOql08EQz1GmCkitKoXxiadTmIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699698; c=relaxed/simple;
	bh=v2H0OsNvV9pPT/cbypaewkMjFcAe/8sPxD7dGqZRydQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GYPpN4tbUMkK6i0jhc3IGi2oxFoNVZa74V0t6az731Nq/Jx+hH3A0qHsKanwnfatf6e7P81jPuU06X4Duz0ZdBRmPaQ38B3p9vCkCJW+fmKDNXxlByrupkHbC27ZqJedH4Uj40USibSY2DquN57ebZrn432UAk0byKvTSjV0etA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXIcRZiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C68C433F1;
	Fri, 19 Jan 2024 21:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705699697;
	bh=v2H0OsNvV9pPT/cbypaewkMjFcAe/8sPxD7dGqZRydQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=HXIcRZiFrVdvUhgprPNf053LqngMHiFs9JduqN28Lir2w7+lpwpMZMHS+U8R0V5W1
	 NshFSsHaWKlmVAbFo8dWAGqL/ou+h5OizkGqe8vGPwiGcFdcKr9jMbILTmkGdagOO0
	 HX5tuppDuLlFgqS6Qz/+imrIVG66dAijBv2NrNX3c46uZSj+xXNyq9B0BzGWkSQyG4
	 V7Cbhq2SWG+56d9tk+Z6ujyU5rc3rbixqZIiddfgdvVsYDQF96UmwAYByFvmRdc008
	 +ifUDbgqWKRdw8ViR2DnPSYfGO9bHjDO4btnnoWsUAEC4fRznvOeTcH2RL6qM02C3R
	 G1k30cg+JtXyg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jan 2024 21:28:14 +0000
Message-Id: <CYJ02TX197BU.2MENZV8N4N87O@seitikki>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Kanth Ghatraju"
 <kanth.ghatraju@oracle.com>, "Peter Huewe" <peterhuewe@gmx.de>
Subject: Re: [PATCH] tpm: make locality handling resilient
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, "Lino Sanfilippo" <l.sanfilippo@kunbus.com>, "Sasha Levin"
 <sashal@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240115011546.21193-1-dpsmith@apertussolutions.com>
In-Reply-To: <20240115011546.21193-1-dpsmith@apertussolutions.com>

On Mon Jan 15, 2024 at 1:15 AM UTC, Daniel P. Smith wrote:
> Commit 933bfc5ad213 introduced the use of a locality counter to control w=
hen
> locality request was actually sent to the TPM. This locality counter crea=
ted a
> hard enforcement that the TPM had no active locality at the time of the d=
river
> initialization. The reality is that this may not always be the case coupl=
ed
> with the fact that the commit indiscriminately decremented the counter cr=
eated
> the condition for integer underflow of the counter. The underflow was tri=
ggered
> by the first pair of request/relinquish calls made in tpm_tis_init_core a=
nd all
> subsequent calls to request/relinquished calls would have the counter fli=
pping
> between the underflow value and 0. The result is that it appeared all cal=
ls to
> request/relinquish were successful, but they were not. The end result is =
that
> the locality that was active when the driver loaded would always remain a=
ctive,
> to include after the driver shutdown. This creates a significant issue wh=
en
> using Intel TXT and Locality 2 is active at boot. After the GETSEC[SEXIT]
> instruction is called, the PCH will close access to Locality 2 MMIO addre=
ss
> space, leaving the TPM locked in Locality 2 with no means to relinquish t=
he
> locality until system reset.
>
> The commit seeks to address this situation through three changes. The fir=
st is
> to walk the localities during initialization and close any open localitie=
s to
> ensure the TPM is in the assumed state. Next is to put guards around the
> counter and the requested locality to ensure they remain within valid val=
ues.
> The last change is to make the request locality functions be consistent i=
n
> their return values. The functions will either return the locality reques=
ted if
> successful or a negative error code.
>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Reported-by: Kanth Ghatraju <kanth.ghatraju@oracle.com>
> Fixes: 933bfc5ad213 ("tpm, tpm: Implement usage counter for locality")
> ---
>  drivers/char/tpm/tpm-chip.c     |  2 +-
>  drivers/char/tpm/tpm_tis_core.c | 20 +++++++++++++++-----
>  include/linux/tpm.h             |  2 ++
>  3 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 42b1062e33cd..e7293f85335a 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -49,7 +49,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
>  		return rc;
> =20
>  	chip->locality =3D rc;
> -	return 0;
> +	return chip->locality;
>  }
> =20
>  static void tpm_relinquish_locality(struct tpm_chip *chip)
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index 1b350412d8a6..c8b9b0b199dc 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -180,7 +180,8 @@ static int tpm_tis_relinquish_locality(struct tpm_chi=
p *chip, int l)
>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> =20
>  	mutex_lock(&priv->locality_count_mutex);
> -	priv->locality_count--;
> +	if (priv->locality_count > 0)
> +		priv->locality_count--;
>  	if (priv->locality_count =3D=3D 0)
>  		__tpm_tis_relinquish_locality(priv, l);
>  	mutex_unlock(&priv->locality_count_mutex);
> @@ -226,18 +227,21 @@ static int __tpm_tis_request_locality(struct tpm_ch=
ip *chip, int l)
>  			tpm_msleep(TPM_TIMEOUT);
>  		} while (time_before(jiffies, stop));
>  	}
> -	return -1;
> +	return -EBUSY;
>  }
> =20
>  static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
>  {
>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> -	int ret =3D 0;
> +	int ret =3D -EIO;
> +
> +	if (l > TPM_MAX_LOCALITY)
> +		return -EINVAL;
> =20
>  	mutex_lock(&priv->locality_count_mutex);
>  	if (priv->locality_count =3D=3D 0)
>  		ret =3D __tpm_tis_request_locality(chip, l);
> -	if (!ret)
> +	if (ret >=3D 0)
>  		priv->locality_count++;
>  	mutex_unlock(&priv->locality_count_mutex);
>  	return ret;
> @@ -1108,7 +1112,7 @@ int tpm_tis_core_init(struct device *dev, struct tp=
m_tis_data *priv, int irq,
>  	u32 intmask;
>  	u32 clkrun_val;
>  	u8 rid;
> -	int rc, probe;
> +	int rc, probe, locality;

s/locality/i/

We don't use long names for loop indices generally.

>  	struct tpm_chip *chip;
> =20
>  	chip =3D tpmm_chip_alloc(dev, &tpm_tis);
> @@ -1169,6 +1173,12 @@ int tpm_tis_core_init(struct device *dev, struct t=
pm_tis_data *priv, int irq,
>  		goto out_err;
>  	}
> =20
> +	/* It is not safe to assume localities are closed on startup */

This is somewhat useless comment.

E.g. this would be way more useful:

	/*
	 * Intel TXT starts with locality 2 active. Therefore,
	 * localities cannot be assumed to be closed on startup.
	 */

> +	for (locality =3D 0; locality <=3D TPM_MAX_LOCALITY; locality++) {
> +		if (check_locality(chip, locality))
> +			tpm_tis_relinquish_locality(chip, locality);
> +	}
> +
>  	/* Take control of the TPM's interrupt hardware and shut it off */
>  	rc =3D tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>  	if (rc < 0)
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 4ee9d13749ad..f2651281f02e 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -116,6 +116,8 @@ struct tpm_chip_seqops {
>  	const struct seq_operations *seqops;
>  };
> =20
> +#define TPM_MAX_LOCALITY		4

Not documented.

> +
>  struct tpm_chip {
>  	struct device dev;
>  	struct device devs;

Thanks for the fix.

BR, Jarkko

