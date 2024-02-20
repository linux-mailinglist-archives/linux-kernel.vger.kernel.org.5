Return-Path: <linux-kernel+bounces-72298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEE085B1C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5C01C211C1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E3553819;
	Tue, 20 Feb 2024 03:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="laYESBj/"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FBE482FC;
	Tue, 20 Feb 2024 03:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708401413; cv=none; b=NOmf66MYhVctPgSmm4wkP18m3qRqyhTw7UJ29tGiVtVShUggbrJnfdq3cvnGHhp/c9uS6NBVXZwQmpEXwP+tNzLttHbWGZNnoH2ueLehnghGP804+YUkGzpJw+6LA0mQ0ctjg++J+P+jantbxStSnjmDMUSEWIstN6IQDJhqjhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708401413; c=relaxed/simple;
	bh=49PLpUGuAZAo22LRv2VQzUfZ1WkfgYkzx5PbbYDe5j0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGCFqhBjK3e6bwX+D0zeiWIgl0gmbZXy/kyzhSKogCp9H7peg5sdeyTvLmIQ58wVa9VCPdL5I625XSs8GYWOKgHhVLlhtc81ypEF0iUSZ539IXRLJih7bCdPxf12JWzuLWALBjX9jGcnBtBMjE1/DZOj3fciDFpdFL5N2iPo/0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=laYESBj/; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41K3ufm5093536;
	Mon, 19 Feb 2024 21:56:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708401401;
	bh=jbEpH2vv9FbzcJ9aRmBleeeq8tWyhtmY299lY3H5P54=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=laYESBj/uhrAiQAOjuqIo/REgC/CjTRu13g/jvTleAjdhk0q9nC/hIJ16yWBMc7N5
	 +TKIJmGQwrSKeHAbXkuLCqYrM7ZCtcArTDefrpvHevMrVzfRg+N2k7Cwy7ohBsBAse
	 R8+MGg2QtDs3dfICslU+h3zr8AxpjodpmSIeoyoI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41K3uf4G027861
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Feb 2024 21:56:41 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Feb 2024 21:56:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Feb 2024 21:56:41 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41K3uavg057365;
	Mon, 19 Feb 2024 21:56:37 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <conor+dt@kernel.org>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        Vaishnav Achath
	<vaishnav.a@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <j-luthra@ti.com>,
        <devicetree@vger.kernel.org>, <j-choudhary@ti.com>,
        <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <afd@ti.com>
Subject: Re: [PATCH v4 0/9] Add CSI2RX capture support on TI J7 platforms
Date: Tue, 20 Feb 2024 09:26:35 +0530
Message-ID: <170834878954.3471454.4526592845067575248.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215085518.552692-1-vaishnav.a@ti.com>
References: <20240215085518.552692-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Vaishnav Achath,

On Thu, 15 Feb 2024 14:25:09 +0530, Vaishnav Achath wrote:
> This series adds support for CSI2RX capture support on J7 platforms,
> series was tested for CSI2RX capture on OV5640 sensor and RPI camera
> v2 IMX219 sensor on J721e Common Processor Board, J721E Starter kit,
> J721S2 Common Processor Board, AM68 Starter Kit, J784s4 EVM and AM69
> Starter kit.
> 
> V1: https://lore.kernel.org/all/20240129132742.1189783-1-vaishnav.a@ti.com/
> V2: https://lore.kernel.org/all/20240208084254.295289-1-vaishnav.a@ti.com/
> V3: https://lore.kernel.org/all/20240208123233.391115-1-vaishnav.a@ti.com/
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/9] arm64: dts: ti: k3-j721s2-common-proc-board: Enable camera peripherals
      commit: f00c6ead159fb028ac989916ed2999bac2f7d43b
[2/9] arm64: dts: ti: k3-j784s4-evm: Enable camera peripherals
      commit: fa646b7096708db6d87b43bedefaddc7c605a9bf
[3/9] arm64: dts: ti: k3-am68-sk-base-board: Enable camera peripherals
      commit: 5dcc1aaf0b7aa861bf9cfd48a9db46a4a3b2d47a
[4/9] arm64: dts: ti: k3-am69-sk: Enable camera peripherals
      commit: 12d82b15b94c2b44bee7c8c90682850d3ad9b120
[5/9] arm64: dts: ti: k3-j721e-sk: Model CSI2RX connector mux
      commit: f87c88947396674586a42a163b72efa3999e3dee
[6/9] arm64: dts: ti: k3-j721e-main: Add CSI2RX capture nodes
      commit: 491821cebcf5cfa86dbc6bbf03f45322dea31b11
[7/9] arm64: dts: ti: k3-j721s2-main: Add CSI2RX capture nodes
      commit: 6aac91999ede6e855694cdb673a901bb7305c214
[8/9] arm64: dts: ti: k3-j784s4-main: Add CSI2RX capture nodes
      commit: 2ba8f21a74b7e75fd1af9ad9ccdbacaf43fe10e4
[9/9] arm64: dts: ti: k3-j721e-sk: Add overlay for IMX219
      commit: f767eb9180967c2961d47955dc1a3d099819f244

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


