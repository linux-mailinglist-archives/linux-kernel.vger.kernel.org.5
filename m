Return-Path: <linux-kernel+bounces-153035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB6C8AC825
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966BE284296
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB29612EB;
	Mon, 22 Apr 2024 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="MsC1n0qI"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2120.outbound.protection.outlook.com [40.107.105.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C654FA1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775995; cv=fail; b=KMlppsyZcRvwKpnLFS906r92vBEXgGB3fpHr/RkjHmP8NQL7uuALdKRK8Dgxyz8pplJZAKEVGACgeC5dEKVGYvVI4ack7+AV6XzgZpXdUmHvJzh024jSQFF6bMli4h3yRAqQBVCDZRnq+erjkoA8f2enFDKHH/aVmMrCGJWm56w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775995; c=relaxed/simple;
	bh=Jk4NZKBLvxD50U8letd3OgpUnVVDSlIMcf6mP4/nQO4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m0qZuUwolN1dVGOicrSeZhVj+fZMX8u6PZTIBCHGuGNQbx6XH1mehkcoqRYNR4fp0SqbqQPIiTMXKrwqr/jFQqOJeC/hwjf3DQM2+xgNNAxHufnEnp+B58/ONbikmCwut+elMkpXDoa/Rw4GYbWb6Ucka//8HltFQr9YDhof2qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=MsC1n0qI; arc=fail smtp.client-ip=40.107.105.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2BdukaNcamcAknlLwf7Pn3NfX72QvCk6Jhs0B/qpv5kkNsp1Objyoz3whiNWMkkXI2xDDWN+o5XEoTY3FiCz98YEd0Gg90ygMCShqCMf2vtwa4CgpqhuzJPhwoZau9d/ORb2p5FB8ElKORrrr1wGrNtjgY1dduO2uMIdK3sBxYjJF5J9APJbrqpeGzcsc8sZQtImiJidIMu4gDwQyWuYv73ZFuSI14abmr3L4F3LOcr50nl0bU8m34bguHoiuKn+14btHLuwqsv2lcVhLmxCwE8mP/j80ebzN00IPMWOBMMwCBqKRGbMQ+XatZtDe2nkbqBkx/SukdY3JLAidYaaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYsAJMq2ZVxEpdZzjNEuwDnsviCzheI/d8JGiPa0UYc=;
 b=L4haMmWRJ1DW443j3uCtSO17JO5YLQHdEooZLAuVsBpxtIGryeUTJhniDOqsWcckL7cICWl5g0snCv1OdQPLZlT4v6soH8Xn8nIQKY3KNsWorEyM03d2atuqasc56d23erhIukkwqxMGnwB37kWXPg9cggka/YzSGdkvQ+vqge2NtPrRDet0kKocc9ctvPup56gmd2sZULgZGB1obhBiQyNaCaUck09SO7eUtMW1hcUWeCXbP1cSwuUZQLxUg3cPJ/JfmxF9L0cvspGG2xDopqX6cITWk46RoBNwHC634yYhSII5bCpHsLuLBZSFrD44BFu9ErYJmUfu92b37HRPXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYsAJMq2ZVxEpdZzjNEuwDnsviCzheI/d8JGiPa0UYc=;
 b=MsC1n0qIzGuNrBuNsBgKSKVS3hz2blfIYDNH5wM5QbbsWKTySkPTnKLrkfTxgFREwG7KCS/PaiIpnfEBo1Mk96jrLjMyK+eF8il6s8qn7Lzq1kxtwXbY2Fv8rX+ilq/1wovD8K8IIngdW1G6ZrhjIAwjlvggaG/Gqjby3kjodqbq3mD8RJWy2LT7YUwau66CVo3tfUe0BT4oqFOC/sP3MgTUkVLICFvrm0di39ayI7ZWUPZH5qPreQg0AQmt4S3Yqq++LnSrbOzOqp9CsWBSF4u+oWsS419ShKHGFtL7/TG0r1ISijoG9rW77NEU3k3r/tWUQxmaL1P2k/iqxmXStA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by VI1PR04MB9908.eurprd04.prod.outlook.com (2603:10a6:800:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 08:53:08 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 08:53:07 +0000
Message-ID: <3d76df5e-7bdc-4318-8d2a-6d569cfc4752@theobroma-systems.com>
Date: Mon, 22 Apr 2024 10:53:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: fix comment for upper usb3 port
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20240418210332.2394871-1-heiko@sntech.de>
 <20240418210332.2394871-2-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240418210332.2394871-2-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0012.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::7)
 To DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|VI1PR04MB9908:EE_
X-MS-Office365-Filtering-Correlation-Id: ca848c55-f08d-496d-9d7e-08dc62a9a176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjBFeE4yZXgxdkJtM1hubHZNVm5FREJCQ2ZvelBtNTVFUVRybFNObFFtM09m?=
 =?utf-8?B?aE00d1RjanJEb2FMRHF6TzFrU0NRTDFFRVdpZElvaEE3Mll5QjQ3MWtMKzdX?=
 =?utf-8?B?Z0tLMVZhcFpqTXlvanF4VGR0MEc0eDBIaGZPbEtrYy9LV1dDQkhXeXFXc2hG?=
 =?utf-8?B?TlNJczdiY285dkpHMkdrZEN5clRlSy9Qdm9IdzdaclFkSEtWRHE4cUF2dEdG?=
 =?utf-8?B?Rk1CY01uZmdoMkJBalZJVCsyTFNLN1cwd3NqT3F3SGhhUVB6aUtRemFSVWRi?=
 =?utf-8?B?TDRhT0NscmxjZWZLSWZ2eGJseUF3azRBcEZhM3pyMlBRZWtWdi9KSWdLVmtF?=
 =?utf-8?B?LzdKSnJoYnE1Z0VtdGt2NjcwdWt0SGQ1NWowSGVFYzREUnlrMXluczZMQXN4?=
 =?utf-8?B?azkrSFQ3ajM0OFBKd1lHaVBnRTNKUDU2SnBFZVVmUG02cWZPMm5qTFJZZjQw?=
 =?utf-8?B?VDN6QUlLY3JvVXpjMVg5WSt2MGI1VVZCdTVjUlVqODd6b3pHNWNYci85NWVT?=
 =?utf-8?B?UHBqSUtCT0x3VjZyTDd6VDJkVk9XUHRTWmc2YkpqQzhYWjdja2tobWRPRmd1?=
 =?utf-8?B?UkJ4VHVVWElDMVdqWitNVHdQN292U3A5VktiR2h5akpGMUcxdUd5ZXVldzdo?=
 =?utf-8?B?ejVtanRIajdBd1IrT3pOZFZoamR3ZXVEM25QSjFab1R3SjdmUXhvKzlHdldV?=
 =?utf-8?B?TkVhVmhjUG44Tk05R2FuKzdsM3lseGRJTjgzRStHbW5idmZRR3ZGMFBXYXRr?=
 =?utf-8?B?MEFKcWpiV3ExcFNSR2ZZU1NQU2dUeXRIWjBjYlJaV3o5Q2cxZG9ZNVppNGNU?=
 =?utf-8?B?dDRiM3Qxc1lVZDBhQXhaVFJFVkZuWHhRMnRicnNLbDVDZ0tXU05GN09tSk1w?=
 =?utf-8?B?dmJ4UTNjdUpleUJia3FraWtqcnBwSWVacGFwbkhJdit6eG4xNnk0aUcvK01C?=
 =?utf-8?B?MGJHYjkrLzdYRlNpaUpPWWdFeE8yTlJOQTZsWHVIVys2YTJKYi9wcm44a3Vm?=
 =?utf-8?B?UVRkbWQ3ZFVrMHU3K3pYVk9QUlRTNll5L2xSOGt1N2Y4cHpFSjlJK0tFSzc5?=
 =?utf-8?B?SVhTNXpyMStQU1MyV0ZEQ3M1a3dEZUhOc0NOaFRhZ2tuenE1Ti8rdW9iUHg2?=
 =?utf-8?B?a0pVRytibDdHRzc3ZmpldENQVk5zZUVsVUREYUtFSTJjQjNmK0VXYzNSdWVK?=
 =?utf-8?B?NnFscnBQb0p6aTFaSzFYTXh5WlBKT3Z4SVlTYVJRZWxnTk5lZEViNlhPaDNN?=
 =?utf-8?B?UDZLa3E2NmFuZ2tBUzJ1a1hOVHgwampMa2UvTGZHUS9pd0k3RnBsNHVNbE9q?=
 =?utf-8?B?WnpwM015WkNuU1ZHSWlKVUpic2NtMDZ0eWJHUVpYS2QwZVFoa284MUY3cDFk?=
 =?utf-8?B?bWZqT3NSZHlSNDVVRG9NQ3pkWlBqbE0ybnFwdW5VYkU2MHVBdmJPT1RHMW54?=
 =?utf-8?B?NmRYWHBZVXZqa0VSa0NIRjMzZVBndFlJM2VBajU3aE5nVFBxcWd2SmUxbXdS?=
 =?utf-8?B?Q2w3Q1BnRHdyVDlIVFQvdEsraEhvOWZweXZRTHJML3Fod0JVeDlKOGhEQU9v?=
 =?utf-8?B?ZHpwcHRrSGVQdjh0V1hmbUNRTHBzajVxaVdqcmtPS2FIZDNTVTlLWThwQXll?=
 =?utf-8?B?RXRKakFFTkc1SUdaSE01dFA1d1lrVCtyNkVWVWh6Ykp1SC9vQnBCbzZUOE9M?=
 =?utf-8?B?eTFhaG1yY1c2NEZyQkkwRWlaY3JBVlM2dmpmTXNDbndjckVjMXFhYUJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4842.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGZsZzJpc1d2ZHl2b1BZQytuT1h0dk43V0c0OGJKVVErL1dhS1lUdXl3M0JM?=
 =?utf-8?B?amRPK2YxT3VRNWVVK3o3enhyM3gvUkdCQ2pCUjBUWlpZTVR4Wlh1L0FOSWhY?=
 =?utf-8?B?SnpqUmZ6OGY0VVppa205bURBQnlpZWdmalBJL3JRN1dhekNTdmF2NXVjRzIx?=
 =?utf-8?B?ZVc2ajRZRE16V1ZMbFpFaUQvZTBZL3R0UHdhVmUxZC82VmNQaUhKdDQySEpu?=
 =?utf-8?B?cDBGRjRHbGhqcWoveksvSElZU1lZckNWZWVSSWRRaFlXYlBpT1AvNzlKMjJr?=
 =?utf-8?B?cHdQWlNxZm5OQUUrYi9sWFhxb2dVNnFtRWhxeEJteS8wQ3BCNHoycVJ6TGVv?=
 =?utf-8?B?eXJ0RjR1VnJKUFc4Y3BSN1JPZGRGbS9XbHlQd0ZwVU05eGVaSldRSzZaVDFm?=
 =?utf-8?B?K29KOTZoMkVhOTM5VzdCa2pWeUlra2dBc3cxSEFLZzZrQkdRM2VnMURzWTho?=
 =?utf-8?B?bHR6ajRsOXVBamsyejRhN2NxVVNmYTJsNUpPa25jcGlyR1ZVemxyYVFEdlY5?=
 =?utf-8?B?V2pMaGRiZTFRbVovbTVlbkx5U1E4S3prTUwrdis0MDYwNW9adGdnZGdMQ2FG?=
 =?utf-8?B?WHk5N1FnQkxkZytpSElDNG9ValN0QmFuek51ZWsxM20wcFhCcnFONTJqZmF3?=
 =?utf-8?B?WDd6ZVRqcTM3YjZEcEx3ayswQTBScFY4eitkd25oLzBydHpXTHVTSFBzSDRs?=
 =?utf-8?B?NUREZW1JTVNoRUt3WExTaGcrMUFYR2o4UFFhekl3Wkh0MXNqblg5V04xSm9o?=
 =?utf-8?B?UG1GbXYxUGhPRnN0amxHeW9meHdmUzMwVTFHWGxIWEZKdzZzUGNrUmsvelRu?=
 =?utf-8?B?YVlWK0V3Mm92dUpjakF2a2lqZ0x0MHliV3FJOTl6TDhETmw3SDkxbEt1d0g1?=
 =?utf-8?B?RThTMWZYQ1I5S1lqT2Zub3g1ZGt4b0pqMzRqUWc1d3R2dkFPS25uNXEzOVFX?=
 =?utf-8?B?QWFkZXlENVNMcWRwLytIbThxbkc4MndUYTE4bElId1A4VVI4UG1HeGtDYzNr?=
 =?utf-8?B?YmhzWlhIejdDeWl2b1pLdnRWdXdTRmlKQk40dUxoT1AzNTRpYzVCNVdnZ05H?=
 =?utf-8?B?QXBMaHVvQlRzbldnMGVidFBmR0NJajUzakhPK1lFNWMzQ3RId3NZcG9qK3g5?=
 =?utf-8?B?UERuQ2tjL1BkMUFIRmUybkxZYWc4amFCbUJiNG1BTWFnaFVnNTNlcXdMOTJE?=
 =?utf-8?B?b0dQNDRuTUpER0JJVEQwNFVEd2loV3lQdjlTbWZPNjIrRGpTYTRZdU9FUnFw?=
 =?utf-8?B?NlQ0MzlBQzMzQXo2bFdZTzFnUHlvRlpKWXdVaXAxdTg2YmQ4SjNxaEhFbUxu?=
 =?utf-8?B?MzJEZTM3R0Q2SStvY0NSdkRiZWtQaFdVNW5RRUZvUm5oeHFhOXlyRmlYaW03?=
 =?utf-8?B?UU9wS3dmUjk2bFNDYllsNGpZZ1BZdHpHbndCSVFUUmloUVVkcDlUcGNTL1BK?=
 =?utf-8?B?VVhYdjBqbHFmbEgyUmt0VThWRzczU1lubE1acERkZWsyTk91RWlMNTVkSGVr?=
 =?utf-8?B?UjU1clVkUTFWSEtOeDJvVEtwdTNOVlpjOTk4ME5jL0JleVprZFBmVWM2eTJ5?=
 =?utf-8?B?am1rNW5zNTlURkJIT3pEQkU2Z2ZHN2NqNzErUE5DKzAvYXI0STllQ0syUU5h?=
 =?utf-8?B?bmQxMUswWlBlQlNIQlBzcVF3NmlQcGVTVzB1WU5rakFVdUREUmcreEtYaTJH?=
 =?utf-8?B?MVpNa3E2anAxQytRUUJHeTlVNlhaN2MwRXFDbDlzQURqRm1ReUdtVWx5KzdR?=
 =?utf-8?B?MEhRZ2FVdXVQU3A1dnRrQ0dkMmNoWE5JV3F5cGhYZUNtTy9Ob25wN2ZkR3ZT?=
 =?utf-8?B?RmFVZ3N6VVlPOWRSSEdqZlJvcHE3K3dZV0UzUUpyL2ZkNTU4TFNXdzhkM29H?=
 =?utf-8?B?dHE3NG1melAwbGF1QldjV01hbjZIMElHQTBjMDBqUnRvLzFTb0hLUlpJa0tI?=
 =?utf-8?B?U0gvdjhObG55WTh1akZOOVkybWE4YWdxeHdDV2owRy9PRTZGdnRhb0NHWnVl?=
 =?utf-8?B?Qi9lYWo5dG1wUHRUaEttM3VsUWc1MktJR1FmblBqWFgwcCs4bkZxZjl4ekRP?=
 =?utf-8?B?ZU5uRU8vQldNb3dJV0pybk9iWnd4REU1WUlKZW5WWC9Ub3ZDUDV4T2ZkT3Z5?=
 =?utf-8?B?K0RYWFQweEJYNXNTK2FIcXN3K1orODU2Y2h3c2VKTE1Jd2xXOEVKWmRpNEZT?=
 =?utf-8?Q?h1s/P1AVViRyEsubvOiqqUg=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca848c55-f08d-496d-9d7e-08dc62a9a176
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 08:53:07.9147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dG9RuCqXd3Mm2tYuJm2dWQhjBeGQtyTYK5YOn/K5u8hKAzJvvQzMm/LhLH4vZPtylmSZLbwiSRC2VuF/oKaxFJt9IqHl7jFfgHt3U0WTVgoT5PxOIy12Y2UV0cOamkNF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9908

Hi Heiko,

On 4/18/24 23:03, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The comment for the host2_xhci points to the wrong port on the board.
> The upper usb3 port is the correct one, so fix the comment to prevent
> confusion.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>   arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
> index d672198c6b64..214f8258af68 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
> @@ -260,7 +260,7 @@ &usb_host1_ohci {
>   	status = "okay";
>   };
>   
> -/* host2 on Q7_USB_P2, lower usb3 port */
> +/* host2 on Q7_USB_P2, upper usb3 port */

Missing the same update to the comments above &usb_host0_ohci and 
&usb_host0_ehci.

Cheers,
Quentin

