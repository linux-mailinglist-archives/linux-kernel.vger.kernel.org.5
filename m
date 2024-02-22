Return-Path: <linux-kernel+bounces-76598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC9585F9CD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6511C25054
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC321339B1;
	Thu, 22 Feb 2024 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bHzNZ0TI"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A450A98;
	Thu, 22 Feb 2024 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608578; cv=none; b=s+5hMLdcCnblNXGRNUO93J7SbR1zv94AsKQZ6/jv28isWKfF48cSyHZ+0JlWE1Dvad2yINDOT9JeZm5SI8JP+2njoUqWx+19nBcrHJQ8VVvWI8StPD8ZV/rcXqZKanNPydmpx2nehZm1sXhcW8+fL7gln5lOEVFXWkHCEN2Zo9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608578; c=relaxed/simple;
	bh=5O4K7q1IK/NjYK7WhiJ/eVnZEXOtS5drn8zpx1YYZg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWZc5pomHEIKlly5aEdk4P1DzUk9o3OFDKvJwsHDzjArhaMoyp0nf97gIHpvNzDz5X0z14XbDz0Z4w/UAHN6otOOOK0JrDarGJ1PTpvl/NXrE14Ltcmjt5/LXaV5zyEujbCGnCio1RfsNhP0uNLTr99AiQhFEjk7k4gBsJUrgsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bHzNZ0TI; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MDTOIU051313;
	Thu, 22 Feb 2024 07:29:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708608564;
	bh=/aXM1yR70nrbW0ktic0OxdjuUQY0IFYS5g44OXEYMrc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=bHzNZ0TItjC1RCegWIeDfp0oiYQyIL6AN66VMk+Gk33sTymag13pEOTfELydsFbo7
	 1JQF8xRSIYlW821A+CMsB+kS6LjV8SpDPkV971Qd6gBUifZ/JBWTgbiZ+3FBI9Oswg
	 zbWd8WLc3xUMLd5C6c6OzkAg9hAb5iMNg3pW0jys=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MDTO4K028337
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 07:29:24 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 07:29:24 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 07:29:24 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MDTKSa107922;
	Thu, 22 Feb 2024 07:29:21 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Peter Rosin <peda@axentia.se>, Andrew Davis
	<afd@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e: Fix mux-reg-masks in hbmc_mux
Date: Thu, 22 Feb 2024 18:59:17 +0530
Message-ID: <170860805561.1966114.12049702081667007759.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240215141957.13775-1-afd@ti.com>
References: <20240215141957.13775-1-afd@ti.com>
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

On Thu, 15 Feb 2024 08:19:57 -0600, Andrew Davis wrote:
> Change offset in mux-reg-masks property for hbmc_mux node
> since reg-mux property is used in compatible.
> 
> While here, update the reg region to include 4 bytes as this
> is a 32bit register.
> 
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j721e: Fix mux-reg-masks in hbmc_mux
      commit: 3d585389d454e147187684e492a0eb8f56adf311

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


