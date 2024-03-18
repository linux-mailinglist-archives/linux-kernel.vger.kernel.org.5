Return-Path: <linux-kernel+bounces-106016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0687E87E794
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270EC1C20AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0117A2E644;
	Mon, 18 Mar 2024 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CKL7TqUx"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6C72206B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710758662; cv=fail; b=WqzFHmTJujmEvGsj1KqIDHgskcea/K2ASU8u+ZGnxwmN3za76uWfTAGcUe5xveUa3j6ajpUBzkuCNqGVXdKDXutH31gcsHFntxWj4Hiw8WhWoPhsi2gxYI68QPhlLVvw0hyEQVs6CXQMII4cFalUc4ilqM0eGXpfW6dn/cNEBaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710758662; c=relaxed/simple;
	bh=F4YwaoZQ6/WPbYlCM6OYzPIO/LM928buSLw8V2cIOCA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pn535LmSqQ+P4d3gaauCTFnIuknQ2jdOSaljnbuCLlLtvIdrw+9Q5irannIGTF4niifhkCHTqeY3RjFefaJn4PHR/MrXQqeOPT/HWSKm2NSliIiZ35mfGXHQQFKLisiRbJm+5V8pe7kBORIVtrqgf1QZTUViYhDefQV3E01wvAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CKL7TqUx; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLDgSLUT+aurUO0IJJHb/2IwU1TQBCou9eeTp+AEQY/JASYanjik7iyhlQLv+4na5103NxFQQHRZhiBFA8tJhes3OHeETExiXerayx7HosclxvX32ckzr7G62RP/GA7IGq86m6OZumqtigbv/pYMJWY6tpnbtQcELTuQML+1cquUSlQpAvKbdbCuZj1PcTAFf/lpO7AROS46/xcAfVOnF61fbRf7gcxb0/PtgmtKEXSU3Z8RpCr+s4NXGeXU5zsCQy1iXmjiCFOQVrzwmbBlh641PKyzcJOlSBtj57bx0qFgZqk4MA+FQTONp02B40bqQ3vVZ0HBLeSg+/DoeM1vrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvM+smfL+o6+uJrvwXf6r10zsNW57CHeFzpfaDrD0t4=;
 b=H15skXTX6BepzE5zqx8wXOvI/et1YGuphTY8i2LtyA0hWMmSIZb7gCjtnJHF2v7+3ldZlcK32/c4b6CxVFsQNenoY/Nr03vxzM1g9kPIHE3QxbLvz5dV8LcGX92i4D7NpSF4+K4Cvs6A7YD+EXu3MpnUbbzHMfzfObq/yJOc5AFTUQETf96ncaHt2R2DGY0EAoGg0rzSut6qWpcL4pKZFxKLB8zhH4NrLX1z0kFNxy3IpaX6ziDRxAvpd9KYQcbByQxOvXhdZpIy1LygRmL7yJV3iLfjNtAxw74hd8v/RD93LVPHBGiv/PPNRsg+PjmYE5r3g6XPymEBmt101bdzPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvM+smfL+o6+uJrvwXf6r10zsNW57CHeFzpfaDrD0t4=;
 b=CKL7TqUxYxMQ5uBBh7Lp80v/ZyFocUrDrUpZqNbuVxEt1NwPV8rlmmuk0ta/bNrMjs032VrvMFYAwdTN3KMtK8yh4iqVzAw8tgGZS6STDAR+BYz2QLxKzEQHdU+oU1QYSqqhYhEcacmVX9ebdD+4ONIo+FUkSCP8fLq6xeyb6qU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA1PR12MB8239.namprd12.prod.outlook.com (2603:10b6:208:3f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 10:44:17 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::ee44:e235:d5d7:94a1]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::ee44:e235:d5d7:94a1%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 10:44:17 +0000
Message-ID: <6b0c6f19-b054-0ffe-ad45-776b2f7c441f@amd.com>
Date: Mon, 18 Mar 2024 16:14:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH] perf/amd/ibs: provide weights for all IBS op samples
To: Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, namhyung@kernel.org, irogers@google.com,
 sandipan.das@amd.com, ananth.narayan@amd.com, Ingo Molnar
 <mingo@redhat.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20240313175453.433166-1-eranian@google.com>
Content-Language: en-US
In-Reply-To: <20240313175453.433166-1-eranian@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::33) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA1PR12MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: d61ea95f-e529-4e40-4073-08dc47385be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zMtsRTWl2tX/5yZVACvihVKUW382wdU/wdaWUZDQGvTlyKIBbUrwnXrGEAf1cm+aUGAPk+txBvvfp9NlC8byiMQluwraCzfASuBg/KpSOdmFYVdjE7a5q1cP7UrPKdRH3ZSNfReUMK3mqiWo3J5gfrTcdM6hOIgDA2SSO9qK61dJByXGx547I7E60+vUUzfM1hwBkdJVtXknnsiu9kctz9Rskk5KERDMh+lLRW7hRE5tG8gjimhh2wLIEfy9G38uFTn6I2387fNL+uO5hUMXxvdNLgWRgYhaGZNmKDf5ibbacxmqhuDEjOyoRRBwMUIf6updH6+PfFLc+tPET4G7aIBDgAu+aZ15jqauoiSwimPouCsNAuv4O7zOo1ZnXiendkfjNLqPT88bGt1eYhML5paVZ2NUxMRLCLXOD7WnJJB9POXqUMNOGKJ7o3KcVVazP1DLhU84N1M4EXHYMkQod7KPSuQ2AaabkBDlIT+HlLFOPhm9iyAFOY30NpFfblzs3N6zemPH4HvBozk3P3PuJeGxJ3fmL/qSRfkAtkVGV32haRUjrNt4kHgfbZ+8XIIjQK5n0u81bUktLynJhxOBxLlSVNOuFFBQ7oZaVcYsd9W9ntBEBZEmjtgICRFKgxmzUhG2i1XA/CUTGXmmbgbBiw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWhmY2tOQklRWk02VlBIWjY5aUFXTFhkeVdLTHdYSzBBcWlIMWlCNFFCUFIz?=
 =?utf-8?B?R0w0ck5QL0NWdGdXN2JWNGJUdTFiOVlHZXAzcnpwaFN5M09ldHZSTmV6dzRT?=
 =?utf-8?B?OGI3eEhpMUNOc0hUYXprUVJjbk9kL0VVSlVzTUtiV3R3bmZlRGdva1VQT0I0?=
 =?utf-8?B?dXMwTFg5YkhUYzFHS2FSemFjeW54b0dUVTRqVGpoY01JbWIrR3JEUkpGcFpj?=
 =?utf-8?B?YkNmTzR4eFA4UmVkRzdad05yUjZmQ2s2UitOZU9IZlFaYzgvYkRMbkxPRUVC?=
 =?utf-8?B?dmZOWnVGdTQrSWU4b0xuM3V3S1VhTk56b1Z1a3BIN2JFR1U4OHNCeHlzWWJS?=
 =?utf-8?B?TWxNczA2OXhWN3hPNU1UaVllZTl6R01GSFNOb1BEY09JQmlTMmEzekpGc2pv?=
 =?utf-8?B?YnYrTEd1S3RLR1lTUTZ3UHdMUFhUaXJRc0hva1hkVHFjRGsydnlQZ1RtVjdl?=
 =?utf-8?B?TDBhWXUxU1ZyaWg1eVZjQytiL3lsczBkZC9aenE1VjhHZ2U2UDQvenVmYVl1?=
 =?utf-8?B?MG5kdDQvQkwrYTk0ellLNE1KQjI0eXVkWHBRZC9IbDc3QnM5VGR0SXFtMlhh?=
 =?utf-8?B?N1FDT2JBeUxUeGF1bTNBWVpBbWZybEt2Y3VhK3ZuS0licm56YWRUdEFBazlm?=
 =?utf-8?B?WllabkFsSEg2Y3UwOTJyWVdhUDRmaHprVzZTUjFpNTdNNTg3T0duaEM2QUh3?=
 =?utf-8?B?d0tZaUN1Wi9EN1hXK09DK2Q0Nng2Tm1FbmFJTFFrMVo1VmhNeGZoNmpSV3NM?=
 =?utf-8?B?aU41ZXJEa2ZyVGRSR25HdytGYjlkZkJJKzlMNWRQNFlPdE1LTE9Gd2NEVUZI?=
 =?utf-8?B?NjdVVWpPRnRKNHQ1NWhMdi91WEVybG9rRGZHdFc4S1Uzdm1vWlIxV00zRUpY?=
 =?utf-8?B?RFpjT1ZQclJyWUE1T1RwNHJML2FhUTBNNDJUZ2RYNlFsbC8yempIZUF4a1FI?=
 =?utf-8?B?SXduQy9rSzlNOUFpQS9qdmNvTlllakZvbFdsUVZ5RE0wUDM1NFpVSVR5LzdE?=
 =?utf-8?B?TG1KWHRoWmVMdEt5QjQxK1MxbGRMZW9RR2J5cFIvLzBuSW8wRTY5K1duQi8x?=
 =?utf-8?B?eVVZZklRNVNyOFJacmdoMXo0VHk4SENHbkU1TjF1Ym8zZ1R6eVozNjhuSkY4?=
 =?utf-8?B?SW1ER3NHeXVJTTlMcTAzNTNUSlBIT0lIMVNoVU5iQms4MkxpQWxRTmwyWlcx?=
 =?utf-8?B?bnpMdVpjUytSSnYwSWkwZUVZQkZhSDZyN0EwbFUwWUE1cUh1MEFFb1dQckJC?=
 =?utf-8?B?YlVVRlhSZFlISlhwVE41bEdoUTRhOFA4SEhMZHlCSEg5dVpKZkpONHgvcVBL?=
 =?utf-8?B?NlVLa0JLM0JicFF0TUorc3ZVOTArQThrWXViY0dEdTNHV3dqV0xueWltOERZ?=
 =?utf-8?B?UWxhRmlTY1NCOWtBVG53SWl0YSt5Z1hrczdBbFhTT2g3Z05LalJ3Y2tFZEZT?=
 =?utf-8?B?dVNVNkZrUmZRbndBa3hGNWJaNXJxSHp0RS9obmVyWlRuOUxkSWg0Ykk0Q0sw?=
 =?utf-8?B?b0NWNSthM2Y0OVhiWjBFbzdBa1RXbllTSjNRQ0pVTnprd3ZoUXpHbXhOY3Fv?=
 =?utf-8?B?eGpFQTdxNS93R0VaTzhuOTNJYlVic29XM3RzVkxWeENmcDY4NGJsd1dOcWdU?=
 =?utf-8?B?NGxJZHFid3YrdndIK1piNHhiVWx5RmVzOWtDVXN0S1VERnFpSTBiOUkydEs0?=
 =?utf-8?B?YnllSlhuU3RUOGhqWmc0STRreHg0V1pTZnhMQUZOQzNkM2I2bXh0RDdwbjhC?=
 =?utf-8?B?YTVOWUp2eEM2YUZwWE9VUXlWQm1GWVZLY3pVYVlid0FpODUrRlJuRVVuckhv?=
 =?utf-8?B?dXVveGJENkRwRFFxZVB3czlVTW54SzFoR2g4YzU4NERETXBnV1EvVmMybWlG?=
 =?utf-8?B?QVYwMUJqN21UMGVNaC9qYWNkaGxRaFZ2N255Nnc5c3MxN3E2QVZzdXBnbVBz?=
 =?utf-8?B?SWRPVEh0bDJQMEk3Y1pjN0wzckxLeitVQ2lFQ3RUdVhPaHhnY1A1Z1RveVVE?=
 =?utf-8?B?dE1XVm1zWlN3cG4zVnZzVjJFU1IrRkFTcUdoeDJ6ZEduTHhMMWwyeWdTaEph?=
 =?utf-8?B?NzFEZXd6bHJrcExMejgxRTR4eGNsc1NwNTJLMlRqanJqeVFDLzdCc2hTb2V1?=
 =?utf-8?Q?IbwSu4YbpzrqS/V3dtQrSfsUb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61ea95f-e529-4e40-4073-08dc47385be6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 10:44:16.9113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLBVr7Dg9Ij/zWABg8Dw1CTSnl1HiDtCO8817TvFbQqZTT+IU/LZ3Vdas6YUlzBwQsAHyTEKAa4zI4jnfXU88g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8239

cc: +Ingo

On 13-Mar-24 11:24 PM, Stephane Eranian wrote:
> IBS Op provides instructions latencies for each uop sampled. The current
> code was only providing the weights only for loads. This is useful
> information for performance analysis. This patch modifies the logic to
> provide the weights for all uops.
> 
> $ perf record -a -W -c 100003 -e ibs_op/cnt_ctl=1/GH ....
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

