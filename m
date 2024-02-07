Return-Path: <linux-kernel+bounces-56902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E0484D10B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735DD1C25FC0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBD183CC6;
	Wed,  7 Feb 2024 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEGhdQDJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0294F82C64;
	Wed,  7 Feb 2024 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329977; cv=none; b=AFTUmJd7vK91cl2nOYbSIc/1Y8JYHfOBndhPAWB2PezOn8lwxAWx7DaGuzDgNibwiBWEi6fZmLae9gMz9eDaLxMlJquZIjBCdRIgjA5PE1P08nXBPQH9Qafx6MS3trKKjoCH1UchPvamEGf+LuqpVbhM6XJH+aMQPFTx5dvbQaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329977; c=relaxed/simple;
	bh=yzqZkWmurf1d3vXbpPSRq3flg3TmxvLtRnfELAdKB7g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CYKtwLRpEe61L8FIgCvp+bq+TrwkLzWucmdTTMtwaSi9eM5i2BtiwHbd2qtxVG4NEBPfrsVlkZ1kSaWThL/YdY7qoDJRilHxjk4t3NoZ+H9LgDgkBoEhzySuJ1okZoLmzXReIQSwbAay3pZgb7D86j2H3AY53bG/s4WbfzIOPYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEGhdQDJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F479C43390;
	Wed,  7 Feb 2024 18:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707329976;
	bh=yzqZkWmurf1d3vXbpPSRq3flg3TmxvLtRnfELAdKB7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kEGhdQDJzavIhJvxC2C52ffr/UE9SoJ9mSUpiZCNmq1JypOn2mgZ6hiueF8bHxcmz
	 JPeRnosDHGyBRAaDNn/KALE4+xNTlFO7Uwq10pSMRCdC1PakuguEDBP7qR2Mab/dTy
	 aLaAesbZaSjSnMezz+7Pjja6d1pGC7TqHrOsOu+zrDFcXJS8LRhccozlrWXUSCkbdb
	 9nCjFktQAC3cyrJW74mDt5pmRpu3SuaKL4rAAzo81ZlKJ9O40lGgwyqUrsLwLgAjBf
	 UU540HAIc1fpuPXdzChWcQOMrX2XMquNc120ZiWSrUYi0WsGdIu6zg1PFuTHgS5uuv
	 zhj1lqaBMdeWw==
Date: Wed, 7 Feb 2024 10:19:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Abhishek Chauhan <quic_abchauha@quicinc.com>, Vinod Koul
 <vkoul@kernel.org>, Bhupesh Sharma <bhupesh.sharma@linaro.org>, Andy Gross
 <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 Prasad Sodagudi <psodagud@quicinc.com>, Andrew Halaney
 <ahalaney@redhat.com>, Rob Herring <robh@kernel.org>, <kernel@quicinc.com>
Subject: Re: [PATCH v2] net: stmmac: dwmac-qcom-ethqos: Enable TBS on all
 queues but 0
Message-ID: <20240207101934.6c0ab20b@kernel.org>
In-Reply-To: <578b6a6e-83df-4113-9c1f-cdd7aa65f65e@quicinc.com>
References: <20240207001036.1333450-1-quic_abchauha@quicinc.com>
	<578b6a6e-83df-4113-9c1f-cdd7aa65f65e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 09:26:05 -0800 Jeff Johnson wrote:
> > This is similar to the patch raised by NXP <3b12ec8f618e>
> > <"net: stmmac: dwmac-imx: set TSO/TBS TX queues default settings">  
> 
> note that there is a standard way to refer to a prior patch, in your case:
> 3b12ec8f618e ("net: stmmac: dwmac-imx: set TSO/TBS TX queues default
> settings")

Yes, please fix.

> (note this format is defined in the context of the Fixes tag at
> <https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes>)

A fixes tag would be great. But we can't point at 3b12ec8f618e, right?
Can someone explain what the user-visible problem is?
TBS cannot be used? Device reinit is require to enable it?

