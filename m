Return-Path: <linux-kernel+bounces-132644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4563C8997B1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A62281E8E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B549E1465B5;
	Fri,  5 Apr 2024 08:23:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386A413D265;
	Fri,  5 Apr 2024 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305401; cv=none; b=tlOKdKtEiLcjUQ00iumhcrifini8J4mpXJg38Hdff3QO8sYnAMXtSsiXqsu4dNlOWz0Kae7E7BoFRhsLD17+eWfNJz/HtRbpJGXq6jy6VO7PyfSNYbxSRoScCxLHPw0JKw7zx8wtUUXcObUt+EYCfEy7EWGpnltwB6KhUvrH77k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305401; c=relaxed/simple;
	bh=XD5Gi3+swQNJ7msa6Jo0RxLzsMbB8WlGIPxGLCNByJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3B5MUQeJqCNhUnPmR6rTqmjq6ico68nzdbfBl3O73WojYLcUQUoQbI2sX0FpoiI2QUhwnf1DC3F18k81aksCcNw7NrAd/RshetyalKqet8O7u6DQz/tamWWVMo+sq0ehCDxbt9ygJw6varJEgRACdRfGCin2QiJorutziFi+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7BBC43390;
	Fri,  5 Apr 2024 08:23:14 +0000 (UTC)
Date: Fri, 5 Apr 2024 13:53:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vireshk@kernel.org,
	quic_vbadigan@quicinc.com, quic_skananth@quicinc.com,
	quic_nitegupt@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v8 7/7] PCI: qcom: Add OPP support to scale performance
 state of power domain
Message-ID: <20240405082306.GD2953@thinkpad>
References: <20240302-opp_support-v8-0-158285b86b10@quicinc.com>
 <20240302-opp_support-v8-7-158285b86b10@quicinc.com>
 <20240304180506.GE31079@thinkpad>
 <c74e326e-285d-854e-5e54-329079152df2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c74e326e-285d-854e-5e54-329079152df2@quicinc.com>

On Tue, Mar 05, 2024 at 04:44:20PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 3/4/2024 11:35 PM, Manivannan Sadhasivam wrote:
> > On Sat, Mar 02, 2024 at 09:30:01AM +0530, Krishna chaitanya chundru wrote:
> > > QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
> > > maintains hardware state of a regulator by performing max aggregation of
> > > the requests made by all of the clients.
> > > 
> > > PCIe controller can operate on different RPMh performance state of power
> > > domain based on the speed of the link. And this performance state varies
> > > from target to target, like some controllers support GEN3 in NOM (Nominal)
> > > voltage corner, while some other supports GEN3 in low SVS (static voltage
> > > scaling).
> > > 
> > > The SoC can be more power efficient if we scale the performance state
> > > based on the aggregate PCIe link bandwidth.
> > > 
> > > Add Operating Performance Points (OPP) support to vote for RPMh state based
> > > on the aggregate link bandwidth.
> > > 
> > > OPP can handle ICC bw voting also, so move ICC bw voting through OPP
> > > framework if OPP entries are present.
> > > 
> > > Different link configurations may share the same aggregate bandwidth,
> > > e.g., a 2.5 GT/s x2 link and a 5.0 GT/s x1 link have the same bandwidth
> > > and share the same OPP entry.
> > > 
> > > As we are moving ICC voting as part of OPP, don't initialize ICC if OPP
> > > is supported.
> > > 
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 81 +++++++++++++++++++++++++++-------
> > >   1 file changed, 66 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index a0266bfe71f1..2ec14bfafcfc 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c

[...]

> > >   static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
> > > @@ -1472,8 +1491,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
> > >   static int qcom_pcie_probe(struct platform_device *pdev)
> > >   {
> > >   	const struct qcom_pcie_cfg *pcie_cfg;
> > > +	unsigned long max_freq = INT_MAX;
> > >   	struct device *dev = &pdev->dev;
> > >   	struct qcom_pcie *pcie;
> > > +	struct dev_pm_opp *opp;
> > >   	struct dw_pcie_rp *pp;
> > >   	struct resource *res;
> > >   	struct dw_pcie *pci;
> > > @@ -1540,9 +1561,36 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> > >   		goto err_pm_runtime_put;
> > >   	}
> > > -	ret = qcom_pcie_icc_init(pcie);
> > > -	if (ret)
> > > +	 /* OPP table is optional */
> > > +	ret = devm_pm_opp_of_add_table(dev);
> > > +	if (ret && ret != -ENODEV) {
> > > +		dev_err_probe(dev, ret, "Failed to add OPP table\n");
> > >   		goto err_pm_runtime_put;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Use highest OPP here if the OPP table is present. At the end of
> > 
> > Why highest opp? For ICC, we set minimal bandwidth before.
> > 
> In OPP we are voting for both ICC and voltage corner also, if we didn't vote
> for maximum voltage core the PCIe link may not come in maximum supported
> speed. Due to that we are voting for Maximum value.
> 

Okay, then this information should be part of the comment.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

