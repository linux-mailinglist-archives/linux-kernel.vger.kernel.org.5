Return-Path: <linux-kernel+bounces-160745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE13B8B4242
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F360B21B74
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CF938FA5;
	Fri, 26 Apr 2024 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X8qRlx/5"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA7C38398;
	Fri, 26 Apr 2024 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171265; cv=none; b=TALdR22bF43GNGxY5ngtdgA9DNbdbBInd7u4cks637BlfquPcopDMNpzuLBLl9NNMYWWMc37Ky3Fss7nCbdLtrVYczh9p71ymdgsCwjeOtcwVqvQcaMhxEaicg3BC5iduW0JTBOAV4PhOtWKsgCwpdoWvrkF5WMliupXe43QpZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171265; c=relaxed/simple;
	bh=1qWfrTbwI9N7BbWSy50P/fZAPnGkaCiG+iAtqomjtrQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOKDJTIi9ANG7X5kZD3SVAiZRU/KJuE+LAXCYZuduKRDAPlzVUvVDbhO30lVDQdik+bVwVHqNqOTDskr/FuP4QnxeagU2LjGLkkmXVXkipEM5rC3dGVZxgdbuwaCvSad9T9H7bYvH32l04fH3ZGETmiiT1lyNI6RgiQNUAbrmmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X8qRlx/5; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QMenHB018164;
	Fri, 26 Apr 2024 17:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714171249;
	bh=zH2m7mms7hQ3H+fyOcr+kF1nqwVFHqlN/8tHzga4jQg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=X8qRlx/5Ia2CqCIucXTD4hFiQc2sApT5KMFO7cUsEk7YLbAzd8s2hkTnTim3VT537
	 N2ISUaoqjyr79S3Wa/geSjKxlS/P4w5+VBnXBV82LTGCcn45O+Clh3cObc6w7dwLdZ
	 gZXVVEqdOvIjZCDD/o+M7eNuYj/oH+YF5/YKdsGE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QMenkt075058
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Apr 2024 17:40:49 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 17:40:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 17:40:49 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QMenK4081734;
	Fri, 26 Apr 2024 17:40:49 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Nathan Morrisson
	<nmorrisson@phytec.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <upstream@lists.phytec.de>, <w.egorov@phytec.de>
Subject: Re: [PATCH] arm64: dts: ti: Enable overlays for the am625-phyboard-lyra
Date: Fri, 26 Apr 2024 17:40:47 -0500
Message-ID: <171417123300.3483372.8333985283029101154.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240419193552.3090343-1-nmorrisson@phytec.com>
References: <20240419193552.3090343-1-nmorrisson@phytec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nathan Morrisson,

On Fri, 19 Apr 2024 12:35:52 -0700, Nathan Morrisson wrote:
> Add symbols when building the am625-phyboard-lyra-rdk DTB so
> overlays can be applied.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: Enable overlays for the am625-phyboard-lyra
      commit: 5df0679a517edd3fc0784c415e0c47c8395ae213

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


