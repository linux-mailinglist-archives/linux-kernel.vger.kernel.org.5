Return-Path: <linux-kernel+bounces-152605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7B48AC117
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 21:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A301B1C208A3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5324444369;
	Sun, 21 Apr 2024 19:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b="Q/BIHHvE"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2107.outbound.protection.outlook.com [40.107.247.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E3644C64;
	Sun, 21 Apr 2024 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713728634; cv=fail; b=g1msSzfkce5x1MpPscXPa+42xGcL3BwWvXEXHmhYKgFs5V5aEmLooacUT2nfBHIIr0i+JTuyDbL5AlzY/5s/pY9jfW2x+mQZipOdCk6eVw1AGTQwgudwq2rb9vHgVUafV2rYRvFBeGHi9pjk25NzrMzFASxO7+X9vF3w7i8WlPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713728634; c=relaxed/simple;
	bh=UDuMk+oG1iuBsanR7vTYEVZSG266bXw1zA5PfhBCJLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KwaDYQncYlrSe1EnpO9vpWqY6/yofwjD1NjF9Z6nEJmEuw2sfotf6OXXz4EUydbLsxP1+ffIpB1SFqbjOlk57yyTNQwy6tt6TAdeiWe4uiQrGIBqVeBV90L5gJXlZ/dJ4RTXMu4gE2VRPDRnzhZ22TURstTVWb/pKQUY6Ldvae0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn; spf=pass smtp.mailfrom=supcom.tn; dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b=Q/BIHHvE; arc=fail smtp.client-ip=40.107.247.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=supcom.tn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8RxbnXBbMOj8EzdINKybkBTqfYRVJykR/8C3LeMR8PtpT2De50SB6+mOSwVv6KoFwdF8wr57Y1PB/s+jpu8OBK/RLhnmoQmjr3gWjXSGDZ5VdGY8sHmLUO8pD8dIoBNxuB6Ew3So3SP0iG0iXNqBiowOkVHYQ+OATrvOv9lqmr5L9yiSuQxviejXeW2tvD9D1D07yxwYNXL1MQvglEIlTwUVNrD40H1IoKRctVCi8O6u6IF4STyY0GpXRgRoF2CW9MZtu/gaj4NpGSFYIMqSFKTyQOUnMRWHpgO4gFkCWpuXpz9ovYm71mACLw9NAm9dHPmwcVvuWaruC+g4QvL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHwehcA0WdxquWWaVdxmSeiAKbtoTXa8t77pexQiqYk=;
 b=MiwCRGUtfyUe0blj5vUkOkJIQ/Eg7SrYLisZUJEIViKF5rw7bBuwWwvX70mFNWp7UFS40eADHi0ESw242fLu6cMSuVXzxBixO109v2KZN3+G/zcQUodFMGvm7Gh8sHC+IWM8Om5dqM9c+YYP7Ktaob2KpQxmsVwjOoS18Kwss+y25TqCbRQCvxTiGH3iGjrHRz9FZnKPS5MCFy2y8A9kY8C1I986KDPxzjQdEQ9fywL68u/LNRT2WavpDpLPwikZBnlVISiFqCs4j6YBK0PktVoghJi42wuPuozP/dPlUt351g3LbqjrSp08yzJiwSg+oc/GqwD/QJRwOmeiW5DvqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=supcom.tn; dmarc=pass action=none header.from=supcom.tn;
 dkim=pass header.d=supcom.tn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=supcom.onmicrosoft.com; s=selector2-supcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHwehcA0WdxquWWaVdxmSeiAKbtoTXa8t77pexQiqYk=;
 b=Q/BIHHvEnjdU0oh2ur9De2c5gK/xjTkoxX3WWGRNzU2nZp096QqKDfbIKSAgviZ3QVWDR5Vjx9HjIF5XiYnMuPm3HavnaQhXgwj83XnDTEHMTsd5NVzuVnIAPFT6k2/lJ43AwiL8sxSoE/u/IrzAZ9jhWMYN9s1OTaODZ5AJflM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=supcom.tn;
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com (2603:10a6:208:b::23)
 by PR3PR04MB7372.eurprd04.prod.outlook.com (2603:10a6:102:80::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sun, 21 Apr
 2024 19:43:43 +0000
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::eb9a:367f:6384:7d62]) by AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::eb9a:367f:6384:7d62%4]) with mapi id 15.20.7472.044; Sun, 21 Apr 2024
 19:43:43 +0000
From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D . Jones" <luke@ljones.dev>,
	Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Subject: [PATCH v3 1/1] platform/x86: asus-wmi: add support for vivobook fan profiles
Date: Sun, 21 Apr 2024 20:43:20 +0100
Message-ID: <20240421194320.48258-2-mohamed.ghanmi@supcom.tn>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421194320.48258-1-mohamed.ghanmi@supcom.tn>
References: <20240421194320.48258-1-mohamed.ghanmi@supcom.tn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0070.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::13) To AM0PR0402MB3905.eurprd04.prod.outlook.com
 (2603:10a6:208:b::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3905:EE_|PR3PR04MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 803a0102-819b-44e9-df3a-08dc623b59e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amRKaEIrZ0dpNDltUXF6WXlpQTkyamN2Z2xMd096cWJRYkZnMWZ6QTlKa1ZL?=
 =?utf-8?B?allJZjRvbEtnVWU2MDgxay9rUXVDNmt5aktyd3lwUDZleUhPRzJtQy9CS0U5?=
 =?utf-8?B?bWRxTzdKdVlSREYxV3dIWE1vbDNrODF3UnVwaDVkdmZNRHZ6REpDWURNSDU5?=
 =?utf-8?B?WWQwaWp1c0pYWDRob0dzWnM3VCs0Z2Nic25zQTYxUUk1UGM2TXpqaXFOWXlv?=
 =?utf-8?B?QW1DWmJZNXVqRm5CUFBzRWFINDU3VmxCNzB4SEE0bWhCYmpUWmViT1o5NnJU?=
 =?utf-8?B?TUJFZ095a2ZKOTlUOG02TFdnMWdPemVUbzNGNmNRVFN0UmlCZDFkYmFGc0tx?=
 =?utf-8?B?Qmh2bktpYmJ1RkkxeTN0TkEvWEF3ZEtFUmQ5eW1pVVQ4UDJoeXJqYnB4eG1s?=
 =?utf-8?B?UmIvUUMwVlJNTmQrSStOOWw1QXI3dEppY3BMLzdEanozUzdoQnNsVGpQZUlv?=
 =?utf-8?B?eGt4WXJYdkgySUhKSWoya1kwSExCU3E1QmVyNDlkWDIxdjlvdExhQytlbGow?=
 =?utf-8?B?a21tWnFYZ1pzaTBNUFpKdWJNMkR2QWhabGl5R0RnZ3ZnNzQrL0RmMElRTDVn?=
 =?utf-8?B?YlBzN0d1NnRDYlFwbVkrWU5FTk1McWE2MU13MU9NL0xHTFM5UDZiYXNKa0w2?=
 =?utf-8?B?Qlo1eGhZTXV4bTF2dTlCdzJPamRyMFcxbkZjRXQrT3JaQ29nZjVJWFlTb1Nk?=
 =?utf-8?B?ZE9rN1hsQUducG1CL0wwSmlHMlYzQmgxLzdwOE1ZNGFrbnBTdkgvYU5FV3VL?=
 =?utf-8?B?VW11K0M1V25Iem1BSXoxMDNZZ1IvNVVyRG5Ta1FHSGpjMFJWTXBGTjZFWnNU?=
 =?utf-8?B?WG5mcjJ1RXAwYTZLUzVYN3RyaXJEWFdFN1gwYklOK1lOcDJXTFdXNXZNanhs?=
 =?utf-8?B?QWFwQ21YU212eko0UURaQTNnQzFXN2c0TjRpUHFkQitGTnJZVUhrTlNiUW9u?=
 =?utf-8?B?azFXZjBwdnBzeFk1VFhlcVpxZlFaSUllZWlvOFBjYnAxUGVIOGtZL3pSQVE2?=
 =?utf-8?B?MFNwcVJTTTNZZW1lNTNLajZlaEJPOVZCL1pwWXQ3aitsNmVFNGU0SHp1S0dO?=
 =?utf-8?B?eDdTTHpLdy9BR0p6bUpYbjNLSHJ2Mlc5ZGozR3VkU0ozeHI3dExRRmpFSEEz?=
 =?utf-8?B?NnJtV1pNWVVvNWJxQlVoUlpWbTBOUHViNVNDQnpWb1ZXRWh2TVNTelE0UjlG?=
 =?utf-8?B?MjBDUm1IS3J6elpzQkN1WmsrOTNJT0RpZVZacXkrTmpOelUveWpQR0REOUpZ?=
 =?utf-8?B?WEhaUGcyWlJQeFhZcE5LOHdTaVZ1WXdBY3EzdzRhZXJBR1ZnelQ2ZlJkaXBr?=
 =?utf-8?B?b1gwZEhtRzdjNHhyQXdKc05LU3ZzWERCRmhlOVVCV3JjZ2xKK0tKcmFPSUhy?=
 =?utf-8?B?bk91RFpaQ0FzSC9jYzlFalArUnppNXBidlBrNjBWUVRFekZVZVYwNkNFdTk3?=
 =?utf-8?B?ck9Uc1dsQU1GVUlhRlliYjZNeDhvKy9sYzZ4TGtBTlhMdURxL3FNYWpLTGRa?=
 =?utf-8?B?RVVxM2JXL2ZZdXlsT3FoY2RxRXQrQUtOdFUrWGhncDZza05mSzFNbjNNaTNP?=
 =?utf-8?B?azhya1daZDVFWFdTdDQzVitwZ3NFdjA3MXNta0YrSWxxVXlsRGsxYTlWdTJB?=
 =?utf-8?B?aTdJQnk1RHNZRWNUY01pY3h3TnRFOVR1UGNyd1FHMUJ6Znc4bE5vSkNiK20v?=
 =?utf-8?B?NGcrd2x2a28yVFhqSmtITE1ZekVGeTNuc2NXT05VYUNoazlXSDV2TVZWeXVl?=
 =?utf-8?B?MWRUeFNNZmF1bllGZFdQNi9TMGRGM00zRjRrK1RwendzU3Y4cThnOHJYbXpm?=
 =?utf-8?B?THl0OEdadkJqVTlENVZ0dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3905.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(41320700004)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzUwcUpBbFN6TG9GaldrNFY4NzFOTHdMMUJnVGpybFpkTVNYRmdFcDNXeXFJ?=
 =?utf-8?B?NVlrQnF2N1RTd2QwL1dZRVdyWjRSMFBGSUQ4TmJJakl6Vkg0am0yMEdVTy9n?=
 =?utf-8?B?K3pGK2Rxb2o4MDJZcVF4azlhOUhJSmV6V1hIM0drTFVURHlQNHRhRE8wcGZX?=
 =?utf-8?B?ZXRsNlM1VmFOYzdFK1EwQ2lZMWg2bDV0N09aRU9kaXJpcE4yUjh2RUxqYnVS?=
 =?utf-8?B?Z2JpdDU1eDZXVi9HMENoS2Y2MW45Y3V4dFo0Rm02WG5adm1nZ3loVW14c2tt?=
 =?utf-8?B?WjNBTzlFNmJ4WnNtQ1lOUklMbWthUU9oS3g2c1NzdEp0ODArby9scmc3V0o3?=
 =?utf-8?B?b1dRWVBXNkJSR1NoSE84RlIvb2dDNXpnaHdydk9hYk0rZEdlbXpGNkhBU3U1?=
 =?utf-8?B?WjZ0THUvTDV6RjJhMzdQNGVsbTg0d1creC9OUUllN0c3aiswVWgvVjMxdWFj?=
 =?utf-8?B?TWZjc0s4cytDeE9VZW92OUlDVDMwbG9DUzY3aXBoZExKM1hGQ3lyUWkrQm9X?=
 =?utf-8?B?Uk9IUVE0M05telM2TjZzNWpOaCtjZ3llRnVUQUJkUTBaTXdzMEtZSE1icGUz?=
 =?utf-8?B?STlTRGtTSkZLajYzNXdvaW5CbUNGVXdqOFByNThsVGd1V1F1VmVaTnMyOUFt?=
 =?utf-8?B?YldkeUNsR3B1bUF4ZjE5ejRZN2xMMVZwdFBrR2NYczZJVWlGaXh3aG5jOGg5?=
 =?utf-8?B?QnFzY1RsMUhVR242Zmg5Ky9hRitUK25FdTZDdW1Oa2NHNFJYMzNoTy9uTkMz?=
 =?utf-8?B?NHlTUHZ3NEFNMFFGSnZSbm9OcTgxMzI5NFZEL3R2NmNpRE11ejM2UjFuTGN2?=
 =?utf-8?B?ZUxXaTBjL1BXZTV3cU5jeE4vSUVoRlE2cUh6UXFncnZOaDZsZkFjcXJoRk1M?=
 =?utf-8?B?RGIzWURFcERZSC92L2xIMEpXT3lObURkVisva2dhTFlGMlJFdURZMFowbXhL?=
 =?utf-8?B?aUZxY29DSUE4THNTTFd6WjNBcXNveXRiSHRrdkFpQkhxTnR2WVY0dWdSQ0hH?=
 =?utf-8?B?OE0wNDk1d2djdWF4Yk5KaUxRQzAxOWxha2E1Ry9uYzQyYUc5a211R3o2c2VR?=
 =?utf-8?B?ZjIwa1Q0SllGM0VjY1BrRmppWWJVL0NiMEJIZS94aGhrSVB3ZVlnSXAvS2lo?=
 =?utf-8?B?QndDNHdPVkpic3NDbWZzeCtYYlNiUnp5TlZYdWk4RHcvTGNxTlYvQU82Nmg5?=
 =?utf-8?B?R0wvd2NlNGhIS0FjWE1tZUkrckxadzVIVUJ1TmtGMnZDaWZId0ZwdjhyRkta?=
 =?utf-8?B?UnAxT0tSVjBRUjg5cTJJTVZoa29RTm1UcW1nU284aGNMV1lUVDBuZ0Vpa1Yx?=
 =?utf-8?B?bHlvOEpFaW50amJnSzZTRDE2bVNrYTgxWEFuVGpBSE5hZHJuR2hBRk1naE5U?=
 =?utf-8?B?SjBqdDFTV3BzakNKb1RsQkN3dzhrSy9vTEtPOXByQkVQYmlndjRadHNIeUhL?=
 =?utf-8?B?M1pGQkY3RitucjNET0V0TXZhbURYV2I1RXRwZHRlZ0tCSU9LOTdkY3E1Sk16?=
 =?utf-8?B?Rm0wWjEzRURJOVdCUDRBcXY1dU1xV0Q5VHU5TnpMWjhsTGVIQ2h6WVJFRmpZ?=
 =?utf-8?B?aCs5Q1Q3TEdPM1FYMGNwSmpZbjEySFdPS2NPWDYrc3RDRUlIQ0tNM09JR1pV?=
 =?utf-8?B?NnlJNGpBTmdRTVBHMEdoS0FMZFlJQ09SdW1nT2krU0JJLzl4YitGZXhQZXVQ?=
 =?utf-8?B?a2ZwNHFQQm5DVTdJODVZVy9OcFZwejVwanRhVjJiQUxOSmV5T3Y4QlJxVk4z?=
 =?utf-8?B?MnIyRlVOUStaTmgvNTJ4MmU0ZC82ZHc2RGpQRG9rQVd3TlVXcklEYk1YTlh4?=
 =?utf-8?B?Ky9pUlVsTkwzOGY0QjYvR2NkVVYzeDhHUE96bktyUTFEN3d3Z2RWNGwvNzVz?=
 =?utf-8?B?ZTE4blJ1UTFnWURWVWFrdmlKMlRyQ1hBQ3Y4ZzRYZHkxUGpWdlF2aW9hY2VH?=
 =?utf-8?B?U1d3YlJmbGE4NU1MWFpGV25VTlF5T0RqcnpZaTRNSmY3TEJva1FwQ1lIOXhN?=
 =?utf-8?B?eC9PNTNqWXBaVmVLV2h0MHNyVWFqN2NSNUYxOFZDQnNsUUFqdXFISjcybC9B?=
 =?utf-8?B?MCtqaUtjdGdTTlhxSFpyQmg5V2tVZWJBMXQrYURKZ0VDQ3dpQjNVa1Y2QWtp?=
 =?utf-8?B?NDU1RDZtSnhlcmFCNzNMWHdOYWdYdHhETlJ5d2I5VUtBMTZIY3pQRHdJSk5l?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: supcom.tn
X-MS-Exchange-CrossTenant-Network-Message-Id: 803a0102-819b-44e9-df3a-08dc623b59e4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3905.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2024 19:43:43.1438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8f85f528-6195-4e97-8e41-f5a9ad3bed4a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtH90vcBQx5UnFD2JgSGUtxL7U85xkGgLuC9xyLA0QXFxDHMzwu4PoSlJ9RMOuw71wMeTq347LJvC5sQFYroIL9CPp1GuOKUOoll/I2VTn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7372

Add support for vivobook fan profiles wmi call on the ASUS VIVOBOOK
to adjust power limits.

These fan profiles have a different device id than the ROG series
and different order. This reorders the existing modes and adds a new
full speed mode available on these laptops.

As part of keeping the patch clean the throttle_thermal_policy_available
boolean stored in the driver struct is removed and
throttle_thermal_policy_dev is used in place (as on init it is zeroed).

Signed-off-by: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Co-developed-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/asus-wmi.c            | 93 ++++++++++++----------
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 3c61d75a3..1f54596ca 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -97,6 +97,11 @@ module_param(fnlock_default, bool, 0444);
 #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST	1
 #define ASUS_THROTTLE_THERMAL_POLICY_SILENT	2
 
+#define ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO	0
+#define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO	1
+#define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO	2
+#define ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED		3
+
 #define USB_INTEL_XUSB2PR		0xD0
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
 
@@ -293,8 +298,8 @@ struct asus_wmi {
 	u32 kbd_rgb_dev;
 	bool kbd_rgb_state_available;
 
-	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
+	u32 throttle_thermal_policy_dev;
 
 	bool cpu_fan_curve_available;
 	bool gpu_fan_curve_available;
@@ -3152,7 +3157,7 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
 	int err, fan_idx;
 	u8 mode = 0;
 
-	if (asus->throttle_thermal_policy_available)
+	if (asus->throttle_thermal_policy_dev)
 		mode = asus->throttle_thermal_policy_mode;
 	/* DEVID_<C/G>PU_FAN_CURVE is switched for OVERBOOST vs SILENT */
 	if (mode == 2)
@@ -3359,7 +3364,7 @@ static ssize_t fan_curve_enable_store(struct device *dev,
 		 * For machines with throttle this is the only way to reset fans
 		 * to default mode of operation (does not erase curve data).
 		 */
-		if (asus->throttle_thermal_policy_available) {
+		if (asus->throttle_thermal_policy_dev) {
 			err = throttle_thermal_policy_write(asus);
 			if (err)
 				return err;
@@ -3576,8 +3581,8 @@ static const struct attribute_group asus_fan_curve_attr_group = {
 __ATTRIBUTE_GROUPS(asus_fan_curve_attr);
 
 /*
- * Must be initialised after throttle_thermal_policy_check_present() as
- * we check the status of throttle_thermal_policy_available during init.
+ * Must be initialised after throttle_thermal_policy_dev is set as
+ * we check the status of throttle_thermal_policy_dev during init.
  */
 static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
 {
@@ -3618,38 +3623,37 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
 }
 
 /* Throttle thermal policy ****************************************************/
-
-static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
+static u8 throttle_thermal_policy_max_mode(struct asus_wmi *asus)
 {
-	u32 result;
-	int err;
-
-	asus->throttle_thermal_policy_available = false;
-
-	err = asus_wmi_get_devstate(asus,
-				    ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
-				    &result);
-	if (err) {
-		if (err == -ENODEV)
-			return 0;
-		return err;
-	}
-
-	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
-		asus->throttle_thermal_policy_available = true;
-
-	return 0;
+	if (asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO)
+		return ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED;
+	else
+		return ASUS_THROTTLE_THERMAL_POLICY_SILENT;
 }
 
 static int throttle_thermal_policy_write(struct asus_wmi *asus)
 {
-	int err;
-	u8 value;
+	u8 value = asus->throttle_thermal_policy_mode;
 	u32 retval;
+	bool vivo;
+	int err;
 
-	value = asus->throttle_thermal_policy_mode;
+	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
+	if (vivo) {
+		switch (value) {
+		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
+			value = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
+			break;
+		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
+			value = ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
+			break;
+		case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
+			value = ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
+			break;
+		}
+	}
 
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
+	err = asus_wmi_set_devstate(asus->throttle_thermal_policy_dev,
 				    value, &retval);
 
 	sysfs_notify(&asus->platform_device->dev.kobj, NULL,
@@ -3679,7 +3683,7 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
 
 static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
 {
-	if (!asus->throttle_thermal_policy_available)
+	if (!asus->throttle_thermal_policy_dev)
 		return 0;
 
 	asus->throttle_thermal_policy_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
@@ -3689,9 +3693,10 @@ static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
 static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
 {
 	u8 new_mode = asus->throttle_thermal_policy_mode + 1;
+	u8 max_mode = throttle_thermal_policy_max_mode(asus);
 	int err;
 
-	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
+	if (new_mode > max_mode)
 		new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
 
 	asus->throttle_thermal_policy_mode = new_mode;
@@ -3722,6 +3727,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 				    const char *buf, size_t count)
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
+	u8 max_mode = throttle_thermal_policy_max_mode(asus);
 	u8 new_mode;
 	int result;
 	int err;
@@ -3730,7 +3736,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 	if (result < 0)
 		return result;
 
-	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
+	if (new_mode > max_mode)
 		return -EINVAL;
 
 	asus->throttle_thermal_policy_mode = new_mode;
@@ -3747,7 +3753,10 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 	return count;
 }
 
-// Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
+/*
+ * Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
+ * Throttle thermal policy vivobook : 0 - default, 1 - silent, 2 - overboost, 3 - fullspeed
+ */
 static DEVICE_ATTR_RW(throttle_thermal_policy);
 
 /* Platform profile ***********************************************************/
@@ -3813,7 +3822,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	 * Not an error if a component platform_profile relies on is unavailable
 	 * so early return, skipping the setup of platform_profile.
 	 */
-	if (!asus->throttle_thermal_policy_available)
+	if (!asus->throttle_thermal_policy_dev)
 		return 0;
 
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
@@ -4228,7 +4237,7 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 	if (code == NOTIFY_KBD_FBM || code == NOTIFY_KBD_TTP) {
 		if (asus->fan_boost_mode_available)
 			fan_boost_mode_switch_next(asus);
-		if (asus->throttle_thermal_policy_available)
+		if (asus->throttle_thermal_policy_dev)
 			throttle_thermal_policy_switch_next(asus);
 		return;
 
@@ -4436,7 +4445,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
-		ok = asus->throttle_thermal_policy_available;
+		ok = asus->throttle_thermal_policy_dev != 0;
 	else if (attr == &dev_attr_ppt_pl2_sppt.attr)
 		devid = ASUS_WMI_DEVID_PPT_PL2_SPPT;
 	else if (attr == &dev_attr_ppt_pl1_spl.attr)
@@ -4745,16 +4754,15 @@ static int asus_wmi_add(struct platform_device *pdev)
 	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE2))
 		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE2;
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY))
+		asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY;
+	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO))
+		asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
 
-	err = throttle_thermal_policy_check_present(asus);
-	if (err)
-		goto fail_throttle_thermal_policy;
-	else
-		throttle_thermal_policy_set_default(asus);
-
 	err = platform_profile_setup(asus);
 	if (err)
 		goto fail_platform_profile_setup;
@@ -4849,7 +4857,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_input:
 	asus_wmi_sysfs_exit(asus->platform_device);
 fail_sysfs:
-fail_throttle_thermal_policy:
 fail_custom_fan_curve:
 fail_platform_profile_setup:
 	if (asus->platform_profile_support)
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 3eb5cd677..982a63774 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -64,6 +64,7 @@
 #define ASUS_WMI_DEVID_SCREENPAD_LIGHT	0x00050032
 #define ASUS_WMI_DEVID_FAN_BOOST_MODE	0x00110018
 #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
+#define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO 0x00110019
 
 /* Misc */
 #define ASUS_WMI_DEVID_PANEL_OD		0x00050019
-- 
2.44.0


