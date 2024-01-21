Return-Path: <linux-kernel+bounces-32202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AC1835820
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 23:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59789281FB2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E894A38F9C;
	Sun, 21 Jan 2024 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IfSO81QN"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2065.outbound.protection.outlook.com [40.107.6.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234BF38DE7;
	Sun, 21 Jan 2024 22:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705875893; cv=fail; b=HQ42j9+t99cvhFnhXWHRyLWHLxn1I6VlikM7lPMT05N7LRuMSyBXgI/97ImWFHeEyJFQsdFPzZ3H4CONGexzxjwkga5dNSlvo64CPa5P+yKA5ylnzQQbpn4nNhAuw+vHNNMXgxSlTCylKBA+qHRXWPdFKetFLZA0ifSdWWJyKQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705875893; c=relaxed/simple;
	bh=UZbK0F4GYapwC5GnfiWRWtb/RKBmxqcRn80ohg9mt0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LJgt9pdBY9viH3Cis7Swd0vd23VjN19lOj+9lRv4jsCJk/IE2K1lxNVbk0kyctVie5AgAHlh3Gp/LzGK3WPr4QOfyfv7E7VIGdlyTCKjFevr8DdFvN0Fg3I3wclhFYErzvXZDya67InsCSEhQxITeDXm10oig0o8xb/clAvzujc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IfSO81QN; arc=fail smtp.client-ip=40.107.6.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOkpZl9ZH7GP2TUFtLwiHxBce9nW6zFbXrus0ebkAtKT7wqYAQXmSKnILsJ2ULRoNl6jF0/+/paMECuwENAwS4UDIWHfOOgAul7IMNEdMC2TgEKpTnfU1ZDwgdJoyy9Ya1rP1SqcDrXV/V38KvcIo0FcXeGMvOVULoaT13OzrCPpO8BieRjyGy3Lrrc1A0CbiHaRHnx6OAYIPqCHWi44OCORYFCG1uMuteovYnrBjcqLaPe8hq1f08DVGwsnUwxPIkgkMOiDnEnwMCGwAhxMK3aWxgoPZV9PN7uSAePw/TAuMsIBqtCkpdvn6NhMmNVo43r3PaFbWz+Hn90dXLzRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thkdAMXk+T5jFDijiZX4Z1FVddyobFgdaE7WeZlKSBI=;
 b=OqYLuPzCQUDIvZA3vl3w3iDjBbqgEa1F+9UIqH+Z0J0qcqtkI/uVAKcZseoDG2WFxyqDYZAnd+FSH9KGFNY8LvPRnCjOa1dAhFWseZBsIS7H3PiAViST7UNqOp3Uz8AJenYt0wVqHI3+TiiyU1w1wqvGmPkGyZrPHEDshO10B7/EtNwuYN1xnPkVyuavaISgtLsyW616v26iZ8POnb0E9e1MyXhaYw+D25y83RbKWU9KNMboDVUQpFvEwvqltHl1K9d6raUfZiDgcwp1esfWuUJfFNmPQmtuHA+YFclT/RB6K0b5DKRnq2Ly6BnhRyGYWj9Vppvvi6Ycgxw6s47vLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thkdAMXk+T5jFDijiZX4Z1FVddyobFgdaE7WeZlKSBI=;
 b=IfSO81QNevwbEZBQd6nYLkpvurCMjqkUDnfj91H70QKZ2kiQraA/ktCNjQuZRiUuiJqULdEfTnjc86DwUXocYuGgyxKTjF7zdk0MPy2DFPj8nLr7xrk8KHPImtOtvRFijLUSeFR3NngqAdKobGmFcGJPONlKFEg792In3CDH8Do=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9074.eurprd04.prod.outlook.com (2603:10a6:102:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Sun, 21 Jan
 2024 22:24:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.031; Sun, 21 Jan 2024
 22:24:47 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	mathias.nyman@intel.com
Cc: Thinh.Nguyen@synopsys.com,
	balbi@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mark.rutland@arm.com,
	pku.leo@gmail.com,
	ran.wang_1@nxp.com,
	robh+dt@kernel.org,
	sergei.shtylyov@cogentembedded.com,
	imx@lists.linux.dev
Subject: [PATCH v2 0/3] USB: dwc:  Add workaround for host mode VBUS glitch when boot
Date: Sun, 21 Jan 2024 17:24:25 -0500
Message-Id: <20240121222428.3396428-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0063.namprd17.prod.outlook.com
 (2603:10b6:a03:167::40) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9074:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea9af4c-8b76-4d81-d6f9-08dc1acfc675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0r2iCx7RjOu4esFKZ4Giv3CWvMkbIknrPD7UZg5ouCgJH3rgCwz39ZXz2G/Ft0DnMLnZjyLAITXDbYhuRoWmVJh7RNqc1uKReIJKYw/hVEs42Ngb1u2XJmpugahTliM+Ftk3sbXUBeVf/pPX1EWQuUF2g39meNyx9BHt9SJy9pDI52U5X5HcHRLbdq4sO8Z1F/KraETFpwHRTdq1zZ0pca75ui4ZQ04z7GCIfGZUkGvNICEAx3kwj1MDrgjuFv7ICfSY7dShr/vfiao8LUjfxPjOpMz7xflAWfxYxeGbJI4QVPIK86YKHxJOH1muwKI8IIej39NHPUH24Uw8BBSU/wECs4opx8vndpz0faS6Fzl+v+DTXpurT6lRvqlnNuWXuub99+BHb8EMkzAx4YiYwClv+CmavHzqxskXFN7cpSa/VRA0rilEGl883ZkJQbEPTPBFfIHi/E/Aft0e4+temEWceRJxazUozJ6Y4rLnc9E2L0muOHcY9lLe7mkA2PSNO3cai+7b5laMszTe8ZqGya/+B9Hn2N4rwiaZAo+pOViXr6oLJB1SZKjr8hAdgWD+fFZMyFHC7XSxiO+Odf00IauF4wsQW8GxJ1KoMVRkt9n+01NhTnW4Uccwobe2FNFkkdmIyDxQ+PyM7SUmeK1AUoB0/OleIVB9gzP/VgrPY1A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799012)(64100799003)(451199024)(86362001)(8936002)(4326008)(8676002)(316002)(66556008)(66476007)(66946007)(36756003)(5660300002)(6506007)(6486002)(2906002)(41300700001)(52116002)(4744005)(7416002)(38100700002)(38350700005)(83380400001)(26005)(1076003)(2616005)(6512007)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q3e6lqyFlMf1v15vlnQaP61ix0eGHojo2/tNcbuy/06o3UIVWjbHCmHWmPhx?=
 =?us-ascii?Q?VM/tIb0/FIEiOJxV9E5uA4K584SSYPWZeuKvv6T/qWbH1w/VgXPVCOTxIxr3?=
 =?us-ascii?Q?yoCfE51s93rWtmLtP1V3ZGNw3u/yGtWzp0xxlsiDkxFzG89Ahjnza203og5Y?=
 =?us-ascii?Q?4O3eBk0OVMrkQuDdDGDXfH8kQpmsTERGnbc7sSsN3qvF7k+Z0rPuqpgta6V3?=
 =?us-ascii?Q?pJWeYyBC6/O7pKUiHytOkE90slaRD1jiX4RMA0E4tzm9nxh8az2LxO0qlipi?=
 =?us-ascii?Q?NgI3GHZtyKT5iV1HedwsONMmQDELvfPDlA+JMu3r/Ui+0gU4YevxHnPXrjf1?=
 =?us-ascii?Q?s/w0iTe3M3k2whkFsWi+EXI98Wd1el3kXfJLWVuL3Phr1zEt5lUUt2x4j5MQ?=
 =?us-ascii?Q?6puWJBN4Yg07OI3bNMpI8SH29NttjydjulVqytjW3NTnLnMhlf2zJ9+j5Wmj?=
 =?us-ascii?Q?wFnnDhqeSkM3svWphD9jsvyfgH86gL6Xt0SKiRma49OkZEGTtjxSL4E+OYFR?=
 =?us-ascii?Q?eRa5DKmAcjbP5EJtNkgG29UF4nTO5lsXSu+Nd8KUYvxsk9c6K80EBDMLdjWn?=
 =?us-ascii?Q?bMELtVLtJFJhKeSlGEfE7iZWW5CFZSKyxeEVbB14gHn9AQ2zs0qQ/95zQPrH?=
 =?us-ascii?Q?0twmPfL9QjUNICWMSvCmEpeYftnPiDgye8tZByPksFViz3HP9t7LielYiAaq?=
 =?us-ascii?Q?DvCiK4h6Qtz4G/uogjzhu8K8kZdoeN0NoAki3EkRAdtiVhyF9TJXn+W0t8D9?=
 =?us-ascii?Q?kCVMCNgfvhMuiL4kwYnY3smbqIVAPqQfdvzSJFBr6lFIVGT2BpFqjFhLfWBF?=
 =?us-ascii?Q?/0K0R2DN59wh56/AzIeXvleHQ9cv/Pc6x7QG5nW9XZBqxbSm/Cc/U44qZpS5?=
 =?us-ascii?Q?eTfyL6ndWopWYod0lH6MZJA2feptsKdQjJJX7Md5/WLItKuqSunaod8R86kh?=
 =?us-ascii?Q?LpUJHnXOdYA8dATUsj8ANaa4vm7bM/1mUjUq+4KP+SGWCpJh3/0sfxUOYTtc?=
 =?us-ascii?Q?eTHCj57KfUxPmA9VfJK4339IXsMP2yWOFx28pxJvq9aQqwTVsS6tsB3Nrh1j?=
 =?us-ascii?Q?vVjvqP+Yf5bWFYhGD0LDg1Zw1M9kvvIGmwm/6x48apfGxOieydQlhRIjsKm9?=
 =?us-ascii?Q?oZO2gNZ9b1a7DE1jxPiS49b7zS2S5V+8tf8Wr+nBW/KbWq5KLvOqNpYIoIot?=
 =?us-ascii?Q?SSRfXt4VFAvQkWv6ickGYb1e0+f9ImYAVH+VpDX4OByGKgxSQNf4JrqsuPl/?=
 =?us-ascii?Q?5xZrGHildOq/JEwJ/fwNokQ5eUQRcDUJo6AYSCgYnIXwVbW1XqrhCauHiJIF?=
 =?us-ascii?Q?ViFwquV+ZH0bBEg7iwfFPfokwtO7MBU4v1A5KYHIAgHuG+sS3Yd/UWGQfzFk?=
 =?us-ascii?Q?c853Hehg27HU/ZGgi4Z1uzuyMoPKBypT4gxvBO9CXm7t9eg7ym0wZ+UoxwqS?=
 =?us-ascii?Q?FvcN5mlMunY/CABA0MaqPCwIBDcyQUY3uXkjq5UbLq94Mqysb//viHpGKhqi?=
 =?us-ascii?Q?ELY6+LeVXAaBnPT8H+CIFAvpxy5RHnWdfOCyhToHWgFlsu2erkLrjuSoRe1Z?=
 =?us-ascii?Q?eXdbJiC+L8VfesB0hw4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea9af4c-8b76-4d81-d6f9-08dc1acfc675
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 22:24:47.3592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BviCV8h7YoviBYM3K84vjHDWEGxlvMUquK0zWEFCn9vkTlz2yqO/lcK6PuVjUO7rfUz+8TiO+nVTiLnirutvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9074

Change from v1 to v2:
- splite xhci.h to xchi-port.h and xhci-caps.h to shared marco.
- add quirk subfix
- fixed checkpatch error with --strict.

left one warning to align existed code style.

CHECK: Alignment should match open parenthesis
+	dwc->host_vbus_glitches_quirk = device_property_read_bool(dev,
+				"snps,host-vbus-glitches-quirk");

Frank Li (1):
  XHCI: Separate PORT and CAPs macros into dedicated file

Ran Wang (2):
  dt-bindings: usb: dwc3: Add snps,host-vbus-glitches-quirk avoid vbus
    glitch
  usb: dwc3: Add workaround for host mode VBUS glitch when boot

 .../devicetree/bindings/usb/snps,dwc3.yaml    |   7 +
 drivers/usb/dwc3/core.c                       |   3 +
 drivers/usb/dwc3/core.h                       |   2 +
 drivers/usb/dwc3/host.c                       |  48 ++++
 drivers/usb/host/xhci-caps.h                  |  85 ++++++
 drivers/usb/host/xhci-port.h                  | 176 ++++++++++++
 drivers/usb/host/xhci.h                       | 262 +-----------------
 7 files changed, 324 insertions(+), 259 deletions(-)
 create mode 100644 drivers/usb/host/xhci-caps.h
 create mode 100644 drivers/usb/host/xhci-port.h

-- 
2.34.1


