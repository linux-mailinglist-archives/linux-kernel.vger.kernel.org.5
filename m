Return-Path: <linux-kernel+bounces-50693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FC0847CF2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446E51F2752B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2CD12C7EF;
	Fri,  2 Feb 2024 23:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XhTErwsY"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2069.outbound.protection.outlook.com [40.107.105.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9692212C7E6;
	Fri,  2 Feb 2024 23:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706915388; cv=fail; b=UsSK4qN13hs4kF+9x0HVLCOeqgg+xh6ypLLI7WehFOnTYezHCOc03SqTCx34AT298f1Mw1bzMLpugw24aunIg8yu4uxeYfmaJrTRp1KNQdp890SI/lfoZrxDTGKXA84mP0rSmYDIMZpp7bOmLuAYiUcn9DLrPvIf/HNcL2JrTh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706915388; c=relaxed/simple;
	bh=lpo5yoDxEjAMAATeuR+ObkAv5g4Z/DAVD2hkbmgALyw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=l11OwP4//ITVr01rbYGa3jtSOXtiSF2TUYoJh6xQ/Jkb/+A2a+LrTL1odC+Hmf7r1+Tszfdk/E3WAFIRSUnLOdgOibRRIaLA1qF/kpjWL7tOKXVxsUjUrUeNXtyAf3MOzHQS7MO5jJ+vIwcK0XYsH+Aun54NnxIr4vvhuCjgZfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XhTErwsY; arc=fail smtp.client-ip=40.107.105.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ci1CkSiZdn6/ONSYeiJg1Qu30MC6vLgMLE1CLgsrtdyBY+6AIx+o8E99GJH5HO4mAbhvZ6HFSn8O19ZdxYqdoHcjfEsaFOIpCCrxpGlMwZ8X5IvUtIWm/N17tFO2holabYGGIg59L/WlgpraBuUIr75yA4EChQEUjKTWYSRwdd+RPzVUul1KiXXPfP0UIGyhxfYlVlFPJZYJ//CGzGUl2mAnW1IeOiN5+6IKd/h7lYlghxNbIjt9JCyKq4VECGjeSbZdxocLOy+VHA3fsREJr3SmJSisZ12fclHHg8dBgiCeVUbGsdL3KyohYP2dcqPg49FRFucuFSJg22/gozFLBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byDnXsXx+ABdHA0brvZRkAWtWoHaTwoTe+9Xa1hY668=;
 b=dbzhQz46SAMvtlv8EiIRJeCM3g2goo7g8rhTe1nHIQxO1UMJFa9qtuMm98RnEG01lzfnjEmWW4S094gbEi/FxFObsSGiAnpjY3m3YlcByQMioJj0yr2WvPePfOFlmebicfYDugavvUR1aTTdxa0Bh4xNl+Jhac6ZH+QoU+JYBbGJNet/OUkPvORiJmEQlbusbYS4Zut9Za3Vk1lGVCKWYjwtVpYH0FGnWkfzElWKK6c8ru8rTmcH5dUuYO+G6U0sWtxIDdJU56hnEVVetqyy3NvZk06dx9z16xDOMVjgBnExAVssZhtNevt79vKtMu8np3CQRxkuRDZs99l3hxrM/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byDnXsXx+ABdHA0brvZRkAWtWoHaTwoTe+9Xa1hY668=;
 b=XhTErwsYryB7L7uHHUjlmlxEd4GermKrjUONuRts0CaDCzq2A9mukE8XGGEiDRsNl0SJO7GF+Z3w0S5a18VcOxReWOfAO7RGbhnGlpD4lA57gmAc7DEEN6cbg02TQXWstBvWeI14OE7mb9IBsUUpitxD6DIFk/UVY0KgtgtV9pM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9997.eurprd04.prod.outlook.com (2603:10a6:20b:67c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 23:09:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 23:09:43 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com,
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
Subject: [PATCH v6 0/8] I3C target mode support
Date: Fri,  2 Feb 2024 18:09:17 -0500
Message-Id: <20240202230925.1000659-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:a03:100::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9997:EE_
X-MS-Office365-Filtering-Correlation-Id: fb06fc0f-3d3c-4527-35b3-08dc24440a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	waJv7ypB2BvpRoQXCOLL1t6lc1z03UQK6pHJ+IV8HlOYyhj75BOsHGs8jmwXcN5QIvypTXg7C1eij/fCA9hlAnM+Q4KoLNUx786J4u+KL1Du7dle5MpBTa6/CTCCGtoYrV5I27eEjWDQsKu/D27WiujDXVi56jqew3pbJnEPjQ9iQNmy9iSigANnIbjuKgScE2xuAwJUJoHLdxy87xYNcNcDHFm7dqyzk6UycVnRHYCoJXm4ieYbbZp74UinGCUPjwQir3fEzFnQqwGkydpz/1h8fXBibMjqbmI33jdDyc1DxXCF6klZ0g/FaXf11ych5vkXSquCJIvz1Bu1WUR+aUXiqiKp+FLJcNigS92y1wj+rQ9O52VZT3oWH9DVg95diWstX60svmVfVucgLV98v9V2/iF3PqRFN3CeG0cpr8GrwZ2jPGc7XDSWU2dFecGRqEjuUxzKJD6dmGHhls7G9KKpl2m3AjU+YXgs01wS0bmgluZ6JKtEZ6W5xYiTepoQC8Pce+aqkhYkofzyc/Ht1p0HkdHSU8eY/rvCRuWigJGryr1EYqHaFpFJeB/8C/C1a7Bk4Bwl8xplOA78i758m+OS2rIu4rJ7PLiLLMPf2u6mNmOiszwU1d2TZFCAC6tz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(230273577357003)(1800799012)(451199024)(64100799003)(186009)(2616005)(1076003)(41300700001)(26005)(38350700005)(52116002)(7416002)(6512007)(316002)(36756003)(37006003)(6506007)(83380400001)(6666004)(478600001)(66556008)(38100700002)(66476007)(4326008)(6486002)(2906002)(86362001)(66946007)(8936002)(8676002)(34206002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9hQumafEq0tIQ50AZ1zOsgLvyfHrpCm3imAV3WyiyMjxIBNaBpso3w1T5xkI?=
 =?us-ascii?Q?RaOjQxZcdDwOClaqOx3J4sj/9nQBGgx0hfiCp2CQg9BwuaFsvCfh8fzyFxrc?=
 =?us-ascii?Q?TCWNb2Ae4zNyZJpkdbVVnHVV5Ri3M6q6Dxx5X40GhWD1MankdBpXdnXWi9/y?=
 =?us-ascii?Q?TgBg/XbryBlPJYJdRd0I6EZwHRNEMxsrCc6bDGX89zZUQ3lqEzpIChVnn+9k?=
 =?us-ascii?Q?3z7RxdMbLAAu+xWexD0S16zFWwsc1O7vU3wAjzhAwt3YfFlVfOYTMJ1QHQJ9?=
 =?us-ascii?Q?oaL7TrqSzuriDEswDkQsHuhKeM0KlPdsY6kwi4GwRxDA3YWw6080wmFSsSai?=
 =?us-ascii?Q?dditZOqWop8wKaWXFaU3olvgcuQKu/bc0ZTw48rOm0Ajfd73MRlOvmfMXiK3?=
 =?us-ascii?Q?PaYxQVjUyBUjD6ktIKMSsDB82tSMBS50Ar+JytwkwewgA1ABGslaQ/cHqTMk?=
 =?us-ascii?Q?PQpZA4FVjX9tpt28ms5lH1Qa6CHJaWDoirtmKzajH29GIA5mTDtdm50AY0Xa?=
 =?us-ascii?Q?Z4XK2KdICBsQEJEC2ILyU3UNUT3rMR4TOaDyaUuYdWCQkrQWPgmhPGL7YhoY?=
 =?us-ascii?Q?ox8c5aDyh7OVi+UlgCjLIgbIA0YbELwA7+cCL96eHyAIqBmD9Cr23IEN95Bb?=
 =?us-ascii?Q?6kxPElXL5ex210V2jsAnPAtdzUhsdgkojZcERtLWPPgSRjEhIEyfcB+zUql/?=
 =?us-ascii?Q?9cC1Q0cAGXq2WQSbPP/8bKhh7J6nGUYVhDVDLX9bx0YENo222DaqdKYAEEru?=
 =?us-ascii?Q?uF9ZXXsc8HsvWY5oGmwbeAvxsXLSSPuqNVYphXK4bid+pBrrL02ArUJvzI30?=
 =?us-ascii?Q?Qyw2BVuKN6X+Rg9U6YIG+L66unVovh645zI8vIOYAnnHy9dDu26I/fYGtrbr?=
 =?us-ascii?Q?C4kgXKHpy0XnFOosoaNcK7/K4ImWxWMvu+uibY6RRnHDCqPDaDrDWFe53/pK?=
 =?us-ascii?Q?X5CnBWduovXzexY80D+Li8xRtq70zlj5D865JZ8ptdWMhXziARe7OHt8Emyk?=
 =?us-ascii?Q?F5+StrVXryV4aJA22omaEpxMsyd1whM4fucbAgyB1ePdGg44QaC5c5gf+Kav?=
 =?us-ascii?Q?X0cJpD3lWpdNGRBUi2h36ojbc1VZLe0vvN4o+2C7a3luy1My/LOdWidzIDRI?=
 =?us-ascii?Q?DjPS4w4dAfstTFcQqEvNtgcK+VQsawLW1lgg53ZKvMVOJjAqKY0/LLcGiNSF?=
 =?us-ascii?Q?Kz6ZJ8iowRfb15RVCsOFjDQfy/4lbQ2tniBrfpcKChXjO6zQr3L81gjQoZXk?=
 =?us-ascii?Q?D8B3zZpBLuqBIspqFgV3VXct6rwSyPLpg6kS4weKZojpR5Y614xcliPc+Z9z?=
 =?us-ascii?Q?g8meh+M6fxjWJQnizgsIJPXoH1lLrkMUFDXNtlCiUkHarLHlIXOKJU7jQrUw?=
 =?us-ascii?Q?NvlhssgmUTAvrPo8kqiIIu8vT4d/CcFKQJSZxKi7rIn0Q9hILQoHs7rd9Uyl?=
 =?us-ascii?Q?VIYlh8jFe91sYA4rJysYFn+5GGtwP41gLAoce/cAh0l2fPutIaLoXqUfS5MY?=
 =?us-ascii?Q?qfeNzJ+Z75PECrGatBjzedBZD1kDM1wzthogCz0M07HG/PSpJFzH5zOj+8SM?=
 =?us-ascii?Q?d9oru1Uh/wnAfK7P8t7LFgu7wOMv7tzjNT2XRzQT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb06fc0f-3d3c-4527-35b3-08dc24440a85
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 23:09:43.3860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyMip/sdnqp4kG12Cp4GuxWAPtPHAiGkcCJDGcAvPQqSg2kwdZW7G1lAG+lJPchsOVKkI1STSNM7NIHtIOzfJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9997

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
 include/linux/i3c/target.h                    | 548 +++++++++++++
 26 files changed, 3712 insertions(+), 31 deletions(-)
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


