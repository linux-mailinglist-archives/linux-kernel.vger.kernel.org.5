Return-Path: <linux-kernel+bounces-77851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07843860B01
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B56283AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816C012E73;
	Fri, 23 Feb 2024 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="cKL/i4NM"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2120.outbound.protection.outlook.com [40.107.20.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9724414;
	Fri, 23 Feb 2024 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708671246; cv=fail; b=eQ2cuUKAs8G95bDpmxDy5G3zUE0gliEV+zuvOe3FtjTkvK/9iQry5LWkfBPn+YCzwUTIz5kstre2ZGpgALg5d/4e+jGnCgVC8ngF3F7ych2x0ciDTUSIytDF2qrGt01GmyvAFMu8ooKpWGct2ma+uUhgslMi8k3FlIsOvQXbBKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708671246; c=relaxed/simple;
	bh=XmMDNgEy7CWmbk/VMc1x/4nZIJHGuLfqYXVWaa4MYtc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SctqFDtpQiyUuJtL8ofNsICOTiM6aPY3pEfniaowDKKe5R35Rjz7Kjoq3V7f1EMpo4Zxx9iuLcCSX2ucnYwd9NhSEc/vrvC+rBce2NBa9GoTDCU/kXbF9tf7QUqhSETIznU//uCPCM0MRXPpTAhA827Iig8Vw0PCQjtpKipwRYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=cKL/i4NM; arc=fail smtp.client-ip=40.107.20.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8qilju6Hl0nqKiv9rPAXQOzcETW3EwrEy8TWRdlp/PO4hyIWITczUR5JA9dLS0Rc+bak67h33GQbB9qOWFmf+Hb/WWXBzxWr2eOfQHNJQr0P2/dQI3t+bD6sUDdfAUX0hNT9fiaqgYGa4UxqmhBbz6xQXCJN2dWp0UJXyv8qWPCk2pEKZdWYaVZ/Vbncfr/yoWCcOGpu8L9b//Zj/r3YCpjpEfMtYlMWDJKUD9VrlQbM+pYOayn5AEYoyix9zOz1AgumOZkvmSrtbmBI2F/gjvAdoBj14PDSLukCIsrLb+V8BRz095IjLVe2FvaIvoclSSQeq6NfB+G1vnFPxPWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oc7WkGoYZTg9+JE9vKIbbAo6TeYg8FC5L4ZkdFLuDts=;
 b=IU790p0N/hkVe/U6qqwYT8D1u3ntuYXtLaX/BXd4C5DVBJRoWDESV9GlB0olF3ga8fdXf5G2vMpEg1qkwU39rpzXpYwPVggworMG7OdM6dtItRbbmcet5VqKOUEJX+5uIXBxYu9XUFSEyRlr0/mlnmbGtrAjrRyNPEuaJ8JJcZ7FjF9jS+UUS10930Y6XwxdealTNmkTlSMVGz3ITpkgfN4PyyKgPB0u729AH4gaRo608gTd9APb+FD2XcVajnWmd7Y2BAlEB1WCVYv00Q1OqVsAjTUWkCY92pTQbnUprpBEnBFRmUyrJIhp5smrEEh1hWo71aSIvUhBt/NWANGQgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oc7WkGoYZTg9+JE9vKIbbAo6TeYg8FC5L4ZkdFLuDts=;
 b=cKL/i4NMwo3kpNxnffo47qLSE80TfBRuLeG3hV2iWlt8z1/GHqxB+6ak6O5iKr0bed+zgn3XvqW7buraoFpBXJuljb+Mn3kZu4fysFhA0No91rDIp8/yb2CPgypb1MLFtKJKoPeXwvGGzrRWgjidPHMKAapkuY3OUAe6Qj6Ev40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AM7PR08MB5462.eurprd08.prod.outlook.com (2603:10a6:20b:10b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Fri, 23 Feb
 2024 06:54:02 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::e86a:6893:ac7:dad9]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::e86a:6893:ac7:dad9%5]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 06:54:02 +0000
Message-ID: <7ee26662-caab-462b-a5f1-3267e55a6313@wolfvision.net>
Date: Fri, 23 Feb 2024 07:53:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] media: dt-bindings: media: rockchip-cif: add port
 definitions
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: Mehdi Djait <mehdi.djait.k@gmail.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
 <20240220-v6-8-topic-rk3568-vicap-v1-2-2680a1fa640b@wolfvision.net>
 <20240223002834.GA3933946-robh@kernel.org>
From: Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <20240223002834.GA3933946-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::9) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AM7PR08MB5462:EE_
X-MS-Office365-Filtering-Correlation-Id: 61182336-a1f9-45aa-71e9-08dc343c37d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FZbaqp77ifYhpWmc85SmXUo7qKiqYnCztYmWokL8MaGk8O0x/opNLNgEF4zP2TyOE+dYvwZeYUCWkhJrmfCmiDvE0Z/DyyGoRca+76x9fl+qxrnV/GnHKRZ6YMppo4oZwMb2DQLrUHlg0mprmmzrHa6RPIieLQocmdEkrxjTak5bPhWMfbbMEi6RGQa+/EnMFGs05o5dntcKBoCGkhq+8DACAfdmn0EiIwbOm45tO0MzZo9KUVOUPt6EZYB6ubIVVfPDNSVZHpDRIbtm5FyiflZcYMbifWH5+iw7iQzgaHm4yVF54RqetBtMcGpQj4HLdD/nZ4pxjNysjWV+WspCglXbi76Rh/YHuNyW62hBnh+oCZvFrgUjaj+a5xOTup9gXebguq15CI5/NKACUz2+eQ6xXIA8kZ0eKDA/q3h3P4jK61vV+0MhO5R1FWZk2FKnmnZXvqsuvdEYHssM32JculwiNfkYWI8iHfF0FxuevoGRqR37771t4F0J8V0tD3TGt4gIbiBa/V2JOASS4qy0mX3dyfC1AJE18c0DVKTvjxk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWRMY0VGZmtDNytDbWJuM09xdXRYYUZKWG05N3NNSGRsaVBBTWhIMml5ejdF?=
 =?utf-8?B?WTVnWnZmRFNSTk9XV0VMeFZUNVFNclVBek9ZaEJFbU8zdGF5cEpNa29NdFpO?=
 =?utf-8?B?bmxPd3MzV29scWIwYlc0ZjhURURHNHdyWDhMZ3EzcDJTVG56VnJKUHJGaExn?=
 =?utf-8?B?L3BYOGxxbGo5NUFWbUIxcEtpL013QjEwZmQ4SVVXUEYraGEyaG5BZnBlY09Q?=
 =?utf-8?B?TFRRM3dPeHdmeHpwakRHZWlYdnJqaTZhNjNmNTVlQWFVa0krN2pUaHI5RXJS?=
 =?utf-8?B?REQ3ZFVqWjFaUTI4M0x6QTFtSTVadFFwbUhGNWhPUkRmaG1HZ21hbmRoYmxF?=
 =?utf-8?B?dU9SM3pYM2xXYUpMMGtJdmpyYlh0cmFXNzd2SytvK2hBVzFJK0QzSHpISWdM?=
 =?utf-8?B?aUNuOGVQZDh1VlpQblpwUVFTSEtOdElEUFlNNERyckhJLzZsTVZaK2VMTjVQ?=
 =?utf-8?B?S2I3ZndSb3hRRWNVNlNMREJiWURraGU2VDVJQ3dPQ3BVVmc3QUxJOVBDdEUr?=
 =?utf-8?B?SUFLQjJaRlBBeGl1QUFmMTkrZlZNQnlMT1FnaHNpY3NWSkZ6NCtYUDVyeDl0?=
 =?utf-8?B?bDZkZ1lGdjVyV2lnTWNnVEMyMlRVaTFVWjBaSnlrZEc1a0FYTjk1aEZHM1Nh?=
 =?utf-8?B?UEhLQ0JYSGVkcVJnWjBqb0NjamdERDhSeFdFMDVMY2ZVMmV2Vno1aVdLcnpU?=
 =?utf-8?B?aHVwZC8xcGQ2aUR1SFZNczNIQU13UzlBWUFNUHhOWk9jVEFOOHZQaUFSb2RS?=
 =?utf-8?B?WVdNaEtIOWVBYWVTb3FSOWk3Y3BDQmdRT3B0bUIxVHVtQ005RXJSWGVkRndP?=
 =?utf-8?B?SWM4TExacEJTMjFvMHZrUlJoV3BYYXdzR2xzRnBUMXBnVzM0ZENOZk5kSkZS?=
 =?utf-8?B?V1RNcHA2ZmpDUFhxc2hBZlBoYWxiT1p1S29iVUFsWHQwZkMvY2F2cklBREtj?=
 =?utf-8?B?Q204L2ZGOVlWc3dDN1JqNTlNZldyejJSOFl1Zk5aMFlRNDdYOHowNEZSekhF?=
 =?utf-8?B?NW9MZW5zTE84M2hscEJmZVhoWnp4aWhucS9mL0dSWE4vc0ZvaHRCYUhzVmJZ?=
 =?utf-8?B?OEs0bVNxekpMSTZFT0NUNk43OGU1aU9GNTRQdndzZXVQbm4xSWp5aXQ1Q05m?=
 =?utf-8?B?bFNISzIyMEs5ODZXL2NJS1Y1aDg0cW53QTdSUkd4aTVJSWRUT1BtMjdFTGVP?=
 =?utf-8?B?bWp6TVMyVlZCdkNKbkVQTmZDNXRkaFczQzg1L3hpZWl2a0p5N3U2d2k5d29N?=
 =?utf-8?B?aFhjcTFjVlVXU2dXSFV6MDQ5YnNxODRURHhJdTM2NEYzcWlKb2syQTBZajhR?=
 =?utf-8?B?M0lsdlB3UFpoZFprYWhUbHRYd3h1bVZsSW40UHZQUEkzUXlaUFZ3dktXMFJl?=
 =?utf-8?B?K0JVd1Nta3p2MmNPWEJOQTNYeEY5WGo0NTNHYjlXblFUa0RZd0dyNFRRdEJ5?=
 =?utf-8?B?cFFPRFlTdVYxcnh3eGJ6Ni9rZEhSR0tjckROcGJNdnNwU1h4UEJJbWV4Z3lL?=
 =?utf-8?B?MzJTcm5mcnJVTHZCVE1STXJqREx4Tkd6Q2djR3Z3MGswaWp3WEVDa1pJZTRz?=
 =?utf-8?B?MnFJeFU4Mml3eWxrV21CSFFIQ29HbDNHWGRYTWg2YXVTS2lMbTU2ZzNjYTNK?=
 =?utf-8?B?TU1rY3JFR1JmbDZuZWlRWi9UN0J4YmZpOWU3WWJmSHVDRjNEd0plUk5UYWdH?=
 =?utf-8?B?NklZRFlkUkdWdnROQ3Y2aWp0MUZQek1RMTFDb1VTTHFVRkQyaUpKSWJXQ1hS?=
 =?utf-8?B?V1daeW1JQUFiOFZWNTlLUWFpMmRCclRBSGZBL2RyaHVSRnRKQUZIN1JhV1BN?=
 =?utf-8?B?OFMzQ0ZTU0c4SlFYVENhNVJOdlBHZVN1cDMrS3VZcmpjVzI1b3B0RGJRcloy?=
 =?utf-8?B?Z3BNU1REaW41WjE4MFJieHN5M2VYMXZtZFNBNi8ybXdvQVozYUkrcmlXQlJD?=
 =?utf-8?B?OEhTcENvekI0ckx1RmNQUGR1a0VvVWF1MGFyMyswcUdqTUN6Mkd2cy9kdzAx?=
 =?utf-8?B?WXdGRXorUkpGVHUrdjZXOHoxbGRjUDF2OFVDSFVKaklERC9ZWHRXQmFSN2dj?=
 =?utf-8?B?Z2dYMkNSMkN1VUd4MkgvNTBJdnl3Z1FvdEdCb0h2YnltcnVyVzV6UzZKMDBh?=
 =?utf-8?B?QTIxK2lxUm1QdndaUGVFeDJ3UEVRMDFVY1pEVWdETUdwR1dmQWRaTXZSY3h0?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 61182336-a1f9-45aa-71e9-08dc343c37d2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 06:54:02.0136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0bqwZPscipJmu+UMjcPJap+LYwBU70l6/DkuWZhD1hfHkrHTqXmkYhUdT/xzRZe0tdw3nirfCsKA4CuZ/8BvGv5MZ3jvAFkH4dzF9P3A10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5462

Hi Rob,

On 2/23/24 01:28, Rob Herring wrote:
> On Tue, Feb 20, 2024 at 10:39:12AM +0100, Michael Riesch wrote:
>> The different variants of the Rockchip Camera Interface may feature
>> various ports. Add a new header file with port definitions to avoid
>> hardcoded constants in device tree sources.
> 
> We generally don't do defines for 'port' numbering. I don't see a reason 
> to start.

OK. I'll drop patches 2 and 8, then.

Best regards,
Michael

>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>> ---
>>  include/dt-bindings/media/rockchip-cif.h | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/include/dt-bindings/media/rockchip-cif.h b/include/dt-bindings/media/rockchip-cif.h
>> new file mode 100644
>> index 000000000000..37364ee1f7bc
>> --- /dev/null
>> +++ b/include/dt-bindings/media/rockchip-cif.h
>> @@ -0,0 +1,12 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>> +/*
>> + * Copyright (C) 2023 Michael Riesch <michael.riesch@wolfvision.net>
>> + */
>> +
>> +#ifndef __DT_BINDINGS_MEDIA_ROCKCHIP_CIF_H__
>> +#define __DT_BINDINGS_MEDIA_ROCKCHIP_CIF_H__
>> +
>> +#define MEDIA_ROCKCHIP_CIF_DVP		0
>> +#define MEDIA_ROCKCHIP_CIF_MIPI		1
>> +
>> +#endif /* __DT_BINDINGS_MEDIA_ROCKCHIP_CIF_H__ */
>>
>> -- 
>> 2.30.2
>>

