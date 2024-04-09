Return-Path: <linux-kernel+bounces-137524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B09589E35D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6111F239F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C2D157E9C;
	Tue,  9 Apr 2024 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PBHdKyia"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FF9156C51;
	Tue,  9 Apr 2024 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690712; cv=none; b=F7fghw91ygddSqOBu+07OecogNlNmmm7M15t5aasnmF8t4ygZqPOLcwnSOoWaLWTM1rJRDu4HW/NAWAwfZat93yUIxhrEbR1aw1tjATKu9SUwEBMK04dYJNX5slU9tnn3wMjgrRZ5T1PeuExFfT+alNPYCFVz8/QGguDM5ky8IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690712; c=relaxed/simple;
	bh=aWx7CevydRrDXasefacZWPb71JXpq5DVLlOrVLb3d/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XF1+cEeX4Zb2M5FcQNyBoJ/saxaQdlZo69bPuvZnchlnNyK19k48KTOSgZHezKl6TDWyNjb2zWfos2/872zu07oSGRNbq8nJHvq2S2PgrjQfM67pNsCFbnfR9pBsET2Ka1DyCfBPdkWU2gErZACL7s50cILgZ7DBEFwWyX46dOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PBHdKyia; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 439JOvm9060924;
	Tue, 9 Apr 2024 14:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712690697;
	bh=f/2ZZLv/YXP88a8yKxEUi5GZ92gmoDf4RDx042otFLg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PBHdKyiaGJ1OgD/UUvSZm7UTmi5/B4fAFOVe6ytVkd67jSaJCFiqkdHm2GNXHU/Ug
	 x9d83d4KAt44Myog//G7n/u4Mk4KIHXeXLh6BRpeSvhlGq3X3UfElxrxvbficjip2W
	 PuvrjAAgJYPLpVtsPXbv2PY7m7I8A8dgnVMrskLk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 439JOv7K001369
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Apr 2024 14:24:57 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 14:24:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 14:24:57 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 439JOv1K079041;
	Tue, 9 Apr 2024 14:24:57 -0500
From: Nishanth Menon <nm@ti.com>
To: Jai Luthra <j-luthra@ti.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andrejs
 Cainikovs <andrejs.cainikovs@gmail.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: Re: [PATCH v1] arm64: dts: ti: verdin-am62: dahlia: fix audio clock
Date: Tue, 9 Apr 2024 14:24:54 -0500
Message-ID: <171269065936.640145.6245831948587866462.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315102500.18492-1-andrejs.cainikovs@gmail.com>
References: <20240315102500.18492-1-andrejs.cainikovs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrejs Cainikovs,

On Fri, 15 Mar 2024 11:25:00 +0100, Andrejs Cainikovs wrote:
> In current configuration, wm8904 codec on Dahlia carrier board provides
> distorted audio output. This happens due to reference clock is fixed to
> 25MHz and no FLL is enabled. During playback following parameters are set:
> 
> 44100Hz:
> 
> [  310.276924] wm8904 1-001a: Target BCLK is 1411200Hz
> [  310.276990] wm8904 1-001a: Using 25000000Hz MCLK
> [  310.277001] wm8904 1-001a: CLK_SYS is 12500000Hz
> [  310.277018] wm8904 1-001a: Selected CLK_SYS_RATIO of 256
> [  310.277026] wm8904 1-001a: Selected SAMPLE_RATE of 44100Hz
> [  310.277034] wm8904 1-001a: Selected BCLK_DIV of 80 for 1562500Hz BCLK
> [  310.277044] wm8904 1-001a: LRCLK_RATE is 35
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: verdin-am62: dahlia: fix audio clock
      commit: a15e5320d91abe68ff1123bb72583d629c49100c

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


