Return-Path: <linux-kernel+bounces-83375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF684869660
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888B5293C3D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194C0140391;
	Tue, 27 Feb 2024 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mxRQd1cc"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD3B13A26F;
	Tue, 27 Feb 2024 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043060; cv=none; b=bFk7jiuMbcYgtJGLYwRqKHLLHy82GyPurIdo8p99J7PuAlVnUNkI9cIWNqAbtysk8mBpAe8uRVeIiIXA86DCJDwYYWQJZK1o5GNtJ9MvK/jI7D9IUupx8P8AbcH5+9lPtlX5YSIHAKtAeKMFTKfGtekDZLPykrZKWBDpmtNGN4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043060; c=relaxed/simple;
	bh=vgTTOZ8oVi60nBI1O82tfTB6TGRX+J/StEizbEtSPek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7h39XGVGJ+9XwrsWffC4XOuUKlG7BvKu1ES1rMGDzeZ2D34XWnia6tokDmqft3YApOPQOYA6lHiGmddTMLgcoa+0mph4kG7x6LLRiTSV/ZV0ILLKTQQ8g+z/uqE/0YtObztCwCTyYIsOsrob2rOHhokcOwZH1zjea6c4Qaxm3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mxRQd1cc; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41REAgIk060167;
	Tue, 27 Feb 2024 08:10:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709043042;
	bh=EN+pVxADQBDkh74H6nAK9fEDLfjUX2qCf5kUyS1RCZ4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=mxRQd1ccTo4LiZXpVb007qxZeY5AmTBZRcHiSd9mVGbUMZhZz9cnDm9AejjVKAuGn
	 T+n7Lz+6ivuFhv61jnyU+cCR8fYNq8TL5UDmWJCbltX/7XNLvHxaY82/rRYwwPHh6g
	 4qkbySkzsW9pGl/01ZVR3YFY3TH3NYoc9KkpE0N0=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41REAfJY049649
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Feb 2024 08:10:42 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Feb 2024 08:10:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Feb 2024 08:10:41 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41REAafS091738;
	Tue, 27 Feb 2024 08:10:37 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Josua Mayer <josua@solid-run.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Yazan Shhady
	<yazan.shhady@solid-run.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>,
        Suman Anna <s-anna@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        MD Danish Anwar
	<danishanwar@ti.com>
Subject: Re: (subset) [PATCH v7 0/4] arm64: dts: add description for solidrun am642 som and hummingboard evb
Date: Tue, 27 Feb 2024 19:39:46 +0530
Message-ID: <170904289248.941614.3402741542948596682.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219-add-am64-som-v7-0-0e6e95b0a05d@solid-run.com>
References: <20240219-add-am64-som-v7-0-0e6e95b0a05d@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Josua Mayer,

On Mon, 19 Feb 2024 16:02:59 +0100, Josua Mayer wrote:
> This series adds DT bindings and dts descriptions for SolidRun AM642
> based SoM and Hummingboard EVB.
> 
> Additionally a commit from downstream vendor kernel are included,
> enhancing support for pru based ethernet.
> I wasn't sure how to properly annotate it in commit description /
> signed-off area ...:
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] dt-bindings: arm: ti: Add bindings for SolidRun AM642 HummingBoard-T
      commit: d14bae4087c5abf5bd2d56c0cc3c9e849ad2ae44
[3/4] arm64: dts: add description for solidrun am642 som and evaluation board
      commit: d60483faf914b4d404a9732476278ac13bb33b70
[4/4] arm64: dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb-3
      commit: bbef42084cc170cbfc035bf784f2ff055c939d7e

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


