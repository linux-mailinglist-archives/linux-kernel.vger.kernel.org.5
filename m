Return-Path: <linux-kernel+bounces-160746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC3B8B4245
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DEED1C225B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0263F3987B;
	Fri, 26 Apr 2024 22:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pBDOlR+C"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1F22F2E;
	Fri, 26 Apr 2024 22:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171280; cv=none; b=E3pgKajtfAWvG9TfTdCH0fyy7IGEli1J5YkSo5t7YP/pRmyjQQ4V9tYakFe+h1X5kkncPnwlu+OHx+DFzsoey/3UFWNcZLqMLdUUOYduLTON+hbGTfH+6L2bS2k76iJGk8YrOrihHH3y7Tq1OkHCpNWdFtUrJ+lrWtyVRpSClXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171280; c=relaxed/simple;
	bh=3S/Bgu4pFsqqUh0PQfkbAdHv5KqsmFaZ46aiABI2XzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4sYG/z6neVQCrqy6izKP7PwxL1ElPtldED2MQxR0w+fIs6tSLuRLFkqSgOvqkfi+d03fXR2qDcWfVJoDADJIyw7gxA9w+Eg7eRq6OGYUtrbqRvvUpU/eWXOE+0xUZwKYdIaP9Kv8/RALu9Tzk55BzGFPHxKL+WbBhik0GU9Gbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pBDOlR+C; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QMfCV8028500;
	Fri, 26 Apr 2024 17:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714171272;
	bh=GcWA1fG+bqKbhNw3/azwxVIcyfkYBtfi3IKEWV+dkX4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=pBDOlR+Cd+KpC7ShinDrS2qFx3Lz+EaR/599AKVJT9KmzNRe5QWxeQ6jB1sXl3hfB
	 wvbpsV+E7fDCSIKtbHNYFR8gswFPzqX5cQ85dxqVVeOPOg0yLg7FKBxbyKNqaepZRb
	 VpfGTRV5L8PCHGmNZNahoJwPfLrrYprAtH/f5OpU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QMfCGe005947
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Apr 2024 17:41:12 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 17:41:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 17:41:12 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QMfCKn082387;
	Fri, 26 Apr 2024 17:41:12 -0500
From: Nishanth Menon <nm@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bhavya
 Kapoor <b-kapoor@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s-evm: Enable UHS support for MMCSD
Date: Fri, 26 Apr 2024 17:41:10 -0500
Message-ID: <171417125616.3483508.7388884169867255963.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422131840.34642-1-b-kapoor@ti.com>
References: <20240422131840.34642-1-b-kapoor@ti.com>
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

On Mon, 22 Apr 2024 18:48:40 +0530, Bhavya Kapoor wrote:
> Enable the UHS modes for MMCSD in J722S by removing the
> no-1-8-v property.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j722s-evm: Enable UHS support for MMCSD
      commit: 0fb3e2ff482c668a4cb2ae9eb85b623d954cc900

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
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


