Return-Path: <linux-kernel+bounces-76521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B525E85F859
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA08283F28
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C242F44367;
	Thu, 22 Feb 2024 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPF2Nf0m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFC37E769;
	Thu, 22 Feb 2024 12:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605499; cv=none; b=o2Smw5tZoEbaaiHhOGYuOHnHm66BxqyX1uL7QMesXme9qUf5EHfg5F5MdVxjHqfI6Sw5xvKVIrRXMN+lWKehNwWzviqwpuHZwz4lwwvHj7Hvia8qHH+BYpHpckAD8F4jy2qa7TOl3EC9Rq5z1AxEIh1DskmDzi3pL4kbnes5joI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605499; c=relaxed/simple;
	bh=sxaJLT5iKpLAmJvusUKEsV6Vqp4iTdyLko6AEmPLNgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=awtE2240ddhPVVgsuEE/YCOYHNNVY0Miivux9qhMjoGkID9Nuu+YaUZCBmxbNdqdJi5ChCXNZEK2BC/ZDCibZuRM48N/iWtMvANiABZ6XLtt/jtVcIv3KDG4dhKtSo2HcAvsbt/cPIwy2Sqdc4XIJNL4Xu5LqtjjhdJ9sattx1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPF2Nf0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09441C433F1;
	Thu, 22 Feb 2024 12:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708605498;
	bh=sxaJLT5iKpLAmJvusUKEsV6Vqp4iTdyLko6AEmPLNgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BPF2Nf0mrNYw7LRiePxAviGUUfj04Yg+PGN13BiZXpH/VlonJ99VG1txuwrzwHaxR
	 riZmO+LhZ489fzBgWABqQHJUWlGd1t/Q4+dO0v8txkuByDmIHBXijBLM6xQysDtVVC
	 SQR+e8Aw/gS+OdK6gj06++9AYC92hx5TKFNdwIaNGyT435YFB1wRO+e1EJ7vAqCOni
	 9UMu4HB4PwbBQUJMqdIVP7urlmo4hCiYfQS49w3arf27xw/f1qfaxvq9ZmaHd+DNwK
	 90Lpb9IX2FHdXYlsQDDsVbVcK0Jo6TOehqXMPzf7W2b+2bCVSOWgp3BTBUXj210oGA
	 jgheFw68CZWrg==
Date: Thu, 22 Feb 2024 06:38:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: root <root@hu-msarkar-hyd.qualcomm.com>
Cc: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org,
	conor+dt@kernel.org, quic_nitegupt@quicinc.com,
	quic_shazhuss@quicinc.com, quic_ramkri@quicinc.com,
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, Nitesh Gupta <nitegupt@quicinc.com>,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] PCI: qcom: Add support for detecting controller
 level PCIe errors
Message-ID: <20240222123816.GA1633656@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221185017.GA1536431@bhelgaas>

On Wed, Feb 21, 2024 at 12:50:17PM -0600, Bjorn Helgaas wrote:
> On Wed, Feb 21, 2024 at 07:34:04PM +0530, root wrote:
> > From: Nitesh Gupta <nitegupt@quicinc.com>
> > 
> > Synopsys Controllers provide capabilities to detect various controller
> > level errors. These can range from controller interface error to random
> > PCIe configuration errors. This patch intends to add support to detect
> > these errors and report it to userspace entity via sysfs, which can take
> > appropriate actions to mitigate the errors.

> > +static void qcom_pcie_enable_error_reporting_2_7_0(struct qcom_pcie *pcie)
> > +{
> > + ...
> 
> > +	val = readl(pci->dbi_base + DBI_DEVICE_CONTROL_DEVICE_STATUS);
> > +	val |= (PCIE_CAP_CORR_ERR_REPORT_EN | PCIE_CAP_NON_FATAL_ERR_REPORT_EN |
> > +			PCIE_CAP_FATAL_ERR_REPORT_EN | PCIE_CAP_UNSUPPORT_REQ_REP_EN);
> > +	writel(val, pci->dbi_base + DBI_DEVICE_CONTROL_DEVICE_STATUS);
> 
> Is there any way to split the AER part (specified by the PCIe spec)
> from the qcom-specific (or dwc-specific) part?  This looks an awful
> lot like pci_enable_pcie_error_reporting(), and we should do this in
> the PCI core in a generic way if possible.
> 
> > +	val = readl(pci->dbi_base + DBI_ROOT_CONTROL_ROOT_CAPABILITIES_REG);
> > +	val |= (PCIE_CAP_SYS_ERR_ON_CORR_ERR_EN | PCIE_CAP_SYS_ERR_ON_NON_FATAL_ERR_EN |
> > +			PCIE_CAP_SYS_ERR_ON_FATAL_ERR_EN);
> > +	writel(val, pci->dbi_base + DBI_ROOT_CONTROL_ROOT_CAPABILITIES_REG);

More to the point: why do we need to do this in the qcom driver at
all?  Why is pci_enable_pcie_error_reporting() not enough?

Bjorn

