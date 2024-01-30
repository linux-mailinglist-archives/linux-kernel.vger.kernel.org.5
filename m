Return-Path: <linux-kernel+bounces-44603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7181E8424EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D0B0B23885
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF886A331;
	Tue, 30 Jan 2024 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="DY7MtXFz"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2069.outbound.protection.outlook.com [40.107.6.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC256A025;
	Tue, 30 Jan 2024 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706617628; cv=fail; b=ayyW2D9CA2OdSTEDHrkfPxh6EZ4jM2b0b/9cNAVUK8TiQtZy+DhhD/WNIk7bjve081Z7pwMZFc1FqeeVC/ODQcDv8AwVG2W19wtEvCCl8qXq6Ct/lardquRfkPjzIGahPkzW7Wb1jdY0Yv1UATssgjw1FeUPHorGSDEgfNC/jYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706617628; c=relaxed/simple;
	bh=t4WXGL8Pibpvak0kRRScS8YCys/fpmrX0HsFQRoFkA4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=JyiuqNWQgh3qqzEBiFnQNaKzmYM8bRfeI8oMFVGhTN5hQugyGjIVw9jGLWB8i1dtQFReGhc0VZ67vLj7Q1I7aZzkT449Q/aAjlXFcS8YnppTbhWNceoD6cJeTWrJjt6dMhBGXf16PydlVUf6R5Q5RSd+JdoCeicGdHVc56Uh0VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=DY7MtXFz; arc=fail smtp.client-ip=40.107.6.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXAkdWPoPw35hMPUaJXJa+Fu+AaDPE90jZJ0UU9GAjkBk/EmIX239ke2WbUn5DIYzSpluNo/bP2Q7MhtjfJQiUEpGxw7rmfqSoDVOEwIg1vTToMlK3HJDhv1qVPh3oFZepe2gDL9BFB6kENFiaA6OkgdK7jQb8iB3hiv1GfwWy3NLfRYTkj76bJYzt2pIGkJJkM/pL5dArdU3fqLN35jOp5dUzVyiigs3V1Ef8gJAJKmjicc3oOBJj3aWAUathyAkLA/FgwrCB1RymAZ1BrInoTOWVnmQIk3vf5x0ZTcOJDdqeAgtGNp4QkittjCofecD96nf+MdHHQkUr/wUQBEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQRv/l+/oG5H7kwL8uUSax01olq85VOayHfTtrRvZuc=;
 b=DPvuMnwrgKETQq4ZEbKYhMLkXttIRC6EJ/jw3JW+IbA89lbeAt+sfiKKHDnwemtp5qJ3tVKp1/15hJ8UGJHF8MbRpOuFnwhOVwTfNDdqmwWPszjEmffi80w7R8rT1/MEfss9J9hdupucar2ast5L9BZR/WzMaYJRtq4CW9Xnhyb7LwpHPT//eyWMAvGeYT+Lj/CC0DblVPfrjrjmXVrnEqjKYpIM/iEt4ERoS5Gfe0HTUElZe8QF+C+Jg+XcVrC1xF1jdMz54YGoezFyZmJVGFXasODUaUZ6ewD6VyqLQ+e67Sqo2fwwe/6Qzce9IsOD5U8tgL7zXmbZlj9YHtLCzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQRv/l+/oG5H7kwL8uUSax01olq85VOayHfTtrRvZuc=;
 b=DY7MtXFz4PjpRFn3/TE2B83V0oZAebewxW1oZjVrEJLFnevhC4O8lsSCnmNkdjVVacRaDospOLd3DXARERgYqZF9+5NGx1BCMt4o3xCeh/snK3MYG5FUJfCV1sYOc7USuO59VtTnGwN2ZpJnLiW0xpP/yWW7E5ZKdXpPTJqykVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB9954.eurprd08.prod.outlook.com (2603:10a6:20b:638::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 12:27:03 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 12:27:03 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH 0/2] usb: misc: onboard_usb_hub: add support for XMOS
 XVF3500
Date: Tue, 30 Jan 2024 13:26:55 +0100
Message-Id: <20240130-onboard_xvf3500-v1-0-51b5398406cb@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA/ruGUC/x3MTQqAIBBA4avErBNm+qerRITmVLPRUBAhunvS8
 lu890DkIBxhrh4InCSKdwVUV7Bf2p2sxBZDg02H1KLyzngd7JbT0faIatiRx8kSaTJQqjvwIfk
 /Luv7fh5d+7FhAAAA
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706617622; l=1981;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=t4WXGL8Pibpvak0kRRScS8YCys/fpmrX0HsFQRoFkA4=;
 b=x2bnZanUTXLWx8x7RG+BfjlGMHUucznQ4S7ZIUYFJv0EfvE2xBtKdXmgPD6pGYs2txSiV5FKw
 v6uL7gBmkpjC6K1+ZjXkMcO3gYvWUoSHwTx/JIcLClF3rdMhPFWbXqf
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VE1PR03CA0017.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::29) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB9954:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c70f5b7-fc2d-4be1-cd52-08dc218ec3b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1PTnrxa1Rj8MlP0JDtXKE3Z6cFSJrPgDcJ5odeZX4IP9GT3TyIa4m/yzubHkfWHdVcmOpaP8ApQCl6L68W6YzKBj0mY3aDIu6hPjVi5k233WjiqXQy4g/aopF6mgzxO6oFj6agghlkKjQoUCnQQDAi2Zdm8fofzHClTtekzQJsaAJVDRHFpL+Xyss/0PcIF0B1GBnWbmMV/uV3+lfFsNhjree3K450oLpQBpLL7UNc5yWIql/rAuW+Kb+xjNAihFaHG9zx3auwvNNpWwC6zLlpLV9RB8yqlYYdN6KHFycgtXOE8zhpK4hdSxcN9mYelDUsQvACy92nbPxFxOIJ2SsmpM7L3tsg24ywnsm1NZ52HC0uTlwPNsa0LR8AMM880Gtwb2vId2jnh3QgWJ9HbnMKVKLWohkSS2Hl01J/nUtxOBK4aIC/LZQKDEUlzCaUEo6GRORRYc1fFkec6XdbI9kvVs0x16rp8Aff/jDlC0qou7Bfoi73OOIK7uvxDRFHG+iOp94WK11G8trXQgFt5Y9Ga1zPeJ0yiQePPcj1lzPoILU6IQVkeMEKA/b1YhBCnY88bgwro+SvgWZooUsHdvCztuim4qZQ4BkVUKgB4HY8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39850400004)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(7416002)(38100700002)(5660300002)(2906002)(41300700001)(44832011)(38350700005)(36756003)(316002)(86362001)(6486002)(478600001)(966005)(107886003)(6512007)(6506007)(2616005)(6666004)(4326008)(8676002)(8936002)(66556008)(66946007)(110136005)(52116002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHAxMUp0Y1A2Tms5Y3lEVW5zcGY2a0VLRWpnMGxIbG1wRkliZFZpSnc1bmM4?=
 =?utf-8?B?YVhGcnNua0JQVEpWclNyaWROdWVXUWtwcWNnUktoRlNlK3BsVWtkMURWVUZo?=
 =?utf-8?B?bFR3V01HQlphbjlwaEwreThSTXc5aFVsb3hMa3J0VVkzaXNud25HSEV6UjEv?=
 =?utf-8?B?R1JIdFpmYjR6SmoyTHI0eElKd3JNRkdjSFgrVTdFOUJaN0Qza2R2aFJhUG5L?=
 =?utf-8?B?WGI5T3FiU3g0MlZJMkJod09qcURFeUVQOGd2SjFkbURXM213V1NwZzMvU3VH?=
 =?utf-8?B?OEUreW5nU2xxVUxuY1Nvckp0a1haaDFsRXNpblBLZjNTL1FMV05VdEtlc3ZS?=
 =?utf-8?B?aXYzV1hRZHcveUk0RGtYNjNTZHpPZmpBbWRoeWVhOS9lVHZ5QkVibXZ6N2g2?=
 =?utf-8?B?Ylk4bkx4YWxiZkNjMUg0NEh0NXNHUk01ZHlKYmRtVzRDOWlVenFCY0VGeXly?=
 =?utf-8?B?WVZqdVE0ckdLRDZFSUdhSnFtOXFTMDR6azRSUVlpa0N5RyswTWRDckRRdzF1?=
 =?utf-8?B?d3pUd1pJVkYzbzJVc1lDTjdNMlVZaUdibUk5Z2Q5Y25TSy91Zkt0a2JPTkF4?=
 =?utf-8?B?LzAzbFVYTllnY0tLdVdjYnlYcnQzQkEzQndtb2NkYWk4WldndFhIc1pUa1dL?=
 =?utf-8?B?ckRqV01tRERaWWVSb0ZuR0NaRVBwNHR2Q1I0VHFMTWVHaUVuNWc2MmU1S0hw?=
 =?utf-8?B?K0JzaTVQeTEySFFib2FOeUI1RDU2V3dUdXduYnVtL29iSjBCb2FYeUd6U3pO?=
 =?utf-8?B?WEIzbC85V1poNWV5RjNBWWdObzhPbnM3VVlWOWZoOGtRYjBZMlY0Tng5aEdr?=
 =?utf-8?B?Y2R4OHkrQ2ZWWDhYYVNHWWlwdWoweE1uMVlCallQYTdtRWEwV1hiNTh2RHdt?=
 =?utf-8?B?RWtpUDFrZ2J4WWw5RU1BaU40eUg4WDVWbDRucHFHTnZiem5tWm1GUUNiUjlv?=
 =?utf-8?B?MFhBNmJ0M0QzNTV5YlBWZW5NZnFpc0gvUmdPQWNrY014VWdMMkZvL2hzSGhW?=
 =?utf-8?B?ZG1nbVBMb2UwaHZkc2pXd0dwSUtwK3BHWXVyTmVSbzBwbGVFb3cxWWs4OHBQ?=
 =?utf-8?B?eEpZNmsxZjRPM0tWaTFhcnBiOVlnd3VVanRZTTM4VEtnemx5dE1pNk5IdnZv?=
 =?utf-8?B?dUoydXJxZ1RFeC9IbVNjTXNFdy8wWG5TR2xwT05ab1F4UUZ4T0NkbkZMdUFU?=
 =?utf-8?B?Z29RMkRTYldqV0FHaithSG9PZUpFT0JQWjQycFdmSzZ6WFl0YmJZYlZLTS91?=
 =?utf-8?B?dWNrWFhPWTNkVng2NzlEclhUZFVPcXliTTcvcCtySXA2bWVwNVFBSE82NDQ3?=
 =?utf-8?B?dWlXR2hrNnVkN0FQaUpKcG5ZTkJnTmQ2Mms2WXJJdUlQaWgrazJGa0NGYWxR?=
 =?utf-8?B?bS9KaHpBYzVqVlQwVnhINWdxWURmZ0RHc2xhVnhLUWFjcVVjcHhQSkE5ZHJt?=
 =?utf-8?B?cHlWL1VjVXgrZWV5Z3BneUptUG9Ubk9Rb1lLQms2V0tmRXFzNDJqeWhxMTVD?=
 =?utf-8?B?QTZjb1g4VHR2M1JxSGM3dTV5a1FtcWd1UHY2eDZXdTVUUERSVkg4eHlyZXRj?=
 =?utf-8?B?NUVzYTh4dmUrc0t3OElhdmVzUFY3WGpzY2tZZmJHUldsL3hXbXRwcVZic0RV?=
 =?utf-8?B?RzVkbUEyREZEL0JkV3NQTjlvN0E2Rm9CTGhMZGM2ZTJNYU1aMUVTMnVmRmFo?=
 =?utf-8?B?RkpJVm9Cb0FjRGVvZ3hvSU44eWphcFdkamJwb3hmNWEyeVpyZUM5UXBhMUl5?=
 =?utf-8?B?WUVjSFk2c3ZJU1NROE9SRThxODVNVXd6MUJGYkdhUlpZckdzU1MvTFlDSEx1?=
 =?utf-8?B?SkpiR1B5Smk3ZW9TckZRU2l1UDhqdzkvNTdsNEpGRHRkNDdwWnhYSkhMWHpv?=
 =?utf-8?B?bVNDYmozMzBxYUZ3cjBGRmJYbWNkOFYwYi8wUWVaN3FmMFovTnRvd1BIcmIy?=
 =?utf-8?B?aXd3Q2FaTkE2VlJzOGpXbkl2b01pSHhGRlhqWG8vQWdibHN5UWN0VVV5Vm53?=
 =?utf-8?B?SlVSMjdXdGg2dHljQmZBakdqMyt5WDkzU1c4aXU4cnZaVVgrNUFKTmk4dkRX?=
 =?utf-8?B?UmxjTFplZEx4dGYvQkdSblBMRUVjbGIwS2V2ZUwxSkV0UlVGT0ZqdlJDZFUv?=
 =?utf-8?B?Ylo2OExFOG1lcUV2VVdQVFNiN3NSL0QrMGlKOXRqaFhqazY3dHk0cWkvc3k2?=
 =?utf-8?Q?wOmgSW5L/eNZ6C+9L3gL06I=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c70f5b7-fc2d-4be1-cd52-08dc218ec3b0
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 12:27:03.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oa4dhWOIZ1dBxPz7snL+U8N/aU84asPKKO2hlCQaybpLfH6bc+AolOb/sO1hY+Okf8Nc1/KC5gt+FCJxMpiCmiuVADZuZCtjthZDi8dp3Xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9954

This series adds support for the XMOS XVF3500 VocalFusion Voice
Processor[1], a low-latency, 32-bit multicore controller for voice
processing.

The XVF3500 requires a specific power sequence, which consists of
enabling the regulators that control the 3V3 and 1V0 device supplies,
and a reset de-assertion after a delay of at least 100ns. Once in normal
operation, the XVF3500 registers itself as a regular USB device and no
device-specific management is required.

During a previous attempt to add a specific driver for this device, its
addition to the existing onboard_hub driver was suggested as (possibly)
the simplest solution[2].

The power management provided by onboard_hub is not specific for hubs
and any other USB device with the same power sequence could profit from
that driver, provided that the device does not have any specific
requirements beyond the power management.

The device binding has been added to sound/ because it is the subsystem
that covers its functionality (voice processing) during normal
operation. If it should reside under usb/ instead, it will be moved as
required.

This series has been tested with a Rockchip-based SoC and an XMOS
XVF3500-FB167-C.

[1] https://www.xmos.com/xvf3500/
[2] https://lore.kernel.org/all/aeeb0dfb-87e2-4024-9d4a-0b9529477315@linaro.org/

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Javier Carrasco (2):
      ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500 voice processor
      usb: misc: onboard_hub: add support for XMOS XVF3500

 .../devicetree/bindings/sound/xmos,xvf3500.yaml    | 51 ++++++++++++++++++++++
 drivers/usb/misc/onboard_usb_hub.c                 |  2 +
 drivers/usb/misc/onboard_usb_hub.h                 |  6 +++
 3 files changed, 59 insertions(+)
---
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20240130-onboard_xvf3500-6c0e78d11a1b

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>


