Return-Path: <linux-kernel+bounces-54513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A4484B025
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B771C2484D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFD312DDBE;
	Tue,  6 Feb 2024 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sp5JWAf7"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D7B12D756;
	Tue,  6 Feb 2024 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208835; cv=none; b=P2KiXz8mUUNwqncgekwXaBaW0SLcAsYSMhR4WPuxgDdIFow2BrINSObNwGMaG1bhi4DoHKOvDvDe4UnGa0iJr8c/XSfoy0eE7s4oFrtftGZIWPpgrcz7GdVXdQDx1S9WzUwGopjNlHkmpqbQ3BtyKnuqPwV5Rdy7y2eVS0rqQ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208835; c=relaxed/simple;
	bh=87HzonWNI/onHhx0I58NR4L8YxFz/qriP6QiQsf0qGs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VNoluN+cz3aWqQKA47l7wcHcoqw/H2Q7Nm4ngiA/FI+fyYSXmOcJ3OUxd1PQTPJSvoaC5Nafo46l2luwDKOasYR1/sRgYxuCKImyJhwn+6JDrB7QmQVhEoxDYRRUEfS611bs9zj0qPrAVoOEXE5VM7JUCt5JCH5AjEmM+Vo2Pq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sp5JWAf7; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4168eKMR082341;
	Tue, 6 Feb 2024 02:40:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707208820;
	bh=CtmOygt1l5vJiRIsqFjaDxXD9YN6h/s8JKZkRtP0d1Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sp5JWAf7QKbtr5q3bYEZpBfOtr4h4SKS8jw6R3YlVdMh0HsLmQ/wAwnCbUJnJN8ME
	 1DBZzcXMgW/m4WBvmzyKQcAGrV4UD0Oicyk9ngzC/4en3B+/1VR8AiPh5T5bFTe2Nx
	 8igtgzX0Gs0NJhPAKV2owxSR5h8YHArMak1ULSK0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4168eKMn120629
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 02:40:20 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 02:40:20 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 02:40:20 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4168eGQE060052;
	Tue, 6 Feb 2024 02:40:17 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Apurva Nandan
	<a-nandan@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: Add phase tags for memory node on J784S4 EVM and AM69 SK
Date: Tue, 6 Feb 2024 14:10:02 +0530
Message-ID: <170719349981.2245010.15227162718815432967.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119171619.3759205-1-a-nandan@ti.com>
References: <20240119171619.3759205-1-a-nandan@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Apurva Nandan,

On Fri, 19 Jan 2024 22:46:19 +0530, Apurva Nandan wrote:
> memory node are required for bootloader operation on TI K3 J784S4 EVM
> and AM69-SK boards for finding the memory size during early boot stage.
> 
> So, align Linux device tree by adding phase tag marking 'bootph-all',
> which is to enable for all bootloader stages.
> 
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: Add phase tags for memory node on J784S4 EVM and AM69 SK
      commit: 28e4e3232777b6a00e483857fe9863f5adbcc10d

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


