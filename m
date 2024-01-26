Return-Path: <linux-kernel+bounces-40054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA0A83D97C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DED6B2BE57
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5224417736;
	Fri, 26 Jan 2024 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="h+yzIRVe"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2059.outbound.protection.outlook.com [40.92.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357CD17582
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706269045; cv=fail; b=rqYF8BQ+rz2V7wlsKi26l81MzxICDb+auruaxjXTD9kNv5m03wwoyGtDZfGcIXsMs9UZRx+QshBfSHkHCjrTrpnAd7Pb/6rNjsPosyEuKv6EV/L192TSzgc6TeyJX3cp54sTP9W951SjeKYgIEnmDppRL93WqSTDE0EASe1GbrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706269045; c=relaxed/simple;
	bh=3fLqaE0MDvxknzmc8UJlElt1by7gXnL/YoYmHBscIbY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bz33CN/EwvNhnKiaR4TNQOGDe0LgKsSJOJ5XHxQ3TV8S5PqX/oIWdVT93mc32ZwkZUCmD34I8L1cGEbGKty5aSo63BDM022AOJjKD4xN1d1s54AMuuOp6DEnkDJHcshglSL7IBDmZYUzk0Cwx9ZpAjgpit+35KZuZtNtdczakfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=h+yzIRVe; arc=fail smtp.client-ip=40.92.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJzJVxEfLkOBIKzw93JawXnQ3W00ep3LJwHIl/RwH0xN0kUUvyoTxfDLifzR2m/M1nkmxuvkQUdwSUaY27oe/CD1DojPJvrqVbRuSuHfiFkLaOvVTOFBBgAsAy1oS3pG9gkSvdVtt6bAo33Aj1aNOGC+hwR3XfgTPUo+3+CwjGNcCOQWAMm+Hb+tqu7keMmI8Hd1MKUknNsX/1E5dDgxCv6tmqBn9xyyMbtY1JXY4cNTiTRYxT/bC98VQM7krUT2jNE6XVFBDhQnVnW/MImN40IRpjRxSMZGKX7FNDWTlJqaQQMHSpkigFBFDzuBkgSz7+cN5xgMXsZXS9eL8S7usA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOHZjkMeetyDk0N3TahToDyxB0gmy71VwOspoc3vz6s=;
 b=kL7X7W8uMtu1HJw2d/w6xNzdvLRdiSMO29mScbp5O/TsRNljUNRfR8/Yq2i7yVaoXYUBuhCyrQ7vZ0gw4IhaGvzNkz2wWlYx2WACrpT7BU9Mvto+2tQhbw7nD5Vp0/9CVg2pzM+GXKhqopZCOdgCcxkK9+UYN7LldTh2i/sQuPiXNjaejfYvNqRlm0Tg63+cjOxHifjNwY64Wz/8geLJx9d1jVTlPwjjtx8Dj0goYyZHBdK1ND8n0yA7e9OicCvInTyqyjYlW5g+qOjDMxvl7zQyjN95sO7dDNt16lTWIUHoLcIe8ypCd7VnII1xZ8+fLv3/yMj7YNsy2UO5x34bWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOHZjkMeetyDk0N3TahToDyxB0gmy71VwOspoc3vz6s=;
 b=h+yzIRVe46WOR7HwV8Q1HBrs1jHs84mIsD4mZuHmo3Eenq6umf/7fI5EMhYHaelchF+O/mc8PzPKRBCmIGtndoytq3XCOrQ5iwu6K8Kq2zwpXcfs7jHEcOPxwAv8ViugwdG3eZcmSbBKem6e8FpyJtVskOcTxawQVnYlZDeJioiT7JGvDxVEj0rE1+WLvw0G9Buan6WDpJ3woFzMIWrciz0Sm9SkVrhFnN2BPbVR/kNO8gR8PJD2P6MX3s66Lyv9u254RDozn9afuhLBZPcK5/+0DiVZzXHC+6lYaD0b0Y4ZLrbCfTSutsy6S9128TMQo3pVG5RxfBar/oJS4dPkcQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB0632.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:160::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 11:37:18 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a2d5:82f2:b6d4:f2cd]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a2d5:82f2:b6d4:f2cd%2]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 11:37:18 +0000
Message-ID:
 <MA0P287MB282205C98343FC2FAC20BB28FE792@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Fri, 26 Jan 2024 19:37:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Setup proper info for SOPHGO vendor support
To: Conor Dooley <conor.dooley@microchip.com>,
 Inochi Amaoto <inochiama@outlook.com>, Chao Wei <chao.wei@sophgo.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <IA1PR20MB49534A5DE79A6CEE57301737BB792@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240126-squabble-vitally-7dea14d09e18@wendy>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20240126-squabble-vitally-7dea14d09e18@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [MsHtGamqqtwx4vb+1olWOxZs+gwyQ4D7]
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <7b3507bc-629b-4ff0-8766-ca25256803ae@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB0632:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f860891-8972-4e63-8f4f-08dc1e632617
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AOIM+3o5RXjr+b+9D8y89Z5GLWk00QrEkmmCeLrDHHDbhLd8KPHkzCim3RhlQNeKDu4qkhQhuC9HOQMaWogjoic9rMLWtb1cjkPpO18RuRW8DpE9QYdwhAM4hcmvTi/DXhsUCpiI1AEqGnKxOy1NaIFklliJ29uWu47eRGoTALA0x4q8EDfnVgz/pBH0EiV+xKftoISFjnZfSh3zQGzu037Y51urzUU5wek2/I9YryPFnSnMzCx6wIzk+MtaAh2JobWm8YaCLtHfgY0BtD5DqZivYnUn0XMAsq1Pp7wKRvCoVMmDnTTp7GPhBsGptk5N7Km/iQmOMRHuHf2VCOtV0t9HSArKRQ4yTd9ixRX1nzUbzNei//Qq9Mh+a8Ck8fG3y/nr3HLNkeU7YjZBN1r/M4Q4fYITiEDAFevfSuRdNEd5yHcecEaVKJY9s/HONjFzQRxwwDeZiR/lr84lpeZJkNb4ZabGeTVOagY92UkeFrvF6JSUrbySy8TetzTPsX3wJrgJLgYxD73T5KQTS70B/MhL9wcy/SUSaluXAs/ZMos52SOQfQ2ntR+BrPEuaHfOS+EedQ0LtlMi2ON+G2O9tU44ycyHDQK2Hki6YezVjMo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajM3aG9La1VNWnJrL2ZNNEVGMkUyNHBjMW1YYmxURUNCRjZTcGpRczV5Wml5?=
 =?utf-8?B?L2ZZVEpCY3JJVUU2V01KVWUrVGVnUHBkRXVLVW9jVTBNdENHUmw5dkpYUW1k?=
 =?utf-8?B?TDZXUk1HWlBsWXIyeGNBcktKS2JuSERtZnVaa0JXazU4blRiVklHdFBzOHVF?=
 =?utf-8?B?dVVNNlc3SFN3NjZrMGlvOHZKbTZZVHpMZkFIS2xoQU9DTHU1K1ZhaG9aa3Vw?=
 =?utf-8?B?NGRRRHE4akg1clZKZUwwSlVKUG9vTzRaZWVWQUxaWEdOYlI4eTNEaDBEYXRL?=
 =?utf-8?B?Nm1kTWRPTnNQeU12dzhhV2NQMFBldkJianhjamJPSG44WVJBUzh6MmxXa1JH?=
 =?utf-8?B?QTdReVFnanU5NEdQSE9TUkZramtPOVNSd0liYVI2NlNBVExtVUtjN0swbEFC?=
 =?utf-8?B?U0hib0tqVy9vL1R6SENrSmVGRXJrVFc5ZkZ3UmMrMjQ2NVZBWFprTW1SQUs2?=
 =?utf-8?B?b0psc0U1NDYvWTNJWkdsUVN0UHl3NUFvMW9yeitqRGFIa0hUQkdQb1ExWmV6?=
 =?utf-8?B?MmR1K3ZaUzl3STIyMk1jbEFwVktXWnFTM05aTDZzN3hmQmV3ZGhvcm5IRWM1?=
 =?utf-8?B?YjNCZVR4ZTF0UENzbDQzNG85alRPNFZHQVlBaWVzY0gvWkNmSk1SYndPME5K?=
 =?utf-8?B?bFdvQU8xUzM2RHk2OHhpNlpqMTBzU3JKU2h2UjB2aTA3S3NpRktQeERRaTZi?=
 =?utf-8?B?dS90V29TVGM1VmNrUTd1cHJuSmljc1A4RlJLcmUwbWpSUVl0VU1rcnBxcWxK?=
 =?utf-8?B?b2FDOU5ubFlSZEhyOUs0WCs2Q1NFcWMvWUd6UDBQYnlTZXNyQythbXRQaWoz?=
 =?utf-8?B?MG1VY3QrajVaeVVxY1ZJK0wzSnljWkNUM1ZJNkJCcjYzN3VaeVUrQVlzYmo1?=
 =?utf-8?B?OUFzUFJvSmI3UDlHRExQRFJMb2dqTnQ2b1Q3UnRQYTBxQzQ5akp6Qy9ia00r?=
 =?utf-8?B?QnlPbDNIUFRHNjFtV3VSVDRZWWZlcjZRSUNqZmpTWkFiR3ZqakN3K0tjeGNz?=
 =?utf-8?B?LzBKR3B1UEcxTUNIcnlySk1pSk1lSUNSNkI5eW41ZVBGQi8rd0V6TVR3M1pa?=
 =?utf-8?B?MnlwWVRkT0tXb0J4b1V4TjNjRGFiQmpxUWNmbWYvekdFSSswcmVxME1kK09H?=
 =?utf-8?B?b2VxSWwva0lSMmhoZVRrVDVvbER6Qlo1TmlIdk1ucjhhMDNHVEM1cGNMU3BJ?=
 =?utf-8?B?QnRMUkZvamZOZnZMNXU0RVdWYnM5NjhxZEZZUHpud2d2Y1JpdE1BczlSam90?=
 =?utf-8?B?aWtGcXlXRnoxY2d5YWRFMmlLZ1pHN1V5UzY5SHVVOUowckdJbEk4OU1lZkZh?=
 =?utf-8?B?TGdWNG8yMlNwL2Q4V2k2QmZUVTNxR3cxQVBRWUhSRWZINDBzbmFHMVJJZXVk?=
 =?utf-8?B?ZS9LdWduQ1VEMzA2b0FzTEdkQ3JBdVN4cG1lSEVXRjJNOUhSUTBLMmRGaWlr?=
 =?utf-8?B?bHNTWjV0TzhEQXZ6YUdjMndqcW42U2hHMVJCTXVxVkxzbCtWUUNWdWVUSGVN?=
 =?utf-8?B?N28xZURFOGRwenpjMm1XV3FLNU8vUjhvNkZCaEJLcFhnZUNzdzlTZjVkK0M0?=
 =?utf-8?B?MmdjWlkwWHlDZnZLOXVsNzVSK0lqdTE3K0xSZGRYSEY3U1dmYzZWaG9CblZM?=
 =?utf-8?Q?pt9so6k7VtKQrrs7x0ceg7pIXXWKKTYp8D5B1hHj1y1M=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f860891-8972-4e63-8f4f-08dc1e632617
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 11:37:17.1607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0632


On 2024/1/26 19:03, Conor Dooley wrote:
> On Fri, Jan 26, 2024 at 02:04:50PM +0800, Inochi Amaoto wrote:
>> Add git tree that maintaines sophgo vendor code.
>> Also replace Chao Wei with myself, since he does not have enough time.
> Ideally Chao Wei can spare some time to ack the patch though?

Adding Chao wei.


>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> ---
>>   MAINTAINERS | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 39219b144c23..0dbf2882afbf 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20446,12 +20446,13 @@ F:	drivers/char/sonypi.c
>>   F:	drivers/platform/x86/sony-laptop.c
>>   F:	include/linux/sony-laptop.h
>>
>> -SOPHGO DEVICETREES
>> -M:	Chao Wei <chao.wei@sophgo.com>
>> +SOPHGO DEVICETREES and DRIVERS
>>   M:	Chen Wang <unicorn_wang@outlook.com>
>> +M:	Inochi Amaoto <inochiama@outlook.com>
>> +T:	git https://github.com/sophgo/linux.git
>>   S:	Maintained
>> -F:	arch/riscv/boot/dts/sophgo/
>> -F:	Documentation/devicetree/bindings/riscv/sophgo.yaml
>> +N:	sophgo
>> +K:	[^@]sophgo
> There's a single instance of this "[^@] business in the whole file,
> is it really needed?
>
> Also, you can fold in
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bf107c5343d3..cc8e240ba3e2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18859,6 +18859,7 @@ F:	Documentation/devicetree/bindings/riscv/
>   F:	arch/riscv/boot/dts/
>   X:	arch/riscv/boot/dts/allwinner/
>   X:	arch/riscv/boot/dts/renesas/
> +X:	arch/riscv/boot/dts/sophgo/
>   
>   RISC-V PMU DRIVERS
>   M:	Atish Patra <atishp@atishpatra.org>
>
>
> if you want. I get CC'ed on everything under the sun anyway from the DT
> MAINTAINERS entry, so this at least might reduce some confusion about
> who is applying what.
>
> Cheers,
> Conor.
>

