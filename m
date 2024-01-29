Return-Path: <linux-kernel+bounces-43431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE498413CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744511C2353D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E967603D;
	Mon, 29 Jan 2024 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K/WVvUO6"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2084.outbound.protection.outlook.com [40.107.104.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362AD6F074;
	Mon, 29 Jan 2024 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558025; cv=fail; b=gqNeKW90DGc0ByPS56JXaMbm8mTEqNQnbZYn/fsBfe1QYQwVH2dxG5WO0Xx1V/obZj6OXGROwOoHCcrJWhYu/QJVLkjivysSO/7pTS3/iwla4rE3ziS8lr71lDR+pWFcmWncMR6en2sRWlI9cUN9taZ2s7HjV59pH1xSyddU82o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558025; c=relaxed/simple;
	bh=OTZuh7LsRm3+WrJQaCFl+RFNll6i2ZbpeAkdLWbLnHo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=n82U/UvkKM6f5rC9wueTlMBkV5V1EGpiP7+QON9WR/9WVXX3Zam9ftXibxyNfxnPwwuMxwPnclZl+93JM4PrMdFd+jOlyCodSajGlbefB7Ev8sVbzFRahYNgbUK3jBF8eZAvsGt/vjfXkelkWY1+gV6/u1WHdDSkbTl4bOXRTYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=K/WVvUO6; arc=fail smtp.client-ip=40.107.104.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC4DOqupsXpcOKpSBlxRArPxAtEJ2fI6m76XWhEJbNsdcZzq9lnezyRmRTWwav0ymTBKfv4ZuYlVARpoPBg58QD+NxETzVs4ZDEeA+Kx4tcVq/Pr46uA1of6zpFt06Z3xCEMvwsGWLiRfkO281i7VeHNYiQInZ4iSIbSNncG5mkQUXdDVs2gDr7s8kQrEA4iF01IaYfG97d4l9cCs6YRdJ9w1Voh5i5WS7gFeXUOimB3OwH5p68T/IYFLEQvqZtONZzxqURJma3rseMlUMoH49IsqiAOrRCt0XFg5OY3W0H99/G6DdymKWM2kzjLzV3xBLxZ/SIXj/cv9sAko5PZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xvDCYPn0CBpTHGLkColV0AhTkpbGViu/rysOlyeMLo=;
 b=Pt5WOTV5Y6OYQt/XxitBm0ZkEydBzhkfiX/2i7jXdWdROqyHQ3vr1/3/JDtxUKTNcnUpX5XLlIoBxdMUYGX7FXBd0HJJByh8ym9jd89vS0deH1dI9sRXaVx2Em706ezwuzoqbSQXWNimgjZyF7VTpm34k/OOM8mw4nNKljivmfYp0j75eCpI9BDbcHIfmBzo5DpnsytvByS8BazwZ9TlF6/XJX8Hk1rKwgxX8CzmW3Vficav3ejtDH07anB/TK95dxRd7Z6AKDCoYxwyYPc71aKZmfCxs+u5cuOS8TEiQ7Wec07/xKEYkuYFLtpNxAPnt7AtZl5H/Pba0UJ/rgRX4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xvDCYPn0CBpTHGLkColV0AhTkpbGViu/rysOlyeMLo=;
 b=K/WVvUO6ENw5GzcC2MhwXZizHmHQsV+jEUqrTJ13tiJvAtEEgo+DhXy1Nhm49xy4lOAYj9pSAxnbU4UHFUKxAWtx5sasw+XUYvq4pLbj5hmFBMqMD6WagNOYcPa5Tc8hNSXXxGZveDR8eKvr5tgqccxCr+PLsopt22gEGDthOog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8128.eurprd04.prod.outlook.com (2603:10a6:102:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 19:53:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 19:53:40 +0000
From: Frank Li <Frank.Li@nxp.com>
To: ilpo.jarvinen@linux.intel.com
Cc: Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	joe@perches.com,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	miquel.raynal@bootlin.com,
	robh@kernel.org,
	zbigniew.lukwinski@linux.intel.com
Subject: [PATCH v5 0/8] I3C target mode support
Date: Mon, 29 Jan 2024 14:53:13 -0500
Message-Id: <20240129195321.229867-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: d40ca076-0864-4214-e758-08dc2103fd66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qkg79M6YkMsTNCARYaXvctYEaT6DxYiEszN1MtZlxuAv5d4/JH9CLaC1rurKHiOceeuWzyE3JoLkU/DrHoSkwKJo7urC0n2/bA3mImecJLM+O2c+R+KfmJAO85thhbduk2QI7s+/09VX/FF4w5y/GwjqXxeC25ozvz3dna02Z3IeCiDTCrgtNXNFNkUOkpcHK2EK9W/K1TF9A5LEAzD5DCbzUop+0l7a+dnztCqZGC+JbAh2V7ZetdhfP3EPyU34mymMKaf6hyayTpVgJW17xH771RpDmbYRjgtHVEsL7LhLHR5pwGJq3Gs+FqE0eiqGkZM7+yw440MhLjBs+S7XVPPZxzZiWTbLGczhiUFXnxJUNnuo00G3GatasBPdWqWYf8+cn6ya42RxQRiKkz8DagJMoDruD2EYVzWjoeNhlWCDi7998YFSp+oKaKhCg27CpPai3AyD2X0DP9nZB7Uz9Cq+Z10si48SVap/q4Y/yflNPGF++MPBWfGpfyJ170Z7AAnCSd2gp/mo4J1cICjyDSlUuXNY8wX7krjDRZORKK7Nl4kyvklNpTri5JPKnpkSjUDt8NQegKnNXEtviO7Tds0Xa/ZeqfcfCtl2y4No9ZieQPfJtf7QeSj9BVPeZwTKeait0USU6fpfd3l2kypseKFUdYX1ZY8I3CKBa/CCLrA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(52116002)(83380400001)(6512007)(6666004)(6506007)(38100700002)(66946007)(4326008)(5660300002)(8936002)(8676002)(7416002)(41300700001)(2616005)(316002)(478600001)(6916009)(2906002)(66476007)(6486002)(66556008)(86362001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OqXCalIMX8Yhk0atflS7Q/IdRwzIJ4gOgKiJtwx2tIMWcgweXLc/BTWQHLjj?=
 =?us-ascii?Q?hpfpvnDev5ZL5KaTVu4OfHVD7uYkbWeqUyttziljbavKf0T+XxUyI2Um1+dL?=
 =?us-ascii?Q?Dor0otReIJvccfAOXSH5trp9xSV8kRU+r7uoUV/O6AXbvxrD2DoB9Sk2+45N?=
 =?us-ascii?Q?9FxSjb/1fGxlYszPjAdsJcE7aVvyd7g00hkH+EonnEi9flBOcB9zSgkohLL0?=
 =?us-ascii?Q?KKT4KQE4e1ESw/+cFsT5X+9K0/4LlXC5m3dMqfRlGtuZ5lHGzIhJt9zF0G1O?=
 =?us-ascii?Q?4ospgYQfRaHFNbN7bBeNJWwdO+zLGAn3THbvc7RamLL0t9b9vMPNpgklzmOb?=
 =?us-ascii?Q?j58CuLihD8EijMz1bW2cdGzIEWu1xl/CBUhtrz+n7gp0kpMnJA8WL1UirkAM?=
 =?us-ascii?Q?+LdLdxIjEqkSKc9wOIe3u4aCKV3j3OXKCo2uK2FG2IAMsH89TBS1CljXPdJf?=
 =?us-ascii?Q?x38Mqj1I5uQcTWQA6cYRgdv/QZRGGJnFCO98zy6uVNf7VUE3rtADn/YtGQc1?=
 =?us-ascii?Q?75POy3dEMHIcN1+ANqpLflbEg8WKMi7kyX9+xFH07Dr3oGKpCdIBG8ix/eZt?=
 =?us-ascii?Q?m1O+oVT42lywQmA775I93d+OJBuwB/nhs/ozxsPYud35FfdwoDPeRV0GDMIF?=
 =?us-ascii?Q?j1LP6evP51N/J9zMy4SD79zfIB1VLloxSsGfEIi8b8t0Hm6G4XoEQBdJ4d6L?=
 =?us-ascii?Q?lRo6jkX04ZwTluGDbXDf8Ldy0QLW85rLPzbxSMkuczXhN/Z87RyiSdBKlF3z?=
 =?us-ascii?Q?H0GJu+aL54l12VTyG2JLHY8OXT2BLnjn932IxWadG+idXahFTBUZTJTdG6kN?=
 =?us-ascii?Q?5OFmB098KGgYU5t+7XPUTWh4hJ5vlzfdDZAhbzhfHJoZgnkZWUl59rHxHxMH?=
 =?us-ascii?Q?zfesbAQqvpjX0lABHeawTPREYO99VrLxuQyrV9X/h6ul09hNKhqsF5Jd1goJ?=
 =?us-ascii?Q?D3yk9bOoFj1s5YbdkVzlJRUQTG2pdP0PhGNFgpDRdSAHDPC9WIgJ54Yp+nUC?=
 =?us-ascii?Q?VblG3BpG0mgPpT+v51JtF/MQkC7WxRV6LC88qUmlre/5g9g3oHreIQ2wlsg3?=
 =?us-ascii?Q?SuAbGphHpgiT8nHQmQ/zipW2XNNfpIjMeMxbCQWq6qKn++ZsjlHuNWhtD2mY?=
 =?us-ascii?Q?6DO94k3OweSx7fhtKCyQmcyAUfBSyLu2LqTrRMWKQU2jizuXs5RuteyJjqny?=
 =?us-ascii?Q?R6ADwLDNrrX8kTzKUrhTx1gCaX+49lIvfjVRlgwsurIe0Ho4v6vB5X+PK6J6?=
 =?us-ascii?Q?vBRbcbMMvRaGYYl8MQzSs9WVHah3NUtDDtEAHF4sR/lj7vOwF4JC4d9OEUz/?=
 =?us-ascii?Q?4viJwMw6maxzyPcenzWbSSPziMsCWhRjoPoUqqyXKEwmf4zEqXFw5EDiuCgs?=
 =?us-ascii?Q?dnIcvYsttvz974OkhBHkkN2T0Ql+DV+OCUjlUTj4JJSoXDWMdoZkRbpZPmD8?=
 =?us-ascii?Q?VKkk1qs0wNzXB+EKxhdFHMDrT/4q8+qiyNaBTFzEVfCB1JRrCFCUYJSHOLfK?=
 =?us-ascii?Q?tzXaDpCCI5sW24d8maVw2toNF+O7VetzHKbSytMMLi8H55ujzp93pwE9K0P0?=
 =?us-ascii?Q?5faqpFIqvN0/7WU2rBc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d40ca076-0864-4214-e758-08dc2103fd66
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 19:53:40.1273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPleUaiN5ZXHoh9E8funKKJmtQvWU2P6Cxa1OmmmfVBAG2NjTiFNiOnsYwSr7176O7q2XukJZ2MYoppvd8cJNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8128

This  patch introduces support for I3C target mode, which is referenced
with a PCIe Endpoint system. It also establishes a configuration framework
(configfs) for the I3C target controller driver and the I3C target function
driver

Typic usage as

The user can configure the i3c-target-tty device using configfs entry. In
order to change the vendorid, the following commands can be used

        # echo 0x011b > functions/tty/func1/vendor_id
        # echo 0x1000 > functions/tty/func1/part_id
        # echo 0x6 > functions/tty/t/bcr

Binding i3c-target-tty Device to target Controller
------------------------------------------------

In order for the target function device to be useful, it has to be bound to
a I3C target controller driver. Use the configfs to bind the function
device to one of the controller driver present in the system::

        # ln -s functions/pci_epf_test/func1 controllers/44330000.i3c-target/

Host side:
        cat /dev/ttyI3C0
Taret side:
        echo abc >/dev/ttyI3C0

Chagne from v2 to v3
- using 'mode' distingiush master and target.
- move svc-i3c-target.c to under master,
- built together with svc-i3c-master.c

Change from v1 to v2
- change "slave" to "target"
- include master side tty patch
- fixed dtbcheck problem
- fixed kerne-doc check warning

Some review comment may be lost since it is quite long time since v1. Now
master side dependent patches already in linux-next. So sent target side
patches with tty support again.

No sure why an additional "\r\n" appended.

Frank Li (8):
  i3c: add target mode support
  dt-bindings: i3c: svc: add proptery mode
  Documentation: i3c: Add I3C target mode controller and function
  i3c: svc: Add svc-i3c-main.c and svc-i3c.h
  i3c: target: add svc target controller support
  i3c: target: func: add tty driver
  i3c: add API i3c_dev_gettstatus_format1() to get target device status
  tty: i3c: add TTY over I3C master support

 .../bindings/i3c/silvaco,i3c-master.yaml      |  11 +-
 Documentation/driver-api/i3c/index.rst        |   1 +
 .../driver-api/i3c/target/i3c-target-cfs.rst  | 109 +++
 .../driver-api/i3c/target/i3c-target.rst      | 189 +++++
 .../driver-api/i3c/target/i3c-tty-howto.rst   | 109 +++
 Documentation/driver-api/i3c/target/index.rst |  13 +
 drivers/i3c/Kconfig                           |  31 +-
 drivers/i3c/Makefile                          |   3 +
 drivers/i3c/device.c                          |  24 +
 drivers/i3c/func/Kconfig                      |   9 +
 drivers/i3c/func/Makefile                     |   3 +
 drivers/i3c/func/tty.c                        | 474 +++++++++++
 drivers/i3c/i3c-cfs.c                         | 389 +++++++++
 drivers/i3c/internals.h                       |   1 +
 drivers/i3c/master.c                          |  26 +
 drivers/i3c/master/Makefile                   |   3 +-
 drivers/i3c/master/svc-i3c-main.c             |  80 ++
 drivers/i3c/master/svc-i3c-master.c           |  34 +-
 drivers/i3c/master/svc-i3c-target.c           | 776 ++++++++++++++++++
 drivers/i3c/master/svc-i3c.h                  |  15 +
 drivers/i3c/target.c                          | 453 ++++++++++
 drivers/tty/Kconfig                           |  13 +
 drivers/tty/Makefile                          |   1 +
 drivers/tty/i3c_tty.c                         | 427 ++++++++++
 include/linux/i3c/device.h                    |   1 +
 include/linux/i3c/target.h                    | 528 ++++++++++++
 26 files changed, 3692 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/driver-api/i3c/target/i3c-target-cfs.rst
 create mode 100644 Documentation/driver-api/i3c/target/i3c-target.rst
 create mode 100644 Documentation/driver-api/i3c/target/i3c-tty-howto.rst
 create mode 100644 Documentation/driver-api/i3c/target/index.rst
 create mode 100644 drivers/i3c/func/Kconfig
 create mode 100644 drivers/i3c/func/Makefile
 create mode 100644 drivers/i3c/func/tty.c
 create mode 100644 drivers/i3c/i3c-cfs.c
 create mode 100644 drivers/i3c/master/svc-i3c-main.c
 create mode 100644 drivers/i3c/master/svc-i3c-target.c
 create mode 100644 drivers/i3c/master/svc-i3c.h
 create mode 100644 drivers/i3c/target.c
 create mode 100644 drivers/tty/i3c_tty.c
 create mode 100644 include/linux/i3c/target.h

-- 
2.34.1


