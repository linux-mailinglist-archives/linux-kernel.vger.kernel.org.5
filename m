Return-Path: <linux-kernel+bounces-36169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208B6839CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA9D1F22036
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B89F54676;
	Tue, 23 Jan 2024 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gs+srFLV"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B32153E2B;
	Tue, 23 Jan 2024 23:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051470; cv=fail; b=fZlDO5laEC/1MY6bfwYHwi+QDe6RCOT22tvffM9YQ9Lgiefeo/Ddc7TRIBweRo1zzEpPh7c6kt+4KDrNuVF2caJbYtUl0OebhVHqG52/hrtlhSaGPj0To1EWBr6bVvSkNblJdoQi4Flto9MUFr3VFV97Nz6mvuyIm4C0xwaIITk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051470; c=relaxed/simple;
	bh=mn0ChQxh9SVQBCBFCFxbD44mymz+sMRtR63H/bfwNxk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uCF1BIreEkkZo0V958fn8cm41k86o0QlgHWLkYXLgZKmHgrNLIhjARvDF08WuILcRY0ImjtxVbrq/Bo0/pS3O3IVHV1jHhiPN8028r4DOKRHInSL8gn4q/+aGgatVUGTXS6Zu4D32RMFNP9T81AxLmAwsm2jlJMtIUN3HPTJMew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gs+srFLV; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBhsYgBYlvDQu1UCTjFjIKAPuPyY/fPz5OixCEaUCB9NYjxj+eFVgiSC5ZXVc2G5jJQNLXq7GcNDDEg8Ge/9Yp7Wmtn1knl8avSzGbkAE1MEQN3HIzewlaZTl0ckeeeL7xdLgx84xCMull3+CSpVUX9lR8SSVqPpne2Kq8BrWTya8T2RyCqieLEbugVeyYbnZTx1qNIIGO3u5NtNJ7SVK1TXPEgi20XDi0nId//iS7NGXOIW9lXF90EiZHJ7pZYaz/9Qnb6TYK+XR5hBaFsfwByZyOcZaaYxwwSxG9jmK+V2OCXuiYGfpAdzA+5Tu5behCBsJVGbrUNhiJ2/0O5vIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMAF6N536AjPAoovcp+vXEnKbjyZDtfqPFMlyEUT7Z8=;
 b=KPbFET/nzlEN3wmJh7Kn5ZxAbugb1sqF74hBiRGOStyAVSUi2/zzMPjEG+ZwjipyaHsOzcjtzQyAsBSEjqY04c8K1nF8kxwxgJYw3NUCLTzINemrWsh+aO8JAE7u1x8FWnl6ZPoYuScQlJ1XAd63OEAeKb6z5/kSIVFRcZIvvplIjpOlwFKt1X/jBAzt9lRjgMBJhLZqP7cfIOf2vzVeryLTXqsV55AVoLTw7kPLQKDyxrpro39UMzVQzIhawLvr0lV4ibt0xLm2nqOGCsRL78FGFNYyPDaZmSrvwpVdHIp3TDe2PKftIC+9yfq1ZYxedXE7mi58Wd8PjKGqTjnhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMAF6N536AjPAoovcp+vXEnKbjyZDtfqPFMlyEUT7Z8=;
 b=gs+srFLV/a9PDYOoQ7Q3nnYkt9aN8fLzluw2Xa5jdZAyikaHENfrl3DhWwznOc0sBwiXUjD4ujb1hOgup2cQk29JUxqWBprZlPFV7vAGGpAJcU7/0HLD6B8VWhz81lZ6lcGCV2CFkJgXv7flgnG18gO93Thvr8f6hN3RHIMTWQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9475.eurprd04.prod.outlook.com (2603:10a6:10:367::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 23:11:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 23:11:00 +0000
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
Subject: [PATCH v4 0/8] I3C target mode support
Date: Tue, 23 Jan 2024 18:10:35 -0500
Message-Id: <20240123231043.3891847-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0371.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: 3456597f-0e7b-4ac7-4b23-08dc1c689046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qy43zR/R1+OHmr2vfKvDkDHhfLM2OmL0guswpdrjU5se3S5J3YZuxTP5umh6OIQyTg/CrYm64FrJph5680ltbpclkey+HFTO4LNu+0Xd7bOnFYJO7dmVelwbK5xEo18WBaibTY9j4caUd/2Q5IsnEJmWQb/AU28ZFLU9sxzYK58g8fpgmk9jMhq5U6Lz/XtB8cmF2Gf8t03B1fKmuO0WKZJ70B7SHloP6mXMelmoaBlxA8MgQ61KhF5fcZYsE0a6KckpaChNOPEsakZVuE2L9mO6g61v6l+JGHMNAVGl3aM+9DY5qhOCqQ4g8b6E70QN3h65swLJb6c7Duu/D78bBnfzP75YPltDJMNlZwQlMSkwHnui/BCvZxLfvsULI4DSaHOldKnhsNkUhFxDYH2I5G+fS4Koz49aX+4y53zZ7TmCGhJMOjyKO8jQbSePug0b2fN4Nd+GlkoHkTZDajlwqG5ctle+ySYJkQMXlb8jRk4INmrEZE39W+MlBBLeAGujsqPdXjSv7fl62s8i0KFsgOTLrRWtsZvgMDOMUH5KAWgqj6VacSbd0wlYMtmVs90Ck1BTpPWojQN6iCgy3bxRHVvXy0UBmAmSeKVbhCBiA5C/j1traRAKV5PS1yL6hqqEI61wE4WRYTc9D9oaqBBEvMWdbFe04FTF9HzqdGx5Oxw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(1076003)(83380400001)(66946007)(2616005)(26005)(6506007)(6512007)(38100700002)(478600001)(2906002)(8676002)(34206002)(8936002)(4326008)(7416002)(37006003)(52116002)(5660300002)(66476007)(6486002)(66556008)(316002)(6666004)(36756003)(38350700005)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gY/oh7/6tKBBkUYkWGMpoGVJRXwqPA+KkX0uOCcqPpLnDKbUxNdFOuvyENLY?=
 =?us-ascii?Q?ouOSZv/2KGpn2DNMLLT+2jgI4Lgx1P3VDOIin87xZT53JhjztFB4bA4rn6yD?=
 =?us-ascii?Q?csfTB3joXjvmRWESbt3Qas3UN8A0lVupVY/KK12pYo2TLatwPqUQhUZ/Rg0W?=
 =?us-ascii?Q?gtTq4GgoZWi7suIj4VEO6B8NCvfl3zZBonlFfBZe6zPWWOSVe4Y0viON0bJq?=
 =?us-ascii?Q?9bNX16gbRhcqmFObjk9bB2M+hiYDgS1tHj+vtUFr1DdI0WZx24fg3/PQcbuQ?=
 =?us-ascii?Q?dLQDwgXoIyjEUJzx1SQsASJ0gl9vzr+Xfoa2kUZGepbmgJE3nJkf2jRLOX6U?=
 =?us-ascii?Q?ltHtBfrNplujtaZpxW5asaN2v05mMkojDyJvjANedeNoL/+Um9Fcg0RqpLsW?=
 =?us-ascii?Q?4WzX4r48WKOc+q3JOCwmDyiZPn9VVjItZSLap6tJ9yosou3pDXiJLNq+Em0B?=
 =?us-ascii?Q?AwBvnPRw1K7YPDZVkikbxG5PUp8x5IyO1eu1Km0GhmcubBqdyx8Eq8EtFpUN?=
 =?us-ascii?Q?JAxRqSl/fVarykL+ClUnljY0x17MgSy2pkGj+3KwwoWfIUHibeEcBkIktiij?=
 =?us-ascii?Q?GbXG6IL015wzUCUXB7VLNSFNVnZtYRiM1sOiJEFj4265ihfIRGrFfuEkjro3?=
 =?us-ascii?Q?OqJUrQbMY5OZhslxmD4qFl7M1cjcyYEu2OMFjBBJU0IH4R8cIpRfXZ8ODmi+?=
 =?us-ascii?Q?zCBFZpsWE9Mc/o35qfkpIcl4ySXXAf5AWz26r6rfDUQSw7JsbQsYR0gVrZ9H?=
 =?us-ascii?Q?FMzx+sh0rmioBZhlAF/4G84Vd5kZdHrVC3HbVBs3XwpPDZygNWelukwIk4vL?=
 =?us-ascii?Q?WZ4XiaYETPNcIZmJz6n6VeZoN0B8yUGvu+fNvg1frXzqeHuP+UVHfgMo/u5K?=
 =?us-ascii?Q?RADgMnx2QP1uzsR5OvG3HxbGtxmx6J9XGQx+xASmWQATtX42wN7BQWNaXZoc?=
 =?us-ascii?Q?A7sArNRYYCMGG0AXrY1T+3uGf3wravgj5j32KhmrLvVrqBzQiivZsQMzB4pg?=
 =?us-ascii?Q?2yHRkXENB0eSI9L/RGBosZOrcPPkXDWs9RjOkOfqusBvOAMgtbLIJcSk+Ouu?=
 =?us-ascii?Q?rc9IbQPQRxICyUue/npcgTXEwfFiecKh1vN9uvJcqfHD+BQuvFbsiPrF4+D3?=
 =?us-ascii?Q?MsWFXslPwcYK1Fbt3vO8G+ZpDBk8Wm2cZfw2M7jZmdix5Z0WViqWEtzSAuND?=
 =?us-ascii?Q?yqGwCPeyGwA89peXYNp7fObotLpUjkJWxNJTwJ+Ly4jzx4VIUPcN1yXxON9K?=
 =?us-ascii?Q?htYVBxLEoyTNcGtBauZTlrM+J4C1wMVDkBbiTx53rY9w6rnCoj1yTykDTdZC?=
 =?us-ascii?Q?wxvrJfqqPdt6bd/048yYFeNTf+fDtTGlsFUJJKXifxLMCxlC3u9m5SgA6jvC?=
 =?us-ascii?Q?xzeJ1tzXgGfhh8JmwZE0k5JVFSs7/Dmioy41KsJUSSHmaNlYLQuVQWAYyew3?=
 =?us-ascii?Q?MVz3/CyNtuypHj8D3qyPfiO8jYvsQ6CqUdFaMRohZBk7aMssGytK4bWhwFds?=
 =?us-ascii?Q?GC12IyTIHnrpxQWvj6efE+2lhZ9QLd41Ngh+0mRzSGRvg0/ajXmDOHn/L+Ys?=
 =?us-ascii?Q?sSBxjLgAGLFxBBml9oRu6pxp2XjuWpZAZ+SRnmoG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3456597f-0e7b-4ac7-4b23-08dc1c689046
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 23:11:00.4329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asamxWXSIxRSPg/Ki/GZTh1bYm1IV6IKveqkWXPvYFPThElLP7+xfs79qR78qrG0PeJXh00VHYOnAH1BRhjA8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9475

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


