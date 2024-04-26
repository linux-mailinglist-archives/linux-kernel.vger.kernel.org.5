Return-Path: <linux-kernel+bounces-160738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 833868B4233
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F361C21043
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A3139856;
	Fri, 26 Apr 2024 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bJ6Yah+K"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7933A1B9;
	Fri, 26 Apr 2024 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171100; cv=none; b=q4YyNfUtSXwjygoehS0K4pvMJIiyI6sCnC0sn5xoEaPCEoOzo3CRvse5mcDt8UJCCL/jXHlQR/h6dhgRHdSpg3cfxtkA0JsK/+2t0/E1oLCM/885DYmjwvtBW0T4aFm/Vf4e8sfcsUYUydR+NqvF/1bnPg8JdQRMQdPrMR2sHWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171100; c=relaxed/simple;
	bh=NVpE+lqzpB7gqeBdiUMvKxg+c+gd9l0VtzWhv5o4jsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NolrJdgI+2rl+OVxJSGBV9aBleLRxjwD7bF32O/C+pDJmb3J3T211WhIKtrIFgrufRR+HzOO18uPouVUvWH1LgYWNsvJZTi96tcP7zM+eclKSMuwPGuI90YVyoXgcxX6EzKHqz4ImvoBt1vahqZtqA2OjTh9/4kwfAoinD1BlRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bJ6Yah+K; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QMcAVE009414;
	Fri, 26 Apr 2024 17:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714171090;
	bh=u7cr5QUHs7PdG4qPqhArHoBOdAkpWLy3QY+EFEPZ3QY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=bJ6Yah+KCLkNF0Gn+iAw5zsBlwRrizpNTvTx9WiVQK6/NX5OcPuJOq75nTcISSbG1
	 OEa48HGfmhg7JMleuA07ikuWohlLq4kvxJMdBxcMsaF95C788M5BmNrUfnmXINRoNT
	 ai7GFKU0zwmt1WrUugnDzZkyWz+nLwS3uY56qSmY=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QMcA7x003632
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Apr 2024 17:38:10 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 17:38:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 17:38:10 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QMcAQh078226;
	Fri, 26 Apr 2024 17:38:10 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <w.egorov@phytec.de>, Garrett Giordano <ggiordano@phytec.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <upstream@lists.phytec.de>
Subject: Re: [PATCH] arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Add Audio Codec
Date: Fri, 26 Apr 2024 17:38:09 -0500
Message-ID: <171417107954.3482467.4331245708656793221.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404184250.3772829-1-ggiordano@phytec.com>
References: <20240404184250.3772829-1-ggiordano@phytec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Garrett Giordano,

On Thu, 04 Apr 2024 11:42:50 -0700, Garrett Giordano wrote:
> The Audio Codec runs over the MCASP (Multichannel Audio Serial Port).
> 
> Add pinmux for the Audio Reference Clock and MCASP2.
> 
> Add DT nodes for Audio Codec, MCASP2, VCC 1v8 and VCC 3v3 regulators.
> 
> Additionally, create a sound node that connects our sound card and the
> MCASP2.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Add Audio Codec
      commit: 641eb61369bb27e4fec76f311aef58e3572d2147

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


