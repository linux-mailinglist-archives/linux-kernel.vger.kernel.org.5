Return-Path: <linux-kernel+bounces-146104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AEA8A60C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 815B7B213EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A052101D4;
	Tue, 16 Apr 2024 02:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="hqKoh8L8"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2095.outbound.protection.outlook.com [40.92.107.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B556AC0;
	Tue, 16 Apr 2024 02:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233576; cv=fail; b=SBEEJYYvUAk8YbX2ngnZRulFxIInAp57apWtf+sU6IKnsudAAByXdYSg5W/+janmw0WRtbpsGuQbEsCpUljH2mcYO0MI5rZaiiH/Y8Z67mBiIcXIa4kWXGmaOY4JW5aAc+7Hgf8d3l/s0BaYViHmFcQpDek0UAxWAcjxNCYGxcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233576; c=relaxed/simple;
	bh=2ZZlCXl+B0neqPeAkaA7Q+wRp/PXnnqRB8Pk5YyLuYo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P+ZpvbVey5d7RIxcoMxgiOHrA52uv+k6SfbE17s3wKN0XBVtWtz2k3JBkcpm/LT3xvNAL0a9ekrRSL0w33oG7HMBoSeBfgPgcmx/PrdsZRytdSHnYbHr6BRvi97xI9q2EYEv18qd4uM2jpTJTo2Cw5Zm5dS7XV6rRHE45LFIORM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=hqKoh8L8; arc=fail smtp.client-ip=40.92.107.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJ9YzfkYalCBpEYZ2n0G1NcCHo1Rlk4oQz1LY8M4+qFI84J5qt9Skh6t4K1jGyT4x7Hzq01wvC2YPEhqBuV5OpX8Z8aoi64Kx8y17S+CvEAz/thDHvilq+AuVKVispfkehvIB8BLSEUblRz8MqItlVrQUI6IIqKvq2hnp0iQ3i/bYtOKizAGCYGNMsqGnVs3wxDk1J9Fa8QFr8JESf4kVM/o3tIc6JFZGYcujD+3AhowaZqXlKFDgttKJBI2IQYQy0XeVURSM2O3q3RgC4npNC529Qa5Hd/WXL8H0ehhVEfG3eh/ghflk4D0llCRWd+0FvxIOBQEquUiNdtcIiTArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATok7YqYwx6as4VbVNvLwyNzgjcNRikFm+smB+28NTk=;
 b=HPrQ49n5gZufjN8RN6YdKYQvMq2N5FZqyTKYClxofR9Dxwh14EPm5OjQXdNr5cYvhQ2BOZ5yTZJ6e6cHQqzfth5ntWPz8fPEyT+9+5WhwgU5bH7O1BEcc6KgxzFeQ2FqQ3xL1/OlWwvSa7FkA/+AJ+yKjsYHfY4FWeHoYuY5pR115YTh7KM9a3Fwqwyi0uQN6P3k7MF6p2uGO90alZL63zthaFGCOzRXtVBBuf92uhWj1yRE4lsYnvfSQhLlg3FmNzP+GcXWlUv0L91ELD5nep7WeHHq7IVpwNCa1+3T4H7ypjL+9sN5haR9rrA51lxdl7HgP4AFrywTV3NuTtYe/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATok7YqYwx6as4VbVNvLwyNzgjcNRikFm+smB+28NTk=;
 b=hqKoh8L8NQ40fMx9xlvgy7d8buTRnWrlYAjCuGkt/B/Jo0+qMvpK/ReZh7lR91T8u+zJ/csM6VTM/smONkgvulJnyyBpjJ/JuwX6VH2o9+TOtC2XtD4wHNYq4M+ZU7iCmy9rpR3u9iPk7XKWdoA7fr1t3x5jrhjwCyD0nnrqA2vwNBDo7uNgifZZOcCJ41Uqv2CUXBl4POGan9ygpaQx6/s9bNU4OZwsuJY3D7gCu7YEvhJqx0Fg51qcHFV072mAxRME9GPyH4ZXX+CH5FqALsNvIqhCfVQJlp/IrjSMfAPi2FG7ntGOplvqJnB6MYwcEoAKNqrSsa55vSC+tIP4pA==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by TYZPR06MB5323.apcprd06.prod.outlook.com (2603:1096:400:1f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 02:12:51 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf%5]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 02:12:51 +0000
From: Allen_Lin <allencl_lin@hotmail.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Allen_Lin <allencl_lin@hotmail.com>
Subject: [PATCH v3 0/4] HID: Add support for Himax HX83102j touchscreen
Date: Tue, 16 Apr 2024 10:12:24 +0800
Message-ID:
 <TY0PR06MB5611DC53BD4FA5C0F6A21EA99E082@TY0PR06MB5611.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [7bQLXif/t9b4i7kgT6aJqgpaE/KcRHKX]
X-ClientProxiedBy: PS2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::14) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <20240416021228.1092678-1-allencl_lin@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|TYZPR06MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: 5264acb2-440c-483e-43f2-08dc5dbab75a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FEx/9ncApk6PjUgzDeumlGhg/THG4OzCLhNw/DjfvZQo1KIbaI540fCd0Y/HnfvQGu2cmY6/u7+WrR1lpyzvMcD9QbnhdR5iFj10OENXP4LiD/vN+NDGZdKxkS7ZpbgFCjrKR/jVTy8JYXeU/wtF2Xtvrz0NEyDTpYvgxA1V+dTvp7H90APSMuak+J+x9VL4e5NFWM6SBVIQL/v6CoGMdzVUUXi+TiHBAW+bl1qspQ9jGajm3EmflqJXQ6PegxG48D30vWRYkpLx4jZqrqQHtt38Up84R8wefsqumtghkIMteq9/gIl8zMupETitDqHMEhbz/WrdT0WZd+dFE0Dj8EyobSX844ND8au+j4GzUeTCLhVWl9LkYfYawcgHOXNXDG56cZdLX58rO6dE/Yy62QVei/DZldO1WqZpRXqua7To4HDLRXT6SOAjMjTJpLtddl8g0OBqi1sKa0hjvErvgVhFwwrEL6zvyV/99/W/Soa5vLG9snKhy2TnY5HjR7l7C8XPNBKtS+dP7XtYWl07+Anjq+u3+FmmLbVOUBbHjNBx3sV4TXkoGDSVK8cPSjklEu4OgXy1h4jB9fNixOoWqDKjOYmHYYvQYGi6VqYPqehZclH1/9Le09axw6ayUlOc
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4KsDcFJaInbuQ8wzZLd+1t9kN4flsR130KGYXSPG7aVjYnMw/di4FlMDpHE0?=
 =?us-ascii?Q?zITQq2iRb4j8QuyLkcQ4TksIetIAxcLUVtQZIs3J8NhX5/nwzoSOYJswUOAd?=
 =?us-ascii?Q?68J7LdBMIq52PZ0ai4nclWy8c5yuoQo58TsbTd1nCDMp/BqCj5L3d5sSJSPX?=
 =?us-ascii?Q?Vc5jZXsk4tcBlXBTn8sKXyJolpcD6F6UbLgrQus/O1iTSmU1imoo9KKqaFJM?=
 =?us-ascii?Q?8rDbwP2BRUiV8JFh4Bxv3JT+BopcUsX+PH/cCgKYCgSEx/okQR++ThYlRrrq?=
 =?us-ascii?Q?zeD/dLJxM5WIMyc+08wqEHa4f1HSc2UiiFPmIxkuXaRcY69FCrRbhGgauJa6?=
 =?us-ascii?Q?0gjyi7d8aetvckeRWoLOy1tolfD88+vxJrChaGDfgp7uKHS36ughryD5ZymB?=
 =?us-ascii?Q?xVNTbKDmtnwFeg603rE1ALGYTPcw2l4z/UUjTpsJxIjizgP7ybHtJpeppaFJ?=
 =?us-ascii?Q?GwnGOA3pvyab0XgerUI+EAAM+YjyUoJ9Iib//YlGWrbHM+RRdZm6IuNVhu4g?=
 =?us-ascii?Q?YYlldCp/IzE6Bo1MNDTC5VTE8Y6kQ92OXuTeOvyfp9CmKqHMgz1yiegK+6RR?=
 =?us-ascii?Q?TRLsiNgBUEB3dSDQCoUx30qvCRsSF9//BsvcJ/T/S16DCSXWneO5SahJ/++0?=
 =?us-ascii?Q?zP8Lj77W1SXrZPJooj73/6jDd1LHQjLnXYC6WTukq0eGXoBiFDYAafqBXk4Y?=
 =?us-ascii?Q?WJqnte0RFe2rs90wBYvHdzwo7f3IWTsQ4QY13EzJo3qN/eVb+wNfGDl7pyGX?=
 =?us-ascii?Q?tBepOW+qBp5ppPLClFWyiwtGk8ErzWMbAFYSWZbMzlJcnubVZ59jX4vNm2l8?=
 =?us-ascii?Q?aptAoMpGcVYiPXzHmZdm68WBdyaL/kx1kbUXVOIoou1+m6rzWZPI7PrXTFch?=
 =?us-ascii?Q?XCOLegZqFxbX45Yd5Phm0wkrHUZ8ZeCvgLKo1P0GAH1EnAOpRh7+wWp75Y2l?=
 =?us-ascii?Q?xpO3xyLVJSF5ap4Dit+6Sj3lLfAGsV8pkB30GE5Lt9pA7uqUa5lWYwQ9OOpb?=
 =?us-ascii?Q?NHItqp2OemN40vStuwYI128WLZCr+lqYHH6nkNIEN616mF9f62rHggrCjwfh?=
 =?us-ascii?Q?eHSL33UWQUwka8gBKT+DG4a39SDlNFQG+4bjbfSgmALo0MZ7OeoazIqGe1I2?=
 =?us-ascii?Q?S5m4VtX2IulV998L7jahbLHzZa1acRBzld7J+vp0592ZGfOPZ/1frXhRKdCb?=
 =?us-ascii?Q?rKyVSU43a8qV3/LP+AEZb2EAsypV07WLPCsz1IUTlH7UKyxtngRpLMTiU4tP?=
 =?us-ascii?Q?RnG8rvuh5HylX2heyXv6?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5264acb2-440c-483e-43f2-08dc5dbab75a
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 02:12:50.8395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5323

Hi,
This driver implements for Himax HID touchscreen HX83102j.

Using SPI interface to receive/send HID packets.

Changes in v2 :
-Added power description in YAML document. 
-Added ddreset-gpios property in YAML document.
-Added firmware-name property in YAML document.
-Modified the description of pid.
-Modified the example.


Changes in v3:
-Fix "regulator" spelling in YAML file.
-Change himax,firmware-name to firmware-name in YAML file.
-Remove himax,pid in YAML file.
-Change driver name from hid-himax-83102j to hid-himax.

Allen_Lin (4):
  dt-bindings: input: Add Himax HX83102J touchscreen
  HID: Add Himax HX83102J touchscreen driver
  HID: Add DRM panel follower function
  HID: Load firmware directly from file to IC

 .../input/touchscreen/himax,hx83102j.yaml     |   93 +
 MAINTAINERS                                   |    7 +
 drivers/hid/Kconfig                           |    7 +
 drivers/hid/Makefile                          |    2 +
 drivers/hid/hid-himax.c                       | 3133 +++++++++++++++++
 drivers/hid/hid-himax.h                       |  460 +++
 6 files changed, 3702 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml
 create mode 100644 drivers/hid/hid-himax.c
 create mode 100644 drivers/hid/hid-himax.h

-- 
2.34.1


