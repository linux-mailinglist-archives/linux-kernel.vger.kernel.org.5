Return-Path: <linux-kernel+bounces-142593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 244908A2D95
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81A31F217D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60A156440;
	Fri, 12 Apr 2024 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFBr7Ba1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF64555C22;
	Fri, 12 Apr 2024 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921763; cv=none; b=RBfh3oMbZkb/8saXykgGCxiZpXdL2GUTw4yYJClrG0ge2zpKafPwDcKCLED66U4jdLwmXHdM9XjpEOeFvsx4tmpKhw9r7URW0weT5WZUXfMxjzdMygaGxpr1+LleJ34zCXhiwUUVFjF1P3Qp1uyv6wwDj7mVgnErU+9SADJOGXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921763; c=relaxed/simple;
	bh=45cFDE/PDUHtIcaaHwj8IYsNzYdpntdj2aCgK/pRFXs=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tzciNaR9Wb+QqJEreGGC/ZnmC76RUV1HWpZE5UFqyg06xwdeSV6kBNr4yjacxVEF+KkJ1sx8BKSOZGswQd+V7w9lLX5hbS6Tkzbf9XLMuW+xI3uJJJvb5UU1/T0UPA7BkS6v3p3OwXDjecC4G0T3YE1RBdYasDkvahbaKvQSx0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFBr7Ba1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4EFC113CC;
	Fri, 12 Apr 2024 11:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712921762;
	bh=45cFDE/PDUHtIcaaHwj8IYsNzYdpntdj2aCgK/pRFXs=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=BFBr7Ba1JN9wm3zN/q42MzXb7lkG1Tjv67VUZoc5X7TxPXH3hGhtOPL+oDr47vi06
	 PYHtlu2K9ePQpbT5GKyjlwUfUq6z2qcJB3djc05XmWyvBdIKWsp1mKY3XkH9aFeYVP
	 EomH/3KWPfY5ZaqJx9UtaSxulfqCk7GVOszL5mE6xOFazlUaqmqNE8LuDfv0FDWUQS
	 ueFpNmul0aKJXQpxmreVXZMNuXch9wEoq3EziFkVClRdsC9oYDnGQm/AXYkn2AJYsk
	 GPrppQX0zjmwyANJ/TZoHEN8l/531YISlEmc6z40A0imi8VD5QYufedjZxund5HdDE
	 2ZOEPVi/KGlYA==
From: Vinod Koul <vkoul@kernel.org>
To: Bc-bocun Chen <bc-bocun.chen@mediatek.com>, 
 Steven Liu <steven.liu@mediatek.com>, John Crispin <john@phrozen.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Qingfang Deng <dqfext@gmail.com>, 
 SkyLake Huang <SkyLake.Huang@mediatek.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <745f8b46f676e94c1a396df8c46aefe0e8b4771c.1707530671.git.daniel@makrotopia.org>
References: <745f8b46f676e94c1a396df8c46aefe0e8b4771c.1707530671.git.daniel@makrotopia.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: mediatek,mt7988-xfi-tphy: add
 new bindings
Message-Id: <171292175438.599803.12725341666567867086.b4-ty@kernel.org>
Date: Fri, 12 Apr 2024 17:05:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Sat, 10 Feb 2024 02:10:08 +0000, Daniel Golle wrote:
> Add bindings for the MediaTek XFI Ethernet SerDes T-PHY found in the
> MediaTek MT7988 SoC which can operate at various interfaces modes:
> 
> via USXGMII PCS:
>  * USXGMII
>  * 10GBase-R
>  * 5GBase-R
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: phy: mediatek,mt7988-xfi-tphy: add new bindings
      commit: f482f76c9d0933b91f32f170fbc421a4d0ebaf56
[2/2] phy: add driver for MediaTek XFI T-PHY
      commit: ac4aa9dbc702329c447d968325b055af84ae1b59

Best regards,
-- 
~Vinod



