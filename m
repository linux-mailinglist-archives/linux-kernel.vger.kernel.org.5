Return-Path: <linux-kernel+bounces-13088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DDB81FF8C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3164EB21998
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E5C1172D;
	Fri, 29 Dec 2023 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5iIvUsb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A811E11705;
	Fri, 29 Dec 2023 13:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218D3C433C8;
	Fri, 29 Dec 2023 13:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703854874;
	bh=3DRFvSQwixMH0DXgU8nYRceIY5QE4EsSnvVGoP7ntTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N5iIvUsbwk+t29KgblAN8s6BmmNldvrHJEsyE0VydeVI+6gDAfPI4a1Bs1pbT3dAL
	 kin7FFubLw5beSFOcDE+YjzXAjQWoOhY/etxE4VaKlu76m9F3XSbv/Nv8o+StRWnfP
	 bjtKQjzZNHwagttZILdNkzNqe4TJKwpjpYnO+ONYoQM4cUf+ba1IXKH9vOvc7Vzu5R
	 4RS2LKtm5RfSnq6l9stJWLsNS8NDV1UMJBIT5ObMKJmLlFwwt/VqwmGvvDjLWOKzKY
	 ImBT5M0+tfwF0jYkehMMrX8pltg3o9fusJ9GMcr2NVvpzKWrbpo53caGl/2wU6jgJp
	 Lz7dOzs/D2WhA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rJCU6-0007hq-21;
	Fri, 29 Dec 2023 14:01:07 +0100
Date: Fri, 29 Dec 2023 14:01:06 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sc8280xp: Correct USB PHY power
 domains
Message-ID: <ZY7DEpaIgvfL_A11@hovoldconsulting.com>
References: <20231227-topic-8280_pcie_dts-v1-0-13d12b1698ff@linaro.org>
 <20231227-topic-8280_pcie_dts-v1-2-13d12b1698ff@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227-topic-8280_pcie_dts-v1-2-13d12b1698ff@linaro.org>

On Wed, Dec 27, 2023 at 11:28:27PM +0100, Konrad Dybcio wrote:
> The USB GDSCs are only related to the controllers.

Are you sure?

> The PHYs on the other
> hand, are powered by VDD_MX and their specific VDDA_PHY/PLL regulators.
> 
> Fix the power-domains assignment to stop potentially toggling the GDSC
> unnecessarily.

Again, there's no additional toggling being done here, but yes, this may
keep the domains enabled during suspend depending on how the driver is
implemented.

If that's the concern, then please spell that out too.

> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")

May not be needed either.

> @@ -2597,7 +2597,7 @@ usb_2_qmpphy0: phy@88ef000 {
>  				 <&gcc GCC_USB3UNIPHY_PHY_MP0_BCR>;
>  			reset-names = "phy", "phy_phy";
>  
> -			power-domains = <&gcc USB30_MP_GDSC>;
> +			power-domains = <&rpmhpd SC8280XP_MX>;

Johan

