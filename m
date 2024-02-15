Return-Path: <linux-kernel+bounces-66549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AC5855E38
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843841F21241
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB01B1798C;
	Thu, 15 Feb 2024 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lQcq1RfB"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B427E11183;
	Thu, 15 Feb 2024 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989513; cv=none; b=o5IaHRiKlRdQm9/azVO+JFHxj8flkfcCvtMuA3nBA+1YrboFAgsqO7qdnEC3MGPhmjRxwObmcGm3GP3wWQQ4s5Z+0Zxc7matyGWSv54DdYZzZ52xgTYVS1cbI8PtvPx4zA6/Z7pRPOotxeVguBxDeagRqrJJZRjebGW05y5GYxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989513; c=relaxed/simple;
	bh=stbk1sWPU80W9C9s74JYSqqOogHY86Bot5Qlgdi6Wzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=laTHt5MhP5XcEvu6uulWBjoT7wLhvOPsgZ0w0uU1/kqkuGBcAsGlC8K2SqwAj+XkEM4xGl+PD+XQJuHDy/QPhl2FvNBko8Zxf8QopvpXfy390XJirEdtzax/w1iDaJDQH42Mn7jbeNvhaRx3tSmjTsaDR3tovSazKeN8y69zlS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lQcq1RfB; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41F9VfCN084218;
	Thu, 15 Feb 2024 03:31:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707989501;
	bh=zWfPTOHpDzxKfjOUZ1ZIKz21Hyle0zixW/xM+KWrTMc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lQcq1RfBd4jswVXrVdHF7mwX5NT2tg4UDp3Kby/3Vjkqy9KKxI7cp4xKfWPfJMzO0
	 CpnU6P0e2x+h++gJ9EjcpYlXrW3oJqRf3ei/+sTkiTxiw2CdY9/4BKlWgdgu+UWoYL
	 fN7uA9se5F3tBZoSBo5eyhWtc5dx5fpq4DdhRmP0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41F9VftQ111489
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 03:31:41 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 03:31:40 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 03:31:40 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41F9VbvN109135;
	Thu, 15 Feb 2024 03:31:37 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Andrejs Cainikovs
	<andrejs.cainikovs@toradex.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: verdin-am62: add support for Verdin USB1 interface
Date: Thu, 15 Feb 2024 15:01:29 +0530
Message-ID: <170798947718.1512489.5264967357166684685.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209130106.38739-1-andrejs.cainikovs@gmail.com>
References: <20240209130106.38739-1-andrejs.cainikovs@gmail.com>
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

On Fri, 09 Feb 2024 14:01:06 +0100, Andrejs Cainikovs wrote:
> Add support for Verdin USB1 interface, implements role switch
> functionality using "gpio-usb-b-connector", VBUS is also now
> controlled with "regulator-fixed" using a standard GPIO.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: verdin-am62: add support for Verdin USB1 interface
      commit: 5125c19d75d8d9609dbcca1201f393fcb3b41c1d

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


