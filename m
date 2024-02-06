Return-Path: <linux-kernel+bounces-55067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7137484B730
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293CF28BC7F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D97131E3F;
	Tue,  6 Feb 2024 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="T7wv3hpL"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2132.outbound.protection.outlook.com [40.107.13.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDAA131721;
	Tue,  6 Feb 2024 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227983; cv=fail; b=FmmDEJZUO/iECftCTmuVixxoHpWWN5FESJvTDiJaQWVOyUzmqFRwkHD5bFG6qxcN0nULffb8PqcdpbLphHDQhRQa6dMXaBR3vO8AoEay7q/ipXWwwYnD6F0NOYNAtlBJknnVOxiCQlUJnI77oDhZxwFvE5jsfpMlfku+iyRDDk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227983; c=relaxed/simple;
	bh=xcaKombqlylQnDTAm9hIIYy+M1MtfKjaEHCnlM3jnkU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=HPms0oMlEUzSFsVUiuNMhoVLO4TOz+WdPP4bxjFwJUmv48i7c6br6fsUyh4KDsNHheiid852VkJItg+PvwFho3IVH4clxCdjwUXf/YZuoJk0481IdXuxKEDzS5C5J0wQFbuT/kIJNVmR+Mb0I0SxC1cPUd6TaTMa2Vb9ElBINbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=T7wv3hpL; arc=fail smtp.client-ip=40.107.13.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuGaOTe6W+fLjFTveKmBQJkN1ng3Hjrs4YcOh3p74T6SK5U1o4zCvazm0F/PfbuZU3TkQUsxEgjHgFwK6fEtIAUSHkoDNZFLlQJXpr7imALlGhGqIYZhmDQjE395w+Zu65qhy0uh2UaGIDAyVUpZT2bibAeC5PnYKSKmvW40D4Rbue2qi0TibRSc0cKMNgwhekaf6dcVCYAxx6wtBGyk7AwQ8fT+KUHKkTa7WdvYcId25xJyEPL9zIU+6WEyeyCU3/tFIOTk72LXF9Rv66R2m0xMS8JvIywpqH9WguLfKAvMJzMDMs41Go+QLh4M8s+7XBI2TCGaLHS394OAq2ysww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcms0RghkDv8XncUdqg+ekxu/0OcbM9PLKfrAYkqv9g=;
 b=jK+r25nnmqPDHCImA11v4nOOZBdmQ0XApma9uvtqgb3zDtPVC9fcjU01wp/vaQGAbvR46yRhLKVldQS2E3ECy5/7t7zBiQkywkKWZMovfQV28nNuh2aG9eme8k3VNQlePtBNhu/n+zdh+EFFdUx+I3mzqpEyHYsdXfP0b8Uigm1danSJ2iSIaJiTHy5WU+7593MYyF0JMtwxXTL3eOQ3ew6oEumv4ggkwM1pXIxmAJ6am/6sR5XcXVF2r1sTy0ulVNu3MmsNPa8aGZZAsO9NeeJLigrmax90zK3Ozmx0x/SGo6DYYMFJsytE6UTZA/bE2tTo2w8iHYvQ4m663+iKRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcms0RghkDv8XncUdqg+ekxu/0OcbM9PLKfrAYkqv9g=;
 b=T7wv3hpLDb0myG9qWhMrVi48721C3XDBWRWIEx+pmp8AP07qesxRR34x0rg2mDz0CIrE+VwYMvGBF3JSVpMfpreYF00DTo7h9kwgeNKFsnVMhjJXrcf/dw7ijCIceFhlZlPM2LkS9JbqdTtdG+/rbBvQqIFKpcXPvuyHJKSVtME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB9PR08MB6330.eurprd08.prod.outlook.com (2603:10a6:10:263::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 13:59:36 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 13:59:36 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH v3 0/7] usb: misc: onboard_hub: add support for XMOS
 XVF3500
Date: Tue, 06 Feb 2024 14:59:28 +0100
Message-Id: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEA7wmUC/3WOwQ6CMBBEf4Xs2ZpdCoie/A9DDC1baWJa0pKKI
 fy7Fc8e3yTzZlaIHCxHuBQrBE42Wu8yyEMBeuzdg4UdMkOJZYUkUXinfB+G+5KMrBFFo5FP7UD
 Uk4LcmgIbu+zGW5d5tHH24b0PJPqm/12JBIqaVC3PbYWNVteXf5rfqaPjGbpt2z6l4ddHswAAA
 A==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>, 
 Matthias Kaehlcke <matthias@kaehlcke.net>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707227975; l=4119;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=xcaKombqlylQnDTAm9hIIYy+M1MtfKjaEHCnlM3jnkU=;
 b=tBwaUPBoMEfwd5d48U0bAR+Ryy34V09lWE6V2T2JTfnVvEfxTIEJulEpeCPq3J0fH9hc94NqM
 jhJFt7CA6rjCjoiRZhF/LC4ZRhvm2kT69PfHgjFMUJtuPrc+0y6mX9k
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
X-MS-Office365-Filtering-Correlation-Id: 766dc3f1-2fd1-4186-daac-08dc271bda34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2HCwPLFR6NkVFMZ4H8VMbJ2CDYIm+jY4RJ6FHQIF9O0TAXH/zJ0G6Nz9U+NCU3MZX3fGi9hcsBJ0DogtHpoYlZ65TiBpJZ1EFn+KtOXyI2R41fD6lZ7NN/jN0QipHJx10EpOi2lsOBTnOjHsxcIHvmidtPfX8n3sGgsI+57nE1Ocv6lv58VY5xEaXC3ZH5rPqvmOcgPvuqsTBePFfTVtqnEMK9RYOiM8RVi0/v8oFmPFmuPAwXlE4tLt1gfbbzwaGDvAr6DCUSfZD/Mu3b8svN1i2TkOAV09PzGdS/5q13UzLE0gWy1ldoss1ymDVb/qGRYwjxG/Kchfngc/nZY0wBTlLPyyW+QNvpxYUcyvvvfKui5qyW+WHySXQ12krYFTeq5k2vPyOoWzbhm/LbTHkVNv9yhTGqpjEpWiLkkQfjWcrQFlfi/n8jx4jv5I6X6EFIyhYUAikA2/LwOp+9RhZgJDayJeVphn7eYa5V/LRbBabC0jC1YGlPPpjlx0PBs8cpT2TFLOuMpm42sPo+lS1EjE/7/thICRV3yacfmkDm4kv8XrSoosCv/AfI9yJlNmxXnf2h9KtjoBjO5L5iuiuensI8pKMYC+yyxQ52cBK8I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39850400004)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38100700002)(44832011)(83380400001)(26005)(2616005)(6486002)(966005)(86362001)(6506007)(6666004)(478600001)(6512007)(52116002)(36756003)(316002)(38350700005)(41300700001)(54906003)(66946007)(66556008)(66476007)(110136005)(8676002)(4326008)(2906002)(8936002)(5660300002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TStFcUUrdzhOekljVWY0cWcxTlVsak9rNzY1SGkzUVdUYzlyK2JFM2NBTkVF?=
 =?utf-8?B?R2RVWGNhUC9UN3hsRDV0TEdpUk56NXBiVjUxVnltTC83VmhIL2pRNWxJSjhI?=
 =?utf-8?B?UjFhY3E5YnVOV1VnUEdIL2Y5c3B1V1ZpUXI5NXYyMmRDa050VTNjd0pmMEw5?=
 =?utf-8?B?ZnpFcGcwRHFRNU5WNnBPWlkxY1RBbTNRNTg2T1JsWHo1T3ozc243bzFoS0Zr?=
 =?utf-8?B?MG5NVnNzL08zczN3MytzNVkwT2t0MS8rNGhlTEJMMGd4YXlEa05Vb3cybjNN?=
 =?utf-8?B?OTJMcHZQMFhvSWx6dmxzLzZrTlpzNGtOWm53ajYvZXJ2QWpIU1B5RjBLbUZB?=
 =?utf-8?B?TW04b0xDV1doL0ZqbUNYaSttaytKNktuMXRabXRSem1PZGdMQVR0YWVrdHpq?=
 =?utf-8?B?T2x0ZzlxclpHQ2RXNzg5WkZmZ0RhS280N0F2TWgwTXdPQnZOSC9Ib0xLTjQw?=
 =?utf-8?B?V1pSaUVrUnFVcU9aZk1hamRzMUsxTUtWRVVXeHRJM29ZL3lZQWNaQVhZNExW?=
 =?utf-8?B?TVpUbENQRHZuVitUczU3MkhnMkpFc3FZZ3o0ckdFZ3YycW54NkhvZ1B2M0wr?=
 =?utf-8?B?TVRmT0FUeWY4SmJONlJlMmZmb0R2UWVrWVVzSEk1WkdJMWdQY2lpdDhTTFNE?=
 =?utf-8?B?aGRjL3VvN1NvR1JGeGJweFM0WTI5RURyZVhNYWUxUGI5ZnBlTlNKdEJUR0Fj?=
 =?utf-8?B?UExCV01pQlNSUXpQMkF2WmFUMnBHN0FneUttdnRWL3FFa3J3N0ZyVDBFa0Zt?=
 =?utf-8?B?Sk5xc3MrQ3BrTUNrb2RmUDVXamk3Y3pGU01FTlRidTlsY3VzajdsT3B3Y0t4?=
 =?utf-8?B?U1Y4VGM2a0xKR1haaVZuS3V4dk9HUlc2elloT3E0VGZoY3NOMGx2clJjL0Z1?=
 =?utf-8?B?Nmk4MlBWUHRFZjNJYy9UV3J1ODZoNzNkMnZCZDNPb2x0Ujl3aW5BY1Z2MU9O?=
 =?utf-8?B?K3JxMVJvV3lYQllkVTRhL2ZTWG5adDVrMkxZK0JXV2VzcDB5Qm1YWW1qODFP?=
 =?utf-8?B?ei81aHJRcEFoL1NwS01BR29jWG5KQ3A4ZGZVajdZUUlWS3l3SURjNTRyRyt4?=
 =?utf-8?B?VGJEcG5yVjBGN0tsUEFuNU1IeGp6cm53OExiS213a2dUakxsY2hEMFJqM2Uy?=
 =?utf-8?B?eDNaVW4rZTZwek12WlBLZmVHM25SVTFuVnJzUzU5b2MrekQ2MW5uQ3JaWExU?=
 =?utf-8?B?SHpMVnZjQkxBM01BbWJCRVowQUo3RUZUbzkxdEx0Q3B1MmRJaE9mNlRFQk1p?=
 =?utf-8?B?bDF2V2lqTWxwSnZaN2RSS0s3MUFTeHNEd3dRa2V4a3IzeXpNZElQLzhXYXdT?=
 =?utf-8?B?eStQd0dRQXhXYVlCYXBXbVZKZU5USVRhVUhRV3U2YTQ0aC9KV0pkVDduQkZk?=
 =?utf-8?B?WG4wTzVmMU5hWXhKR3I1dXlTaTFOVVRJeDRkRkF6RTVPSUgwZ2pZSGF1TWdq?=
 =?utf-8?B?UVE5cW9QOXlDamhWV1NXSXZOdzdPM0czR3I4NjNVZG5pNkNHRDZTWDlXTHN2?=
 =?utf-8?B?QytrOU1zdjN6bjdhSGNra1NxVVN3MjJId2lmVm9vUG93a1REVXVoRlRUQ0dK?=
 =?utf-8?B?bDRJc21nNEdPQUVSbHRlOU1WMXVDL1VUd3lESnppdFZwTDFJcko3OG42N3RK?=
 =?utf-8?B?SXJOUElMQ1lrb0FWdXVLTzNIbm1HQVhwODF0YnI0MnJtZW0wRkQrckhySVRt?=
 =?utf-8?B?UXRRL3RaSWRaRDNlSlRwYVIzSldNVEFKcjZWRlM0eE1Ga2NRa1g0eUplbmd2?=
 =?utf-8?B?YWtNVjIveDEwcUFOaXlvS2NmVXBoZUxYTWRLbnNlMWhMMFI1RmUvb3dDejhR?=
 =?utf-8?B?L1pMSjkrZTE2OXV2RTRXaSt3OGJXMGdFUkx2cTRoLzVjZkZ6bFdiQVY5VGZR?=
 =?utf-8?B?OGFpZE1yRGJpcmhnc3lvNEE4THY3RGxZdS9SZUJJd3dUeldFb1o4dE1VS283?=
 =?utf-8?B?MTVydWNCTFRrTGk3NUFhYWtod0l0Y2hnVFV2ZDIycXNjS05wUWI1bkF3elhx?=
 =?utf-8?B?Umh4MkhKN3hqVmQzdm1DMDNxL2hxbzVpMUVXdTg1bXV0cjVieDZ2Y1F1OGx5?=
 =?utf-8?B?dVNnWnRHMEdxMTFFMHd4dEUwREFBZjV6NUw1bjFhc2hjTyswWjVLQWdnTnRs?=
 =?utf-8?B?RGc1c05qVkpiRnJNaXU0WnFqWUFNVTY0SEtiRGVzMm5LRzlGelo3blJFSkJr?=
 =?utf-8?Q?HQyYYtZbcC8z9ihwrm6cbv0=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 766dc3f1-2fd1-4186-daac-08dc271bda34
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 13:59:35.9262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToQDAYngRzYmC5PuTlLVpXCyGYgbwvtBBcWGnmHqZUrMZHcmcNny5jt6F/H1p+qoap17w6OBB0tK7O1KRYsQZgxfqaJWf8NnWInQgqlQc5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6330

This series adds support for the XMOS XVF3500 VocalFusion Voice
Processor[1], a low-latency, 32-bit multicore controller for voice
processing.

The XVF3500 requires a specific power sequence, which consists of
enabling the regulators that control the 3V3 and 1V0 device supplies,
and a reset de-assertion after a delay of at least 100ns. Once in normal
operation, the XVF3500 registers itself as a regular USB device and no
device-specific management is required.

The power management provided by onboard_usb_hub is not specific for hubs
and any other USB device with the same power sequence could profit from
that driver, provided that the device does not have any specific
requirements beyond the power management. To account for non-hub devices,
the driver has been renamed and an extra flag has been added to identify
hubs and provide their specific functionality.

The references to onboard_usb_hub in the core and config files have been
updated as well.

The diff is way much bulkier than the actual code addition because of the
file renaming, so in order to ease reviews and catch hub-specific code
that might still affect non-hub devices, the complete renaming was moved
to a single commit.

The device binding has been added to sound/ because it is the subsystem
that covers its functionality (voice processing) during normal
operation. If it should reside under usb/ instead, it will be moved as
required.

This series has been tested with a Rockchip-based SoC and an XMOS
XVF3500-FB167-C.

[1] https://www.xmos.com/xvf3500/

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Changes in v3:
- onboard_usb_hub: rename to onboard_usb_dev to include non-hub devices. 
- onboard_hub_dev: add flag to identify hubs and provide their extra
  functionality.
- dt-bindings: add reference to usb-device.yaml and usb node in the
  example.
- dt-bindings: generic node name.
- Link to v2: https://lore.kernel.org/r/20240130-onboard_xvf3500-v1-0-51b5398406cb@wolfvision.net

Changes in v2:
- general: add support in onboard_usb_hub instead of using a dedicated
  driver.
- dt-bindings: use generic usb-device compatible ("usbVID,PID").
- Link to v1: https://lore.kernel.org/all/20240115-feature-xvf3500_driver-v1-0-ed9cfb48bb85@wolfvision.net/

---
Javier Carrasco (7):
      usb: misc: onboard_hub: rename to onboard_dev
      usb: misc: onboard_dev: add support for non-hub devices
      drm: ci: arm64.config: update ONBOARD_USB_HUB to ONBOARD_USB_DEV
      arm64: defconfig: update ONBOARD_USB_HUB to ONBOARD_USB_DEV
      ARM: multi_v7_defconfig: update ONBOARD_USB_HUB name
      ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500 voice processor
      usb: misc: onboard_hub: add support for XMOS XVF3500

 ...-usb-hub => sysfs-bus-platform-onboard-usb-dev} |   4 +-
 .../devicetree/bindings/sound/xmos,xvf3500.yaml    |  63 +++
 MAINTAINERS                                        |   4 +-
 arch/arm/configs/multi_v7_defconfig                |   2 +-
 arch/arm64/configs/defconfig                       |   2 +-
 drivers/gpu/drm/ci/arm64.config                    |   4 +-
 drivers/usb/core/Makefile                          |   4 +-
 drivers/usb/core/hub.c                             |   8 +-
 drivers/usb/core/hub.h                             |   2 +-
 drivers/usb/misc/Kconfig                           |  16 +-
 drivers/usb/misc/Makefile                          |   2 +-
 drivers/usb/misc/onboard_usb_dev.c                 | 523 +++++++++++++++++++++
 .../misc/{onboard_usb_hub.h => onboard_usb_dev.h}  |  45 +-
 ...ard_usb_hub_pdevs.c => onboard_usb_dev_pdevs.c} |  47 +-
 drivers/usb/misc/onboard_usb_hub.c                 | 501 --------------------
 include/linux/usb/onboard_dev.h                    |  18 +
 include/linux/usb/onboard_hub.h                    |  18 -
 17 files changed, 683 insertions(+), 580 deletions(-)
---
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20240130-onboard_xvf3500-6c0e78d11a1b

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>


