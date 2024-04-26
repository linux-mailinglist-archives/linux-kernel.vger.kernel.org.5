Return-Path: <linux-kernel+bounces-160748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194218B4249
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53075B233A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BCE39FC5;
	Fri, 26 Apr 2024 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iJgeqyKZ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AAD383BE;
	Fri, 26 Apr 2024 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171350; cv=none; b=gCEBd8H4ZeWn8ju9xTOYKXdwICuFTmn7r9c1jabFtUvGrAdFHHoovUGZ3PmW0noLopoEwLzqMpLUdCfbWTuiaymxtX0U8MjBhnZVRcJ5Pizn1PfDV0vqGLXElDLF342UstX/qF5IcyAAfwPUvkAfGHugVSGSSNP+CBpFW9pXht4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171350; c=relaxed/simple;
	bh=aR5JmJwVj68lu+Vs9P7gprZK0XkP/8KMDcqphjQteDA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbIEDrPpPe4yn+bOk3GPAcFDjbfhvzvPHEKpg0pMSw/t9Isoexr7fsOW1Je8kc9s9Mb2qG4+Xfb9Lih0Y9wHLi5cFIOidUCRioZMwJW6vS/L5HiWkmNUIat535B7PeJmhSajiHpnofTNZnU9xm4mrJrtem8Br4DeUQ6WAXB/quw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iJgeqyKZ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QMgFaQ018503;
	Fri, 26 Apr 2024 17:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714171335;
	bh=9XyFwCvc+ipvHtwCu+tqxq5hfhL96pWIbwEWvrv3T6k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=iJgeqyKZ92w/nvZsLEFsbB016aWPpb9Cgk6oP3blgVM7pn4yF8RLHMUQCge6zCPqw
	 TQRw5Tnp90bE4VdeSDlbR6L62YIEcA8gmb1vhiYUmL5qyviRrWBvVv7l7NcOKa0F4Q
	 2NXIceAjXJIpiBcdsj9WaYj2YLQF5BH0qkwBtgXU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QMgFv5006593
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Apr 2024 17:42:15 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 17:42:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 17:42:15 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QMgFoL085612;
	Fri, 26 Apr 2024 17:42:15 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        Stefan
 Eichenberger <eichest@gmail.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <francesco.dolcini@toradex.com>,
        Stefan Eichenberger
	<stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 0/2] arm64: dts: ti: k3-am62-verdin: add sleep-moci support
Date: Fri, 26 Apr 2024 17:42:13 -0500
Message-ID: <171417132605.3484246.13145737437782597279.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240301084901.16656-1-eichest@gmail.com>
References: <20240301084901.16656-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Stefan Eichenberger,

On Fri, 01 Mar 2024 09:48:59 +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> This patch series adds support for sleep-moci to the Verdin AM62 in
> combination with the Dahlia carrier board. sleep-moci is a GPIO that
> allows the system on module to turn off regulators that are not needed
> in suspend mode on the carrier board.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am62-verdin: replace sleep-moci hog with regulator
      commit: e75f65467e01633afe921acb5742403c86153b48
[2/2] arm64: dts: ti: k3-am62-verdin-dahlia: support sleep-moci
      commit: 262b0d3d724dc33c7ae1359bcd89abefbad7a886

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


