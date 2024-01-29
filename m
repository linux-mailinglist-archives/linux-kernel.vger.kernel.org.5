Return-Path: <linux-kernel+bounces-43425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C496C8413B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF711F2494F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2506F096;
	Mon, 29 Jan 2024 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MeQl1Sw4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBE14E1BA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706557369; cv=none; b=YJuMD20iaBH4YzqP/GCs1q71arvA827Ej3XnCalnb1TqlQ9/tIY1/2fMVZdql3b429pAN8twKK6jf1kvp5ngLtH2VflzV0rPywh52aBUnJdQHOt9gmN/9ZGffoEUsbdUAuhTL30BJQXx1exp5jcQkYryg1VXErYxUQYbkZnsKGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706557369; c=relaxed/simple;
	bh=0IossWu4UpgVpMtMdcmHPu1ZZhD0JBLYr94Oq6BZXiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqR2g250UQvnWqcQi6wsdsry/9xYklvRJXHHph66EVdeuAmAkZUt+FrdmYJXPPYSkm4oeHoo9jXZciDG0ZMsohrarPUdB781SIBxauzdUGwbpF2+n6x7PJQhAjjcJDo2lu+CS96p7EB+6kCa2mhAnyubpytpbhN/lbarAUAtmfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MeQl1Sw4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706557366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6eMGjFNAQFg5AWGDSpwZ9ve2g+VcHkXFxxu/Em8ANwU=;
	b=MeQl1Sw4g4qN2d6z80K7aA2XoVSEY1TCv/Kr5FYBfqwmbFqD5dmeCJAYg3oK8wClpjd4Ak
	A/eHlgt/nFF2QDfgyUq1b57Gxzr1JPvSrPIJehK86KAVQRRMlD/mAJbYwcx52FQ7kl4kpy
	1tB1rEGcKyN6yp/zKnN375/WzxMLgBs=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-K-K6GELbObqPT7Wx4XArFA-1; Mon, 29 Jan 2024 14:42:45 -0500
X-MC-Unique: K-K6GELbObqPT7Wx4XArFA-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7d2df856a0bso831504241.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706557364; x=1707162164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6eMGjFNAQFg5AWGDSpwZ9ve2g+VcHkXFxxu/Em8ANwU=;
        b=sY45Y+T53dBiHnBUE4abCGXyCqbT1acDcjoTDGSSMhKyw/Qix/sLmAzMTaN4QnYwnT
         GCWeaHm+kW2E0aH83Jm3/CYzU2CThaeIOqvTK+C6w3KtPowlu/h5sU4oB2xZLEr9f5yE
         3rxNcMlNlI3FSMh9AKw8Th197ypsG/CXexF/NJJfVLWp57y1GleWZOpkyT9IyxsKuBA1
         5J77g6o0de117oUMwMF6LGrRaXnAwKbf0ofCv3HW5kQ3RYKoY27qABp5jyy0HRcF7/YS
         4CgIGMWE64OlncxPhRdxBJ+CjJKtVOEVmhZG1zqR1nteoECk0YU08nVyHzyg4rZwxSy4
         yckg==
X-Gm-Message-State: AOJu0YxZtAhrrve609GBjwkzOMZePW8StlQvJ38RBuiAaadeb4MT62sK
	YgmNgT35fhZ9fXIsIA8+Pj7l0Ynn+cq+NzKEdfg3mCpWEAfdo4/x0nZhQjYNC18+G83fLQkrzTa
	61TV12jww2FlNCwtkNR+cNYzhjVf2tnfS+dPY9Z6ykVZ2D5QiGVZPtGXRzzYT/w==
X-Received: by 2002:a05:6122:905:b0:4b6:d44e:2897 with SMTP id j5-20020a056122090500b004b6d44e2897mr2411884vka.33.1706557364490;
        Mon, 29 Jan 2024 11:42:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEThEh8Xkd7t3M3A0o/6ZDNQQdUgWUrOE1Coe2POYUY14FwHFSt1AWYC4c9IpcRASFz/2t94Q==
X-Received: by 2002:a05:6122:905:b0:4b6:d44e:2897 with SMTP id j5-20020a056122090500b004b6d44e2897mr2411868vka.33.1706557364144;
        Mon, 29 Jan 2024 11:42:44 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id pj2-20020a0562144b0200b0068c445b747bsm2266170qvb.59.2024.01.29.11.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 11:42:43 -0800 (PST)
Date: Mon, 29 Jan 2024 13:42:41 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Sneh Shah <quic_snehshah@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel@quicinc.com
Subject: Re: [PATCH net-next] net: stmmac: dwmac-qcom-ethqos: Add support for
 pm ops
Message-ID: <jnwylhbparw4uwci3epbd7th4izt3rnd3uzrnm5mdunm55kdoh@yyp4dprfh3sl>
References: <20240127130327.22443-1-quic_snehshah@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127130327.22443-1-quic_snehshah@quicinc.com>

On Sat, Jan 27, 2024 at 06:33:27PM +0530, Sneh Shah wrote:
> Add qcom ethqos specific runtime and system sleep pm ops.
> As part of system sleep qcom ethqos needs to disable all clocks.
> This ops will be extended further with qcom specific features.

This last sentence sounds like this series is incomplete, I'd avoid such
wording if its untrue. Upstream typically won't accept things that are
building infrastructure for patches that will "eventually be posted".

You state in your commit what the code does (really it replaces the
stmmac_pltfrm_ops with its own), but only gloss over the why. I'd lead
with the "why". i.e. I'd say something like
"net: stmmac: dwmac-qcom-ethqos: Turn clocks off/on during suspend/resume"

Since there's already a handler installed for PM ops, I'd explain why
you need to change to new ones as well.

> 
> Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>
> ---
>  .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 51 ++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 31631e3f89d0..cba601ee9e01 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -720,6 +720,55 @@ static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
>  	netdev_dbg(priv->dev, "PTP rate %d\n", plat_dat->clk_ptp_rate);
>  }
>  
> +static int qcom_ethqos_runtime_suspend(struct device *dev)
> +{
> +	struct net_device *ndev = dev_get_drvdata(dev);
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +
> +	return stmmac_bus_clks_config(priv, false);
> +}
> +

This perfectly matches the stmmac_runtime_suspend() function installed
originally. I don't see why you couldn't at a minimum reuse
that function instead of writing your own.

> +static int qcom_ethqos_runtime_resume(struct device *dev)
> +{
> +	struct net_device *ndev = dev_get_drvdata(dev);
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +
> +	return stmmac_bus_clks_config(priv, true);
> +}

Same idea as the stmmac_runtime_suspend() comment above!

> +
> +static int qcom_ethqos_suspend(struct device *dev)
> +{
> +	struct net_device *ndev = dev_get_drvdata(dev);
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	int ret;
> +
> +	if (!ndev || !netif_running(ndev))
> +		return -EINVAL;
> +
> +	ret = stmmac_suspend(dev);

ret here is ignored.

> +
> +	return stmmac_bus_clks_config(priv, false);
> +}
> +
> +static int qcom_ethqos_resume(struct device *dev)
> +{
> +	struct net_device *ndev = dev_get_drvdata(dev);
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	int ret;

unused ret.

> +
> +	if (!ndev || !netif_running(ndev))
> +		return -EINVAL;
> +
> +	stmmac_bus_clks_config(priv, true);

Probably should check this.

> +
> +	return stmmac_resume(dev);
> +}

Both the new system sleep ops installed here basically match the
stmmac_pltfrm_suspend/resume() functions that were already installed.
The only difference I'm noting is that you want to call
stmmac_bus_clks_config() in your implementation, whereas the originals call
the exit()/init() callbacks if they exist in the platform driver.

I would say "let's just make a exit()/init() callback for Qualcomm", but
looking further... (see below)

> +
> +const struct dev_pm_ops qcom_ethqos_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(qcom_ethqos_suspend, qcom_ethqos_resume)
> +	SET_RUNTIME_PM_OPS(qcom_ethqos_runtime_suspend, qcom_ethqos_runtime_resume, NULL)
> +};
> +
>  static int qcom_ethqos_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> @@ -838,7 +887,7 @@ static struct platform_driver qcom_ethqos_driver = {
>  	.probe  = qcom_ethqos_probe,
>  	.driver = {
>  		.name           = "qcom-ethqos",
> -		.pm		= &stmmac_pltfr_pm_ops,
> +		.pm		= &qcom_ethqos_pm_ops,

You effectively remove the stmmac_pltfr_noirq_suspend()/resume()
callbacks here, which do the stmmac_bus_clks_config() via
pm_runtime_force_suspend() etc during late suspend/early resume.

I do see this if statement, but I believe !device_may_wakeup() is true here,
so the clocks should get killed.

	static int __maybe_unused stmmac_pltfr_noirq_suspend(struct device *dev)
	{
		struct net_device *ndev = dev_get_drvdata(dev);
		struct stmmac_priv *priv = netdev_priv(ndev);
		int ret;

		if (!netif_running(ndev))
			return 0;

		if (!device_may_wakeup(priv->device) || !priv->plat->pmt) {
			/* Disable clock in case of PWM is off */
			clk_disable_unprepare(priv->plat->clk_ptp_ref);

			ret = pm_runtime_force_suspend(dev);
			if (ret)
				return ret;
		}

		return 0;
	}

Right now I'm of the opinion that this patch shouldn't really change
much based on that digging. Please let me know if I'm missing something
but it appears to me this should already be working.

>  		.of_match_table = qcom_ethqos_match,
>  	},
>  };
> -- 
> 2.17.1
> 


