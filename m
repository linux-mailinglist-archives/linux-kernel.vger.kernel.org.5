Return-Path: <linux-kernel+bounces-158563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8148B2215
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D811C220E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B73149C42;
	Thu, 25 Apr 2024 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="GG3ZTidn"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479B7139D16;
	Thu, 25 Apr 2024 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049894; cv=fail; b=Ap7kHmcOrGr5AV4m40ijU8mnkbQDxkeGHrwKkh7nms/ow/V38SSsqWjEfJO08MmvNwVA6qTepsMmOaf/22+ldmgPP4mE4XuZERluXbH6ehKNBwbuhCblI55qK5yRGBp41ML6IwU69d+uV1aoucHxERsie++s90G49n50eGAnras=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049894; c=relaxed/simple;
	bh=QVoxtHiUA5gYa4CZXrjTZxwzKYcwfRs7Z+iKhXaZgSo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ePV7keYh49Yd8/WpttXg7Eg2Nlulz9VTwOJRfG6rL1SVKrvmM3CuHnKVi76yyAaAYPpqq0a72VPxJt8AuYUZF+bn2r4bbQly0BQmWT9Zoe8lzGat2Ajjgj0BwmJBVWbNwUc0LP4qbowD6k7E1QRs6v7SrpHN26mdyMJZgVCO0pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=GG3ZTidn; arc=fail smtp.client-ip=40.107.15.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOadS3Y8WcSb+53aMVRZyVXmFLjJUeZk83uoAzLHEkqnr+cBo7FCFOh+ru38fGTTwp7zjk/oaA8az33bxxzADcXcdniHOBol+P7N08PiaXs3WtCmjYmfJkeNkJeMeHzuZfczBJa1VSmRlMqVL4pAO+j+DCjDa67aZHRf5RctG9igmI6zrVJrPACQo+2Vngxq9OSUFc+nAKO2vD13XVOhjRIm/ZmBpMMVYYgkyCwKkIuZlEpM636ipPbydCjTKahXKhfiVPa0m14pft8veHZN45fENzXXmopjx8OhwsKl25CqskJRXIBo8WZ4Tn/iF0g6JCKs8HU5WJNUyzM38P469g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58yIuDDKdVi6LT+eQHvpUveYo608RWjfBpDUuSWql0c=;
 b=TG4uGcj3HYo+JdjFhDN8qx+rxAmKXcbcAnxD2scYf/gzViYIjNg2YXTlEfqj2Jnu72hc9K0Mk3YBin3qeviB2cIkbspeDCmV5Foaftg2sJfVlcKKsQ2+p67B8GC2iivHqIdLmNDl3ALI8fzipAJNJR2fF+DiUgh970ZfZpExHX115vneR8AKf0xjvyPj6DOoLm9EyKMPo3PlZxukojxQnoXoyrVWI3RobgXpm2VEiFGfPvRfawjiC8wtrJpZaVnctMfNH/uzzPjFJXpwceXAh/aXt02UACTGZwVa6FLAAoNGhuu8+xmEeirIY7votpSqt32wYkYgSC2xdH2QMxX8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58yIuDDKdVi6LT+eQHvpUveYo608RWjfBpDUuSWql0c=;
 b=GG3ZTidnimciaZ5EZnPvdHbCObjk8Kb7Qq+UPef6V5mTfVRrBNWTvaCI+KjeUyA9AdDj/QNogPcpPrB3m0d9FVUrdp7CAwBj7Dbda2OQfMODRchj7creBiURn1cScU7A1lzjRIUeDlFo/tXrJdJkCY5gZ38b0+boydOzpl/GJVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com (2603:10a6:10:488::13)
 by AS8PR02MB7334.eurprd02.prod.outlook.com (2603:10a6:20b:3ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 12:58:08 +0000
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::b406:31bd:907c:e817]) by DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::b406:31bd:907c:e817%3]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 12:58:08 +0000
Message-ID: <4ddfdeba-cc85-47af-9762-b30143c4e606@axis.com>
Date: Thu, 25 Apr 2024 14:57:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: bcm54811: add support for BroadR-Reach mode
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: bcm-kernel-feedback-list@broadcom.com, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240416123811.1880177-1-kamilh@axis.com>
 <3aaf1b82-247e-447d-a39c-c209105c2d7c@lunn.ch>
 <1b985a54-8c47-4f62-8971-e2a4d7976c03@broadcom.com>
Content-Language: en-US
From: =?UTF-8?Q?Kamil_Hor=C3=A1k=2C_2N?= <kamilh@axis.com>
In-Reply-To: <1b985a54-8c47-4f62-8971-e2a4d7976c03@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0132.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::16) To DB5PR02MB10093.eurprd02.prod.outlook.com
 (2603:10a6:10:488::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR02MB10093:EE_|AS8PR02MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: 5deda3b0-e421-45d7-06a1-08dc65275ac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXI4MzNiNjVyNkZBOTdGQzdXckpPbG5YL0ZEcHpYOEk2TTdseXhqVEh2V0Np?=
 =?utf-8?B?WFVrQlpIVURGSjg0MVk5ME1tZEliWXVicHBQQmRwMTdwTGpJT1VMTE1yYXcr?=
 =?utf-8?B?dnRYalJrSEZVV0VrMTJRTTgzQW1KeWgyNTI2aE1RYlVYQnpRQi92U0laeDZl?=
 =?utf-8?B?SDZwOTBUMVZsVlFPK2prWFh4SWFpcVlEK0d3V3BxbS80dE9NbS84eDg0Vmgv?=
 =?utf-8?B?RGlhTlRrVlIrVDdXOWMyRURYZ2h2TUtubDZqazFRM1lOa0lKeEFCOW51ZXdk?=
 =?utf-8?B?OTdBSkxUOFVZMzloUDQyS3M1VE85VlFiaTVCcWVhNllPUjBZa0ZhL2hzWTVH?=
 =?utf-8?B?YlBYdlZremdPd3YrRG5JVXIxa0dzTzR3QmQxMkJLQlZGeWVVUXAxZ3A3Z0lw?=
 =?utf-8?B?eHBPSjhieTdrYnNkVjV6Y1JuSFAvWUhsUFJ3MDVSVUdNYVl6bFZSMFZ0dW5z?=
 =?utf-8?B?SVRzUlhNam5oZTE1dUFOSDllVHZBeCt5VmRScFBLemcwSG5NTk9qbktqSG9I?=
 =?utf-8?B?RjlxcDE5NlgvcDFVdmw3WHdBeEZBR1FRSDZ6VGpSVkIyQ1BPM0dDSXV2UWhU?=
 =?utf-8?B?aFVuRE5GNnQxZXU3K01iQVp4TzJCK2hzUkFBNUtkRVdDb3M2elZ3dXFJSkNu?=
 =?utf-8?B?UzBHWTJ2M29hWUc1Yk4vQWp5dnhXWk44ZUR3M3dqRSs0dVorR1ZySG1OT1JY?=
 =?utf-8?B?ZUVFbTlRTEthVWRidkdCRkVyaXZtcVgwUExOZWtYSWtUS2xzcjJyYWx3WFh6?=
 =?utf-8?B?MU9VS0dwNy9yUy9RYlJDdldacHltMjYwSUdDRlZsTDNPUVUyd1FENTR0dWNW?=
 =?utf-8?B?ZUx3dWEwME03aVdBZ1FUNFBML2JsOVAyVU4ySkZMS2Qrd3d4a1lkdHRIQmgx?=
 =?utf-8?B?RmZxRjFkRGtUSUVibmpRN05jVSs5UEJJSld4NnJMWTRFK0lHUHFKMC9Ia2JY?=
 =?utf-8?B?UnNzOGRZcHZzKytKNVJzSVkrOEYxSzZ0UXU3a25acDBpZi9kNVI1a21QQ3I3?=
 =?utf-8?B?bkZWR3Erd0E4YVNBZEoxSTNZNVViZUEvZmZKSzZOcDdQUC95N0xZa3ZSbm9j?=
 =?utf-8?B?ME1Xd0d4Q0JCYWhjclZzVFh1ZlRiQmxNT0xTQjUwc2x5VTVjR0Ewd2ZRYWdW?=
 =?utf-8?B?UHVXMCtYOWtQcitST3ozMjBySm9kSWQzamc1TTU4dW8xY2hxenhXU0UvSFNo?=
 =?utf-8?B?Y3VxRDUzcE5JYVhLZGNPTWpZWVRvZUFKOUVlZ2JhZEQrR2V0bEhENDk4ZHhx?=
 =?utf-8?B?bG9sd2krRE5YdVBMRkcxMU1UNlh1blBnblllSExDaGQ4VlBtMms1dGY1T3hp?=
 =?utf-8?B?SGV1ejJzUnRBNFN4OXhyTE9mQk9kSEl1UXh0WTl4ei93TVlVK0FaMnpXNWEr?=
 =?utf-8?B?alV2L3IvNC9vK2ZzVFpLWE5XVS9MM1ZTLzV1TWwwMDczWE02c1o0cVNRUGJF?=
 =?utf-8?B?ZXdVdmpRTXlUZUY1VTBIVzF3UjRFWVRNU0lzNXZLWWU5Rk5hVHA0K1RZNzFN?=
 =?utf-8?B?WnZzZzQyaXdkcm5CWDhQUW5IeklSNW9sL3NGMktsVjNIZklTRGhwL2hNT2p3?=
 =?utf-8?B?SEZZaXRqRTNMRHJCWWVUd3NZeW41Y1FjVmRNZU5pUGdwaS9wTk1FMDVnd2Y2?=
 =?utf-8?B?VTVmTWQyYlF3Ui9yajlVaExiNURuUU0vYzJ6Y0RQa3c4TityVEp3enIxSnda?=
 =?utf-8?B?UmFuaGltSmhLTlF6RmxaaE1mVk9sWWQ4VkRETEJqVGRJcURGVVJHZ3RRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10093.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEl3M1dXd1RNZVRNMDkzNjhmZjA2UDdzR2hxejlONWVqTkZLdE0vL01PSkh2?=
 =?utf-8?B?a1BpaWJrMUNEdWtNN09sbDRJWUNuRFIrYm5yTEpBRHRIWVo0bmZiSDdTK01U?=
 =?utf-8?B?eDZ4YTBuWElEbVI3UVU5YU04ZjN3ZDl1RkZKVEhFdzdmT2xXR29lZFpMSktT?=
 =?utf-8?B?eDg4clZuc3p6Y0d6RGplRXRGMnBjdjFweUNBOG9jcGJWbWtnYUQ5TFMxM0RO?=
 =?utf-8?B?VjFYK05hR1NQM2EvdkFHVzNyaDRDQTJHYkJYR1lWaVlPTUlWT0ZSeXVTWWlO?=
 =?utf-8?B?Zi9LQlJvNS8xS1gzUGJNa3dENWVCRlNBazZkbUN0elJNZzdoeE9VKy9vT2Mr?=
 =?utf-8?B?M0ptSW1GcUdEenpHZ1JHYTU4Tk1Ed1NubkZlYVBEZWduMHhlQTFTWmRtVktF?=
 =?utf-8?B?UUt6RVNoVGlmK3gyVXVyTzdOVjRtRDlzWFVuNFpNU212U2hBcktzWk0yMmo4?=
 =?utf-8?B?TEx2aXZ4ZzEwemF3akxudFlVZnU5RDFURk9KcFMrM2QweUJTZHYwMURZQWNx?=
 =?utf-8?B?K2pCVi9YMVZUUTNCelYxWER3cXZheWZjTTJIU2tIdHNGdUptbW9XbjNKWVFL?=
 =?utf-8?B?SzVnMXVXY1EybGZmY2docWFOMXdyaFZiSXRYcFM5d0tLVzRsS0lySmptR2cw?=
 =?utf-8?B?ZXYyQkNDcjZwbzRDSXlzM0Z0L3NkQUpoK1U4VE9VQi9rTWlxdFFBQ1FtY05X?=
 =?utf-8?B?SUtCRGdEcU9rSmlxVHl0MkluQjY3ZUpMdlRFUUIwM09PRmwvYnkyL1U5aTVm?=
 =?utf-8?B?ZEhlcVFGU1M5Z2l0NjNjUHFtREYzZ1lEZUF0eDlUNGxnNWtkbnRFS3JZVWVJ?=
 =?utf-8?B?MDB1MUdxdzlTb2xSRVhqaU1HWkFyemtkSVZuNmFFOUZ1UmpNNjd5citjTlJH?=
 =?utf-8?B?STE0Y2VaUk9RemIxWHVISzhoSjRnV0ZMdWswUWxGVFF6M3ZyejQyaWtFNU9l?=
 =?utf-8?B?blpUSytYYnQ5U2RCVkRTYlp0K1FvUEZ2K3NicjhMcnA4RmZyV0daalJlSzJi?=
 =?utf-8?B?L0J0d0JVRlhhSXlzWmdSaXA2VitjVCtHK1JNNWxialZyRGxwYURHRlg4S0Vw?=
 =?utf-8?B?U1NoM2R2clp0dkV2ZlFPUzlzYWFSOGlzM2FsbmMzd0RZNHpLRXZsYkpIdmtD?=
 =?utf-8?B?MnRPN0lRZzlQcFIzRk9HcnVWcThqMWZhTkNsYVBTUkwwVXVKQ2doL0ovUzBB?=
 =?utf-8?B?QVEvTWs3bVBXeXcreWsrWHAwQllwMFdkR09qMzhseWIxSUhUNis3cWxTUzc4?=
 =?utf-8?B?SjZ5Z1pHdkx3T0g5VGVubkdnMnk5eCtTK1VXN1BsaWFnUmoreWFaWDk3cDJu?=
 =?utf-8?B?WXZheGRjMURxSVBJa3NoeVp5ZnNqUTFzR3ZaOS9YOEQ2NmRXRFh2THpzR3Rr?=
 =?utf-8?B?Yi9JK1Z4eG1JSGhxSHZjb05PcVIzMjdYN0FGSlYvNVpNdlVZWDZ2Nm4za3pn?=
 =?utf-8?B?U09ub25EMzQvanRpWEJNWFZtNTNCYTFSWVVDSEZaOWRXaVhiSTR6Q3BLRkhy?=
 =?utf-8?B?VmZXVFRoZEMyQ2ZMTEVPQmxxbE9sYThWb1pTZlQxZldpbmdEb2RRRlZlYVlw?=
 =?utf-8?B?d2t0aUF4T2FBb0F3TkQ4MU1Ka1JCZEJqcXRxaWN6RkxsZDd0MGphUXM4dHNs?=
 =?utf-8?B?Qk1DZWlJS09Ccm1zTzZsanhyUGQzV0xHL2VFaEVmQlRTQ0ZpV3ZncTZyVFlI?=
 =?utf-8?B?TVRxenZ4SG9JdExoemd5WXBCa3lUTU5WaGVualdFdmdWYXA1NXEvOVdCbDBr?=
 =?utf-8?B?TFpMSHQrS0phRHZlU3JISXkzbWRVVHRuUlRocDR2S0dJdkh3WW9pbzhISW9r?=
 =?utf-8?B?UDJNa1JqQTFNRmp2U05FN0RiV3UvNmxudVJoYnpzd2xFZjN2czMzNDBNNUU5?=
 =?utf-8?B?UmlNUElTMEpGTVNqUUtqV2puVFZYYUhaS0FTQVZTc2tlamdrQ0JtR1A2N292?=
 =?utf-8?B?RkpWcWxpVW5yeG1Vb2dlREhXVHFnWEs3bjZ4czBpeTJ1QWtPeHk2UzVGNzAv?=
 =?utf-8?B?azlxZzBCU1VoVHE1OEQyUk5DeVluRFBHU3RtUHJNTklPOHl4bFU0Mlh3VEtO?=
 =?utf-8?B?bEIwVCtkdVByTjRtM0czSStOSFpiUVE3YTlCb2NzMm1NVXNzWWNWSEdvL1VJ?=
 =?utf-8?Q?sstFch3nwTPE2gvqtztsdGl7n?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5deda3b0-e421-45d7-06a1-08dc65275ac1
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10093.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 12:58:08.1989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Twn8SBcORZI/P6FQfQWOXc0YaW9dMcNsAr1ALpbjLCxlzPMBMv+jPWTQ9tVaB8ZV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7334


On 4/17/24 01:46, Florian Fainelli wrote:
> On 4/16/24 07:10, Andrew Lunn wrote:
>>> @@ -258,6 +257,9 @@ static const struct phy_setting settings[] = {
>>>       PHY_SETTING(    100, HALF,    100baseT_Half        ),
>>>       PHY_SETTING(    100, HALF,    100baseFX_Half        ),
>>>       PHY_SETTING(    100, FULL,    100baseFX_Full        ),
>>> +    PHY_SETTING(    100, FULL,    4BR100            ),
>>> +    PHY_SETTING(    100, FULL,    2BR100            ),
>>> +    PHY_SETTING(    100, FULL,    1BR100            ),
>>
>> Please could you explain the name convention. IEEE puts the speed
>> first, then some letters to indicate the media type, and then a number
>> for the number of pairs. Why is this not followed here? 100BaseBR4?
>> 100BaseBR2? 100BaseBR1? Are these names part of the BroadR-Reach
>> standard?
>
> The datasheet refers to those mode as 1BR-100 so it seems to make 
> sense to define them the same way here.
>
>>
>> Also, is there any compatibility? Are 100BaseT1 and 1BR100 compatible?
>
> As far as I could glean, they are supposed to be:
>
> https://www.electronicdesign.com/markets/automotive/article/21806576/whats-the-difference-between-broadr-reach-and-100base-t1 
>
>
> Given that part, it makes me wonder if it would not be less confusing 
> to map the existing T1 link modes onto what the BCM54811 PHY supports, 
> Kamil, what do you think?
1BR100 is really same as 100BASE-T1, in fact, the Broadcom's 
BroadR-Reach 1BR100 became 100BASE-T1 standard (IEEE 802.3bw). However, 
there is also 1BR10 to be implemented, which is neither 10BASE-T1S nor 
10BASE-T1L.
Thus, there would be 100BASE-T1 and the remaining BRR modes (1BR10, 
2BR10, 2BR100, 4BR100), let alone the fact that it is questionable 
whether anyone would need the modes with more than one wire pair.
So yes, for 100 MBit alone sure it would be better to make it 100BASE-T1 
and it should be interoperable with another device using same link mode 
on non-Broadcom PHY.
Note that the BRR modes are always full duplex

Shall we change the 1BR100 to 100BASE-T1 and leave the rest?

Option 1: 1BR10, 2BR10, 1BR100, 2BR100, 4BR100 (= leave as-is)

Option 2: 100BaseT1_Full, 1BR10, 2BR10, 2BR100, 4BR100

Option 3: 100BaseT1_Full, 1BR10 (= leave out the modes that are 
practically unusable)

In our application, 2-wire 10 and 100 MBit is used, the rest could be 
for someone else or just to map all PHY capabilities.



