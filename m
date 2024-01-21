Return-Path: <linux-kernel+bounces-32047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DD78355B8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907D21C20D56
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECDB36B1B;
	Sun, 21 Jan 2024 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Yt6tDlHv"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2095.outbound.protection.outlook.com [40.92.107.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9DE364A9;
	Sun, 21 Jan 2024 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705840906; cv=fail; b=C+IyHUqEymcYtFji2OYqpAvh3WH6V402gt0lyIkqgLFdxkevKNlyJH4ylho3xDxP3fvpK+16heZQIemcbEaFpmOzDBDgxWflU3++Y9RUBHoaybJqkJQvwD0VEtLKnsUF67kGq3owH1GCQZUnRgFg8OLn6UnDRht4mV3zYEyZ4TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705840906; c=relaxed/simple;
	bh=GMJLZFym36h9jqm99/2yM7zrW5FLKAZCLY1KHQDEYHM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S/A+x2qYc5vp4aGjEc16jdQO2UraZ4WwdXdMq9nPkn2lUz0HOuktOAgUmsIhamSNcB2IR0nlQA5t15w6X+ToytzHHz+NCtxvd+MkhS2er3dzDmQmtMwQOhbx9YPe2Gf1Fjh8PxvWBC/m9JwO08d/OzVc1RI4maaAAVjNpeDmkEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Yt6tDlHv; arc=fail smtp.client-ip=40.92.107.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alnx7Nv66GqduNj04ccav/kWiWYcOXIhyUcQdyv+shqf4dfFiB0bSXI3gPSO0xnIj1X6OxTRzWb/sASzzdN9FYAMPW3IQrjXniF3xUGdRjV0SHtsO6PZb2avciTEt+xC6BkKU2ykWTMSjHwGRz6fF+gbgM25yALyX9QORFwwZ3juf0aNVEYO3SfPNx2VBxJAis1KxkXEDsD4b3Ra0HgUaRA1Omkz8vgMBN53ynrO+ezKQvoPRTwkw9nQQv2OMFM497JSdQHRJcV3furu+65LN4tCsJRl2RVf/4j7nQVFlLQ5Sga66Qq2AVaFSdLYhVpISOtlC0i42WETv5Zy1Cv5Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKndGcaFr+VI64e8Vu/mjV/lynKbFFTYkXoRG1OAVK4=;
 b=KIAEHkmAlANsfn4ZCm3quq+tRSF8qjMX1bwb2Aaj8c1ngDDBJ7Pgn2hDzts0DG50KdebS1LV4ScOn/nyAgvvQrlzIucPj3NOsArAMoz+4qtavoEHE9b6hEq4NM3TqrmgRzrnmSbeJb6fE3jJ04ju/AV+jnGhoqbTy0D1ScjWOPxZpFWxDw4ceaFrUW199HsTvk03a6F1aXpCwTEW7NWrV3tRcqyk0ic4coAIIF1LudLsAUpkGIiRuObpa2XmKt+fHXTJnoGFLciBNRODIH9gPdkOCYWkVN5bmH4q+XSKsXAb7TuzDLVov05yYbnLbZp0oZusZB2hP6m0GJFQwisJHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKndGcaFr+VI64e8Vu/mjV/lynKbFFTYkXoRG1OAVK4=;
 b=Yt6tDlHvb84ZJGL1HPx2Xu1tj40lgCkhwYfVyAdpPbxrFg10RGO7Upg2slibgjd9IlRAZyLRwRv1Ysk4zuc2YxWpJa5eAFq2PW86pIZ1YZDTCJa85bFZvLqVm/LaZ6UagBkfPmpGS0deiLX6oL77+1PZkTMzvxcsHG2J73jgWxSWk9btL9eULTQqXxSOi4ZdZyn5auXc3RMlXWYSCR07OupYShqrzCKaa0RNSI7ZxTMbemtq3QpCXEK8ScqsDd8DukmjER42n5fJH4eQuInJryaXyHOB3E/iEn8gxKoOTRtYrJrEiYGfO7H1Lh2zb5mDMVcrDDqH/ftjJZAEdD+IzA==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by OSQPR01MB6119.apcprd01.prod.exchangelabs.com
 (2603:1096:604:27b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Sun, 21 Jan
 2024 12:41:41 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::bcb7:50f4:7a16:4ec0]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::bcb7:50f4:7a16:4ec0%7]) with mapi id 15.20.7181.019; Sun, 21 Jan 2024
 12:41:41 +0000
From: Ziyang Huang <hzyitc@outlook.com>
To: mcoquelin.stm32@gmail.com
Cc: alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH 0/8] ipq5018: enable ethernet support
Date: Sun, 21 Jan 2024 20:40:39 +0800
Message-ID:
 <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN: [ert9Mh57VppqbQ2FUxLhaMiZ3rYoe/qMQBXWesUVLUI+xdghwV9kEw==]
X-ClientProxiedBy: PH8PR15CA0023.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::22) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20240121124039.3328587-1-hzyitc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|OSQPR01MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 085daddb-4539-429f-0f58-08dc1a7e50c5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kSfuwsfaLKSVFzAGt7VVfRCVyh5JN2bSPQGKTX67Ch5P/r5g7zXCdgOxDkBPE1iCuqg48/VBdYM2ksBukBxXDnxKGFX+yb2BlYE7UrWCUqd4nKuq0NseqlNxbbpixMA30TbOaN33zQ3TpReUW2qmRNzBDCU/gkDAi/8/dN5TR+deUsl/D2Ri7OJ3KY5VN5KA8qhz8g3jeXbYqW8etWjbJq9ZGe/ehuhZrReYWh6Gib+Od6XdisdJ6yp+WGOlBVaZQZku2beFqWHp8dYhB3k5acjjAiBRu9gyDSOl1bHDzbvV9C5fF8LMhLUp7F59feMHvwYGAPPPAG8fUi7LCayKGpyPxVXhgR6dh7HeYMiZwPapRG2SPzPNVwla7S2Lfcym29uXlzdKIjkDxBuPriSFEmp3lhgme5qcwnO2/xunoKrdwmY5sQBIYeYD4WSxS2Ka6uAuM44CvCy4pIj04eW/p2i2dIZBrpf704c9WJwzZkC2U4W1fjW6rAnsYOxhvSwUzcJW+IMjFy4Xprp7twcQMo1zkuOrzr/tmswXe0N4dNys7PbxwGeiIol0JCf/yQVPiJuj4+bSAExGICSlOkOV1Uf6A8vQMfrYvZW24lHQVr+3BQSpRAQsE61nObyc58W/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aER6S0kzYko5UU5NVFhCd3YwT2lkNVkzd1NlVGJOeGg1b3g3RFc0QUYxOVRl?=
 =?utf-8?B?MDc0eXFvM1AvQ2JpN3hwbkpoeWNhclVoS3owT0lheVpraVY2bVZCbHdRNEl3?=
 =?utf-8?B?NVBTcld0RVVncWV5VlBvazRQQ3NIV3dEK0NZbll4VlJOV2U2MXhwekdRMXZ2?=
 =?utf-8?B?QVg0cHRHdk45ZG1JcnEyVHZGOGtsb2pvNEpNd2kvZXJvRkZUQjR0cU5DR0Ji?=
 =?utf-8?B?eEhVZW93Q0lEU0c2MjhDeUJHUHdHeXh6dUZSR1NsZEpVc1hHaytueVptNWJy?=
 =?utf-8?B?dXRzR0l6T3hjU2ZDaFNLZnZsQk1INzM3eVh2MTBWcGJtb2x5UCt5dEsvTlg1?=
 =?utf-8?B?ZDU3RzhVa3hmZEMvdWRDb01pRWNXKzNGTmV3eHRvcTR2Q0hDVmwrMXQ2ZE9r?=
 =?utf-8?B?NzJ5NWllUDRKOWJvRTFvSGVBSzFBeTRqam05SC9uV25VZ2JFcys1bHJodnRm?=
 =?utf-8?B?RzhLZGdjc1FHbHZ6eUhnRWRJaGpqa2RxSWNOUVVZNkdTTE1Ld3czNi9GbWFC?=
 =?utf-8?B?ZStJV3BsR2pwa0tuTXN6QjlpMHA2K2FqRkRxQUVjSE81TGdERHJpbCtyc1pY?=
 =?utf-8?B?VjM2VVhoYjRXUldMNzkxK2VNNHk5TFdUdllCc2hoQzdic2tjSjdvaHZNQkx2?=
 =?utf-8?B?NkttMDhXTVR0MmpEUElUN1RLK1hSTm13VTcxcGdnYnBvRituQ3ZpU0pXb044?=
 =?utf-8?B?dDJoZWU0VWh1dmJIKzdhM1NhZEZLQUJwK3NhL2ZsRDBwTHJ3MDJsdkZ3cU9h?=
 =?utf-8?B?NksycFlZRDNpcm12UXR3eGxRSHhWR2Z1cGpNbVRMbHNqT3p4NHJKOEhHUjdu?=
 =?utf-8?B?OWVQdWFyL2NoZ0MxK3hPdlZWMnVTVmlwOHpDMFFLcndIUjlWN28rUFJ0QXYz?=
 =?utf-8?B?ZmxiSklHWUcrTGxNZ1ZDOGFCYW5RbXNlMXZBWFpIQmpUWnI2c0tDUVViSG53?=
 =?utf-8?B?Ui8yMUxvUjY4eUx6QTJ1RWQ2ZDVob3FZa1dxZkM2SlZjV2t2VDhqNHVsR0Z4?=
 =?utf-8?B?TGhGbFRuc25JR3lPbkVTTWhpd3UzZ1Bsakh0NStPbm1qTWh4QjFQOVhwWEJM?=
 =?utf-8?B?QkhDTUM4L0ZjS1RmZndTK0xyMEhjZUZNSFdjMkZwS24zbldNSnBHVkJOV1p0?=
 =?utf-8?B?RC9nS3JhaFZpd2R4SkNrZ1NRWUp1aFpXVjByWjJnV0tZWTBuZ1ErTUhyL2hZ?=
 =?utf-8?B?Z01MaFBFRUZYdkR0TFpueUN0UGxyWkwrKzhxRUFHZW01UlV6WVpKWUFwZU1w?=
 =?utf-8?B?N2lDSk9wWTdxclB3TDFxQUt4S0hHOUEwcHI4SUZURG9EeXZ5a3ppZzhjc2Vh?=
 =?utf-8?B?dm9CWTdPTzZsMXJ3Y1Z0M1N2U2Z3UlorRWJMbVd2U0hJbEl5ZlVXM2xodFFC?=
 =?utf-8?B?UVJLcFlibnYwcDBhWVNnem9QMENJZUVKMnhlcG93alZHdmw2ZnZPdG5FMFYy?=
 =?utf-8?B?NXU3NlNkQUpxVGtRYWJRaFk4elBvaTQwbmptZlB3V1NWL1I4bHFTRm8ra0VB?=
 =?utf-8?B?N3JzU0hwUERFeFUwaGxGU0dJWTNac0RTWXFGMVp4a3BPSngzTGRldDhWK09D?=
 =?utf-8?B?U1lWVHhsR0FEczZXakpmZkJGcXo0SGFscWxqcklLMjBsSnhUNzlpUkM5NjBs?=
 =?utf-8?B?em9lSE0veThiZFpWalpyNmFTbUw4QlVQWjF5V2NOOGtpSU1JV2lPMDZxWTVn?=
 =?utf-8?Q?FXwKLDwSMFBF6Mm+fiKQ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 085daddb-4539-429f-0f58-08dc1a7e50c5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 12:41:40.7119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR01MB6119

Enable ethernet support for IPQ5018.

Praveenkumar I (1):
  clk: qcom: support for duplicate freq in RCG2 freq table

Ziyang Huang (7):
  net: phy: Introduce Qualcomm IPQ5018 internal PHY driver
  phy: Introduce Qualcomm ethernet uniphy driver
  net: stmmac: Introduce Qualcomm IPQ50xx DWMAC driver
  clk: qcom: gcc-ipq5018: correct gcc_gmac0_sys_clk reg
  net: mdio: ipq4019: support reset control
  arm64: dts: qcom: ipq5018: enable ethernet support
  arm64: dts: qcom: ipq5018-rdp432-c2: enable ethernet support

 .../arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts |  52 ++
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 120 ++++-
 drivers/clk/qcom/clk-rcg2.c                   |  86 ++-
 drivers/clk/qcom/gcc-ipq5018.c                |   2 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   7 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-ipq50xx.c   | 155 ++++++
 drivers/net/mdio/mdio-ipq4019.c               |  10 +
 drivers/net/phy/Kconfig                       |      +
 drivers/net/phy/Makefile                      |   1 +
 drivers/net/phy/ipq5018-internal.c            | 125 +++++
 drivers/phy/qualcomm/Kconfig                  |   7 +
 drivers/phy/qualcomm/Makefile                 |   2 +
 drivers/phy/qualcomm/phy-qcom-eth-uniphy.c    | 494 ++++++++++++++++++
 include/dt-bindings/phy/qcom-eth-uniphy.h     |  15 +
 15 files changed, 1057 insertions(+), 25 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-ipq50xx.c
 create mode 100644 drivers/net/phy/ipq5018-internal.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-eth-uniphy.c
 create mode 100644 include/dt-bindings/phy/qcom-eth-uniphy.h

-- 
2.40.1


