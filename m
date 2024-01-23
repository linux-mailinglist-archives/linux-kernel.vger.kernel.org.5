Return-Path: <linux-kernel+bounces-36067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762E7839B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D762846CE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD893986F;
	Tue, 23 Jan 2024 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SxWssYbk"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D6753AB;
	Tue, 23 Jan 2024 21:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045173; cv=fail; b=tyhtPWEyUwjSHc8R1fxEkHlKy3hO+UNSGsTCs3vttLjV1SDFI/BqqwRTui60yTRojj6hV0D1eZjRHjZnzpHWR28Y2ty1Cp6cQt6T2UtxOvjVbvy34gHE2SMkRCeWHhVYIxgsIgqbQDJ5Ucd1lVKK7yqHKUXGCy09SQiWKeeFavQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045173; c=relaxed/simple;
	bh=mn0ChQxh9SVQBCBFCFxbD44mymz+sMRtR63H/bfwNxk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fPCuP173QVlEsk/PEv69jyFbQlUR6MSE0cjujgyYHInktR32HBpBq+FjQfcFaffAi5ndVrPSzDoClhBj9Mj9ntX0guRXMxe0B6l93lHEsaNOil3J1Qfvt1JhDOhh55/t9Wxe7cG2Lj1k1Hr+1gLawlQXGBT9A7rMZM8GLBnfP7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SxWssYbk; arc=fail smtp.client-ip=40.107.8.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRZD4goYgpH+Xv25EDrEuv5+aQx3MSgTTlz/lBSsI4sO+8Z8j7ep4V14lNsfTeMnUJymflcuucGC1Z7qlHt5HfB7DobhaEYZZQAngdVcZGZ8ngtrTAw3BkLYO+hTsZrnx96jm6IjjzULVCxuutiiud+sKcZc0y37s56X57OY/iIkXolrGZERHv8pZXFkzG+EZTtu9BNcAsF+BVPyCxGG+zzjGjdXfdXlzztbGDOXitKcHdXImYBZsJSzLhEMtThcT291Pcz7lPE8P+9yzSQQM1DR0DnLtgxRMeJJ76BZfwpSHVixLee9r9KFfjge+rBWCkSoPBiIQLAWlq7xQa7lkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMAF6N536AjPAoovcp+vXEnKbjyZDtfqPFMlyEUT7Z8=;
 b=Mx6kp8UZvfuag8oIGKDShquVKUku4A2bZWbrDGgMj9OmiWmyWm9Rs698LiKnSzynz+bDXxL1ds896gIJ6BwobPkPOtYETYTET+qHBb4NAesRTDToQn/Bbl1gzZ4Sqk4AEwvliupAEh3ppB75Gv6Q7Tewyc5Ruwvdqp+Ml/vu7IzuNPLmsAnYjrrpTWPU1AwoDxAaBdPEgHWmMXHQjRBxcR4fi2lqFQAiGjwbMm2FLiAh9O35fXYt/z89Do0M4mGYMiFJvSpiyGpcMqTlEHMfNll6DSgZwa8KarR+xOfBBBSzQqydVN6+YQsTYb+1fdgYCK/6L3xp34Ki+dJKUxBwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMAF6N536AjPAoovcp+vXEnKbjyZDtfqPFMlyEUT7Z8=;
 b=SxWssYbkW3rtCLtOjSFohmUfogsbQfjKNP3t/pcylQ2GmwWpxvkOXoKEHqU3KpNMAiRCtmIXP7g/Rc2Dga0orv/mR7fVcaDaMkTeoobbfOvTwWx3+vNiNhx0tdlN15B6Z6m0UQhU4FyW6EVQXz1Upt+nAbLGEKfohV24JWw7VOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9873.eurprd04.prod.outlook.com (2603:10a6:20b:672::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.29; Tue, 23 Jan
 2024 21:26:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 21:26:07 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: alexandre.belloni@bootlin.com,
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
Subject: [PATCH v3 0/8] I3C target mode support
Date: Tue, 23 Jan 2024 16:25:41 -0500
Message-Id: <20240123212549.3858137-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9873:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f454af-528e-4764-e912-08dc1c59e91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CYVpKZc//fpWql6Uu8phA/GYL7G91jwpkl0jym/M+G4zU6W1z4Xps2O4CriKr/gXVTwwAf/MKTpX2fwB1g9kuzOy64u47iOz/QM8kYLJk5V8ub13eA+lpnHmb6Q9P11QGl/Bu5Ic6jiR9vGVMhR7MI5YArNbEauNK5F5xdyB2KxAzrDbEM422onj47Q0chGe/rLFIsB7nzn1R46/twhXfBtVMASkQzBvE0PnhwQd8v9SCJdJEIykB3uhxoNW//UJkJogAPeFW5jDqKQaeSDpTWpXjNY9wQ3ZjI+B4UtdAv8Q/czePeIPaZHzxVOdhdb1DnE8TpGgLiScx2y2X3kv1ZlzoujokZ+VYzVCU8VH2j1R6ic0wpOo+rRVemrXzlBc+6yZJBrbbgX8yq0cTFTx/4sheunMOAfyJAPlK8N2ags2TqbPUTnKpdLxom5Dk6wwmpQxmPEhtdqNw4fRBvMPH0ghmYcEQdB9mbZnxGQxaR7Pr6rr5w6iCZrMWCiWuWPyUd970HZe8Tvk8YJkedJiQDRixprCRgoz1miVXeVehGd0bKLvvJ+bNJCY//B2I+s5vdYKsKzfLR9KckoPQB73JWNw7U8BuBEAOrcp3ODO0Qw7xNzhlKnFXJhheuFCyMw7DR4185FmgfzQsbUTMWkbXTu/BL7WINH00m8wE9OD3sA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(230173577357003)(230273577357003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38350700005)(34206002)(316002)(52116002)(2906002)(6506007)(66556008)(66946007)(37006003)(26005)(5660300002)(6486002)(7416002)(66476007)(4326008)(478600001)(6512007)(6666004)(8936002)(2616005)(1076003)(38100700002)(8676002)(36756003)(41300700001)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KBGyHXyDFYximBU0QSDdvK0qMh+EJbP1sI/MQCt1D1JMYl3o6QY1lH5Y04qQ?=
 =?us-ascii?Q?JA/HxzUnaN995SJobsYdzZRlcVHBi+eTsuoAUv/Cmx1a279B7V70/vHuo8vI?=
 =?us-ascii?Q?tlonRppa0iD0kP8mH+IBJW5rt6Jq+KsR6eRBkrZU46r078WkdMSNs1D1Efat?=
 =?us-ascii?Q?eIO9zGJFuGtBGTTy0m75jav/+xpkSynRgDY4LFIWt8JPpv/zsv80C/8q+2s+?=
 =?us-ascii?Q?1lXdOhKC0660x9trQeR2rPWlpSPD6eE3VEYX3wFYKPOgCjZ0O5EOodvOlcY3?=
 =?us-ascii?Q?LsJw6xAoMrYS4ywarcYgg3qe3tyjJXWn6wtfY6IngOWU9EdH/o+1tc6mBcqX?=
 =?us-ascii?Q?I1RFBx1fGerTBFQ/ZSl23mtJM9Rgd3C4n3kO+qqQLUULvcA6GbhanPgf0WcJ?=
 =?us-ascii?Q?3pNJBXhi1DoY4pGElI+yExj+/qYWniPTvq+VW3kgqDU4aD7VG1A3SEEPwoCV?=
 =?us-ascii?Q?X8OkoqeUIKyOAaCuki2knqAK4c58GaiwEZOuGVzcCt3OTK6b/NE3vQFncYid?=
 =?us-ascii?Q?NgQMtTga0aREwP+x+CrTOFbim2DHtgLOSPNz8Ru+YK4Rc33okFBA5WT9/cna?=
 =?us-ascii?Q?R0dpTxfYHKSSBUuWYhqCo2EPAMzYc0urVo6iHeyuQSYVE4wEsVBqW3Zpg7G+?=
 =?us-ascii?Q?BSQm5livANIJ+10iAwBmvVVQelTtc1tICKrVY35G1r89Qf1tPEUMsS92KgkB?=
 =?us-ascii?Q?oEI2NibCvRuX74w3Ayk3JUHohFU8J/GOjfJd7qMkYna/rxJOixy1ZtLQLXf4?=
 =?us-ascii?Q?mRVY9rN9HmngAmCuCjU2+/Tf/OXPBRT6g7WYoYJlsl/AKy0Gk64dyqv+/9BD?=
 =?us-ascii?Q?A6IyvWGN0RB46rTd+A+cG5mSC6mPOsDM3c0kazh7XH3SQYCLpppnbdlBkx6K?=
 =?us-ascii?Q?cNiwz8H3LpSlwmWzEsYs2UkAYa9DOaa7K//8sLt7RDJwi1FTV2z8hrFK3lwS?=
 =?us-ascii?Q?9S54hjDE1b/QwFOfWAVoNbP9O6+dt+oDk0cNytIUZ2hPX3YH+h/Xp9qiypt2?=
 =?us-ascii?Q?QWH1emXV1HPMB/JLhB4B6J8SNGM+BgLCHeFMxXwolsW25TM9LmsLxRZLAe0q?=
 =?us-ascii?Q?kxstNkG4FYxEjxwWHK37cKvIoErnlgSBIMnDJXluhuhIYo1MC/hyrx0h3f7n?=
 =?us-ascii?Q?lQXA8bLMP9JlNKSGWlyT9pCt9kZ5U0OMIoYfPF1UM9q9IWhfcr7QDgGzt4YM?=
 =?us-ascii?Q?Yj9hVTLXjKrbc9R9T9+Mgv/o82XjRJLdhBVm6xhV6XFiNQLaB4r9rJ0qWDrW?=
 =?us-ascii?Q?ikJ0LiwDL+SiaJa63Azs7YkhvUBtxt/MOj6YANscE4RVDG9wKhVPbMakJO76?=
 =?us-ascii?Q?aZqLME+YTgWsBrXyq3aD3K67e26GiCo7bSxCOqBDKsetKOo5pdypLtqbW6uE?=
 =?us-ascii?Q?5wgdEkH4Vlw7/PvrfopDLuFH5DJ6ApMQz5LxwjViZlmNzKME6DfKFRCsx/zu?=
 =?us-ascii?Q?s3iplqN8LzfQ7u1JRt72bdgbnP3wnkFcSU5/QwfPd0vAophVDWcHQMrZLPt3?=
 =?us-ascii?Q?fhceXzqM8mveK1+KeTXwg114jBcEjwTV7d+Z+OAv4iJeEE8AkyE0kdHVkYFl?=
 =?us-ascii?Q?I7gUizNnxm3sSF+l/sLrc1t7Hu85zrpnzKEeiSVg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f454af-528e-4764-e912-08dc1c59e91a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 21:26:06.9688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gw8eSm+WbDb4/JShbVuMMyPeOOH3aT2hMDCmfM2PaoK0lOXaiKoU+8B0arIuXXq7ZhshvK8iarvOuEBlFJs7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9873

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
 drivers/i3c/func/tty.c                        | 475 +++++++++++
 drivers/i3c/i3c-cfs.c                         | 389 +++++++++
 drivers/i3c/internals.h                       |   1 +
 drivers/i3c/master.c                          |  26 +
 drivers/i3c/master/Makefile                   |   3 +-
 drivers/i3c/master/svc-i3c-main.c             |  79 ++
 drivers/i3c/master/svc-i3c-master.c           |  34 +-
 drivers/i3c/master/svc-i3c-target.c           | 776 ++++++++++++++++++
 drivers/i3c/master/svc-i3c.h                  |  14 +
 drivers/i3c/target.c                          | 453 ++++++++++
 drivers/tty/Kconfig                           |  13 +
 drivers/tty/Makefile                          |   1 +
 drivers/tty/i3c_tty.c                         | 426 ++++++++++
 include/linux/i3c/device.h                    |   1 +
 include/linux/i3c/target.h                    | 527 ++++++++++++
 26 files changed, 3689 insertions(+), 31 deletions(-)
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


