Return-Path: <linux-kernel+bounces-80527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38656866925
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D161C215B7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412A91AACC;
	Mon, 26 Feb 2024 04:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VBnhH1wL"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61FA17BCB;
	Mon, 26 Feb 2024 04:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708920532; cv=none; b=j084hKSrqg3PCLhp+VJWVQt7niWRTLqqQOB5QG0mh3pMf2nWVzq++4jfJhKo6Eg34zN07qe5Q+nunlcPIU0c4ISDH+oYlJSy56V1iu3Va0HFpHQc3EOVX+nFpJz5oVcm4lDTnD0tlxV2SeXIvDFaqosrbtbRSUv4uA4E70OKP2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708920532; c=relaxed/simple;
	bh=rsQz5L5aZrv7vU7jUeoF0dk6Ph1Eb0g/0gSx7i375GE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHG/Y+PXDNAWHZQjoUgR3f4V0GOc8ILcH5V/Fjh62sOT0fInUoc6+0hgPg1n65lD4AChuMIA13SnwPOZdeQov4//bbM/KQ+BCRy49X8nNl9p58a67/ZfcCaPvhrGHyhMC+wGMXYcs2OHlFNMYnNqXxrXsfdnv/T8WxmQmZWYOqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VBnhH1wL; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41Q48KEm068833;
	Sun, 25 Feb 2024 22:08:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708920500;
	bh=9/vGKxLqEvjlsUxXNsXq7LOSMLEoOfPXv9R6m7ZEntY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VBnhH1wLx4b2ITu7sFzw6obhzTNZZUCbANJv4Xv0w6+fZFxjK/pLaILLihFVCbjVD
	 2Q/3tkGHWjr3y4MT0jFKnz2gdqKK2aw9q0YJmeaB2oEKA9odEcieKHnj7k5u4EcQiU
	 a991dKakAktM5UgdyihqkKwaaoT2HxSGYK+J7dW4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41Q48Khi010991
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 25 Feb 2024 22:08:20 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 25
 Feb 2024 22:08:19 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 25 Feb 2024 22:08:19 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41Q48F3Y043562;
	Sun, 25 Feb 2024 22:08:15 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <peda@axentia.se>, <afd@ti.com>, <gregkh@linuxfoundation.org>,
        Siddharth
 Vadapalli <s-vadapalli@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <c-vankar@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v5] arm64: dts: ti: k3-j784s4-main: Fix mux-reg-masks in serdes_ln_ctrl
Date: Mon, 26 Feb 2024 09:38:12 +0530
Message-ID: <170860805561.1966114.575240163502689016.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240213080348.248916-1-s-vadapalli@ti.com>
References: <20240213080348.248916-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Siddharth Vadapalli,

On Tue, 13 Feb 2024 13:33:48 +0530, Siddharth Vadapalli wrote:
> Change offset in mux-reg-masks property for serdes_ln_ctrl node
> since reg-mux property is used in compatible.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j784s4-main: Fix mux-reg-masks in serdes_ln_ctrl
      commit: 9a0c0a9baa2d1f906589d715f9baeab93e7fcdcb

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


