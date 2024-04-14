Return-Path: <linux-kernel+bounces-143975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC68A4042
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C581F21769
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C9C182B9;
	Sun, 14 Apr 2024 04:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="m9rgvtza"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2113.outbound.protection.outlook.com [40.107.101.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DA917BA0;
	Sun, 14 Apr 2024 04:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713068603; cv=fail; b=IVpBQ0RNPqt3DFQQ2GqUpcvgMTBBxGFAsL/IZW5RPKIfmDHhWwrrg4i5+rng0S0cVBysCCy/W34kEjElmslBjDc7678TKKgCiy+stmCgqBu+EpJsg69yr+YxkmKwac1Phng+04tkc9iW1S9qg8qhtdslupW4zjkRaWruELWzm+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713068603; c=relaxed/simple;
	bh=mmaVhGP7BqD2Lh0uUonD7lggAjMKoPHuykslGqzCX10=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Rc09TNAJLn8EFuIAtXOxsi3v0rgXSTKxg7VF28O/54PLfoGOaYQjAr39uFKfH5jOhhncdHgLNwZBXqiidw9R0cEyQGZ5ZDk+ealIYd2vZ/1baBrimsA023BfOaCgriD7uK4ntNG/Cbtj+9zoxTZMZ8j1cUNGwDWhcv3W7QWlgbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=m9rgvtza; arc=fail smtp.client-ip=40.107.101.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9/D3xS0AulFu+qUcdZ1b7H30rk4jRfYf9sRUuaZovwa8EryXB3MDkMaX6Rdw/ALJ3dovl2C4QOBFW2ynfunjDgpLMmxjWYYHiEZWYiQvBABR6EI6T7lxWKgvq+TBly8ZUZPzUOv7arnGYUZBtYuBlC8hck6/DLdMKm/03Uswu/CeD6Pgph8zPEKPpxFvoqBtsdrxah0doM17Rx2JhBwJ5lSUSemaIaDohHLUBstUywTS+/fgbEUOOqXZvrZOHF8ucFp2Jmo1jR8tdGcPD3IqpNZFC3cQ3N7nXnp3PPWDUi0klar2YNxmUkLyhx8N0DCs0AEDsjvELYyxH/1dq+rBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51HvCMz5741xwby8iTh+EIr4OPT+GTf0zOmuv574x9c=;
 b=akuEbsk0WMx2yxdypOF48dt7hDWHvARxK6tpVJD/9RGuGxkSeqLBMcVn+Z+031+w0jGXpcUvietM7gjByvkGP+UXY470kWJzQfFlV98TZv75TJgUYrkcSB8dRkm9wWr9ABIB/10MxRiyVToP9sM308kILt9nuA9PnJ3rO2yH3pXBjiTxQMWpVf68e+6sxA/A2pHrbGQiTfGhWGkc5VvB1Z74M46wmvfa4K67UvVkCUhFoQL3pQIwALpy1mxV3CGcYXj6gXafcex8bL6B4CP6BIx4GGz5BtmboQzIazUh1RQHK9ogH0l7EBbL10jTQdHh1RUE2x3vRue3TKuSjsnWKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51HvCMz5741xwby8iTh+EIr4OPT+GTf0zOmuv574x9c=;
 b=m9rgvtzaPJHbUH6u11KNF/Jy0Eh1pkYYsUK9k8lj2aoTjiEnjHCPVuS2iy8o+EAqqp+TG+5MGV9VDy+OMeP3lMbYG7TiL8QE1QJSaQ5uRCt7b4b8orJyLn57Y2ZBkxaW/y9EnQZx56vQl6P4bKqm1aZ2v8XfGsSbgdMyLGF1fIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB5947.prod.exchangelabs.com (2603:10b6:5:1dd::12) by
 PH0PR01MB6715.prod.exchangelabs.com (2603:10b6:510:97::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Sun, 14 Apr 2024 04:23:15 +0000
Received: from DM6PR01MB5947.prod.exchangelabs.com
 ([fe80::b557:13cd:8a29:ae08]) by DM6PR01MB5947.prod.exchangelabs.com
 ([fe80::b557:13cd:8a29:ae08%4]) with mapi id 15.20.7452.046; Sun, 14 Apr 2024
 04:23:15 +0000
From: Chanh Nguyen <chanh@os.amperecomputing.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Justin Ledford <justinledford@google.com>,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Open Source Submission <patches@amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Chanh Nguyen <chanh@os.amperecomputing.com>
Subject: [PATCH v2 0/3] Update the max31790 driver
Date: Sun, 14 Apr 2024 11:22:43 +0700
Message-Id: <20240414042246.8681-1-chanh@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0216.apcprd06.prod.outlook.com
 (2603:1096:4:68::24) To DM6PR01MB5947.prod.exchangelabs.com
 (2603:10b6:5:1dd::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5947:EE_|PH0PR01MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a73d39c-f9d3-4ea5-5862-08dc5c3a99f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eMpqNomt56TFTXmjnW84NP6hRySMUWTAxYUyV1vURv84nZtk8dGTwNCSI8aN?=
 =?us-ascii?Q?adsgUuNtm6W9MyXURgra5gEwrrIKVlU001ZQv2X32iGVv6v1bUJUwNN9g+pI?=
 =?us-ascii?Q?iZ0vjbuQKls8LxVXrIguggCi1JE934sZ/2ZIzZJN9NZyOwbV5576glhTv1UL?=
 =?us-ascii?Q?3nqc1iDNCo/hiCmrkNQi5SANEi82FFAeoLIg+VMVi6vzQGZjaaBQZihPGooB?=
 =?us-ascii?Q?qOsYDwdvKgnGLID2IIVZ4ElagT0pGCCOz+AUPOWpCQERGxu3Fzr2pCTGazAT?=
 =?us-ascii?Q?+Hs1jgRDUkyXZRYIiwsseGaSd5E9/EKLI0gujmVV2GkdeZTqoYDfRzUFWaAe?=
 =?us-ascii?Q?XzKjk5GuNtF8nn6blVOHJIWeUTeqOeJr7Aj6H5e7rnO6G/G48d/cD2beuvAO?=
 =?us-ascii?Q?uEdgSbgBeipMb6DsZR22PLoAeTbidr3eC8jQdLRgSFNW5F/2M8+xnfEPrz57?=
 =?us-ascii?Q?dbC/hcVoMpaqZLFMPtaf7KRYJ2h7ALxYZgfPKi5xQbgL2U7BTegEhz0Qb949?=
 =?us-ascii?Q?zc75G1bShP8T8B0IyNeBQay5i16yqPBy1B+1B96S1bnEoIm6ptmk1rSRBn3e?=
 =?us-ascii?Q?DYG7Vm8ivYJ+AnMKChwt+vi45Alkn/MSpD4SEC7HWYvFkvOuv6rJXm++kx9W?=
 =?us-ascii?Q?KgHuguRFB9WPRpd2ztIr2c0hGP9hBWRvwFgasLOU9ulk3RINr5lm+bWlcTAX?=
 =?us-ascii?Q?1nD5zZZ0lzAi+Knz33C27o/e46zdawJDMgCC5Gqz0TP3sQTHQr7G6NOeXRMm?=
 =?us-ascii?Q?z4pb/QLjat1WNO7QyTVhpnZcaAqFVtEO51JYspKLqRX1WKfJ9Zjl2oVOlW/1?=
 =?us-ascii?Q?YhveUVN4hYNvYcVqEVwcPmzEGqVccjMBqRPQVLgbPw5UiPxeXYUQeYipP+sg?=
 =?us-ascii?Q?cH54FAmF/SNtWupR+XmAyTYxBB7pil85oZTcZzzxuBEQ2YQp4GSmVvOjp9/j?=
 =?us-ascii?Q?PPrj00oSHQ6eStzvGElQqdA/UTgqjIjfbM+w8YOctFyx+xYQ9/JryH1nfY4d?=
 =?us-ascii?Q?g9lLIHXEIrOdYTzlM9A9mB5DhWPsg+medFYyeut4zUT4bDiFh9N4tONQ4TqP?=
 =?us-ascii?Q?qPH1nz7BPE4tkGpJVbqHeKPOoL/YVG8ah/F9gZ5eNNl+QPBOsTnEB8VsHW6Z?=
 =?us-ascii?Q?AxWlBxO3AmeL8lj6pjt5zXX/Yomhic7JNgySn3zEmR+dTccdiYh1VnvR6wPn?=
 =?us-ascii?Q?UwQ4kB07aMGUlGn6Bj+x7mkYIIbYi/itMfRfUQBpzQPrkbLCnCiGnNwgG1GI?=
 =?us-ascii?Q?Mm0CZDYQf+LqoPbATtc7Zm4Tlu9uVu4pBuerQUHs4nTmVGxI1rAQR2CUa90v?=
 =?us-ascii?Q?rhVyyexLfyDAEsbUOmcdhIyg1E6y6pShlw3GpSe6RhCSQv1+GBipgfoB6XMy?=
 =?us-ascii?Q?VbDYxPs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5947.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A0B+OXfP508jEw3WpXu5B5Zc4rUBaPl0V1BsMCFDEE/Gl1DoFDoLJWfukDN9?=
 =?us-ascii?Q?B4erFgFch9xN5bLnl0wCvGup8gT9HqADFvAC1In/1iWGhWNmrr9o0BeGoBpJ?=
 =?us-ascii?Q?WNCnz/xcZX+65fdbnCPkbAiwXMWJ6Wo7bte6cPd6LsB3OSryDzIswmq0HWZb?=
 =?us-ascii?Q?g7xxre7kFWvASF69aeGczEWg4cmVCcIy6LogUjjeolPrQQLNy/1aZdFTboFM?=
 =?us-ascii?Q?diEzIiYmnNC9duLrNA6KWCzi/0DY+Uy5buItBFQJtOMy65Rl0YpWf7prJPX6?=
 =?us-ascii?Q?1yFsdC77L6pAqE2Dsxd5zKoDv2o5/qptWtD6jpWsFBnqRagcmguOKxAozg0T?=
 =?us-ascii?Q?rTTR1yIATmLjO40ogxxSUoo8BtHfDWdtq8e8HmvoJgU5a3NgHtVORpvJ2P6P?=
 =?us-ascii?Q?CTt8mOUWLl69GyuknU5upomZLNPe9AQxL05urrVcdu5rqjyheuKDkKTMNTIM?=
 =?us-ascii?Q?JtsJ9m+uBX3WwsUCtcnFZjt/WHpM8XgPC9qeIjoxnRnFUwfHKyeNLLZEvLu5?=
 =?us-ascii?Q?6IH4LZtSXVEa37caW1BMoc02ln2u5NVVHXOBy0hJqsNOpIjn5J7pVyT3BtFi?=
 =?us-ascii?Q?syQgZvp1d1AKfkxFknMYBVt7iIcVvCg+DXvpIlyag0zdxZB9ZYMZp27EZdIb?=
 =?us-ascii?Q?a8wpg+ZkhW60b0t+Auqiside7lrLUCzWKjvSudUv+HDF+QY8leYC3C0aumUl?=
 =?us-ascii?Q?rcQ64mxwcE7R1qqlkxqdbozj4NptuEPcKf7Wm9+wuZLr553HuL5SIgLUpMAv?=
 =?us-ascii?Q?d0BLUOTkQ04XzKhf9N63jzHWNs6BOwGM7Rg6p4DezS3rPj87qKXTdbxh7/3u?=
 =?us-ascii?Q?6Aw6MDJdzxvHbJhc1SiY45EAZKVndqfpYp1Q7fHx8NTpKyqGGDS30vg0O+sw?=
 =?us-ascii?Q?Gj1tWniPW4z0Xs6yRBc21iOc8L4RlqAWXOkj5tn0Imc+N4TpQUkLiyw/BPre?=
 =?us-ascii?Q?d2NXaeQ8tG2tCpgT8GrX+wOLcA0+wqki3OHOgSKJCgsnPOQat+/FlJJRy1Lt?=
 =?us-ascii?Q?r6VjvOYHDBwYNjdz/XpRwzkmtQCsdhrDioLkXXFFgtx2h4gk1GrCLzCEe0cT?=
 =?us-ascii?Q?v5mM4zoWVM6jW/bCgn0z9xms3YRQNBccuU99k7jndkh9XDofb7R9tdQQalUf?=
 =?us-ascii?Q?sUOhnVybx7GBo400b+rw2p820/l/IpxldisND1PlUtwthTw+4L+Rsu6w8nNE?=
 =?us-ascii?Q?fCTtP+A/10d/TlqGOuRZriABOYJwYCFGJV/SvKwiQEsKARaClEOSGYTw8BvK?=
 =?us-ascii?Q?HqYpMtRzFaO9+dtOFjMDAyhT/wnN92c5jHoAWsrnA75D6UoCfpJB68aDStjt?=
 =?us-ascii?Q?eDsYKBxc5c+XLFF2WD6AJ6NBNYtpSqadHx16irnmxy8w1O+VrEjRfJ3bVI6V?=
 =?us-ascii?Q?w1KTqS5+uXCn2MJiZBQKSIqi1iUkzeOPLaDYeZO/Zknv/B+Tu/v1R5B9WEcU?=
 =?us-ascii?Q?zR3uI4YxMcU27h5jJjmYoPSTiM/HXn6+66iR2Incigpt4J2styUOZ4nPdAnA?=
 =?us-ascii?Q?boEg8B6JT+z9/QVIug56PwfBCqy+PuqNh+npb3puXsZlTaDRQ35WasAYwN7N?=
 =?us-ascii?Q?LOq3Xr4hgvj+M2iSfMadw6xT4ZtsdujZ1j/0tYEZzvLc36Nd9kaU4jDL/QzE?=
 =?us-ascii?Q?OpuIQ6yw5lb/zPk0KcPnPv4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a73d39c-f9d3-4ea5-5862-08dc5c3a99f1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5947.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2024 04:23:15.1265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZrUkTgIHl5M3TPRlbp6AbZBmoLANlR2l3NQlgwIyY/XnKgYeIMSpiXQjB3SywWiX1mTrEvGfyEEEC6XYYD4Y2dUpKGOmVZl0CmHXubd6B0pJgbBvJ/vlIUczytM62IIo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6715

Add the max31790 binding document and support maxim,pwmout-pin-as-tach-input
vendor property for the max31790 device.

Changes in v2:
 - Drop "driver" in the patch 1/3 commit title                           [Krzysztof]
 - Update filename of the maxim,max31790.yaml                            [Krzysztof]
 - Add the common fan schema to $ref                                     [Krzysztof]
 - Update the node name to "fan-controller" in maxim,max31790.yaml       [Krzysztof]
 - Update the vendor property name to "maxim,pwmout-pin-as-tach-input"   [Rob]

Chanh Nguyen (3):
  dt-bindings: hwmon: Add maxim max31790 bindings
  hwmon: (max31790): Support config PWM output becomes TACH
  dt-bindings: hwmon: max31790: Add maxim,pwmout-pin-as-tach-input
    property

 .../bindings/hwmon/maxim,max31790.yaml        | 63 +++++++++++++++++++
 drivers/hwmon/max31790.c                      | 31 +++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml

-- 
2.17.1


