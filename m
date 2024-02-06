Return-Path: <linux-kernel+bounces-54309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1003684AD8C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4D4283885
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8427A717;
	Tue,  6 Feb 2024 04:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y9aBWf7U"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7A077F2B;
	Tue,  6 Feb 2024 04:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194064; cv=none; b=VB8cL+4qP4F9kKmsT7nL+SuHmfK090RQe7/pQE/zg/98/jTy5cDVcy+y6+R2NrclaT1NOU4J92Y6WTz2Z9OaA0QoEzGoDdEIMPA2NbhcHjYSaIJXEYv6mJi0Jm4MqUIe5h3FfDOGeCqaZ4CEZpAQYCdPYA1LISbaXY3f/aVftwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194064; c=relaxed/simple;
	bh=41ASCPjh09r0/e4aS/npQ9tFGwyIoN0e2w5VO1hy+HI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKT2vtbS/ArVEMvI86TaJmZSvnpRSfRiNx8rE7Ok946aCzK2zD12t8HWS7aoHCbHb+AzjrMajWLJDB4enWVWMHTfSP1GO2y1Yvix9A4g7qi6A5xI+9m7YW9a8s3wglxTYHQAwZh6xvWx9hWiHPZqFgxeQJXo3qBcYf6FKI/S0W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y9aBWf7U; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4164YH7M017184;
	Mon, 5 Feb 2024 22:34:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707194057;
	bh=qOWEdMzU2QayYX1RJ3zsd6bQg72OWnWEVtP2IZWGVZY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Y9aBWf7UEHlmbKnDfqMp85bW/ThyhceDxFgjukpkOmgODU3IFeROi6suByICxMHxq
	 4KvPNoH2kovZc4NiboLsnZz4bulqFJ1jo9379RXHasRWOVMVAPcmyzoDtU4mrlyR5u
	 4AqRBPWGPMJaqll7zPMsiVUL5M2wW0ILIwgqsySQ=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4164YHfY105465
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 22:34:17 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 22:34:16 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 22:34:16 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4164YDpT090299;
	Mon, 5 Feb 2024 22:34:13 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/11] arm64: dts: ti: k3-am642-evm: Do not split single items
Date: Tue, 6 Feb 2024 10:03:33 +0530
Message-ID: <170719349982.2245010.4501898536246619202.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123222536.875797-1-afd@ti.com>
References: <20240123222536.875797-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew Davis,

On Tue, 23 Jan 2024 16:25:26 -0600, Andrew Davis wrote:
> Each "mboxes" item is composed of two cells. It seems these got split
> as they appeared to be two items in an array, but are actually a single
> two-cell item. Rejoin these cells.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[01/11] arm64: dts: ti: k3-am642-evm: Do not split single items
        commit: ba076778dd70f0011aeb2c9847abce937b52c3f6
[02/11] arm64: dts: ti: k3-am642-sk: Do not split single items
        commit: 3c25149bb61e483b4cf04473768a3a24f57c04fc
[03/11] arm64: dts: ti: iot2050: Do not split single items
        commit: 966459a6994bf7b16a330635b2c2ff9f00437b31
[04/11] arm64: dts: ti: k3-am654-base-board: Do not split single items
        commit: 6d1ffc18d68f82f82899f2f2d9aca65657828a96
[05/11] arm64: dts: ti: k3-am68-sk-som: Do not split single items
        commit: 48159cb78e3c540b592031e1db5a6c9eed853621
[06/11] arm64: dts: ti: k3-am69-sk: Do not split single items
        commit: 2b8e6fac6bb254f70dfcefce01deada89251ae99
[07/11] arm64: dts: ti: k3-j7200-som-p0: Do not split single items
        commit: ff61b8cbafdcc9a0be0a45758769a54b3d9f2042
[08/11] arm64: dts: ti: k3-j721e-beagleboneai64: Do not split single items
        commit: 3ff119bb1cb1e3a81bf620125a3bd74821464804
[09/11] arm64: dts: ti: k3-j721e-sk: Do not split single items
        commit: 90ca6810778865ae7b3ac33229f72f542dc7830d
[10/11] arm64: dts: ti: k3-j721e-som-p0: Do not split single items
        commit: 9fedf76ac33b2a169eaa64d235f5b433c575ebb3
[11/11] arm64: dts: ti: k3-j721s2-som-p0: Do not split single items
        commit: b1898456a4307097c47a340f4a9327a125f75a43

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


