Return-Path: <linux-kernel+bounces-76592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB5685F9B5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E425B273A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD781133439;
	Thu, 22 Feb 2024 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R6AE6aX2"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612F413172C;
	Thu, 22 Feb 2024 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608378; cv=none; b=eq4nmlG5bja6zLLWdPxQyNJ/pITUAHcK7OTt7b3dYNvIw/gMEIaHdIxClOIjofwIM+hjR8E9aV47S53qNtHS0QXR+g/UQMqAOgAaZpMlua9XOSZWkDkDVOxAX7A20P+noKBSbU5zX3JdXSAFcBCNnvymb8u7dSG4DTEJidYD5Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608378; c=relaxed/simple;
	bh=I4irWzrbdiecduFdHLP1KMnn3sD5tUCl+NF7IaHYyNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCDfHxHCydmrT24/aeIGHlV3aIfrnfUXHT6v4Y/5bAk4Qbgz5pjmRU2JCjbPBL13nFiJmeH7w+CaPDVMSMOhcTZcJmnGP1AexHb52NsPj5B8D9O7xL8XUePI0BG6gh+3tQXxFnWjeZxXBP+eNUBeKCjnQa0C+eV4mlCbPeUcxTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R6AE6aX2; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MDPnE8005138;
	Thu, 22 Feb 2024 07:25:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708608349;
	bh=aMbV5adGSWaSv1TMJZb7IGsODIV0BZo86n43P68dotQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=R6AE6aX2PKZCmsmuSvWgSBQ/RSttSCzhRnHMr5aosFwhfCCcWNiLUuk1K76N10Ymr
	 2eFtWa4wIVVmSxRM8Y+Cy6zIqqu3Aqd46kv/6Kb3awTiQnta97BTftuyco2Hhj33I/
	 TvMTX4oWJZ12ATFjwdJPcR/1MppAgRsgLbPl8S8A=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MDPnf9123837
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 07:25:49 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 07:25:49 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 07:25:49 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MDPgml103774;
	Thu, 22 Feb 2024 07:25:43 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Geert Uytterhoeven
	<geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Darren Etheridge <detheridge@ti.com>,
        Brandon
 Brnich <b-brnich@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v5 0/4] Add Support for Wave5 on TI Devices
Date: Thu, 22 Feb 2024 18:55:25 +0530
Message-ID: <170860824003.1969506.11520093746235278886.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220191413.3355007-1-b-brnich@ti.com>
References: <20240220191413.3355007-1-b-brnich@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Brandon Brnich,

On Tue, 20 Feb 2024 13:14:09 -0600, Brandon Brnich wrote:
> This series is responsible for adding support for Wave5 driver[0]
> across numerous TI K3 platforms.
> 
> [0]: https://lore.kernel.org/all/ae6d2ad3-0b2a-462a-a9eb-9ce01e7a7f5e@xs4all.nl/
> 
> Changes since v4:
> =================
> * Remove clock-names from device tree nodes per Vignesh's request
>   - "vcodec" clock-name is defined as macro in driver, but unused
>   - no purpose to have it in dt node
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-j784s4: Add Wave5 Video Encoder/Decoder Node
      commit: 7805623df1ff50e69fa66e91f7305144e9ef5c31
[2/4] arm64: dts: ti: k3-j721s2-main: Add Wave5 Video Encoder/Decoder Node
      commit: 8caaf735b9114f77895608acde21a5163b1bf02e
[3/4] arm64: dts: ti: k3-am62p: Add Wave5 Video Encoder/Decoder Node
      commit: ab480b8036fde8c1ea628bb1027919bf399468e9

I have applied the following to branch ti-k3-config-next on [1].
Thank you!

[4/4] arm64: defconfig: Enable Wave5 Video Encoder/Decoder
      commit: 02b645583e26f38261711f2a8b36c5db06862527

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


