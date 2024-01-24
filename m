Return-Path: <linux-kernel+bounces-37080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B12AA83AB38
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1A11F2BF43
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621247A702;
	Wed, 24 Jan 2024 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8VVM279"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161C677F34
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104526; cv=none; b=ZXhEvZI3U2dZPDjUoKOy0iyHRzejPIvl0SA4+hnXdmtcpvjcOfuCV9VjUCEeyRSQxByKM7Kz2h3rBByDqruqwufKtMLDMtqA2kOjQjzwrJg2c9+zm8V3EQmOC+auPv4zvujmGYU0FGrvcEMzyRr5F75e6fxvA1pI8rQWC/wNSqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104526; c=relaxed/simple;
	bh=uO6XYeao3+ERbDLbaGJYNsqD7iMh0uqxQitnp3GG0EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AV1GLACBRbwmn/Tia8jW8PO5XREX8SjnzXzFRybK5VxodVTe7yrHiYDBeJaJEgdAvK6K6ddEOjZug/GdQxFeuoI5NooDM9OZpzy8KeVGLWeY2ZbWYc6RBuksqPB4B4xsTTFAh8wZx9Rp2zOcg57vLVhTQDJfap8K9WkK2491zQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8VVM279; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706104524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X2HNODfBS+JrHafscRLbwZLG2NmbTl5ZUi1igtTA3Vk=;
	b=R8VVM279xhsCGCfoWiNbryxF4LZ1fDKgi14MDQiKqU1xE2/GwEhXPDaHPM/WXehrUTYQIQ
	OlWq3Ly2u9yj98tnbY/0SmvSHV3p8a+T1QpgrcsW75hti/NuRxsRLdBmBW6+xPLdaOvUv7
	TkNFjk98DB9atMLc7BbNgeetVeJf5SY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-_P-yUVP_OmudNHW5rbxEQA-1; Wed, 24 Jan 2024 08:55:22 -0500
X-MC-Unique: _P-yUVP_OmudNHW5rbxEQA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-783603ba574so897065785a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706104521; x=1706709321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2HNODfBS+JrHafscRLbwZLG2NmbTl5ZUi1igtTA3Vk=;
        b=sll2MYt5ApuRpycr6znFdGqUAYqybLfHnLAe000Azs0wzcxkQh4xfH4nOBmR+XP1K6
         4o0M3Y/qVxk3LwOp0KXYR5xpHlXGu+W7Ps7iznyY7Ym7F89bahPuEECbgZ3gyKpOgIl4
         MKISGr6RhfNzTfcNQveSBGcXMWiVzKuzPuLgf4/9juB3a83paUKv98XoZOd6PuU49OyV
         b3jTuqpS/d5Fh34p3PF1IbjqY/13KEFG0x9DEuN0nkgP23p32uRPKKgP2rvyIx2FU0F+
         D7qsa10VvaIPTPmi4eyHJ0nU1//05p6oxYef++Jjm8bN+Wea0IOPfzp9WmuyVxynrm9H
         +hNg==
X-Gm-Message-State: AOJu0Yy6bKl6QajAE6FvImsePH4u1rTdsZoFwFg4hyETadj8OCKvKWmI
	NQBrDm/PAmimzkvelCIrwzi/Li94SQY26dkkmKciRsjioRS9h1yb2L/D47qvjBJyRlpTfjEj5Dc
	YOOE+w7fSvaM/KHuHgMd/GND7bMwrAuESP/AGWRrBJLtiQ3Fqc2GXN7ddU3XQ8Q==
X-Received: by 2002:a05:620a:610a:b0:783:8071:2473 with SMTP id oq10-20020a05620a610a00b0078380712473mr8341384qkn.61.1706104521678;
        Wed, 24 Jan 2024 05:55:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTtQXSI1MSoTfgWJ8tVH7siOJkHn3LOGpV6BWnWln+S7PK+ANFnpN3awurbecqz9jTWq6izA==
X-Received: by 2002:a05:620a:610a:b0:783:8071:2473 with SMTP id oq10-20020a05620a610a00b0078380712473mr8341369qkn.61.1706104521402;
        Wed, 24 Jan 2024 05:55:21 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id m26-20020ae9e01a000000b0078392eacfd4sm3940574qkk.80.2024.01.24.05.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 05:55:20 -0800 (PST)
Date: Wed, 24 Jan 2024 07:55:18 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Eric Chanudet <echanude@redhat.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: ufs: qcom: avoid re-init quirk when gears match
Message-ID: <mzfbayn2yz2egmtv2lankxn3h7p4pglaqxallczzmcevkvnp5b@jplxt7yu6xae>
References: <20240123192854.1724905-4-echanude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123192854.1724905-4-echanude@redhat.com>

On Tue, Jan 23, 2024 at 02:28:57PM -0500, Eric Chanudet wrote:
> On sa8775p-ride, probing the hba will go through the
> UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH path although the power info
> are same during the second init.
> 
> The REINIT quirk only applies starting with controller v4. For these,
> ufs_qcom_get_hs_gear() reads the highest supported gear when setting the
> host_params. After the negotiation, if the host and device are on the
> same gear, it is the highest gear supported between the two. Skip REINIT
> to save some time.
> 
> Signed-off-by: Eric Chanudet <echanude@redhat.com>

On the sa8775p-ride I have I see similar results to what you mention!
Thanks.

Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8775p-ride

> ---
> 
> v1 -> v2:
> * drop test against host->hw_ver.major >= 4 and amend description as a
>   result (Andrew/Mani)
> * add comment, test device gear against host->phy_gear and reset
>   host->phy_gear only if necessary (Mani)
> * Link to v1: https://lore.kernel.org/linux-arm-msm/20240119185537.3091366-11-echanude@redhat.com/
> 
> trace_event=ufs:ufshcd_init reports the time spent in ufshcd_probe_hba
> where the re-init quirk is performed:
> Currently:
> 0.355879: ufshcd_init: 1d84000.ufs: took 103377 usecs, dev_state: UFS_ACTIVE_PWR_MODE, link_state: UIC_LINK_ACTIVE_STATE, err 0
> With this patch:
> 0.297676: ufshcd_init: 1d84000.ufs: took 43553 usecs, dev_state: UFS_ACTIVE_PWR_MODE, link_state: UIC_LINK_ACTIVE_STATE, err 0
> 
>  drivers/ufs/host/ufs-qcom.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 39eef470f8fa..f7dba7236c6e 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -738,8 +738,17 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>  		 * the second init can program the optimal PHY settings. This allows one to start
>  		 * the first init with either the minimum or the maximum support gear.
>  		 */
> -		if (hba->ufshcd_state == UFSHCD_STATE_RESET)
> -			host->phy_gear = dev_req_params->gear_tx;
> +		if (hba->ufshcd_state == UFSHCD_STATE_RESET) {
> +			/*
> +			 * Skip REINIT if the negotiated gear matches with the
> +			 * initial phy_gear. Otherwise, update the phy_gear to
> +			 * program the optimal gear setting during REINIT.
> +			 */
> +			if (host->phy_gear == dev_req_params->gear_tx)
> +				hba->quirks &= ~UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
> +			else
> +				host->phy_gear = dev_req_params->gear_tx;
> +		}
>  
>  		/* enable the device ref clock before changing to HS mode */
>  		if (!ufshcd_is_hs_mode(&hba->pwr_info) &&
> -- 
> 2.43.0
> 
> 


