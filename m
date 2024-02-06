Return-Path: <linux-kernel+bounces-54324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F56684ADA9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C580285E24
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0BB79DB8;
	Tue,  6 Feb 2024 04:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="czmyYm8R"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB4E78695;
	Tue,  6 Feb 2024 04:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194570; cv=none; b=de87jPuly3c7OWXA9D4pE8ARv8lBjOc3hZhTPVdzQREWowE428TwXdq/7bCZc6Ef2KQxn7b9R7jOfYRU9eUa2gA5yHNMJkhGsPlTEUTDzkipXOUUBzKq5nE/vvyEbn88bppeQD+aaOkLdutV706sGvislKwVXtDpLul0sCCwaso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194570; c=relaxed/simple;
	bh=H659Nd+hbWqbyN+BEkToWvpZgNTvDtbbNyHLofTklT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrJeLh0lslkaCLE9ysg3HClxVTySlAraUvNlsmzcw/sKX4L/3E1M2lekYliBOWHoV2b7JF/slnvq3Ti76y83Sn7G8sFBC4f84Vjfq4mel0lZjlIFsMxssNwa1NeNHcVkjMwTZa6vf4LWIqdl44JmaV0kJkS0YDwjPKRGQzToWLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=czmyYm8R; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4164gb5M025329;
	Mon, 5 Feb 2024 22:42:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707194557;
	bh=14U0i7f6xClfeVWt++SyF0sOz0n1VyqN8YCHQtLViQ8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=czmyYm8RZHytpqn2IRx1L09ZXv6AK8c9y3DPQwzyrXnUGIClm2YOBTC2Dc7v1TjA5
	 OL4fWwjghEbLRHTFBEgNwtxcXqj3DX8zrmucWwlyWIq4WQ/SV2UgPtXh8opXHDxBK6
	 zbB/gOrSnQccwtI9ggSF20eEIgutRbRKzXPSuxKM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4164gbSx116926
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 22:42:37 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 22:42:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 22:42:37 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4164gX7k100900;
	Mon, 5 Feb 2024 22:42:34 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        Wadim Egorov
	<w.egorov@phytec.de>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-phyboard-electra: Add TPM support
Date: Tue, 6 Feb 2024 10:12:28 +0530
Message-ID: <170719349981.2245010.3337630647469226018.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123102921.1348777-1-w.egorov@phytec.de>
References: <20240123102921.1348777-1-w.egorov@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Wadim Egorov,

On Tue, 23 Jan 2024 11:29:21 +0100, Wadim Egorov wrote:
> The phyBOARD-Electra populates a TPM module on SPI0 bus.
> Add support for the Infineon SLB9670 TPM module.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am642-phyboard-electra: Add TPM support
      commit: 742b9732e88a0b0d24a4cffd8aaa343a2aee6683

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


