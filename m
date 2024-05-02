Return-Path: <linux-kernel+bounces-166353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0978B997E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3701C21056
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE1F5FB8B;
	Thu,  2 May 2024 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="S3x4KkTo"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2092.outbound.protection.outlook.com [40.107.22.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA30056B7B;
	Thu,  2 May 2024 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647354; cv=fail; b=rxyvZUgDYXqvSZ2Ke6GABVl3GrXr6keUT8axD9N20mZ8/HCyVoFfzrnWsNzgTr+iJVstcwHmk0BVKZ7k/b81M6Ek/n3oKYGMCfceJyO4HXoJBTM3usAfJOqxSNHy/3HFzGhdXKn3HmqenQAHWN9cr8z/vDhSYJRvF/2w4ktkEM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647354; c=relaxed/simple;
	bh=K8QQ0vE6kJS0U2RCCfOS9ovSSAbfliVsZQGnX+PMNVo=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=L1Q56LXiy5X85NV1wjZvywryd/AcxNisETpL1tZf7FpUhmCZsMVkR+5keQ982RKJAZ9zxBILr4/Q94RTFAsT3cQFRnz9BGBem0cb4Sl316qUss34kxf7OnSO5ILoJXpauHNaQOOH5nRO1uZg5akgYQrBAM9aAHX4EiqWd4Af5QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=S3x4KkTo; arc=fail smtp.client-ip=40.107.22.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buplrOYkfOPPPswGQ5ucMxdcDMGeoF/yWijgRbdQuVquMZKCJp39Jgp2DPvKNut/adYP0oqx37Gkxa2VWVHxfEOMfTNhVcb3w9gbwdHPkeG/80lMRWbS6nrpPn/82LvZQrnOsjstu2+CRP3xfciQPkwE/FBN5sidkq4gqCGVxoQ27m6Ic1LVZiGLEEAsDYmAtZnYSzL+VeQRdTEsgLM4VruVYF+uAX+k57JeKkvtMY6HxtX5wl8utohqw0hG7WXXXAFDc8x2yhw0xAYH++d+eGaluKKbDGwSNJLkY0jhvZYqe1myVu9E798vIYypJq6OT4ji3mKaVubeyuND+hXRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfGtqk+Uq9rLc4eJZoXD5HSehiPmhe4GyU+bw+vXA5E=;
 b=YYUDg2g5GBxtjC0u0agV+OgIdiMjvl8u+3ix3PjBHruc5Ek1c7qGuPAdS3E52lhTbgR273DwKbteMTSylUWOJAmJ4kN9Tn0AUmbRDPyS5+9PxPnUrw3kZAkzTazYbv3rioPT9f1csl3YjD5GPHMEi6eGfI7+1/0So/zzlRVmNZ5l5IYamgOGJMvgfzcvMXfYdgQnUdWOrse1ahnWTdOendS+4fcXYCBTGd+Y3FxixqTpMwF++mxDoO5quSQmaWiHf0y36uAliv8tZptfrPWkHK3iNaivwTxBLaCklmcxEEpFvmwrdjTRvTs0uw/poE4kPJDuLkY+E2oVkBT7Aj6Dpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfGtqk+Uq9rLc4eJZoXD5HSehiPmhe4GyU+bw+vXA5E=;
 b=S3x4KkToK31VsXzLU7uGAqGGl8ePZRkwZjPDru85U8A18cdGwsULIz4dMVt4/HR2+w2+3QRNWTAE+i6jJrBH17TeI5i0TC5WfllDN6nIuTzgGuWmKWJjZ82oTagXHtQzoEhkMlxKrOOI1P9iNFXtCwhOshj2Ai7QoU7Wbrp5XzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS2PR08MB10324.eurprd08.prod.outlook.com (2603:10a6:20b:5e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 10:55:49 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6621:68a6:ab00:c040]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6621:68a6:ab00:c040%6]) with mapi id 15.20.7519.021; Thu, 2 May 2024
 10:55:49 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Thu, 02 May 2024 12:55:40 +0200
Subject: [PATCH] device property: introduce
 fwnode_for_each_child_node_scoped()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-fwnode_for_each_child_node_scoped-v1-1-868a2b168fa8@wolfvision.net>
X-B4-Tracking: v=1; b=H4sIACtxM2YC/x2NQQrDIBQFrxL+uoKaBtpeJRSR77N+KBoUkkDI3
 SNZzixmDmqogkaf4aCKVZqU3ME8BuLk8w9KQmey2j71pK2KWy4BLpbq4Dk5TvIP7naNy4KgGGb
 yb/8aDY/UO0tFlP1+zN/zvAD9iIorcwAAAA==
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714647348; l=1853;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=K8QQ0vE6kJS0U2RCCfOS9ovSSAbfliVsZQGnX+PMNVo=;
 b=HDQAo6cx3iMEoqs7Ws99rtKNhDYaaWL2t180CkMEQ0D8Uh609Qlk30neM+yz0E2uRueZ5Hfsh
 vXlcqJ1d9zOAarF9FC0Fe16vK2mIOp8Bi/dIjBvW33gah2EYmc9/Gnf
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VI1PR07CA0262.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::29) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS2PR08MB10324:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6831ed-746a-46b9-5844-08dc6a966d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|52116005|1800799015|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlBOa1dUK1Y3Zm9pK1B6d25aZUlCM3BsT3ltdVlIb0t5MGFhcGdETWljRkVv?=
 =?utf-8?B?Vys2SGE2TlE0d21hRDZydjdsaExpOGlOZnRCQjhXV2pCOHh0REtFZlhPSkIv?=
 =?utf-8?B?Y29yRXJ6UlRjUDJkM0dFaGVSMHlLaGpmZERWSHZjdmR0MkFhWkJjLzdLR29H?=
 =?utf-8?B?VytJTlVMMGZ1MkFUem13dkpBcEpEV3J4ZVROeFdTd2xIdEhFMnZYOWhtL1Ix?=
 =?utf-8?B?NEpaM1k5KzVjdVZ3U3doRGY2SnJBZFBPWU4rckZ5SE5nZFNRZTIvdnduRGNL?=
 =?utf-8?B?UVN0RzBrV05zMkR2SmxoZ1JSaFJ3UHVXQmV4M1FNN0MzN2Vmc2hWVVUwKzNN?=
 =?utf-8?B?UFpsS28weHI2dTlITUJZTXVnZnlNay9nRHc2dERobzFLbHBqdFFpQUM4dEN3?=
 =?utf-8?B?TFkyWUZZQ2Z2Wjg1dUtiakk0ci9YUWh6c1BIcmpUMFVid25sdmdFWjhZK2RC?=
 =?utf-8?B?eVNPdVVsMWkwU3R4cldjK3JpbVloaDV1S3dYVEhGOVN3ckVINFpWSVJGL1hx?=
 =?utf-8?B?WUtUaHR4Vyt2MjNwQ2YwS2lSa2VBbFlKOTdtNmprK0lodUx6UkZaQktueU5J?=
 =?utf-8?B?bkJMOW1jQmFBdWFkeDhaamhmaVpreGRtNWxCVVZidW5ldFk1Z1l0c3VpU3Jq?=
 =?utf-8?B?ZitaS0FWbmRsVjZ1UGg1OXQ5SlZleklOTGVkVnpiTUtpQVErQk42TmZKZ2NQ?=
 =?utf-8?B?U2w4dlV0VDBPa2dKRHVJY2RMS1FDS0ptZWNyWmlDcTJsU1hydTFsVy9PYVB1?=
 =?utf-8?B?OVdyS1NzTlZiRGdYUGF6eXJaTG8reHNxSHJxU2dNT3FGNkpyY3p0cFFFMVVo?=
 =?utf-8?B?NGRUZE5WQWlhc29XN3hWdDczekpINWV0WTEwejluZVc1c2MydWZHT09Kaktm?=
 =?utf-8?B?L3pKbE1NYkFHTGFPa1ZsQkFuTE04b3RBdmd5NkZoV0hBK2UwSERxQWlCOWZ5?=
 =?utf-8?B?dElRa0U2S1gyY2xUYzZrZkpsOTZoR0FnaVlraWgrSmEwNjlNQ1pqeWJFTWVi?=
 =?utf-8?B?dDlnRzBWYk9OQlJ4YzgxZTlMTnBkNmh3Rm53d1EwVml5a2d4Y1Rja3diS0Fz?=
 =?utf-8?B?VmJUL25TbXZmRWNQd3Vsb1BObXJSdnZSSHZpRy9GUWFrZk4wMGJ3NlExWUZ4?=
 =?utf-8?B?WGwyaFYrSGtOWkdWaE9udityR1lnNXl2cDUveVdPbGZqTTI1b0VuM3czbW5N?=
 =?utf-8?B?QjJ1Nk44VlJqMlQ1bytHYlBnbnJaaUs1MFVLdzc4NGI3OG9NK2syV0VsM1lo?=
 =?utf-8?B?SVJrK1ZrbXBoaHRnZmZQMnRGTUhYRSt1UGJseVVQVWxRekM4ejlBRHhzY2Nu?=
 =?utf-8?B?VlpYL0gwdG82VWtGU3hQY0JtUk5GNXpLZmh6S0I3dUtwOUt0M1hZVkl3Tzda?=
 =?utf-8?B?MXppYnQzanYxbVpzS3Q2V2kwNXhLdXp5N2ZXejByTGpKVzA0b3VDYzFCSExG?=
 =?utf-8?B?TEljN1FnNVNQeSt1SnRaWGpYL0hjTDkzS01jQ1V6Yy9mbmpUU2ZUaUtuK1Bq?=
 =?utf-8?B?S29ZbzhIV0UzcEZEVHdIVFVSNGNmOWw0MWVSOFVqSlVLamY2TEpsUE9vK0Iw?=
 =?utf-8?B?Q0JycVdUSzRxY010bEVFZUw2emRDejNNNEhkSkx2ejJ1NjJmWjd0dFMvL0hm?=
 =?utf-8?B?VTNkb3F3ckNnYmtBV2haZGxJOEQxdGRHY0NBNzE0Yk9CMXYrZVdlN1U5TkVZ?=
 =?utf-8?B?TWloTjFTb01kRk9rbk40bG1uKyt4OW9sd2Mya0FXb1RVeDFoQjMzWUJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3VPN3IrY2RlVXIzNWc0UnBIRVRqd3VSZWF5WjBBV0d6L0NFK1lpNkhSOENY?=
 =?utf-8?B?Y0hWV3NNbnpkUUp0SFJnYWpBOGxOVzZkVTFHU0UyTUQ5VXBKUlFOM3E5VU83?=
 =?utf-8?B?QTNTYmc2UDlIY2I2K0JlSVd4d2x4c0FXSVNaZlZrZ0NJQ3R0MkJkMWovUUdO?=
 =?utf-8?B?RFEyMEZrcTZZNUkvYjk4eEwxQ3hVQXAvZlhrbXcvV2NLWHFYdlJReW5YMnpK?=
 =?utf-8?B?cTd2aFE5b1Qxd2tWcWJ1S3k5NEFMWjl3K2ZxaVpoa0h4Z0lzVmRJVnFWR1Np?=
 =?utf-8?B?Mzc1M3QzNlJ5ZEVXNHZpWXB6d21xdWtiUXpCSnZUMDhuT1BmSzM5b1FyS0t0?=
 =?utf-8?B?R2luRnI4NmIyanludTBScy82TzJyUzVOMzBPVmllajhZNFFCL0l2R1BQVlhx?=
 =?utf-8?B?cXJjZ3Y3emliT21ZRzhnYWgraERRRlpzUEtid1lmQTJPU25aZkdyczNueHFF?=
 =?utf-8?B?RDZFSG4vdzJTRHZsaHBCL245cmJWZjYrTjRaNmpSZjNyL2N6cXBSbWpFM2Np?=
 =?utf-8?B?SWJRa2RTWDZUVysrWkM0cWRSMWl1eFYzZ0J5dXd3ZjBtODNVL09HcG5QeVNC?=
 =?utf-8?B?TUJ6V2NVRWVpanNCME05M2U2b2ZOQ241TmYzWUdVeXZiRS9scmVUU3RmZVhK?=
 =?utf-8?B?ZHlDV3pEYmdlYjNyaVZaU2ZVcFZXeFVEeGpNRUFGZDVkOHdTcTFBTFQ1ZS9U?=
 =?utf-8?B?Ti9VMFhES2I3QmxNbmlwRUk3K1ZZNVVXaStTR25xWFVLdlowZkNMeUVVSUFV?=
 =?utf-8?B?WDN0SWRBRktXYTZETnpLMXViNjNKdUhOaFRIZEJnQkJWWWt6VVBnWm9IdDBT?=
 =?utf-8?B?clZsTGF2YlRCVVUxZ01YMEVUcTg4UnY3RWtoU0ZYbXcwWFErbHZzU0ZWQzVG?=
 =?utf-8?B?Z3IxY1dheXkzZnFQYmh6RzRlclFiQ3RMZzIrSnBKYVpGU1VuUTdCNzVMYmE2?=
 =?utf-8?B?cHBDOXY4TGVkSGIyNFN1eVArYU83OC9qWE4zckFxUTBteStuMlMvUjIvODJF?=
 =?utf-8?B?aHRLZFY3MWRaZEFQRVl2aENlV05XRGsvdEticHlWbE1vUTJEQzROcWtkS05z?=
 =?utf-8?B?Y3FFRENGMlF3ZndaZ3R0QzNKaWQ3ay9BRGczcU4zRjlTY1lhS2E4c3IxUlYw?=
 =?utf-8?B?ZE1Va05QV1o2bEhFdjZhTXFYcER1TEFqSW9HTFd3Y2ZVbW5tTjYxZHJQUkNL?=
 =?utf-8?B?elRqcHlDV3NrTHNmZVExUE01UUtESm5tbDBZS2VSekdFa1p6bTlOMmo1cS9U?=
 =?utf-8?B?YWE0UFpha3RtcXdPc3ZHZXlsTndIQjdJUGMwQjZTRzlDb05DMSs4NDdIei9D?=
 =?utf-8?B?ZEZISEFGOVpuVk9PRHQ4bTZpRnZPVFQrdmd5aGRCNVhpaEdlS1FoOStoY1dL?=
 =?utf-8?B?b0JlQkJ2bU9mTVRGTzd2WWRPcVJCQ0t1VHBaRU5udC9KbzV6aTV4NGdXa0dy?=
 =?utf-8?B?ZDlDMFJNZ2lRYVA4bWJiN0FJUHNtd0VXZnVOVFVnbk5VWURVenlSSGFDcXEx?=
 =?utf-8?B?QXkwRG1jcGZmaEdPQm52bmZSd05KRkJMSzhsMStQTnY0UEoydXAvRE1YYnFS?=
 =?utf-8?B?aXhXbmljOSs0Z0Q0cFdtSDVBak02MTZscnF4aTVROW5kUnF5WGp3N0t3Ukkx?=
 =?utf-8?B?U00xSkttUDVzU2xMOWp6MFMzQXFZc3pYMm9hK3E5ZVFEU0VJa09NckxQc3pE?=
 =?utf-8?B?bDBudC9Ja3o1RHE4T1oybTFKcWtjVUR6T3c3WEQvbS9QaCtkZDlHNGxBTmwr?=
 =?utf-8?B?ZXBzbTlGVHp6UkEvL0ZlNGdmZFZnZEpKMnczSWdWUTJQWWhTd0wxTWhuck1B?=
 =?utf-8?B?STNiOWFiMGlqYjgrdkZ5ZXVNVkxkMGRUdDhXaGpUQzRSVmIya2daemwvbHFT?=
 =?utf-8?B?WUVnU3l0RXNpRURab0g0YmVZYmM5cXdnZFpuTzIyRlM1Z3RYNy92NHkyd0Uw?=
 =?utf-8?B?TTFTYlBuZmJaTzJPTXZlcDY5Z0pmNm8yVXphdjIycnI1cHdCNk5qK0V0QTFx?=
 =?utf-8?B?dkY0NXFhWEpCZ2ZPc0hOeG9xSXZ1dW5iRTRYUDBsaEFoVEt6eHlDd3d6WE9y?=
 =?utf-8?B?ZzhJSlRwRXdmS2x4ZlM1b0FKeHNwNlJ0SHdkLytGN0hhRXlTczZ5T1p1bGNm?=
 =?utf-8?B?MXc2RCtqb0czamlHV09GeGJHRE9tcHYyWTJGN1pPbmxuQ3UvaTB1Q21hMFU3?=
 =?utf-8?Q?1bnik1rUh72vr/WgWaSLFPE=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6831ed-746a-46b9-5844-08dc6a966d46
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 10:55:49.1578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQmqXIfJnVYCzOEPmidLqeY5latoi6V8xX0uUnEA1SDBcm6up/qXRxCOhFIo2wCcAoTYA5LlG5MQn9wDjxXrDBu4hSPB0ZKFndFo3wH4JCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10324

Add a scoped version of fwnode_for_each_child_node() following
the approach recently taken for other loops that handle child nodes like
for_each_child_of_node_scoped() or device_for_each_child_node_scoped(),
which are based on the __free() auto cleanup handler to remove the need
for fwnode_handle_put() on early loop exits.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
This macro has been tested with a patch series that has not been
applied yet and is under discussion in input [1], which makes use of the
non-scoped version of the loop.

Based on linux-next (next-20240502).

Link: https://lore.kernel.org/linux-input/20240422-feature-ts_virtobj_patch-v9-0-acf118d12a8a@wolfvision.net/ [1]
---
 include/linux/property.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 61fc20e5f81f..88f930165071 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -164,6 +164,11 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
 	for (child = fwnode_get_next_child_node(fwnode, NULL); child;	\
 	     child = fwnode_get_next_child_node(fwnode, child))
 
+#define fwnode_for_each_child_node_scoped(fwnode, child)		\
+	for (struct fwnode_handle *child __free(fwnode_handle) =	\
+		fwnode_get_next_child_node(fwnode, NULL);		\
+	     child; child = fwnode_get_next_child_node(fwnode, child))
+
 #define fwnode_for_each_available_child_node(fwnode, child)		       \
 	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
 	     child = fwnode_get_next_available_child_node(fwnode, child))

---
base-commit: 9c6ecb3cb6e20c4fd7997047213ba0efcf9ada1a
change-id: 20240502-fwnode_for_each_child_node_scoped-ce15a9a831c3

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>


