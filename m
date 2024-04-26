Return-Path: <linux-kernel+bounces-160750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288C68B424F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EAC7B21E50
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB8B3B78B;
	Fri, 26 Apr 2024 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GCO6lhh3"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C2239FC6;
	Fri, 26 Apr 2024 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171380; cv=none; b=Hi+TzgVeta1Z49KEeH6Z27jDCgMOt56KzuF81Xs897KvgbmXA9XyBiZSvA45wrPcr0TA8Bu0xFdb0MmqrKP0h0pppXI8smS+J44IHwJCAXnGiyZ301j0L7EmUIyavjrCdI+f03MaAXUge8RK1XImlcfqpTRGnU57OIfkFUBB6SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171380; c=relaxed/simple;
	bh=D65yH3Jcaj4F/bvyXdknw8AaninxbTFKjalBD4Vw9QM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWQOliQ552lU3izLdHQqc2d24Cx7qHBX/l48Jb7RZ0pe89Xx+hoOe+ajpVcow+WCCYlXCqX18hgashKzQjd4un8jfyQ+K7xi2xOS9DGSsOM5E2IxGdLtF9qPBXW1Xd5Rlso0c531WsEbkc96TOsV4AV5LtrCDFEjTbCtIoELxkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GCO6lhh3; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QMgr7t018587;
	Fri, 26 Apr 2024 17:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714171373;
	bh=pcXUP9mhP+TQia9HSe9eduFdMAC4Ifio/cP1Lce13Ko=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GCO6lhh3mp6Gi1tZo+Y2ksjMEYRXGUcQ+2EWQzesKwFNZumzMpEsdaakqaysJfPiH
	 MvCXd8qPQRfkh9sqQB3idkYO9X/FwzPHiosEoZycPAd5hnFbGR9ZaQuJV7lhlEATzS
	 yqN643umKBdpLBJYt45xKjRiODhP/piUVqM09hUQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QMgrqW006900
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Apr 2024 17:42:53 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 17:42:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 17:42:52 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QMgqsB084202;
	Fri, 26 Apr 2024 17:42:52 -0500
From: Nishanth Menon <nm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Judith Mendez <jm@ti.com>
CC: Nishanth Menon <nm@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bhavya Kapoor <b-kapoor@ti.com>,
        Dasnavis
 Sabiya <sabiya.d@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 0/5] MMC fixes for TI K3 platforms
Date: Fri, 26 Apr 2024 17:42:50 -0500
Message-ID: <171417136027.3484916.3535632859423780295.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423151732.3541894-1-jm@ti.com>
References: <20240423151732.3541894-1-jm@ti.com>
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

On Tue, 23 Apr 2024 10:17:27 -0500, Judith Mendez wrote:
> This patch series includes MMC updates for various TI K3 platforms.
> 
> It includes support for enabling UHS/SDR104 bus modes.
> 
> For AM62ax, add missing UHS support.
> 
> For AM65x, fix ITAP delay and OTAP delay and clkbuf-sel properties
> in SDHCI nodes.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/5] arm64: dts: ti: k3-am65-main: Fix sdhci node properties
      commit: 9853d5fc6b33d77de20308a9facf1ac0b4ac3347
[2/5] arm64: dts: ti: k3-am65-main: Remove unused properties in sdhci nodes
      commit: 0c6ad2fed244c393e8c19edafde324a01b7d8c1b
[3/5] arm64: dts: ti: k3-am62a: Enable UHS mode support for SD cards
      commit: 8fea8069313c3a77e075a353edbc5b212e07303c
[4/5] arm64: dts: ti: k3-j721s2-main: Enable support for SDR104 speed mode
      commit: 7e484938110c00e9d27413e04200ffa94ec16b55
[5/5] arm64: dts: ti: k3-j784s4-main: Enable support for UHS mode
      commit: 2396b640f82da528bc3fcbcfdbd240091ff405e1

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
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


