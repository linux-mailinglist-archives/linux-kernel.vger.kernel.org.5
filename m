Return-Path: <linux-kernel+bounces-76589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD90F85F9A5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBF81C23DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E3F14691A;
	Thu, 22 Feb 2024 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NhvXyovi"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07ED135405;
	Thu, 22 Feb 2024 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608191; cv=none; b=opAeAQzO+AIxv2bIGy6nyHMN21+9IlJW1ty7BpyAKCKxJyyxwYtCHy9IFHwJQhWu1BvDFxDWXSj+9wxJzj6BwnkOC8nPOzKsGBHzFiJOqpW0s2kz1rEJc9btLccwyZ1LPDk/DJMoX3D6J04ZvIWmFDk0Z7guKtxqSSvbwNcJfDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608191; c=relaxed/simple;
	bh=eSbXUqFedQp3uxU8odFpdsy0/WXm8uAd03gbB8t0lCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukrVQzJgA5LG2WzuiSpD9UE8jobql5xom6AuRL4db/Bo8W7hb/PbtIrMouPrnYX6KLmfVUA7jwlJTTyMuFTFUgz8+J9kaydi75iFCA+xB46ppZvXja1KqS46vaUhjQ+JYuvJ+/jDcOl4gkLhYyfl4R9j6U1PPcB4DHcsV/XiGXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NhvXyovi; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MDN4cb046825;
	Thu, 22 Feb 2024 07:23:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708608184;
	bh=CKdem2P6UyMctXabHybF1t5eSYfeMxcyIMqd3gX3ji0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NhvXyovirvowl8rr71OGYD8Rc9rfCW4OwqVJXZe5uVv1iqYmrb0XoOn4cOlIbgIA9
	 CGoUHtL1kg/mtMJu/06QIHyiSy6UQzv/ZRcne3rTu/jzM7YZCTYFvXjCNOBIr084Tj
	 EpRqAupWAFL7gugoP634Rj5tEZMI45+Q9fptDnqg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MDN4KQ022141
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 07:23:04 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 07:23:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 07:23:03 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MDMwBt009356;
	Thu, 22 Feb 2024 07:22:59 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Bryan Brattlof <bb@ti.com>, Dhruva Gole
	<d-gole@ti.com>,
        Jai Luthra <j-luthra@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>,
        Devarsh
 Thakkar <devarsht@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>
Subject: Re: [PATCH v2 0/4] arm64: dts: ti: Enable camera for SK-AM62P
Date: Thu, 22 Feb 2024 18:52:54 +0530
Message-ID: <170860805564.1966114.7021966559574978180.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220-am62p_csi-v2-0-3e71d9945571@ti.com>
References: <20240220-am62p_csi-v2-0-3e71d9945571@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Jai Luthra,

On Tue, 20 Feb 2024 11:48:01 +0530, Jai Luthra wrote:
> This series enables support for camera sensors using CSI-RX ports on
> AM62P family of SoCs.
> 
> Particularly, it enables OV5640 and IMX219 sensors via the 22-pin FFC
> CSI-RX connector on SK-AM62P [1] using the existing common overlays for
> SK-AM62* family of boards.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-am62p: Fix memory ranges for DMSS
      commit: 90a67583171f213711de662fab9f8d24a2d291a9
[2/4] arm64: dts: ti: k3-am62p: Add DMASS1 for CSI
      commit: 091e2e05228fa3fd424b1d775b04fb4734d5275b
[3/4] arm64: dts: ti: k3-am62p: Add nodes for CSI-RX
      commit: a8787f4fd29a43c5351daf3059a6156ff089a441
[4/4] arm64: dts: ti: Enable overlays for SK-AM62P
      commit: 598139b8c7c56cc6fb30ef8b4cf34b53a7fa5d0f

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


