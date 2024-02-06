Return-Path: <linux-kernel+bounces-54330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341BF84ADBC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673C91C2300A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878DD7A723;
	Tue,  6 Feb 2024 04:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GFjPN5fx"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7837A717;
	Tue,  6 Feb 2024 04:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707195398; cv=none; b=MepZfYJ5FYJ7l8ENJ1HLBf3SJwEFcO32gKryTiTe7KlVi8UuIm2xGJzxsMOst4JqCmNBX2cwAEIolyiAItzzHew8gCVFSH/gU1XAM6GzKDns/OeLiyswCbjpyUK95zcJA3CsHtwXa8lcpTSw6UO9h0Q7cI48EuYvf3LyX+cRdVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707195398; c=relaxed/simple;
	bh=NnPw6mvP/VB8UpLRC8XMPV9oMyheCzH1T0rxj01LA2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UuHAHWmuoXuLU+Fk2U2BGE7AoIVAPInKaZD6Oo62IaS6VycQ4jaGWKMUSF9ZC/XcuI40z07oLTuk+l+aISqWUtkhGomFREAUXDRZVDiAX7IOWMqztF6u3yPKOjJHrXJsKYMtnEmfFnvkJpfUWZ1hAts/Wx7Mo2gJYFr2sKC5LJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GFjPN5fx; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4164uVDO023136;
	Mon, 5 Feb 2024 22:56:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707195391;
	bh=XpyZjwViMGROJ6p2FDtValaqDMAeg75JuE5DxuTdHpk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GFjPN5fxSAXj+yx4TSu/fP8NAS8qD+GJIkiv+LzimDjQK9PO7i3dajqM3DybCkCsS
	 9/WjKmM/7lOO8xhHN9QCaG5Gu7sjvewaAbKKVNMoRybeE23jr+lNvFDhL8jHXckNtj
	 GcrMyM8e4B+aqLGkmJTPg9iQRFsor6pAjHhSx1K8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4164uVSr127057
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 22:56:31 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 22:56:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 22:56:31 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4164uRxB002383;
	Mon, 5 Feb 2024 22:56:28 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan Brattlof <bb@ti.com>,
        Jai Luthra <j-luthra@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62p5-sk: Enable CPSW MDIO node
Date: Tue, 6 Feb 2024 10:26:25 +0530
Message-ID: <170719349983.2245010.18430004394937215893.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201-am62p_cpsw_mdio-v1-1-05f758300f6e@ti.com>
References: <20240201-am62p_cpsw_mdio-v1-1-05f758300f6e@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Jai Luthra,

On Thu, 01 Feb 2024 18:13:53 +0530, Jai Luthra wrote:
> Enable the CPSW MDIO node, and link the pinctrl information to enable
> ethernet on SK-AM62P.
> 
> Ethernet was unintentally broken on this board, even though these nodes
> were already present, as enabling them was missed in the original
> patch.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62p5-sk: Enable CPSW MDIO node
      commit: 8839a9af397e803e0447a6b3e69fad54ed22d26d

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


