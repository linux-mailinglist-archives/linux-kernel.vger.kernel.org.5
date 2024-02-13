Return-Path: <linux-kernel+bounces-63479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CB485302E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6981F25824
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9AD3B196;
	Tue, 13 Feb 2024 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="DyhvOknf"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9219A39FE2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825945; cv=fail; b=pe/W6jiCLPU0tFiTrUF5zPXBnR6JkpnCXWDbaIS9AtsPS/ZmvJhNpK0GgUNqinYZQOoZACioB+zaGbaCnUEmEm6Up7oTKQPnTcvHndCKVsZJvMWb2FGEyqlBBGJERvFauQaCHPvuoK/P1JnF1d18jb9OpzMSJzYeWqmmFYXWCEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825945; c=relaxed/simple;
	bh=CN1b8xoe7cpbyoSRtIsU4NYeQWFGOs/R0MCIlRqhE2I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UMuvyjhvAkjui/j5PCZAZ9WvtYix79lO72OCNfhnMdUGVhA8D6qIh5tptVNWqUA56Bde3pU6PIdgjIBcefdoZORdEqRf3xTqCFCuZtiTlb6TVrAJQK+KY8Y1EHPk6tJfW6xCGXWxKGkMDThPzhHlyRKU9AMVgYU1R9CBLKBAJ9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=DyhvOknf; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cka0eMeInZwutuQvbVzBwSx1m3Wt5a8HDZomkKUxG+JAvSTDr2IMg6qmRD2Y54ERIepPhD226X2aq2pZNfOyTWYByWrFpb1wXofh66VA5tNURCk+/qfW0S2WKpstimonJNPio4oPLriwoDoQxVCy/PnWrV7gEpryCY+wyh+JZWD+PCX02g/XbalJLf88GgispwQcgOUW+j7oYYt5k6ArizqROhSt05AoYoB/biqHXruwrBi//RCV55//TwUcZ7ZmSbikWFZa0yxMyMONBcvmPJj+djAV0LAjtAhRcJXWOIa86dm5xAjSesof8C6aVV3laGBwUyem0NgUMssTTeBxew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETeww57Q3OFZVmQF4aaJeatIL7382mxM6FX8aWlKfE0=;
 b=CvpDcRLsJRaK8CNe4N9hNgbvuHSvTST0NcDWFubO3W6i0B5GkF/2/flh1abrBQG5qAKpVMkw5T+TptouT1lQDN3j7hjeqMO8JevaiOvTqTRq551B3gAt2zLa2QJBaVMk1rvRZ6a0pRHJY9OU1RjMCWOck1KsysCpS9DPoBbGAbNsYxRbsN6t0uRg4gsPng5qoJY/zYFCV5VofmmV1moLKUBFAB4ZPnti53RLYvpoc3J7gr/AGeNWIKKhbVyEu7d4AhRdfW8kq/Sd0gSQ7QiOvwfNHVcHMs6RG/OsgLyDtgPebO7WTYvhXYIipGwdbbHDcup/HYPZsOIXBJaG4Nc9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETeww57Q3OFZVmQF4aaJeatIL7382mxM6FX8aWlKfE0=;
 b=DyhvOknfHowv/QpgkBpluxL2W0O8tOaRDnZmAvvHIfYbJXYkgT4TNzeYjemvjB0reu7diEdSZOPDB8UPAykvuhbUuB7F+WBqbpN1BUtbCuuzS/NWfWTWQlv/X8+ZDJSlWhH6BEqpwMGHJpiznd5oHebqv3S3pI1Wp88j20wLZiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB7399.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:614::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.28; Tue, 13 Feb
 2024 12:05:38 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 12:05:32 +0000
Message-ID: <6e776c69-12fd-470f-b3ce-dd9f91bacde5@prevas.dk>
Date: Tue, 13 Feb 2024 13:05:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: lib/vsprintf.c:1528:9: warning: function 'va_format' might be a
 candidate for 'gnu_printf' format attribute
Content-Language: en-US, da
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 kernel test robot <lkp@intel.com>
Cc: Petr Mladek <pmladek@suse.com>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <202401111051.dDNWAfKw-lkp@intel.com>
 <Za0iLa7akcaML096@smile.fi.intel.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <Za0iLa7akcaML096@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::14) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: fba0f973-7e0d-41cd-e234-08dc2c8c13aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x3OSX8mOiuJlTHAyIr1KLwwurQZ3reJIV+ghbz7FzpbnTMWkAF5eUdVKDMde7yDbAMKLlXOH4mc4JoiJBQ0PsXerPaJbURpITGYLDjt6XPEKqgD5tSdb88zORGVhrtxD1WNFE++CXX3CSim3Y6F4vGgXDKkeZ/8VqRQIFgSxh40oFVr4Czx0Db9/aD1GoELVANS16taC59Wmk25EYfrsduXg21uxuY+8pZu+nXWzC8ZNQIoJF1CDLVCvpsyEK3SlHj9rKtNFqGHaILYdx5ESqhwZPJbSJg7hQPU9odBdKbraFi4DssZbmIcZw7U9nzg2mIaIHlqOqOHEzR2qSBhxqciON757zZfMwRWCVxugOOayPGh1tDW8h4FqNxsu5fqeQNLqkHajR69/zehWUn7ieIxGJ8VygzNTxLlAWs1KSCc8A36uegk3UxMsa0dMwozyarL3Q+/LDjT8OxYGdzlW32pn7mJFNGvr6j61fAoLV4RrPJ84k1OdaeEmifgYoo3Viuq5lm5iA/ZRHNjJatFu9d98lp8X3csyH86vVdeBiAWWfDN9XJAx3UyLD6ePzf0E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39850400004)(376002)(346002)(366004)(230922051799003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(8676002)(31686004)(26005)(41300700001)(2616005)(31696002)(4326008)(66946007)(66556008)(8976002)(2906002)(44832011)(5660300002)(66476007)(8936002)(110136005)(478600001)(6486002)(83380400001)(54906003)(316002)(6666004)(6506007)(966005)(6512007)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjVMaHVpYjN5VHhzTitzOCthcDY5R25NcDN3L1p2L3hyakhhNjVrS1dERVJk?=
 =?utf-8?B?cWlOR2JCbHRFc3o2NnVBWWRyZHhoOWlpVXpFUDZ5ZUkyd3pEeU5xUkVLcHpV?=
 =?utf-8?B?VkpybzUzRUNUVE9SVDFEUFdKVnlxb1E1eG03cFI5ZWlSRFRhVWw0SkdLdlo0?=
 =?utf-8?B?VjFVdElUQWxtTjRwNENxL3kzcXN6NmZhdzdnbzBDRTF6aXJOQmowVmNwVUdF?=
 =?utf-8?B?UnVqKzh2MVIyRks2dkFLMDJKMkM4RUtvWTBWcGRHd0k0OXNSVTBWenR6ZkJ3?=
 =?utf-8?B?dUhjc25ISDkxTW5xUnkxTEZRWWg0RjZSaGlwNHVnYTZObHV5WTlnMWtVaWpD?=
 =?utf-8?B?cVhjZXlaL2JuRlFZSkhkejhaRlcxWmUrVEkyVHl4S0ZLbGZ0dHlOa3k2aWRs?=
 =?utf-8?B?elpNdkFXU3I1Q3FsTzN4a3hpWnkwbHVONytvWWlsL1dnd3JIMkFoaWtwcUE2?=
 =?utf-8?B?bHQ2RU5uS01KUS9zWEplbGdFTVNGczhncmFDNUFpaVhjTWhsTkRnV3B0K0Fl?=
 =?utf-8?B?dERLZW1jY24veVZUTjRuVElueVFuMXdvUXV6ODNqSDV3MGh6VGgrVlYvay84?=
 =?utf-8?B?SFBIbHlNR01lOXhqeFpmK09LYTQrcEljSHNRM3dLWnVDc3p6Vm1LdWF1bGQ1?=
 =?utf-8?B?NWVEOHpGVWRRaWJvOWpIa1RaWWNDT3MvMXdITFA3VnA2NkowK1FNV2owWlUv?=
 =?utf-8?B?b0dnQ1hBSExmMzJvNkxOT0c0R01hbldlblJ4NndyN1NRQmpJMWE1L3lobWVv?=
 =?utf-8?B?YjB6bm1DbEpMU25uTFdFWTNVZm9pOTlmZ1llaUJJbmNZdUl1MU5xN1EvelUx?=
 =?utf-8?B?dVZVaWNhU1NjOE53MjZCbUNjZFlTdVdDdHNkd1c4dXQ4Q1FlcDVwMUpsdGcx?=
 =?utf-8?B?KzYvYnJReXlFYnVWd3RLMncySnhrOXcydzJpODBwWWdpaWFqOE1weEgwT1hI?=
 =?utf-8?B?U0FjMDk2UjB6RVNGZnhvNFloVk1VTlVXZW5URWdDQ3J6a2F5a25MUDRTOWww?=
 =?utf-8?B?WW9XcEQ3cXA1aElpMFo2bkgydWRPdk9sSVNHYytLTm1NdERvZlNEY0tzMkFo?=
 =?utf-8?B?UTRiaXF1S2dwNGt1ODhmWE1yV21saVNOWDNhU1NSdS9rYnllZ3BueVhwQXJJ?=
 =?utf-8?B?d3JneDVtSFVLT09hQytyejRCaFJuYU94OWRienFzeWZxazVjVHlnanBoNHRL?=
 =?utf-8?B?K1VjaldXUHFnMUJ6UnhVN1BWNXBXM2JLOCt4ejhNRzUvaXo0T2owWFZIT1V3?=
 =?utf-8?B?QXErNnJ0NDlKa05vNmh1Z004TkFsd09OTzQ0RTlpcnNuZDVnRFJpQTNMOXk5?=
 =?utf-8?B?RkpzVkptQWJEdStEMEo0bXdzZkRYajdLUjhYSE1PQytNVUVWTldqbHV6TVA0?=
 =?utf-8?B?VFlwSEkxT2tFY1RpNGtCdVJsK3poUFRPVzJ0RHZCMGpjZXZqclFkd2thMDhB?=
 =?utf-8?B?YkVYbzUrNDJ3bDB5Mk9RNVhEdDIrY2hkbWEvbkdUT25mZktqM2k0YWV0Rksw?=
 =?utf-8?B?ckFrVnBPYmJqSkU5cFpud1dPS083VVVyNmQrWGtXbGJOWmhqVmJDbnpCYW81?=
 =?utf-8?B?Y1lJODlQMXFNK1g3Y3NFbURoclVwdWE1ZVlpeHpJTmdCZ3Z4T2tpVnVCRFBn?=
 =?utf-8?B?ZzZWMUJNVzlDV0luc1NTQ1NHN2pFSURBL3FrbjhqenFWMnA3c09ua3JTbXRF?=
 =?utf-8?B?akVIdXZ4YlBXL24vNGVybFJ1TFBqMmU5L29aR2RpVDhCL1dDZW82QURvdDVH?=
 =?utf-8?B?Qlp2QkhKN0lJTlp4enRUUGNacXZSZ0J2NXBiL2E3NHhLNVFKdkZXZmt2eDFh?=
 =?utf-8?B?TFFEWXk1cmoxQ01SMnJoZXdqNjZGT3lRdUc5NjJBclY2ellZMlBPLzR4SjV5?=
 =?utf-8?B?UURNNzVSdjJxM01LQm1UYjQwbFBiYThIMC9QQ3VDdFZ1TVEwaHN2Y3lTTXA2?=
 =?utf-8?B?UGJoeC8xNEpLSTdhNFNvSFVXUGNwbGdrTTNkT0wwWmd5aWJOVUVJMlZIZjF4?=
 =?utf-8?B?RllCR21wV1FaTHZBUTMzUDRSc1lYT09Wem9SNlJNY0ZBTjhoeGkyUnFCSHpj?=
 =?utf-8?B?T1FqSnBNenJEd1ppOExQL0QrVUpjZEJIT2EzUjRTY1o3RWlvdjFpRDdOV3d3?=
 =?utf-8?B?U29jR0RZV1JSZm95WmxDdm0yWmF4eU5iNmZ6eHo5Z3VjSW1vdjdydjQvM1Zs?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: fba0f973-7e0d-41cd-e234-08dc2c8c13aa
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 12:05:32.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REJ+TSs9NKX/sROCdZb9zp6O14pqd75w9OvoVJcUpxBo4feL3XW+lZt68nm0a1/L20xrnCLZ9bCO+sVhmwevav+NqV5K279l5SgdkndB+Ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7399

On 21/01/2024 14.54, Andy Shevchenko wrote:
> On Thu, Jan 11, 2024 at 10:33:09AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   acc657692aed438e9931438f8c923b2b107aebf9
>> commit: 45c3e93d751ea50861c796da3cbfc848fa6ddf55 vsprintf: Factor out %pV handler as va_format()
>> date:   4 years, 9 months ago
> 
> Blast from the past?!
> 
> ..
> 
>>    lib/vsprintf.c: In function 'va_format':
>>>> lib/vsprintf.c:1528:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
>>     1528 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
>>          |         ^~~
> 
> This might be still valid, but I have no idea how to properly fix it.
> 

It's a bogus warning, and the fix belongs in the compiler. When
vsnprintf() is called, but neither the format arg nor the va_list arg
are direct arguments to the caller (and the va_list is not built from
actual varargs using va_start()), there's absolutely no way a __printf
attribute could be appropriate.

IDK if we can shut up the test robot by locally disabling the
Wsuggest-attribute with some pragma.

Rasmus


