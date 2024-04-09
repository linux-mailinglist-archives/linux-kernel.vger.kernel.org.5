Return-Path: <linux-kernel+bounces-137552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A8D89E3D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07891F21807
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AB4157A48;
	Tue,  9 Apr 2024 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LdvvLqCX"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3261E89E;
	Tue,  9 Apr 2024 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712691599; cv=none; b=no0uGwuf5/T3i7a6XZ9utXnyaYTsNmc0DRjXSS4ZBt+cez+MJrtD0Leul7ieo344YKg77r6F+oTNknObHjWieKeLZWHSSL5dD7s7Jk7S6tI/nyORKubV8QiNpShGwTk9taNI0rkrPDi+ioViuyxgIJQdzAwGbnAkQnXRQpgE1Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712691599; c=relaxed/simple;
	bh=UWMRK0m4UxrnUXib4lCMgaD1ArvJTQn3Ncm77l4ouRc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVz2FDzN2/mQFwTmZ0PpoNUalfvhAP0EXDT8YFaE9KbsinJHlatAZ51XUMaVdlD95pu6DiqxMym+3rp0pT3Tbs5EYGdnCDXpV3TdmgWIlrBMj8RYdTAIs0Kuw75NBY3frMlnnmWkJl3hV/AEQmd6WrnXC3fQj8J185bFp0QNEQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LdvvLqCX; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 439JdjaB106624;
	Tue, 9 Apr 2024 14:39:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712691585;
	bh=v4GwheQo5p5O4y/kpHxweoSNcFIKUU+zSI9LDZJ8My8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LdvvLqCXYL/z+dWaPKmJimnojez0oJxwtIwNiZ1uNRxhduCEFVupq+dQ+T71Y/xmb
	 kJ9AD+ThfyB3WZjfPaEbHwZN9lC78WZY/d8Wzqnk0F3GHk2nECcjiFlwU+ojlMADtL
	 2NR+QcCi6yj+aElu/X/5EvS7whn+YzaLJv/ebq5A=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 439Jdjei002800
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Apr 2024 14:39:45 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 14:39:45 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 14:39:45 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 439JdjrH105320;
	Tue, 9 Apr 2024 14:39:45 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>
CC: Nishanth Menon <nm@ti.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] arm64: dts: ti: k3-am625-verdin: fix GPIOs pinctrl
Date: Tue, 9 Apr 2024 14:39:43 -0500
Message-ID: <171269157178.643546.11040513615596738650.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327182801.5997-1-francesco@dolcini.it>
References: <20240327182801.5997-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Francesco Dolcini,

On Wed, 27 Mar 2024 19:27:59 +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Fix a couple of issues on the Verdin AM62 pinctrl affecting multiple
> carrier boards.
> 
> The first patch fixes a mistake on the pinctrl of the verdin-am62 mallow
> carrier board.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: verdin-am62: mallow: fix GPIOs pinctrl
      commit: 8760892b8a3e20fdd996e59daf0a5f847b238967
[2/2] arm64: dts: ti: k3-am625-verdin: add PCIe reset gpio hog
      commit: d3c702186abe01e24f962627ec67fcad8106c79d

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


