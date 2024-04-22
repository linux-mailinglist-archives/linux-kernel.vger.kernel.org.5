Return-Path: <linux-kernel+bounces-153152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA1D8ACA43
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6C61C20F09
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50511411FA;
	Mon, 22 Apr 2024 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="lz2iNvhK"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2130.outbound.protection.outlook.com [40.107.22.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF25013E8BE;
	Mon, 22 Apr 2024 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780475; cv=fail; b=XX4GVfyjwqfrlHC3LkHjhLtCKr+q5rv8y/bxpNDMfYD65zBgdH2Xrl8rh5pZuXb99DgRxxfSZeYo7QGndkwJIfr9Zn+8KApYNw+8V6DBQkni7GlA/NAidmnTsg7FSNJjurhbaL2adR9oQoH1wbrfBh+OYM/J3zR0mYRcidgzBrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780475; c=relaxed/simple;
	bh=p9Jwz/8rK0zTZPWVuIL6lA7Sdrjcu8RH3+Ur4C6kCgs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=j0dk942T/x4sJOdomxpzUNX/68dtZ8wxykTb7CxQc0GzC0qioAYCN8UpYGFGicRIjekrrooa43r+CVsf+DXfbSqS+mBZqw7zKMbaTiyLQpKCikKd5fFEnvqOA4alG43fDknLmXq9E60kbLzI5MioMRH+rwg+HXNTe6j8U42jhYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=lz2iNvhK; arc=fail smtp.client-ip=40.107.22.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLLc0Hsu83S2RtHecw7kVVvEJW05ZQ9LoXxBllIUOP9aVca3PZlhASzp5ZGymwRcdPcxhgqgdRZmenNWpRebF+mSNQL6PqYfs4ER3M2gakmxOuxsM6FrGx0th/jbql33rN2vuWL/3+xp+zqm5Mah8M84R1Utb7BQQ1oFRMAIi0xaE1pl8NvYjJhNv10CuOrpGry/hS6pi51s26zOPlL1W5cwlY4sVip/B8SmvGvSDmA74S1qUUf+dJ4bc+dQj6hPHV8ht9/q7Mk/pTWEwVqQ5QZYgyGGb4Aeh/SCgry7BBvXfaTcfMjnLNOSdh4wXOUYGmvs+SIyK7wvvftYd8G9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0u1KdYXdRmqiAc1PitUbeMUNPuGUu3updOr0DLsVY+c=;
 b=BkAFZ7hjyv2PpbzIOxL60Nj/uxUDInOQz4yzk1FF7+4PaBdvbww9tMQIrMVj+TMwOnUxzUD3Da11NB+ms4iitzlCe+6i8qmHNilktHy2aoiMgYG0cIPVlF2fO8vSpAAjtulbPEwxqnFQAP7wrFKy9KLbMHI1RWzJ8IHHBwL16g0+51Y9UFaPo6nzQFx4OOgWvI+N6tqMBerGy07v9WO//cw0wdErL9HCNnG+gxqdRrd/T9eAT5OIqcjEzCw6sZzkqVpWN/wPxrFz5tTczJFd6nnQHGJ/Iffh0qzzejQM8b0tgMQWeL7FI+xnrSQehhpATIWtbntEAn3M/pCajgipfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0u1KdYXdRmqiAc1PitUbeMUNPuGUu3updOr0DLsVY+c=;
 b=lz2iNvhKcfks/MUDSmjMtL3W7J5MujW8+cRYvuOg0tRtU+t4G0PAoeKtU9isc5bW0qI8ITmcLK9Wz9MOCMyphRY5n+idWKDC+XWqGrH26H2SxkravgjGtfi73j8LqRZgJwbD2ejRiO+R3/N7aHLBi/Rrlv6PwElz7Ngdh3B3Nbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB7885.eurprd08.prod.outlook.com (2603:10a6:20b:508::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 10:07:45 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6621:68a6:ab00:c040]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6621:68a6:ab00:c040%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 10:07:45 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Mon, 22 Apr 2024 12:07:39 +0200
Subject: [PATCH v9 3/4] dt-bindings: input: touchscreen: st1232: add
 touch-overlay example
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-feature-ts_virtobj_patch-v9-3-acf118d12a8a@wolfvision.net>
References: <20240422-feature-ts_virtobj_patch-v9-0-acf118d12a8a@wolfvision.net>
In-Reply-To: <20240422-feature-ts_virtobj_patch-v9-0-acf118d12a8a@wolfvision.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bastian Hecht <hechtb@gmail.com>, 
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713780463; l=2517;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=p9Jwz/8rK0zTZPWVuIL6lA7Sdrjcu8RH3+Ur4C6kCgs=;
 b=veMcZnBSjz+/gVOSf0+SqQmwXYUqbRRVhV4BSUnYUz3Ata7Mc3mhUuxX80kCdPRTy5pKOQIbi
 yyB/d1pRijIDuaFcum733CC4WIIeucDUyPVxP7k5+5sdgGR1d75OhNV
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VI1PR0502CA0004.eurprd05.prod.outlook.com
 (2603:10a6:803:1::17) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: ad556cf8-82f5-4a56-99fd-08dc62b40e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmtLeGlqelB0RFlJT3NJOUNnaW5XR0dSOGFjTm93Um5LbmZnbzhjZno1ek5W?=
 =?utf-8?B?V3JDY3JPcmFadlJsWUFZelBNUDN6M2hQN29ZTDJXR2t4RkFENWhyN3J2VERp?=
 =?utf-8?B?SjBUbmRGd09QR1FnOTlqR1puYkJ3dS9LaXgwanBpc25vRVdqcUlLY1ZTVHYx?=
 =?utf-8?B?TTVhb3dDYy9vams1YXpIYUk5aFFRWWlKcHpmSlJSZkRkRFkxbUkxNHEyanBO?=
 =?utf-8?B?anIxUnFEdnJCbXlwa2x0ZlV0U3hxbVc4WGZwNEdGS3pmVHdoRHgwd0JqWkVS?=
 =?utf-8?B?TU0rY3lsVktJVzhoWnBURFp6Nk5PdVdpTFJXVEF3YzVoc2drbGNXUG5aT3ZX?=
 =?utf-8?B?S2tuVnY2aGJNQndOWVhxckFSakpOckUrazVLMW5UZHcwQUM4NUFvN3RoaGdE?=
 =?utf-8?B?N0NVV1pnM2pJaThhVmo5THNyUFdwVmZmYjRsZGhHVHhjUUhmdGhscTZaN3o5?=
 =?utf-8?B?RTVLVktJQWtTWERNbFdYU1VZWHFVNitjYk1kU3Y2ZjRuWk9CKzF0SXRrMXd3?=
 =?utf-8?B?Q2tzVzkwYk1DT0tEVFVmUmtwVHROWlZ4aGRwbnlUdkZsY1pZWHV0TjVvd29w?=
 =?utf-8?B?aTdXcnNXeFhwSjZORFBwZjJsVUdGckZrVWVXTnJjQ1dDN25Pdi9xQXZTTERK?=
 =?utf-8?B?OVJiTU1QaXZvSVcrbkJnNjh1U0tqU0hoQm9NRS9JTmJlbllhNUg3SjN0dmlH?=
 =?utf-8?B?SVhMQjZMR1JjZk1pWkVqVUtJYlRmSFFnS3dSS0JTRyt5ck85RkUvQStkbkQ0?=
 =?utf-8?B?TDd0M1NYWU1ld0JIdys4c3FaZ2QvUW5nbVFKakNzQkpHaHFKSnpVOHhqK0RG?=
 =?utf-8?B?bDBScU1UQ2NkSElYNmpMRk5ZVmlDRkVPcHI3RHMrc1QxSDJpdkoreHBIWmNo?=
 =?utf-8?B?b1laeVJXeDUvRGJEcmYra3IxaDY4V1FtL254ak1mZnNHL05qSi9QMklNZXVh?=
 =?utf-8?B?UjdDWUtLVytIVVdWY0FKSXVxR3V6OUZYcm0vTHpZLzFtUFRIOW1qTWU1MkVX?=
 =?utf-8?B?aEllUXFGOHVCdUhLSENxcUFBVDg2NHVnMWZZYTFHQTR2bUdHUyszblVvZ0xB?=
 =?utf-8?B?R2JMY2NJbnMxd2ZVSGtQcFZDU1VwM2RNNHBwYU45VmNVbUVxV1ZDd0JBRkNV?=
 =?utf-8?B?WEpFS3YwREJjTWhaYy9Ha1kwMXc5eHBTamtzdm5lZUhTY01odTVUOW5RTGJP?=
 =?utf-8?B?QjI3U2VIcTh4OTU0MUd2cDN4emhZM1V1cERRWnFjc3Z0MENCTW9LM1BvWkZE?=
 =?utf-8?B?eVNoTkNDU29QYytkUGRoajh2VWZTODFTMmNNOGd5T0k1ZTJhaWFuWHlPaDZC?=
 =?utf-8?B?aEJkYXZNUjZiS1BVdFZoTHJRaDcya0hUN2JJblUrWExMTEdPcUhtT0hibmEx?=
 =?utf-8?B?WFFnV3NOZzljNVQ5bFRsR0NkQmZaekRnUnR0ZzVyejlJcWFYL0dDZWZpMjZB?=
 =?utf-8?B?MjR6czAwc28wRTAzamN5K2F3N2dpeUNqVFQ2dnZnOWNyajNES1pmYjZKTmZW?=
 =?utf-8?B?eTVGa1JrY094aVhveFdXcVZwcXBWQWlhTyt3L04xMTc3TGI2RitJUW5HQXJn?=
 =?utf-8?B?RitHeUtISk50V2F0eUdvTUVmTFFQQzZCc2s1QlVTbTFxTDhpNEE3Z3o2a0Jp?=
 =?utf-8?B?MFZKMmJFZE9xWWpkVW1iTUhIZlBsYmNlb1hsZlZzZ3Z5eXJOY1l1ZWVJVWw1?=
 =?utf-8?B?R3VON0U5QnEyMEs4c0l2U2VTbDE3S0pWWEdoOFBqMXdVeHcva2owVDlydU4v?=
 =?utf-8?B?QVhXY0lBejk3aEx2aExJMGhuSkl6SUZFL2hyejNzOERLV2ZwWlpNazlSbTJj?=
 =?utf-8?B?MzJpK0R2UzJxUkw3bkJxQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlBmQUVuZXcrRkw0RTZ1MHFDRTF1bHgweU81ZjFvTlp0L1dydjlxWkJjZ2lE?=
 =?utf-8?B?emNhT3I0c2NYVFM5NXFRUlRaZmE1WXlGNEtjMjM1QS9kaEN0VFJLd0FUTTNy?=
 =?utf-8?B?T1NkMWw0TEZxdndtVklnODdlaTV5NDFhU1BxaEJZUkRXd3BjeitLVngvZUht?=
 =?utf-8?B?ZFZlYnRNUWhZd2hoL0JyRHNzNDdCUTM5SzFQUnlrKys1ZGloYVVmbi9MSi9p?=
 =?utf-8?B?WFo3SjMxUzg3WURJdkRxOG5HalBrbUdiZWNuNEliQngraFBWMkEralROQjNa?=
 =?utf-8?B?WDhqUnVrQSszSGp2WEw3Y2hoVlI2azNEbm9YcmJYNGRuYVVNNFZpdDlsZFli?=
 =?utf-8?B?YnM4bXZMb1djdGxzMDRqdmllUWx6aU9UNGpsUnhXL0Q2dGVCci9yY21VQWNv?=
 =?utf-8?B?Q0kraXJOeDVObTBFT1piRHJIVEJkY0Zsbk1LbDBHeXNRaHRzSkFHanl3b2I0?=
 =?utf-8?B?TENBVW5qR0s0WVZyZHJkcXNFRWNTSjYyUFBZRG9Ha2R6MHNhdU9XYiszbUti?=
 =?utf-8?B?ek0xRnBESk8xUkM5SGpxQ2JIaWZueUZJa2t3V1UxclZ2R2ZPQk5jdERoNTNP?=
 =?utf-8?B?c296dlJrWXlTS2RLQ3ArekVpeHI4R2Fmbm9jdzRpeVZXY3NkYVFGN25rTEo0?=
 =?utf-8?B?ZlRxWFNadUNxSi9sSXVva3RTVUZWdjhJRWZMKzhoNzRlR0I2R0RpaUc3d0Z5?=
 =?utf-8?B?Q0MxRVJEQ0FKUkk2QURyY0thcUdmVmFVVVBTallrK1I2cWgwaFp5Y0s3cWRt?=
 =?utf-8?B?T0RCdG54Y1NuWmJZUUZ4dU16N3Y5MUpxYmFVcjhVNE12b1pidTFIYmpUejJC?=
 =?utf-8?B?OGl4d2tKVFdvZVNHTTFOS1dncU5Xc3lRSC9TN3VuVUZtNnNVb1k2OGlWcTVO?=
 =?utf-8?B?blFsS1RUSDJBS3c4dzFuYjVOdkVtZ0lrSFBObHMyZWROWk5ZTVZZL2E0Sy9I?=
 =?utf-8?B?S3RqK2FRWnRrZ2RnOWg0REFvc0RkOFZHdVJJQ204TEVJNXdsVGxoNUhQZ01n?=
 =?utf-8?B?WGs1SFd5SzZyUC9vOEZGMnpwM2hVeFlhR3owSkVHc3NIRVNDeE9nRCt2UnFR?=
 =?utf-8?B?U29hc0VXWElRTVdic2dsb1RyS3gvdjhSaGJwZUNOMXhTUTdSUFBwejFsc05K?=
 =?utf-8?B?eWlBbHhUNG9MampPYUw0TWJQbWZVSll0SUxvbVVXSzVqS3pOOVZieXZRa1Zu?=
 =?utf-8?B?bHlrVzNkc2N5dldqY0tudWZIUExFdkNZckdLVDdTUU53dUs4MUsrWkxlMTFp?=
 =?utf-8?B?cmY5dzZKRWhWSk0wNjgzekhXOE5kZXZxaGdHNjg3YTNxQ1lVYkNKM05FLy9E?=
 =?utf-8?B?MkYwY0g1TVVML3RjZTR1OHllcjFNalJtd01IcUhMZEgreFlYc1NZY0JFLzNv?=
 =?utf-8?B?UklqZi9venJvdXdtRytKYkY3TmtscUFjTkxGSEV4SVNjcWJ4enA2dTBSeC84?=
 =?utf-8?B?ZE5GSTh5OXpyTHdsbnVxREFONG0vb0plNlltMHpDYkdiS0JUbmFSU2xldHAr?=
 =?utf-8?B?WkNCNjRmWXNIb2dLUm5TWm1Jb3M3LzhUaW9lQmxHOG1CSlNoUWNRV3pEMFhJ?=
 =?utf-8?B?UDViM3RteDRlUDdjckQzZTJQQnc4ZjllaXR6M3crUnFDdFVJQzNIVUtOZFdZ?=
 =?utf-8?B?bGdVVGxlNHlERUZ3Q1BjVG44TnZiWm5BU0xmWEpmVjZKMGpZK1ZNRWtpdExW?=
 =?utf-8?B?b0xSUU5VUmxHNm5KMzJpZlkxWkZhM3ZPY1diN3h3Y1VGeVBCRCs5TVQ4MkdV?=
 =?utf-8?B?bktxL1lRU25oSUtVQzFFd2xzZlU3aEtQWXNYZGZ2aFQ3YVhhZnlMUFdlZ1Ja?=
 =?utf-8?B?RXZBU1hBTHBYeXhJcUovcTJPRTF4UjhpSmxyRGxKWW9DSnAyNEFjdkNlTk04?=
 =?utf-8?B?ZmlRRUp0K0lGR2NkSjNaRnR6ZXJrb0IzK051RTMyR1FaMzRuN21tK2FQdTA1?=
 =?utf-8?B?eEZpMXZpQ3dMdjF3V2FCdkZBTnlLOWFDVGpFQk82UXhBVTVpVFRiTGJJNmk0?=
 =?utf-8?B?djBFUVhPQ2Zra2xIaGFXQnhJOHQ1clRZOWxSZWp1bDExbDliRFZDU0txc1BY?=
 =?utf-8?B?Z09jd3lsNlU4UnFrZk84ZkJjZno1cVhjb1cyc25uOVJSOWd0UE4rb0xBTmZa?=
 =?utf-8?B?cFpWV3VGeXhXYWgxemJNemVmVkdDTFFrdlBZb3dGYjRRTWRsTTJSckxBbzd4?=
 =?utf-8?Q?2rIQAC2IJSrMMCAT7DIOIUs=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ad556cf8-82f5-4a56-99fd-08dc62b40e12
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 10:07:45.0867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLwuz9JRpZepJLbpBsIBJgxVyrspAxlnRZRCKcjKVGx2RBmcoLc8Ckfl7YMem6W8Oe/I00Q4vMxcYQhogjLObt+aEBQbCKKw1jlll31CX04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7885

The touch-overlay feature adds support for segments (touch areas) on the
touchscreen surface that represent overlays with clipped touchscreen
areas and printed buttons.

Add nodes for a clipped touchscreen and overlay buttons to the existing
example.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../input/touchscreen/sitronix,st1232.yaml         | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
index 1d8ca19fd37a..e7ee7a0d74c4 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
@@ -37,6 +37,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/input/linux-event-codes.h>
     i2c {
             #address-cells = <1>;
             #size-cells = <0>;
@@ -46,5 +47,33 @@ examples:
                     reg = <0x55>;
                     interrupts = <2 0>;
                     gpios = <&gpio1 166 0>;
+
+                    touch-overlay {
+                            segment-0 {
+                                    label = "Touchscreen";
+                                    x-origin = <0>;
+                                    x-size = <240>;
+                                    y-origin = <40>;
+                                    y-size = <280>;
+                            };
+
+                            segment-1a {
+                                    label = "Camera light";
+                                    linux,code = <KEY_LIGHTS_TOGGLE>;
+                                    x-origin = <40>;
+                                    x-size = <40>;
+                                    y-origin = <0>;
+                                    y-size = <40>;
+                            };
+
+                            segment-2a {
+                                    label = "Power";
+                                    linux,code = <KEY_POWER>;
+                                    x-origin = <160>;
+                                    x-size = <40>;
+                                    y-origin = <0>;
+                                    y-size = <40>;
+                            };
+                    };
             };
     };

-- 
2.40.1


