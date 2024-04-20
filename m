Return-Path: <linux-kernel+bounces-152247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42218ABB58
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D895C1C20E2F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01DA3A1C5;
	Sat, 20 Apr 2024 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Biqqbcvr"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2138.outbound.protection.outlook.com [40.107.20.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC142942C;
	Sat, 20 Apr 2024 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713612194; cv=fail; b=jjzJoVj5KiqOBLPKJqLYxAjRKkpx+v3qagwIAUJta4AuwzkNfWbwRIIBlrw/pDY2Futi7Sda6rhIsBHkJOeqDAWAqJlw9m4g4VuShpuoLsfgg1ODXDWMkp3GW1vgp/n9IXFCAbVtYw9TfsR6zHSSIs87WbclNZ+zy5VBuxzfa0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713612194; c=relaxed/simple;
	bh=qUmhMOYO7hRAmXJtCXe7TY5aDCN5U0hzSn+jyQb87Zc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rQBhLg+qIG5pHxZ5JbOZqkY+txG++bMqU2CLG45npE7wEFeONw8vtOcmQ2LhuMKDlqBqNduYk9PZIgtRgn3oYX7ElquP4S0Cm2U6O7vokM/X3R9yr9pOGawCcEA6XIOQhlbTXOoI5OS6vWMYPw4XJEZz/Xs8ulKfvJAdTQt188I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Biqqbcvr; arc=fail smtp.client-ip=40.107.20.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYwlYF6MaWFDcO6ROPEbc3oeCng1E0c0OnfICVfd9cQ7S9tyOxpQ+1/2o2vquHUKFirZhj1aEfJVl0VGkphphqAyGGyJBQmRjAhQILqqfjde64YPPBPapO/OmRcOVRqOvkUAptJvdxWfqO9O23naKKkHKqDRBFbiLcA6fzeGPRuBwlf07OsJSHr501YakPvYNZ2DbDANdnL3lJWcUXZNk7F6g69PMhmEd6SuV8DlIZ9DNAtOkprkQkWoTKbjB1U1ZTgQzgk6K9AAeI6pf2/kWRVcvmmERplrAMaQRTQAy8CiUoSbnGiaa+2Uf7eAJICPIgnqDpZKhjzcuoDY39wBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKr43lIb/a8ZPpWQGxFgPVTJr4qK7JqQVy85temD/b0=;
 b=FDXZOZ05qN0LRDZQa4tJj7e/WeH1MMJykuNxpJZyRn6CPL1pi1QwNnWLsEuNWcIEBEpytOhW+rvflpSBnEuCq6yzErOYIEZ/w0Fc0PdOWXe0DfF05mU0LqThunOI/Cv6tG17pgxjklpaz03aaA70/UuyI2pR0jmW9dPsGq91tEC8VL86OuyV6IqfGhkkAe3F5NuRVzOJhuN1g99MAhUW0nh28iGVzrcG/M5XgwPbtWXymyeoVr/89Edab1OjDB6MpLII+5aoIaL93s+YM4T9PRhZ8NBcYJGfXygLklxbPZ8b043qmJUVmqJZW8nCLKmlf12ZE50ApXtFYvlbFpwpXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKr43lIb/a8ZPpWQGxFgPVTJr4qK7JqQVy85temD/b0=;
 b=BiqqbcvrnAk3FDV70o3139Oot9Bh0IJ2NnZIxiWrWU8p1BVZoRqoH46XR5i5pfCwdiOG7zUhr7P+rw9iU3IPbGAhp23Qc3OwaZ9LrcB3fg9kCfSzoFTM/7m0/pZ/GFYEWUfVoFRnoxXGGwPlQc21oBSajtSB4N5cbBXWAqq5lRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM9PR04MB7588.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sat, 20 Apr
 2024 11:23:08 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7472.044; Sat, 20 Apr 2024
 11:23:08 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 20 Apr 2024 13:23:00 +0200
Subject: [PATCH net-next v2 1/2] dt-bindings: net: adin: add property for
 link-status pin polarity
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-adin-pin-polarity-v2-1-bf9714da7648@solid-run.com>
References: <20240420-adin-pin-polarity-v2-0-bf9714da7648@solid-run.com>
In-Reply-To: <20240420-adin-pin-polarity-v2-0-bf9714da7648@solid-run.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Jon Nettleton <jon@solid-run.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AM9PR04MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: c110f105-a6a6-4c57-7a15-08dc612c40da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1dISktMMWhZektWemN2c3dZN3ZFQlpCcEpwWFlhVytXWVFiOVZKYXkvOHRS?=
 =?utf-8?B?WU9UR3RFSmxWSm9ZUXZEK081L0lmQ1hxYVdrV0I2Z2kxdlpwRXcwRERXN3FT?=
 =?utf-8?B?VzRQMnRnNzJIV01XdjlXTWFZSUdLcVNiTU42dWMxQU92bHdabm9rcFM1dWFs?=
 =?utf-8?B?dGhOWGRjSUlENVU4eHJ4TkxmOFZuY2pFQm5aMUFGNVgweThrem9UWDNwYjdu?=
 =?utf-8?B?Q3dIVWE2UW1UazdRVUJraGR0czlkQ2R5S3V0VVgvUEk2a0N5Unc0c2RxbUpY?=
 =?utf-8?B?ZUt2S0ZPMkU4TEc2S1YxYzcrMkZ0M0hPTEMzT08wcE13WVJJWHBKcHVHbW8z?=
 =?utf-8?B?MXA3bDRBU01ibE4zczZid0lCY21COFhsRU5WRTdqbzFkZzZvbXVKc2N6dzBB?=
 =?utf-8?B?QXc2Tk43U2tVOG1uSjhlQWhtNmJ6TWJENCtKclE5K0NaS3E3MTJzR2dwanBR?=
 =?utf-8?B?TEFJQkpBRmtHV1AwWDM4a1ZKT3dZQkFnSkptblJGek1kMW9YTnJxUUZyNSsx?=
 =?utf-8?B?ck8yMGhjdEFveUorbjMrRU1jRktHd1FNQjN3cWJHNFZVMGJXODl0azRwaDFy?=
 =?utf-8?B?RTZrcEJveUJYSDFRL3JsRnlUMWpuUTBIdFBTV25CWCtnbVpESjVORzVwQ3lS?=
 =?utf-8?B?c1UySmxJWlR2Q2FhY2FLSUI0MjAvTmJTcmVKa2NhbDA2Ykw1UGh0M3l0dzFv?=
 =?utf-8?B?dGQ1WDZ0ZU84Z0xRZEtpQ3VoRlpER3doc1pRODA4d2lKRFJTcE8xc0NHRkVv?=
 =?utf-8?B?eFFRQkI4RjNuQklzUExaWFlkeWZtNjUwRktyT0NBT3p4T1Z3L2JybS91dHRJ?=
 =?utf-8?B?c3pLN25DNCtmdEc2U055T1hKa3VBRE9uK1JJQVVtR0pTdnNsQmxMMElJcGVO?=
 =?utf-8?B?MTNYTm8wSHE0M1ZncUlFeHJzY3NjM2VDbnd4NXYyS2hhOXJvT0pUblhPdWRy?=
 =?utf-8?B?R1dmZkVOZE1sYVROTmdJRytSaHM2QkhudnY3dXNCSGMrZUJOYzIyRFVwOGcw?=
 =?utf-8?B?bXg0REtvN2Z0eUVDTXFGTkpITHVLaG5iaTVVU244K2IrTlpzUEhncElXN3VF?=
 =?utf-8?B?Q3RVd1MxS1RnQ3JGay81QWpIWVcyTFNlN0xVMG5yZG9TVHdtOTBTL0l4NjlV?=
 =?utf-8?B?RjhGblBIUW90T1dKcjE5RTBGUDFBSzB5Tjg0MU9CT1FyMXV1VGQ1Nlg3MWU0?=
 =?utf-8?B?YzBRaHVxdW9BdHRNelN5dGVXZVlLT0lOT3BzdnFDNk0xdzVIcllpTnhoS3hu?=
 =?utf-8?B?aUhERS9jWVA4OStRNTJyTWJCNWd6aHJHd1F2Q09kNjBkTERHcGwxRUViZDM4?=
 =?utf-8?B?WGs1SnJaZEtEdjg5bVZ0amovazZmZlZGcGZtUnI5Y1J0b2dsOWZxc1ZnRXUx?=
 =?utf-8?B?aWxXbjJseVpnb3o4WjVrS0RES3Fjdy9yV3pJekI3SlNvMXB2ZUNQNG1zeTNV?=
 =?utf-8?B?WHpHSk1tYVUwelIvNE5remI5QXU0SXFBN3hvQjZZdHBNeGEvUWRkUHlXQmhq?=
 =?utf-8?B?andsOGZzWDhRc2VOVmJkaVE3NlFYSk0zNG9GYTYvV1FLaEVpYzRFeVFhVkFL?=
 =?utf-8?B?Z0hyemU1SHl2SmI3Tk9Ub2R0VlVuMFkrUkZxZjZYOG5QY2VEWDU0Q0tGdzBG?=
 =?utf-8?B?Y1h4b1FjL20rczlIcVRNMVhQakI1cnJSOThqdDZSdEZLblFvRXp0cUxoMzl0?=
 =?utf-8?B?ejN2SElOcVRQaUsvUlBiV3R3SjdjU2l4UlpXQVZRclN3dFM0SjQzcGFTbVNG?=
 =?utf-8?B?ajlkU0F0MjY2OGk1bklGc1RTUHVsU3Rhd25VSGxCTW9RcEhyaXNjV2N5YWxy?=
 =?utf-8?Q?ht6Izfo854BJH6FeA3I78DZq7VEqqbYmdwT5M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(7416005)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ym1UVHpJb29mS2Z1ZjBTQ1IyK1ljV3RzcFJ2V3pxRkJyYXY3Ni9zMjUzVXFn?=
 =?utf-8?B?SDlvZXh4RDNkL2xGRjNGOFdFZGsyWlV5RzBwa0RWVXdHeC9kVGsySmxqclhF?=
 =?utf-8?B?MXovNll2bTZ1aTRISGJOcnZSa0RHM284cGZEbm9LWnhYdDhTYXI2SWZ4Yytr?=
 =?utf-8?B?Ly9PZ2l0d2l4SS92Q3pwTWdlanZLbkZxWTRGMy9jRnBNMlp6bVRWZXFJU0ZJ?=
 =?utf-8?B?b0VzV1VYZnRINjJkUlF2Z3kybHd3YW1WWHZJekpPczZkQkFXazhFOFl2RTJC?=
 =?utf-8?B?eTNiaFVob0p6aCttclJPMTlhcnZaa0QzTDVGMW9nRllsVkY5MDg0MGxNNVBB?=
 =?utf-8?B?QjlkZnBVbjk1ZE1ISzNnTFBSNFZiREtPM1dzeTJyVCsrTUlIMVRxTUREcXR4?=
 =?utf-8?B?alBYVzl5a2d5S2dIRU8vQ1gyQmNpbXA3Yk1wNkc5SXFRWVZxTlp6T3hMQnFR?=
 =?utf-8?B?Z3R6by9qejlWR1BLZk1OcS80Mkk2R2dxVXk5N0dXa3JKdGJaYUtVSkFVdkF6?=
 =?utf-8?B?dVhja0ZUM0dPRUFzZkJZU0xNVGswY3NEOStEVlhINlNCNzUvWTNyU1lwYmJI?=
 =?utf-8?B?RE9jRmdTK3RDQjJJV1hKYXFjc3RYOW0zblh4M3I3M053NkxmUkh3akxmczE0?=
 =?utf-8?B?VDQ1dEhwYXFjUXV6azB5a0tLRUpZZjFjK2NkVHJpaVl5blVETUlNd0tMdytv?=
 =?utf-8?B?ZUtUd1RITU9NRTVhUy9qNW1CczJnVkorbk9uZWVLWmRwa3lPRTcyK3Jsbloz?=
 =?utf-8?B?QVVnSFRiTTlhbWRZdW9TK2F4V3pWd05IdnFyc1h2aG9YQW5mazl2SHh3b0o5?=
 =?utf-8?B?NDhpeEUxaVJCS24yT0xDbGJLZUVtdkcyL21nNjh4ZGhtZ3BUdzAyMk4rblRU?=
 =?utf-8?B?c0hQWWt4ZHlXSHNwV3pTaVBhSzF1WTY3NCtWaTV5a1FyOWJSWW5BREtxRkZN?=
 =?utf-8?B?VWl4YkdxbkRiL3k0ajVybStyN2dtRytENmxhclNDT21qZkpwMjVWVFIvcDdl?=
 =?utf-8?B?WmhVbVFMU2dZWjEyZUNvQlljM0JaT1dVWkx6dHQ3YVVoNHE0clBPZkZUTTZB?=
 =?utf-8?B?L2ZEd3JaYUVNSFFuSWRlNjdKUFYzeGpBMVRabktrU1c2ajRZWjc5WHN2VTBn?=
 =?utf-8?B?YWZBZ1ZSRXlPZXBJOWIvYWk0azdMSkF0VXVQZHA2REw0RU12YU1Fb3d4RDBW?=
 =?utf-8?B?aUxjdmFMZWgyN0ExTUNlOE5BQTA1T0lDM3hqU2l5TnhaYjJFdHJWV3FpeFBq?=
 =?utf-8?B?bm1zWGt3UmNYcXR2Y0FKL3Z0WmpEeFlzWFNmU3BxemkxWEZGT1poZnc1Vno5?=
 =?utf-8?B?ek12ekRrdHBoaU5KSFBnSVVndThkS3BNT3k0Qzl1Mm1ZbG8rSHpRc3c3Tnp5?=
 =?utf-8?B?d09tZ3J1SEpsZVhmTmNvaDhVMHcvWTJPOTlzUVN5NUNKWDBCR0s0b0Ria0Fr?=
 =?utf-8?B?ZFZteEpXeE9XRENJNld4RHdGNVk4WDhlakh6ZkR1OTBRY2dSUHhJWS80M2Nv?=
 =?utf-8?B?QnhVNUppVU5iaTNCc2tqUEFMT1hMbnMyU2U1M3FWS0t5ZjZiL1BvWXRwRzJJ?=
 =?utf-8?B?U2NwYmhGMzhPOEdteWlLT0hkQlM1K2JHQzhKV3lsUmFjQm53MmVEM3ZQRWll?=
 =?utf-8?B?cDRGMHRBNjI3anVpNmpmVjBEdnFJNlFsMExBaVFGbHBlRlJtNmU4T29sY1NZ?=
 =?utf-8?B?anc4Ym9mSGJwSkhTcVZ6M1lSOERTOHhxQ1pxemhqcng3c014Y1A2dmlTckht?=
 =?utf-8?B?QWpaUms0OTVhZHpoM1FNWHk5cXEvUkNsOS9jbWxYMHd5ams4cG1kMmhaQkhh?=
 =?utf-8?B?TGZBYWpvVWZwRHFxMXlvUklyQndRZXlucjJLSWovTmRocTN1dE1zZ0FLVDNn?=
 =?utf-8?B?NWJXQ1QxNllmakFjRHlneU44Z3FaRy80Q2dndHFwOVZ1MHNncDhEME1tbFJ0?=
 =?utf-8?B?Q3drb3dlMFYxek03UURIZzhvNUlqUzYwUzE2dmN0eVZBaElUTEFHbXpWTllQ?=
 =?utf-8?B?emRuWm4rSzhLVWVCQ21SZ0JVWEFoTy8yNHozVEpKK3JDdm9TMFJCVzRjaklh?=
 =?utf-8?B?TWFna0xOSG9OSW1VaUpjNnNhK052K1Q4dDRGUlFBcFFNSWhxcXk4RGphS1Yr?=
 =?utf-8?Q?bE2S60L1C+C6EVAP2cFH6AKAt?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c110f105-a6a6-4c57-7a15-08dc612c40da
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2024 11:23:07.5602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVTPvUAv7z5W//B/POIUukvqXQ8kA4Mu49jY0N+r7YnvCEm3s3K9bF1u7Hd24k4iDdAX6BAf9B8FB/DQX5UJlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7588

ADIN1200/1300 support software control over LINK_ST pin polarity.
This is a fixed function output reflecting phy link-status that is not
otherwise controllable by software.

Add new property adi,link-st-polarity for specifying polarity as either
active-high (reset-default) or active-low.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/net/adi,adin.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/adi,adin.yaml b/Documentation/devicetree/bindings/net/adi,adin.yaml
index 929cf8c0b0fd..cf195e070b26 100644
--- a/Documentation/devicetree/bindings/net/adi,adin.yaml
+++ b/Documentation/devicetree/bindings/net/adi,adin.yaml
@@ -52,6 +52,15 @@ properties:
     description: Enable 25MHz reference clock output on CLK25_REF pin.
     type: boolean
 
+  adi,link-st-polarity:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      LINK_ST pin polarity.
+    enum:
+      - 0 # active high
+      - 1 # active low
+    default: 0
+
 unevaluatedProperties: false
 
 examples:

-- 
2.35.3


