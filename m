Return-Path: <linux-kernel+bounces-55725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B96684C0E2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702DD1C2473B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C1A1CD29;
	Tue,  6 Feb 2024 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNl7ytcO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BAD1CD1F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707262179; cv=none; b=Sk+jB8hynxYt9Mv5U35H2QqYzPUeoL8is6o7mGVqCP4axg8PNURqdgtz4gu1UiVIDDolviWlGayZxJE4r0UPyE7KJ/53+8lRrZDF1DA5ZtYn8sdIs80nziA9KMd0k+1r3XWMmY7v//BjYSEqZl3/MhXgL3WvGH+f71LBQZ3O7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707262179; c=relaxed/simple;
	bh=tqwLPes11lygGwOT+EnjRVwLn4nZH90wJ7US1Neh49A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNLuFDwBiZ5iWE6fw4WohKsJ3m+KTU62DsggTmV6JDanJEdqamYUP0ltJd3/EvrLmfHc83kIC13oK81D2Sgqet/FFg3wzS2h+JCDLThNkXGdxkgfu4fN7sgbV45jq7fETucjGE6Di+Lrop096fGRGoZ86vtcLTCMWWmOTxLE+oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WNl7ytcO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707262176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kGuKJfCI04HqdOMRiRGUxI5yLSI9wasd/RUKvuSvTE8=;
	b=WNl7ytcO5ya3UI3YYBV+l5KKHC9z45BgusDZeVTk9hn8d3jzuXYliKsBulIsgEwBDmErD+
	YcJf7GVKvWG4DdWeIcOgMpA4czD9NyUGlsTO5dO+61AsBl7ePeBImC+EWL/189dstyePhU
	KOR2b32DYC0jceO2q7soPIpyGBbrYeI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-GQ-vvZ6HNdeJ-Hza6OBX7Q-1; Tue, 06 Feb 2024 18:29:35 -0500
X-MC-Unique: GQ-vvZ6HNdeJ-Hza6OBX7Q-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-785947d659cso98697485a.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 15:29:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707262175; x=1707866975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGuKJfCI04HqdOMRiRGUxI5yLSI9wasd/RUKvuSvTE8=;
        b=YRGmPYGqDytzu42jghWMCKqCEFPTfUvSKPdElZ+tzT3b7NtRW5fJ5druQGYqb1LaRx
         lgJTpNNjJeEeAcsjcAIQ0efiEtGVTasR1cBTsAjSj5Nq90GenQw6mHtQts5wkC2Px0Cv
         /qKnqGprfyfrx/PqSxSa9RWOS9xIcoDO4czdYJrzSz4y12GCglQ8NkG6SsooNJEM58Ea
         BAk7nkig922ZRNJKzTWhiTP8/eT5OQBGUHsRDGH3ZklOXanE43VwjmtNC34lBRvkBP4D
         Q/F+S1o8PyVypx3FFCGRduN0XppeFY3fe/7z8mKSr2mDfOhaOCG46jQHAPwccTPqZjW/
         hxzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm+X6Ig98r7cQdzNCNH0VxyJRfEKFnOj5VTBVZLqYoKXmvxnabMWbfyVkMqWTTu6fnGX5fi0WdVgeEhoAjXO8KH7K4aRtiT65tT4tt
X-Gm-Message-State: AOJu0YxfdGdYw1LWr1KQrsiV4Bc1Pn9qFEjiCeDsidyO015aVGi+dSdh
	7qmWtKfIxRIrihMa75N8sTdhCrvMKk5H2EyVy4kGcJBOy41FjDH9PrJNCMuMj5KDrQIA17v05Es
	YULUHaLrIkM5jgjwskxi7r0e96IjGHSaS/CPqNwx1uDAqx7zWyFqIbcZgs0edOA==
X-Received: by 2002:a05:620a:954:b0:783:6943:26d9 with SMTP id w20-20020a05620a095400b00783694326d9mr3538731qkw.72.1707262174748;
        Tue, 06 Feb 2024 15:29:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzxDP7R0yen2yo1PCk013ut+Q4BlMwWCQioC3aozlnsOonH4eG8xY5gzlWpshjgLrV00I1Ow==
X-Received: by 2002:a05:620a:954:b0:783:6943:26d9 with SMTP id w20-20020a05620a095400b00783694326d9mr3538704qkw.72.1707262174447;
        Tue, 06 Feb 2024 15:29:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWn7QpGTl7tuRLSbSHbLtGrThhE2QQZsdD9HxTI/kAsC/lMTLONidoD6JCzM4ob3KPWP151kUMo+jzEzuM+UC8wdgldgzf37xpaeBke52O5TawY5b38PM0mGH3xDU2b6JWiYFdqnSod3g7qxsgqhq9mU5ElK0F+N0/QSvBRu0NOauUzVM/YI3xwAe0GAk8g5IXS6k6mXVmta5VKDZWRNdPl5eNHryvxOfFf2RL3LsIi/GrN8CkwJuzj4tWlzKgeiWQdDiC1lrVe1V7mTd+f0FqAYx8ZMSNj8EYdfyvyfiGXRDJI+JBBIC7h6iKFM3Js0FdA67hhhvAOv3uCfc7PBPZyI/0U22PR6z/HqKjTFVc5vwuVl1L173g0YV21h1qV0wU0fscwC9//3ZVFw34sQ2ZnxH9Ptqtr827WwoHmAygiQTQSuYO/KILvWvDHQdZ1KnVE5LEXsM3tbyXiO5tTaoCjWk0OcDYa5CFSJoFIvBw07fIbb0D5Duw8edAqEPvNa3jGXCJpTwm9BE09RW7sXLnFQUS1NMj9iDeg9x1TjH1gy1LaV4P/20jN6MseX+boOnNIIoHhfBD4IVdNJjVg+7rRHT3ltUwFkaT97uvZfcLAu6mUtC+T9vRpIACKvkkNYGn/6gUyUfl1x6LlErTZZM82rT7yBYgU2Tfp/SvtgzwQN5E5P6f0cQfVqCiwmIG1ZwCLKlXJa62ZfAkqLb+LqoDHAi6Bhqd3APWP4thGNPOIOyAm3csqM9bL
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id d24-20020a05620a167800b00783e1590ebasm1357761qko.82.2024.02.06.15.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 15:29:34 -0800 (PST)
Date: Tue, 6 Feb 2024 17:29:31 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, Prasad Sodagudi <psodagud@quicinc.com>, 
	Rob Herring <robh@kernel.org>, kernel@quicinc.com
Subject: Re: [PATCH v1] TSO and TBS cannot co-exist. TBS requires special
 descriptor to be allocated at bootup. Initialising Tx queues at probe to
 support TSO and TBS can help in allocating those resources at bootup.
Message-ID: <uihm7fwg5s6vqdmkz3poasuukdhuc4ztep7doqxnvhhsbfmfop@iikjtrb4jwoi>
References: <20240206212734.1209920-1-quic_abchauha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206212734.1209920-1-quic_abchauha@quicinc.com>

Hey Abhishek,

Thanks for the patch!

This is a new feature for netdev, so the Subject should have "net-next"
in it: https://docs.kernel.org/process/maintainer-netdev.html#tl-dr

Another thing, the kernel is very particular about the commit messages.
I thought checkpatch.pl would complain about the subject line, but
surprisingly it didn't.

Usually going with a "when in rome" approach is good (i.e. take a look
at the git log). So here something like:

    "net: stmmac: dwmac-qcom-ethqos: Enable TBS on all queues but 0"

would be better. Its a short one line subject, that has the appropriate
prefix, etc. You could then embed the information about TSO and TBS
being exclusive, and maybe explain your reasoning on why this allocation
of queues (TSO on 0, TBS on the rest) was done.. etc in the body. Maybe even
pointing to the similar NXP related patch Esben posted recently would be
smart since your motivation is the same:

    commit 3b12ec8f618ebaccfe43ea4621a6f5fb586edef8
    Author: Esben Haabendal <esben@geanix.com>
    Date:   Fri Jan 26 10:10:42 2024 +0100

        net: stmmac: dwmac-imx: set TSO/TBS TX queues default settings

        TSO and TBS cannot coexist. For now we set i.MX Ethernet QOS controller to
        use the first TX queue with TSO and the rest for TBS.

        TX queues with TBS can support etf qdisc hw offload.

        Signed-off-by: Esben Haabendal <esben@geanix.com>
        Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
        Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
        Signed-off-by: Paolo Abeni <pabeni@redhat.com>

i.e. something like (please make it your own):

    In a similar vein to 3b12ec8f618e
    ("net: stmmac: dwmac-imx: set TSO/TBS TX queues default settings"),
    let's leave TSO enabled on queue 0 and enable TBS on all other queues.
    This allows using the etf qdisc with hw offload on the TBS enabled
    queues.

On Tue, Feb 06, 2024 at 01:27:34PM -0800, Abhishek Chauhan wrote:
> TX queues with TBS can support etf qdisc hw offload.
> 
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 31631e3f89d0..d2f9b8f6c027 100644
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
> +	/*Enable TSO on queue0 and enable TBS on rest of the queues*/

nitpicky: Please put spaces between the comments

> +	for (i = 1; i < plat_dat->tx_queues_to_use; i++)
> +		plat_dat->tx_queues_cfg[i].tbs_en = 1;
> +
>  	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
>  }
>  
> -- 
> 2.25.1
> 
> 


