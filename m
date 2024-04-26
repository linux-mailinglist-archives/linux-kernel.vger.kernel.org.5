Return-Path: <linux-kernel+bounces-160744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199658B4240
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF101F22DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1818C3987B;
	Fri, 26 Apr 2024 22:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QrUgdqLk"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82AA374EA;
	Fri, 26 Apr 2024 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171233; cv=none; b=izAi4G8c/0HbTl1r6jRVWQmAUbjHRL/s++D5NEoc6qx3hw4Vdi2c1e/3DYWadF4EtB06SItHSVZBvgLRTcw/C4ogWssUsawAS8A9mmZ5SVBpHQ6L+hIiirSeJczVygdrWqmgTKkJ3t91FhoNlFLRBpWTcu7PC2OncvzsUFM7wyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171233; c=relaxed/simple;
	bh=DwufAWwzl3vE5QXemZI6/tuCGLYpYegjlOva1p0BUZ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBUf+ssQdFjCeikM9+GRynqOAQEYk42GnfxfksCo5jlR2eGtfxiggstE8djG9X8KHBoX30g79VUNsr0LOwju+iUKUnBU87pnwcUsax97ZesNDAqTVFtWjVY9mtO7pOutyffarL0gynWBTjUtj66RlL2qaaYMCClGb4Ux+yzwSGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QrUgdqLk; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QMeO9f009863;
	Fri, 26 Apr 2024 17:40:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714171224;
	bh=ajxTk5qiU/sLLTXvIiCSu+fG540EarS4BMEfr/DLixQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QrUgdqLkwnpt/BkGnlLOc6sQUaxfzqc6jBOh5e97ZD4O5j/R2lz/qXE6/bkRsWMBh
	 5k3YaLmF9Eij5nI5Xst1ROxq+S/4ohCvSWLVBYvKI/tSBad5WdI4yL9ucruc8v0L3W
	 m0xKQpAEz0VQj/Q3Pw1lgGI1j7fQtkKiUEMBG41g=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QMeOP9060476
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Apr 2024 17:40:24 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 17:40:24 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 17:40:24 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QMeOiu081125;
	Fri, 26 Apr 2024 17:40:24 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Nathan Morrisson
	<nmorrisson@phytec.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <upstream@lists.phytec.de>, <w.egorov@phytec.de>
Subject: Re: [PATCH] arm64: dts: ti: am64-phyboard-electra: Add overlay to enable a GPIO fan
Date: Fri, 26 Apr 2024 17:40:22 -0500
Message-ID: <171417121030.3483252.13281191860265108819.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240419193114.3090084-1-nmorrisson@phytec.com>
References: <20240419193114.3090084-1-nmorrisson@phytec.com>
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

On Fri, 19 Apr 2024 12:31:14 -0700, Nathan Morrisson wrote:
> The phyBOARD-Electra has a GPIO fan header. This overlay enables the fan
> header and sets the fan to turn on at 65C.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: am64-phyboard-electra: Add overlay to enable a GPIO fan
      commit: 9198fbfc14797a3a39c758ac6fb96a2169cbb70d

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


