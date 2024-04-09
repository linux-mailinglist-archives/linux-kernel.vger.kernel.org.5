Return-Path: <linux-kernel+bounces-137549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D8C89E3C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F53287207
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDFB157A41;
	Tue,  9 Apr 2024 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EiXq7zIf"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE98287E;
	Tue,  9 Apr 2024 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712691533; cv=none; b=OPKDbsjhyAMnOQ1ndqVT/QpBZeWXnYtrMExHI6TSSTGXZ5ZjwC8zmlwEIl4cb28vW0zvbW2RINhywh5vE8ym1TmkZhR83MK5bV0cXZU1ssKhTxErpxxGDlkSwc/WRL6qRrx1W9x5TeB0C0S9SbipcdLY2SNMEplUPpXeuNNk0iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712691533; c=relaxed/simple;
	bh=5He+hPYuSWL8/RTjUKHQyM43sI44vCYjWprccp1juHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJQtW6KQwyTbL96ItGxol+jvtEQZ7+kM7X4v7S5zzqu+ktbElcLWmp58BIl8Q8Qis9uPjgzKgiwVAF+3rzSWQyRsCKs7epQW6yppX3yJrAZRWmfveosx0V4l7oxmZGbjX6hmg5+dxEYegWDvGIw+IxR6gg7hQ2ZePcGjEvevqW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EiXq7zIf; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 439JcZKw016007;
	Tue, 9 Apr 2024 14:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712691515;
	bh=UMeKXqutEdhZWaPaQ+3kgGVkcVHTscqD8c4wrFATNrY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=EiXq7zIfhIEV47bv+tanv8aPeippm7Yl4oTlW3U6gxVJuUYT56Hl1GiOTdr8tUp41
	 v+b+5o/cKagzyMFyQpYdfMDItiWUvbxVcBDd3E3VnbZZZwkA1hwPpmhHEXvDX+/0Yt
	 VcRn755QTRxCNCTqfIunNB4ktxDqcdy4gXAiVuak=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 439JcZLZ006752
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Apr 2024 14:38:35 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 14:38:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 14:38:34 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 439JcYlm092851;
	Tue, 9 Apr 2024 14:38:34 -0500
From: Nishanth Menon <nm@ti.com>
To: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
CC: Robert Nelson <robertcnelson@gmail.com>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Shengyu Qu <wiagn233@outlook.com>,
        Sukrut Bellary <sukrut.bellary@linux.com>,
        Javier Martinez Canillas
	<javierm@redhat.com>,
        Bill Mills <bill.mills@linaro.org>
Subject: Re: [PATCH V2] arm64: dts: ti: k3-am625-beagleplay: Use mmc-pwrseq for wl18xx enable
Date: Tue, 9 Apr 2024 14:38:33 -0500
Message-ID: <171269147745.643129.11386696424104889094.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325143511.2144768-1-nm@ti.com>
References: <20240325143511.2144768-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishanth Menon,

On Mon, 25 Mar 2024 09:35:10 -0500, Nishanth Menon wrote:
> BeaglePlay SBC[1] has Texas Instrument's WL18xx WiFi chipset[2].
> 
> Currently, WLAN_EN is configured as regulator and regulator-always-on.
> However, the timing and wlan_en sequencing is not correctly modelled.
> 
> This causes the sdio access to fail during runtime-pm power operations
> saving or during system suspend/resume/hibernation/freeze operations.
> This is because the WLAN_EN line is not deasserted to low '0' to power
> down the WiFi. So during restore, the WiFi driver tries to load the FW
> without following correct power sequence. WLAN_EN => '1'/assert (high)
> to power-up the chipset.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am625-beagleplay: Use mmc-pwrseq for wl18xx enable
      commit: 31d5c43719bbd147d7e2c53ad2ef17953c68f458

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


