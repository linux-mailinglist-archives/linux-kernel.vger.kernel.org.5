Return-Path: <linux-kernel+bounces-48898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54F08462F7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A568B27176
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AA2405F7;
	Thu,  1 Feb 2024 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsMgwn8J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683FE3FE37;
	Thu,  1 Feb 2024 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824437; cv=none; b=W+9ZjicHnAw9h4XOwTU/ukY+oOaprwcmavBEHYeltt5nmRy2tQqNPNRJtqLYFF+n5CO3ML1Aqo8B7oqZwhByuTO5bVSBWNo5334rgbx3+eQgR8Bsda4JG1aDOA+e4KNpD02xydQhnGPsOpuxTb0AGjBQN4MCePu7ZMDaxpHPDpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824437; c=relaxed/simple;
	bh=ApF0fuJM9LahCwtp9OKHrxVJ6Bt5ITSdn6RlluIjytU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqoDLNE1/N8rxS1uuURbxNAmt2xd3s6yWSrdvLnnP2++lCG4muJr9sDOOmEJT+QVJeyN61F34smYwAbsEZ9tRqoFwV3NG37VSANpJBnszHPK/hIvxcganadit4U1kzQ4oJxMq+EQM0J/t8b7sYA0ljKor+2nJbG/hzTVf8Ri1+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsMgwn8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F239AC43390;
	Thu,  1 Feb 2024 21:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706824436;
	bh=ApF0fuJM9LahCwtp9OKHrxVJ6Bt5ITSdn6RlluIjytU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZsMgwn8JOKoqImUIHlGktSAqvBXVIJwKqi3VBWhX+gBNLb8Tqk/wsc3FwxEcT6YNE
	 PeoAod82Pd5pk1H4h36ylutaQqPqnihNu6yRvLs6lAViMyy/ALhJ3uFl/UdgQZbpy3
	 25AqEGw+DQ/+kuhwHGKnzs+tuR0ASIeT2GjDZxeC/c/698FKEgd1bk8IZ4rP+/s6hJ
	 9BTx7s67DUy4k02VYyZ9+UnhrwcVa8LsDKdhr0wifkGTGQhli10pHK/0f0ArVAEAPi
	 YDNtOObFONTCNoDLze1gWWS9ZuqErTaw6uEhUR5i3eNb9bkbkTXJshlujqqASI19Kg
	 oVGyoTHtW6bIg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Andy Gross <agross@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	David Wronek <davidwronek@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Joe Mason <buddyjojo06@outlook.com>
Subject: Re: (subset) [PATCH v4 0/8] Add UFS support for SC7180/SM7125
Date: Thu,  1 Feb 2024 15:53:47 -0600
Message-ID: <170682442877.248329.5672084774517998432.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
References: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 21 Jan 2024 17:57:40 +0100, David Wronek wrote:
> This patchset introduces UFS support for SC7180 and SM7125, as well as
> support for the Xiaomi Redmi Note 9S.
> 
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@linaro.org>
> To: Herbert Xu <herbert@gondor.apana.org.au>
> To: David S. Miller <davem@davemloft.net>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> To: Alim Akhtar <alim.akhtar@samsung.com>
> To: Avri Altman <avri.altman@wdc.com>
> To: Bart Van Assche <bvanassche@acm.org>
> To: Andy Gross <agross@kernel.org>
> To: Vinod Koul <vkoul@kernel.org>
> To: Kishon Vijay Abraham I <kishon@kernel.org>
> To:  <cros-qcom-dts-watchers@chromium.org>
> Cc:  <linux-arm-msm@vger.kernel.org>
> Cc:  <linux-crypto@vger.kernel.org>
> Cc:  <devicetree@vger.kernel.org>
> Cc:  <linux-kernel@vger.kernel.org>
> Cc:  <linux-scsi@vger.kernel.org>
> Cc:  <linux-phy@lists.infradead.org>
> CC:  <~postmarketos/upstreaming@lists.sr.ht>
> 
> [...]

Applied, thanks!

[4/8] dt-bindings: arm: qcom: Add Xiaomi Redmi Note 9S
      commit: 526b333d7c275a851ce982357218496569b3958e
[6/8] arm64: dts: qcom: sc7180: Add UFS nodes
      commit: 858536d9dc946b039e107350642ac6d78c235a6b
[7/8] arm64: dts: qcom: sm7125-xiaomi-common: Add UFS nodes
      commit: 00aaa58e8936558f7526f2376d3740885b5c7312
[8/8] arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S
      commit: 6016fb7c91f72f4afbb4017e13cd91954d0f1a9b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

