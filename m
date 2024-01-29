Return-Path: <linux-kernel+bounces-42983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78428409A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B9DB202F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6658E153BC9;
	Mon, 29 Jan 2024 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O/w8yhWS"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78327153519
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541493; cv=fail; b=XlQ3vF9Coi9Fn8wP29d8aIma/Uu8Gjz/G5pP2uI10JfguXAiq8lpXsJZGTJJqM2DFQjNV/AhQDoEgHdw4Uex7jK9cTcOqrRuhR3eAEZsn7RmpSMYFcV9QZchSif7HL9E/CC4RVwkj76p5HFm/w0TQQXemikjqKcWvWtsJaUvkek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541493; c=relaxed/simple;
	bh=E3KTvUpYUhLrcxqqGBpHkE4kzKo0p0oGUb2x4zBV68w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GDh6Tx76bincyv3Qe2LHyUfWnk6PPhuyHkm1/j8Ynikwzzpt7xU7rjCleFzpXe/RN8jcNHpG6XuS8EZlQFSKB1tVwp9h0sJ/Eqe3B6wOd+Lsq/MgBXs4aULQ8n2mlA+Jq5MYdXYTOg4ARyKcZ2MzyktcXpK6se2xdj7ahtZ7swo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O/w8yhWS; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkzcRuLF8wCLtaYaCaLhfZsWIyvUjKY2tmDPDs2AAyyRL1aKvahqqVErhndDVK7lgXVXL/iIka3yYCG4/yv+WeO7OyIdCp2kwDpcqOmHIiVMf/ZpHMoTXWFKcN3CsTs6afkvpA2PyCVa6qqXGhkYyBhbJOh3O/nzt0JPbJqvd4+FdntsMf46+JvmlQbw0qYXZDCuWriEPzZlLtTJXYl82oW7zQ5rkWI46M6E3WUbMUFcCDtIC42dGsM3CRTuA8FfGkC0nRketCkRkaKLhtP6fBY9tuTyaOgfv374+bVviuejiqF/IusLHlETwYXPgRYRrGnt8EMWA2vmW8fuKiLqTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHBPKz6ZIkyLrVnPTq9MrQEG4dNZ5Lpe/lTSAVrhgvg=;
 b=V15B2gTBRApfo9YFFdPshByjEVY1GLQIre4hfEFrNDFBioyCj7eHuPj02sDo5VTWw1YXJnsWKBPmIja5/wMNQeDzcdzPEE8RANPmi3ZGZiBgcPSQP2MVWD1pABJzZikZMDCiTmXuqyvmLPZHByLWXu9uU4PeDdQIFgZqeRvSG9Dhw0DDQWBZEfydug4UsDAWYOa0shvaipgLZt2xFZbShhku9r1//TF4MecTzolSKIM5pVVE5562JpdFrVK6GJnuh+i1FgqSIYLOmitCKH11JRHY5erItzvKRrTcyRIXclaNPuQTP1Oql34PbA0CGE1Z0xKPb5l2F9tyTxVfklUaMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHBPKz6ZIkyLrVnPTq9MrQEG4dNZ5Lpe/lTSAVrhgvg=;
 b=O/w8yhWSLp51YUgsYI36QpYYi3LmHURwnoDIMfSYAtSPXliYF8A1zAw/4iSQpNfx9ylwrpxbjjdyedc3UhCrRT9qXOZWjdrPUypXpB/DAk411ht9pzf0XtTW10pk+nfbPRLItN68rkvBBVPHNuesN3aJ3cGd52N2dx8Swy+RGM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 15:18:05 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 15:18:04 +0000
Message-ID: <1a3502d6-98e3-463c-8923-28217b5e64a0@amd.com>
Date: Mon, 29 Jan 2024 09:18:01 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] x86/sev: Provide SVSM discovery support
Content-Language: en-US
To: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
 <2518c82f24f3e5d7533eea72512cea9ce985704b.1706307364.git.thomas.lendacky@amd.com>
 <20240129104125.GA20729@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 xsFNBFaNZYkBEADxg5OW/ajpUG7zgnUQPsMqWPjeAxtu4YH3lCUjWWcbUgc2qDGAijsLTFv1
 kEbaJdblwYs28z3chM7QkfCGMSM29JWR1fSwPH18WyAA84YtxfPD8bfb1Exwo0CRw1RLRScn
 6aJhsZJFLKyVeaPO1eequEsFQurRhLyAfgaH9iazmOVZZmxsGiNRJkQv4YnM2rZYi+4vWnxN
 1ebHf4S1puN0xzQsULhG3rUyV2uIsqBFtlxZ8/r9MwOJ2mvyTXHzHdJBViOalZAUo7VFt3Fb
 aNkR5OR65eTL0ViQiRgFfPDBgkFCSlaxZvc7qSOcrhol160bK87qn0SbYLfplwiXZY/b/+ez
 0zBtIt+uhZJ38HnOLWdda/8kuLX3qhGL5aNz1AeqcE5TW4D8v9ndYeAXFhQI7kbOhr0ruUpA
 udREH98EmVJsADuq0RBcIEkojnme4wVDoFt1EG93YOnqMuif76YGEl3iv9tYcESEeLNruDN6
 LDbE8blkR3151tdg8IkgREJ+dK+q0p9UsGfdd+H7pni6Jjcxz8mjKCx6wAuzvArA0Ciq+Scg
 hfIgoiYQegZjh2vF2lCUzWWatXJoy7IzeAB5LDl/E9vz72cVD8CwQZoEx4PCsHslVpW6A/6U
 NRAz6ShU77jkoYoI4hoGC7qZcwy84mmJqRygFnb8dOjHI1KxqQARAQABzSZUb20gTGVuZGFj
 a3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPsLBmQQTAQoAQwIbIwcLCQgHAwIBBhUIAgkK
 CwQWAgMBAh4BAheAAhkBFiEE3Vil58OMFCw3iBv13v+a5E8wTVMFAmWDAegFCRKq1F8ACgkQ
 3v+a5E8wTVOG3xAAlLuT7f6oj+Wud8dbYCeZhEX6OLfyXpZgvFoxDu62OLGxwVGX3j5SMk0w
 IXiJRjde3pW+Rf1QWi/rbHoaIjbjmSGXvwGw3Gikj/FWb02cqTIOxSdqf7fYJGVzl2dfsAuj
 aW1Aqt61VhuKEoHzIj8hAanlwg2PW+MpB2iQ9F8Z6UShjx1PZ1rVsDAZ6JdJiG1G/UBJGHmV
 kS1G70ZqrqhA/HZ+nHgDoUXNqtZEBc9cZA9OGNWGuP9ao9b+bkyBqnn5Nj+n4jizT0gNMwVQ
 h5ZYwW/T6MjA9cchOEWXxYlcsaBstW7H7RZCjz4vlH4HgGRRIpmgz29Ezg78ffBj2q+eBe01
 7AuNwla7igb0mk2GdwbygunAH1lGA6CTPBlvt4JMBrtretK1a4guruUL9EiFV2xt6ls7/YXP
 3/LJl9iPk8eP44RlNHudPS9sp7BiqdrzkrG1CCMBE67mf1QWaRFTUDPiIIhrazpmEtEjFLqP
 r0P7OC7mH/yWQHvBc1S8n+WoiPjM/HPKRQ4qGX1T2IKW6VJ/f+cccDTzjsrIXTUdW5OSKvCG
 6p1EFFxSHqxTuk3CQ8TSzs0ShaSZnqO1LBU7bMMB1blHy9msrzx7QCLTw6zBfP+TpPANmfVJ
 mHJcT3FRPk+9MrnvCMYmlJ95/5EIuA1nlqezimrwCdc5Y5qGBbbOwU0EVo1liQEQAL7ybY01
 hvEg6pOh2G1Q+/ZWmyii8xhQ0sPjvEXWb5MWvIh7RxD9V5Zv144EtbIABtR0Tws7xDObe7bb
 r9nlSxZPur+JDsFmtywgkd778G0nDt3i7szqzcQPOcR03U7XPDTBJXDpNwVV+L8xvx5gsr2I
 bhiBQd9iX8kap5k3I6wfBSZm1ZgWGQb2mbiuqODPzfzNdKr/MCtxWEsWOAf/ClFcyr+c/Eh2
 +gXgC5Keh2ZIb/xO+1CrTC3Sg9l9Hs5DG3CplCbVKWmaL1y7mdCiSt2b/dXE0K1nJR9ZyRGO
 lfwZw1aFPHT+Ay5p6rZGzadvu7ypBoTwp62R1o456js7CyIg81O61ojiDXLUGxZN/BEYNDC9
 n9q1PyfMrD42LtvOP6ZRtBeSPEH5G/5pIt4FVit0Y4wTrpG7mjBM06kHd6V+pflB8GRxTq5M
 7mzLFjILUl9/BJjzYBzesspbeoT/G7e5JqbiLWXFYOeg6XJ/iOCMLdd9RL46JXYJsBZnjZD8
 Rn6KVO7pqs5J9K/nJDVyCdf8JnYD5Rq6OOmgP/zDnbSUSOZWrHQWQ8v3Ef665jpoXNq+Zyob
 pfbeihuWfBhprWUk0P/m+cnR2qeE4yXYl4qCcWAkRyGRu2zgIwXAOXCHTqy9TW10LGq1+04+
 LmJHwpAABSLtr7Jgh4erWXi9mFoRABEBAAHCwXwEGAEKACYCGwwWIQTdWKXnw4wULDeIG/Xe
 /5rkTzBNUwUCZYMCBQUJEqrUfAAKCRDe/5rkTzBNU7pAD/9MUrEGaaiZkyPSs/5Ax6PNmolD
 h0+Q8Sl4Hwve42Kjky2GYXTjxW8vP9pxtk+OAN5wrbktZb3HE61TyyniPQ5V37jto8mgdslC
 zZsMMm2WIm9hvNEvTk/GW+hEvKmgUS5J6z+R5mXOeP/vX8IJNpiWsc7X1NlJghFq3A6Qas49
 CT81ua7/EujW17odx5XPXyTfpPs+/dq/3eR3tJ06DNxnQfh7FdyveWWpxb/S2IhWRTI+eGVD
 ah54YVJcD6lUdyYB/D4Byu4HVrDtvVGUS1diRUOtDP2dBJybc7sZWaIXotfkUkZDzIM2m95K
 oczeBoBdOQtoHTJsFRqOfC9x4S+zd0hXklViBNQb97ZXoHtOyrGSiUCNXTHmG+4Rs7Oo0Dh1
 UUlukWFxh5vFKSjr4uVuYk7mcx80rAheB9sz7zRWyBfTqCinTrgqG6HndNa0oTcqNI9mDjJr
 NdQdtvYxECabwtPaShqnRIE7HhQPu8Xr9adirnDw1Wruafmyxnn5W3rhJy06etmP0pzL6frN
 y46PmDPicLjX/srgemvLtHoeVRplL9ATAkmQ7yxXc6wBSwf1BYs9gAiwXbU1vMod0AXXRBym
 0qhojoaSdRP5XTShfvOYdDozraaKx5Wx8X+oZvvjbbHhHGPL2seq97fp3nZ9h8TIQXRhO+aY
 vFkWitqCJg==
In-Reply-To: <20240129104125.GA20729@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::17) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: c93cd8b7-6574-490c-418f-08dc20dd7d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w9ARxetw6+hg65E4av57duzIR0oBcFFANXJ1pmzxqYnmPjJVdBNhuaRYLFJmf7ODpu/VUD4ufqzVGtf5QC2XIcgkLZWBUFFpMbtAxzvnjHrOoJ5kuWQm3fmIApsE3BT4e9j3i5s+2PByNSW2XuoaEsBFnTwcBvBgeBCvqs3keni9bh6AN55bOBCdebtZA/7ngC6/qmNqmmtwdouuSOeAe134kVbk4iAUzTWywaLBoWvQUreYcXCOIaYh3B3LL+Tbo29DzbO0N+orUx6YRYo6Y0CfeA85m6TatBvys9umK8P8fMEdD6BKKafcQiru+sFqgFTNyqEEs4AtqpGRGQZgvpNMC+BDlxmPnxOjbT+bCX5C2Hfag4eKEotIREcvboLHGH1HgEhEXB2rEtBM9WtgJxKfEGiEbAZsCV9h27SaHJvJyja2bdrWUwFwhMvBiPxOF4FWi+iN2ahHpwdDdvxxhsHQ8Tiz0LiDq06NYAxNQ4NzmAoUWYMU6sdHWYJ1yIXPAzOsyEF/4f8fUrcKPr6CI1MrdO/aYj0KVch4wqiERmRBIZGBleEmnfbgBXyObWhXWfLXZkVql0IDMFlFPKLYPMdamSqm5SBO4tcqvFJ8D2wN5YjK3KzLRdds+osqZZQXr7cmX5DnDLc9QHtmaQHEQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(136003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6666004)(26005)(83380400001)(6512007)(6506007)(53546011)(2616005)(66946007)(478600001)(38100700002)(7416002)(8936002)(5660300002)(4326008)(8676002)(41300700001)(2906002)(6486002)(316002)(66556008)(54906003)(66476007)(6916009)(31696002)(36756003)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2tlNWRIWU1xNGZlOVErek1sT0tvd29KR0pZa2RUcjdhY3R1MVhYaFdLZUlZ?=
 =?utf-8?B?MUpVV3V5YUNna014K3VXdmJWU3JISlMrRlgyVVdxVTlqa3VsZ3d4eGcwRnV6?=
 =?utf-8?B?RVJpNXU0Ti9KM2pXYkdXcUVyZWU4ZWZITFZ3d3BIdFBpdmNVd0dnTm81ZWZy?=
 =?utf-8?B?Z0pyTW83UFhzdlB0NkZ2M2RSK25sZVdPbW41N2JvQ1VSSWxzZTV3QmN1ZXdx?=
 =?utf-8?B?cm5qcFR3YzBpQjFSSkUxbzB1VGVYc0I0R2hDQzRLK1RSR3JIcUFFdytraU94?=
 =?utf-8?B?ckRZdnN2TVJ2c28zRlBPTDdTd0NQdTJMM1BPTXFTNTUxOHBwWmg2bjVqbitU?=
 =?utf-8?B?NjZPTEc2Nkp3N0Y3Ujd2NUZNZ2xGTFI1SHBGY0ttbHNyMW5BdG92RkN1eURs?=
 =?utf-8?B?dUZtZW4wQ1o5T25zZzJQMjVmOTRobDlLc0dNeWJacHJ3cXYvSThGQStTTG5x?=
 =?utf-8?B?NWs5c1N3S3ZYNjFUVGJmTmNLczZ6TkZsSUk3RGlPZDdrQ0ZRdUJlanl0dW42?=
 =?utf-8?B?YkFQYzNQaUNFSVZpWWVGelhXVWoySExmcTI5SVJXRXdsTDU3UDYyWHJobHZj?=
 =?utf-8?B?WmIxcG1nNHp3UjcxUjRub2dzbU1BaHVQaTBuRlFKeGFVRWp1R2srN0UrVVBH?=
 =?utf-8?B?K09uK2lmV1lzTllzdnA3WmRnMGhmWndwMXRYTjYrZXFRS0ZwZnIwZkxpZjl0?=
 =?utf-8?B?eEZ5OGhvMDU4ZEMvWThHZW5iZk9Qbkh3VHBUTHB0TVBndDlGMHRSMHk5WnBX?=
 =?utf-8?B?UGRyZU1LUHVXN0s4MXJDOGxybWJXQ1VMenoyVnRrMHVNYmJkcGpUcWZDNXpV?=
 =?utf-8?B?VVNTS0dCcFVZUkxTSWhnME9TODJ6T20wSDZDbTFGVlFCakVveURwOXY1UzRB?=
 =?utf-8?B?R01hc2s3NnJtZGlSV3F5UnRWdE5RNmZzd1M4K1U3cVR1L0FrU2NESStSM3VN?=
 =?utf-8?B?bWpQZ1hDZUZPYzVaNnJnR0t5OEFhckc4ZTFGYU1hcmZkU083UnJRMVllWmxV?=
 =?utf-8?B?V0VjblBtUU5BYXNIeHo4TG1sNlNsdlpYUFpDeHRFMjlHK292WHdNTktzNzMz?=
 =?utf-8?B?ZytZbTdvMmZUVWthTEZjTWgvS2RnUzhsaWtQZkxVT0pBc25hd25JMFVEVkNr?=
 =?utf-8?B?SG5SMkZoa0tGV1piWEpWZ3kra0taT0JxTmlTYXNJaksyYmFyUG1MZ25tVkp6?=
 =?utf-8?B?V0gzZjBFSzFDMFM3V2NkYUhPTmhldHJFTlNCQ2hoNU1GYmp3U0dIV2FmS251?=
 =?utf-8?B?S1JDZlFHekFYZE9BeFhqSXJlZjdwU1NUYWhHODlGQy9GNjdnZU1PVlhDS0Ja?=
 =?utf-8?B?QUZIK25mRWVFSXMvYkhZOGpobEV2UmwxN1BnaFE4aG9UdGNtRGo3dm82OXJE?=
 =?utf-8?B?aElGNVJoUVc2cjlFaEg2WEdSUTlKR0pyZnVlNUhmNk9yUVVDY3dqOU1nMnpE?=
 =?utf-8?B?cEJMWkFDUy9sSVJPR3NkdjU2a3FEclljMGd6Y1FtUE9VT1BQMFdhT0drNklq?=
 =?utf-8?B?VmZLVkE2QTNDbkpFSnVKaGFGN1RqaVNOR3ZMOGlTL0lMN0VGTTkxOHBmUVJR?=
 =?utf-8?B?ckl4Z0xZRFJWNFc3TUFUZFNJT0hIc1QzcU91SHhwT1Z4NDFwamhmMFpqaWFK?=
 =?utf-8?B?cG9BVnJzS21KRTFUdlJLS0VvV21RS2kzbkgwU1BjTjcwdXJhZU5keGhZS1FE?=
 =?utf-8?B?enBOYVlWNktzRHVhZmJ0Z1VxWXRSWVpuN1l5WXB1NUNzZDVyZlE5b1lmQWFK?=
 =?utf-8?B?czZRNXNrYnI2ZlZNMFQ1d0Rod25rWFp6ampVb1IvbVB1S1BsSjl1cml1RFVI?=
 =?utf-8?B?bDA4bWpGcTJYbldySjlHZFRoUE1NQjV5VUk5YWpzUnA2NTJTRFJTTnNDZUFT?=
 =?utf-8?B?ejZIMFZqbkZqWm1BTE1nMTY1VnMzbFZoK0I2aXlrYXdqM3B1UW12Yk1YOFVP?=
 =?utf-8?B?NmFCL2c1RSs1NTFmSkNhcGZHaG5mUDIrNHloR0pad0l0ejlKa3hDanVYenli?=
 =?utf-8?B?M0Y5ZjhtdU0zTlF5MG41eGdLU05lNGp2ZXk5VjN5S1Z0TTFhSVdFRllCNGFr?=
 =?utf-8?B?Q2REZXlWNG9TaGZNQ3dpRXNTb1lCNmZkQlNJR2QvT005Ym04K1U4VlhTdTBC?=
 =?utf-8?Q?o4qHW5VMr5KSlH58MeQ4JoELk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93cd8b7-6574-490c-418f-08dc20dd7d4a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 15:18:04.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ToiPmaT/oHoQR/kxctQh5xFOT0e9jpxMaxaYvLtC/p1nl0f2hBfsBRw1FAZvvADfXqu5Wi5KzB1KTBOB2zk/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726

On 1/29/24 04:41, Jeremi Piotrowski wrote:
> On Fri, Jan 26, 2024 at 04:16:00PM -0600, Tom Lendacky wrote:
>> The SVSM specification documents an alternative method of discovery for
>> the SVSM using a reserved CPUID bit and a reserved MSR.
>>
>> For the CPUID support, the #VC handler of an SEV-SNP guest should modify
>> the returned value in the EAX register for the 0x8000001f CPUID function
>> by setting bit 28 when an SVSM is present.
>>
> 
> It seems awkward that the guest would have to set the bit in the CPUID response
> itself. Is there no way for the SVSM to fixup the CPUID page contents, or the
> CPUID instruction return?

It's possible for the SVSM to update the CPUID information provided to the 
guest, but it hasn't been specifically called out as a requirement in the 
SVSM spec. That is why snp_cpuid_postprocess() is used to ensure that the 
bit is set. But, yes, we could update the CPUID information in the CPUID 
page directly instead of the snp_cpuid_postprocess() change.

I'll look into that and see what it takes.

> 
> Could you also add a definition for the feature to arch/x86/include/asm/cpufeatures.h.

Yes, I missed that, will add it.

Thanks,
Tom

> 
>> For the MSR support, new reserved MSR 0xc001f000 has been defined. A #VC
>> should be generated when accessing this MSR. The #VC handler is expected
>> to ignore writes to this MSR and return the physical calling area address
>> (CAA) on reads of this MSR.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   arch/x86/include/asm/msr-index.h |  2 ++
>>   arch/x86/kernel/sev-shared.c     |  4 ++++
>>   arch/x86/kernel/sev.c            | 17 +++++++++++++++++
>>   3 files changed, 23 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index f1bd7b91b3c6..4746135cbe21 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -622,6 +622,8 @@
>>   
>>   #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
>>   
>> +#define MSR_SVSM_CAA			0xc001f000
>> +
>>   /* AMD Collaborative Processor Performance Control MSRs */
>>   #define MSR_AMD_CPPC_CAP1		0xc00102b0
>>   #define MSR_AMD_CPPC_ENABLE		0xc00102b1
>> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
>> index f26e872bc5d0..9bd7d7e75b31 100644
>> --- a/arch/x86/kernel/sev-shared.c
>> +++ b/arch/x86/kernel/sev-shared.c
>> @@ -628,6 +628,10 @@ static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
>>   		/* node ID */
>>   		leaf->ecx = (leaf->ecx & GENMASK(31, 8)) | (leaf_hv.ecx & GENMASK(7, 0));
>>   		break;
>> +	case 0x8000001f:
>> +		if (vmpl)
>> +			leaf->eax |= BIT(28);
>> +		break;
>>   	default:
>>   		/* No fix-ups needed, use values as-is. */
>>   		break;

