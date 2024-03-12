Return-Path: <linux-kernel+bounces-100615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9B1879AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A5A1F21944
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CA51386BB;
	Tue, 12 Mar 2024 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fsc9hnk7"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1572812FB2C;
	Tue, 12 Mar 2024 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710265346; cv=fail; b=SyoySTgYocvEPC2RxtAMqrFMqKJvxXap/dotLBHojO7LijMFuY9HKUROj2MAt0yO8OBUTHC7Lq0zVAv7+MvkI9vWcyQOXxZx2BhZBtsVxqMYrsP43Kr8V+PgP9qXHD0MOti6LveT66QKWwnQf5ex401Kt0UcF96NqANTQnv1pbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710265346; c=relaxed/simple;
	bh=UcJ8a0FiIIN8LdWreTlsDdwpPTd+wcNGN4OB5QlpliI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LY+RHxHAwO2M0A0HN6wK5tOt11muODY+/zbyTZxZzuDg1UVNYbN7afzRVqvrEEOFyp+K5piAEnuRv+YL9GnVZAYUlGE/2880xVi/3rVSvUmb1sLT2Jr/Q9JHrEAvyXXz+aoAONLVzb43YtGdnSFJ4XkrBqHGBkaDcf1V9a+b5M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fsc9hnk7; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDSxRNsTld//eqmtr3URZGYrUTgZEIlB60Y/nrU7vBh7EDQqyrdXS27kSpjNDJJaUn/ykWOqyWzkzyacrFzGNyf/sofTTamlbOR8Ln5Ywdvbi7aAL8p+WuZMhg/qk70hRgdRP3ui/BaucOXrF3srbu70imNnON6yRzDZ1dBKuqRbBMIAE/VlDpEO+F8AKPhbTpvK83/I/nxjZphjIfDuzmrFNBT149/BRRh5ZqpzJR+82KI57Q3Kd/zjZHep/0Focgg3XhwJUtrEvHqB5ctA8wDUdWX4XTscSA6d4KXnI6scNEDfPql9KeLEgaffYHspEifryekLCnqKH4XSxluqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCuUscKaMpMxmmM1pIZQ/Fn+qAKca7709yjtpB2VyfU=;
 b=gjSOB3KlClx2iqvGuJgtahovtAV4Et7nCJvbM4xbUpw20UOvrRoFKEaB7UkHu1fqu3XTHRvqnfUdvsjZSLnfIsLusj/WzsFgZdjbt/rqqunYunwypcwtXJQ52pjWclRTao0FNdbqcoxRVB3cTuhqL3M+Uz3KSJogsZeh8nTFWuKk+wM6yHWzVrYjpsvREznrE9FNS1G8NQ2i5Otr6ZgsPHf4Diyrh5kn66Kp22PBn88Km+dHqoFVntQlqgBeKz/Gdk7ePoWAAeEsyKsaDzWfxCMf1zaBC0RmiIyWjCRNRcXia7Otg2nZEJrNI4wyNO7Ik/vTGHFfGMrBXwZAGoAfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCuUscKaMpMxmmM1pIZQ/Fn+qAKca7709yjtpB2VyfU=;
 b=fsc9hnk7QDaVmvfGOyN+ERphIk0/VXj+xpYetGbL2866HP2E7YWjlSWr7bfO9P5AKdSk0KP5ukfcxo99inUtbtwryNtS2yMfW9pW70M/lLYd056bs6gHsiDPQzJlPo4hjeO8AceBHQTKyhdqLTy/7iZxqtsV8bUEnQVs75QcP6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 17:42:21 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 17:42:21 +0000
Message-ID: <fdad2198-5d3a-4bce-8249-8b2f9f75f84a@amd.com>
Date: Tue, 12 Mar 2024 12:42:18 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v13 2/4] dt-bindings: remoteproc: add Tightly Coupled
 Memory (TCM) bindings
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 andersson@kernel.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
References: <20240311175926.1625180-1-tanmay.shah@amd.com>
 <20240311175926.1625180-3-tanmay.shah@amd.com>
 <d498d76e-b021-4cf7-adca-63f1cd3e1542@linaro.org>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <d498d76e-b021-4cf7-adca-63f1cd3e1542@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0076.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::19) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 68cff8aa-2e32-4d78-5b21-08dc42bbc542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	isObjzNg7KsCPDV/CTSwwFhonjxmQ+UzKlLDJUnQdnoOsajPG+41Ib8JWU3NVEjSZ2C9w3qOc8xy0yJaNXesybY3qYVY4WPAuAPQ5xJssL/494hMO6D5t9PtoeHVLCMSz3SPygCkpbieoq/KIPpWrKzcJT+BkvYjCVKU+WSWNoMacJ8oDwWffl2BAMwT1/Mw1Uolu2AEASKzkeUylwAtegc6aVTUrI3Zt0uV7ADKV9lOxFu9A3HE9Jge6KvtPQfoYGXxHWbHYW9kZ97w7RGrv3p9JI+AWGU6VbSL2XqznVIPn+WC45NJE5ooLnESIujss7iDtPSopuqq9wVESVOQ/VG7OprUi+xQOizyUvtdPB4+GhYZdSK6Asfni6QWKii42bz+HP8bKREZCrbcJfr5dzXaquukcwnkK2gvxFVsIrIlDyBOHB0sBvbUdW2dhD5rSQAgJlFQnJKv/YojKFtvgXpR48nFQO31/mIVl4Ldoqz37+hAz0fMTTvJxEDtYEEnWSbu6qOrHJS9vCuBrXA0GBmKEmhDtt8KMN1Dk4SaazGur/SVdfyLKdJNv1B1TERnb5pCj9p/i5R0531H4B99RnwB1No+flQTeh0XVvKjnQNriUeE6BSWpM/Nw45gXI0CuqpD9rWJ+vNqtgKwtww9Z+wXfQrdB+h3cndq5VxbqZU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkQwMUxFdWJOR3VMS0x2SkVuRDNQZWNwQmFnbnpxZXhIRVZBNkNYZ3JBTUIr?=
 =?utf-8?B?R3E3a0NQN3JybEFJQktwb2VHdVh0a29lQ3pPYzZCWFQ0SjYwV1ExeHVTeVl3?=
 =?utf-8?B?Slc5WDRaS2JOYkl5Z1M4b0NJQUVXTVpVQSs3SitJNklCdkRWT21wWnZwdDRI?=
 =?utf-8?B?bnhJT2ZOdVRUVXpvVHdJc2IzdUxuZnYva0pnZ1F3UVFmSS9iVTBXYmFnWk9p?=
 =?utf-8?B?NEh3cUFUbVBwOW42dndEelVTMytlSWhVeFRDL1prSlAzQktWdER5cFFvbDVt?=
 =?utf-8?B?WWVYUGM3NmtmWWdnTy9XbVZ2YjUwaHBlckMwbEtmSFA3dE5BV3crSXRoeUpQ?=
 =?utf-8?B?Q2pYbG4rNW5UcVp2ODQwOUQ2NXdoSTk1VERMMnlybUZ2aFN1dWU2cVVtVm9X?=
 =?utf-8?B?WnJTZFVFeVd5eEhtM0QzZkZJRndyN1o2cGdXNHNZc3pTZkgrWk9HRGJvbXFM?=
 =?utf-8?B?dUt6eDlYcDRXSk5TY1JTdVZmVHoxUVdiY1lGMVdSYk53QkovQ1hRZTFRVTRE?=
 =?utf-8?B?WTZ2Y0hoVXlZWFhIdUxISllreUFMNDdwa1BmVE5hRkNsM1VYVWNzV2FwTWdu?=
 =?utf-8?B?WFBQY01PbjBxNjYrRjFKNS9wVDFhcktRWXo0cTVLWnJlT25PWFBHVlIvMDNO?=
 =?utf-8?B?aFVlU1ZDTWZmN0QvKzc3ckhJb21VdVRpTmc3bzFIaTVZbEkvdU80L1Q1Skc5?=
 =?utf-8?B?SSt1aC9hK2NVdVRHbitCdVp5c0U2STcweDUwNjZWcmF5eXRSQlU5T3pqMHhp?=
 =?utf-8?B?am1Bc0VjWUsyWlNMVWM0THJHVEpqTVY0U0NTQkhDRXhGcmVySTV6T3BseThW?=
 =?utf-8?B?QmNBNlpRa21BdURSQjNHTEZ3ZFJGci9SNVNqaDVzbml3OFRWdDR1bm9pdld4?=
 =?utf-8?B?blRmaExndS8xKzQvTy9ldTNmUzRVcmtCeDk0bWw1dnVlaGdqWUVWbkFRNXpa?=
 =?utf-8?B?dFUyVk16ckRnUHFJSklUdFdrRWlKT3J4bEgwZ0c4eFlFanFETkdtSEJ3Y3Bi?=
 =?utf-8?B?eUxmR1BLVFFaKzRGUDI1UXlOdzRvbG8wdVQ5YkZZL0sxRkhuSHlOMWxiM3VN?=
 =?utf-8?B?NTdrMjNPeDlMc3BmRUkwbmdkSXBGNmtJbTBVV3lpYUNZOHZyQVN3UDJQbHFD?=
 =?utf-8?B?SlpudFowK2JtUFRUekpyQldkZWEyU2wyUUZIVWFpRkhmbWNQancwQmoxRHEz?=
 =?utf-8?B?TWpjaHR6UXU0Smh5ZExnM1NqeGRzWERqUXVQR2pUUmV0RmFkd1VFcGluTTZt?=
 =?utf-8?B?ZTB6aUp6SW1ESUdBWnlWQnhJakl2UVZIdWJjK0d0b1VNMGhiRnRrazU1d0RU?=
 =?utf-8?B?eDRZRFVlV2ZYTmRMQlBvbU9FMHNldkIwVFdtRExWeXhVU05KcEFtZDdjTTR0?=
 =?utf-8?B?U1IxYmF1MURZUDZzRVM3c2RXeUJwdC9MWXJXTTlIMDZhSER6UnoyUHB1Vmp3?=
 =?utf-8?B?OHowb1VIaUlscHY2Vjdjd1JGUHVRUWVPWm1scHlwVENQLzVlbzRGM0t2YkVI?=
 =?utf-8?B?bGZLeGFLdlpOTVN1bW85dXNWa1Babk4rN1lRcHpTS016MlFxeVp0OFJlc1E0?=
 =?utf-8?B?cERtZE9aWEFMUXd1R2JhV2drcFR2WjRGWHg3azNXVFRzdE9nbTFIelhVVEpi?=
 =?utf-8?B?Y2Zjc2xkdS9CelZMQmI0K1BLeUJ0TUcvYWtZRysyakloK3VYUlhxZHFDdHhs?=
 =?utf-8?B?c1JNaGFNMUU4Nms2ZjlwZnhCdWN5YzBwdnYwUzdka2lZbnRuY3JRUkhhUERZ?=
 =?utf-8?B?MVg0K0VuKy85RzZhUVFtMXpDSElDL2VOcVRWUFhMKzVhekdtL0JoK3RRZktq?=
 =?utf-8?B?bTRKMlZWKzVya0VMc05kN3E5WUJmSTdQNUNFQWQwYkowYWt3S01Fcjg1a2RV?=
 =?utf-8?B?TWxvWFZuNTVQQTJTY1hCOUJtRWpFUHExaE04MitCblF2T0VYOUZtMjV1TTd5?=
 =?utf-8?B?TkZQcXZpUWR5RWxBVjBFNlJ6c2NtS0dpQkgxZWl1SUh0ODdadHFiNVY5K1lK?=
 =?utf-8?B?MEtJMVpyWTJmMFZvOTFvdkVURllTazBJSFYxeEZlcUdtVXFKaGRuQk9WQllB?=
 =?utf-8?B?VWQyaXovcVgwdUxFOEp3eWNoOW50eXlEa3NrNTJyOU9rSDRwN2lUdU9uVlM3?=
 =?utf-8?Q?pbLl9ucyTj/lLCZxxYyzBX1pj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cff8aa-2e32-4d78-5b21-08dc42bbc542
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 17:42:21.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+xfv/kv2SYGAyA3AoSahMN5DnilhySyOOdaK+Kui2lbzCLDeT5IGLgqr15r4mr1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705



On 3/12/24 7:13 AM, Krzysztof Kozlowski wrote:
> On 11/03/2024 18:59, Tanmay Shah wrote:
>> From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>> 
>> Introduce bindings for TCM memory address space on AMD-xilinx Zynq
>> UltraScale+ platform. It will help in defining TCM in device-tree
>> and make it's access platform agnostic and data-driven.
>> 
>> Tightly-coupled memories(TCMs) are low-latency memory that provides
>> predictable instruction execution and predictable data load/store
>> timing. Each Cortex-R5F processor contains two 64-bit wide 64 KB memory
>> banks on the ATCM and BTCM ports, for a total of 128 KB of memory.
>> 
>> The TCM resources(reg, reg-names and power-domain) are documented for
>> each TCM in the R5 node. The reg and reg-names are made as required
>> properties as we don't want to hardcode TCM addresses for future
>> platforms and for zu+ legacy implementation will ensure that the
>> old dts w/o reg/reg-names works and stable ABI is maintained.
>> 
>> It also extends the examples for TCM split and lockstep modes.
>> 
>> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>> ---
>> 
>> Changes in v13:
>>   - Have power-domains property for lockstep case instead of
>>     keeping it flexible.
>>   - Add "items:" list in power-domains property
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Hi Krzysztof,

Thanks for RB. I provided explanation of flexible power-domains in
previous patchset. I am happy to send new revision removing
minItems if you dis-agree.

Thanks.

> 
> Best regards,
> Krzysztof
> 


