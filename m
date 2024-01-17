Return-Path: <linux-kernel+bounces-28658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7900830177
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF8228705B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE259134A9;
	Wed, 17 Jan 2024 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="pJlX1sNx"
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27DB12B7C;
	Wed, 17 Jan 2024 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481159; cv=none; b=mmDUhjHZgNCIrjkT4dpvvJ/BRCIoiu9xWW+89Q81b9q18oEZQv4sXE0AF8ESPC6F2XErSp84VHvTb7A5eqUtSsde6osIn1Eb86GIyCPRAj8gmiz+FsjYuVQtIcSoi2+e2IHF8WYHklNV7ThCfRmYAjUCJUbuIjoEVGI4c23SPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481159; c=relaxed/simple;
	bh=L4nGR93Mrx+QGtN/Hr3HuZCR/Enu0i8Qzi3eC48RcM0=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy; b=KfbVk/6pNPc3dK0VF8c3Hc5QJwh0y+H7/0WOqTK6B90ssmeY2E7s2FFrORRAm85s1Gc72SwLymJxP8OIGZWTF25NFIjfOtZ7+6Qrgdzw7IggQrDRIJgkic2mHOrAUf+Y2MXUSlNce7T/2nfiBPeVQOn+fspo1SghRiBPbTcQH/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=pJlX1sNx; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1705481157; x=1737017157;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L4nGR93Mrx+QGtN/Hr3HuZCR/Enu0i8Qzi3eC48RcM0=;
  b=pJlX1sNxTPMc776Rl8SpBhoS7KJ3qo0TufLM26OWygVNrmnGql3quhEX
   E/TohT6aHY6RFHkrRED0dSlrl4WtWQn3c7w5eclLC237i6EoQdymCqHnQ
   muZwuvf7D57MdSJgtcx7zzPUuGsLnxh+JMt4Q0lOT5ubTGaVhMWPzaiJB
   g=;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="8976963"
X-IronPort-AV: E=Sophos;i="6.05,200,1701126000"; 
   d="scan'208";a="8976963"
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 09:44:45 +0100
Received: from MUCSE844.infineon.com (172.23.7.73) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 09:44:44 +0100
Received: from [10.160.240.161] (10.160.240.161) by MUCSE844.infineon.com
 (172.23.7.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 09:44:44 +0100
Message-ID: <711d659f-3f57-48e4-b5b3-efbc2fe236c8@infineon.com>
Date: Wed, 17 Jan 2024 09:44:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: make locality handling resilient
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Jarkko Sakkinen <jarkko@kernel.org>, Lino Sanfilippo
	<l.sanfilippo@kunbus.com>, Sasha Levin <sashal@kernel.org>,
	<linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Ross Philipson <ross.philipson@oracle.com>, Kanth Ghatraju
	<kanth.ghatraju@oracle.com>, Peter Huewe <peterhuewe@gmx.de>
References: <20240115011546.21193-1-dpsmith@apertussolutions.com>
From: Alexander Steffen <Alexander.Steffen@infineon.com>
In-Reply-To: <20240115011546.21193-1-dpsmith@apertussolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MUCSE807.infineon.com (172.23.29.33) To
 MUCSE844.infineon.com (172.23.7.73)

On 15.01.2024 02:15, Daniel P. Smith wrote:
> Commit 933bfc5ad213 introduced the use of a locality counter to control when
> locality request was actually sent to the TPM. This locality counter created a
> hard enforcement that the TPM had no active locality at the time of the driver
> initialization. The reality is that this may not always be the case coupled
> with the fact that the commit indiscriminately decremented the counter created
> the condition for integer underflow of the counter. The underflow was triggered
> by the first pair of request/relinquish calls made in tpm_tis_init_core and all
> subsequent calls to request/relinquished calls would have the counter flipping
> between the underflow value and 0. The result is that it appeared all calls to
> request/relinquish were successful, but they were not. The end result is that
> the locality that was active when the driver loaded would always remain active,
> to include after the driver shutdown. This creates a significant issue when
> using Intel TXT and Locality 2 is active at boot. After the GETSEC[SEXIT]
> instruction is called, the PCH will close access to Locality 2 MMIO address
> space, leaving the TPM locked in Locality 2 with no means to relinquish the
> locality until system reset.
> 
> The commit seeks to address this situation through three changes.

Could you split this up into multiple patches then, so that they can be 
discussed separately?

> The first is
> to walk the localities during initialization and close any open localities to
> ensure the TPM is in the assumed state. Next is to put guards around the
> counter and the requested locality to ensure they remain within valid values.
> The last change is to make the request locality functions be consistent in
> their return values. The functions will either return the locality requested if
> successful or a negative error code.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Reported-by: Kanth Ghatraju <kanth.ghatraju@oracle.com>
> Fixes: 933bfc5ad213 ("tpm, tpm: Implement usage counter for locality")
> ---
>   drivers/char/tpm/tpm-chip.c     |  2 +-
>   drivers/char/tpm/tpm_tis_core.c | 20 +++++++++++++++-----
>   include/linux/tpm.h             |  2 ++
>   3 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 42b1062e33cd..e7293f85335a 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -49,7 +49,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
>                  return rc;
> 
>          chip->locality = rc;
> -       return 0;
> +       return chip->locality;
>   }
> 
>   static void tpm_relinquish_locality(struct tpm_chip *chip)
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 1b350412d8a6..c8b9b0b199dc 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -180,7 +180,8 @@ static int tpm_tis_relinquish_locality(struct tpm_chip *chip, int l)
>          struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> 
>          mutex_lock(&priv->locality_count_mutex);
> -       priv->locality_count--;
> +       if (priv->locality_count > 0)
> +               priv->locality_count--;
>          if (priv->locality_count == 0)
>                  __tpm_tis_relinquish_locality(priv, l);
>          mutex_unlock(&priv->locality_count_mutex);
> @@ -226,18 +227,21 @@ static int __tpm_tis_request_locality(struct tpm_chip *chip, int l)
>                          tpm_msleep(TPM_TIMEOUT);
>                  } while (time_before(jiffies, stop));
>          }
> -       return -1;
> +       return -EBUSY;
>   }
> 
>   static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
>   {
>          struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> -       int ret = 0;
> +       int ret = -EIO;
> +
> +       if (l > TPM_MAX_LOCALITY)
> +               return -EINVAL;
> 
>          mutex_lock(&priv->locality_count_mutex);
>          if (priv->locality_count == 0)
>                  ret = __tpm_tis_request_locality(chip, l);
> -       if (!ret)
> +       if (ret >= 0)
>                  priv->locality_count++;
>          mutex_unlock(&priv->locality_count_mutex);
>          return ret;

This line seems to be the most important change, that fixes the 
locality_count handling for localities != 0. It could already be 
sufficient to fix your original problem. I'm not sure all the other 
changes are really necessary.

> @@ -1108,7 +1112,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>          u32 intmask;
>          u32 clkrun_val;
>          u8 rid;
> -       int rc, probe;
> +       int rc, probe, locality;
>          struct tpm_chip *chip;
> 
>          chip = tpmm_chip_alloc(dev, &tpm_tis);
> @@ -1169,6 +1173,12 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>                  goto out_err;
>          }
> 
> +       /* It is not safe to assume localities are closed on startup */
> +       for (locality = 0; locality <= TPM_MAX_LOCALITY; locality++) {
> +               if (check_locality(chip, locality))
> +                       tpm_tis_relinquish_locality(chip, locality);
> +       }
> +
>          /* Take control of the TPM's interrupt hardware and shut it off */
>          rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>          if (rc < 0)
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 4ee9d13749ad..f2651281f02e 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -116,6 +116,8 @@ struct tpm_chip_seqops {
>          const struct seq_operations *seqops;
>   };
> 
> +#define TPM_MAX_LOCALITY               4
> +
>   struct tpm_chip {
>          struct device dev;
>          struct device devs;
> --
> 2.30.2
> 

