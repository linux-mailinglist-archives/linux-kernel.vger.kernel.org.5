Return-Path: <linux-kernel+bounces-137555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F3989E3D7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750DB1C235CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56309157A73;
	Tue,  9 Apr 2024 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RUMOKiig"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115EB157A4A;
	Tue,  9 Apr 2024 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712691711; cv=none; b=i8JUe8BHbwCHA8HXANyRFrWB0qLkoBEIhf6eHXEYxtKTE330lvtEXHrnFx5K0pygMBd7x2YiVHxf0g4pdiKOA04/xdlHGbmmwQD/hUKBi2P2xq2ip8kay36ys5q16dX4wsb0YsY0yVYbXwFUn8Tdy5upX/9pBvjcmXfhyculelg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712691711; c=relaxed/simple;
	bh=XXKqruQgNiIuRD36vRKjg1JQWwoBtewPmsN4RWl7tKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+H1cB7fqWyQqJyVLR341GWlrAtxB0YCF+03ZcVuaMOW6csx3oXC74+lC3JAnA5pYH3PYey0qGlziTwZxth6/NWQ+2DPMvOW2fxkC/Iy1WbHKQO9re+onwYslDPzzRAbAgwAtzsDJSXt0NCDmZ8sEJKh3TcgMTI4ygUyLtMEgEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RUMOKiig; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 439JffuV016626;
	Tue, 9 Apr 2024 14:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712691701;
	bh=EH/MIRL8DMv76Ho8+sx0b/tVL1ljRT21WV7qTqKcezI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=RUMOKiig5qFWQ/yL8WSjPWj/J7QoHFKThAh9eAL8QtclzyAt6BPxCBLYC+BwaiA0d
	 2HISYL4bxPssMrtHfT6XmGA+7kS1yijVGszfAVAa4Yfyf/eW35yk8gyD4YiVualPGY
	 VQyEp6Nuj0aVSi5OAnjEFsBjhpWqp1IM7ql4RtMc=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 439JffXO004420
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Apr 2024 14:41:41 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 14:41:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 14:41:41 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 439JfePX097970;
	Tue, 9 Apr 2024 14:41:40 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        Nathan Morrisson
	<nmorrisson@phytec.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <upstream@lists.phytec.de>, <w.egorov@phytec.de>
Subject: Re: [PATCH 0/2] Increase CAN max bitrate for phyCORE-AM62x and phyCORE-am64x
Date: Tue, 9 Apr 2024 14:41:39 -0500
Message-ID: <171269169333.644861.5540130724053446073.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402160825.1516036-1-nmorrisson@phytec.com>
References: <20240402160825.1516036-1-nmorrisson@phytec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nathan Morrisson,

On Tue, 02 Apr 2024 09:08:23 -0700, Nathan Morrisson wrote:
> Nathan Morrisson (2):
>   arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Increase CAN max bitrate
>   arm64: dts: ti: k3-am642-phyboard-electra-rdk: Increase CAN max
>     bitrate
> 
> arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts    | 2 +-
>  arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Increase CAN max bitrate
      commit: 3de136cd0d601e6051aae86903e0e83077a436c3
[2/2] arm64: dts: ti: k3-am642-phyboard-electra-rdk: Increase CAN max bitrate
      commit: f360d7f8bb7b115103017f406aa90605781fb05c

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


