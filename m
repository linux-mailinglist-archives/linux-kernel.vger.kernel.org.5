Return-Path: <linux-kernel+bounces-160749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 045138B424B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BEA1C21EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6B53B781;
	Fri, 26 Apr 2024 22:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rmqASM2K"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EC4383BE;
	Fri, 26 Apr 2024 22:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171361; cv=none; b=oYaREyJrj3BDzto2/Rcm385oRU1DVdXJj3+cpwqxI6vZkzd0XlYy2iCZSq6hj7qDmmknUox/yqPj4QGTsVlw3+N4Qmoo/O/bDRJDNWgYX/Ax63ACTu+C0XkI+8gwZBhiXjXEQ8QoGHuNAwa2LAjBoeueVP8R2oZmeE/OBrdi1ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171361; c=relaxed/simple;
	bh=cJZiQy5A7koqzXHwuy8iofaYcipy/Vju/lwBSvJPLeE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KC2ayV0Ib9hESS3jLNizaZU7QDSjL4OHR0dlyjmiIwuW635jwkFqkHKAdlPag63YABRnUwxnHwnDYhlDYwktFmT0mWSkI1rFO/CnZhoosiggWxm02YNMXSdIUVcY6I9pZP9xJJVX33tJZUYVTkh8OvUCM/XfAnv3pEue8rf4Kas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rmqASM2K; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QMgYGe028623;
	Fri, 26 Apr 2024 17:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714171354;
	bh=bfI/rN0T5eINGq5PJj0s1oachOAwHoqwlIDXnhIss/Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=rmqASM2K9Nz60xCS6m3fCwnCqy8JzYC4t1m7xtXaIxshwMMDNrj0y+sFMUUHI3Ssd
	 IxHfd4BWlnqznpdDjite5ZrJFOGEOxhmVtcNcZOVjoJtMKTknFVAaHoyNE7axSmG2o
	 FsI6Q6MHm4xSeOnUVneKB0wqXtXLIY1pdkO1Sa2U=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QMgYpQ061813
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Apr 2024 17:42:34 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 17:42:33 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 17:42:33 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QMgXIp085988;
	Fri, 26 Apr 2024 17:42:33 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <n-francis@ti.com>, <m-chawdhry@ti.com>,
        Udit
 Kumar <u-kumar1@ti.com>
CC: Nishanth Menon <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Adding main esm Address range
Date: Fri, 26 Apr 2024 17:42:30 -0500
Message-ID: <171417134332.3484516.7638823174327418428.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424075423.1229127-1-u-kumar1@ti.com>
References: <20240424075423.1229127-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Udit Kumar,

On Wed, 24 Apr 2024 13:24:21 +0530, Udit Kumar wrote:
> This series adds address range for main domain esm
> for J721S2 and J784S4 SOC.
> 
> Udit Kumar (2):
>   arm64: dts: ti: k3-j721s2: Add main esm address range
>   arm64: dts: ti: k3-j784s4: Add main esm address range
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j721s2: Add main esm address range
      commit: db4d62037d90c6c8f70884651acb3b532c688e54
[2/2] arm64: dts: ti: k3-j784s4: Add main esm address range
      commit: cc58233a29809aa841a29c2729a2786bc57abd9f

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


