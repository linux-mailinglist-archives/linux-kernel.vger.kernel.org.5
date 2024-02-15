Return-Path: <linux-kernel+bounces-66521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04390855E10
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14D6CB30096
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBFD17756;
	Thu, 15 Feb 2024 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QDlIiS9V"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4A17730;
	Thu, 15 Feb 2024 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988955; cv=none; b=GeC2GMEgHa6Np2pS2Fuju9KS3AtFoVIaoKsrDwy8+KPwzcwwrzbOJwCN39kwvfEps8+rjFA8mrKfIf+XTSn7Xk8ZZ5KRHusVQPaNvR3muS5rC3o3a8sTQ1C9CL/ZNQZh9UyT+viWbokFPKYB5/of91zyAdMkqBXo3UJdcC1X+Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988955; c=relaxed/simple;
	bh=OULdzMWgxfFFg9LRf6bcSMGbltqVRUYec/PuCMqih6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7Qp/d2onj1+cGG+I+j1pBK6tvsxDssqVdcJJ8hkvhnNupgFXMP8jJOqnq33nXn9Xcv7Ld5N2DUf+EaRt7adrx+OijaPy5W8hrTBBNQb3TkzRFBPef94PnQ73esrTAOmfvp/UgTezcO6jrPTz1e0/HdMLODSyhgfX2MA2ZPo654=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QDlIiS9V; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41F9LoQt095990;
	Thu, 15 Feb 2024 03:21:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707988910;
	bh=xCLD175GRPHiHDl/Ut7lhjopF0rR8HNYuLJPwOGdpOI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QDlIiS9VxsssxRW7nUXSxvUtKTPMhPWskGfJy8z/TyzSELBfc9PM+5jrBxFtFf538
	 +0RHv0zUT/d3eKe+CcH/CvxbOFa4nbOZo7p2wdr37W5V7UGbDEGAnloTNxUHhwmNwo
	 F5PBgiDQ5PoAmhaNSwf5agJJezpvcC+krgjFTlnI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41F9LoxI058910
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 03:21:50 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 03:21:50 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 03:21:50 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41F9LlST094738;
	Thu, 15 Feb 2024 03:21:47 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: (subset) [PATCH 01/11] arm64: dts: ti: k3-am64: Convert serdes_ln_ctrl node into reg-mux
Date: Thu, 15 Feb 2024 14:51:44 +0530
Message-ID: <170798859433.1495814.14458901296374501325.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124184722.150615-1-afd@ti.com>
References: <20240124184722.150615-1-afd@ti.com>
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

On Wed, 24 Jan 2024 12:47:12 -0600, Andrew Davis wrote:
> This removes a dependency on the parent node being a syscon node.
> Convert from mmio-mux to reg-mux adjusting node name and properties
> as needed.
> 
> 

Dropping 2/11 as indicated. Rest applied.

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[01/11] arm64: dts: ti: k3-am64: Convert serdes_ln_ctrl node into reg-mux
        commit: 91e93fdae6bab038f5913f766a9640371f9c630a
[02/11] arm64: dts: tidd: k3-am65: Convert serdes_mux node into reg-mux
        (no commit info)
[03/11] arm64: dts: ti: k3-j7200: Convert serdes_ln_ctrl node into reg-mux
        commit: 80d835defb8c9c696be35d86cb7949e5e7c0f1f6
[04/11] arm64: dts: ti: k3-j7200: Convert usb_serdes_mux node into reg-mux
        commit: 6b52caf93289a0f0f9980b7d21a5ae376c2afe8e
[05/11] arm64: dts: ti: k3-j721e: Convert serdes_ln_ctrl node into reg-mux
        commit: 4cd6d56c3c81e31aba3d69a6cf872770e8945dc7
[06/11] arm64: dts: ti: k3-j721e: Convert usb_serdes_mux node into reg-mux
        commit: 62b19a64e121e9ce081d18a77436a846585b9c7e
[07/11] arm64: dts: ti: k3-j721s2: Convert usb_serdes_mux node into reg-mux
        commit: 6b3a4da3ed71473126036c363261c5f1271e8e51
[08/11] arm64: dts: ti: k3-j721s2: Convert serdes_ln_ctrl node into reg-mux
        commit: 0985bf59052fbc932ff05ea760c8d177f390f20c
[09/11] arm64: dts: ti: k3-j7200: Make the FSS node a simple-bus
        commit: 3829ee48a4c44c28e397859c8df1d9e2ed7c5b3b
[10/11] arm64: dts: ti: k3-am62: Make the main_conf node a simple-bus
        commit: 3f6de97ee917ddabea8dcfab315fa6806cf7f230
[11/11] arm64: dts: ti: k3-am62a: Make the main_conf node a simple-bus
        commit: ad163bb36344f0432d8aee48553a17997b926c29

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


