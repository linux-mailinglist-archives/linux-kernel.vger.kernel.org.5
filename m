Return-Path: <linux-kernel+bounces-132558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D807C89969A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7750F1F22CD4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC9848CFD;
	Fri,  5 Apr 2024 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxdH4r7g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D6847F7E;
	Fri,  5 Apr 2024 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712302466; cv=none; b=n6HWexNCumLhCFzpDh7AXt21OiXPTzUEP/Ac5sLKdoCag7HIk7mUY2+lTvHqoTl4ItfcY/qidT4hiEIcBHN1XWODj94Sq80Iv4SYlz0QmzURnAJinPvabjm0G1HdtSfq0+KK8dluXBPTsFkdMXujiDarjHKfoim/nzCP4pNvTBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712302466; c=relaxed/simple;
	bh=oaq9Chvq0Xt0yDSaB529RRq1eKJleLzX7w7NqMqrl24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeIce2uWxvlLx1AMQYQf7OHaOvslyxZsmrrRR8QQ2NF3WadeKatDXBjk615OO50teqbVK7s3ZtBqoVHwkeFLE2gBDF72P8WvkGpeXejf4/Jufhln3jDJ3cnO58LGoxjsGtTGfFypHTqymGkzB0vtjRNdSMBLlc6ulwhG2x/9ZfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxdH4r7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EA8C433F1;
	Fri,  5 Apr 2024 07:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712302465;
	bh=oaq9Chvq0Xt0yDSaB529RRq1eKJleLzX7w7NqMqrl24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JxdH4r7gT+DnO3b8C6d9K6qOC8OKy698/iGb6CRqMtMtnyI4yH1atmnDXRWbgVy8C
	 dHELKn+OiiNNbpkAck78a62oRO+Z5dNhnHD/e4EtarFk4DRIz0Ovl65AcAwi8b48yQ
	 RYktGhaJWEeehCVL7D788Zx/rRiFvrf7+nSmP71t4MzrD7b9DMt0eWHGLlCEiqMERL
	 dPJMUjDboxCy5KNlW3JsnEHHnsATZ73IOdHeft6RdkvPIdtRi9AgPBBHhUGMDP22po
	 FlzrcRKnsRYvrRsrBva8j1TJENfLaXQzC9kfE3Ql9H1Akk8knq0BAqBgyRpyx0Zb9E
	 Bh9W4Kef6EUqQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rse5j-00000000606-2pQx;
	Fri, 05 Apr 2024 09:34:27 +0200
Date: Fri, 5 Apr 2024 09:34:27 +0200
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Stephen Boyd <swboyd@chromium.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-phy@lists.infradead.org, freedreno@lists.freedesktop.org,
	Douglas Anderson <dianders@chromium.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Steev Klimaszewski <steev@kali.org>,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH] phy: qcom: qmp-combo: Fix register base for
 QSERDES_DP_PHY_MODE
Message-ID: <Zg-pg-QAAfC9Pybr@hovoldconsulting.com>
References: <20240405000111.1450598-1-swboyd@chromium.org>
 <Zg9MQOAZpsndSNtb@hu-bjorande-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg9MQOAZpsndSNtb@hu-bjorande-lv.qualcomm.com>

On Thu, Apr 04, 2024 at 05:56:32PM -0700, Bjorn Andersson wrote:
> On Thu, Apr 04, 2024 at 05:01:03PM -0700, Stephen Boyd wrote:
> > The register base that was used to write to the QSERDES_DP_PHY_MODE
> > register was 'dp_dp_phy' before commit 815891eee668 ("phy:
> > qcom-qmp-combo: Introduce orientation variable"). There isn't any
> > explanation in the commit why this is changed, so I suspect it was an
> > oversight or happened while being extracted from some other series.
> 
> Thanks for catching that, I wrote that patch long before Johan did the
> rename of "pcs" to "dp_dp_phy", and must have missed that while later
> rebasing the patch.
> 
> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>
> > Oddly the value being 0x4c or 0x5c doesn't seem to matter for me, so I
> > suspect this is dead code, but that can be fixed in another patch. It's
> > not good to write to the wrong register space, and maybe some other
> > version of this phy relies on this.

This code is still reached on sc8280xp, but I guess only Qualcomm can
tell us what these bits are for (and they should).

The write to qmp->pcs + QSERDES_DP_PHY_MODE does not seem to have any
effect on sc8280xp and that register still reads back as 0x2020202 after
the incorrect write.

qmp->dp_dp_phy + QSERDES_DP_PHY_MODE reads back as 0x4c4c4c4c before the
fixed write and either 0x4c4c4c4c or 0x5c5c5c5c after depending on the
orientation.

Can someone please replace the magic constants in this driver, and at
least explain what the impact of bit 0x10 not reflecting the orientation
is?

> > Fixes: 815891eee668 ("phy: qcom-qmp-combo: Introduce orientation variable")
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Either way, good catch, this was clearly unintentional:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

I think this should go to stable as well even if the impact is currently
not fully understood:

Cc: stable@vger.kernel.org	# 6.5

> > @@ -2150,9 +2150,9 @@ static bool qmp_combo_configure_dp_mode(struct qmp_combo *qmp)
> >  	writel(val, qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
> >  
> >  	if (reverse)
> > -		writel(0x4c, qmp->pcs + QSERDES_DP_PHY_MODE);
> > +		writel(0x4c, qmp->dp_dp_phy + QSERDES_DP_PHY_MODE);
> >  	else
> > -		writel(0x5c, qmp->pcs + QSERDES_DP_PHY_MODE);
> > +		writel(0x5c, qmp->dp_dp_phy + QSERDES_DP_PHY_MODE);

Johan

