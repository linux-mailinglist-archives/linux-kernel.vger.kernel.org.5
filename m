Return-Path: <linux-kernel+bounces-61223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 608E3850F29
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BF6280E61
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97241FBF5;
	Mon, 12 Feb 2024 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nkJ/dGqi"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FD67489;
	Mon, 12 Feb 2024 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707728059; cv=none; b=vDdsZ0eM7UlEvodEu1er6sd2mY5d0UulYSjYOsxBA0mE/oFFJRon2PgDB/ALTzjvBFmOU+BiPs3fDfe8dayNrEQ4H1AyCcrRKOhj4SvGyubHBS1w4lmpRF0eFX92odNxBOdgVaG8z/mzFZjV6aPDAcn9Io3W1Iyy7bjA57yJu4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707728059; c=relaxed/simple;
	bh=Icz1i3w5C5PCoCJWhEx8Q4ARzAXbRLcRLO4H+Tn6HBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogchQrmz6UewpqrPMKphcz2x96GVzTq8riIiMoYlolyiGJ01bmFwI2Wb+T2+gu8Wrg2WZmkzNv0ryRD4bXX4i6tJJRcwWXL9SDFMWeeG88CSWvy3rV2ipOyazeUagya3fFaGgwheWLM2BauBCybz8Gn1vCRMz+/hmOakIBhFOwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nkJ/dGqi; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41C8s87K095299;
	Mon, 12 Feb 2024 02:54:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707728048;
	bh=XEnHiguWpWLJO7Gkrsj0u16xJ6oLhMKb7JAitQWrolo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=nkJ/dGqi46XzR9y/9V5gpzpTK/rWy1psBqudV3IEjB5TkWlOvC5KTI3eHoRvXOX+z
	 ryzaqoHGKoGci/QjDm9PW2dPgm5B/86g25PQptKiSM3AArmBX6trUiAgm+LaLckZnn
	 8hVpjvLS+ptdKOJbkBq1GEjoH2Pt0a3mWXaX+IA8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41C8s84b085118
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 02:54:08 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 02:54:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 02:54:08 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41C8s4oj091102;
	Mon, 12 Feb 2024 02:54:05 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Aradhya Bhatia <a-bhatia1@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Devicetree List
	<devicetree@vger.kernel.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List
	<linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>,
        Devarsh Thakkar <devarsht@ti.com>, Jai
 Luthra <j-luthra@ti.com>
Subject: Re: [PATCH 0/3] arm64: ti: k3-am62a: Add display support
Date: Mon, 12 Feb 2024 14:22:36 +0530
Message-ID: <170772794559.2674561.13954046137471686164.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201125452.1920623-1-a-bhatia1@ti.com>
References: <20240201125452.1920623-1-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Aradhya Bhatia,

On Thu, 01 Feb 2024 18:24:49 +0530, Aradhya Bhatia wrote:
> This patch series adds DT nodes for Display SubSystem (DSS) and other
> peripherals required to enable the HDMI audio and video on the
> AM62A7-SK EVM. An HDMI monitor can be connected to the platform for the
> audio-video outputs.
> 
> Regards
> Aradhya
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-am62a-main: Add node for Display SubSystem (DSS)
      commit: 3618811657b31090da08a0c4bcd9941102b5456f
[2/3] arm64: dts: ti: k3-am62a7-sk: Add HDMI support
      commit: 396ca2fc736b0b3c6f738408e9a3e82d86b62d49
[3/3] arm64: dts: ti: Makefile: Add HDMI audio check for AM62A7-SK
      commit: cff6dd01a68fe9a8aaab724ef4e21f37eff609e9

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


