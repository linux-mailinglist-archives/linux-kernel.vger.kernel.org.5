Return-Path: <linux-kernel+bounces-49596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5941C846C37
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28EC1F22E43
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1887765D;
	Fri,  2 Feb 2024 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Khzo0xIZ"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2085.outbound.protection.outlook.com [40.107.117.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46702628B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866604; cv=fail; b=dwdMdHNCtXhLO4En0nwFjHtOJKfuguhMelZ6W3zAMMDDGhxFVlbjjDT+UHDDnjJ+4rjPtyYbCoiY8CbGW21g5igkRLzgQFf4a/X0TGVlHCWFiuygjPWq3SM0I7/lA1hEIIATbi2huR5oUi2soyuxog8jXz5sXuK3GkdgzcgPGrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866604; c=relaxed/simple;
	bh=/aeIkgElPdkN/Z3hAUD2Lb6/bzyIV2yxblj622RQnIU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QumJAJgI2Y6AF2wI0RWeIedSb5N5+Ok/WsKhysQ3yhjfdr8T0b0mOS8KU1cKBIYbl21dy12WAchVsDjfOcECqHUUZFrdj/X/EfR0+SD2+q2GLj9ywjPoQeBNNG+8uHuAHMVN5iuRyW5ZHHqhi2NdyD/ZDU07kXdKOgTEvQ6rApo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Khzo0xIZ; arc=fail smtp.client-ip=40.107.117.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3Do9QPCaR+LsAvoef8HlPBCdi7Q+JhGEI5rET7EQS3+bgaUpnRDJIP+rwbN/fBhgUhNuGv5hphhJcJ4BoEyIzNytt1BBe0FkDVY/KGSWkRmpRG9TKXAkLM55mkpurA5IIdA2twNvfeRI7d4wD3+FOO4x9DbMVRMP/csB7Zyu+FZ8bP0TCpRcdpcwsEx/cg1U6+s5o7CciI5J+FTc2CtnX0a6V8uydBYa6SWuSdcXevyw79nvjEd6CCR5Kmy9taRsvkTi0GcK/C5i/7tlizQIJinslZXLBpRVlnuVhvWniKzrBTaQD2wS4+yoOp4cl/0Vf+9iu2j34LNzdyZfT1rrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fz3H6dTKkssG3p5v5XeAR14+2lu5HpS4Xxm+m2FLi1I=;
 b=dyP8V2RN92/cxrNwleZ5TQNQ/jvnuzS/kJ63zfWEfAxyOqMxs/SvdttN6t9utupCGfRgQWl6cNS01b9qfNCg8pwOM1gRKgNwzaGd0LAFhPR/9EADvJFM8QRSK0ua4X02BHogfJ7jvh/aKj9/iuo5AIuGR7ytHE0f5N/BWKNUpGhs0WjKJyi7OtU8y+wVi43ra7G5fwcbiUWigC9ZPY35et/sYrxv7BAdJwqOO0wHwNLtzGecvEku8fUozTw8f9iPE8V+sgFnFUfCsCegvaU1F+DmQUaNR3BLs0whBAzspLOeRE3mFVmY3/giclcvu8ne+rrwyc0xmB6g+koZH1Dhpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fz3H6dTKkssG3p5v5XeAR14+2lu5HpS4Xxm+m2FLi1I=;
 b=Khzo0xIZCEj7OESIjiWEront/pv2io7Kd0QYvmvlOL/YsoXnyh66pXdEiDQnLzZ1ANHm/Ze2U3tC/lVOmAsMfT7xncImQ2WRbQtXPaC4eOQ6CklT4CIvv5IovCTgYdbLB3rPW6G3aXq8RazGrpnyiRz+FI/ggHYOPc4aTpUvmqP5j+SsSQd/qGgcXsICB6xCSbvdi8kT0awNR2HZmLIDMZD25oP6EPV9EoZp/u52fyqK3te7wzoUshl/Kd9diS6eQWOcAkpBjHU37ciLvhhHH6O0nNni4hDoZizoDeu4IrqtA7oMeFHFFct1GtVrpkazG7yGJTbQve5b8Ai/lHhy7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYSPR06MB6767.apcprd06.prod.outlook.com (2603:1096:400:471::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 09:36:38 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::84c3:362b:bebe:87e2]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::84c3:362b:bebe:87e2%5]) with mapi id 15.20.7249.023; Fri, 2 Feb 2024
 09:36:38 +0000
Message-ID: <0f8d2f71-c77b-4804-b762-cc40f23f88cd@vivo.com>
Date: Fri, 2 Feb 2024 17:36:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm:vmscan: shrink skip folio mapped by an exiting task
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com, Matthew Wilcox <willy@infradead.org>
References: <20240131131244.1144-1-justinjiang@vivo.com>
 <20240202012251.1aa5afbfdf2f8b3a862bced3@linux-foundation.org>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <20240202012251.1aa5afbfdf2f8b3a862bced3@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0117.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::21) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYSPR06MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: 15020503-4af3-4daf-f533-08dc23d2744b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yZXbACZsJi3kHxtoBYEtFgfl+WI4NmsdUDbCS7F2lFz0EYNYTbkqQaUJYmWCIISXcXQpATohDSAzwR6gLv0xiCWI54IJVzGPrnhzTMDLL0A7hOaYZMWWlWuLiYLRrEd1wXCV8RD1q+69gBVhAb7P3xHAagKrynPD5LfchKCXCNrN1KoXqAS5qtzJQQC0Gt1itb49omLaJYaNNpV9zg7LnCMyp15REj3J1HD0NPKKq8h621w4BWV5sLSKuyuBr8k1j6yzvp54n6guyZ0vBUH5jQZjdIaYTlzR03ezxPGKsJNCoo1J3zg/+hmLRnrV4oGv9anFsYGsCUvu+jef/2jabL6L/NyG07WYwllcYlsqh3pW2sNILU6h4hwrHuEHuIY55/59tAoAawJIU63EjJUPK1KE8JK1aUos15IOP5FTw4Xpz0nvEMBBPbIPbTZnjjgjejflt/azBcwxg0LkDxzwcDOe3ZaGvNiJYvSTwF7ojOX9ipHtMcqGePllJOlaVviKG4WChSd+Fn7a8icivIqpAVGdIVCcMR7KiaKN7SvszP0xHIt07RSpu8Ij68bYMrPTJAqtlSTQgzjsNjE1Jyw/lfiC4AuIHTFFdHTSn3Vnc8DLbCv6NcZNBb7M4OXcLHuYo29ZAS8Lj4saz3Au8YAglk/hwwZ8PRZMiQy6apXlCpB7PbRtYCTSRY4kc6aj/R9l/08midWZ/ovgKpB0ufo0CA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66556008)(316002)(6512007)(2616005)(26005)(31686004)(66476007)(6916009)(6666004)(8936002)(478600001)(4326008)(8676002)(52116002)(6506007)(4744005)(5660300002)(6486002)(2906002)(66946007)(41300700001)(38100700002)(38350700005)(31696002)(36756003)(86362001)(43062008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWFtMld3ME1XcENLek5kOW41NWRhRzc1NDI3MUtNSWZsNUZmTTVWR3pYRk9v?=
 =?utf-8?B?L3E2blNGclI5TXFuWERKZXQybTNLL2dPUnhsZm9HWmwrTlFuMy9xTjFnK3V5?=
 =?utf-8?B?TXRMdlZOVkRzaTBya2E5UFI1Nk5GSDZTQTl5ZGozSEo3d3R6UGZUczR1Y0Rq?=
 =?utf-8?B?T0hBMGJXV1M1SS9oTno1a28rcU9rd2JtZnFRVlZCbVBiVTFKNDZpMExHMGNz?=
 =?utf-8?B?QVZINGQraUZCaGpYZjhhR1JiRUZla013MGhjQzgzTThFSkhOcUZsS0lvM2FF?=
 =?utf-8?B?aTZvalRWVkd6ZkNvMTVlTzZVYXo4WGtnTUh3SDdscW9Gb2w4UFRKalhzQmpO?=
 =?utf-8?B?L1lWZlJwOWl4aFpUMUZ1cmdvY3FXZ25hNTJsNXVWRWxqSDJSSFZDWlZGRE5q?=
 =?utf-8?B?SHJvVVNvTG1PRVV3aGtIN3lnMThtcUVYV3dQR0IvS21PcmVDUDA2RGpSTEEy?=
 =?utf-8?B?VkdvV3hpcU9rUGVLL093QUd1ZUhVdHZsWlZoQ1lxdWk2TDBnaU44M3dFK0lh?=
 =?utf-8?B?cEJVZkVib0ZWQ1F0SDBoZkY4dVNyQnBxQnJBd01hYlFnbUZkMFppZVZtc09I?=
 =?utf-8?B?R3VtZ0ZGS1NQd0Y3dGJqcVNteEVTSTVlN251ZmczZjhyalU1clBpQzhQZTRy?=
 =?utf-8?B?YmZBSElFR3BQRjZ0Z3VVQ28xbVUyOGR2ZkdzeTA4Ukx5MXlOODFpMEJ1eWh4?=
 =?utf-8?B?dFV0V0dqSERKeGF0TTl5bitrNTB1K3g5M05qM0Y0V1BZZkNtQ2NRQ1g1U09P?=
 =?utf-8?B?YytoWlBKL2NKbHhTd1VlSDErdTV4dE1tVlNUdUM0eldlcFlrdmlEMUVndGQ3?=
 =?utf-8?B?LzRheFUweWZUVnZEL29Vd2pXZEpsN0Z2NnlYTTZqUG9vNWdWWHMvZkplR29o?=
 =?utf-8?B?eUJpZmR1bnBnVm0vVDNDWlJycjVaY0NTWExQTTZkMkZPVDJuUGJCMTV0YVUw?=
 =?utf-8?B?a29Sbm03RStPZFFaYzYrZzdiWHpQR2xaa0sxUlc3dUdCQ0oyQXB1dDJ3TWNw?=
 =?utf-8?B?aWx4dDlsektVdjh4c2xtQVNIR2V4KytyVTJIa1huWTB4aXFrbDNLWitvVzBM?=
 =?utf-8?B?ekRWa3dBYnMvcVlxQnBHbTNEY0pVUWEyZ0JQY25weGU1SHBrTmoyNmN6S1RI?=
 =?utf-8?B?dFoxNFBKS0EzdmpkTERiejZoY1lWbnVOSFZBcGRLNDdVcE1vbXZTaXhwRmw2?=
 =?utf-8?B?eWp6TFJIRVNIVmg1QVJrTnQ4M2V1SkNyb0JRUUJabVJ5amluSGVnRWJUSXA0?=
 =?utf-8?B?R1RKczFDcFdGNmNvT0RwQ3pJUzZPUlVzVWVHNTYxSUlzcTNRT0ZNM0tQU0lv?=
 =?utf-8?B?SE5NNk9RVkN5WHh1bm5XbFRCcWFyNGNmK041ekIrSTNmN3YxY1J2WGdBUlNE?=
 =?utf-8?B?dW41UVBqTmMwV2lpeFVmNjVOYXl5Z1ZtZTkrMVN3bDdkMmEzODFWVldsaDBj?=
 =?utf-8?B?NUwxaXk4eHNVa1MxRjRMdHJSdWtBQ3NONGJmRDVNZEZRQXdIUUphbzlqTEZ3?=
 =?utf-8?B?S0szOWhBZHZXdWFyc096UHhJYjBxVzd5VlFpTUxVNllyekozRDBML0hqZEs5?=
 =?utf-8?B?ZHk5VTRWWmlVc00vekQwYVR0WnhTOU90a3hUNlZkSG93YlluUVhYRWgzYWpv?=
 =?utf-8?B?TzA0NGEwTWpzeGtTRFNJcEo0cnZUMHFjZGd3K3V5SWdLblptMXNVZ1Q2RVhi?=
 =?utf-8?B?TXVOU2JER3UxdjBRcGQ4cnlrbk12aWxrV0h6UXIzQ2hBcUdDcFR1bWxPVzg5?=
 =?utf-8?B?ZVRKQ1ppNmt6Rm13Zmd4SVo3aTlUWWNPRWJVbWJiNnpnVWIwSm9JUTFXcTJv?=
 =?utf-8?B?ekZ5b1JzbUtCa0hOem9NVlF4RVZhMXlzNXNJMTROOFR0eXpxNUlKTU42djNm?=
 =?utf-8?B?WWJKZFhrYWVxMjFGRzl6TGVlVnFwais0NXk2dW90Wm5XOTdrQWRTREFDemRS?=
 =?utf-8?B?NHhFSjZpb1N1Y3ltbU0yY3hPdjBwUHlaRE5OMk52a2xlSFJBUUJYbytkN0pa?=
 =?utf-8?B?UHd6UmVucFZucEoybXV4bGM5Z3NMR3Y4aFRpSjJFS0lzL3pKV1c4ZGhpL3FH?=
 =?utf-8?B?MDM1SExBb2dTdVpPR2lmVWxENHd1dUZKS1pTOVlXSk5EZzRObTVxcjZ2SWNm?=
 =?utf-8?Q?cQeHnN+ZSz8E5wN9hk0TBxqQo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15020503-4af3-4daf-f533-08dc23d2744b
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 09:36:38.3399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tm3mBIy2FI6IBIBSJJ5IgmJwvMbfJurrws3MUoizblIBZTKkTmF3hij0+GXv4wKTcg8CFsLypwRgOXoIaxRjqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6767



在 2024/2/2 17:22, Andrew Morton 写道:
> On Wed, 31 Jan 2024 21:12:44 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:
>
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -840,6 +840,13 @@ static bool folio_referenced_one(struct folio *folio,
>>   	int referenced = 0;
>>   	unsigned long start = address, ptes = 0;
>>   
>> +	/* Skip this folio if it's mapped by an exiting task */
>> +	if (unlikely(!atomic_read(&vma->vm_mm->mm_users)) ||
>> +		unlikely(test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags))) {
>> +		pra->referenced = -1;
>> +		return false;
>> +	}
> The code comment explains what the code does.  This is, as usual,
> pretty obvious from reading the code!
>
> A better comment is one which explains *why* the code is doing what it
> does.
Yes, thank you for your recognition, and I also appreciate Matthew Wilcox's
professional and patient guidance in patch v1. I will study this 
seriously in the
future.

Best Regards.


