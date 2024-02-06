Return-Path: <linux-kernel+bounces-55070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F85784B739
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DA01C2596A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049F8133297;
	Tue,  6 Feb 2024 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="q8UIefyL"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2133.outbound.protection.outlook.com [40.107.21.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C377132C1D;
	Tue,  6 Feb 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227991; cv=fail; b=L72rkjADQft/qfE8eZMctMAkSFwZk9mokj+Bs6YQolcKRBEoM+bnfEUsRKcgnnHamloiASxhRXomuHlhFAPo05d6FOE2zs6YjtoRG1ysq9C2Lmz8IksKgqqCSLZMxEfKNjbt1DqoF7F33F98w1t5Sth/kE3aOcT7HH023/QmIMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227991; c=relaxed/simple;
	bh=6Ht5ynmIJIX21g9C4JpOADohFLbwFWj8jYgr/isAV+M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oa3t/0/xOAEoBF9Skz7rIErkRi5Ak1whhjLZ0tv9TMO14In7b1o9gvYg/H8gr+8x/jLbHr7vhbaYWMInvYEUtzW3vRf71onsDr1y7k/K5qr8fo3HU5ZhcvgmPLHjFQEOrkSBU/j1jga6OxPgD0JsTlmV/j28z72wBDC6yzSHNuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=q8UIefyL; arc=fail smtp.client-ip=40.107.21.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHvNr8AWzZiKMUQwz47uCpioJUXsiTMebb/7JohM8n4eza7eViD1bVwxgGZ55Klg9UC4WQOqR1ZSSiT6SYRx3OJCabsUaxua+yV3fazyh8JPQcj7un2gz2a9qRt1wqPUDG0sHXEr647+k1QpW7qJ/qhD/Q0fIrPuXR1gumbDJy67zQJE3CO5HkeaHiJEf7kC5gWNoxjcxE33i9K1mp05Mu7xX1CGvY/CTv3Fx0aoRizK7OiGw9qWKlknwQxkIK83Mz+68fwD+z/PJBwFvpF73DPwS1xrcqI+xeQ/n1SxmCEierpBo64gCcHcULukAJ4oRbb9Vd3t4VfiZ3SkQ5vWUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2fcPywiN44+BPGaXpHzkDdxp4Z9BT1tDuUyT0+2Jyk=;
 b=FSVo745Yu31M+VcNuPRFXHWk8x5SCzlA3TlidAmCbaaQ+7jEzQxf5rjvvP7u0S+JQLBRs9yEr44cmH+tPo8p+Vr7SSP4ezE/pDIWKH/WoxybstzW2KPb3fFg3V71llS0b7jcDUamY8t9LxVUS4MveSPePIel3bxL++OCv9WySM+NKiYWHpYcaZaQi26ASK/hle0GhnGG6TyazKZwZJXjhUVur2IHmKxuwRx42T0RRdAphg1rF9iCmgaH6fhQVPWK9cN19yZefvZaek5WLKJxucG8ZhJjCex3Bd75mRuyAOfX+BzmFD6cxb9wEFidGLS0o+0zlAcx/Bl2UjZNMUTndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2fcPywiN44+BPGaXpHzkDdxp4Z9BT1tDuUyT0+2Jyk=;
 b=q8UIefyLp5rvUaYleVMCj2QG1chJr3qH/4wDhZWkXn9qUJ2NYrNsOTVIGy6PBsaspT4YZ6byVc8rm+uxPt+jXo+8LvEIsQALfoqzixvrM8SCZ+3hifpFaiyQAaCN3fuDMOXn6CPN8h2EAVGXsT5UN4UGjJujYfeTQn5Q66y/k/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB9PR08MB6330.eurprd08.prod.outlook.com (2603:10a6:10:263::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 13:59:38 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 13:59:38 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Tue, 06 Feb 2024 14:59:31 +0100
Subject: [PATCH v3 3/7] drm: ci: arm64.config: update ONBOARD_USB_HUB to
 ONBOARD_USB_DEV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240206-onboard_xvf3500-v3-3-f85b04116688@wolfvision.net>
References: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
In-Reply-To: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707227975; l=1001;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=6Ht5ynmIJIX21g9C4JpOADohFLbwFWj8jYgr/isAV+M=;
 b=pXED5dxJePCU/70VXEJgYPyW9J5Dh/lxWPaNxVYxdRMR21UczqD4cEdB3LER4ItQny+khr5+x
 b1oqGc73ddrDA/6G+sy3o5xRPYb86arieCNfbtbwgZ7JtEdFqlV7L+1
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: FR5P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::8) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB9PR08MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: e82ea6ef-c614-4291-f833-08dc271bdbb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p8PS9JrbpG4CdYpELP3nRca5ik/Qx/mswzv8Evx5+dA9UV+fHFSpbyspbp5GYWBF/OqLJSoT5XseEtgczLtQRhuwfvs9MiroQuHT6YYxCSAPYsMsbXMhtdodTOIScv4183+J3TvltW2y5VGWb1OVvdS/r/RHxR0TKO9Ojew0+aDRoOQKBqiYucFaTelwKWPQspJzX7iBNLORHw9rxnrXyD9oXWS4vy44J4dtv3baWk3FpowtdmrRuEayjKmZrGV5v2Ck09zEQyJj57hjCVKY6h31mVGNb8f/6nIBJx2/brcGNz4rgupCtbnECQxnZLxMxVWfwtYdOmwYM0BZ/wS4wa7yry0+ayryKcdCZlfRruaAA52eEwaKeg1taiTDpWXK3wB5kTMOKT/VCKI0y46HBIxtLUIofLYz7ltomu5Fctptwe3S40b5nVxud0JVxbF+nvL/jibts/KzOzdq7QRUyHXmFwm2B9gd5TW8VXFinMFTvc4WNCUoScwg3vhEqaJ3ArKo3SK1njG7nxjxzqRuQHBF0Cf2xvNb4eFguHb4m8JT2QUZABeQvuDhOwbGfFx3SLmoQ7VLU8YgtetnQzFARjJcejiNv7XB6np4Z13VipIWEKverHmyGfh13A+kBAFm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39850400004)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38100700002)(44832011)(83380400001)(26005)(2616005)(6486002)(107886003)(86362001)(6506007)(6666004)(478600001)(6512007)(52116002)(36756003)(316002)(38350700005)(41300700001)(66946007)(66556008)(66476007)(110136005)(8676002)(4326008)(2906002)(8936002)(5660300002)(7416002)(15650500001)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVZpU0QvbTNsQVFTalhMK0dvQ0MxTmtubXhLMHZGajg1ZC9UdEtZbVdEY0hF?=
 =?utf-8?B?c3A4K1RIUjRoNTZTZVZCak1QUXJXYUxiaGhoYWxQblUyOVBuVHpmYThGU0Z4?=
 =?utf-8?B?a1lDMWNwU0hlaFpucm5ubUt2RkdhYTRqOENNZm12M1QxRDlmSDFCeGF2ZGZp?=
 =?utf-8?B?RjBoY1BFZUMrSGdZYVN0UjF6dm9IMDZ4R2xUTzB5Zm1rRE9iWHFmTWxFM3FQ?=
 =?utf-8?B?Z2ZPVUkvdjVwN0RTZEhuUEMvNGFzYnRlNkVVUTFJZWQzdXBBdFdwTVA2VG9P?=
 =?utf-8?B?eFJEVCtQZGRORGNXMjc3WHVXMVZnNk4wMUhjRGliNXZzQUtNKzE3bVczV1Zv?=
 =?utf-8?B?WHFkQllWUUt1N0o0VTM0UFlyZFhwWGRQdGFNZUNsVE1kWUNLeVhRZ3JUS2pV?=
 =?utf-8?B?RE5KbnZkWjFnYkFNbzA4MGdaUjZEUnRFTGtBUGtYZ29ORndhT3ZSS3c3TElo?=
 =?utf-8?B?Mmt5RGJkWXFONkJ0bTRXZDdzOU11WlZzWUQxclp3eEVkc3VnL0UxZ055cldJ?=
 =?utf-8?B?YUppSDV4N0dFZjJEWnFiUmNRZ2ZaeVZiSVpOc3NjUFVKOG5Ea1orSGhQNlps?=
 =?utf-8?B?dkVCUGR0QSs2Ui9ueFFSL0ZzcXBIT256STcxS3ZsVUNzOG1HQjk0SFhjdG81?=
 =?utf-8?B?L1VwT0k0OWliMjJZV1pSR3VMTTh6Q2lhOG05V2IyN1dCUmlXQnF2amxtOFNC?=
 =?utf-8?B?c251Si9VK1pPbzVTSDdRV3oxMWlxSVZnb29ZdHNVY0VOaFUrUEw0b3phWFgv?=
 =?utf-8?B?Mmo2K2YyQVRsWGhaYmh1bHdzUzcySXhlR3pMVjZrNkRvcUFpN1pvTGdKMFE0?=
 =?utf-8?B?R0o0ZjhmYnZvMFhLeDFpRkVYdGZaVzJBZ0xyNTdRbTdoNGpKNmZWNlNsVmVp?=
 =?utf-8?B?Z2xYUkEza2crVFVuRE93ZmNMcitKZ3k5N2JaUFFXdlgxbWF4bXRIYlE1MVBZ?=
 =?utf-8?B?bXZHK2FBd01mcUpEU3YveURoTDZQWkQ2ODNpUE1EREJqbWFvL0xkNHlrL0hY?=
 =?utf-8?B?U3VrTUJZTWFaaE9vcDh4bGFwdmowaWdkUjVZd0g1dm1PMWlwS3FUbXJTUmU0?=
 =?utf-8?B?SFVJN3VLbUhwaU9tazJoK1Jya2c1UjcxUFFuY1UwdmhQdzRNWkk2UktiV3dN?=
 =?utf-8?B?NDZtT25qbzFObm1jTENOVWVBUG5xdHFMbmNrcEpjelFhREVHZXZDZURZRDF5?=
 =?utf-8?B?ZWNvVGNZZG9sbGNwNFA0eFJNd3Q2SUpwUTE4bGtrMzdpV1VRRnFrNElTWGRp?=
 =?utf-8?B?YlVWKzhWaXhjakRUNzh0N084UTZjWWY2UzZ0a0NNeUhyZXEydmM0N2RwQU5u?=
 =?utf-8?B?WEtqMkREREh1S0taTnFuOUFNZDBqUmRITkpmWFFvY0lXT2RXYTdRaXUvdHdD?=
 =?utf-8?B?eC9JNkJYdlBBWlEzSjEzeVFjS3JQVFlzdEEvR20wZFRBUVhvMElqYzl2dWJo?=
 =?utf-8?B?NEFDVVRweVZWMmJLODNNTTZLUnZIZjNuYTA5Qys5L0RHRVptcUowSDlUMzVu?=
 =?utf-8?B?Yk9TN21vM1BjazJXOUhUK0cvV2VKLzAzVVlST1puaHNoTU40YUg0WWJ6V1A3?=
 =?utf-8?B?UjEyUFZsMWdPRFVBL211VStvODNhOE51VVVCR3N1ZmtFUVl3bXN4ZVZ5M0w2?=
 =?utf-8?B?Rk9LRkY1YWFBK2tGb2NoQmE5VEVZNTRlMUp5ckp5VTNRZkdxMkZKUHVxQkFo?=
 =?utf-8?B?ekV2SVNmNUluUzRjQmwwcFRrV1BBYThSdGJGWE1KRDBEcE5Cc3B0ajJEVkRz?=
 =?utf-8?B?V2I1Uk5yVVJRRVlnd3JNWjhUWHgvaHQ1RUl2MWFOQkVlRUZueTBxTkZxTzNT?=
 =?utf-8?B?S0FtbUVFUExoc2tickFBK2F3dGpYZWNETG9ubnN5cTU0Vk43emxBblNpUXFz?=
 =?utf-8?B?Y0VXYWxFRjN4WExzSXVFNXlGQkI4dmdCZnBnSElIQllkdzR5aFR0OEhWbEJ5?=
 =?utf-8?B?MmQ1c3pveW1rOU0rczFLcno3U2paM0xiUmlPWk5MTWhQbkxrbjFyMEtqVWVN?=
 =?utf-8?B?WkVYVTIrWCtEcGt5UHA5Slh4bTYxMkdaSkdLK1k1NnF5d1dHUCt2Zm12TlBo?=
 =?utf-8?B?cDRKMlVVVXRrTFhuUnpCcmFoeWk3R2MvWkdpQklReDJheWt0MHA0K0ljbDZV?=
 =?utf-8?B?dGlJYk9KSzY3djBMR0VubCswaUdNdndGYXVSekJKVXJOdGM2ekppQS9EdFpo?=
 =?utf-8?Q?KUhXRtp49RZMYNzxq8eEvpI=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e82ea6ef-c614-4291-f833-08dc271bdbb2
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 13:59:38.4201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UN1y/nOLEH47TxeGXNT+WbQQ78IC/ntrcSQ1jLCIudkZ4aLidGVpgVVoN08UvHtQO+/y4vAmSEviSg6O+Zr69oLJnSlnXSQSuESTHknnEe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6330

The onboard_usb_hub driver has been updated to support non-hub devices,
which has led to some renaming.

Update to the new name (ONBOARD_USB_DEV) accordingly.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/gpu/drm/ci/arm64.config | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ci/arm64.config b/drivers/gpu/drm/ci/arm64.config
index 8dbce9919a57..4140303d6260 100644
--- a/drivers/gpu/drm/ci/arm64.config
+++ b/drivers/gpu/drm/ci/arm64.config
@@ -87,7 +87,7 @@ CONFIG_DRM_PARADE_PS8640=y
 CONFIG_DRM_LONTIUM_LT9611UXC=y
 CONFIG_PHY_QCOM_USB_HS=y
 CONFIG_QCOM_GPI_DMA=y
-CONFIG_USB_ONBOARD_HUB=y
+CONFIG_USB_ONBOARD_DEV=y
 CONFIG_NVMEM_QCOM_QFPROM=y
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
 
@@ -97,7 +97,7 @@ CONFIG_USB_RTL8152=y
 # db820c ethernet
 CONFIG_ATL1C=y
 # Chromebooks ethernet
-CONFIG_USB_ONBOARD_HUB=y
+CONFIG_USB_ONBOARD_DEV=y
 # 888 HDK ethernet
 CONFIG_USB_LAN78XX=y
 

-- 
2.40.1


