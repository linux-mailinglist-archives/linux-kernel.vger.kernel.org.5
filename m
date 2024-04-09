Return-Path: <linux-kernel+bounces-137534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB5889E389
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2A828535A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7AC158DC4;
	Tue,  9 Apr 2024 19:26:37 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE94157E9C;
	Tue,  9 Apr 2024 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690797; cv=none; b=akoxJrUKGb7s3AuPiCgL0lghTWGjA06TZGi3O4hZuQBrDS3/srBr2xYYR0+xTIQg6KjjMvAZjNMKaPOvXrfLpBFYRERQntdLnNqQXx2nAPrpfVfzBLVhWQ3Eits5BiD4TuJA4DsReiWOjjVsB+1QvqOOv6Nfft+G6k9EfbiJiZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690797; c=relaxed/simple;
	bh=LSz9VcksS3I44HIeB0srZE2FQPGtzmVVAAOs5a4k/3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPEPI9WID78nqrgl4NXuA+FG1/Y2s+9wtDbir90pXqyWAHsS44X3m/FY4zP4LMwV1aBGjAst5UG00iEl/J75IfmTk+ypAbCfaIS62HpIZign637d2L/EPJAX8xCHXUGa7y+8YqCNW8CeOFwsmUQiqlBzw8Er7QkfBMWuq0ZM6Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id E3CE4140562; Tue,  9 Apr 2024 21:26:25 +0200 (CEST)
Date: Tue, 9 Apr 2024 21:26:25 +0200
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: typec: ucsi_glink: drop special handling for
 CCI_BUSY
Message-ID: <ZhWWYQMluJCvYFKF@cae.in-ulm.de>
References: <20240409-qcom-ucsi-fixes-bis-v2-0-6d3a09faec90@linaro.org>
 <20240409-qcom-ucsi-fixes-bis-v2-3-6d3a09faec90@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409-qcom-ucsi-fixes-bis-v2-3-6d3a09faec90@linaro.org>


Hi Dmitry,

On Tue, Apr 09, 2024 at 06:29:18PM +0300, Dmitry Baryshkov wrote:
> Newer Qualcomm platforms (sm8450+) successfully handle busy state and
> send the Command Completion after sending the Busy state. Older devices
> have firmware bug and can not continue after sending the CCI_BUSY state,
> but the command that leads to CCI_BUSY is already forbidden by the
> NO_PARTNER_PDOS quirk.
> 
> Follow other UCSI glue drivers and drop special handling for CCI_BUSY
> event. Let the UCSI core properly handle this state.
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 9ffea20020e7..fe9b951f5228 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -176,7 +176,8 @@ static int pmic_glink_ucsi_sync_write(struct ucsi *__ucsi, unsigned int offset,
>  	left = wait_for_completion_timeout(&ucsi->sync_ack, 5 * HZ);
>  	if (!left) {
>  		dev_err(ucsi->dev, "timeout waiting for UCSI sync write response\n");
> -		ret = -ETIMEDOUT;
> +		/* return 0 here and let core UCSI code handle the CCI_BUSY */
> +		ret = 0;
>  	} else if (ucsi->sync_val) {
>  		dev_err(ucsi->dev, "sync write returned: %d\n", ucsi->sync_val);
>  	}
> @@ -243,11 +244,8 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
>  		ucsi_connector_change(ucsi->ucsi, con_num);
>  	}
>  
> -	if (ucsi->sync_pending && cci & UCSI_CCI_BUSY) {
> -		ucsi->sync_val = -EBUSY;
> -		complete(&ucsi->sync_ack);
> -	} else if (ucsi->sync_pending &&
> -		   (cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))) {
> +	if (ucsi->sync_pending &&
> +	    (cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))) {
>  		complete(&ucsi->sync_ack);
>  	}
>  }

This handling of the command completion turned out to be racy in
the ACPI case: If a normal command was sent one should wait for
UCSI_CCI_COMMAND_COMPLETE only. In case of an UCSI_ACK_CC_CI
command the completion is indicated by UCSI_CCI_ACK_COMPLETE.

While not directly related, a port of this 
    https://lore.kernel.org/all/20240121204123.275441-3-lk@c--e.de/
would nicely fit into this series.

I don't have the hardware to do this myself.


Best regards,
Christian


