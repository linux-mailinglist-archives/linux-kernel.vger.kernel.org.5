Return-Path: <linux-kernel+bounces-160739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A108B4234
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185EE1C21772
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AA93987B;
	Fri, 26 Apr 2024 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kKrq1DSl"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCAB3A1B7;
	Fri, 26 Apr 2024 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171100; cv=none; b=VAc2Inthr80WXBphuQAOgr1GRiuVvBDfjXUjIDdTJOx88NcRFaiat+awNW70Y6AyF9NS5Q0lTeSWn2UbUKArY5YLikMqHqw+QzCZIeJ1hwpCiuUQXNbroKgQ0dlhYoeqCfAgBcGrAfFLupeOR4+SYyw02BtjAZ0xyJJg1IkYTXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171100; c=relaxed/simple;
	bh=zx6NYwocKI9DMvysMEzQha5v1FOAgG7HSF4pUUbk/A8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKsfq3170WqHnRfL3gRLl6CGtcYywrlfVTOJUiqrNyax/kqPg26hN2INhWDXDrGe20H76KUi8oxbsht5b1RlGO0RcNYzJxdIvHANm+gGSxhi5JOACabruTZu/ue4al2b/dcJ+JkbYPhkx70wy8SHyxWLXdj7+oaT+pGyF6SiGK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kKrq1DSl; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QMbsPI009381;
	Fri, 26 Apr 2024 17:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714171074;
	bh=/ZdtuJMeDJxRMheIBrs2Gf8TauftnU5dxe3FLp8bHMM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=kKrq1DSlKSIsiNsS9IfiNaDdJPc/Ua2V5ProcAipO2bnSfKvr/2ba+KMEju7B9pL0
	 Lx6BPqAFZpfKWkptq2aGf8GxIiZn1hjC5DYKRKklz7A6dyWKtVVJTZ+sSKirrvwl4N
	 uMtXVVt2jKIzYhYaRi7wdeAjSb+IGX0Oyu6r4TKY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QMbsKq058911
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Apr 2024 17:37:54 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 17:37:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 17:37:53 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QMbrvS077633;
	Fri, 26 Apr 2024 17:37:53 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Chintan
 Vankar <c-vankar@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH v6 0/5] Add CPSW2G and CPSW9G nodes for J784S4
Date: Fri, 26 Apr 2024 17:37:52 -0500
Message-ID: <171417105222.3482343.16635280405078352816.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329053130.2822129-1-c-vankar@ti.com>
References: <20240329053130.2822129-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Chintan Vankar,

On Fri, 29 Mar 2024 11:01:25 +0530, Chintan Vankar wrote:
> This series adds device-tree nodes for CPSW2G and CPSW9G instance
> of the CPSW Ethernet Switch on TI's J784S4 SoC. Additionally,
> two device-tree overlays are also added:
> 1. QSGMII mode with the CPSW9G instance via the ENET EXPANSION 1
>    connector.
> 2. USXGMII mode with MAC Ports 1 and 2 of the CPSW9G instance via
>    ENET EXPANSION 1 and 2 connectors, configured in fixed-link
>    mode of operation at 5Gbps link speed.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/5] arm64: dts: ti: k3-j784s4-evm: Add alias for MCU CPSW2G
      commit: 4670135ec39545e47f2602853dd321bc5f2bc4b7
[2/5] arm64: dts: ti: k3-j784s4-main: Add CPSW2G and CPSW9G nodes
      commit: 290b341499fc5c40839141c12d1b4d9cfe4484a6
[3/5] arm64: dts: ti: k3-j784s4-evm: Enable Main CPSW2G node and add aliases for it
      commit: 6f2133e6b46b8b499fc23a890756a44c6c434423
[4/5] arm64: dts: ti: k3-j784s4: Add overlay to enable QSGMII mode with CPSW9G
      commit: fb55df5a6b69702f79023b93d0c38cc6d749eba3
[5/5] arm64: dts: ti: k3-j784s4: Add overlay for dual port USXGMII mode
      commit: 385afb85589e354853234ed68a0600276dcd77ad

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


