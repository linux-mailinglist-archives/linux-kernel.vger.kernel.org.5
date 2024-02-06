Return-Path: <linux-kernel+bounces-54298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8678384AD72
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBC31C23D0F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E864C208CF;
	Tue,  6 Feb 2024 04:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RYcWZi1b"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A12D052;
	Tue,  6 Feb 2024 04:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707193806; cv=none; b=cMj3ZKtCSo0I+gcz4spKMjfR28ot9Yx+m0y46db47foYMPDcXd8P0SSEeeKTRC4wKoxQq9VEGevYcEuk+FXYMMdVJUYYaS5JTfcYj0nKjtkqrEwgIQLELd+oM/ZUxXKH9fCk4UPc9vPguXGzZ0nbLsfd+1hreG4U+oMjmqbIPWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707193806; c=relaxed/simple;
	bh=Zx+YKhvERm1JcAJVLFA4638UBYYXTDFqTFzZieNLA+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CO95OmiNzYh28lO1uml00Z8TuPdgeRnKcic2zqprKRjqs3b0eK4fZKMvotO3YPcL46zWCy+F6J6uvri3pclJPe6vdoA2ajR8CeZCiRqrMAUNemytN0FZWnPXSNHN5CfMjyrckLDejuW1otat3CNbymLq6+ZfV3pq3dENbGHTec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RYcWZi1b; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4164Tpsa087778;
	Mon, 5 Feb 2024 22:29:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707193791;
	bh=A6BXY1U52Np3UNS4Lqr7bF3Hqk1NGFiDx+Tx0WfLMBQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=RYcWZi1b2OXhGhucmDVISejzB1s0U6XmkYH8AtGJoIE9YtoXXA2kpZ5CJolRjIK9J
	 okKyWA2hyFNnqLUeMms9L+rrrEbaM9ng/DJbTj3Svo3yDlqdJwQAxp9CCtvwXJsCgt
	 YqQEFdKCREAgv3b2kzHRRBsqUWqYmEOpDiYM0II8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4164TpaK121051
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 22:29:51 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 22:29:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 22:29:51 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4164TlRM083629;
	Mon, 5 Feb 2024 22:29:48 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <linux-arm-kernel@lists.infradead.org>,
        Sjoerd Simons
	<sjoerd@collabora.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <kernel@collabora.com>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Rob Herring
	<robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Set boot tags for the usb0 port of AM62x SK and Beagleplay
Date: Tue, 6 Feb 2024 09:59:10 +0530
Message-ID: <170719349980.2245010.13978940073133357464.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112091745.1896922-1-sjoerd@collabora.com>
References: <20240112091745.1896922-1-sjoerd@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Sjoerd Simons,

On Fri, 12 Jan 2024 10:17:06 +0100, Sjoerd Simons wrote:
> The AM62x SoC can be booted from the first USB port using DFU. Set the
> relevant boot tags for both
> 
> 
> Sjoerd Simons (2):
>   arm64: dts: ti: k3-am625-sk: Add boot phase tags for USB0
>   arm64: dts: ti: k3-am625-beagleplay: Add boot phase tags for USB0
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am625-sk: Add boot phase tags for USB0
      commit: 524c8086a453b8df1002c1ccfa9f99589761fc80
[2/2] arm64: dts: ti: k3-am625-beagleplay: Add boot phase tags for USB0
      commit: f7d2844d848f8836e6a7923e3ea426f7be4f38d1

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


