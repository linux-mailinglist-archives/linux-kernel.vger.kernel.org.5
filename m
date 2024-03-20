Return-Path: <linux-kernel+bounces-109085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A84881476
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D8EEB21814
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C16150260;
	Wed, 20 Mar 2024 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cVn4UH9R"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2025.outbound.protection.outlook.com [40.92.99.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32394F214;
	Wed, 20 Mar 2024 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948128; cv=fail; b=CmYUWLGwnQx1QHwocvsmPlBhjOLFAeID+zMOfDQ2zfFzb9lRKwOSqS/27luNaN4rniwWvKse9Z0yroZRzA7U5A/GTmcm7ICAoIdxQvabmFZobP3KAzBh1SxmY/CyW979Beb40c0uPMyWgqphrWB8mGdMb/p/ffWtpFO/c88Hj/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948128; c=relaxed/simple;
	bh=h5wttCx3aAYbLTpzzFtxbepXglbmi10NeFo4rCxUAtk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Rq/L8yuwZtdq2zzGc5n5R3s68lXekxl1a2AkSXg1yodCt5GAYpYIWZOXgLfcj6FKzoKHECer80JFpNn+jBTdaq/n8ga89VGOVFMRN3MpGT8pLoSvDMyqRjWWvPdMLCS4wYy6WkF+T9HGlX5oEDuBBPY+3StJVHp9HjmtICHcVRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cVn4UH9R; arc=fail smtp.client-ip=40.92.99.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HW5JDH4U6YJVsr00phkqEY3HUPnV6/+oFYYBF3a0jvlmjAf41Oe6b6qnm8HZVoQ+4fgLCx5Nlm/bs1tJkGlCSgquyFEXKbwIlDQsHuZiZeBK/ZoKVlBkUP3LEEhhEfZ7V2UQHRpr2T4j4wsP4g7K6RuihRuCxaxy9FPPQ2eWW/F98Z66qVAAQH2t3Nzwwxz9Yo1YOR1TSur+oPcv1aDZ94DEiSzW1KhGSSK7ILKYVTtKj1atOTcCgDzEsifHaZhR3z8wYqyqk39FMYFOIT6Mezm7xuGH0HNZ3VLLkIw6HSv/uJDspr6tkKiFrL8MC0sP6Q1mMocVjn7tSAcPfiC09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UDOalIrKDQ8Stzn9flsbkKGgvaV6Pc1/k2KeLc/MWc=;
 b=CMKGbMlY5fa9AktEysNDIOfJS1DHjRZxZPIt9Ji2K9MXS6cMxy46+EXcoqMtpKGT07V/efqQPklkeeOT4Zysz7o0CGZn4Q5JIk0nLPmOkE+n49kE2yQC3Whz7V+gifMAIsDXJl+QDyiuymHjKhbquKOEyBzWcBp+nAoOeb1fjBtimHpQ+YPFJfrDe4QSsuOCq6cx9NDGbb2Y036HrRqgi5T9Q+txAYZ65ZkllAzq0vwLK3sQq5VWlyhvOr0hZw4Xx2AknQV8jBBEFwLuBqj2iwe3i1HVzqLeQ7syeos5ywtV1G08d79WL/cyf40wnkKGsvYyPeHpr2spwPO7G/AyAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UDOalIrKDQ8Stzn9flsbkKGgvaV6Pc1/k2KeLc/MWc=;
 b=cVn4UH9RB79p8gaQpMzFPt5ToqOIYobMJTrVn8MCVYN+ZmSztDZMEutGN/sMjUFquvmc678xMSiYoHX2xSBK1bIPJHAD9v917dWW+wGkfQjdrtUlgXYmj2+ytPAnCkMOJY37BeXTS8ME5Y+Y88fev3WPzj/UI3tU5k914n9Jx5LJHDstKNbSKUqAn+7zwlBS2CyM81fP6hBOwg0Nv4ddexFlwSGLqJr1/L56oV+Gc2qo3f/hswIF9eF/K0niO852pKRoF9qm9fuoIK8XshyWb3IvxLivyo9qTBL1bqpByTb8Yia0/tSGggjGyQQWgTxK0c4KZeTigmSBcAOnoziULw==
Received: from TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:256::8)
 by TY3P286MB2562.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:22e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 15:22:04 +0000
Received: from TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d127:7317:59e9:143e]) by TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d127:7317:59e9:143e%4]) with mapi id 15.20.7386.030; Wed, 20 Mar 2024
 15:22:04 +0000
From: Songyang Li <leesongyang@outlook.com>
To: tsbogend@alpha.franken.de
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Songyang Li <leesongyang@outlook.com>
Subject: [PATCH] MIPS: Octeon: Add PCIe link status check
Date: Wed, 20 Mar 2024 23:22:00 +0800
Message-ID:
 <TY3P286MB27542582C36379EB4A128DEFB4332@TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [xSexVDk8IWs74z85TBYDJvZ4tq2DCD/T]
X-ClientProxiedBy: TYCP286CA0048.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::11) To TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:256::8)
X-Microsoft-Original-Message-ID:
 <20240320152200.8271-1-leesongyang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2754:EE_|TY3P286MB2562:EE_
X-MS-Office365-Filtering-Correlation-Id: 4815c572-31e0-400c-f7ee-08dc48f17f2e
X-MS-Exchange-SLBlob-MailProps:
	Vs63Iqe4sQk8N0yY9albUc+E2gbT5Qb45bcPRRKiE0NCRmCl89oJwaR7LhkAkC9rNTLh/6WerkVWBIXK3xyRivGAbYA35+xQkGmQQzoTjVaZTqjVgVTfxJMftZjDSa8g89IvGu7osMPfAA8G7zjRe1ECIVIo5Yc4n6MDdZkRrxLDjG1PBnFc6J0vsJqir2Tgf4Y3olSIJd0sfbykQbPqtRiiS+uD80ddAKcMUnudh/jEDyQ9Da5bfwGLx2u+JCbmHtGG2KmcRq5Rny9GV3/bLFnCohhl8fYiSiZG1mXixEe+P8xZ5r9k2KDPnPxc47aPVFjQPDXqxxfLvx2hILqQfUlXorBF6BNmdYw38YVk3uQzTjQYWw1dshs4wplrSDvNj1zeXIkVDDA8aW/UlNoTDdW1VROiqD0dxResfLp+6/UDqoaP9CBEICRtP/c4pcKe7gOyd8caGEvVRGBjbbCFMJdn4XccW0zsrgjWotWfjNu/TkZgESfH42yWcVGXruS535zw3pNvDQIb131Plhf+muNwt7bCVZ5JKZ8LZyamvN4IlFLro4hLWKBHbSaBrpg3aJ/Iz6bp/KpfCFPDdHCREEw3u62OUBRBvDygdm7B8DkHMCWydz1KT8rVqiEJXgpXmxlUrpkZROAy7Z/o6rjv97IF4c6Oee7/yVF/GJU0IB5ACxL199HdZsEp0XHlchIBhk6vJD931sm7zHnU/SSbzw+1G+ma/GJkwIk69BBxbh0=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	luJzAsYBB9lxy1jf/H79OsTB+Sz+LiBG+a0bBU9CD0vVzrlkwUhHGjIatl6iIzkCfOMYtd57mO2CtZmgV4hneWba0ELEZrrk+ZC1J6clgp0tJrcf4+ANRlmdnYlw6BXURtxHnBMt+qWrVpyPIFQXZH/M8pHO9iFRrLYDmIgMS6HlIZbK2Evjj881A8jFC/F43q/splCOHkBk8m7x9NHLHp51Kq4qn1EuKiPz8+ukky3E4dsyd9k4QDlWe85vTETC+Vm0xJwPpTeE+6quWSQLULNdExMeWsbDQG95KhKBljP86ijhl7jvJkcNxK/RbcJA4gr3zbVIafqobno1Gpr7qu0JNXxaxPWHmjvlCDJVBkTrE0hoLhLhMbX0jBF8wr/ARt5nt5tvpWoazMFmwv/wO0ETSIF4N4iSI8H6foQbXXHChek94vFbG6VQRQYfTRTyHXpjqpf3QNL41sU5DuixiGKF5DAwM7TDY9j3EmBnM2R+YF6VqjjyhQPTL7qkrOXL8hqJAPQFbU73WYchTeqYTa/DVmHBQqWO9pneLU5i/xgceHiN8i3PnlmEuUmPuh8/v7Etf+ExoR7YkzdrGf/7igDRdPcikvgEx/8ItyHzpUSUvtTbBtnjfyQR/7GAqYZi
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3PTqGsYF4aEhch3MkWzZ4A1qnUiznALv7Lwa8VJlOeWO3muEXX4Mew/wZOqD?=
 =?us-ascii?Q?z2XIWvooOhTOuqEeCr3VGPtsVeH0A7Lgg46xvo+oy1ALLS1/2VFxbqukPEOH?=
 =?us-ascii?Q?426yV1voLmWoPF57mIM+MNQNaL11b7x36eEAujNNAaM5zg2lySUzAxsHHKA0?=
 =?us-ascii?Q?ZCAgfmy6RnbkJtrl6bi52cJOo2UB4sGBlOz4nzbnuzExR0/YhKV3B//m3gJ8?=
 =?us-ascii?Q?4lZ/lnxTR40RyxWCgi2TGS/nYtqjvDkJB59g6UpOOukqC139fARmnwFd9eDd?=
 =?us-ascii?Q?mY8ct5GjHcI6QXdcx0EDkEBqYNfTAgueIVOnox5s42V58cNv7xeMCFnPyeHu?=
 =?us-ascii?Q?76wXLM+jIVgwQC66nBHLsFrCTGaOmREHC9GaIrWMLb4VBs2PxtaiRskjQMFn?=
 =?us-ascii?Q?vP1rkUPeLej/44CnfPPadOd+xZc6jNJqZGX0p0kNlyO9DLiCAh5S/uNbclRm?=
 =?us-ascii?Q?Zy9zsuucntj4izX8+qx0TkgKvvrvRdPshPE3vvgVInDbJ3V1BiH1p9JC8qtB?=
 =?us-ascii?Q?my8x6FdN19qhOZosx1mfMydZpbnmmNt2Nh6zeS6kj3U9SRbt5LNwwX2Xyc6B?=
 =?us-ascii?Q?FQrWWfr8xi4yX36JT6ik2HpgyzQVAykzdrJMCNUIkPYtsYE32SdOw6eZZfNz?=
 =?us-ascii?Q?LYafjh1SXouy3vhOsMYMPe0hOEWgOWMJ2d5+RtnEsGn8PS1hvdf48WtlS1V1?=
 =?us-ascii?Q?heSw+BiWzz+LNPNLljeiV+53sGZg0a8DFL4/3iDOCFyVdSI/JjaM1H1q0rvT?=
 =?us-ascii?Q?3K5n9qjVV3laBFYp8QMcyA8KJirUeaIFAqo5D++/PFyqMJELH+DQaPQhbmN4?=
 =?us-ascii?Q?5CB/KrejTLrOhNqA1wvcjqV+zVTAlgumYo5QgvhUXD7ggQDSW/xDM7LQiJqq?=
 =?us-ascii?Q?Y98ElMPnkt0Nz+LwcTi+t+cJduwQAkHfUw7oCesBifzvzQ2PAG2t4piNCoRr?=
 =?us-ascii?Q?LmhM3EfRS+GVH3r/C4GYdo7Ga4yzO0GOY4aMV54WmktTcwduR3s2Z08txmJn?=
 =?us-ascii?Q?vzJIbL0cTf2K9VdR7ic8+X8aYY2LuyxMM4eYJFIIydQFR7Dq2SSHvIc0hd7F?=
 =?us-ascii?Q?YXQ8Hc6u2Z+tD62eQ0E/GWHCNPMQ3YAL7kR2fBSr/Tp4YNdxyugUVw2jtRiS?=
 =?us-ascii?Q?q8pOcHCX7+NJEa3urT0Tx4IJHjxy9seDsZx6HcqUbktFC40vcBJspMNy5Cez?=
 =?us-ascii?Q?evTCx9T30Ap40Cb9hTGeh5g50HRLaoxTvCqbhNjWpjrsRoaLhpWSbPbe+Br2?=
 =?us-ascii?Q?/Tn0fwXCLrrXv0KPddOF?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4815c572-31e0-400c-f7ee-08dc48f17f2e
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 15:22:04.3074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2562

The standard PCIe configuration read-write interface is used to
access the configuration space of the peripheral PCIe devices
of the mips processor after the PCIe link surprise down, it can
generate kernel panic caused by "Data bus error". So it is
necessary to add PCIe link status check for system protection.
When the PCIe link is down or in training, assigning a value
of 0 to the configuration address can prevent read-write behavior
to the configuration space of peripheral PCIe devices, thereby
preventing kernel panic.

Signed-off-by: Songyang Li <leesongyang@outlook.com>
---
 arch/mips/pci/pcie-octeon.c | 6 ++++++
 1 file changed, 6 insertions(+)
 mode change 100644 => 100755 arch/mips/pci/pcie-octeon.c

diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
old mode 100644
new mode 100755
index 2583e318e8c6..b080c7c6cc46
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -230,12 +230,18 @@ static inline uint64_t __cvmx_pcie_build_config_addr(int pcie_port, int bus,
 {
 	union cvmx_pcie_address pcie_addr;
 	union cvmx_pciercx_cfg006 pciercx_cfg006;
+	union cvmx_pciercx_cfg032 pciercx_cfg032;
 
 	pciercx_cfg006.u32 =
 	    cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG006(pcie_port));
 	if ((bus <= pciercx_cfg006.s.pbnum) && (dev != 0))
 		return 0;
 
+	pciercx_cfg032.u32 =
+		cvmx_pcie_cfgx_read(pcie_port, CVMX_PCIERCX_CFG032(pcie_port));
+	if ((pciercx_cfg032.s.dlla == 0) || (pciercx_cfg032.s.lt == 1))
+		return 0;
+
 	pcie_addr.u64 = 0;
 	pcie_addr.config.upper = 2;
 	pcie_addr.config.io = 1;
-- 
2.34.1


