Return-Path: <linux-kernel+bounces-66531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBFB855DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFAA1F281C6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C248E179B5;
	Thu, 15 Feb 2024 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LMYIDRn5"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857C6134D7;
	Thu, 15 Feb 2024 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989198; cv=none; b=dNpiYXVf6sJO3u4sKkU0o0kFmYHR0dcXM63Lw9mlJhqHN5L8fa8cR4BSjNPWZbLM66AlHJi1FwESl49yV7DN1SlVKGvXmqRPH6D1fMh6zhurQ4pIIhbW0wHhaE6gle7fR40Qj+l8RJpPomzAxJH4XJGYCxLkN2LEwiFfaup+rt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989198; c=relaxed/simple;
	bh=3kuVzkr/6c5/S/9bs0YcA4FFOB7HO9bNlsLgAfkqaho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4TbadAaClxVOraBG8eWzZv9/PkGTAymLYo3g/zUsLwLpjJPSnKNq1jVr6BABjiqR4Nmt54fhjp2OpV5cQTIQLXL1C/vm3PQf9YCXJ3JWAzWSI3Xvv0WxsRXQusciCg+76Ay7KN/XvgyqlKT/VlfHhJJB8lz/+nvem4/hQG/2jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LMYIDRn5; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41F9QRAd061289;
	Thu, 15 Feb 2024 03:26:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707989187;
	bh=DASJvtkSvMfnXalycCCaTklm5G/FhbEJw+Jgi3vhJP0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LMYIDRn5amAvonuvtSt8nF4YKE5C5x9jIpJEiGdOptIMrpKkR4w7NeMvG+mjs08HX
	 kgEp1/mlcX2QedhZnygJEkfX5HfIShZbWUg79hvlikzoQFsf6dEfdUtNkH8yKU1Ace
	 XikUt1qN281n++g+dtO+mOUPQ5vIcyn4N6uGP/6g=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41F9QRF4063969
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 03:26:27 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 03:26:26 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 03:26:26 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41F9QMQH059017;
	Thu, 15 Feb 2024 03:26:23 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        Nathan Morrisson
	<nmorrisson@phytec.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <upstream@lists.phytec.de>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <w.egorov@phytec.de>
Subject: Re: [PATCH v3] arm64: dts: ti: am62-phyboard-lyra: Add overlay to enable a GPIO fan
Date: Thu, 15 Feb 2024 14:56:17 +0530
Message-ID: <170798813444.1487216.17136908853088424547.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213005248.1027842-1-nmorrisson@phytec.com>
References: <20240213005248.1027842-1-nmorrisson@phytec.com>
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

On Mon, 12 Feb 2024 16:52:48 -0800, Nathan Morrisson wrote:
> The phyBOARD-Lyra has a GPIO fan header. This overlay enables the fan
> header and sets the fan to turn on at 65C.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: am62-phyboard-lyra: Add overlay to enable a GPIO fan
      commit: 192a0c70ef164b7b00a9d0126d961f10318e058a

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


