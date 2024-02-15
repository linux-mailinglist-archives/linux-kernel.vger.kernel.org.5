Return-Path: <linux-kernel+bounces-66530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB10855DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016E81F25069
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AAF1759E;
	Thu, 15 Feb 2024 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LyqcKbe5"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6BC1B959;
	Thu, 15 Feb 2024 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989177; cv=none; b=KyWYBbfr4TTF+G+bAfAC/ICn6kow+svnkmlEegAs1F7UpejX+rb34I8wmta4owtkiXIzxyu2mF9AZvcXJvXMc+Rx47WuOVqahsWT1AheeYyyyM90cdjulouBSheOXTYUq9j6W4aKS2/Hk9pMSS2CCXM6Iiu7NyYG8d8vv1CQRXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989177; c=relaxed/simple;
	bh=GHNNkElN8VRk4BZPcs5hGVCSyB2s257EndfY9jm+ZzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGetxCn1nnUGurtwuJ4fT19+xyWwfkIbixxW8Z6PxMmqgbT7rhBIEilOLH0nr9W8DmHIzTOTxEXC9Nht8TtviZzDJ0HmEGKcz2Xycde46LcaHI6KMoWX2bhdy9AZ19/qlRAez2CIaXjBzW/KGb0wh48NwqYklid2a2xGghWnKTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LyqcKbe5; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41F9Q6N1083250;
	Thu, 15 Feb 2024 03:26:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707989166;
	bh=vxiwVjBRNQCCnMGzxi0/1CSQo0N0p50iwEtImMqNbmU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LyqcKbe5Hp+W8+9VWFflnIa0R8ErJ151yBnMussJKFySEUOHFZyIvCLCsIiVZ7Epu
	 3YhlruzT0WVBpYn5EJQ0ysAJhqUSn0lG2g3JQOMA2bZlr5iD/zj7bCbWXzi5SQ3aDf
	 bPOl5wMI6KphGoKah9Pb+lhG82YEIlh6+9Xep4Wo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41F9Q6lL105155
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 03:26:06 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 03:26:06 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 03:26:06 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41F9Q2wJ100261;
	Thu, 15 Feb 2024 03:26:03 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <nm@ti.com>, Romain Naour <romain.naour@smile.fr>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Neha Malcom Francis
	<n-francis@ti.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am69-sk: fix PMIC interrupt number
Date: Thu, 15 Feb 2024 14:56:01 +0530
Message-ID: <170798813443.1487216.13269796960509910423.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209171146.307465-1-romain.naour@smile.fr>
References: <20240209171146.307465-1-romain.naour@smile.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Romain Naour,

On Fri, 09 Feb 2024 18:11:45 +0100, Romain Naour wrote:
> The tps659413 node set WKUP_GPIO0_83 (AA37) pin as input to be used as
> PMIC interrupt but uses 39 (WKUP_GPIO0_39) as "interrupts" property.
> 
> Replace 39 by 83 after checking in the board schematic [1].
> 
> [1] https://www.ti.com/tool/SK-AM69
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am69-sk: fix PMIC interrupt number
      commit: 9673acae37ce06bebfe75b38c15952cab05da896
[2/2] arm64: dts: ti: k3-j721e-sk: fix PMIC interrupt number
      commit: 59974c38ded179cac63a3fa1a8adaaa1048cdc41

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


