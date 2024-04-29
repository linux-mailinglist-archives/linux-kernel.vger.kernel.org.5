Return-Path: <linux-kernel+bounces-162453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B168B5B7A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489C91F225B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB0D7E77B;
	Mon, 29 Apr 2024 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LDwesnrN"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299BC757ED;
	Mon, 29 Apr 2024 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401423; cv=fail; b=kng1tP5M8z4bMg90SNcucLCWtuqJxOKHOotN42WBPUcPvadDty30aIG8W2Au/hMAXYJU/hX6IlxcoMy8iOqEaT52WlGbSVp6wxKFfkBRcUrP/e1HO2gPKv1uEjihkdMITZp6AlYeXgeyDh76HOrtRxPePzub4xfacpNtqC7DotM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401423; c=relaxed/simple;
	bh=MaekDZdmfE5LXg1R80hTI1Ej5C0O/hmBWy4tYQEpcTg=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ezWAnJSNkrkHZPXGkZt0nPxkhbMYxVNjbyDy7rZpalEQBp4/hO6uM14t14cW6NJIrJ0lyCP57yGBLRkgpP+BeZpR0zHrNepbX88/3/5i1iCgmwjj6dyu2zp44oTQhDX+HatS0XezqB2BoLfE2vn3bvnUR595OFLxsYLAyuaIwYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LDwesnrN; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COYYvFbkRco0ptZsi2SAp8O2Ucjwvz/VZbPai8/FgfiImYz0fjMkDgTktz/f2rP/g0AjIHhCyo2GO+5QTTI5nINjC9AzUV7SYLE5b9XdDVje/LQPBH4SlVUN4D2IIn7QEggh4+Lk938Vu1EmDtAz+aUr9zOi58Jll8P7/+CxuSxyOnNsHhSmJ7IjG0NNHWs5/n+3w6lST69105eE06A2TdlLH7bRnXKXnOj+Hz+mSjmTmjdQncsoYELXyINTap0QD4gYRZrareEADQZSSw90y1ct0OmJEJ8TYNzyY0MEIuezkfihNDy0HYTZ5IYwXRx/dY+4I5LpF6eeaBQfltPZaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njixFyw7NprxWmM6FOiaqF74twLtUkidX6JTY08zmt8=;
 b=PZZ6jr9ie6mSQIAsmbjmYi/Me0zfiG0r39fS1mF9ffmD9FgatVuhle756VriY5NWdP76UMGhjoaDX2nNzGhdcpwrr+24KWKtyl4QNnlGZU4FEmsPVomOta19eN+StN58SSi5kZuCPiNNrMlqfKmpVe4ka5w7CMgchxpH1eqt+PkigVfdEftE56EPw5665DaqkoeEbc46dJQW1o5AXx1zM21aVPBXT7618VNb9BZ0D8Q9qmICNX4150jSTMAuPe80ZPAOKIBb2lMJhOY9w1BG3SbyA6hItCOIuYTuA/OO1hy7f5ETHPF080zXl+R2du8rospBwJTGECGuEJeckf+oxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njixFyw7NprxWmM6FOiaqF74twLtUkidX6JTY08zmt8=;
 b=LDwesnrNCRZ3u9c9k1+EhzDDvEwemoeThsv2EMnEk6RiqEG0TiFP9VQCBJXgh+7TYNzJJOFQmuwNXK9b1l/s8WcQ+ae4/R1/z8H7mwJtmzlmasTwtwgF+by3AGO4uE7PJO8lJGHj/KY6xtXdpNaqrNTOK6Mj3kzKafhPUI1sfzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:36:59 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%7]) with mapi id 15.20.7519.035; Mon, 29 Apr 2024
 14:36:58 +0000
Message-ID: <7b68f364-a324-4e2c-87be-19cdef4e3ad2@amd.com>
Date: Mon, 29 Apr 2024 10:36:57 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 Avadhut.Naik@amd.com, John.Allen@amd.com
Subject: Re: [PATCH v2 09/16] x86/mce: Unify AMD THR handler with MCA Polling
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-10-yazen.ghannam@amd.com>
 <20240429134043.GPZi-jWzoVe3bJkyYX@fat_crate.local>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240429134043.GPZi-jWzoVe3bJkyYX@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN7PR06CA0037.namprd06.prod.outlook.com
 (2603:10b6:408:34::14) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: bbea8871-1764-4fe7-1ec8-08dc6859d35e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjdRQnZ3bkd5SmZkY2hlK3doK2VVNGkwUUtydTMyZWN6N0FGTXZjUG8yQlg0?=
 =?utf-8?B?UTBZbGlQM0JHVkRJQ0lDUU1vNktNNTlwR29jVG4weTU1ajZlYUJLYWxGT3Ju?=
 =?utf-8?B?R3grYlJPZjZERkp2YXZRL1Q2RHRBVkt4TWlVdFY5TXRuTjI3SmFucjRxcyth?=
 =?utf-8?B?cVFERndUMlhQM1liQ3ZMa2NzK2Y3dURzV3Z6eCthWG9zaWI0R1NkcjhPaU9K?=
 =?utf-8?B?aWlLN1lJS2xYdWtKeU4vc2ljZ21iSzRxb2k0WXgyVERQZ0lkQ01HR1NWbmlp?=
 =?utf-8?B?VzYyVHR3dEd4V0lIRzEvRjQ0OVZFMldxNGwxWTJDb3FvWWkxcVE3M2Vva0pD?=
 =?utf-8?B?QS9LZ1ZZU3AwK0tMaFpIZXBOMVBrU3JZK1IzYkVnOXFhdTk5TmRxTUN6UjJl?=
 =?utf-8?B?SVJEUjBtNjZIVm02aGZBeU13YmpsTHVSV3JaMGxYWG0xTjRib2dua1o5Wkpl?=
 =?utf-8?B?U0h3cytNc294R28vUGdyZGpRZzRJN21qc2VCMWt3TUtMTWh0bnNLOFlVSlpz?=
 =?utf-8?B?VFQ3YXM4TGkwOE1RQkpEMlhtR2cyUU1QdUxKNm9ObXBrZnU2TTErSXpJQU1y?=
 =?utf-8?B?TWUxNW5pNFY5NHN0NTdQMVpobktKQmV3REZBbGE3Zjg4RnV3b3lsL3d0VnEx?=
 =?utf-8?B?bit2VUMzSXNzZ041ZzgwcDNCeHpYTnc5YUFBNkZhU3Ixa1BHYUl4QlQ5RDh0?=
 =?utf-8?B?RjArajFDc0JIRVpVTnJpcU1ualVwVlVQVCtWd0hNeHVTczhDZ0JKdEJYRWdV?=
 =?utf-8?B?enhIWENaTGpFSUZvTnJzYnNwTVl4ZGI2Snd6dmdmQzVQNnpNWWUybVl6bTJK?=
 =?utf-8?B?dVhtQXkxUWNjWjN3R1JvZndrQnZiaHMxdVJCU0lyR2srTVIwRHAvYkI2eVVI?=
 =?utf-8?B?U0ttQnM4MmV0amk1czYrN01hTERLTDRaNVdUN1ZjYXNGN014QmRXaGZ4K0J4?=
 =?utf-8?B?Um96bGROL1Z0ay9SSzBBSUFzdUE4bjJaaCsrZVplVmY0ak1jMXpEcW5PREMw?=
 =?utf-8?B?dmVHNU50dUtTY3JmVExvZHFyTlJCMXQ2WnFLckhsQ21zcWRUSnhuejNMaW03?=
 =?utf-8?B?RUp4Y2JBY21jSjNZOVB1NDZ4b2VrTFY1Qk02cTIvbUZSTUJWMkZ3eWpGU1JQ?=
 =?utf-8?B?Qjh4ZHoyU3JHcmNkZC9RTFhGN2ljMkpFTTNmeFNNelVndWpkNlZ6RlFzTzBW?=
 =?utf-8?B?MDdkay9LRXM3dEgvQ1FpWUhiOXFDbXBxcmk4WlBNUXRHMlRXSVBnMW9aRmxp?=
 =?utf-8?B?eFRvbDNBSUhmemY5OEhDT25RV2JsdWxxbkZ0NmhqUmdrakZ0NnJVMXd3RXpW?=
 =?utf-8?B?S2pQelljUXRFQXI1RjhJZUJsQk11VDNHZTVDQm5tSk1DdTYxbG9UemtkV1pE?=
 =?utf-8?B?d1I2OGZxcVVKRWYvKzkwaUNoemdIMkh1RDBRYUZyODFwU3BzclpYN012YXN0?=
 =?utf-8?B?UC9aMXkwbFkrN3pHYlBKSmVBUXZxVkRvUUdVTlJMS2NlQlppUlFRT2ppUEhO?=
 =?utf-8?B?cDg5ajF3WjJOakhoNTQ5UkczQkVyTmZpRFI5UWFHVzdQUEo1N3hscnluK2Vw?=
 =?utf-8?B?TVhhZll0Y0tKSjdrMzVrVWEzVGZhc1NMTVQ3bEpWdjhEUGdLdXhJU1pYdDZL?=
 =?utf-8?B?eE1lSitEdDZ2bUlVVzVzeS9XR0VoSnZxMHZwdGd4ODNnQmVlY3YvNERSL05y?=
 =?utf-8?B?VDRQTEpWdHh3a2Y2QVZVSXZuQW55OGVkMnB3T0hjMW9iK2phTGFmRmZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGdPZ2J0TWRLUkNCUS96TldidzEzUkNTMnFFMGhEOWgwUE82RExuTjlXem1L?=
 =?utf-8?B?N2lSa1JIcjM0VC9SQUJLZERmQ1psdVMxSnE2SVI3emVLRHBIODZsSDhLTVRq?=
 =?utf-8?B?RC9kMzdoN1Z6MGZuMUZQTDk3UkxLRWR3SkgvbzlpZGdKNnA2SXNTWVBjK01x?=
 =?utf-8?B?ZFJKdDBZa3g0dDNvUE9WOG9WUWVUaHQrcnRvOUlpdlVERjIvMnlJS1JBMUNW?=
 =?utf-8?B?dU5sV2Z4WkNUQUtmeFpoeHc2Y3I2UmRHQU1PaWRIWkhJYnZJeUxDN0g2V3pK?=
 =?utf-8?B?N2Z3YU10emtVR1ZaWGUyN1hIdFFwNkh2N0w2MUhKSllOemM1NjRaSVd5T1N1?=
 =?utf-8?B?UHhBSVpFUXlsMFVseGxLblBxcG5xMmtLVlMvc3dkVG9YbGxkR280ZWdjdTdL?=
 =?utf-8?B?OWZDa1Z5MFMxWkZrVG9aS1p5T1dvNU9qMVp3SHhta01TeGRycVpVcm96T3Rs?=
 =?utf-8?B?dWJLZTBQbzNqVExUcDZnUXByc2x1U1FjbTJTYzBoQnNUdnJ0d1phRk85ai9Z?=
 =?utf-8?B?dGJtQUxCT29kRmg0eEYwWWV3M0JxL0FpRFRrcDBCd1BBOXNwTUdvQVhMTTBW?=
 =?utf-8?B?OFNUa2UzY25KUm9uRVZSclY1K2hmR0pVUm9iLzhZYWVnT1JzVzdGT2JMUlJE?=
 =?utf-8?B?V0ZSc0VhMkF5bk8xVzJUd2dXeWhVYTRUV0d1bGF1MDhWWk8zekxUT1dpdVpJ?=
 =?utf-8?B?T1loYitvTXo5NTdvWDU0bnVVUDRJRFMvMG03bVlmSDVMaUwwYXlvNjdMNFpi?=
 =?utf-8?B?MWlIcUpNdEJheW83ZUp3WTVLZGoydU1ua1NpT05hTmg3TENkSXkvaWFTWjl3?=
 =?utf-8?B?VUJobktLR21sSU43eDhuRjZWdDdoS2hHVDcvMjArd3RZaTBSWXRmVzJTSGNR?=
 =?utf-8?B?T1EzWlVHRENTc3BwSVdmZHlpdzVJODVteHhpN0JzWTUwMWVKYXdrQ0JZdUJX?=
 =?utf-8?B?eTdMeTJMcStqQlhDaDhaQUZJcE1kdnhzeXpqMmYvUVJtTW5sSFE5aVpTajQw?=
 =?utf-8?B?QnZNQko4RVloZ3R4M3FuMXhYcldNUkZGWk5IdGZrRmVPdHlRZVdacGF6YVg3?=
 =?utf-8?B?OWw1UEJqSHEvM2Z4aW80cXJnVFJhRXVhMEM5Q3MzblN1WjB5MFQ3ZTZRekRs?=
 =?utf-8?B?TGhZOHJ6Z3VJaW5QNjZRc2dzajc4Z2d5cXJGZ1lSenM3Znc2d2hOL3pkeW44?=
 =?utf-8?B?NTlxNDV4a2NBRWd6c3F6SExmZHQxTzJKaDk2bWxHUWFQVHBYVVJhZFlmc21G?=
 =?utf-8?B?Lzk3UXJhMC81WFVuUUx5RTc3Z0QyZmVsZWZCb3NkbTA4SGd1SnRLSUYwdkdZ?=
 =?utf-8?B?YlJSR1c0YXg0MTRoejNTbW9QbmlqTHUzN0xVK3FmaTNiQUVxK2d6RG1oRHJK?=
 =?utf-8?B?VWI1K3k3Zml4NC9wTzBjZ0FJczN6WWtTUFpTaERvSmpaUGgwbU8yWDQ1WFJu?=
 =?utf-8?B?UDFVdHlwU1k0bitxbmZHQ28rKzJQSzM1cDJYMEVvbTB2d2JUQTZROHdaZnBl?=
 =?utf-8?B?cGRDVitYYUFDRkxSOEdFQzhTVGtDdGZaL3pYRDBmN0duaGFLaHZvdGgybUtO?=
 =?utf-8?B?YTMwdDQxUVFuK2NVMnIreWc5Wmc4N3BFYTQ4TStQTmhZb3RtOW1WYkdGOXV0?=
 =?utf-8?B?VERFOUlHSExNblN4WUFGQnZmWFJ1ekhWVWxVcjhWVS9FaTg4ZkJrSFQzWXYz?=
 =?utf-8?B?KzN5aVNpTEJPWmxIU2hiVUx3NHUxY1p1RGtkZzgweE1GZDRsTjBENmRNYWhl?=
 =?utf-8?B?WlJQd3lUeVRlYTdvNnl6V3dTaGpYK2FmK1BEYTRCd3FVQ29nZkFXUjAzbkNF?=
 =?utf-8?B?UFg5T2hXMTlkdW9NNnJxMVJZTkI1NzJ2NWJuZmxsLy9XWStEekgzdzZybFZV?=
 =?utf-8?B?VE9sSUZRNVBBV3VoVzZ4cEpkZ2ptY0JBQlZKUnZEM2s2Y1htejVGZVNURGQw?=
 =?utf-8?B?NDEzSktCN3dOQ1pid21WZ0pjYzgrRFg4ekFlUXJaekp5UVdQQk1YTTd2dUJP?=
 =?utf-8?B?dTRSczdXN21BOUtHQXVnOXhZZFVSNk9xU2lhY3NpQ1FyL0hKbW80YWFkSWFR?=
 =?utf-8?B?bFlldnYvZUVrblBlMHp2ZGcyNi93bmZPTWhPd1ZXdEMyU3k4NmlZak8yaFRl?=
 =?utf-8?Q?m6HD81gb3YsRfwCEmIRdqVs57?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbea8871-1764-4fe7-1ec8-08dc6859d35e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:36:58.8252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wc26LCM4mpz5gIRT1xJehCNpOe1a1bmTXd7TGofH0pgizGSh1zGBiSsDl1m7Cjj1A0/SAD1YUoHzy6g4pSQdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794

On 4/29/2024 9:40 AM, Borislav Petkov wrote:
> On Thu, Apr 04, 2024 at 10:13:52AM -0500, Yazen Ghannam wrote:
>> @@ -787,6 +793,8 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
>>  			mce_log(&m);
>>  
>>  clear_it:
>> +		vendor_handle_error(&m);
> 
> Wait, whaaat?
> 
> The normal polling happens periodically (each 5 mins) and you want to
> reset the thresholding blocks each 5 mins?
> 
> And the code has there now:
> 
> static void reset_block(struct threshold_block *block)
> {
> 
> ...
> 
>         /* Reset threshold block after logging error. */
>         memset(&tr, 0, sizeof(tr));
>         tr.b = block;
>         threshold_restart_bank(&tr);
> }
> 
> but no error has been logged.
> 
> Frankly, I don't see the point for this part: polling all banks on
> a thresholding interrupt makes sense. But this resetting from within the
> polling doesn't make any sense.
> 
> Especially if that polling interval is user-controllable.
> 
> Thx.
> 

The reset only happens on a threshold overflow event. There's a check above.

	if (!(high & MASK_OVERFLOW_HI))
                return;

Basically, all the cases in vendor_handle_error() would be conditional.

Related to this, I've been thinking that banks with thresholding enabled
should be removed from the list of polling banks. This is done on Intel but
not on AMD.

I wanted to give it more thought, because I think folks have come to expect
polling and thresholding to be independent on AMD.

Thanks,
Yazen

