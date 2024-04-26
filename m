Return-Path: <linux-kernel+bounces-159454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0450E8B2ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C38C3B21E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4394274E26;
	Fri, 26 Apr 2024 03:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RRGhpQ8N"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010000.outbound.protection.outlook.com [52.101.128.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04B52CA2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714100402; cv=fail; b=SkWRxHP01cJoMHEh8TH0AS18BNuIR2ij45xuCkVAymO/PzB7V5QJhvxC+yKaHqf+l4BpECf7DHUN361p/sR8mXNGZ8qKX4NDdl2i59GubQG+8dZTHrt5eOld+F0j4TYmN44h/yJYU3fNGhn2Z457h2j93mbysPVpeaQ+AawDwSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714100402; c=relaxed/simple;
	bh=sAdjm4gJzNdHEqykjijbfAV+QVO/yFsKH+ZLKS4iV1s=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P2Hk5AqUE67btQ0zo/tCVRt8u7bPlpuQph+yoKGWw/U1fXlliCvuXb1JcvgGXpe73MV9uiLcpz1RtiZUY8hrWXvnHcLXuDpBqgqdrx4Ueh6Mg1FcaFU+s6yaMzpB1A467ang9fYNwUXA3YQvft0lnbPD+bmWxvgME8+A+a8/bqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RRGhpQ8N; arc=fail smtp.client-ip=52.101.128.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJB4R5FzFnbtzlg9T1YycBFEIMOCStNyDL1OV76EBbhsxdzP+YXB6ixMmPDOVOd1/9gtDEkzd0j6/mUX/H8X3cTDes0J9e5grFWRpafdOcv2FGgFiB2UbJHE0DL6u6jW8L4JgfU7peWpxHT0xvC9619RjEngQPQ4C67hUe1gdWX99hJA9a3xaO/LVtj3MS5qJkT2ZowfgD4zb2E5USyTJd4I+9yV3TtSqxUj8aqrsGQ2aFkp3sFOT6ai9eERaPRrF4a6KxhsjL0toqwYMV7S8Wgy4mlsCVXWSjPNiHBZsTK903YN1eZql0lmnht6GxmZ8M057NVWaZB6gIHv4d1g6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtkQCTKWFmD/RH174VzJT7jvqPZA8afHgm1thGNa6cc=;
 b=TqgDo0LR6Q+y+jH82ssAhZg5x52v9pH7G+gatMV1wdAkrRkMsnAv+ZCedICy+dm00xJXt7AsF5uXJoGFZW47o3kIGU3neGdl+mOgH03RNPO7eVje4d2XWCMXhifA9WqzfHWa79zlClV0jZqlbLgNF2SGaRQXBQD1M/oyN1TIxKjHg5y3c4dTpcThNMMYza8CzyIq17T934e0OzwUQMISThADMc3Y+y73Xklz4f0NUhKq2GmIK5L4PaeSoyQWNwSQR35WcTCX/0hHhnfDp98MoRJvDY3Ix28sR+kWB9S2Vo69vRJJAHxGIEUHmkz4aSp+nSOtS9ZKq8xKMpWyp8t63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtkQCTKWFmD/RH174VzJT7jvqPZA8afHgm1thGNa6cc=;
 b=RRGhpQ8NO+7I5anBOmgnqHPxEDQqAAuCbpM5M6huHT34uePO2YfJaehuPplJMugwxFKWVGwHnVIWm3hiI7B5HnoWAhzWEzThpD+dTKksahR3TzwPtQhj2jjdLBp0k/m5xhFg8ASpShdCimcnJ2Cdr2VGKb4ZgHPi4VnzuV7D1gyVSB1Nlf7jAof3LNlIsfo8safPixPkVCuLbqp60oxkLNDgYKNLRLed103dD6XZk01HPAb4nvGCffhofr4fPPXKSWWsjBLvcKPegr4Tm2C6ay9HW2cj9hz+S3mnJ/iCdh3AGIUSt6Q7N/NraL13rpKdArara4h8keQgYaEyKJvoAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TY0PR06MB5801.apcprd06.prod.outlook.com (2603:1096:400:27d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 02:59:55 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::4fda:1ec1:241d:4634]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::4fda:1ec1:241d:4634%7]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 02:59:55 +0000
Message-ID: <fef9f0e9-33d6-4e64-80b5-095b4794d7c8@vivo.com>
Date: Fri, 26 Apr 2024 10:59:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: fix alloc_pages_bulk/set_page_owner panic
 on irq disabled
From: Huan Yang <link@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "kernel@vivo.com"
 <kernel@vivo.com>,
 "syzbot+b07d8440edb5f8988eea@syzkaller.appspotmail.com"
 <syzbot+b07d8440edb5f8988eea@syzkaller.appspotmail.com>,
 Wang Qing <wangqing@vivo.com>
References: <AJMANAB3D*gl9w79jvWlvaqZ.3.1626053734064.Hmail.link@vivo.com>
In-Reply-To: <AJMANAB3D*gl9w79jvWlvaqZ.3.1626053734064.Hmail.link@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR0101CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::28) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TY0PR06MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 4384ed1d-620a-422b-35ca-08dc659cf33b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekYyM0Rqcy95TmZscGFGSGFmU3UyTS9kZEk4N1hhSnZwdU9OeFJRWXQ5Y3VJ?=
 =?utf-8?B?RTNGbTcvTjFxTmY5dlNkMFZtV3BONzYxRDNxQkRCY09HOTZaQXppQ3VZeTda?=
 =?utf-8?B?eGdwa0I5U0ltbGEwQU1yRjNIc2x5dy9CSVlvZkFJeEtEaTZEcXVlZWFiRWln?=
 =?utf-8?B?WVllME1pREQ1cmVyUnUvT3o4Y0RPZzkyV2ZNMDBZMGo1ci8raWFxeW9WdHln?=
 =?utf-8?B?cnFBRHArMnVleFNYMkd1WDFmS3k3RncvOVhFV01BdHAzRkQ5MUFwVUE2QWp0?=
 =?utf-8?B?UzJKY0M4SEx5YlplelZOTFZpUktKR3RqT2JlWDRLV2hBTVNFemI5NTczcGxR?=
 =?utf-8?B?akNacmNZVmN5ZVhKWWZPZk4rMm9nNEhxR0cwWTFLbFd6bHlMMCs3aXlGdnJW?=
 =?utf-8?B?RS9ZU3k4TmFWb3poaytzeWVEY3o5NGtXL1dtTkQ1Vi9BcWx2TWFjT2FLZGln?=
 =?utf-8?B?bDAwdnR6LzR1c1ZKMW44UmRqRHQza2xFZWZUdW5peEh6UXNxY0UyS3NTL1Qv?=
 =?utf-8?B?SHFzazRzNW9RZFlpemZnOVR6aElhQzFNTEVEbmdYYnNjaVVrSVMzYjAxcGsr?=
 =?utf-8?B?cyswdWxoMWRJV2ZqRFV0aWE0MU5EL25VODN2ZmJFTng1eVRNZXllQ2JlZ3dv?=
 =?utf-8?B?M25wOEpLOHhEaHlBQmd4d1lxa2FsRWEwdE1RNVNSTHp2VzdVd0pQdlhEWENM?=
 =?utf-8?B?RWd0ZkRkMnU1ck1QTzZ3NW1PUS9COTFBdUNFRUtnZXNoUCtXN1huTnNpKzJQ?=
 =?utf-8?B?VUo5TlRuNzNpcm1NSmMyZ1NHMSsydWtVV0tEZXBrNHh3WE43OTdjUElLMzFv?=
 =?utf-8?B?VDg5b2psbUt5NzNuZU8xajVva1FsNzQ3TWJmSTJlMUl2cUkwNXhxUXBGRmVH?=
 =?utf-8?B?QTc3UlBEb3l5NWxXZ0hwUjhwM1dGVUwzOFJ5VEJPL0hQL1l4bHlWb1MvdkVn?=
 =?utf-8?B?MmlQUnpzYU9hR3ZXSzIyNW5oT1hPeEcyelBrM0xEYzdxclhOL3A1aFhieEMx?=
 =?utf-8?B?aGMyRFd6WVJyOW5pYTBUOHlyOExqY1VtRHIzbno2UVlJbURESmYwWmV1cVpC?=
 =?utf-8?B?cFdEZGxHamNJY05TL0V2ckYyUVg2VlBPeXpTSWZQOHpGN0FVTCtNUUNMOVFQ?=
 =?utf-8?B?VVZBcHFyY0NZL1FvVUJnY0E3anNnTDhJaytGNmhucXBoSzEwZDdxTUg1NmQv?=
 =?utf-8?B?WGdveGtxREgwa1AxVkdVM2FYMFBVQVBIMU1od2I1RUhnWWZJVXp0RVE5TU9E?=
 =?utf-8?B?WUh6Q3hHZUtiSm9GRFcyd0xLY3MwYnFMWjBnNEIybVV1bXhxb0xveHoyQmhM?=
 =?utf-8?B?a3JISWpuZG56cjRrYXZjaWpUTEV0clZJcmc5Vk56K3M0NnU3NmpFNlBOR2Zw?=
 =?utf-8?B?MEV1UkdFeUZNaUN0V0p1UkQ2QlJOckNKQ1pNdFZEemtTSFRubDlMTU1vTSsy?=
 =?utf-8?B?eG8vcVllN3pQQkdwQk4vNmNMc0xHdUFhM3d3MG1jRHZLWEZKcE1DQWIwRnMw?=
 =?utf-8?B?dkRRc25MTy9NRnRCd2tRc3lwNW1MLzRNNGhydzBnRmpwaGpOTzU1ZzNHdmFS?=
 =?utf-8?B?aUxtditCNS9JelZkWFhNRldaRXZ6L2RrajZsaDJOR1ZqR01vSEplS0Nnb2Rl?=
 =?utf-8?B?ZE9QWFVvTUNFL0hYQklXci8xNTFPb2h3VE5rdDBVTzZFeDU4cjBsV3liOGlE?=
 =?utf-8?B?ek1BalFXQTZJeGkzVmI5ZE00Q0hSd0xMWG1yMTVheU1KY1ZFS0FWbk1BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVZCMEFuSFl5RTZnb2UzMHh4a3JMQVhmbmE4bTdQemZPYk53N3dFZnhRTmJ4?=
 =?utf-8?B?QldmRmt5akRjRURqUi9DOG1VQTBYTUlIOVNMY1lXbmk3b28xV2VabEZiUXMr?=
 =?utf-8?B?S0RzRHJIbExaNTUxc1VENWtSd0swN3BES3FCOTIvSUhRSFlzYWd2VTBYcE54?=
 =?utf-8?B?Z2wzSkw0bHkwV2I3ZlpEKzBvcjI1VUp4VHVXSVdXMHk1dWdoczBzVEFMREY0?=
 =?utf-8?B?NjhtOXNadVN5MTNYRTdzR3RUMlgxNXhGUXpwQTBFWTFMRERrZmpJUHZyclV1?=
 =?utf-8?B?dDgzRjc2cTlCclkwYjhSSVE3bkVieDhjZWRDa3Z5d1J0SmljWUg1T3FIazF6?=
 =?utf-8?B?azRVVVZWaEpZcGJGeXRCMWh4bkZhMTV0MHRMb0x1dFVJblhPQzVuZm9QRG01?=
 =?utf-8?B?cUNHWStnNEluc0d1Z3VIMktKTXpTbjZLRGpqZTh6SVNBMFZNalFFa0h5dG03?=
 =?utf-8?B?U3NjNzdZREI5TVU2KzNRYTRBMDZzOGpJWHRyaXdYZUJzNnAybXVIazB5WjM2?=
 =?utf-8?B?RDhqc010MGQyR2NHY0NCOWFjcTRBN1VNZG8rNkszaU54RDdtMWJ0L2E0S1Ni?=
 =?utf-8?B?dU1qNXBlWjJaRXZUTlNhNXV3alFPOHMybnlPZkgveUR3V1IrRytWRmlQem8r?=
 =?utf-8?B?aG1tSk5hN2lzbEhIZU5uQWtlUnJ2MlladEFFSCtPK0Z3ajBZSnBWTFpUUWRl?=
 =?utf-8?B?MkYvUzZEdnYvaUtoQnhTTUFwNkExT3NUUUpldjlZa1V1ZnFpVVhNZUpwalA3?=
 =?utf-8?B?c0JZSXpoRGVrNXhIcjZVYVhmY0x3VE1YcEV6QVhPdVBINXlmTW16N0licUVU?=
 =?utf-8?B?Q2xXb3FhS2lSZzc5YTdzSGs2NVRmVHViK0ExM0cvbjVneGQyUE82bkJlNCth?=
 =?utf-8?B?M2hmbkFjRmJPVitoUEJFczRtdWp5TElBZ2pSZjZlYVlvR1BjNUdVOGh0Wmxu?=
 =?utf-8?B?RDdmREsrOTZxT3JldXlNQS9mOVVFRmZQNmZCQ0RGNFU2REZyVHpUbGRKeTlB?=
 =?utf-8?B?ejgrMnpTeThmejZaZGlKYms4VU53THRFMnBGeDM1N3BGNEY2Skx5WWtMWFdD?=
 =?utf-8?B?Q3dJcEQyd0VHSFlrdzYwY3lxOHVOeUdBNXZ4aytXOVJIWGYvR2VSSUlDanNQ?=
 =?utf-8?B?eDM4RVRsWkZpS21Ibi9nS21nNjlabkdZY01BMnZMV0JIb2l0TkdWbUxubHlL?=
 =?utf-8?B?NVc3TjQrS2FrcHo5Ym1XNnk5YTEyZTQ4bWwxOWpyUWRSLzBWd2p5a3FTN0tr?=
 =?utf-8?B?WlJuNVd5MHhwV0lrdHFaQTQvZXZhcklNcjE4d2hnN2U0UVNYTXA2b3pCTWhN?=
 =?utf-8?B?S1VXbVZNWUphOXlxNGRsLzdQVnhJaXN1SDNHRjE0MTc5anFXQUl3OUh5U2kr?=
 =?utf-8?B?b2FOR2ZnYlRJTlJsR0tFZWVZQVh2SERoNzVCSHVweGZsVmV5M2I4ZWI2blps?=
 =?utf-8?B?VGE5OUF2UU95QktwNTZ3eDJFcWdiVnc0RHlmYk9GWkVwTXlnQWgxcldlcVdF?=
 =?utf-8?B?aVdDRzYxNGJRcDVKM2QwQU5HSlMxUlNnb0d2Kzk0QlAvY2g1My9heGkweVVy?=
 =?utf-8?B?VE5ZSi9FMGEveUhadlU3aGJuY1ROTkFQK3lMQnF3aGFJRWk2WjVOWHkxRm1H?=
 =?utf-8?B?K0dmYXBkbjdVRytnaE1wZ2V2WjdQR1BnYUJDS0liaEZyUDROZjNDSmJlWndI?=
 =?utf-8?B?bmZXaHgwc24xVEM4SHdreDdXOXNwb09pb1lqVHZlQlc4dkJuS2pJNU1Dc1Yz?=
 =?utf-8?B?aFJ3NEs1dkZnYUhpcFBFVUl4Uk5iS0hJL0J5NVhObWtJYmlaQ0VvaFlNZEVP?=
 =?utf-8?B?QTRYeEZua2pGeXVBWUJmdVQvWmxPZ2lFKzBRT1Nrd2IvVDlhbGhPZC9WSVJS?=
 =?utf-8?B?VW5TYWplUDRCQS9VRW5zUWJNc1ZyZlhxMjlkNkNvQjNhUzJ5NHFldkVyMnhk?=
 =?utf-8?B?NkxEbWkyYzF6RjVSbXkxSGhDMFJGUWZjeUpxc3cyV3VTVk9TRmhnS3g5Q3p3?=
 =?utf-8?B?NzhTbzlJMTdwR1paZU0venNVcXZ2SlRKOUo5Nm9tMXk5NkxZT2NjVUpvOVdw?=
 =?utf-8?B?c20zQ0k1NTU3QVpqWm1QdnNabW1xcTJ2ek5kSjBWUVA0cEliblNEKzFDYVB2?=
 =?utf-8?Q?U70TRgYL2cJB2Ev8fhGs2iA5h?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4384ed1d-620a-422b-35ca-08dc659cf33b
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 02:59:55.1429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCCCm4seYYg1ePqx5H4ejBgkSJ/2SB8XfQjN2Pn97PZQohYTuaoGYUFY/ChjFQixdVtPWmEKayBNIgzThmToCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5801

HI Andrew

在 2024/4/25 17:52, 杨欢 写道:
>>> The problem is caused by set_page_owner alloc memory to save stack with
>>> GFP_KERNEL in local_riq disabled.
>>> So, we just can't assume that alloc flags should be same with new page,
>>> let's split it. But in most situation, same is ok, in alloc_pages_bulk,
>>> input GFP_ATOMIC when prep_new_pages
>> Please more fully describe the bug which is being fixed.  A link to the
>> sysbot report would be helpful.  I assume there was a stack backtrace
>> available?  Seeing the will help others to understand the bug.
> Sorry, here is the backtrace:
> __dump_stack lib/dump_stack.c:79 [inline]
> dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
> ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9153
> prepare_alloc_pages+0x3da/0x580 mm/page_alloc.c:5179
> __alloc_pages+0x12f/0x500 mm/page_alloc.c:5375
> alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2272
> stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
> save_stack+0x15e/0x1e0 mm/page_owner.c:120
> __set_page_owner+0x50/0x290 mm/page_owner.c:181
> prep_new_page mm/page_alloc.c:2445 [inline]
> __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5313

Thanks for your reply, but this patch was submitted in 2021, at that 
time it was believed that bypassing

alloc bulk would suffice when page_owner is enabled, so this patch was 
not considered.

Have you recently encountered any issues related to this?

Thanks.

>> And if you are able to identify the patch which introduced the bug, a
>> Fixes: tag would be helpful as well.
>> Thanks.
>>
>
>
>

