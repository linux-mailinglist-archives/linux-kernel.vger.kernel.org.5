Return-Path: <linux-kernel+bounces-152337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3728ABC97
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 19:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC039281349
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 17:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703A53B1AA;
	Sat, 20 Apr 2024 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7M4mx/0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E0339BC;
	Sat, 20 Apr 2024 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713635516; cv=none; b=Snvov18X6HqQ8qQ5i/Lwo1m1/veBmTb4m15hr0S1Z6/OiOZgg559nPeWl4Ec/RiZfiBohfJgffKF+5KxQ9wgdC7qDPPlJsrqx8Kd3GGiNowK4fvCcTHlFSly44RA7VgL3ioOBDn3Wwq1SyNtTSo6ogTno8XVq6lAGoYboEu/qiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713635516; c=relaxed/simple;
	bh=nCgy5S4vrfbB3JPv5gne295UUu4TDmAin7gXYzx0nrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOIyg8QaIj7RI2QhZyAznPbUXH+I8DidKSNm9GIpXDBLnrCADpQ7C1tHUOS1KTP8oOlKbiKhbCtauTNtVtwOn6lwATE534ThUsQxMNEotcjCCagQo6mVwI0OcM5lRGHg+Q+HoEzuvU/zeejCQExfcA/xBOWPl2RXoTKXSLXgS5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7M4mx/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82613C072AA;
	Sat, 20 Apr 2024 17:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713635516;
	bh=nCgy5S4vrfbB3JPv5gne295UUu4TDmAin7gXYzx0nrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V7M4mx/00cmsG5sRqdGyWEu5crzF0VZFKEjmKlsIcWvvUN0ZkSPFGZ4zzrHR3owvD
	 FnygrYnyEKcF3AfP4ZedRlABOOWJYBCbtlt9463jnbMTO/nfd7MbUShx5gjbZHPGld
	 MyWVhbUo7cUxC2qkHFkqWENzUPywFYpBy2yR3jVnHMKdh7l0S65R5wEHCkV4vNI8g3
	 PG9UE6s6ZgbtnZpu7LTMEGwZO3rMP6VPTpoSmu+ysudVzAP2QwK7qSmM+z25Wdej80
	 TiAYbOWQfU0tOciSCtmOwJBD+LMGlIb7uy/cICD4ou81NSPYvw9pLAuHBmZUABokqu
	 W3rE35K/NRtCw==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: clk-alpha-pll: Skip reconfiguring the running Lucid Evo
Date: Sat, 20 Apr 2024 12:51:53 -0500
Message-ID: <171363551101.1138274.11659255153276607537.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418-clk-qcom-lucid-evo-skip-configuring-enabled-v1-1-caede5f1c7a3@linaro.org>
References: <20240418-clk-qcom-lucid-evo-skip-configuring-enabled-v1-1-caede5f1c7a3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 18 Apr 2024 16:41:32 +0300, Abel Vesa wrote:
> The PLL0 is configured by the bootlader and is the parent of the
> mdp_clk_src. The Trion implementation of the configure function is
> already skipping this step if the PLL is enabled, so lets extend the
> same behavior to Lucid Evo variant.
> 
> 

Applied, thanks!

[1/1] clk: qcom: clk-alpha-pll: Skip reconfiguring the running Lucid Evo
      commit: 810e6d2fac01ab1e189f3002a364f19bd5d0f444

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

