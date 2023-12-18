Return-Path: <linux-kernel+bounces-3105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EBA816786
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95562B20BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8148D308;
	Mon, 18 Dec 2023 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfysvMgl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18701E541;
	Mon, 18 Dec 2023 07:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AFEC433C8;
	Mon, 18 Dec 2023 07:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702885152;
	bh=DLIMnOLvVX+xJyjnOj2ITzwyjQr/CpHXdFQMsKuGcyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cfysvMgl3/mr9VnMvG1t3dAfH/yPt2bURa4RzMKMKnwu+g5amf1eylO5Kep7nm+Rm
	 xvM/I1xXjWHpXODWotiCCWPbQ4qDTe5pxbWjJTfQuf0tCIuoPbAOlm1uUDw7+ovNs4
	 5tY8lmhlM/2rvirKVtLTJOGm7z7NdXsFNEKlhlYwQrzBlx6/AmWJN1z3CjmqHfXkNz
	 0EmCDGT2hFQA7JwD23ClH0vMWNEGq0pbNMsb+cyvkfHMH6EvlNalzu0XyW0uUaRZie
	 cVTNgLzOy4iqk3Pr+liNKAX5NomSHujWxRPkJuf6CRskHBbE2HAdYSzu9nUu46bMgT
	 Y+iWwMjt/AeFQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rF8DX-00058K-2i;
	Mon, 18 Dec 2023 08:39:11 +0100
Date: Mon, 18 Dec 2023 08:39:11 +0100
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
Message-ID: <ZX_3H09Vx7Xyf8ti@hovoldconsulting.com>
References: <20231214074319.11023-1-johan+linaro@kernel.org>
 <20231214074319.11023-2-johan+linaro@kernel.org>
 <ZX0MzT5jX_s_m_1Y@radian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZX0MzT5jX_s_m_1Y@radian>

On Fri, Dec 15, 2023 at 09:34:53PM -0500, Richard Acayan wrote:
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
> 
> I almost forgot to mention, both SDM670 patches seem to depend on
> b51ee205dc4f ("arm64: dts: qcom: sdm670: Add PDC") in 6.6 to compile
> properly.

Thanks for spotting that. The 6.5 stable tree is EOL now so this will
fortunately not be an issue in practice.

Johan

