Return-Path: <linux-kernel+bounces-72296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7F585B1BB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2A7282978
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275FB535B4;
	Tue, 20 Feb 2024 03:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nzpDzpqw"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E5E17E1;
	Tue, 20 Feb 2024 03:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708401304; cv=none; b=hFMFtch9QeBiKHVnOPcLREwHACSQQqQSk8uSJ6jmACcmNu+baCS7NbefXIixchGvH0FLQ5EQKFXNuioL7A7FVYJaLYL/6o9+2TXeA6Qgv1CYW0wDslc/jsAMvQtax1f5dvmpQfpNpKUUj+BCan8Q7JC5jWg0450dtxCv6DvvGPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708401304; c=relaxed/simple;
	bh=5oZ3K3bAXkffHb6k1g5LwmCoSvNEG9tF2O38FJwH0pU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/yfqQHtwVWa+/B5n7aCqLVirt6GhIF2S7fmFLGV/0JnAlLkYJmcJujpL4HULo6oSPtNgkaJ4181IwaDWjLJNBSeTyh+PV+lqB2oAWfA8zi8O1pd9iA4KozmpfcLsWfKqt/DppF6CX1c0VeFaFt1SPLF2MWJuZhKcGzLaJeLnV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nzpDzpqw; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41K3sgpP102048;
	Mon, 19 Feb 2024 21:54:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708401282;
	bh=o2nBXARzFvvU+JNHZ8+R4HXI9akimhmL8CTZQPRtQug=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=nzpDzpqwQe+1yCzMYDyqZGmJVoaaH3D+y5claJN1Bm4Oy8RdF+8FI/3PYR+emmoPc
	 UxEWB64nZ9csfbjuJ/FnJTvw3vkVKlelMFhSsxwolyRAQJMv7CYGRL+sIxQJIHNo8A
	 IJS6S7TwCZG+EJe/uyi1id/GDhvNDU3bzDhhbpzc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41K3sgFv028739
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Feb 2024 21:54:42 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Feb 2024 21:54:42 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Feb 2024 21:54:42 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41K3saEY055308;
	Mon, 19 Feb 2024 21:54:37 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <nm@ti.com>, <kristo@kernel.org>, Devarsh Thakkar <devarsht@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <praneeth@ti.com>,
        <a-bhatia1@ti.com>, <j-luthra@ti.com>
Subject: Re: (subset) [PATCH v5 0/4] Add common1 region for AM62, AM62A & AM65x
Date: Tue, 20 Feb 2024 09:24:28 +0530
Message-ID: <170834878957.3471454.9863747085400602100.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216062426.4170528-1-devarsht@ti.com>
References: <20240216062426.4170528-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Devarsh Thakkar,

On Fri, 16 Feb 2024 11:54:22 +0530, Devarsh Thakkar wrote:
> This adds DSS common1 region for respective SoCs supporting it.
> 
> Changelog:
> V2 : Remove do-not-merge tag and add am62a dss common1 reion
> V3 : Add Fixes tag to each commit
> V4 : Add Reviewed-by tag and AM62A SoC TRM Link
> V5 : Split dts patch to separate patches for each SoC
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[2/4] arm64: dts: ti: Add common1 register space for AM65x SoC
      commit: 1a5010eade10b409d353b770d97b548b0fbdf5d7
[3/4] arm64: dts: ti: Add common1 register space for AM62x SoC
      commit: 7d8ee2c3b8a2aabb9ce75795bad20773bfe1ba13
[4/4] arm64: dts: ti: Add common1 register space for AM62A SoC
      commit: 0f9eb43f009091501dd0c68232aa6530ba0e0185

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


