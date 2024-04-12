Return-Path: <linux-kernel+bounces-142591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448928A2D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49A61F240BB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B1856B76;
	Fri, 12 Apr 2024 11:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrlXkGq9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A766B5676A;
	Fri, 12 Apr 2024 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921731; cv=none; b=DehougGTPdZ4ZTe95IVEbgrFslOYBUcMq27Ah76r5GgRLErznQ2jRsPA6VppY6/s6uTKkdILpmuB8/aO7il0IQ4fVGuMXr0ERB3IRP5R/ecfWyEmrfqI9VYt/zJjwiTYmZBqHXbk8h59nCeAz+7gvB2ZiGV4Nk4H6WsswA+fuqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921731; c=relaxed/simple;
	bh=y5TAKF6PSxBn9qjkmf3G8Xrddl8HmQ3V5U+f22zFewU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Sm5pdvQh5+sX55n0tflC/9O0gwPCozXwQLiDWKkIiHIi3OPNAYwnAKwMi+9ozhiNcyksTSjmm0reTb/5In6x6SpmyOYh8B3tSQv/p7NjZZSJENk+8nRTmLekaZM/+m8DDU+IQG9QWifAinqlmBMT7jVdslZ4txBlH6h8pduZUsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrlXkGq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E685C2BD10;
	Fri, 12 Apr 2024 11:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712921730;
	bh=y5TAKF6PSxBn9qjkmf3G8Xrddl8HmQ3V5U+f22zFewU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hrlXkGq9nh2VLQbtmqg2koLxXrvG0CY+ZLe7qWB/5ntrzSuwz6zyj+xFNSUC/xd60
	 nLpehDcO0HdjSAjE9GbHDuDemh6T7cT+2RwgtEASJSrItj7+9Z4I04Hq9UodNu+fjo
	 igSk0mOp0Vu8PUNOE4FEfTDA7G1z2i8FrVZqSunCBpaWpuniOwIUSOzGeLaOZnh2JO
	 yNbI4rv6FzbXB3it9w5Vmyl4UWmOebTVX2u+Vvbg7C78bj4HNRCY/x+TkaHgnb/On/
	 MAD/bqhgWMyPrbbQHnbfe340KOiWOJdtxGDTvRfKE8pTArf7ku24OOnqPfn69INMJ9
	 PQ9ga8g1tu0rg==
From: Vinod Koul <vkoul@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20240408093023.506-1-johan+linaro@kernel.org>
References: <20240408093023.506-1-johan+linaro@kernel.org>
Subject: Re: [PATCH] phy: qcom: qmp-combo: fix VCO div offset on v5_5nm and
 v6
Message-Id: <171292172572.599648.13799054915753507931.b4-ty@kernel.org>
Date: Fri, 12 Apr 2024 17:05:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 08 Apr 2024 11:30:23 +0200, Johan Hovold wrote:
> Commit 5abed58a8bde ("phy: qcom: qmp-combo: Fix VCO div offset on v3")
> fixed a regression introduced in 6.5 by making sure that the correct
> offset is used for the DP_PHY_VCO_DIV register on v3 hardware.
> 
> Unfortunately, that fix instead broke DisplayPort on v5_5nm and v6
> hardware as it failed to add the corresponding offsets also to those
> register tables.
> 
> [...]

Applied, thanks!

[1/1] phy: qcom: qmp-combo: fix VCO div offset on v5_5nm and v6
      commit: 025a6f7448f7bb5f4fceb62498ee33d89ae266bb

Best regards,
-- 
~Vinod



