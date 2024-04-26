Return-Path: <linux-kernel+bounces-160740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C0F8B4237
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484501F2238A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2117638FA5;
	Fri, 26 Apr 2024 22:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BT8uT+2C"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4C034545;
	Fri, 26 Apr 2024 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171136; cv=none; b=EvWyX89sl1ALb3tmEWi8DQBS1KWOWgIwE4U8rm9/Ewz6X+0q8E1qvHFSHRV+zQEGmAskghVwFE4n/FUXxRK4ytdHMSn8ncjyaCPml9hTInYL4thjsjwKu3trAUe+joJz4GUEk2iRwP2m7Re8fj56X4AMwa59h+DDorewUI34vVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171136; c=relaxed/simple;
	bh=qJ9rw2GU0e1gRvWiEFeq92YCHmCMgPMhYIg1Yr1Xr1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mpwfe0DRYM6YBrUE50DfIZtRo6Qwp5CV/p1oA2aalNTvLau9bAiUg3faDJLWqsoQn1oo/PUqRHWxmU/09aAje08LrVT00NGu+3RtsF4HjgfY7ndl213PtIIcKJ9P1FEe9D8DhigZPU61cNod03t4Q+iX6LhWvw8fuyJFuCP/s/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BT8uT+2C; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QMchgS009482;
	Fri, 26 Apr 2024 17:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714171123;
	bh=chaxr6tVE54gEOSPdHPLfgKOoXUaqZ5tQUQrRMi8FNI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=BT8uT+2C8YgrBX2CjH4HSyXvulizNIQdrD7TGoOmdtov00WcZvRKf8BvDTLG0dRd9
	 MxgX1636kbZ1DZxGgPaITyX0VzFWSb337h3n7+wIiRdz2LB2B5B1QQ5Vwk7LzPG6Rk
	 ehbG9qJf8SKuBAkTL8GIrNWA2MQ4e0iTCaB1CEKU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QMch3Z024237
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Apr 2024 17:38:43 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 17:38:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 17:38:42 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QMcgtH078499;
	Fri, 26 Apr 2024 17:38:42 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>
CC: Nishanth Menon <nm@ti.com>, <afd@ti.com>, <srk@ti.com>,
        <r-gunasekaran@ti.com>, <b-liu@ti.com>, <francesco@dolcini.it>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62*: Add PHY2 region to USB wrapper node
Date: Fri, 26 Apr 2024 17:38:40 -0500
Message-ID: <171417111578.3482723.5915664375435778473.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412-for-v6-9-am62-usb-errata-dt-v1-1-ef0d79920f75@kernel.org>
References: <20240412-for-v6-9-am62-usb-errata-dt-v1-1-ef0d79920f75@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Roger Quadros,

On Fri, 12 Apr 2024 14:52:14 +0300, Roger Quadros wrote:
> Add PHY2 register space to USB wrapper node. This is required
> to deal with Errata i2409.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62*: Add PHY2 region to USB wrapper node
      commit: d4fbe9bfc7a110c6700be7fc1484c3ea22b6401d

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


