Return-Path: <linux-kernel+bounces-78281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AAD861152
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B361F249B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414FE7BAEB;
	Fri, 23 Feb 2024 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwAAV5G0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694D75C90C;
	Fri, 23 Feb 2024 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690564; cv=none; b=FVE5LOxGkozSS8G1bjL1zpWdyLLMpu4teT7RGtw+U4m549lJVnCJt740e/JMyiEV+CuzldpvV2+JGYn15JMvrntuCCc6mS1CEm352HopHiTNNJiR7lo0e/Nxi0/40MCsmmgVG9q6pfmzkQ1XqwtzeaoeH6uxdD/CrCXkxaDgWys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690564; c=relaxed/simple;
	bh=JCFDC8egWyXQb7HABdNFJAfvo0AUNIyjCWnepDQI21c=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CKtNHIMj9xNxddcNQ4oHyJlR3Q4GVE5xdoaLOsfUnJGAEyc8T6ohTBNwqj5p2DnhODOyxCFz0ymCb5T12+qMDE/Y+hN93lSB4XUwkRCDjCV7KPT8DBEgn7r+vr94bwDkbH5+q7FWRHvYJbPQAzXmVuB5XhKoJVWQ2bRl74RthWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwAAV5G0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02934C433C7;
	Fri, 23 Feb 2024 12:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708690563;
	bh=JCFDC8egWyXQb7HABdNFJAfvo0AUNIyjCWnepDQI21c=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=iwAAV5G0xRLinAtkNwS/UDub21NcNA/YD1kSoIhSJS+aJCIHz/rumU3D1Lenn5wnk
	 HkGxD26tSsFekC+CXQG5DAxyM5Nzw7ypVnkoX0qMWTFo45T7vyZh1ulJdmcw6I6vSI
	 UJ6q6aPRVM14waxuS1UmjG5fRjGbU95J8syQO6PWLp28QwLU5RigoqYeGbzTnehotR
	 OZnD6ewlC3ECto1MNL2V+wyAZ3smxhQ8ivngTmijPejLtLKy0AU+B7T3E2jt7ju1IV
	 UjCjpAXG60xgL49D4fBUMAYJ90iueYRNijtk1m0BQrN7+M/KilrjgPT1EIM/oblm0X
	 /pGqEA5bFmyQw==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Linus Walleij <linus.walleij@linaro.org>, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240217093937.58234-1-krzysztof.kozlowski@linaro.org>
References: <20240217093937.58234-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] phy: constify of_phandle_args in xlate
Message-Id: <170869055762.530534.10335046810476136989.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 17:45:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Sat, 17 Feb 2024 10:39:37 +0100, Krzysztof Kozlowski wrote:
> The xlate callbacks are supposed to translate of_phandle_args to proper
> provider without modifying the of_phandle_args.  Make the argument
> pointer to const for code safety and readability.
> 
> 

Applied, thanks!

[1/1] phy: constify of_phandle_args in xlate
      commit: 00ca8a15dafa990d391abc37f2b8256ddf909b35

Best regards,
-- 
~Vinod



