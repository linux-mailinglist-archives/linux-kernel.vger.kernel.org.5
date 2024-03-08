Return-Path: <linux-kernel+bounces-96726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A71C8760AC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C17F1C20A78
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A8452F91;
	Fri,  8 Mar 2024 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sy+YczvD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B62A52F79
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888966; cv=none; b=K8eIEn0n37c4UkEf33CJ2+GLYaar9rUEDzyR4injIoZ+NKsAPDXskjri1u+RR6FF8OUkDpTsG5Y2fPEv9A/iSiQMdkiamaBkZ513Ur+8GvCjiucFdGPaQatU+KMopI6GUbt6rZdpXZWKFM4P7OwqLwysZcXXwh8A4r+OXEMhxL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888966; c=relaxed/simple;
	bh=v16FgxoD4jrKW4DEZ2p6BiXqbxPb+7o/1XZr+zdbld8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8DYgCcdpfURORfsi+QayyAijPYS/ZKq7tjDLaS7a4CvYXHXs3w1cgFxXWLW6OCuu3R34M0GiBj3fp4ZYz3MoGFVdYCguc8TFVSLR9pQyTPhE/+CsWSNzYC3NSkhfLiRfH+oTxP+VBanwhgdPI9IZgcAJssxsK+DJlWtgaRFAcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sy+YczvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6C6C433C7;
	Fri,  8 Mar 2024 09:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709888965;
	bh=v16FgxoD4jrKW4DEZ2p6BiXqbxPb+7o/1XZr+zdbld8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sy+YczvDG6c2AeBXhxb5VElBD0BrCFbb0Q74TH3cp5WXlCVitaxCh9lCXgApm3b7A
	 46oflEALayLxbh5FA6XFYkkZMGd1C4955wle9QBfzPi7tO4QCvWODlo93CK7cl+xqm
	 2yec3of5kSvv96OrGHnan4dtE/zAwMIK6iOpwIUNKaaAmVWDmAbGNTeXFFNChcQRbw
	 kTlKmH2KPRySP4S7Fmr4g8bTEfVSjvrwfwVIMBceaVBTGJ54NZ5X88To+TH1Dnd75d
	 sacCq75SHdHlJWW4+K/7HbJMC+gktckqawSjz+rnZVbpEbnO5ah6SzQieh0jTyAwZ4
	 KzDmymh50vDIA==
Date: Fri, 8 Mar 2024 10:09:21 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Marc Bonnici <marc.bonnici@arm.com>,
	Olivier Deprez <Olivier.Deprez@arm.com>
Subject: Re: [PATCH] firmware: arm_ffa: fix ffa_notification_info_get()
Message-ID: <ZerVwbT8cbXuzviy@lpieralisi>
References: <20240307092104.937440-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307092104.937440-1-jens.wiklander@linaro.org>

On Thu, Mar 07, 2024 at 10:21:04AM +0100, Jens Wiklander wrote:
> FFA_NOTIFICATION_INFO_GET retries information about pending

s/retries/retrieves/

> notifications. Notifications can be either global or per VCPU. Global
> notifications are represented by the VM ID only, or 0 in the absence of
> a hypervisor.

I would just say "Global notifications are reported with the partition
ID only in the list of endpoints with pending notifications".

> ffa_notification_info_get() incorrectly expect no ID at all
> for global notifications. Fix this by checking for 1 ID instead of 0.
> 
> Fixes: 3522be48d82b ("firmware: arm_ffa: Implement the NOTIFICATION_INFO_GET interface")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/firmware/arm_ffa/driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index c183c7d39c0f..ff1f37a4b28c 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -790,7 +790,7 @@ static void ffa_notification_info_get(void)
>  
>  			part_id = packed_id_list[ids_processed++];
>  
> -			if (!ids_count[list]) { /* Global Notification */
> +			if (ids_count[list] == 1) { /* Global Notification */
>  				__do_sched_recv_cb(part_id, 0, false);
>  				continue;
>  			}
> -- 
> 2.34.1
> 

