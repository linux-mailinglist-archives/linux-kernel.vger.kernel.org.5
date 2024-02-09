Return-Path: <linux-kernel+bounces-59659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A0B84F9F6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C3128F939
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D4380C1B;
	Fri,  9 Feb 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfYOOMZP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4B7BAE5
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497067; cv=none; b=mN5kYOkQA9IjYwGA7GZlIasUzsMIZ9VyFSOND84MjKi8fMNYj/dosBXKTW4VSLgYChAoBRadpTj7zwbQsOeyd5wnFnT0/igViRr87RO8Mfhb8JYx23qh+OWluibTUY97NbBMORpukDirp9SF+GB3TUFq9nIwoWkOt6RLAOILxVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497067; c=relaxed/simple;
	bh=VqosT3yYW+lBjgM8Ul3Vsp9pX35Tuke2OKN2acExoc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hX0ERT59tALTF58UfRIStw8XFDhZbZVSWvriIbORXOg3eWbO/48+Hk2pOfXaAXzBCEf8BgiKH0beAqT80nu8Q/uprAh6ChGgXXJQPMiHkU0Lic9a53vPc0KkVKlJx/DGjnR9zSmHdZyY7/0d5DVgqkcaiGUo5xDKBIbJs0W8Teg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfYOOMZP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707497064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k3HiufRFOq7vi28Eqly0vEDaDdHwR8LxB2v5P2jtSCw=;
	b=AfYOOMZPHxpGnSmXTBvIJwRcCClBkbj6fKIUx5B4EueZZ/IOAH9GViT4WT0bUtUEHzjZW/
	Ga+bfDQqA9g0SCpopRPipfzvE/hF5OyaZ7pm0ciba6qdYr0QyufuM9FaTQMRAt7OxhfTni
	ffAIcKh8YFGvY4+PCdVtuumUsJbz1T8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-eHa-ObD-Mru2vKJqJiyF7A-1; Fri, 09 Feb 2024 11:44:22 -0500
X-MC-Unique: eHa-ObD-Mru2vKJqJiyF7A-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-785bd90f3acso51959085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707497062; x=1708101862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3HiufRFOq7vi28Eqly0vEDaDdHwR8LxB2v5P2jtSCw=;
        b=bX6b5I8gJZKOr6wtWlae222aELyoqZRpAKE6G5fb+K/LhyTt3jxvb4dPrCBS/Ow7Hy
         SIQIggtHrrQHLTeV6fpiC3VyyqSNNSs8T7eZoEl3aO2BlpeV+25RlsXHgR6Oe6WwRV0E
         eHcXy5xIfjMD8M/hs529a/z+D0B07CjKIgZyL0YcVSetHqHl3jrqYW4WSNLOA8prg1zQ
         QjlDzpjUXTQoEGQkaDy3cl2BM4LOMOm+RvHh24QQDAniP4AocEVIxuiJU7IN4dMvWlMi
         SodllgozuBSYJHQo/peP3r4okrv98Bq0CIlgzFL7rscgWJJXyH9inU/SUTuw/z8gHDxl
         uy9w==
X-Forwarded-Encrypted: i=1; AJvYcCUMcN0haZJhA3q5NbKNZ6KEnyocFEFfLroQn7CSrd7Y2i+Fy2VB5hzpOq/hYsqQVVLWYwZyj+FclBznc5B7CP0FYmuO5FY+ef2Au3Ab
X-Gm-Message-State: AOJu0YxdC4POu4reJNa0dusYIDXAN/BoZFEPGLNsvvl/1NcqRrTFmm60
	Qjct8fEKCfKe8yK29ttDsGHuzeWvR+jxxdipZQgt2U8gO0pRliNGX4G4C9OJ7sYz0FDtQyzZ4ep
	FUn7jf9/Rbe6TcGbUJnWvYvAVRTqQW/1Nt6zC0kzZxpzNH1DwRAObZL6J8FCCAQ==
X-Received: by 2002:a05:620a:40d1:b0:785:bf37:38f with SMTP id g17-20020a05620a40d100b00785bf37038fmr657045qko.11.1707497061982;
        Fri, 09 Feb 2024 08:44:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENVlA0qg0+4v3P91wiIIxEpOzL+466GK2dg+eDP2qJSP6DtjO3gdikAce6wgZD8KW4lb3G3w==
X-Received: by 2002:a05:620a:40d1:b0:785:bf37:38f with SMTP id g17-20020a05620a40d100b00785bf37038fmr657021qko.11.1707497061667;
        Fri, 09 Feb 2024 08:44:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIu8tS+YN+nAnwmSQTK3nqYx/bNMiFOQfgHipM2vrWJG2F/T3h8FvYmc9sp26zQKA8kRWeXTlFjy5PqWMMMB06Le4B1D3VrK7uk+jvefd3gRc6JwN/cXMo8ya359E9TOHld3SBT8QDePHqAfKIglTQJi/kTdIx/ptsgS57YRqRlcs8BE3OlYDYt+M31mvj0MWKqkkB2oPw/VmwDRTT1aq2+px67RQ+GB8oxTa0jyVOaBe1pP4pldi/EU7s74bsCzmagbrXRPLyj5dcSPaelYmCRC6lN5zZ25atB9oYuPWOCkC6C9HLRV7cuLgf3sPLEqeTV581C7U/H9CentaZ23iF6Fe4pnJQOEA8LnTdwv1mK6ZQZ7Vi+vJbTjxpvJpQXUBsyrSiMIsclgOubE7AnvCcMdKWNkgz63/OZLHAk8l3faG5vQBBXzXcXrYIBn5NXjvqFIZs/hVxQPwWnHradKVH2xQ=
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id x25-20020a05620a099900b00783f77b968fsm843857qkx.109.2024.02.09.08.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:44:21 -0800 (PST)
Date: Fri, 9 Feb 2024 10:44:19 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, kernel@quicinc.com
Subject: Re: [PATCH net-next v4] net: stmmac: dwmac-qcom-ethqos: Enable TBS
 on all queues but 0
Message-ID: <xtwaz7cma6tc42hwslpp3j5htxhsefkmgjntciihphhhkislk7@dy6kr4qfs7mf>
References: <20240208231145.2732931-1-quic_abchauha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208231145.2732931-1-quic_abchauha@quicinc.com>

On Thu, Feb 08, 2024 at 03:11:45PM -0800, Abhishek Chauhan wrote:
> TSO and TBS cannot co-exist. TBS requires special descriptor to be
> allocated at bootup. Initialising Tx queues at probe to support
> TSO and TBS can help in allocating those resources at bootup.
> 
> TX queues with TBS can support etf qdisc hw offload.
> 
> This is similar to the patch raised by NXP
> commit 3b12ec8f618e ("net: stmmac: dwmac-imx: set TSO/TBS TX queues default settings")
> 
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8775p-ride
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
> Changes since v3:
> - The change is Tested-by Andrew Halaney <ahalaney@redhat.com>
>   on Qualcomm Ride platform
> - Change log is removed from the commit text
> 
> Changes since v2:
> - Fixed the styling of comment in the dwmac-qcom-ethqos.c
> - Followed the upstream format to give other glue
>   driver references to solve the same problem
> - Appended  the subject with net-next
> - Discussion of why this patch is required is discussed in
> https://lore.kernel.org/netdev/c2497eef-1041-4cd0-8220-42622c8902f4@quicinc.com/
> 
> Changes since v1:
> - Subject is changed as per upstream guidelines
> - Added a reference of a similar change done by NXP in
>   body of the commit message
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 31631e3f89d0..2691a250a5a7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -728,7 +728,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  	struct stmmac_resources stmmac_res;
>  	struct device *dev = &pdev->dev;
>  	struct qcom_ethqos *ethqos;
> -	int ret;
> +	int ret, i;
>  
>  	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
>  	if (ret)
> @@ -822,6 +822,10 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  		plat_dat->serdes_powerdown  = qcom_ethqos_serdes_powerdown;
>  	}
>  
> +	/* Enable TSO on queue0 and enable TBS on rest of the queues */
> +	for (i = 1; i < plat_dat->tx_queues_to_use; i++)
> +		plat_dat->tx_queues_cfg[i].tbs_en = 1;
> +
>  	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
>  }
>  
> -- 
> 2.25.1
> 


