Return-Path: <linux-kernel+bounces-73702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD6985C622
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5797B1F23C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F148151CCB;
	Tue, 20 Feb 2024 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="NZ7nhA/j"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2102.outbound.protection.outlook.com [40.107.8.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1C0612D7;
	Tue, 20 Feb 2024 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462494; cv=fail; b=YH9nujofKcqm4CO2lfNwzu8zwbjHiJi15oe9AQJMxzTY9m1Yh1uuspU5DnWzu8zywCAJC3erTAJu2thlTiW2ityakAgtPl4cH5fbgyQ7Uu8dgYIA/6guu2xI9g7ehxT4NRH7yjXLXvV1KptKSzKbnOmhgoIEF2A3NWOAuQ5u4HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462494; c=relaxed/simple;
	bh=qkbXwoFMWgtvjuDYoo3cnVt2VFn5qjmYmHBLxsB5LIc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mzuAuFo/dye/AIADqLncYiyACSSpniRg6n1VMwi/YgDH3vy2tAJF/ldQPFUmoZBUJcXCjKMVvbuiyUlVne7/I7/RCo9qCa2ApJ9jgyz1ptRs3hAx1vH+cLfa+DWx8/jfcLsKfwSMuehsHZA1G6ararPPeH+Mg8TCAiC4VoO73cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=NZ7nhA/j; arc=fail smtp.client-ip=40.107.8.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnoyNAhbnewsS3uB/KrYzAkJNHL/F+HAsjFPzZ4kwIaiKtc9QbXTp+TgtG5VisSTcARCsvAnQWDGtwczc4hwZPc0R9FKQerIIKxeBgkrGahoZrc+ZrxwSYcLFc+0bqZ+TxyLXyULqHgOqqpB+KmGt6AjmT4MM/iPwKSJsCSeSaDoisMrGleZcWPAdqPjfhGzPLf38QhQVN96+ui7SB2jfRzK7f9czdSK1HiK7HMjN8ChOJFqW9iC7qdYcBbP/nK1JWfWb9de0Bh6bYNcXCPf+bK81U6O+XbMkCIywN0/x897AmFHpgdoCF+HgpwR6BCBByrxM4mNvJseJNE9zY7DzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3v2aNl/WA9kBdZgc4EffaOTYv2FQ0HK3dn3wo9MB7U=;
 b=W6d6HW2oS5ZlPAiOJXtQvhy12Y28KrShHrwCAmCV3RNSXrxKOtrugqJeGvFjz8c0HV8chvLssdZdeUrWloMSnddJi+SLTG7ZXETegmyXeAAm+Q0VEHbjcJ7SHZhSC48KoVLAtSMt7uQjt64HJzxGQJiLyTMuxo8+cOS9bAFPDqTSfNIk09YI/6I1WAym0dmxR8SZTHnRmBo2d9+iI3Bd9pTphIvT1290FIIW0IwS4D2wnNFpoxijvTxbzX9hkez10hBP244saQgDWiKmjFYZNgGDjZ/tkg7i8XsbWzBz+hI7bE05ecLrZqv4xA3iQclcAJQo5e9WIFz+R/SlkzhQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3v2aNl/WA9kBdZgc4EffaOTYv2FQ0HK3dn3wo9MB7U=;
 b=NZ7nhA/jChaurxUbn8At+NkUcXhxHYR+jHmCPomAYHfM0+VKHR1dkQdGvhq1S07PHAANlYasiU19HS4zKC+bQyrybVe2BgLDVssDA6IE695lsYDO5VP5Xr7GjQs4iZB6ze+t5u+j3v2/O1Pv80+sMHukUZ3SoG90AT9vLjK0+vA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PR3P193MB0764.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:33::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 20:54:48 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::83c6:a213:7935:ae6f]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::83c6:a213:7935:ae6f%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 20:54:48 +0000
Message-ID: <91f600ef-867b-4523-89be-1c0ba34f8a4c@kunbus.com>
Date: Tue, 20 Feb 2024 21:54:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
Content-Language: en-US
To: Alexander Steffen <Alexander.Steffen@infineon.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Sasha Levin <sashal@kernel.org>,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
 Kanth Ghatraju <kanth.ghatraju@oracle.com>, Peter Huewe <peterhuewe@gmx.de>
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
 <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::18) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|PR3P193MB0764:EE_
X-MS-Office365-Filtering-Correlation-Id: 134f3d96-ffa1-469b-0c75-08dc32562d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vZiVEBRq+j6N8wdDC4knNmq6D/iARcu55CVQmgVuGovl3ea1hLLeJRE+6IuI7mxsgetRFOUJ0uNL+XHaw63MLSGiCG94GzuX6Gh5Ev4bZ4pMyUu2ZHzjTbgtWBJgPDBMj4CpUZVpFj/z1p/DAcWZdHEo7n9+Fy2PiKZpB1jRchgtp1cb2xN3kORcHHkAqJhMJNLfyR7J7lp2vpxnqCBNsPuIuXdnjYPHZuTww1a6aRIm3ivsacakugl3YZKWTB45f/cJ2uC7/wkeR6WqyBhC8/qqGvEiEfFXeE94rx00726UQf2Vte/MjyLxf9EoRgPSEIJHgH6uf9jSgbp/tcyw6rKpCAvAtNUw8AcRYPOWaqkvESSihR9CPrK7PjMI9Lrmg2tAWkTjdbKBAiG99cNmKkVeyKE96GfgSCGCA5no85PDhNRvGUk75hS6jqlnFYoA4PiUBOuiFGW4q3eI32VbULQD6niIeBNHmnyOyvVBeNsueF6MNoL0xZ1WIiEp57F0tBbEpqFxrugdRVH9W4Gl/shWCJfrlTpMXkYmtRsWKTzTKPz54789KaLOgdqAr5qz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTc0cFBQd29WUVBVTGNNSCt6MnJOWU95Uk1PSlpBZURzNkJ1c0t6MjNEVmJy?=
 =?utf-8?B?eEduL2FkNnR3SGM5TXM4ckYrTC9ldUxVUUxDL2Y5N0tTV29CbnppUnJKNUs4?=
 =?utf-8?B?bUJTb3VZc1dMSitKYzIza2NiemIxZUdsWkNyQ1VsckQrQy8wNnlSTFhZMnpD?=
 =?utf-8?B?VXFJN2J2UGY3QnQ5SndtZVloN3FKZ0hVUythMml6bmgzdnA5ZXRGWUZCQ3I4?=
 =?utf-8?B?bGxVRmRRSHl4WWViNGcrcGhYc1M0K09wSms0cnJyUWRSNUdISmFXUFc3cHpk?=
 =?utf-8?B?OWcxVEl3MmlPajRqRmRnMVdLRTAxL29sMXRrc2FJc1lTd0tvajN0S2VvdDlv?=
 =?utf-8?B?d1JqeUxrTUpsTlJCUmpFemExcWdwWHIwNGNsNmxoL0JVZ3RrYTU4NTlwRFpH?=
 =?utf-8?B?RHdkbTBaZGxxVjJyemxibjVXYlg4bEs1T3haNHpUSURhZGFCRDZTbjA3NGg1?=
 =?utf-8?B?anlaVlBORXF3RTA1UnRZMno3ZTdGZER1Sm1yZkhORkcxS2ltZSt0TGYwSWZk?=
 =?utf-8?B?Z2xkSEErVkxYVmRvS0M4d1p0bnJKMXNRdVhhVFFIakZVQnJNaHhqVDRFeEN2?=
 =?utf-8?B?RzBWbEJXZXJ6QnhXZXVyNW9mbGxiRlNFSUZHaWx3b1FUMk1XUDIvT0tHMEps?=
 =?utf-8?B?OVhlVElxcjRneVhSUGlpeHBGNHJoamJreEg5TG93YnhtZTBWOWJrM3BGVExX?=
 =?utf-8?B?dGhoY3lwTHNmcklXTWRPVXEzRFVNVXlsYndubk9nU0FFSDZsWERDMS9WZ0Z5?=
 =?utf-8?B?VVVJenlwQzhFbEpCd0JLVnVWOVRnUzZVWXRCbkx0eXgya0JPRmxnK3Bhbjhx?=
 =?utf-8?B?dWFNdWt4dkU4YkFRYXg4dnlMRUlTS1l4R1dVYTRwUjNEOEY5RTQ0M3ZTMVVp?=
 =?utf-8?B?UVdIcEtKR3NhMFRMcGdVUEpnUTF4RmJjc0dzc1VSQ080cExVUlRMdEp2M3Zj?=
 =?utf-8?B?ZzAyeVNNWk5MYjRSRFFJNUR5QVc4NEhwZ0huZGFsckFiM3FJZFNKeWxkdmJR?=
 =?utf-8?B?cG5SOUs4VzRaS2FaNVk4ZlRhZmFzQW1rdVFyM05Lck8veHJFRllnZnppb0ty?=
 =?utf-8?B?eU51ZitzQ0FWcG1mZ2h6TDlSSTFwcU8yaU1BMk8vb3FTTzVxT1pKMjR1UXV5?=
 =?utf-8?B?dXd4aVJ6bUIzWG93aHBxa0gzcE9wLy9sYUNTa2Y1dXU3dGh1bkFZUk1tZjVD?=
 =?utf-8?B?UVpVZ2tUa01seWE3ZXZaUUllalJaVkx4N0o1LzZVbW96NEFwWE0zc05tZ0xi?=
 =?utf-8?B?VWcxOGgweFpSelVTRXBUSWRtZDF0T21CNGxXS2ZRZVh5VTlyZDBMSWxUb3lv?=
 =?utf-8?B?Y20rRnM2NHA0bHZhcE96RURDQTJQVkp1UVphcW5jdFp2MnRpVnZBWkVqMGRk?=
 =?utf-8?B?Nnl4dk4vTThOQWl6VE9qQTNvdFdvNXk2cGFubzdZd01BNXc3Z0VHK29VamZ4?=
 =?utf-8?B?dFRRem8rQXFNTlVJZmFpTEZteHA5Qm54TmcwVzdRUkVuRGwyd2lYL1V6cURR?=
 =?utf-8?B?dzRsS2d3M2x2Wllaak1vUnZSYm9VdzRHZGZNV0VOTERJK1dpN1RnSUpFWmZo?=
 =?utf-8?B?NGwrRFZ4Smh1UTZ1T0UyWG1PdTFYdGU3Rm5qZi9acisrMlBUV0JrSWJaa1ZY?=
 =?utf-8?B?SE93WWdxb1ZNSmdOZjJGT2F6ZTY0RWJKWXV6eC92bGpFV3FsNk1kM2pGTGNv?=
 =?utf-8?B?VVdicWx5YWNCVDltMWdjbHlyYnBRNTI0MW9VNG55VXBERTdvcFhKUDl0VW1m?=
 =?utf-8?B?SHA2QnU4cGlCTnFSckJTbXNGWHZUUkNPWUtCNkhVQVNXWmdsaGdqNXhFVTZD?=
 =?utf-8?B?YkhIZ1pOVFlscGQ3V0xPa1kwTjFXc1R4SEJiMGdqOTc2cW0zYW84d3VCZTRQ?=
 =?utf-8?B?SVlEN3J0cDNaQmV3cEt1NUpLR1QrNzF0dUt4Z3RndlU1b0gyZ0VKWXVHNVlP?=
 =?utf-8?B?REE4aE5nSWp0ekhZSGljZzIwdU1mb21qaU5xbEx3bGx0UkhVbUpQd2FrT3dv?=
 =?utf-8?B?K3pydjhXWmZzR0FkazlwNVdRUng5VTZiUnMxS3NVMUlzaFIzZ3dTKzdCRjg2?=
 =?utf-8?B?LzBXckRKMXZFalRURWlmbVpKbjc4SGFCTFJ4RGxxU2g3TDVJQXEycHlaeXBo?=
 =?utf-8?B?RUh0NEtXWXJNMWlqb3hZd0toRXBxYk5BMStDdG44YmVmTzYwYUtOOGF2N0U2?=
 =?utf-8?B?LzBuRm1TQ2ptUjk3VDQvdGJMM01meTBMK0hBRlloSGxDL1pmVkEyMTA0VnFG?=
 =?utf-8?B?MDNseDNFa01wczkxUzhlcmgvU3NBPT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134f3d96-ffa1-469b-0c75-08dc32562d03
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 20:54:48.5151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwcINVKhUbsHwn14o2ieXSHIiy6FVZKIWLy5v8nnAwCOq83X7ow6VXfbASEKyyRUB9MlggWAbeJuzKMMj/ygKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0764

Hi,

On 20.02.24 19:42, Alexander Steffen wrote:
> ATTENTION: This e-mail is from an external sender. Please check attachments and links before opening e.g. with mouseover.
> 
> 
> On 02.02.2024 04:08, Lino Sanfilippo wrote:
>> On 01.02.24 23:21, Jarkko Sakkinen wrote:
>>
>>>
>>> On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
>>>> Commit 933bfc5ad213 introduced the use of a locality counter to control when a
>>>> locality request is allowed to be sent to the TPM. In the commit, the counter
>>>> is indiscriminately decremented. Thus creating a situation for an integer
>>>> underflow of the counter.
>>>
>>> What is the sequence of events that leads to this triggering the
>>> underflow? This information should be represent in the commit message.
>>>
>>
>> AFAIU this is:
>>
>> 1. We start with a locality_counter of 0 and then we call tpm_tis_request_locality()
>> for the first time, but since a locality is (unexpectedly) already active
>> check_locality() and consequently __tpm_tis_request_locality() return "true".
> 
> check_locality() returns true, but __tpm_tis_request_locality() returns
> the requested locality. Currently, this is always 0, so the check for
> !ret will always correctly indicate success and increment the
> locality_count.
> 

Will the TPM TIS CORE ever (have to) request another locality than 0? Maybe the best would
be to hardcode TPM_ACCESS(0) and get rid of all the locality parameters that are
passed from one function to another.
But this is rather code optimization and not really required to fix the reported bug.

As I already wrote in a former comment, the actual bug fix would IMHO simply be to
make sure that no localities are held at the beginning of tpm_tis_core_init():

for (i = 0; i <= MAX_LOCALITY; i++)
	__tpm_tis_relinquish_locality(priv, i);

before wait_startup() should be sufficient.

Regards,
Lino

