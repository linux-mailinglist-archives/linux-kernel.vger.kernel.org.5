Return-Path: <linux-kernel+bounces-66573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0585855E77
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D55428B52A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C586A58AC4;
	Thu, 15 Feb 2024 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Wl3Y/x3J"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8627B58AA4;
	Thu, 15 Feb 2024 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707990386; cv=none; b=EqWBJlNPaixhicyHeBuIGipSMPnoivHgfPTmIICw5/XdBkp7Xdo1Elo+/jxgf7Abra/n2DVFfIa2DqR4bzt8r/Dj+VwX+X25iM9fyE7RjKbrXgxQEAW30T/aK64FXV7yL9iukXHOe3B8sw+Nog45f9UUuYMXW2vsiKV0ENAiYSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707990386; c=relaxed/simple;
	bh=m7HjE3gAIDiXIS1ZaeL2QN44pLxesvU8VZZHmb2N7pQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/wXxMFGGVPgI4LgalDgOCUX0h4SdtkkZeFHP5oQVcgswyTipqtJD7QuEiqEHvU8i7cyGe43nPPZeyGsfUp3lONVgYrUrU2Xj8Q7z56bY18SXfLSjS5i7dlKhktJzaap39P6TXYs4dYN0zXoSXoe+Jvh6+cCEzctWoCDvHf8pXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Wl3Y/x3J; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41F9k7ln086992;
	Thu, 15 Feb 2024 03:46:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707990367;
	bh=Bbs6Kf6AEMDgIsTNm4jANFNwHRYod3wkTlwK7cFL2PQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Wl3Y/x3J+A/vz4+5Q/GB0oCN+3sGeFBpOnAddbGz0wzHmmKw1MfE08B81eiG+nGS1
	 l5q1XrxD0e655QYaU/atK2JQFr5vIvg4/mtHzkyw/JeHXAbg+isjvJrKVIMubMy1in
	 NzohO+HG6EcdBis95tKN7r4KJQu7y/yqcf9kAPKE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41F9k7BH003508
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 03:46:07 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 03:46:07 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 03:46:07 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41F9k35S129651;
	Thu, 15 Feb 2024 03:46:03 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Sjoerd Simons
	<sjoerd@collabora.com>,
        Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Andrejs Cainikovs
	<andrejs.cainikovs@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-main: disable usb lpm
Date: Thu, 15 Feb 2024 15:15:56 +0530
Message-ID: <170798813445.1487216.9575227386692519157.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209130213.38908-1-andrejs.cainikovs@gmail.com>
References: <20240209130213.38908-1-andrejs.cainikovs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrejs Cainikovs,

On Fri, 09 Feb 2024 14:02:12 +0100, Andrejs Cainikovs wrote:
> AM62 USB works with some devices, while failing to operate with others.
> 
> [  560.189822] xhci-hcd xhci-hcd.4.auto: xHCI Host Controller
> [  560.195631] xhci-hcd xhci-hcd.4.auto: new USB bus registered, assigned bus number 2
> [  574.388509] xhci-hcd xhci-hcd.4.auto: can't setup: -110
> [  574.393814] xhci-hcd xhci-hcd.4.auto: USB bus 2 deregistered
> [  574.399544] xhci-hcd: probe of xhci-hcd.4.auto failed with error -110
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62-main: disable usb lpm
      commit: 576ad1d1d8b12a632598f7963d640f9422781f9a

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


