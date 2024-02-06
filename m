Return-Path: <linux-kernel+bounces-55153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F5884B895
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069EC28BF98
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B18D134CD1;
	Tue,  6 Feb 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mIiycjwX"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D317C132C3E;
	Tue,  6 Feb 2024 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231309; cv=none; b=sgET03IKZcBUebVNjkJHuTiALdihPMw3mhBNPwJ38jlH2oi33+MnlHyb7EJ/sDKd0pfjJyv7+QOP1LAKOvYWP/oI6OXpx3Vy05gvrxB2+SVmepdb9hTB3EAncM3cg5aAaAWe84huf/6bFTT+TsHRwK5ru+ttVt/Z1AYgMXLlxNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231309; c=relaxed/simple;
	bh=j+QFNeS/VO2zFOn+mhfOZ8s4Z3+3GdEFXPxdJoZ9jT0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUAqlvx+lN9dxttDjpORaeVk7nnSYTuwY7veElkSi0rRZQbGu7kTNr5R9Y44oHnYu2cDqKI3GyWC3TyJ3aqJ8Swbx8+gBvH1B8tW0ETPCekuPB2xEQieJSTysFQg1UuoRXLZIsLhsQGoOnHsbJ1lPSl+Kt87Y7SOd05nTK7hAac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mIiycjwX; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416Esx6J022544;
	Tue, 6 Feb 2024 08:54:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707231299;
	bh=KxPl/+O74D4htbdgdG6JBwM6O+fMVv+uOVakC/1OfI0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=mIiycjwXHOcLORQLuuXS0aof7E2uzVw6L3ZQfrj6dMiWPTeJBM57x+eHvs73gLc0k
	 nExuQ3vIqc+Q1hFKY0hFMwii2lWmVd+OQ1KsGbwWohMINp23mdUTgbfEQl/mdFJc/S
	 cFSn+rR6xqVqT50saYwTS2qTRbCimIc77lMAd6JA=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416Esxa9108092
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 08:54:59 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 08:54:59 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 08:54:59 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416EsvQ8050924;
	Tue, 6 Feb 2024 08:54:57 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2 00/16] arm64: dts: ti: Additional licensing and clarification
Date: Tue, 6 Feb 2024 20:24:40 +0530
Message-ID: <170723117278.3216299.12458152939034721597.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145539.194512-1-nm@ti.com>
References: <20240122145539.194512-1-nm@ti.com>
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

On Mon, 22 Jan 2024 08:55:23 -0600, Nishanth Menon wrote:
> Thank you all for the detailed acks on various patches on V1,
> consolidated all of these with V2 and noted some missing acks below.
> Since it has been 12 days since I posted v1 and v6.8-rc1 is now
> tagged, looks like a good time to refresh the series.
> 
> As part of my 2023 LPC talk[1] about the difficulty in ensuring
> device tree is same across multiple s/w ecosystems, I mentioned about
> Licensing, and Rob had indicated that other SoC vendors have MIT
> license option that allows co-existance with Apache.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[01/16] arm64: dts: ti: Use https for urls
        commit: 01e886c4dfdacc2956d9857a3b5c985ea74e9ddd
[02/16] arm64: dts: ti: k3-am62a7: Add MIT license along with GPL-2.0
        commit: 89bd4c373649b81d4255d9c5a3e49d3fd10df708
[03/16] arm64: dts: ti: k3-am625: Add MIT license along with GPL-2.0
        commit: 7e614b5394f06c7ff5e9ef570bb1d40af08c6449
[04/16] arm64: dts: ti: k3-am62p: Add MIT license along with GPL-2.0
        commit: 20f8173afaac90dd9dca11be4aa602a47776077f
[05/16] arm64: dts: ti: k3-am64: Add MIT license along with GPL-2.0
        commit: 6248b20e3203c5f255efe6c330b5c871ca4e8033
[06/16] arm64: dts: ti: k3-am65: Add MIT license along with GPL-2.0
        commit: 2822c791af4d98ca469485dacde9ea4f13c905af
[07/16] arm64: dts: ti: k3-j7200: Add MIT license along with GPL-2.0
        commit: b87c44dd974e13aab1d0a9a01a5f94f1fe5fd1fb
[08/16] arm64: dts: ti: k3-j721e: Add MIT license along with GPL-2.0
        commit: 111f6dac6c08471888da49389f63174f3717bfbd
[09/16] arm64: dts: ti: k3-j721s2: Add MIT license along with GPL-2.0
        commit: 25aec8a64a2413f6b16e33ecbc0334bd7075ba49
[10/16] arm64: dts: ti: k3-j784s4: Add MIT license along with GPL-2.0
        commit: 33e089bd1e136f1e2c58e6b44455de55f4fe4bae
[11/16] arm64: dts: ti: k3-pinctrl: Add MIT license along with GPL-2.0
        commit: 67fdcf08cd76a7d81e64343b2f0730f554245840
[12/16] arm64: dts: ti: k3-serdes: Add MIT license along with GPL-2.0
        commit: 3feda6a0cf7d9a82d820032033ae7e600e9dca66
[13/16] arm64: dts: ti: beagle*: Add MIT license along with GPL-2.0
        commit: 380f1ffd281b6f33a6e03220921be2750c6fd8ce
[14/16] arm64: dts: ti: phycore*: Add MIT license along with GPL-2.0
        commit: 049010c9604f87568ae59ee5ea1b885ece19e6c6
[15/16] arm64: dts: ti: iot2050*: Clarify GPL-2.0 as GPL-2.0-only
        commit: c32953cf00a5ab9059483d825f866a528ad80460
[16/16] arm64: dts: ti: Makefile: Clarify GPL-2.0 as GPL-2.0-only
        commit: 1e6bbc5185bcd113c8d2f7aa0a02f588a6bdbe5d

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


