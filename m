Return-Path: <linux-kernel+bounces-90666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DE18702E2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A3D28B0A7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6119C3EA9F;
	Mon,  4 Mar 2024 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b/bY7CxO"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9053EA94
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559541; cv=none; b=AfTaBmiOfDFP9+iDmH4h5mP/H4bMOz377By+sFTgCM/TNUoeeHSsxTKFa2dTR5+lk0qAz8sHgZeehZKy2bH+7iqpkeCYEydg5kk9wFMkSK4Xr/kMfZllxiWSn7C3p+K93e4hW7fW0eWyY49Z5dcMr8tccqUGkP9HtfokyrqJkuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559541; c=relaxed/simple;
	bh=eRJqtxF/hnl40Ku/oGPxOBYU8XPkZX8uhlixcF9S1Ug=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qd0DPaKyNRBcvGdNv1sgZm/b4TNoNk9lHFwCjVqWa2H5dycpsg4T5to5iRwwsd6IUFL3TMMfvzYvJFL2gYd1JDVTIC05k8Knvm4+Pz+jhT6FFcy58X/X+EJBYaygpihFSne91rBWMPAmc2bHwNeW6ZxHW6qlXgfYsbj9o29ipTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=b/bY7CxO; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 424DchRg000574;
	Mon, 4 Mar 2024 07:38:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709559523;
	bh=kKqIu5RN4fHPUy9UGlC6mcF827/TZjj39JVabv7mJP0=;
	h=Date:From:To:CC:Subject;
	b=b/bY7CxO+ZxhPJnV1G5vkg+5DNb4zTgF4TD3mz+lMPL5f/bWII9znMJNns2TxvXRG
	 g4hv+C3wkGeWMWCOJX7DuWTo9ft3qMN5UFSHsTEKPisHeisz9fNnw7WOqL8NS97wwe
	 gzYDdvEIowm4V4ITWanZDH5Ehh9qvdaD5MFsJfM4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 424DchEq013635
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 4 Mar 2024 07:38:43 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Mar 2024 07:38:43 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Mar 2024 07:38:43 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 424Dchvu044462;
	Mon, 4 Mar 2024 07:38:43 -0600
Date: Mon, 4 Mar 2024 07:38:43 -0600
From: Nishanth Menon <nm@ti.com>
To: Arnd <arnd@arndb.de>, Olof <olof@lixom.net>, SoC <soc@kernel.org>
CC: <arm@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony
 Lindgren <tony@atomide.com>
Subject: [GIT PULL] ARM: dts: ti: keystone: Updates for v6.9
Message-ID: <20240304133843.e6rm5va6w4oavgoy@posted>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Arnd, SoC team,

Apologies on a extremely late PR due to unavoidable personal
circumstances. This is very minor change, and would be nice to have in
v6.9. If it is too late, I can carry this forward for 6.10.

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-keystone-dt-for-v6.9

for you to fetch changes up to 11621bedc016578e0b025b6f23458e9fe3f3caad:

  ARM: dts: keystone: Replace http urls with https (2024-02-05 08:50:55 -0600)

----------------------------------------------------------------
Keystone2 device tree updates for v6.9

Cosmetic cleanups:
* Replace http urls with https.

----------------------------------------------------------------
Nishanth Menon (1):
      ARM: dts: keystone: Replace http urls with https

 arch/arm/boot/dts/ti/keystone/keystone-clocks.dtsi      | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2e-clocks.dtsi  | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2e-evm.dts      | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2e-netcp.dtsi   | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2e.dtsi         | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2g-evm.dts      | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2g-ice.dts      | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2g-netcp.dtsi   | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2g.dtsi         | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2hk-clocks.dtsi | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts     | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2hk-netcp.dtsi  | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2hk.dtsi        | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2l-clocks.dtsi  | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2l-evm.dts      | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2l-netcp.dtsi   | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi         | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone.dtsi             | 2 +-
 18 files changed, 18 insertions(+), 18 deletions(-)
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

