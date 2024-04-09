Return-Path: <linux-kernel+bounces-137556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C692189E3D9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CADD1F2460E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955F2157A5D;
	Tue,  9 Apr 2024 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S3gHBlRP"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662DA14D71C;
	Tue,  9 Apr 2024 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712691760; cv=none; b=hIWjma2zU6NkTKoyZPfVlmVi3hKoPqAINSS/cuh1djVYCJmpy+A+JfuYeIKhtRdMVc80HsCeYCK5psp9xDzZK9F3bmhEZF/1qtZVtBSQ015dkSMfnttLfZr4ZxTe6tJ9DOXisMzlUpMXUNOP2N05knGi+yuZn0cx1BfLQ6n0Ryk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712691760; c=relaxed/simple;
	bh=l5aZQMiEeI4HB4uw9THHqDGYoObgomRufCJgSLEgShs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9av2KE/ePSyYHJ8r+KJQ5yedLw9uOBoMAFKAxxaj4KnA/Iu55AnGH9V/+KTdId/RMPPmvgTSRydLs3lZbjsRQd8FF8T3OUqAvGK5MKFQ/7fvkq+NFFUVsljA3h6My0cw5/sSKsq5lBfawAYTjOOdKE6ACbZL2BPf1KmM/3u+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S3gHBlRP; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 439JgSo2016705;
	Tue, 9 Apr 2024 14:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712691748;
	bh=7JgDAbaAbpZ7jtyyywE9SqgUEKIYgtKGGiA3fpmJLGQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=S3gHBlRPrqx65gGJuBvZqLgPNFwOgram1gM2jmE9vpN9qlTv3xRiCLxXxe+E1enpH
	 PPZAi5/ENP9tt6IPmHDY+lXlrZKGxbll+qpbeWTLAdg5Ip9HwSXnREQhi05qbNxPR9
	 KNu2HZLuXQ6MvhSsgEhUb41ik6DNdSfvXgoTyCig=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 439JgSov017053
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Apr 2024 14:42:28 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 14:42:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 14:42:28 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 439JgSFl099398;
	Tue, 9 Apr 2024 14:42:28 -0500
From: Nishanth Menon <nm@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Michael Walle <mwalle@kernel.org>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-{am62p,j722s}: Disable ethernet by default
Date: Tue, 9 Apr 2024 14:42:27 -0500
Message-ID: <171269170716.644950.11975793376902182591.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403101545.3932437-1-mwalle@kernel.org>
References: <20240403101545.3932437-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Michael Walle,

On Wed, 03 Apr 2024 12:15:45 +0200, Michael Walle wrote:
> Device tree best practice is to disable any external interface in the
> dtsi and just enable them if needed in the device tree. Thus, disable
> the ethernet switch and its ports by default and just enable the ones
> used by the EVMs in their device trees.
> 
> There is no functional change.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-{am62p,j722s}: Disable ethernet by default
      commit: f3d27e84814641192570fbe7a1cfdbb741a250e8

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


