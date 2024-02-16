Return-Path: <linux-kernel+bounces-68107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF3D85760D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBD01C2209B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E1912E5D;
	Fri, 16 Feb 2024 06:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S6ZSo4/3"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F03A8C05;
	Fri, 16 Feb 2024 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708065104; cv=none; b=W3AjPOFl5EJJkEQZ+lmMG6IEjoVI1xpczaBDI4cwIHPrXAdS0OxXHaI8Pb9Ton/AM5AajIRwPBUZwrSX+hwebnRwrnN6Epi+lKoDYJ4hO21XLrjnA4gt2A+2VJ1Wo2+rhsqrUevCojF/++wOf2oGCP5ylXDnJnIs/I/tyG/cdIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708065104; c=relaxed/simple;
	bh=HxAVdyWDicoKYG0jnt1F+soDboQQfJbyVwmTA3Jdp6s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/66z+tumgucRESpkhBo6pldO84H47uMF1rafytZGby+fONS586TyGgkRmT57pN9ShgGZRO8u06/B/4O57hblaOduO4U7rTnLAF1URDbHvZlcH+rR1IqIH3S4Ozc1Hh4oEsR//sqv/bz85Hp3XEqmXN7z0Rw51Xl838ynjz7QHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S6ZSo4/3; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41G6VZG7004212;
	Fri, 16 Feb 2024 00:31:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708065095;
	bh=JO1djsgcc/AA1bUDnNIRAettyxfLzQegZEnJu34iTtQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=S6ZSo4/3WydV8PShQbE8OHhihY+xuINOBdF6A3G9OwZ/3BnX0YUXtdANABehie86M
	 a/GSEhuSQDOG/ERrNg/GTdni1xZePGi64u7ZHiXlh8o+2/E4iiky60UJB71jiJ7eEF
	 JBh3PbHWCkj/lfkQGoRLILUG4JjIuF//cWzR/qrI=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41G6VZDQ010637
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Feb 2024 00:31:35 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Feb 2024 00:31:34 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Feb 2024 00:31:35 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41G6VVxj051744;
	Fri, 16 Feb 2024 00:31:32 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        Vaishnav Achath
	<vaishnav.a@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <j-choudhary@ti.com>
Subject: Re: [PATCH v2 0/3] arm64: dts: ti: Introduce J722S SoC and EVM
Date: Fri, 16 Feb 2024 12:01:29 +0530
Message-ID: <170806504068.3877215.8092202742138440785.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206100608.127702-1-vaishnav.a@ti.com>
References: <20240206100608.127702-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Vaishnav Achath,

On Tue, 06 Feb 2024 15:36:05 +0530, Vaishnav Achath wrote:
> This series adds basic support for J722S family of SoCs. Also add
> J722S EVM support with basic peripheral like MMC and UART.
> 
> TRM: https://www.ti.com/lit/zip/sprujb3
> EVM Schematics: https://www.ti.com/lit/zip/sprr495
> 
> Bootlog (6.8.0-rc3-next-20240206):
> https://gist.github.com/vaishnavachath/23d859925277df9ccd628190e7c23371
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] dt-bindings: arm: ti: Add bindings for J722S SoCs
      commit: de82585f62e08283572d385d0cd6b57893a99d1c
[2/3] arm64: dts: ti: Introduce J722S family of SoCs
      commit: ea55b9335ad81e32f2833c71b2dcb591792e54dd
[3/3] arm64: dts: ti: Add support for TI J722S Evaluation Module
      commit: 2f277dbe1a4ac40b1157ba3b2914d39f4040bbed

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


