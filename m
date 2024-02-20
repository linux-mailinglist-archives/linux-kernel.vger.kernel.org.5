Return-Path: <linux-kernel+bounces-72300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4833785B1C4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F9B28245D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9B053819;
	Tue, 20 Feb 2024 03:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EcoeHB97"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878E056B6C;
	Tue, 20 Feb 2024 03:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708401469; cv=none; b=lafRqAEEFSLUs3rbnJiTySiIV4yUPxQ5PliXbbUkviSpqbOa1bACNJftwkhEmxuAcl2Az/7pIJuPyenTfqB+7+TZSXY4lYQvasmLHLl2TYlIp5Mz5J1mJ6uAfjVJsZcHkzVEdcQDcn6+dRL9iUtKqrK61JB9REA/KezJIxOJ/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708401469; c=relaxed/simple;
	bh=d1B5na/ZbDwQeLGWjNDp5QwA1KGrsRmm2DlVOOe+DRE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYv7cAFVso8HFXhyG3o/wtvF/QD68RqQVRPjeo+ZGk+qGk4z/+5Xp54OimUcqpN8tN8IBTGIldEEaUpI/Jb5fsMXjt3vzrLDi8ridRdeyv4ZgiH05y6H2TzZKexwFixgLmq3I98li785XU72gaUsD1GfTjvsiGZoE1TQycYzcdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EcoeHB97; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41K3vg9h103029;
	Mon, 19 Feb 2024 21:57:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708401462;
	bh=Ng66aocc/WRYVytTbvZAXniHkI5XGrCluYb7Fj/bk4g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=EcoeHB97h0og0fk8GZSzAHmW8l9s9jg+EnxKA2/kK046nZ0C/OVmf4finYeBKR7Pv
	 jJJrN3piVjX4OMDzmoA9Xl/UPISauT6WQeXg6Mqt0Jru6RtxWvWPKEHMKSwwd31Qag
	 Jhh1nhqnxJUcbE412CTsVNOnESylWl0Gm4XwZgIU=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41K3vfLe031548
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Feb 2024 21:57:41 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Feb 2024 21:57:41 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Feb 2024 21:57:41 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41K3vcQI059769;
	Mon, 19 Feb 2024 21:57:39 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhavya
 Kapoor <b-kapoor@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/4] arm64: dts: ti: Modify pinmux for wkup_uart0 and mcu_uart0
Date: Tue, 20 Feb 2024 09:27:36 +0530
Message-ID: <170834878954.3471454.4988713452460973346.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214105846.1096733-1-b-kapoor@ti.com>
References: <20240214105846.1096733-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Bhavya Kapoor,

On Wed, 14 Feb 2024 16:28:42 +0530, Bhavya Kapoor wrote:
> WKUP_PADCONFIG registers for wkup_uart0 and mcu_uart0 lies under
> wkup_pmx2 for J7200. Thus, modify pinmux for both of them. Also,
> remove the redundant clock-frequency property from mcu_uart0 node.
> 
> Only Tx and Rx Signal lines for wkup_uart0 are brought out on
> J721S2 Common Proc Board and J784S4 EVM, but CTS and RTS signal lines
> are not brought out. Thus, remove pinmux for CTS and RTS signal lines
> for wkup_uart0 in J721S2 and J784S4.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-j7200-common-proc-board: Modify Pinmux for wkup_uart0 and mcu_uart0
      commit: 566feddd2ba5e29d9ccab36d6508592ae563f275
[2/4] arm64: dts: ti: k3-j7200-common-proc-board: Remove clock-frequency from mcu_uart0
      commit: 0fa8b0e2083d333e4854b9767fb893f924e70ae5
[3/4] arm64: dts: ti: k3-j721s2-common-proc-board: Remove Pinmux for CTS and RTS in wkup_uart0
      commit: 28e5b74d524050008edf415f20a3e38907b8f176
[4/4] arm64: dts: ti: k3-j784s4-evm: Remove Pinmux for CTS and RTS in wkup_uart0
      commit: d29a6cf980572d8cf7b63935716fca663e2610f0

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


