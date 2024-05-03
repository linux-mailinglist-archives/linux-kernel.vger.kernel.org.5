Return-Path: <linux-kernel+bounces-168200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68638BB504
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E56E284F0C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF08E2E85E;
	Fri,  3 May 2024 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0FcFr/yz"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC3423775;
	Fri,  3 May 2024 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714769074; cv=fail; b=Cj3dm1Wu0O9UIzE+15tSXn6iMPwpDqcFEDyn2doN9jbnp1RIf90b7bR/xs6zn5d5yaQwj51GQL8I+WULUbfnXICymsijx3x6foZjzd+xyuGw99y55pHVWPaxV8vHdrOsx8HwET4bC/rGnD2nEL+srLtABEtoQ+6Z2Ywo7F1l7tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714769074; c=relaxed/simple;
	bh=Au1PPopg+tkg9GzWVxIKn1PquAPVtnQkyw9HB82zPoU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l86tk0ixc0ASqoiE82CYN1QaN1WvKGBtKmd+xQlIqbz1dNI8c704ryop4pBFWqzA0tmejJBLlShlJOKFn8gLyNEdebCwALAfcEaikHKpRbbQgju9mDx6XdBUNccVx7HYlN9f5S4401wf2NQCMYW0yUNegUs576VW9G6Zx0dxbKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0FcFr/yz; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDbDkuijvEEF2Od4jlN9fyjhIRoiUvRi8CXHCGCPoVtgnH3QxQq3Xg7/RBx2DRP2P318LoMpkjTmbFxg9hN6jmfDQS6xilVfVIdmTv7sW+pye5RINKFBvcUyXypUML0Cdru6b9sRbwM3cWF6a8MzpHLzkakwp26iPy00cMbHvNrN4H1YbhgaMYMloftjgcTGeq3fymiI5C3mwhdJGioaa01QLjxGVRJdNKu1ZJPNTVjQ0V54425wJc64KjbKh0o0tgeIpXiICIJRWlFHr2YkL0XemS7wm18qCjImQ4knRIYLVSB7qp0CurRWUisQESqwdmepXKBV6YJ+L6u99j0Uew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIHoz+ORh95ARkzpIsKLNENDa4Y9U7Q8XIkNX/0NoaE=;
 b=EDsp3vm9Aixgi1dhqAxZeMrTBA7O7s7D/jBPV3IAdTzj6Ns9rinCH0gOHDYi/lyBzT+2VBJjl8+VXh1dN9Z2thK5MieojVZybSFvfc6YcaF3FZ2+KjMPmJKXY/VULg0WHusD8jsyCjqAeB8/cJ1Wn6amEgwdMh4VZvnHTpyJgH9woHPAoGySgODlfNGZlKdaIR65z35HK2AOOaMOlW1wTrjg8f9lbQ9LrwoepBmCabVkbU8QOcFP9Z2u6cgFAr7jThIybk8Fz1+E/ILCHY1+w74fiuPcfuqgpeqqrSKfOeGyI2p9rkFz5rppX6p1R+Z4MNgUg2EpyW6B2M++McNvfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIHoz+ORh95ARkzpIsKLNENDa4Y9U7Q8XIkNX/0NoaE=;
 b=0FcFr/yzTZWQGRAjoZ5YHaBgkScYrhPzm1B9/7osoP5TO/KtPXnyl5b+qi+TV/uIgSlQ3NelVYThBjav28x3k/2O1IScRzrSHhSsxMS8/lCnRJ/SENG7zYPgAeb33yxTr+VaQOaKmf1KVJ0/vrozuaXUw8fOlS2kRA0b6PnNmyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Fri, 3 May
 2024 20:44:27 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 20:44:24 +0000
Message-ID: <b725e4ca-8602-eb26-9d47-914526621f52@amd.com>
Date: Fri, 3 May 2024 15:44:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
Content-Language: en-US
To: Peter Newman <peternewman@google.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: babu.moger@amd.com, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1711674410.git.babu.moger@amd.com>
 <CALPaoCjZ3oLdKymJjASt0aqtd0GGOme7LavvYOtPYTb_rA-mYQ@mail.gmail.com>
 <b35dc4e9-7e8b-42ed-9a51-ae50d521cf4b@amd.com>
 <CALPaoChxYoJx8eR48EkSKf-hu2p2myQJLZEhj_Pq6O4R15-=5A@mail.gmail.com>
 <6edffe1b-e9a9-4995-8172-353efc189666@amd.com>
 <ab2a6a4b-3740-47c6-9443-e6bb7a0c1adb@intel.com>
 <CALPaoCiYFKeASPMDwzzaHLw4JiMtBB6DTyVPgt0Voe3c3Tav_A@mail.gmail.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <CALPaoCiYFKeASPMDwzzaHLw4JiMtBB6DTyVPgt0Voe3c3Tav_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0223.namprd04.prod.outlook.com
 (2603:10b6:806:127::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c4be7a-1191-4f52-ce2d-08dc6bb1d13f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlJlRk9ITytNK0xwWXU3QkE0aVUwM3BYRU1PMHNBZHNLNWRrOEtHUGZWMmVj?=
 =?utf-8?B?dXRVUTRIUm9NZDBDd3lWUTlRS2dZMHZhYkJFbkZzZWJRYUtqN0U5OGhmZTFt?=
 =?utf-8?B?eElIa1ozaXBRQ0RreHNvN29ONFhFWStZVGUzNjRSRVlEK0tCbHN5TGVsSWVM?=
 =?utf-8?B?emdNdWVtbkpPZlFPMGRVbEE1SXpIZTFNWWpFTmgyYWd4ODZqYlB3czJnMXo2?=
 =?utf-8?B?V1ZFbStwby82UUVNKzhVZW56eGpNY09PdEd0YnVPcTVUMCtRYm5LQWFXUzRx?=
 =?utf-8?B?MnhiYVlvTE9PR05KU0ZtMEx2UHBzSEFLOGZxK1hLZUZHUHdoc3NsN2syTWVn?=
 =?utf-8?B?eHk4WUo1SUowaklvOUYyY2tFR3FHZmtlakoyODRLNmx1dTVOdDdNbzJDUWV4?=
 =?utf-8?B?ZGdoVlovblE3cGh2Y1o2Q01hN2FFVWhKaW1NTEpzT3p5WWx4aW1tVHFhVWVm?=
 =?utf-8?B?Vm92SnlhcEttSFRzNUJkN1Ywa0NpVUoybEVkb1B4T081ai9XOVl2U2VnTDlD?=
 =?utf-8?B?UVpEQnc5QURtSTdaRGtYK2RFY01kWWxTdjNTMElxTzhWZGJUMlJPUnltNm1k?=
 =?utf-8?B?a2V0K2gxU0NaZkVGUDczV3pNbDhWYzdnNFkvUUtyazRCdDdNSytrZjN3d2x4?=
 =?utf-8?B?NUZxdFpDNUgyVmo0dnd1RTB3ZFVENXF4WUlqaElETmR1ZDR5WWJyUTVoRkxI?=
 =?utf-8?B?aHNyQW9HYTVZdGpVaElYNmtydm9nSFhBZjAyaWp4OVVCbFdPN3RqWEpYZmh0?=
 =?utf-8?B?citrODZFVTRMbWdrTklkU1FwY3FYM3NYZVlsb1lCK3pqVlJldk9IMTlLUlJs?=
 =?utf-8?B?dW1UQWxNZUNtNEQrQVdCcmJXNzBWL3BDWStIVVA0U1M1dmxUWWdSSUh0MjBr?=
 =?utf-8?B?ZDhzcHVSVCtEQXRvdXFtYmJaOHFkNEYxQXB4WkFNYjFQU3hZQUtYd1hKOFhT?=
 =?utf-8?B?eXhoOVZSd1ArcEpITTBxNk1nYWk4MU84ZFpHVU1idTZnSlF5aXlvV2FqSUlN?=
 =?utf-8?B?SHZPNjVtTDRhZFB2dVZKbmViN0VNV2t1bGtMc0NucDVGVHJwSWRaYjh3Qmpy?=
 =?utf-8?B?c2txUnZkQlAvQmI0WXd6SFpnYTlmaFcxbDJwdi9VcnNwZUlXSlpwV2RYV3VP?=
 =?utf-8?B?Z1kzRFh3c0JueWdJWm45S0lUdTRTdGI5eEZtQzFwbVN1VlpPQ2RLdi96d0Zl?=
 =?utf-8?B?MjJnK2pYdzRxTDdOSlpoYTJPNG12cjRtMzRlZU5TMDh6OXBPWlVQT0RreWFH?=
 =?utf-8?B?di9rMURZREp6U1Rzck9iOHA0bC96a1hNcG1PVjl0V2t4aC82VzViMWRhV0hH?=
 =?utf-8?B?TlM5VW9yblptTFNvMEMxdm1VOTRYbnh0QkxMSk93VTVoK3RodnBhVlpRM3Zt?=
 =?utf-8?B?OHpEV0JYR2o4Zk5FSmtYRENLdWd1RFp2eFdiSGs2REViOTNDUkszc25LNUN3?=
 =?utf-8?B?WjFiRTIyZDVDUGNHOHVpa1pzWTdWbFQzTTc1VEEzbHd0VXE2VE8yMkNxcERG?=
 =?utf-8?B?L0JteTBHWDh4WGlFamRpTXJTckNUcjJjZ0p2T1BnV0IxMzJQZlBna3hiS1JC?=
 =?utf-8?B?WndpY1pDYVJEUHBrL3BiV0t0QmRUcFlhRzYvUGxBMzA5NjNkWDFXdWFGRFdN?=
 =?utf-8?Q?PkCS2Q4FUN06rTP3YfDmTHnLqtUoMiln0G6WqhlM09gQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEpESi8vRElOeExTUTMrS0o1WGp6MEZyY1AyQ0habXE3bWdidStzdUpXbjZ2?=
 =?utf-8?B?YVVLbTVLK1BHemgvR3ZCRnh3UnhsNmJFdWx6N3JBakp5ZTNKU2IxemxzTFc5?=
 =?utf-8?B?eFJ4SWk4bVZUMGFSYWFpbTM1REFwNDNRMmphblVFQzcyZE9BYjdSM01NTVdi?=
 =?utf-8?B?c2xTYnBRSnJaRlpiZHNMaVNqdlJ0ZWRrT2taK0lZdlVSQjVpV2tZM2VDbXZ4?=
 =?utf-8?B?akNNSElkYkJYOTdpcUdIN0ZxMWRXdndILy9lVlRZVFFsdHZDeER2R3QxaGNE?=
 =?utf-8?B?amtEMHBmeS9zNm1EVmh6Z2VMbjZHRFY1M2JDYnYzUlNscTdkS2kyT1ltSDNB?=
 =?utf-8?B?YjMwOFluRXcybFdYdm55UFRZTk8raVFKM2wvT0I0VURnamZtV0crMVhQR0t3?=
 =?utf-8?B?RzEyNmQwNVdSY3A5SHhPYnFPaGVVclplcEpCMmFJcXBKc0MrRHVRNFAvdkZn?=
 =?utf-8?B?azkwN1RNK1VSRXAxYmVUTzZyMURUT0V1OCs0Y1A4MDdodTBCb2ZvNmpXVnVN?=
 =?utf-8?B?azY5bkw1L0F1VUVRVzhadllnYnpwUWx0OFJ6b3N4RGtPVklhdWNQeVNqaHhM?=
 =?utf-8?B?Qy9pNk8wZ0RCcVFCVTFmMDZEcmVvTEE1eExrQ0ptck9lUlpaZHVVY2IwRGVu?=
 =?utf-8?B?a01hcHJ5aUpUTWNwdXZrSGJxK2pQUndqejQyQTBBZmcycjhrQzdPak5QR0RP?=
 =?utf-8?B?YnZ1WGtSeGgvQkxyY240RGVFVEVVUXVvU3E3N2ppbmtWRDk3M2FYZnJla3VI?=
 =?utf-8?B?UXd1M094RXdJSFk0MW9XSnpNeW1CT2UvT0EyaHNwVzJidGgzcWJrQW1aQWcy?=
 =?utf-8?B?SEQ3SnZCRFlVRVhRanB4UURIMk05SUJ5M0JBdHVUVDB1YU41Yml0Mkt5bGF4?=
 =?utf-8?B?VWU5UjRnMDVZVmxJSFd6TGxoelJYQ1hHZFJSR1hKbDVzazJTa0dnem5HYk9D?=
 =?utf-8?B?czR3ZlF5UGFUd0N2RDN6djNiRDg5eEFXTE9DUnlJeEJaMFJPdVVoSkhNRzhi?=
 =?utf-8?B?NzBMQ21oY2RSS2dEWS81dTM1U1JLY3Boc1VTcjQyS2oySDRqZVhsR1NLcWp6?=
 =?utf-8?B?Y01SNlhTS1B3NkZMOC9LUUVMRHpGOUpocERHLzEyWmhTamxaRmRCeVA1dGJh?=
 =?utf-8?B?U3hMZnFwMDBkSHhVK2FZRGx6ZnR1VDhmZXZtSjd3eE1kMDRhM2g1K0JsYytX?=
 =?utf-8?B?aDZwWVFFQlE2Z3hXTHlyZmZOdkMyNUZQc0l1MS93ZXZLM0VqMjVwMGx0VlR4?=
 =?utf-8?B?UGd0RzV4SWp6aXo1a0Zzd0h4ZTVzZ0dvZk1XV09SVzRaTnpaNE16R1Ezem9z?=
 =?utf-8?B?NFk3UGxmRXppTW9oVkgrYTdKbDFiS0lPa2FqN2R2QTYvSTUxNEUrbkNmbWkv?=
 =?utf-8?B?UWZjMzNqbVZ2VC9KS3pXbDRxdGNlc2lONEljeTJ0ak9Zd1pYWjduazdROW9v?=
 =?utf-8?B?Vzd3QlljczA3TVBlWlcyS1gyb25sUy9ac1ZGV21JKzZsQzdGT3BqSzg4dmtq?=
 =?utf-8?B?RklISFFqNkQzUGpBTnhiZUhQbk1FbzFlWmZOYkVPaFEvMVhaQlpSYk5GYlJD?=
 =?utf-8?B?MlVRMC9xbFhtMEtvZ3lNbEdLN2RXUlNYdVFIRWJGNk5qaVA3TlZ5OG9tTXBk?=
 =?utf-8?B?Z0d2blJEblBhSkhON215YUNaMzhveGJtcVYvdzcySE56S09VSFRGV0tnS0M3?=
 =?utf-8?B?bkgvY2FFemE4MmdzeU1wdlJ5cWxqdUZYN3FvUzBFVm02YlI2MkRRbE1QblMy?=
 =?utf-8?B?aGRucXRpai84anhSQU5ZMmVab2pMUzNpOWxDYm0vTGFKL1lFSUNENlQxZzZh?=
 =?utf-8?B?OEd0ZWhzNzdrNFJkWVQ5QnJ0ZmUwcE41bEJpeWV3dVFrZCsxcUQ3WnlqNUZq?=
 =?utf-8?B?byt5c0NQWS9PRHFRRnNiUjBiOTMxV1pCNjNPUm8xT1dhYW1ROGh3a3lPY3Jz?=
 =?utf-8?B?VVNiM0d3Zk8xT1YyUWtNTWJsd3JOdGI1SUxnQ0pWd1VOVUozdFcxbDdXMjha?=
 =?utf-8?B?eDRHbmxodjUvc3ZyWHJXUXdMU2R6Nkx3ZnVZWjVhSnFJbW1UOHVNYUhienlL?=
 =?utf-8?B?VVFlN0NSOFRTRzcrcUhrZHV2aHZOTXA5d1I2UnBsc2loVzkrQ1JKR2Y2U2Rl?=
 =?utf-8?Q?yfLEBTBvaV5psW1Sc6y+o0CFc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c4be7a-1191-4f52-ce2d-08dc6bb1d13f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 20:44:24.5387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogCNs+M2kp2DKnpRMpxiLPyRHswmtHD0gRHwWB9D4w51UgE/bn4TQqAgLkJolf/p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509

Hi Peter,

On 5/2/2024 7:57 PM, Peter Newman wrote:
> Hi Reinette,
> 
> On Thu, May 2, 2024 at 4:21 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> Hi Peter and Babu,
>>
>> On 5/2/2024 1:14 PM, Moger, Babu wrote:
>>> Are you suggesting to enable ABMC by default when available?
>>
>> I do think ABMC should be enabled by default when available and it looks
>> to be what this series aims to do [1]. The way I reason about this is
>> that legacy user space gets more reliable monitoring behavior without
>> needing to change behavior.
> 
> I don't like that for a monitor assignment-aware user, following the
> creation of new monitoring groups, there will be less monitors
> available for assignment. If the user wants precise control over where
> monitors are allocated, they would need to manually unassign the
> automatically-assigned monitor after creating new groups.
> 
> It's an annoyance, but I'm not sure if it would break any realistic
> usage model. Maybe if the monitoring agent operates independently of

Yes. Its annoyance.

But if you think about it, normal users don't create too many groups.
They wont have to worry about assign/unassign headache if we enable 
monitor assignment automatically. Also there is pqos tool which uses 
this interface. It does not have to know about assign/unassign stuff.


> whoever creates monitoring groups it could result in brief periods
> where less monitors than expected are available because whoever just
> created a new monitoring group hasn't given the automatically-assigned
> monitors back yet.
> 
>>
>> I thought there was discussion about communicating to user space
>> when an attempt is made to read data from an event that does not
>> have a counter assigned. Something like below but I did not notice this
>> in this series.
>>
>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>> Unassigned
>>
>>>
>>> Then provide the mount option switch back to legacy mode?
>>> I am fine with that if we all agree on that.
>>
>> Why is a mount option needed? I think we should avoid requiring a remount
>> unless required and I would like to understand why it is required here.
>>
>> Peter: could you please elaborate what you mean with it makes it more
>> difficult for the FS code to generically manage monitor assignment?
>>
>> Why would user space be required to recreate all control and monitor
>> groups if wanting to change how memory bandwidth monitoring is done?
> 
> I was looking at this more from the perspective of whether it's
> necessary to support the live transition of the groups' configuration
> back and forth between programming models.  I find it very unlikely
> for the userspace controller software to change its mind about the
> programming model for monitoring in a running system, so I thought
> this would be in the same category as choosing at mount time whether
> or not to use CDP or the MBA software controller.

Good point about the mount option is, we don't create extra files for 
monitor assignment in /sys/fs/resctrl when we mount with legacy option.

> 
> Also, in the software implementation of monitor assignment for older
> AMD processors, which is based on allocating a subset of RMIDs, I'm
> concerned that the context switch handler would want to read the
> monitors associated with the incoming thread's current group to
> determine whether it should use one of the tracked RMIDs. I believe it
> would be cleaner if the lifetime of the generic monitor-tracking
> structures would last until the static branches gating
> __resctrl_sched_in() could be disabled.
> 
>>
>>  From this implementation it has been difficult to understand the impact
>> of switching between ABMC and legacy.
> 
> I'll see if there's a good way to share my software monitor assignment
> prototype so it's clearer how the user interface would interact with
> diverse implementations. Unfortunately, it's difficult to see the
> required abstraction boundaries without the fs/resctrl refactoring
> changes[1] applied. It would also require my changes[2] for reading a
> thread's RMID from the FS structures to prevent monitor assignments
> from forcing an update of all task_structs in the system.
> 
> -Peter
> 
> [1] https://lore.kernel.org/lkml/20240426150537.8094-1-Dave.Martin@arm.com/
> [2] https://lore.kernel.org/lkml/20240325172707.73966-1-peternewman@google.com/
> 

-- 
- Babu Moger

