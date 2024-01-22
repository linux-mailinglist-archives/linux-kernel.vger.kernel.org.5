Return-Path: <linux-kernel+bounces-32686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA296835EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4FE287F53
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C2139FF5;
	Mon, 22 Jan 2024 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUW4C+8W"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E232A3A1A6;
	Mon, 22 Jan 2024 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917645; cv=none; b=E/37k+V4DGu+tu1JcG7eh5AxQnwEfw9LTekICh2DbAK9TOav0eT00ZatXdbV2tu8RD3D4NEwwv50MAANC6fsgkslzx4c8UGf8QWvisDt9pgq6pHXt9CobXS1U6YHtK4phFnlp9HzFdPsd+Xfo7QtCUDP/quL9k7yN/Vc3lJtGdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917645; c=relaxed/simple;
	bh=RviGP00bc2z5L9e16SGhcQi/O8tKdDVcvKn/cFKyZf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XW+ilYPWEj5V2c89ln+hjQCw3zzWWkm415UC6ONMitgs0upMsfkXM7P6X1cex9GE8bFKfka0kkKjKZT7nigcGhryh1+rflMaY6c7T4T5HxlXso2wHU0U10kRa3luupShJIRXn7nXegj5sReRKhjkDuHorwD6QqKpw75b20liscI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUW4C+8W; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e72e3d435so2571837e87.2;
        Mon, 22 Jan 2024 02:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705917642; x=1706522442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XJvUSmFKxVkc/aj2645yUF6Llh0UZojhKj6fnT1VtgE=;
        b=WUW4C+8Wh0zOPj9d/SVIQclAlgvyP0Fl1r6I/MO7fVadx48xM8rnYgo5c1H8fDp/iD
         DcayBZuGZC9z/uo9/u1N176mBVKuI1JrluHtMZ17C9J7+35aHss+WEI3e2yCL6ovYJuj
         CRtZAxsFUCgcrW7pVY+vzhzoMldXcSs1z3Mb7VjJ34zNk7n32gBAbYKt7b8mRlXjt6Gm
         4R63gOIdy3jbaRxy9UBl2X1e6uCE4iXlkku3KVgDWkd5eWFENarTssDCtRYca94kk9F5
         /XYYxpRAjRvmP5AFl8SCt8xXmyJf9A+vm4vGKHnCQqCLRZGXNUgWKXd76OKx7a3Nqu6H
         99Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705917642; x=1706522442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJvUSmFKxVkc/aj2645yUF6Llh0UZojhKj6fnT1VtgE=;
        b=d0QkH02auwLQxTgnOD+Sg/zPa8JEYKicYY45OcFD1NUqh0pu5JYbiAmdEwBJUeQShC
         q0155Gd0BzJot5rEeT0g4NT2BaLs0oWD+hfLMutZh7oNA1j0TD5jmrS0b7JIgaieDEkt
         vyTI4aE6y0AtMAXbSLQC44MmdzKKK+FvdCrEqfz651JuxYDKdZvVeq9802d5yxPWUpzL
         u9NH8zboxIq1gsQMe6iCNMtLXu0R/yuE+wiUWZun4sIFbn+nImBZo1kLS0IKhFgHuN+U
         mAKKn2y5lonMpbQMeFe54HdlEhqkAEuiZeTpW+AJBIaR1ivwmQ9/OID0tB5pzG1L9h9J
         IrrQ==
X-Gm-Message-State: AOJu0Yy7YGHauK217MvVgW0gRyFwsDVJqW6LFhXeYEQyMAgDaR/FBqLD
	V67EjYEa8Xh8Px7piQvs8zo9C4WPEsoguZ+Iyk+EKA8rkGoWEKg9
X-Google-Smtp-Source: AGHT+IEssD/hfPPeOOMHxQJvdb3GjMChqufvu3VcLm9fhwD+pPdZrTLpsswyzYA4xoIoKlv/ESBQWQ==
X-Received: by 2002:ac2:42ca:0:b0:50e:3d3b:93fa with SMTP id n10-20020ac242ca000000b0050e3d3b93famr737632lfl.12.1705917641364;
        Mon, 22 Jan 2024 02:00:41 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id k5-20020ac24565000000b0050f0c199448sm1937151lfm.168.2024.01.22.02.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:00:40 -0800 (PST)
Date: Mon, 22 Jan 2024 13:00:37 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Denis Kirjanov <dkirjanov@suse.de>, 
	Suraj Jaiswal <quic_jsuraj@quicinc.com>
Cc: Suraj Jaiswal <quic_jsuraj@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, Prasad Sodagudi <psodagud@quicinc.com>, 
	Andrew Halaney <ahalaney@redhat.com>, Rob Herring <robh@kernel.org>, kernel@quicinc.com
Subject: Re: [PATCH net-next v9 3/3] net: stmmac: Add driver support for
 DWMAC5 common safety IRQ
Message-ID: <giimpexp3qk3byb725r3ot3aund2bwmi45yrctkydatm73d5af@e36xmjf2ehvu>
References: <20240110111649.2256450-1-quic_jsuraj@quicinc.com>
 <20240110111649.2256450-4-quic_jsuraj@quicinc.com>
 <633ff61d-f73d-4221-a2fd-79f913880761@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <633ff61d-f73d-4221-a2fd-79f913880761@suse.de>

On Wed, Jan 10, 2024 at 03:07:30PM +0300, Denis Kirjanov wrote:
> 
> 
> On 1/10/24 14:16, Suraj Jaiswal wrote:
> > Add support to listen HW safety IRQ like ECC(error
> > correction code), DPP(data path parity), FSM(finite state
> > machine) fault in common IRQ line.
> 
> As I see .safety_feat_irq_status available not just in dwmac5 but 
> in dwxgmac2_core and that means that the subject line is not just about dwmac5

Right. Suraj, could you please fix the subject to be describing the
actual change? The commit message body more-or-less describes it
correctly.

> 
> > 
> > Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
> >  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3 ++
> >  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 41 ++++++++++++++++++-
> >  .../ethernet/stmicro/stmmac/stmmac_platform.c |  8 ++++
> >  4 files changed, 51 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> > index 721c1f8e892f..b9233b09b80f 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> > @@ -344,6 +344,7 @@ enum request_irq_err {
> >  	REQ_IRQ_ERR_ALL,
> >  	REQ_IRQ_ERR_TX,
> >  	REQ_IRQ_ERR_RX,
> > +	REQ_IRQ_ERR_SFTY,
> >  	REQ_IRQ_ERR_SFTY_UE,
> >  	REQ_IRQ_ERR_SFTY_CE,
> >  	REQ_IRQ_ERR_LPI,
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> > index 9f89acf31050..ca3d93851bed 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> > @@ -31,6 +31,7 @@ struct stmmac_resources {
> >  	int wol_irq;
> >  	int lpi_irq;
> >  	int irq;
> > +	int sfty_irq;
> >  	int sfty_ce_irq;
> >  	int sfty_ue_irq;
> >  	int rx_irq[MTL_MAX_RX_QUEUES];
> > @@ -297,6 +298,7 @@ struct stmmac_priv {
> >  	void __iomem *ptpaddr;
> >  	void __iomem *estaddr;
> >  	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
> > +	int sfty_irq;
> >  	int sfty_ce_irq;
> >  	int sfty_ue_irq;
> >  	int rx_irq[MTL_MAX_RX_QUEUES];
> > @@ -305,6 +307,7 @@ struct stmmac_priv {
> >  	char int_name_mac[IFNAMSIZ + 9];
> >  	char int_name_wol[IFNAMSIZ + 9];
> >  	char int_name_lpi[IFNAMSIZ + 9];
> > +	char int_name_sfty[IFNAMSIZ + 10];
> >  	char int_name_sfty_ce[IFNAMSIZ + 10];
> >  	char int_name_sfty_ue[IFNAMSIZ + 10];
> >  	char int_name_rx_irq[MTL_MAX_TX_QUEUES][IFNAMSIZ + 14];
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 47de466e432c..e0192a282121 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -3592,6 +3592,10 @@ static void stmmac_free_irq(struct net_device *dev,
> >  		if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
> >  			free_irq(priv->wol_irq, dev);
> >  		fallthrough;
> > +	case REQ_IRQ_ERR_SFTY:
> > +		if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq)
> > +			free_irq(priv->sfty_irq, dev);
> > +		fallthrough;
> >  	case REQ_IRQ_ERR_WOL:
> >  		free_irq(dev->irq, dev);
> >  		fallthrough;
> > @@ -3661,6 +3665,23 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
> >  		}
> >  	}
> >  
> > +	/* Request the common Safety Feature Correctible/Uncorrectible
> > +	 * Error line in case of another line is used
> > +	 */
> > +	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {
> > +		int_name = priv->int_name_sfty;
> > +		sprintf(int_name, "%s:%s", dev->name, "safety");
> > +		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
> > +				  0, int_name, dev);
> > +		if (unlikely(ret < 0)) {
> > +			netdev_err(priv->dev,
> > +				   "%s: alloc sfty MSI %d (error: %d)\n",
> > +				   __func__, priv->sfty_irq, ret);
> > +			irq_err = REQ_IRQ_ERR_SFTY;
> > +			goto irq_error;
> > +		}
> > +	}
> > +
> >  	/* Request the Safety Feature Correctible Error line in
> >  	 * case of another line is used
> >  	 */
> > @@ -3798,6 +3819,21 @@ static int stmmac_request_irq_single(struct net_device *dev)
> >  		}
> >  	}
> >  
> > +	/* Request the common Safety Feature Correctible/Uncorrectible
> > +	 * Error line in case of another line is used
> > +	 */
> > +	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {
> > +		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
> > +				  IRQF_SHARED, dev->name, dev);
> > +		if (unlikely(ret < 0)) {
> > +			netdev_err(priv->dev,
> > +				   "%s: ERROR: allocating the sfty IRQ %d (%d)\n",
> > +				   __func__, priv->sfty_irq, ret);
> > +			irq_err = REQ_IRQ_ERR_SFTY;
> > +			goto irq_error;
> > +		}
> > +	}
> > +
> >  	return 0;
> >  
> >  irq_error:
> > @@ -6022,8 +6058,8 @@ static irqreturn_t stmmac_interrupt(int irq, void *dev_id)
> >  	if (test_bit(STMMAC_DOWN, &priv->state))
> >  		return IRQ_HANDLED;
> >  

> > -	/* Check if a fatal error happened */
> > -	if (stmmac_safety_feat_interrupt(priv))
> > +	/* Check ASP error if it isn't delivered via an individual IRQ */
> > +	if (priv->sfty_irq <= 0 && stmmac_safety_feat_interrupt(priv))

Well, I guess this is the best we can do with no IRQs handling part
refactoring.

> >  		return IRQ_HANDLED;
> >  
> >  	/* To handle Common interrupts */
> > @@ -7462,6 +7498,7 @@ int stmmac_dvr_probe(struct device *device,
> >  	priv->dev->irq = res->irq;
> >  	priv->wol_irq = res->wol_irq;
> >  	priv->lpi_irq = res->lpi_irq;
> > +	priv->sfty_irq = res->sfty_irq;
> >  	priv->sfty_ce_irq = res->sfty_ce_irq;
> >  	priv->sfty_ue_irq = res->sfty_ue_irq;
> >  	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > index 70eadc83ca68..ab250161fd79 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > @@ -743,6 +743,14 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
> >  		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
> >  	}
> >  
> > +	stmmac_res->sfty_irq =
> > +		platform_get_irq_byname_optional(pdev, "sfty");
> > +	if (stmmac_res->sfty_irq < 0) {
> > +		if (stmmac_res->sfty_irq == -EPROBE_DEFER)
> > +			return -EPROBE_DEFER;
> > +		dev_info(&pdev->dev, "IRQ safety IRQ not found\n");

s/IRQ safety IRQ/IRQ sfty
* Although I would have also converted this to just dev_dbg() since
* the IRQ line is optional and is present on a single platform you
* have.


With the subject and the log-message fixed feel free to add:

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y) 

> > +	}
> > +
> >  	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
> >  
> >  	return PTR_ERR_OR_ZERO(stmmac_res->addr);
> 

