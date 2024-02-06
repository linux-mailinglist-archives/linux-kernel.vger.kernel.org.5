Return-Path: <linux-kernel+bounces-54515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 844B284B02A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21857B22A36
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217F512E1E6;
	Tue,  6 Feb 2024 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DsiwZciw"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE71D12C537;
	Tue,  6 Feb 2024 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208872; cv=none; b=KwjMScGgw0brl/yTAYAZVaNXzTCJEVtZt3N5k2gH6pjx5UbOFrCuUKZ3dJqRHV+Fb92R1iTsLi9c72nkHaihKHeLJ/2LM++WT9FQZn0a7xEWC6I0WxB+0UL8lxoAkd7/cK0LVgWtFrLwgXT+8WtBCiOXyBVVk4/B+pJ1Jf7DGGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208872; c=relaxed/simple;
	bh=4SicKHSrRkIGWJ8E0Z7++sboIIerlu6s2MfFDejsO4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+17W6ado5KCJaXPe+rHdyhCvFrAwW+46cElqDA6NlKP5YGFxhGPgfMBJN/+dkkrumDTE4ORmvLwp3THvpOfUKRo8IFsjC8FT9sTf+hPVTcRsDbuxaBLuUgqwSqnWJrBxLpAunk/rEE9yblQfcAQSmuYYt0oJzJaUFKTsodYcX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DsiwZciw; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4168euTD072153;
	Tue, 6 Feb 2024 02:40:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707208856;
	bh=qHA8zoxT1AkM7zEWlLGwOinN0ZDK9F65bYI+Vh0kDeM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DsiwZciw7pmL1+EfKJuVwyv4oIaptRbY/vFkRYUHZ6h7dmwO1SOtldlmWtD+gzyW3
	 HeTqYC+necbS6IpEtXJgBWKbu5+T0v7vuvcyFGfTEZQ41z6ncF4Y7gMbLX/8gE78QX
	 tCaKmrQnjGU4zjtcWU0hubPEmm1pw+PRSIN5pMuo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4168eua8013088
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 02:40:56 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 02:40:56 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 02:40:56 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4168eGQG060052;
	Tue, 6 Feb 2024 02:40:52 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan Brattlof <bb@ti.com>,
        Keerthy <j-keerthy@ti.com>, Manorit Chawdhry
	<m-chawdhry@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v2 0/2] TI: K3: Fix the device IDs for VTM node.
Date: Tue, 6 Feb 2024 14:10:04 +0530
Message-ID: <170719349984.2245010.11811390979313823199.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201-b4-upstream-j721s2-fix-vtm-devid-v2-0-85fd568b77e3@ti.com>
References: <20240201-b4-upstream-j721s2-fix-vtm-devid-v2-0-85fd568b77e3@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Manorit Chawdhry,

On Thu, 01 Feb 2024 13:37:25 +0530, Manorit Chawdhry wrote:
> 


I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j721s2: Fix power domain for VTM node
      commit: 5ef196ed912e80a1e64936119ced8d7eb5635f0f
[2/2] arm64: dts: ti: k3-j784s4: Fix power domain for VTM node
      commit: e4d252e6d29208aea56d4c04270523e306b1e3c2

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


