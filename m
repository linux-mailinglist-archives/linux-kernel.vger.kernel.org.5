Return-Path: <linux-kernel+bounces-71396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 284FD85A486
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD20FB21C67
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9453536132;
	Mon, 19 Feb 2024 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E1QGrYw8"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2195536118;
	Mon, 19 Feb 2024 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348846; cv=none; b=Wz7dZLjVWFD5sMp1Dn5RO/Rjz5ADVj77ikTE0ALG7f0qOj/52zvelnOoPNSDw6HHTNI4OUX5txr+z7aplPeTGhNTyR+WjXRFV9so//bvmudc1OjbnhSn1o1V+QPKTIrOzR+ZiBgO9ul9YO34X+hQXISgDapn0mFLIBBp64tpYAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348846; c=relaxed/simple;
	bh=KNb0KK+q8cVZ0ApPaQM11/OWeLMxQLjSnB8wr3hcRM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szUi3ApnWGUobcSSIFgvS9vpnyhwAH/rC2m+KFX7Xw+ehHxYYLT9MjGFKbEtodayiiHr5UPV4s4tE/MiHsHLSGcRYz9r7yHaZi5Zju8e4XJWuQkePYH/OCnWMzi3wjJxDjc12h37dyqG6gav13jcz20hYmH7oEIJIZvMv3Nyztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=E1QGrYw8; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41JDKWsq008361;
	Mon, 19 Feb 2024 07:20:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708348832;
	bh=M0uNNQWLLHnv3ooGLreNOREbGeGPXAw3YOkIrOj8EYQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=E1QGrYw8g5mUiZtTdhp0jn2+yRHVqL3sTnMGjtWFskO8/UBvw6B+ctnwQj5XgxkmY
	 VbL2l3m/kSWgw+HrXPE7DKn9Z39MkY6GhjfxYq7X3Jb2sEDk3vwE0aWNYxMPVcrN6A
	 NBWoi11bprC0jUcV8jiN3WROuUp6mjC0Ijj2reXo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41JDKVGw037512
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Feb 2024 07:20:31 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Feb 2024 07:20:31 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Feb 2024 07:20:31 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41JDKRZm125092;
	Mon, 19 Feb 2024 07:20:28 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <huaqian.li@siemens.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jan.kiszka@siemens.com>,
        <baocheng.su@siemens.com>
Subject: Re: [PATCH] arm64: dts: ti: Add reserved memory for watchdog
Date: Mon, 19 Feb 2024 18:50:19 +0530
Message-ID: <170834878953.3471454.17341005022396223551.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117060654.109424-1-huaqian.li@siemens.com>
References: <20240117060654.109424-1-huaqian.li@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi huaqian.li@siemens.com,

On Wed, 17 Jan 2024 14:06:56 +0800, huaqian.li@siemens.com wrote:
> This patch adds a reserved memory for the TI AM65X platform watchdog
> to reserve the specific info, triggering the watchdog reset in last
> boot, to know if the board reboot is due to a watchdog reset.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: Add reserved memory for watchdog
      commit: 14a65ea5fee71d716d246b8cc494a95bc9924306

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


