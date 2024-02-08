Return-Path: <linux-kernel+bounces-58645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B9984E959
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DCE1C21A61
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D43383AF;
	Thu,  8 Feb 2024 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsOyviIp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D7383A0
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422809; cv=none; b=CTfHV0Mn3LPmDcBSWEhjhiz8vxDpnLEAh1J49bhcPC+TOuROXy4BPNtHqJyChsWnds4ix/3xLMab/wz4spvqXk+EkEo6GfX72ByQ5vfv9Knb7qurIqsoYLfJvlAncqF1CzGrefm3AKD6YhNo/XPBbj7OD5Bi8lbd/oDPWybs2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422809; c=relaxed/simple;
	bh=+Fs19Cpun0TSkJklfnxJtGN0nfv7FVxeEyF3YOp+XSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tP089+Kcyn9YzbQOgSR9lqD8aY8X5fLmbHwpoMfo1y6NOqYSSoNqTB9gbFp9HIC5dQkm8NLTdyXSB0EqTUdqN67sQSdmNMO5N7AgZoG6E0rswu31IM/nmb+Hlq83x6MinQ3YeQrwXz/CmruxwjOwdblmWUsGxQ6DQmgqejI/fl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hsOyviIp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707422806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ANys47F0NxoVUIOHDguuU7C7l2/Ixa/qHxdOlZRmRWc=;
	b=hsOyviIpXGysn+o/JY/DPzjcIY3kz2CF5uVPqLGOPdEL2FRbiZuwajyQ6skfJPVJbwnl/e
	m5+OlBTBIPrJ8q00v8crdWiZaLVYVLh7i5P0WANJcmAmzx5SHZJv9gv8qFtd5HR6DrZoX3
	l8YQvTib9yulvPZq3swsC6/M1mYRdnY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-cY-kLQC1NeCXKTQ5fSOHpw-1; Thu, 08 Feb 2024 15:06:45 -0500
X-MC-Unique: cY-kLQC1NeCXKTQ5fSOHpw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78315f41c6cso28179685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 12:06:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707422805; x=1708027605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANys47F0NxoVUIOHDguuU7C7l2/Ixa/qHxdOlZRmRWc=;
        b=wcnU+PV0Ztm08SqRvNYyiSYtMYqE64Wg82GseOiYJ/CBpGSLkevskRPbjMW98aYmPb
         zQl/sDmGu51xQp+WzWs0dWUa1ejqEqumLDi566SFGghh3pQoNiuIaW4iSQEE3Es6ZtZw
         2fxYxBCYxKHN9UP21rkEGiby19Jl/uWWL3RqtbxasEcaThC4At2sO4FPwI0Oe9BKhA38
         8ivrvQbUfgsYneYP3ctmxSeIPWVI4jsD3FuhBCUgHN5gQKbl58HUdWkm+YvSzEl16Nyd
         XWzV0C5PlzC4zSGRkREbfVb6MY00ZnQ6dgOwoghBGDCfcNTRlGDCahsqgA8HDCkdL80s
         v4fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM6fCLlrtkhLVwAckb9A19IIupIbuuNgswzessUDdWLTmcnx5TvZwnPVPCtLXYIWLZeFvyGk1BGRe8SLO2fHnAvL4JTGYgK5qclWas
X-Gm-Message-State: AOJu0YyPOaTYNSgpAWoMM3Cvj8FwtrSdkhhwSqtmPU+OdUs/sg8Fxcui
	/nfegSiLx/lJqpoDIc5XD4yjXmwX72EFeY6D1aPc40EBzkWTJSx0vDZyDweU7JH0LEuSbMtJLcq
	0HU0bSg1P4wUnUxPiij8W77vHUo0+AdHAcY+qf4f6IYOqwk4LkDBvOXm4apYDhQ==
X-Received: by 2002:a05:620a:9c3:b0:785:ac12:e4b5 with SMTP id y3-20020a05620a09c300b00785ac12e4b5mr574419qky.55.1707422804893;
        Thu, 08 Feb 2024 12:06:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuq4yeSZLglLwVkXsC5eH+I4vEuR70T8am1BFRQodf/cnjwEjFuwBGgJLIgQIc31AFA38WaQ==
X-Received: by 2002:a05:620a:9c3:b0:785:ac12:e4b5 with SMTP id y3-20020a05620a09c300b00785ac12e4b5mr574395qky.55.1707422804605;
        Thu, 08 Feb 2024 12:06:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYxnneQ2myYwNQ9XHVjYFXa6X60+lUgyO9TTq4kAi/WOA/HjG/z0yklvZLAMzZDECVVDXsBsbSDt+Ic9UZIOmG1G5dLK1DKUQtYSk+4SECN4g5TExgPfHjb+t5Nl09pJvRguZgjdp71fW7BJRS6tenMtZBWUCQrbgKOKLsRLlLtdFRF83Pe5hWRggNNqTOVDmU/++S9cdhAaZ3pjp56calv63pkhSwsK3BtYMHyg7WyiVaLEyV0Yq2DH5I0GH+mSTkZJmWhN9iBbQYB2Ss6qmDxMghuPXOLXtcA4jKavTFX+HHRDDrmy5g+48mkdbc8gZO+nW7sYFCJTUb62st+NLVW47BxLzEyAz3eoDdpb6YbE81/qoRtyz2sRaEv+7EMItFfpBBRK4URBgothCCqOfvB8H1qm6pEAENaOSVLy5XAQmKITQYIpAe1UkJ3KBWJzhP/00852p0KnCxgTulaJmB33o=
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id t2-20020a05620a034200b007859ee84641sm125675qkm.6.2024.02.08.12.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 12:06:44 -0800 (PST)
Date: Thu, 8 Feb 2024 14:06:41 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, kernel@quicinc.com
Subject: Re: [PATCH net-next v3] net: stmmac: dwmac-qcom-ethqos: Enable TBS
 on all queues but 0
Message-ID: <yamtu6i6bzre2ewmgh5eert35j74ofcw65554zr2g57ydzsjqa@crxdyszih4tw>
References: <20240207224001.2109224-1-quic_abchauha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207224001.2109224-1-quic_abchauha@quicinc.com>

On Wed, Feb 07, 2024 at 02:40:01PM -0800, Abhishek Chauhan wrote:
> TSO and TBS cannot co-exist. TBS requires special descriptor to be
> allocated at bootup. Initialising Tx queues at probe to support
> TSO and TBS can help in allocating those resources at bootup.
> 
> TX queues with TBS can support etf qdisc hw offload.
> 
> This is similar to the patch raised by NXP
> commit 3b12ec8f618e ("net: stmmac: dwmac-imx: set TSO/TBS TX queues default 
> settings")
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
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>

Please add my:

    Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8775p-ride

when submitting v4 with the changelog moved as Jeff mentioned. This
seems to work well (I can enable ETF on all queues but 0, and as far as
I can tell after trying to test that for a while it seems to work as
expected).

Thanks,
Andrew

> ---
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


