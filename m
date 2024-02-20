Return-Path: <linux-kernel+bounces-72305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0042F85B1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16EDE1C21084
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBA053E3B;
	Tue, 20 Feb 2024 04:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GGD68i5t"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163DC5577E;
	Tue, 20 Feb 2024 04:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708401828; cv=none; b=hRpMOLDMOIfM4QEonY9OKnirHPzhdObhiQzT/gx9IS8KCKeQgUWnIT733+doAmYDb6NHCPUqO2d3zc4ndHV1su4vaKfdxmjo+L+nXU6MFLoeqD+z3Y/+p+dxJ+IHZSSu/BO1o82+uegePazUr2MYgrXIYbC7+ilpwff0xiKBWvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708401828; c=relaxed/simple;
	bh=IVIzkcVbOkPWz7ortT2t4T3hWJ3PaAF5jKVTkV8Afwk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/2es3ym2XeXCUSm/d6esxdzLPWb4u7u9u3zf6NQmTKISvB5c0DCIo9vyQCjPr6yG8cHEouA3KpRy6vz0p4x+2JLFJv2xx7YhPV8JL8FBmefRPKsnqDs32r3RvcKvxxi/15iZJWt4Q3qqx+NYEjsTDxm72sAWrW8eP3qHVOv4ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GGD68i5t; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41K43N31076875;
	Mon, 19 Feb 2024 22:03:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708401803;
	bh=crnutHHUYH/0PHILJfzZc4/J5v3/2KFIL0jgBpVroak=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GGD68i5tfpwUx0FRd18RieRmJMnE0s7TfBCpR8J3pcOwh7PA3gHKAhQgZlTaAh8vw
	 EGI3wUPgRr10jagulji1ylowICYxLlOwyleiyK0M5a7QqG0BJn98A/9gFtdQIA1RNm
	 /RALaXrdoxHXx8WNDqTMRjGeNeWomZZV5VWqTYXM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41K43NA9035427
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Feb 2024 22:03:23 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Feb 2024 22:03:23 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Feb 2024 22:03:23 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41K43JfC068689;
	Mon, 19 Feb 2024 22:03:20 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Judith Mendez <jm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wadim Egorov
	<w.egorov@phytec.de>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v3 0/9] Fix MMC properties on Sitara K3 devices
Date: Tue, 20 Feb 2024 09:33:17 +0530
Message-ID: <170834878955.3471454.11267750873554490606.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213235701.2438513-1-jm@ti.com>
References: <20240213235701.2438513-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Judith Mendez,

On Tue, 13 Feb 2024 17:56:52 -0600, Judith Mendez wrote:
> This patch series aims to fix and update MMC nodes for TI
> Sitara K3 devices with the following changes.
> 
> The series introduces sdhci0 and sdhci2 nodes and enables
> eMMC for AM62ax platform.
> 
> Also introduce fixes for MMC ITAP/OTAP values for AM64x
> platform according to device datasheet [0], and add ITAP/
> OTAP values for AM62p to enable the highest timing possible
> for MMC0 and MMC1, according to device datasheet [1].
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/9] arm64: dts: ti: k3-am62a-main: Add sdhci0 instance
      commit: d3ae4e8d8b6ac0db82264c5576daa260cac3d536
[2/9] arm64: dts: ti: k3-am62a-main: Add sdhci2 instance
      commit: feb5d68cec77b6783f4febb8c91c1b1caa8b4924
[3/9] arm64: dts: ti: k3-am62a7-sk: Enable eMMC support
      commit: e041ec6e86e7dbc49f5245ace6f3b965bb7c26f7
[4/9] arm64: dts: ti: k3-am64-main: Fix ITAP/OTAP values for MMC
      commit: 379c7752bbd0e81654544a896dd19c19ebb6faba
[5/9] arm64: dts: ti: k3-am62p: Add ITAP/OTAP values for MMC
      commit: 37f28165518f7df2ed085e4481dade9c262b593b
[6/9] arm64: dts: ti: k3-am6*: Remove DLL properties for soft PHYs
      commit: eea929f0e0e3f83d2c027b1e60630deb50df4494
[7/9] arm64: dts: ti: k3-am6*: Fix ti,clkbuf-sel property in MMC nodes
      commit: 2812d23ade3d614b451bff5d63d29a31b92d8859
[8/9] arm64: dts: ti: k3-am6*: Fix bus-width property in MMC nodes
      commit: 0ae3113a46a64266f19fdc9753d5e3a6748fc594
[9/9] arm64: dts: ti: k3-am6*: Add bootph-all property in MMC node
      commit: 5f0e6ce354f61092182b79d177585bd7310f12a2

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


