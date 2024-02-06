Return-Path: <linux-kernel+bounces-54514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01E784B027
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7AE1F266E3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0942912E1E1;
	Tue,  6 Feb 2024 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fQqi8/3j"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD34712C7F1;
	Tue,  6 Feb 2024 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208843; cv=none; b=M8x6nOhScYGIUfrDlKHaLr1pFbykCxiVPUMm/3/9kY6oi2BE7Ya9KVPfsvaDCj4cF59YUUAo22ag0AVT4kHfBCuI3+vwFcEG9E3B3yoETr3dBsR9psbxifgmai5S3Y873ZR35sdXKIPbI5t2p5MbMLNcPxG1+m9q91JQtUZM0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208843; c=relaxed/simple;
	bh=68Qy2+ELYXOwcO4gCfRrTOeYk/xCdxNDcJEjv3bj1JE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnRdu+lEfXEkyjXgarCw9eB7exvZV02eXNwHOl73er8kFr/fpnhHxfYwJJao+j+h8A2pRThrpcDCQE/9K5H6INDQmFnuEKpiPSssIr6yIQS93YivoFsgNs4BbfRNhr77ylQsz+F14JCGNF1iZt7pjDz8qXCAQhXz2zRq1wuMaV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fQqi8/3j; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4168eawe082428;
	Tue, 6 Feb 2024 02:40:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707208836;
	bh=CWefgATNB8WYvR81/spRcD4WHJWquBX6ZsOXZuOUX/U=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fQqi8/3jhehWgKhhbho5eMoa3urhPeNwTbYMiG6p7VHxl7+BaAjBwLa2GiKiDrvCI
	 AKdrb9bbeDH877z42dwhouUArRW/2cOU6aEw4+g3jspYhMNdSgaXK6au3rfaZJbByG
	 9mrIO0GLtB6eslteDsA3O989+0J3UDYbI90q927M=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4168ea4k120851
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 02:40:36 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 02:40:36 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 02:40:36 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4168eGQF060052;
	Tue, 6 Feb 2024 02:40:33 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhavya
 Kapoor <b-kapoor@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/3] arm64: dts: ti: k3-j7200: Add support for multiple CAN nodes in J7200
Date: Tue, 6 Feb 2024 14:10:03 +0530
Message-ID: <170719349983.2245010.1711894811388300123.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130102044.120483-1-b-kapoor@ti.com>
References: <20240130102044.120483-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Bhavya Kapoor,

On Tue, 30 Jan 2024 15:50:41 +0530, Bhavya Kapoor wrote:
> Add CAN Nodes for 18 CAN instances present in main domain and 2 CAN
> instances present in the mcu domain. CAN instance 0 in main domain is
> enabled on transceiver 0 in J7200 SoM. CAN instance 0 and 1 in mcu
> domain and CAN instance 3 in main domain is enabled on transceivers
> 1, 2 and 3 respectively on common processor board.
> 
> Rebased to next-20240130
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-j7200: Add support for CAN nodes
      commit: 03b94719ec31ba0e6580f512cba9100bb560e17b
[2/3] arm64: dts: ti: k3-j7200-som-p0: Add support for CAN instance 0 in main domain
      commit: da23e8d1124b93e468a24247021ace34902a9895
[3/3] arm64: dts: ti: k3-j7200: Add support for multiple CAN instances
      commit: 6b80695f93b2253dbf669323154eb06b162f55ef

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


