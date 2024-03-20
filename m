Return-Path: <linux-kernel+bounces-108583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CD2880C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A8C283CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5BC3FB35;
	Wed, 20 Mar 2024 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="tZQfs4ZA"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2094.outbound.protection.outlook.com [40.107.22.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B04223DE;
	Wed, 20 Mar 2024 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710921501; cv=fail; b=g+br8cX9V7R9lIjPfhEYBaFMfofeY7NuzgejspMzAH7YfuVO3y4NP2XMHyXb5pQSrfYkGod/omHIBCFC78epuAhD4+PAZS5rCxBwvv+ChUacFmdf7sXguOqCKyPjY5HmcG5b9m64TL8U9wipCa7GoID/F/Dqo6vxXXVdXikPvC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710921501; c=relaxed/simple;
	bh=GlXHoFVfGs9c9meh5vV5ej7K7i+w66XzdRkU6vn5rT8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=tKXTIGHcpRQjBs9XdDQrEq/HZsWdCZpouBK36SgBKe/4k9rBiaw/5zWjKb1r7ReSVHZtBgJPkq4VUmyTP1+eMX4VmeKfuVJWd53FINL1EonZo1fvrppMDcGQBQtlN1Jw6wnOorW6hVm4+LTObljRzCGRKr2tPR7CMo5U3i1BUAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=tZQfs4ZA; arc=fail smtp.client-ip=40.107.22.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuMZYo9rM5pnvw6xcvp74T4t2mKbANtN7eFSEmGiJQXKBBTcHs6+VwX2pU6rv3L3cP501W2O7xqpRrtE2tS80P5jJLUCpFXtj2+rK0F1IV3PIX79xWJGPAARWdsT3C/lAx7WPdUru7SXM31Iddk0RwMhW4f3jQbHNwRe+DNONRAkDalZl7Dz5B5ejJIsTpN8hRbrSs+miY0t7t7HBwwoVoSY0PH6FYaemvKOLolpguMBt1wodBkxlmwpkvy7BeVjszcJSVjdoPg+JuNGvD5bZLm4u6VCx8DvPxE2Txbj8udTsekd07hM7IG1H1Z+17MtVO7sLHQEfogwQs8ZBZSY7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfUv06jq+gQwKaV4aUPQ0Dxm3R5jrT8vL39k44yvgbo=;
 b=MBCsV5km+1hchVvD47BjTUpnZ9H5iGUnosvQd+pK3rWMdxNngA4Wq3v2Gc/kdOdtoKREmc7oqbE8AHcHvJBAk5rSX5T38AVoRFcSX5NYU1lMA2a+hdl/lKcDe5RLBVUhrjYnuBRObNhNDK5tSlOq4xqBDxXoIS5LPC5pvMvSHhG7vwqROZi7CRuNJiPPNae9fZ6lXlX/zFVGdGMORYL91C2Nw6rfW2lxhFPL5b/LZuIWy+bzUO/tXctQpdeeyX8Fq2ecg1YejUK5HH5YZQU4CP9A9PlWdaCWQcTjoIYmN6UoEehDpI0iKdwCVqIYsSwJhvxOB3uDF5nVMGj64iTRpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfUv06jq+gQwKaV4aUPQ0Dxm3R5jrT8vL39k44yvgbo=;
 b=tZQfs4ZApaxagWEorB9enqiT6FyFrau2C/rM77ARLqBV6gW93sij8LkoGxKGHeQMwBNoeSQRZ0VEye4TzSwxS4fGWnd7VVD0zaK4XPogb83mmU4Yc0zPgGrnJsZwfb+reE+Xce8uI++/QzfiFBeZg5dOa8J7jDxocqE6bGL4KNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB4PR08MB8056.eurprd08.prod.outlook.com (2603:10a6:10:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 07:58:11 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 07:58:11 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH v8 0/4] Input: support overlay objects on touchscreens
Date: Wed, 20 Mar 2024 08:58:05 +0100
Message-Id: <20240320-feature-ts_virtobj_patch-v8-0-cab6e7dcb1f6@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA2X+mUC/43QTW7DIBAF4KtErEsEmB8nq96jiiIGDzVVZUdAa
 KvIdy+ky3rB8oHmGx4PkjAGTOR8eJCIJaSwLjWMLwfiZru8Iw1TzUQwMTDFGfVo8z0izelaQsw
 rfFxvNruZotBGSWYtGknqONiEFKJd3NyAoo+SRsfb1S2iD9/PrW+XmueQ8hp/no8ovJ127CucM
 qosKhw5OKHl69f66f8aHBfMpMlF9Gqial6PVoNHY5nf1YZebagaSA/GOwkWzK4mezXZmjrtmHc
 ccdK7murVVGvqNSgnJ9CnYVfTvZqu2lS/jamTUVz917Zt+wWnlyMfZgIAAA==
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bastian Hecht <hechtb@gmail.com>, 
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>, 
 Jeff LaBundy <jeff@labundy.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710921491; l=4664;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=GlXHoFVfGs9c9meh5vV5ej7K7i+w66XzdRkU6vn5rT8=;
 b=lYmrSjOspPZPSiJWR1DFypAc8gmhjL9AT9I8hdM035TEkgQEpZspnE0bR3yHMuMrFBzD/yIee
 Ox2nDkzT135AV+waKnsONB7amR1IS8XzAJc9TunHhD+WQPiYXTFEn5X
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VI1PR07CA0286.eurprd07.prod.outlook.com
 (2603:10a6:800:130::14) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB4PR08MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: de3ae115-98ef-4aec-dd07-08dc48b37cf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8tiZuhmTo7kpiKPUu31wFjpfPCysIA3jW+INh1bepfzW/gyb61szHo9DOMNRLNbgegWzjxqLqJ4F1KN+J26Q60rbt/fGjLVf99/29jpQ3SIdlguNbDE7FMz9nHE+DPhmyX1UBUKCz+9jxhxrvLTY9qbjTDux5JtzSblSlXydR0UmJ9CmFdCV0FjgpJekpWFjz9QUQCQSS4V28ZmGziH/TyLrKpT+JPKqs9Ic2EBwCbAFcGD8gjPE1UNm3dBRXtVwObhNXCfWCKtjjhHO2fMsSDXCPVEAIUnWqN27QDT2/0PyBML8BjniaV4Oaa7oTEp9GdZnOJdIYokaf0XDO/jyrcoJBi5RTIEchD9g/3LQO37+t5GAiPnhvODY7dJ9QzevSON6wBGstXfbB50B0DsDhn5fpHniO6ObF8fJUBT6tqT0rabrBd8uTVT3AE1RRiE3SH6GnfaPwNxUJHRtuS2meABlwyPyFXIzpKRS71lY5J6Z+33DOa7T+wZeFSumbNzDxVGxyIY13dD/6IadHUumgD7mw2HNwhKqbGQNegJYy/9hETxuX/qJjK59GwV3LmVn9CYbrp0lUn4zSBDu0DFrfsma+WCwo5/TTM3h20zVAVovTcTrYDZCuwi7S6S2Qms+o41DUfp+ioE861yZh42dwtzv0mxR2VqiRX9zME2nGn4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHMvdlhFU3Qya3BOOWJUenNBWUZkOXFRK1N5dUJNa1pHbTN1V2c2WWxpaXFF?=
 =?utf-8?B?cllxcEowTDF0V0RvVnlRWlhDTXJxcjFCbUk3eU4zK05taktYbWVYWG15bjhx?=
 =?utf-8?B?ZVFOeEFOVUpuQzYwTm8zTlFrSkt3S3RlazlIR1M1TWUyTWtyckRvTkQvNzlN?=
 =?utf-8?B?ZURHbksyZ0d1UG81cnFMeFkwTEZ3cjdEcDdWdElHbU9XeHRUZEtPbXh1SlBB?=
 =?utf-8?B?UnlzQWZJdG1BeFByQlVXQWFuVk81RjdFN0xVNDArTk9KWGxBNkJDQ1hHWk40?=
 =?utf-8?B?emtPcGU4RVJGUGFrZEUxYi96U3N4ay9SUEZXM0xHbG5hUG15RjBaMkQ5WGpW?=
 =?utf-8?B?Q0JyUEpGMW11TUR0YlBRYjF1c1dTNlNhNjhlSVFMMnV5NmwrLzkwbEg5c1Za?=
 =?utf-8?B?SU1FMWIxZTBzSVVRUjY3ZGgxNXIxbGdKY2ZWOUF4bmdkZW1mL3B5ZGJ4OFh3?=
 =?utf-8?B?WHBnY3lIZUZGdnpsZXR1Nk5hSHllM1NOMnNnR3VsMzQrQTBjNnA3L1pPc3Nx?=
 =?utf-8?B?d29mOWR4WGMxVHcyeWFQdm9sUFRNejhjdGdSaTRLeWlERXNMMHRhWTl0ZGdD?=
 =?utf-8?B?UFlTZSszc2licldGME1KSTVXSHZHR3ZWelhJd3BLam1BVUJkeEs4UkhXYXBP?=
 =?utf-8?B?UnNzSExmemVkejZ6c3gweFVSYVBpL3oyRy9MYmhJM2tvSzlIeEdjeTArYXow?=
 =?utf-8?B?b1pEVFcvMnovem4xZGwxV0hBQzhJNkJzRDNsNE93VjNvaytrL1ZjR0VYNisw?=
 =?utf-8?B?b3Vsc0s3TkFYclArUHhndTlWYjZXbTF4MVV4dlhZTm8xbkNFWURNTWRVL2Na?=
 =?utf-8?B?RzFDZ0hZbi9Ccmlya1FoTTlySkVtMjFDMUtIVmJXRmFFRlkwV0lMdDFTNzFi?=
 =?utf-8?B?ZUxTaFAxaXQ4YUsvbzFwV1l6M3pxQnptQUx2aWh3dThHOGxBQUZKTnE4QVFy?=
 =?utf-8?B?NzFBKzJTVHhmcCtHckdmaGJaaVQvYTUvamNjdnU5aXA2Mm9paWxzNVJ3ZXdH?=
 =?utf-8?B?ajkzWUdxQXZFb2hPRjdFeHdqUXU4OWxrQWFrUndoOGdkRnMxWS9HRzM5MEhS?=
 =?utf-8?B?OXdzZjdYZXIzMVdwditJQmUxZXdDTVJuR1gvY0M4cm1kVG9zZjl0ekNZUVkz?=
 =?utf-8?B?andYSUdNVnBOTEtwd3RHWkhXR0ptZ2FCRnJSUDdBN2N5aXB2SDVZSUM0VUZj?=
 =?utf-8?B?TWEvWFBHcDcxZ2NIUWZJTys0SEQ2djNtYTJJOExETnVaNXVlNmtUV1c3NDlL?=
 =?utf-8?B?U2VOQzFrd2ZrQmo1THB0SE4yem9Lc2pzblR0em1VVkEwZnNhcGQyZ25wY3RT?=
 =?utf-8?B?dzNPS0pid0JnUWNVTEFxV0hma3ZuY1MxZldWL2VickZFOUNLZks4YUFTMkdZ?=
 =?utf-8?B?dEdvWklaSjR0bWFrbWFCRHRSeXZ3UTdaVlIvUXUwbUFHUWlaZzFkR1JYTHY0?=
 =?utf-8?B?ZGU3Qi91S1FsSUlOYnFJR1gzbDFJRU5aeG1OMkt5cTRETmxOcGlHd0I2bGNw?=
 =?utf-8?B?aCszWlZxTnozejg3MmJWYjNoNEZ3K04yL0lRU29qbjlYdXFwaHk0Y1BoYzkr?=
 =?utf-8?B?NUh3Zm5MWlhkb2lReWlVNUUrYXdZV05td1E0MHRFbjhjMnRrdTZCM3lKRk5i?=
 =?utf-8?B?R0ZEM2JpaFluU3BIU2RnY0c3aU8wbmVyVnA1WEhXeEk3Mmo0U3ZkUjlZdEY4?=
 =?utf-8?B?czJxbkxnTk5SbWVJYkRQOHA2U1FBdnNZSlg2bmJoT0NFVG1YT0hRam1tU09V?=
 =?utf-8?B?QkRFczZnYXNXZEpBZTBTUm4wM2JZb1RZazV1MkhJSitNdVIwaGl6VHBJcHVk?=
 =?utf-8?B?RzVmK2FpcE1jYzNtK1Q2WWZiYUdTdHI5OENFS1lRYWZmMDFNNWJucm5sdEFm?=
 =?utf-8?B?SjFjYnE2OTdxOE5KeG5FcW5udGo3Qml6RUkyeU4wbWpXRVZYTkFDc1g3bDZr?=
 =?utf-8?B?WnJ5RWhEcklZVUZKTHZWRS93Rmt3RUlhUzhDaXhXT1MybHlHUTJuNzUxWGth?=
 =?utf-8?B?RE93elNqZG5tL0NaSGdtZDJvRThhUithK3lMbG9xTTVOOXkzeitORlNMSnFN?=
 =?utf-8?B?empVbUo1MzUrL2ZNYkNpbE5EOGJPd0gvRFNPUXRSMFFJZkpVcVIrRTdKd3cr?=
 =?utf-8?B?bXhpQldUbkFUN2xrZzJ6OUNvN3R1K0pJTlNTYkgwSFZueFBYd0I3YVJsOWFp?=
 =?utf-8?Q?IPFTz/9Qq+3LQao/VwFScKw=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: de3ae115-98ef-4aec-dd07-08dc48b37cf9
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 07:58:11.4385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fvrwsNjAfiwoIVQ4MOYT9KAppFfNBR4Hu7+ocVSAMHtVTiZoibQM97R0J8vvYVNJJsLi++Bdbtsn99zuEc7XucqaLnv7TH0ruJeULsGdYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056

Some touchscreens are shipped with a physical layer on top of them where
a number of buttons and a resized touchscreen surface might be available.

In order to generate proper key events by overlay buttons and adjust the
touch events to a clipped surface, this series offers a documented,
device-tree-based solution by means of helper functions.
An implementation for a specific touchscreen driver is also included.

The functions in touch-overlay provide a simple workflow to acquire
physical objects from the device tree, map them into a list and generate
events according to the object descriptions.

This feature has been tested with a JT240MHQS-E3 display, which consists
of an st1624 as the base touchscreen and an overlay with two buttons and
a frame that clips its effective surface mounted on it.

To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bastian Hecht <hechtb@gmail.com>
To: Michael Riesch <michael.riesch@wolfvision.net>
Cc: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>

Changes in v8:
- touchscreen bindings: fix description formatting.
- Link to v7: https://lore.kernel.org/r/20240119-feature-ts_virtobj_patch-v7-0-eda70985808f@wolfvision.net

Changes in v7:
- General: return to a single input device implementation.
- touchscreen bindings: segment instead of button in the label
  description.
- touch-overlay.c: define button-specific data inside segment struct.
- touch-overlay.c: remove fwnode_property_present() and check return
  value of fwnode_property_read_u32() in touch_overlay_get_segment().
- touch-overlay.c: simplify return path in touch_overlay_map().
- Link to v6: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v6-0-d8a605975153@wolfvision.net

Changes in v6:
- General: use a single list to manage a single type of object.
- General: swap patches to have bindings preceding the code.
- touch-overlay.c: minor code-sytle fixes.
- Link to v5: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v5-0-ff6b5c4db693@wolfvision.net

Changes in v5:
- touchscreen bindings: move overlay common properties to a $def entry (Rob Herring)
- st1232 bindings: move overlays to the existing example instead of
  making a new one (Rob Herring)
- Link to v4: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v4-0-5c6c0fc1eed6@wolfvision.net

Changes in v4:
- General: rename "touchscreen" to "touch" to include other consumers.
- PATCH 1/4: move touch-overlay feature to input core.
- PATCH 1/4, 3/4: set key caps and report key events without consumer's
  intervention.
- PATCH 2/4: add missing 'required' field with the required properties.
- Link to v3: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net

Changes in v3:
- General: rename "virtobj" and "virtual" to "overlay"
- PATCH 1/4: Make feature bool instead of tristate (selected by
  supported touchscreens)
- Link to v2: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net

Changes in v2:
- PATCH 1/4: remove preprocessor directives (the module is selected by
  the drivers that support the feature). Typo in the commit message.
- PATCH 2/4: more detailed documentation. Images and examples were added.
- PATCH 3/4: select ts-virtobj automatically.
- Link to v1: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net

---
Javier Carrasco (4):
      dt-bindings: touchscreen: add touch-overlay property
      Input: touch-overlay - Add touchscreen overlay handling
      dt-bindings: input: touchscreen: st1232: add touch-overlay example
      Input: st1232 - add touch overlays handling

 .../input/touchscreen/sitronix,st1232.yaml         |  29 +++
 .../bindings/input/touchscreen/touchscreen.yaml    | 119 ++++++++++
 MAINTAINERS                                        |   7 +
 drivers/input/Makefile                             |   2 +-
 drivers/input/touch-overlay.c                      | 250 +++++++++++++++++++++
 drivers/input/touchscreen/st1232.c                 |  48 ++--
 include/linux/input/touch-overlay.h                |  22 ++
 7 files changed, 462 insertions(+), 15 deletions(-)
---
base-commit: b3603fcb79b1036acae10602bffc4855a4b9af80
change-id: 20230510-feature-ts_virtobj_patch-e267540aae74

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>


