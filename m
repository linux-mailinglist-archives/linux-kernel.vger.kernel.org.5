Return-Path: <linux-kernel+bounces-160751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EDC8B4251
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0851F22160
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CDF3B781;
	Fri, 26 Apr 2024 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LmfqWjE6"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B5B38F91;
	Fri, 26 Apr 2024 22:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171394; cv=none; b=Kqqt3LApIhzREUAe2YU9XdhXd6vt7OfsOTIKNAhNJ75MKe9Aon9oFCKYYU3mIEN18d7IKg7n8XDx/B/UarixzYSn2aEYY9QaiMEo2vKoh9bL+v2sERqlaBUqCdpl4a0E5HAQcEB520Qhye02aV+qGXrpK7BfpadhhpeO2xF05/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171394; c=relaxed/simple;
	bh=f6sb0CgUdNHK9jZbYPBp5/UdQ4TFKx5Uk+8945hkT8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLqObZbJ6EO+PaHdZRsiuvQOJ4fpx7PsTItOM0AhnwLXfF/ok0EPLNj/sa26HOvr8bPVHhU46TqMhwz+2zTIocSGthbPul3jX0Lq3Ac46bwOsxbYqw7mzfXxxz8j78FaXj5tFi3GA0nMo7SVr+Tu2OR1ND2wu7liWyBnKyN2BDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LmfqWjE6; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QMh3Hi010100;
	Fri, 26 Apr 2024 17:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714171383;
	bh=GDPF6zI8yJzbEbGBTuLb4SqqRm/rvBSUCzBishxtq5E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LmfqWjE6YZKSg1BY1uQjYBm66eTtfh5JzcSOHqeQohxQ0fPP8yRsRn622R3KTKB5C
	 qK7hxljjrEA44jWzbAdVbKvEBsu3km8ftg8vZyLAr0RiVbhZoowzPikW5AU0G7zRa8
	 BgSmLRfohpORRM+ifyTIRX77Qfs19G8frZSelHFI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QMh3S2007063
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Apr 2024 17:43:03 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 17:43:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 17:43:03 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QMh3JM086800;
	Fri, 26 Apr 2024 17:43:03 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <w.egorov@phytec.de>,
        Garrett
 Giordano <ggiordano@phytec.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <upstream@lists.phytec.de>
Subject: Re: [PATCH] arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Add USB-C
Date: Fri, 26 Apr 2024 17:43:01 -0500
Message-ID: <171417137876.3485042.6733134851117347492.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240425152558.485763-1-ggiordano@phytec.com>
References: <20240425152558.485763-1-ggiordano@phytec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Garrett Giordano,

On Thu, 25 Apr 2024 08:25:58 -0700, Garrett Giordano wrote:
> The USB-C PD manages plug orientation, power delivery, and our endpoint
> for the USB interface. Add this node and include its endpoint.
> 
> Configure USB0 for role-switching and wire it to our USB-C PD endpoint.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Add USB-C
      commit: 3454b58dd9d99e317871e9abd57f589ae7580642

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


