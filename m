Return-Path: <linux-kernel+bounces-54321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E25584ADA2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598BD285E90
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8253677F2E;
	Tue,  6 Feb 2024 04:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LZOegb8m"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E677319A;
	Tue,  6 Feb 2024 04:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194510; cv=none; b=MNC2iXKNXFwLGOQ6qvsoSmqqHwvcXCFYoP4oHCdQcTSIoBo//Hh8vSFGR1eNGShElsq30muctAvoyoO98J5O8pFLwjqiWZbL/K9u1IaXDklVzcgFNgyCKEZjkJhsnb9zbXZZA63EdY31GE/HiUzlf3d/ioaygBcbGXfg4cGy8P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194510; c=relaxed/simple;
	bh=H86YPC9Yt7D4hlMVdYpOsRZKRfQvO8saUTAZIVPq0C0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LB0VWDfYPygTgQOVhicAREWfRzZV51NZPrD66z7ptFQ0ftaJXZMUNJkI6SA9XSZBLQWwDmC4/uHnhyK4EbOnvd5ZdYta2NxTeKcRiKwUAhPNCnjOfDlbiYiGSYQmJOWnXO0hobARk7s5dikCOh7DFCUixZKMIMD95iw12A83d04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LZOegb8m; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4164fdcN003352;
	Mon, 5 Feb 2024 22:41:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707194499;
	bh=I6KnNRVPruimnqniN3MXKgnXwy8Y5l+gmXwMdLMDokE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LZOegb8mL23+X0kdnvZh3L9ZujVxceGb+tabT6rjVTWbcbx3Nu+dZmxNu8oGdlSNj
	 N7AroIDAcEQfjXwmTjjBqPTqGt2jgF6ipFZtP8Ro87CTyzCmTI+sSajuLQGD/WlGv1
	 bvmrCSdB8J6b6XTzQ4a0irEK+d0EHJqywSyfJ0mo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4164fd6m009625
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 22:41:39 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 22:41:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 22:41:38 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4164fZhM115442;
	Mon, 5 Feb 2024 22:41:36 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] arm64: dts: ti: k3-j7200: Enable PCIe nodes at the board level
Date: Tue, 6 Feb 2024 10:11:25 +0530
Message-ID: <170719349982.2245010.16848121374381229501.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124183659.149119-1-afd@ti.com>
References: <20240124183659.149119-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew Davis,

On Wed, 24 Jan 2024 12:36:56 -0600, Andrew Davis wrote:
> PCIe node defined in the top-level J7200 SoC dtsi file is incomplete
> and will not be functional unless it is extended with a SerDes PHY.
> 
> As the PHY and mode is only known at the board integration level, this
> node should only be enabled when provided with this information.
> 
> Disable the PCIe node in the dtsi files and only enable when it is
> actually pinned out on a given board.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-j7200: Enable PCIe nodes at the board level
      commit: 1b63a1b480c27764d30a0924a4982d31e15df6fd
[2/4] arm64: dts: ti: k3-j7200: Remove PCIe endpoint node
      commit: 0b16abe711bd5136f2319c4f548fb20588540266
[3/4] arm64: dts: ti: k3-am65: Remove PCIe endpoint nodes
      commit: e074d9d9a52eec11cd8b3f98e2576b0c762686f1
[4/4] arm64: dts: ti: k3-am64: Remove PCIe endpoint node
      commit: 6cce60550763564360beadf57ecf2e4d45b585e1

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


