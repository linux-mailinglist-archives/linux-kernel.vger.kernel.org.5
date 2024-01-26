Return-Path: <linux-kernel+bounces-40053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F3583D973
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86CC1C2431A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C462175AE;
	Fri, 26 Jan 2024 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdowly5M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478881426E;
	Fri, 26 Jan 2024 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706268986; cv=none; b=sLWCYXrKPbe50d5iiY3Y/6LzdRDF/yn46PDbSwQO58cCqBPJlAatJnAMSoOepopbrlFcgbCiOvEmUSQkUterqEgFLsjQx0IPvv4e0OMPXRGarbx3yg0snmX4dhcDRev70UaGu5O50K6NSXh3GXmLUudW2KFM0f2HjQgEfTSodn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706268986; c=relaxed/simple;
	bh=MNtqVm1/B/1/sVEpU0SsXkiKk5FooQFfoTy30vK4zrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dw/ed4fpWe5mY7EXyfSKXACnJNe1WHTic1btPxHOU/IPHeKVYJ659qXWgf2LLs2yZ8g2JdkDuTbjc3U8aWkvVRtHGrzRJm2oiWs4fy0qabDTOr5C5wzrBjwTjznk8UU/Zmnd4iIGfyOAWDiwnjkJzOzjtSxnjJoJk1NZTHs6bM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdowly5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4925C433C7;
	Fri, 26 Jan 2024 11:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706268985;
	bh=MNtqVm1/B/1/sVEpU0SsXkiKk5FooQFfoTy30vK4zrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qdowly5MS/3ADclX5TbgeYvwRnT90hQWeb11ZjD7CP8AH+G5QNw6YJjCjciT14S+L
	 2Pmv+hA7g2P73agkA7fIhUbzEVimRSPypo32xg5CUic55kP0PLwNf8p93OQWDG1M3H
	 lm3NqurNAJyZYk+abKnDS3ycfBRhP7BHtD52LT0vvOiYxVbaL7DGuli7IyYLUCU+vs
	 c00DxEbltuqfgSDbcu9a0jOFIpq9Om92a4IOJ/NVIjo8smpBjQT1SNWrz2KK877Zm5
	 oLXvqs7FQE9USrjakMbU3kDLHFbb1toIcpLIf5tDYG2SzZtJtu1q+qVI4HQjQhg0ZO
	 o/3F1HLF5+4vw==
Date: Fri, 26 Jan 2024 11:36:19 +0000
From: Simon Horman <horms@kernel.org>
To: Sneh Shah <quic_snehshah@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@quicinc.com, Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH net-next v3] net: stmmac: dwmac-qcom-ethqos: Add support
 for 2.5G SGMII
Message-ID: <20240126113619.GA401354@kernel.org>
References: <20240124092215.14678-1-quic_snehshah@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124092215.14678-1-quic_snehshah@quicinc.com>

On Wed, Jan 24, 2024 at 02:52:15PM +0530, Sneh Shah wrote:
> Serdes phy needs to operate at 2500 mode for 2.5G speed and 1000
> mode for 1G/100M/10M speed.
> Added changes to configure serdes phy and mac based on link speed.
> Changing serdes phy speed involves multiple register writes for
> serdes block. To avoid redundant write opertions only update serdes
> phy when new speed is different.
> 
> Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>

Hi,

unfortunately this patch does not seem to apply to current net-next.
Please rebase and repost.

-- 
pw-bot: changes-requested

