Return-Path: <linux-kernel+bounces-54516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE8D84B02C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9E81C245E5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E545912B176;
	Tue,  6 Feb 2024 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MeNQCdQJ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C321E12E1F6;
	Tue,  6 Feb 2024 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208876; cv=none; b=CytIU5zSBLzr/XvMJgbfkmRcx5rtduL+e3Qe/gvDVIGO/e4DM46opAl3AtG2qReeLkS8mrZ4696IP11hVR2zXNQKpHmXS1JUMJTPqp3c7QXAYaepYvpCAwONiU88T5r0iMOKchnZIIlJDWftLWR344iPxeaNNzdJUcN6d5SHyFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208876; c=relaxed/simple;
	bh=OnDL6eo50I1XpxWq1PiPa1uNicjOpXYt05whqSzZZk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JF+zagO1uVUEX5GWqNH6eOefyWHPTHgy2N/pubtNjgJmiYBHcIGGIiODrlD4FpXZlLpvS6HEYAB3FhSGSQnsRZLY8Ui1fFiXFaNACoLswSL58pmESfDaNz/k6r02z2d+s/4ny86XMF7pcbRuPP5YVOkIzuK/FO/4adFJT+ovZio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MeNQCdQJ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4168f6UH082890;
	Tue, 6 Feb 2024 02:41:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707208866;
	bh=VIP94DGKn4409WYNCD5giSdLKUK4fe7FjMJPkMWg5kE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MeNQCdQJ2JKA/znh4V94s1LxvPHf1DLMVbkPZr0ecHjjj58oIYbhvetuNe6RkAMOo
	 TzULiDfddxDEDm1RlfEv3qQNHdAEMF9RoFsKK1gsyeXWZ59FMbky3X1As8dd7f12lH
	 7/EBR93n7Ep2oXixX4NN3Ao+GxTnaad75Ukf7aQU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4168f66S102942
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 02:41:06 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 02:41:06 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 02:41:06 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4168eGQH060052;
	Tue, 6 Feb 2024 02:41:03 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        Vaishnav Achath
	<vaishnav.a@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62p-mcu/wakeup: Disable MCU and wakeup R5FSS nodes
Date: Tue, 6 Feb 2024 14:10:05 +0530
Message-ID: <170719349986.2245010.7290601708313622270.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240121134017.374992-1-vaishnav.a@ti.com>
References: <20240121134017.374992-1-vaishnav.a@ti.com>
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

On Sun, 21 Jan 2024 19:10:17 +0530, Vaishnav Achath wrote:
> K3 Remoteproc R5 driver requires reserved memory carveouts and
> mailbox configuration to instantiate the cores successfully.
> Since this is a board level dependency, keep the R5 subsytem
> disabled at SoC dtsi, otherwise it results in probe errors like
> below during AM62P SK boot:
> 
> r5fss@79000000: reserved memory init failed, ret = -22
> r5fss@79000000: k3_r5_cluster_rproc_init failed, ret = -22
> r5fss@78000000: reserved memory init failed, ret = -22
> r5fss@78000000: k3_r5_cluster_rproc_init failed, ret = -22
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62p-mcu/wakeup: Disable MCU and wakeup R5FSS nodes
      commit: dfc90e5f1a0fe0f8124521bc1911e38aa6cd9118

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


