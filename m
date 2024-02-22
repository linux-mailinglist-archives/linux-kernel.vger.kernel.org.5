Return-Path: <linux-kernel+bounces-76596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB97D85F9C9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6488A288F81
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8A71339A4;
	Thu, 22 Feb 2024 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p06ePR5J"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38443C480;
	Thu, 22 Feb 2024 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608509; cv=none; b=E7ABoIQX5RRwAqYEcm7zD3qanCTR+aOQw3YGMbUHxDLqqhduNwFnzc89whMcFyh140WScWWDyL2GSb7TqrtvwSZmH3h77vNSMRCE2Qyz5EHSpwmBIRPgDlAWKsLq/6DsaYRIv4NTNLYXAshVQtPZoar3XQyiWCddFNMDQ0B8Rfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608509; c=relaxed/simple;
	bh=GcuZDND4BOCDJ3Qbi+8MqLFkdkVUVN8h6KHnXZTDnBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6dCAnm2glNXfABhSxa/a7u7VbIYBrJbs6FbY2wBR3Qj8G/uJXWygEjGE4cG1v8KTwMx8SCDgrHtcR1i0CFKU5uI9m71Pp5QGrCcComybKLPhHgIGx3npco/gUHjxys4wF5ctDdm6w1/6iRwZK9H9C52M4rFAhmRNmYW25o0LVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=p06ePR5J; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MDSGmg051181;
	Thu, 22 Feb 2024 07:28:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708608496;
	bh=q46Q7hHSkGrZ7spae297ZIJS9vHwJ1ZBQZkXEcC56MM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=p06ePR5J63UEnum1dG9Zn4zPMafOVgYzY8GSmmvWYuV3laMhknzS0MmWh/6Ch5Rn5
	 pAK07pjYfBZVey0W7nT5AXIe7oIwGpb00rSgt3ZcI/HsaeykjRNRz9J33PimVd0zQr
	 dScX9CfPVMyCt/tDm6+rl1MNvtCiTUy+LyV/OtNk=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MDSGFR039736
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 07:28:16 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 07:28:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 07:28:16 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MDSCCX015467;
	Thu, 22 Feb 2024 07:28:13 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <sabiya.d@mistralsolutions.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>
Subject: Re: [PATCH V3 0/2] Add CAN and OSPI support for AM69-SK platform
Date: Thu, 22 Feb 2024 18:58:07 +0530
Message-ID: <170860805565.1966114.18241653060912010768.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220162527.663394-1-sabiya.d@ti.com>
References: <20240220162527.663394-1-sabiya.d@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi sabiya.d@mistralsolutions.com,

On Tue, 20 Feb 2024 21:55:25 +0530, sabiya.d@mistralsolutions.com wrote:
> This series adds support for the below interfaces on AM69-SK platform:
> -  CAN support on both MCU and MAIN domains
> -  OSPI NOR flash support
> 
> v3: Changelog:
> 1) Updated OSPI partition table to increase the tiboot3 partition to 1MB.
> 2) Rebase the sources to accommodate the latest merge.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am69-sk: Enable CAN interfaces for AM69 SK board
      commit: daa2eb7f30eeb7127b6050e18f491326d278b836
[2/2] arm64: dts: ti: k3-am69-sk: Add support for OSPI flash
      commit: fabd934c6df2fb0c351144e424727fead261f333

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


