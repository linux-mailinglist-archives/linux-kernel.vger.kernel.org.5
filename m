Return-Path: <linux-kernel+bounces-526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CB781427B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E191F23DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A941111A7;
	Fri, 15 Dec 2023 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpD4UKJh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631781096B;
	Fri, 15 Dec 2023 07:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFB8C433CB;
	Fri, 15 Dec 2023 07:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702625684;
	bh=ccmOE9j3jNhe4GDIdM1CW0I44hLwXu8dmx+o/QgsK+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HpD4UKJhNlD8/uebof6RQdb+aUvamm7Xl7XMyPaL/3KLU9qCdNJfISUWjS9XhFI93
	 tbXBqqXVbRbMAyAY5qPzLjL+CeiTLfJAnUZkNebVc5+BxOdZBr1ufqzFgZj6M6txsI
	 tvTR8UqrZgRNTv/cmj/yFjbiyJENmTklp9X/zAyqqP0k22r92+CnhUzL6dI8Je+KzD
	 /GqVrTX70r5tUe2kIEfsLTrSds44PSed3O/NiOTlqzqkDI2HE4YdJpII+VgYSi2JZ/
	 I2EFC64gljV1y/2KirKfWFjrAOorKc52tTXb1LW12WNnKHf1qnUC3E17gPL1uDu7vu
	 /Ef5Airp/WBoA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rE2iV-00066d-2I;
	Fri, 15 Dec 2023 08:34:39 +0100
Date: Fri, 15 Dec 2023 08:34:39 +0100
From: Johan Hovold <johan@kernel.org>
To: Richard Acayan <mailingradian@gmail.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm670: fix USB DP/DM HS PHY
 interrupts
Message-ID: <ZXwBj-EAZ1rE8erk@hovoldconsulting.com>
References: <20231214074319.11023-1-johan+linaro@kernel.org>
 <20231214074319.11023-2-johan+linaro@kernel.org>
 <ZXuv8zgm4kl3fwZV@radian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXuv8zgm4kl3fwZV@radian>

On Thu, Dec 14, 2023 at 08:46:27PM -0500, Richard Acayan wrote:
> On Thu, Dec 14, 2023 at 08:43:17AM +0100, Johan Hovold wrote:
> > The USB DP/DM HS PHY interrupts need to be provided by the PDC interrupt
> > controller in order to be able to wake the system up from low-power
> > states and to be able to detect disconnect events, which requires
> > triggering on falling edges.
> >
> > A recent commit updated the trigger type but failed to change the
> > interrupt provider as required. This leads to the current Linux driver
> > failing to probe instead of printing an error during suspend and USB
> > wakeup not working as intended.
> >
> > Fixes: de3b3de30999 ("arm64: dts: qcom: sdm670: fix USB wakeup interrupt types")
> > Fixes: 07c8ded6e373 ("arm64: dts: qcom: add sdm670 and pixel 3a device trees")
> > Cc: stable@vger.kernel.org      # 6.2
> > Cc: Richard Acayan <mailingradian@gmail.com>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> 
> Tested-by: Richard Acayan <mailingradian@gmail.com>
> 
> On a Pixel 3a, plugging in a USB cable doesn't wake up the device
> (presumably because there is no wakeup-source property) but this gets
> USB working again on linux-next.

Thanks for testing. And yes, the wakeup interrupts will indeed not be
enabled at system suspend unless the wakeup-source property is there.
Did you try adding it?

Johan

