Return-Path: <linux-kernel+bounces-128320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1937889594C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386AA1C20291
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34A614B06C;
	Tue,  2 Apr 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="TiynvNQ/"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4D414AD1D;
	Tue,  2 Apr 2024 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074127; cv=fail; b=iUTjXrg2/36xNbYNi5KQ+I3mfl1lwIx+RLpaV11FaqAk4s4ReJw9he/+3Cm7/2rUhggMrLnVn/+x+jj3p5R2y7mB5tfZ9oWACpTtn0d2OcqUQEagNFSNnR01R8jgjQnzAQvapYuvmL8fPeV+gwSSW5aRfFAApWdrEJEqwAUICjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074127; c=relaxed/simple;
	bh=GDbO8YntxMEoJgmDZg1Gjd6atM03ZT6li144WFX9dLM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bQjGuFDi9/UDywOtxS52EjzN1eBdRQA872NID1yqvrdX5dfp/wR7X67JulhZ585KMt121sF5YnFVLJ/73QSKLA0xBmBrV3yFHUvzvd09KeiAUbUz31q+ZmhNCSOd368zJniZSBFR2KZqK+IJ0tyj8gAaNFlV49onwlvfKni/Mk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=TiynvNQ/; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xp0KzGu+cLJPnrooLnWIK+043XionZDPBWSaQZYaVuqkHG+1XSumisx5GYpuhjZX7wgseNGO/zWlMDzRV4ObEUgHoDN2phTwXzrDsKgZis86vViqYIAVz2eSEjZx/L00rxV7BkkYv37ArbvREIeDUnlay/eI75mqV5fY1vr2MwxVQ4BgEa2WCuTpxuY2zXjw452j3rSivRHMoXw/9tR7iCYNfu1jWOeOQCKCu+kqeioISDNSQIOfaFeEi94plJNNzuWhbS4Z7EQZduEJVcetVnvTM84UoMpzAvHyJOgf8RVGgYzSVsmEVwRIq4zFTED9uWgzZkBP0rPRp/CkEAmQcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57RBwjQieubSxbYSnCa9rzMpZeMEGeS0SV4p8T7a6mA=;
 b=Zie0F8+1IuKm9q3IIPy4qFuK1mvsBN2qpsH2j4jfeB5WSMYc0HPrDoz0ND7KrS3P1f/B5rqkVzgrH2cyVuvCs1/i/P8OaDDXKkM1iFjeREa+JvQZWgjGaC1Y3cVZjkvzvizzSbYM1dXDQeEIgN5pjgXFkGd/c5rRY1I5QN5kIp6bX+1Dlb/2vRrcdlTgzzpilSmoHah6a7iS+Beh47iyR0ZJeSK9fKIHnk2e1yjZh2WmRgflV48aULVB4uh1yZ4KpyM4UGHAiumGDXOLaQe3cXH+y8mgIKApRNjDUv/yQZ9Aj3YUg6bH566fpAzDYULmBgvEz6i9Rq9fntt8IOSu+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57RBwjQieubSxbYSnCa9rzMpZeMEGeS0SV4p8T7a6mA=;
 b=TiynvNQ/mkHXQNa6nEPNPh/pnKHxKAsMVuJoNA6phMsW0C1G3BgBsVAupdH9rTMAvJBdxWPt7WxflZ+ONl7k9Y+gPUGttXJqKsJLKHh4xbNN45Cq6OAusuroDxjycScvEiQQCO3Wfdbvu9MzLZNiWMcMxhjC/xE2Xu+8Eaotw+A=
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by PH8PR22MB4097.namprd22.prod.outlook.com (2603:10b6:510:238::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 16:08:37 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e6c9:dbd4:f002:212f]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e6c9:dbd4:f002:212f%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 16:08:37 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH 0/2] Increase CAN max bitrate for phyCORE-AM62x and phyCORE-am64x
Date: Tue,  2 Apr 2024 09:08:23 -0700
Message-Id: <20240402160825.1516036-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:610:b1::16) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|PH8PR22MB4097:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xYIzR9JfuRYjVCMyCshb2LPCBwNjIJTXz7EZelA4afKO7K17+DpNqI7ruo+vEATvqW1ADqncwd7waPNkwL9B6UfKuO7tImWoHrWBmkbTJaZhTGBVF0HcrOq9HCM6FN7JPULCU39+okU/DaP9Yv6W+0ZDIdjBHCJQ+5+QMfm8P4eoq1i9Ok/JKmcPPqOfxeyqT0ssaVJi5sV0AAA3314pUaa5QRmepCS3GodrRqKdR3b5JBMRwF4rwQN5T7JRN3OsFC/tKC5HLnBSlex/A3f1sFoD4Hp+S3SOQZVdUBtu0VVlkxxzuaDKM5tV7IqOv2t/yFyCikjuqVltVmKGK2LID6Dp0/Sk3IIOm12gjWlWSEASNPJ3zxjcne/TQ5NVdJdlNQfaR2R7wzMMQk2GeDTCi9mTLeYynDwR7KHf16pq0K3CoMp7dzWhOQoYZ4hl4Ocz5iU0Hk0wKBDb7ooAa9pXFeBD7fCGGB6fME+ZPp131/A0GId/oAdDJ2ko0PhI7twtLRRXL739aKUUw7xOiG+m9FOZNJW30R+lovreQ06SeO52eySEWd/9gMtFt+uy33sWkMgtdhpuybG89nmxqtp0gnGpFpoEQbLNB5o0fPYxWkFtnCsAYt0TOka9xiTOuyptjldekpAKGhR+KVY0hN1sJ+YMmn77Ab2DcuJmuqjFi1+wKrAGAHdROkQUpHBIF8/XnlJP9FoOWhWD8hyTXQeifA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WtwmtQAX0LRIXzfma5SUFs0NKlS592EIYG4cQtSRhU+xRJL8CnlujbeN+COA?=
 =?us-ascii?Q?LKDOHXlnuzhxI9l251VRQhK77eZfQN+KzWxlawPEA0BSbPxgWWev9HcOz/9X?=
 =?us-ascii?Q?Bm0hAR0bJLIrJbwuAuabrWp59LlIrg9cfFAuePAS6ALD3jNIPAWdR7sanP93?=
 =?us-ascii?Q?vpEHoXJMP85nqfgoWRvtEiG6oOf7BcVuptTl8xQT+AU9qZtju6ZskQbDkpSC?=
 =?us-ascii?Q?5TUl+xvAxLfsht13gcEAfZWCCLa5Zt9fNA5X+JGMU82NfMBjx7m9MuYKxGRh?=
 =?us-ascii?Q?WBlqm+f06QUuT4EBR7o6MvQEVCzPbsrum0pDb34xGc5geU4X3lxnHoSJBh9l?=
 =?us-ascii?Q?UgGDoNxRMvI34xRiDocmpFX2L9R2f0je5q0kad54kRaQUZ5AlsuM+i+mb5sU?=
 =?us-ascii?Q?5JqTiKjdIeUrWdpkz4FwNpACZdRKy3Vd29aNbc5nTnzSES7AqSpiiSYSRIIy?=
 =?us-ascii?Q?FFU5ZM1JJ40btXQ5jcFXvZO//pghawnj83qq+lYJPftnSn0xB11lMeqcYPxb?=
 =?us-ascii?Q?1Erb8jQPBru2ECEoCvXPwBb6MSE0o7iycwNGr77/zCkLr52ekipzETiFBJtc?=
 =?us-ascii?Q?QATxyeR10E6gXn8QGQ/oYyWK3XXZXwkdnlwWnMsRRKeR43VKZ6DJ3GMGe9Xa?=
 =?us-ascii?Q?pZxMcUqzLsIbW5b965yLEVzs/wo6FdY2lgDk9LpcTChEAkzc5lbdX0NrjD6b?=
 =?us-ascii?Q?dwtx2Qe5TWMBT8ba1NtVl9iOJnTA3gGjZB7vKHRYIMzGCl3XIYloB8N4Pe5y?=
 =?us-ascii?Q?aLYKPLEcYLj8rwXLMMY7g/Owd2GKz8Yh7xDDItHAsiLvXdcmKlNJlA7Ow264?=
 =?us-ascii?Q?0I/ouRLN5TckfpqfYGr2fgVc+257QtpuzR+XOyJOxqFwD1d8AY2xaufO2yeu?=
 =?us-ascii?Q?7SUZka6I0wKDWYNBQhtYeewNrEqmHI+S52QueGlwgpLWaU4WjwVYL9tT8MPM?=
 =?us-ascii?Q?Hy+UAgPFfa7rs4Sau0YZkKZPrOgWQz/w6HQeuvFyCL0CgxBU0a280V6Cv1xJ?=
 =?us-ascii?Q?7wSqNMbnNYvmX23rXnMrT2AHHs36hiuHNIUkcpM00DNeMn1BaJltQ0+bOuWJ?=
 =?us-ascii?Q?8LILfsHPDFpkk/dX+yQvqws/GDju3SSqjOuwkMDGoCrf1qd7QVyHHbLfMqJk?=
 =?us-ascii?Q?++u5sv4fwpNSvNBdTlKc0QIkeavjWlnnZZPhGGhpq/Ke0CdF/qw66ZcjO2xq?=
 =?us-ascii?Q?pXaH4Dnh11YjpaRhg8P1ZLBz4mEyojkE5kLavtbg0PmRNDvlgqiecef38Gj7?=
 =?us-ascii?Q?UAtKyHZYbxicrlp2dOtJeh3nNXg4L2E1SjzWXLyMbPkHWfhuGKKhxssmlT5z?=
 =?us-ascii?Q?DYlwQM1keIcVEAnk/NwTSQ521hucNRBXvsE6nrXSQ7/IwdrZz5/preImvkCN?=
 =?us-ascii?Q?P+7hhVhzL2C98s/t8iov+6Tk4T2ANgyGbL4w4mjb1GQ6e0xm+i9j2Yhjaugp?=
 =?us-ascii?Q?QuhYEIPf97Z705ZnmF48Y9ApHVMPEDdPeufiprq76nLHMXNlff2BYEtJLP+3?=
 =?us-ascii?Q?TGbSuGm9OwDOgTsgbgyEPsGp5XELRiIMR3V+5FJX1/kswQ0RaGzdgK+YxVLQ?=
 =?us-ascii?Q?oFCczeXvlV2d8Whjwku5JCzOt9gdQeCt1AfVNY4e?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9ac8d0-625d-47bb-7949-08dc532f274e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 16:08:36.9650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPu0OmKlpP3g2oSOM6v9mOvAw36AmHb2eftUC1LBnBb1A7yf/w7x64IAm/ZnEjnOo81/4zsNX/lPTcbqGcMBug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR22MB4097

Nathan Morrisson (2):
  arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Increase CAN max bitrate
  arm64: dts: ti: k3-am642-phyboard-electra-rdk: Increase CAN max
    bitrate

 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts    | 2 +-
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.25.1


