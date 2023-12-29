Return-Path: <linux-kernel+bounces-13061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D7481FF24
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1133282E50
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F286E1118F;
	Fri, 29 Dec 2023 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IR+9Pbtz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429E611183;
	Fri, 29 Dec 2023 11:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EA6C433C8;
	Fri, 29 Dec 2023 11:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703849103;
	bh=MieiRL5YdRkCYRdCXxYZ9gmxzPhKZ67/qsDP0kxrLek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IR+9Pbtzwr09SaZmVGlv9yoDpz0bu/d6mWkxctCHahOojgGp7pfbNM0DxDS5tb+3y
	 tOEMh3fQ6BiTfse0W+6wPYFRr3Ex0I8j2ndTRV3jASg6HrQQvgHn0hFlB8xCYKCSGd
	 reMdwCIGWew6JxWL+9n2gzvPjI4reIWZY99troit764ZHHiRB6Lj+tazMMfyEQwQNa
	 6XsqCC1wb8pcemSWwTndXT7hWgCcHMSiD49O2ps4sDlWQnPNqj6lPKOE8/ieMOOrHO
	 ghBh9s6zaW1j8U2mzPxL40mueEaopWkYMKyX4TW2goce3aZc7vVmUy8vFJ4uhW3fZ7
	 X5jf2rbaVMWcg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rJAz1-0007Nf-2f;
	Fri, 29 Dec 2023 12:24:56 +0100
Date: Fri, 29 Dec 2023 12:24:55 +0100
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
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sc8280xp: Fix PCIe PHY
 power-domains
Message-ID: <ZY6sh8nlEUyEfL0u@hovoldconsulting.com>
References: <20231227-topic-8280_pcie_dts-v1-0-13d12b1698ff@linaro.org>
 <20231227-topic-8280_pcie_dts-v1-1-13d12b1698ff@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227-topic-8280_pcie_dts-v1-1-13d12b1698ff@linaro.org>

On Wed, Dec 27, 2023 at 11:28:26PM +0100, Konrad Dybcio wrote:
> The PCIe GDSCs are only related to the RCs. The PCIe PHYs on the other
> hand, are powered by VDD_MX and their specific VDDA_PHY/PLL regulators.

No, that does not seem to be entirely correct. I added the power-domains
here precisely because they were needed to enable the PHYs.

This is something I stumbled over when trying to figure out how to
add support for the second lane pair (i.e. four-lane mode), and I just
went back and confirmed that this is still the case.

If you try to enable one of these PHYs without the corresponding GDSC
being enabled, you end up with:

[   37.709324] ------------[ cut here ]------------
[   37.718196] gcc_pcie_3b_aux_clk status stuck at 'off'
[   37.718205] WARNING: CPU: 4 PID: 482 at drivers/clk/qcom/clk-branch.c:86 clk_branch_wait+0x144/0x15c
	
Now, you may or may not want to describe the above in the devicetree,
but this makes it sound like you're trying to work around an issue with
the current Linux implementation.

> Fix the power-domains assignment to stop potentially toggling the GDSC
> unnecessarily.

Nothing is being toggled unnecessarily, and generally this is just
another use count increment.

> Fixes: 813e83157001 ("arm64: dts: qcom: sc8280xp/sa8540p: add PCIe2-4 nodes")

So not sure a Fixes tag is warranted either.

> @@ -1895,7 +1895,7 @@ pcie3b_phy: phy@1c0e000 {
>  			assigned-clocks = <&gcc GCC_PCIE3B_PHY_RCHNG_CLK>;
>  			assigned-clock-rates = <100000000>;
>  
> -			power-domains = <&gcc PCIE_3B_GDSC>;
> +			power-domains = <&rpmhpd SC8280XP_MX>;
>  
>  			resets = <&gcc GCC_PCIE_3B_PHY_BCR>;
>  			reset-names = "phy";

Johan

