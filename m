Return-Path: <linux-kernel+bounces-154548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A028ADD78
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B81B22F89
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A3222F11;
	Tue, 23 Apr 2024 06:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PtRU205b"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D9520B33
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 06:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713853526; cv=fail; b=gUkQkXNkunsOWeo+ITrGOyDCE2OKFUncetPSZYGegOCetsYb1hEQ9Oqdsrh1HBmXAY+5V5S3uk2niu/FshC8Rg6jZW5d7Zn5asNNz5NBO4o4Vetfe86LP8mzwwfkLyLJjrqm7p4gB9l3mpj29czN8iyxuRBp6zdA8N9gwvnHkFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713853526; c=relaxed/simple;
	bh=k25HpKc4Z/qq84XsdwaO0uzDpXGRpU4r4FlBi9pdYDI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XM67FV738CarNOYgM8WU19NBjO7RmfKgQVDlGDN0jEDz0WCKoBpqkO30s+3rAZqw70mmQLSgkPz2FtvZfDPTdZfBg1nOla8tzZ0+7XWfvrOcabU9FacDZI/ntgK9qKWGXYN0nwuGD10e1oYcFqbyMCPr6F2MBC5+uAxvrPmFNOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PtRU205b; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhMFPp2WWLZV8gkDiqs3W8gVJ1ANaGTp2ym0FyExKgyrG3pgN0hwYXXcqKnetyCh7WRcTBFwQX4bt+5bpVVsVIwfOaRnaXRWZfZ2PuZXrPppd0qwsyXvq/I2AaIVmJNXcpGXXyz73/B2AUur8h0LQqk57LEJZ9RbdFz3LnuiX+hxe739etFFXyK3F27DZe37to5iQ/3MXxkR+xxCkwjf+bHFmjseAnbeAb7EnlLzwglV2DfXPzH1QzKQ8jexgWVlWjdo5pt5hZjYKdFkR7TgTxsxXDwBJ5kAHQ2ZgoNRSGRRvxhDGT04hjhvmx84pesYgqAkF+nVPvEhYbYuaQsPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szjXbmAAeNibh86VHCO5mpIM+I1UnQEqYCJuNl9ppQw=;
 b=hLutbCClh2h3iOlX8BZzrbPnmGpZOssg3hkpQNw2Ujs1KVJ2YL1fQfm0YibPby9nAL0pWrqak/ta2nxHzBrx27OGaPdEcx6JK+5Fulp2iFwUKMGUt1pbxGO6TghSwRs0XwTtkEAv+/ppmkpqpgcHcccb6GVu+DaX7JIxCffEZNjWY5EIksfgSNCxSvy83ELj3C09xyY2cShZcY3xfnUFWAH+2+jFi9tWMWp7B8xnz5f1E8Adirk9+pWrlsFXSCacEu8cGRKjjIq4dd2l21SrWKkOE/8NCxf6LctAXu8YbeIQdkvT5CoAhHLQDP7w4zES3l5bqK3OfdIIFleRXrAHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szjXbmAAeNibh86VHCO5mpIM+I1UnQEqYCJuNl9ppQw=;
 b=PtRU205b6Sza8qu0p/f1lwNam8d8jkdf1i3jwX2vV/PQpSrJ5srzNLxiuh/DNKkS36jXfRutlJ69+61xX0HACaMUFJ7g3jic1EdO6bAWgu6D2gQfIGLp0+A6OImKIEnck2zSxMtFn9Nwk3Itw3Hz9GjtTSsTFVtEQWvMBUmdgUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 06:25:22 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 06:25:21 +0000
Message-ID: <702f0ca6-7edb-4328-92e8-1853ba010910@amd.com>
Date: Tue, 23 Apr 2024 08:25:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] phy: zynqmp: Store instance instead of type
To: Sean Anderson <sean.anderson@linux.dev>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Kishon Vijay Abraham I <kishon@kernel.org>
References: <20240422185803.3575319-1-sean.anderson@linux.dev>
 <20240422185803.3575319-2-sean.anderson@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240422185803.3575319-2-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: e5935387-88f9-4f78-2561-08dc635e2709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YU1QaDJtMjIrYTBQdHdjZFptN2NqaWl0TmdTV1J5YUNHbVgyU0tDTUEyVXBj?=
 =?utf-8?B?NWJycVVmRzZDRzFyd05KeTYzRDhuSWRPY3hGYm5DcHZzZW5Jc0JXZnFYSXB4?=
 =?utf-8?B?OEtYU0NaRVlneHkzUmloSkd2T0dxSk1Ybm5DaWpFNmFzbGNWbzU4SzNmcEh4?=
 =?utf-8?B?V3huM3cxYVFOaGRmTTN2SmwyQjUyY3diTk9FZ1dpTkRiWDRIOGd0dnpEY2VK?=
 =?utf-8?B?U2lkV0dER0JITjNwbmk0Nld4SktadjRVV2hxM1ZtRDFzZUNTREI5eVZONUNa?=
 =?utf-8?B?em53eDlZQW5NOWxTNHRPbUdQcXpaN2ZWeDk4SldtK1U3TVBrUjI0b0FZcm12?=
 =?utf-8?B?Z2xZd1BLWk1TekJzaWdXZE9lTVZiTlM4L3lnaEpOdGVvbG54dTFTd3g1aXNO?=
 =?utf-8?B?RFg5cFU5TzhrRThOV1o0NDBJcVZ5cXhOWVk5d0RoUXdYM0lMRnY4TGozSnVU?=
 =?utf-8?B?Y1NSaFNNN1NLUEpqVmJHcWZVMzUwNVNoKzVqY0xLY0lPSlNITytyL3hMY3ZO?=
 =?utf-8?B?aTRDMkpDRFhpSDdRandVNHRIczRxd2p5aHZPMXNHNXg0bDFsVWhuTHJHZlNP?=
 =?utf-8?B?dzAwMHFhbmoxL3V4YnFVKy9xU01vUGxMdHFGcmcvNTZRYjA4cWxKSUVnTFJv?=
 =?utf-8?B?aFZNOWpWQm44a2gyTUxEN29rcmxOV1BQWmczYm9vMXZwWDl2TU1pSUtXUE5z?=
 =?utf-8?B?TVQ5RVUzL2JOVVZlaWZ1cHpKYmFYZGNMRjUwVE82OWxoNi8zeERNV0dMUVdw?=
 =?utf-8?B?TGN3eXpJek5NZFJTMmxBUDJHQ3kwVE1CQTZPK2hjTTVPaWhBcXZWbTF6TWZm?=
 =?utf-8?B?Z2h3dlc3bkpTa3MwbVhFSUtlT0FRcHltaGRpRzArdDJ5SHJhSFBweFg2cEVr?=
 =?utf-8?B?QndsYmVld3ZCV3VmSUxqcDV0aTdMWDlqdzlhVnl1M1hhNGlNNTM4c3YvTFha?=
 =?utf-8?B?UFMzY2dWOCs4QitMY1NuUGU2RmE1Q2NFbGoyRnJSaks2QVNyN3NISUhGbnVX?=
 =?utf-8?B?aE5Md1MyVmoySTBOTUtGS1FxY1FBWUZxQUhBclMwaUpzekRvUStBTEN6c1pL?=
 =?utf-8?B?dUlwd0NjMExKSWxvOHhRaCtrMG5MU092OGF5QTliRlp0ajVnT2I5eE40TmRZ?=
 =?utf-8?B?VGdoTUJCZ05xTlYxRmhoU2xFVlZ2eDN6NlBMa2VCQkxQb0F0dW1rTWZ1NHBa?=
 =?utf-8?B?K2ZUa0NvWUwyYlk4U3RhcCs2SkZ3WDJnUVNXckpSM0RJenVBdThsM01xdGZD?=
 =?utf-8?B?cmt0bHp6enVTRVJyc1picThFb0p6WFIxOFhqLy9EM1ZQYjNGbVpzb2pIRTdJ?=
 =?utf-8?B?MzVta3djQ3ZkMG53Q3FhZ3BxN1JWbTdOVTFqQUFvK2JCZmExc1ZuN1Z0YXlh?=
 =?utf-8?B?dHFrRjNHUE9leGV6VytoVlR4VUp1SlNKeERENzZJaXpwLzhDVDAvZWZvaG5Z?=
 =?utf-8?B?WlZrUnZzNmFSTFBkQW1uY1QyZWlLamN3SFQzNmpGVWJ0WVBYdXNrdFhZdzN0?=
 =?utf-8?B?QXhKSE5Rd0pwcU1EcDIxWVB5dXdraWRnS2hnUk1kMnFzczEvamFYNjdwQjJL?=
 =?utf-8?B?N3MvZitkdFhBZlYyVDdyMlhId05CekluT1NMMEhaZkNkTEZTRmlaUVY3ZjZG?=
 =?utf-8?B?Z1kybUc5WHpZR2VzZFdONjJVOUhPenRQTXFhVkZmNUtIZ2ZMcWQySmEwaU0x?=
 =?utf-8?B?RC9NTkdCUmN1dWh6ZkJpa2d5V2tOUFFTNzJBM2dBU0FzZDNSNFVlbXJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1huL0tHYitWeTJUNjI2SUYvMldMeWV0NERTcitIUjFVQjg0QmVyZnJVRHhQ?=
 =?utf-8?B?QVZCVHg0SUxJRGs2SWtOUnZBYk5namZYT1RVakRYbm4rQk5JT0NYUlpvT2Fu?=
 =?utf-8?B?L0RsemtnaHU4TllpQlZsS2F5R2hPMWZFUGw3dUZHMkp2a2R3c1JvSTZPRjUz?=
 =?utf-8?B?WmlXYS9sTEsvck51VEJLY1FCZzNBd2syc0g5Q293RmxUNmt3dHVQQmRvSW8w?=
 =?utf-8?B?My9KZDlNOWh6V1BJVERRWXJLMDZnM0dkdFUrcGNrNzhEdDExMnZ5eTByMVNI?=
 =?utf-8?B?Ukx5MG5MZFBLdTR0d3pKeXhmVjFhS1F5NnNqZ1NJa1VWS0R1aTliSUJlMG9m?=
 =?utf-8?B?alNmWUorNnJrY3cvYUpFcHJiSnhnM0NBYzl2WnAraHRNdGlLZ29TUi9SSzZL?=
 =?utf-8?B?b1F1TERrdEZyTUN3aVJNeXZraTFQeUN5Y04wQkR5bUZXd2FuZ1dFbURhU2tp?=
 =?utf-8?B?M2cyV3cvanFpeVZJUXpvMFphaDExK1BxeG1EZnF4c3BFNnFSa0Q3K2dxd3Yz?=
 =?utf-8?B?M205MVozVUZQS0R6QVJOTGM4aGgrQjBpYk9qZ0FhUFhjK3U0SmRiL0Zmb0VS?=
 =?utf-8?B?RHpmb1VXYVVmNHd3MDduZjVoSGJlMWJnNjRYaDNZdTlCRUpmSGRYWXcyczBG?=
 =?utf-8?B?MVdvd1k0bHhIUVpYYXdibk52dVRFbHJvTHlGYUtPdGxTU0xMVmRuS1VOMXpU?=
 =?utf-8?B?MDNnWkduSTJQOXhENXcvS2RvbnBUQ0xhOHNSc2xlZk83K0JWajBxYlhpdEkz?=
 =?utf-8?B?T3hnNDVRd1VsaVUwV3ViNVp4bmpmYlFMQ01BYnR6R08zM01jWWR0SW8xVkdR?=
 =?utf-8?B?R3RYL1prZ25SWEh1dk8yRkV1WVI4c3lwSm0vLzMxRHROQ1UwMVJ2aFU4Y3Ni?=
 =?utf-8?B?V2owczV2WU51blBYa0E5dlNiYytiYXQ5VmZkODVCVnZWVjk2cVR1UllLRllG?=
 =?utf-8?B?aGI1SWxoL2tOanNtWGVDd0xkeHZjditycGNzUEd4NXNQS3RRL2FFTGZKc3Iz?=
 =?utf-8?B?bjBBajNjcXpJWkRKdmEvRXVUNUdPZi9pVmk5MGRSNUpBelRUNGV6cDB4b0ZV?=
 =?utf-8?B?TWFTcTdDZmRkdTBHTkJFaW45UWdrUkZNS0s0L0xCUjhkbDNrbzBwVzNucmVX?=
 =?utf-8?B?eXJTVDBNZlVzMVdMSjhDNHVvTTJLUEhhVUpLb294OE5SRWFmQ2VFZmV0RkpP?=
 =?utf-8?B?SGNlTXpZK2V6a2l5UEdzd2JEZ0psckNYUnZvd1dNbmFlSWIvY3VQQ3lSWjVI?=
 =?utf-8?B?Rm1mb1NoL2pvcnYwNU9oVGthTkQyK05YMkdxL3lRcEdjRGJtSjlqemRFa2J3?=
 =?utf-8?B?bHNpdXo0dVVxaVUwNzFnRTR2UlhINSt0ZDJRQitaZy9sRlB5akx3MzdMaENR?=
 =?utf-8?B?TXFpb1BIL3dsQjZPaXl3a3ZQb001aFgvRWpjdUJ5YkpRREwxNjhRaVJUeTRa?=
 =?utf-8?B?T1lVcHZ0blJ6N0FWMVRpK3pBVkZQVktJc1NCN1pIMTVVQ0FvcWpKSENRcjBW?=
 =?utf-8?B?MUpTazRvSkhzbk5IUjZSMVNEckdDMUZoSTgvRHM1b2ppbGdDTGdqNHNSVWhx?=
 =?utf-8?B?TFJHWTZOVkY3Ym95Uk9WcENhWk9lVEQ2NFhDSTFiZEoxQ1k3UElrZUp3WjRZ?=
 =?utf-8?B?dkVKUmFuZllLL09DWFNXOFg4bXFEbUxDWUUvSHE0U3A1eEw5Uk8wN0FYUkVt?=
 =?utf-8?B?SUpXOTBGbjZnZUtETXc3cVQ1OEpGT0ZoRlhpaTVUV2lyOXRwcWt1cnNhVmRJ?=
 =?utf-8?B?ZERPWm9YeDJaUXhYemRFZ1ZCWmtmbkJ4a1BEOGRkUDRWeWFiQWdNQ3FqbENX?=
 =?utf-8?B?a0Uvb2d5VlFhbmtZQjlPR2VyNUJJbGxsZU1lWlA3M3NSMXFxNmtXK0NmS0M1?=
 =?utf-8?B?b0VNdnNRdTBoemN1MFQva1E2MWsxODVxKzhoQ292WVZDUUJpTmVMeG1ucFdW?=
 =?utf-8?B?VVFsSzNkbmVFNTd6Tm15ck83dzF6NUNRdDJsWlFYVFIyZDV3a3FYQnBNRVFo?=
 =?utf-8?B?blpKRmZ4YWJLRW1BYkg3ejcxMHVUR3pVTmp2SVczSW5tdmZqY1BJQmhLdEda?=
 =?utf-8?B?T1FiZ0JRTmc2Qm12THB6dUtNZzBXQTlJdGZKMmxnY1R5dFlYUlNQQ1UrVlNX?=
 =?utf-8?Q?l8jek90nStpuxS+XBFaqnGBTe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5935387-88f9-4f78-2561-08dc635e2709
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 06:25:21.7144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0XgmkF4SG5OZ20SaWrTllPPQ85lvnuEMcq5y6J3h0AI4+Xk+i3VwNKk7t5fL333
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701



On 4/22/24 20:58, Sean Anderson wrote:
> The phy "type" is just the combination of protocol and instance, and is
> never used apart from that. Store the instance directly, instead of
> converting to a type first. No functional change intended.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>   drivers/phy/xilinx/phy-zynqmp.c | 107 +++++++-------------------------
>   1 file changed, 24 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
> index f72c5257d712..b507ed4c3053 100644
> --- a/drivers/phy/xilinx/phy-zynqmp.c
> +++ b/drivers/phy/xilinx/phy-zynqmp.c
> @@ -146,22 +146,6 @@
>   /* Total number of controllers */
>   #define CONTROLLERS_PER_LANE		5
>   
> -/* Protocol Type parameters */
> -#define XPSGTR_TYPE_USB0		0  /* USB controller 0 */
> -#define XPSGTR_TYPE_USB1		1  /* USB controller 1 */
> -#define XPSGTR_TYPE_SATA_0		2  /* SATA controller lane 0 */
> -#define XPSGTR_TYPE_SATA_1		3  /* SATA controller lane 1 */
> -#define XPSGTR_TYPE_PCIE_0		4  /* PCIe controller lane 0 */
> -#define XPSGTR_TYPE_PCIE_1		5  /* PCIe controller lane 1 */
> -#define XPSGTR_TYPE_PCIE_2		6  /* PCIe controller lane 2 */
> -#define XPSGTR_TYPE_PCIE_3		7  /* PCIe controller lane 3 */
> -#define XPSGTR_TYPE_DP_0		8  /* Display Port controller lane 0 */
> -#define XPSGTR_TYPE_DP_1		9  /* Display Port controller lane 1 */
> -#define XPSGTR_TYPE_SGMII0		10 /* Ethernet SGMII controller 0 */
> -#define XPSGTR_TYPE_SGMII1		11 /* Ethernet SGMII controller 1 */
> -#define XPSGTR_TYPE_SGMII2		12 /* Ethernet SGMII controller 2 */
> -#define XPSGTR_TYPE_SGMII3		13 /* Ethernet SGMII controller 3 */
> -
>   /* Timeout values */
>   #define TIMEOUT_US			1000
>   
> @@ -184,7 +168,8 @@ struct xpsgtr_ssc {
>   /**
>    * struct xpsgtr_phy - representation of a lane
>    * @phy: pointer to the kernel PHY device
> - * @type: controller which uses this lane
> + * @instance: instance of the protocol type (such as the lane within a
> + *            protocol, or the USB/Ethernet controller)
>    * @lane: lane number
>    * @protocol: protocol in which the lane operates
>    * @skip_phy_init: skip phy_init() if true
> @@ -193,7 +178,7 @@ struct xpsgtr_ssc {
>    */
>   struct xpsgtr_phy {
>   	struct phy *phy;
> -	u8 type;
> +	u8 instance;
>   	u8 lane;
>   	u8 protocol;
>   	bool skip_phy_init;
> @@ -330,8 +315,8 @@ static int xpsgtr_wait_pll_lock(struct phy *phy)
>   
>   	if (ret == -ETIMEDOUT)
>   		dev_err(gtr_dev->dev,
> -			"lane %u (type %u, protocol %u): PLL lock timeout\n",
> -			gtr_phy->lane, gtr_phy->type, gtr_phy->protocol);
> +			"lane %u (protocol %u, instance %u): PLL lock timeout\n",
> +			gtr_phy->lane, gtr_phy->protocol, gtr_phy->instance);
>   
>   	return ret;
>   }
> @@ -643,8 +628,7 @@ static int xpsgtr_phy_power_on(struct phy *phy)
>   	 * cumulating waits for both lanes. The user is expected to initialize
>   	 * lane 0 last.
>   	 */
> -	if (gtr_phy->protocol != ICM_PROTOCOL_DP ||
> -	    gtr_phy->type == XPSGTR_TYPE_DP_0)
> +	if (gtr_phy->protocol != ICM_PROTOCOL_DP || !gtr_phy->instance)
>   		ret = xpsgtr_wait_pll_lock(phy);
>   
>   	return ret;
> @@ -674,73 +658,33 @@ static const struct phy_ops xpsgtr_phyops = {
>    * OF Xlate Support
>    */
>   
> -/* Set the lane type and protocol based on the PHY type and instance number. */
> +/* Set the lane protocol and instance based on the PHY type and instance number. */
>   static int xpsgtr_set_lane_type(struct xpsgtr_phy *gtr_phy, u8 phy_type,
>   				unsigned int phy_instance)
>   {
>   	unsigned int num_phy_types;
> -	const int *phy_types;
>   
>   	switch (phy_type) {
> -	case PHY_TYPE_SATA: {
> -		static const int types[] = {
> -			XPSGTR_TYPE_SATA_0,
> -			XPSGTR_TYPE_SATA_1,
> -		};
> -
> -		phy_types = types;
> -		num_phy_types = ARRAY_SIZE(types);
> +	case PHY_TYPE_SATA:
> +		num_phy_types = 2;
>   		gtr_phy->protocol = ICM_PROTOCOL_SATA;
>   		break;
> -	}
> -	case PHY_TYPE_USB3: {
> -		static const int types[] = {
> -			XPSGTR_TYPE_USB0,
> -			XPSGTR_TYPE_USB1,
> -		};
> -
> -		phy_types = types;
> -		num_phy_types = ARRAY_SIZE(types);
> +	case PHY_TYPE_USB3:
> +		num_phy_types = 2;
>   		gtr_phy->protocol = ICM_PROTOCOL_USB;
>   		break;
> -	}
> -	case PHY_TYPE_DP: {
> -		static const int types[] = {
> -			XPSGTR_TYPE_DP_0,
> -			XPSGTR_TYPE_DP_1,
> -		};
> -
> -		phy_types = types;
> -		num_phy_types = ARRAY_SIZE(types);
> +	case PHY_TYPE_DP:
> +		num_phy_types = 2;
>   		gtr_phy->protocol = ICM_PROTOCOL_DP;
>   		break;
> -	}
> -	case PHY_TYPE_PCIE: {
> -		static const int types[] = {
> -			XPSGTR_TYPE_PCIE_0,
> -			XPSGTR_TYPE_PCIE_1,
> -			XPSGTR_TYPE_PCIE_2,
> -			XPSGTR_TYPE_PCIE_3,
> -		};
> -
> -		phy_types = types;
> -		num_phy_types = ARRAY_SIZE(types);
> +	case PHY_TYPE_PCIE:
> +		num_phy_types = 4;
>   		gtr_phy->protocol = ICM_PROTOCOL_PCIE;
>   		break;
> -	}
> -	case PHY_TYPE_SGMII: {
> -		static const int types[] = {
> -			XPSGTR_TYPE_SGMII0,
> -			XPSGTR_TYPE_SGMII1,
> -			XPSGTR_TYPE_SGMII2,
> -			XPSGTR_TYPE_SGMII3,
> -		};
> -
> -		phy_types = types;
> -		num_phy_types = ARRAY_SIZE(types);
> +	case PHY_TYPE_SGMII:
> +		num_phy_types = 4;
>   		gtr_phy->protocol = ICM_PROTOCOL_SGMII;
>   		break;
> -	}
>   	default:
>   		return -EINVAL;
>   	}
> @@ -748,7 +692,7 @@ static int xpsgtr_set_lane_type(struct xpsgtr_phy *gtr_phy, u8 phy_type,
>   	if (phy_instance >= num_phy_types)
>   		return -EINVAL;
>   
> -	gtr_phy->type = phy_types[phy_instance];
> +	gtr_phy->instance = phy_instance;
>   	return 0;
>   }
>   
> @@ -756,14 +700,11 @@ static int xpsgtr_set_lane_type(struct xpsgtr_phy *gtr_phy, u8 phy_type,
>    * Valid combinations of controllers and lanes (Interconnect Matrix).
>    */
>   static const unsigned int icm_matrix[NUM_LANES][CONTROLLERS_PER_LANE] = {
> -	{ XPSGTR_TYPE_PCIE_0, XPSGTR_TYPE_SATA_0, XPSGTR_TYPE_USB0,
> -		XPSGTR_TYPE_DP_1, XPSGTR_TYPE_SGMII0 },
> -	{ XPSGTR_TYPE_PCIE_1, XPSGTR_TYPE_SATA_1, XPSGTR_TYPE_USB0,
> -		XPSGTR_TYPE_DP_0, XPSGTR_TYPE_SGMII1 },
> -	{ XPSGTR_TYPE_PCIE_2, XPSGTR_TYPE_SATA_0, XPSGTR_TYPE_USB0,
> -		XPSGTR_TYPE_DP_1, XPSGTR_TYPE_SGMII2 },
> -	{ XPSGTR_TYPE_PCIE_3, XPSGTR_TYPE_SATA_1, XPSGTR_TYPE_USB1,
> -		XPSGTR_TYPE_DP_0, XPSGTR_TYPE_SGMII3 }
> +	/* PCIe, SATA, USB, DP, SGMII */
> +	{ 0, 0, 0, 1, 0 },
> +	{ 1, 1, 0, 0, 1 },
> +	{ 2, 0, 0, 1, 2 },
> +	{ 3, 1, 1, 0, 3 },


Do you think that this is more understandable than was before?

Thanks,
Michal

