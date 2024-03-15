Return-Path: <linux-kernel+bounces-103933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B3E87C6B5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BC91C21123
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB81564A;
	Fri, 15 Mar 2024 00:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DfhVS65G"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2079.outbound.protection.outlook.com [40.92.103.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6FA320A;
	Fri, 15 Mar 2024 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710461725; cv=fail; b=AmJHGqoOTJLyCl4YTYU3X3O7DfIZbCwUcYfoGnzIhFmAc7ZR6vmFQjkdBG13Ul5Hdh9QKHvFib5QL4ioL4+lkLYm3YkdmfaNUg61FTmeHEgrXdZ3pQm6WQ1ClriiWfkES92SealBS+b8DXbMzeFdO/QLZYGugDPc6M7/VWTtVUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710461725; c=relaxed/simple;
	bh=zJa2ZL1MGb7v4YU1xUx0aQxF0a5vNL9TBADK60CUFnc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dn3/djB4SbY5SZbi1rLtdOLXxzFECZUDwI1oMlcjfPQ84A95S5ZTa8reYtpk7IwVX+dZbHk5zlffQnmgBNW8nq7E5cIXe6L68yOz2Ziv9aHYPMeBgL5ZHawxDrrryJergDI5bPIqAdE2JWzOW9DzsKCnjg3ydbAK1JKDJWyoTZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DfhVS65G; arc=fail smtp.client-ip=40.92.103.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlVg8bEqBX7Cbgj6RUmqXrQf6atlrjeAYjw8EPxNJllwLdL3L5xkIVB/K/I2GpqXKdqUT4ssXKPKjTHqD0vXRaJMNrAaDoutWGWS0cIv/WZI6V+PH6FGQ7+u+6NsBjrKpFYfz96OayS842h8PBjeIlRBGqRd1sF3m81yDzIG9aAQqOgTQCzW+ePayQc2ei/vha8Uj9aVZd5/MnskWHvn00F7QhyGGc2BSkjaW6DGb1MWhSdse0yjCrP/euIC0im3bunFfy8EEVB6CclgZrWVtNhfh06qsG4a00kMWUSSjz7+qRkP35eus4i9ojxm+5aEaW4hRJ//hSlODR0YSJvdhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSdnMYZVynHK7TuLc1rbW8uELtIsmLS/7kKo6zbSiDw=;
 b=BnfqHnDVo/YX5Yv4j0IX8nzhyycYj1A43cOiVkna+Wsq3W6/+pqHWR8+Gepu/XqZlZsMUuAbqnAqzKok4Qw/qWjup9bnD/E3Y6tfJ1ZQc+r8wjTWKwrZ3HXch05ft4nK/HQveZzOSvL9a7UqRryj1PPRj3Qy6WClvgJZrGBRS4Sh+VaWIdi+tp0R1nmYtdIv+nkmDrX3O89tciiQzMOalTXuurO+zaFvxzJME8iCvCJ5UXQIVvCDHVCRxidVIgJuIRxgNjDHvD0jj+vZVtC8XzDnikG7aZB0lxmLLoLYEkXUL9IMXbP1vbtyupbaPfkeWq3p4Dy9tYGuwDPa3ZG5qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSdnMYZVynHK7TuLc1rbW8uELtIsmLS/7kKo6zbSiDw=;
 b=DfhVS65GCGzgNSij9jxEF5CeIgwC3rQhfvkq0upWMGI79Sqg4oDvB6LA5QtICjiH73/X8gbHoim0webUlt13twA/78hHY1J0JGyWVSEd8pwpeoIQFZ71MfaJjD8Ze3MYbAwSFT6wYOu+UjpifRSlwbZDRlbtR0KYxUovZXoCXGBUU5/MQgFH0UYkFrl/rKvmamI/H4+PkbAZ3uA5xN9SG+hF+JUT0lpc0IAucOSCZ7Rncqn8GwfT0+Q68I8XmO7XgTQ1+ErJp4atm6AV22KcHTX2WEbuAcciGYx+S0YKgPXgGaA4SI6wFOgbKRLzUIt5N5BY8LTlLQUB146y+47deQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB0455.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:116::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 00:15:15 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::64a9:47d2:ce4e:b84a]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::64a9:47d2:ce4e:b84a%4]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 00:15:15 +0000
Message-ID:
 <MA0P287MB282221F8E750206EA615B3CEFE282@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Fri, 15 Mar 2024 08:15:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: reset: sophgo: support SG2042
To: Palmer Dabbelt <palmer@dabbelt.com>, unicornxw@gmail.com,
 inochiama@outlook.com, arnd@kernel.org
Cc: aou@eecs.berkeley.edu, chao.wei@sophgo.com,
 Conor Dooley <conor@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
 Paul Walmsley <paul.walmsley@sifive.com>, p.zabel@pengutronix.de,
 robh+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, krzysztof.kozlowski@linaro.org
References: <mhng-3e62b204-0a40-4356-888f-060c0515c286@palmer-ri-x1c9>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <mhng-3e62b204-0a40-4356-888f-060c0515c286@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [58n8lBTyyaG4AaD59LRZhPXkncGQOVkq]
X-ClientProxiedBy: SG2PR06CA0251.apcprd06.prod.outlook.com
 (2603:1096:4:ac::35) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <54b50eb7-ebc0-4890-976e-20061c904f8d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB0455:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f16d24-6b54-447e-707a-08dc4484fd19
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	or1Fqj/Re25C51tOvMh1IAAH6KAsmNEeo45rL2DzNv75I9kC4pt6XSaz8OfHVEI8EAuzMMK0gBIVML9eodzB/Mimg6Y3Txs/7MtK7fVvMWYTxxUNTeY4Js2E2njph4dYUab5jeXEFKCqp6xegEObkrtaln+NFbKt8YG+W4KamKjlgsHg2HKImtySOtRFne5AhvkGDAe12fhc3dYh5ZZwZAhCoRYskzB08mnOz13uvssHzlzNjIzrBOQwVHlURtWkz6PhdWeSdIsr5Ylp8dQHeL8pP9WwaLlKOM8yaN+Ef5be0xE+DXCKJsOPgLmlS3svAZL2H7xbIsubEudirYjTPHjTdz+NI4HIJCCmxeDP8VaZn2YVelVAWMXKpkrne/D9vcYJG3UjvbapcTp1ioGD7hx+ztZahzZRhg7I6UoqZhByDhK6ycPfOuD3hIVJvqH9FI1IXbrz5uGJzXgyZpmhHHzS1k0C2PBE+ZZvsFOn6Adhg6RR180X6RBJlPKGvt1ahOuuYhJ/hZUZ3DqeJ3TSstiEoqlgstJybyOZYjDYY+HJN2YDr342Yp64JKB7dgD3Fp4uEfGUf0UsYb1ax34IbKgNJ8f77J+wEQ5ZKx97XDCw3nrm3dOLNHDzbbRU8IsjusIWfr8Gdc0cRVnhNigV4d/X48lrpr2um3wW7E4foX0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnVhQnZseERGVjdQMEVDQ09Vc1NZMDJjeVdaMUUvQ1JTSi92Z3M3NllKSHVm?=
 =?utf-8?B?S0FYdW1Hdzg4ck9oekJkQms3Nk93RHJmSXZRa0gxOFRjTlhhZ25idlNFQzVF?=
 =?utf-8?B?N1NHbXM1T1F3TkJQc05ZSEw2WmZmUUVRKzhpYjJFbS8rSzJNTUF6S3dVanM5?=
 =?utf-8?B?WHp3ZVovTzNmRlhxdUx6S3QwcHlLa2pwSzZzMm9OOGlQVTZwd0pQVVMydHQw?=
 =?utf-8?B?a3hHcEV1alJxa1BHd3BKOERlQmdlSmlKc0lwRWZ0cURkMlVpR25ZQnlWQkpt?=
 =?utf-8?B?dFlGNGk0aFZmM2dDK1JYNzN6cTVBdkFDcEJIRWd5dlhaQU11Um9ld1hSSkV0?=
 =?utf-8?B?emdGeFo0T21vNDFHdjU4M05LNk82U1dOYjFJWlVPRlprVGZlRmhaV3FtUHVx?=
 =?utf-8?B?QmUxVlhCTThLdmRFQWk1VHRZUS90TkRLTVNKOEIzbTlJeUNsaEFQeGNMcW5q?=
 =?utf-8?B?QzZhUEFKRkNwMllaTkdNc253cCt0NjIwcGg1SENyM0RQTEhmRnMzSGN0R0hZ?=
 =?utf-8?B?bjQwWUI0RDg4YWZPZW1CV3BZV2pkaDRwRUlFMXh1WXVJUitCZVNYQ25uUk0z?=
 =?utf-8?B?T2xVMTdodVhTWWZmOG1xdDRCR3ZETnRwLzIxUllscDZRWjZiVXYwOFRzakxU?=
 =?utf-8?B?dElWZkN4QldLdk9FdG82SXhXNmNsTkxNSFFZL2xyVUx5c2lya3hNUmgyakVj?=
 =?utf-8?B?akhKUnFDb3B2WTVkMkxURnVwazB2a014VW1qUmZGYnd1ZzBNY3BQMDd6M2xZ?=
 =?utf-8?B?ZVBQQ1g1YkUxenJ3ZlY5Tlc0RWloRzBxWVBmdnRhblRvZUpJdFczcGN0bitw?=
 =?utf-8?B?bTNidmRlUVhUZG13SW1GcmJHNW9ZK2dUeW5TdG43OXhlRjBFZUtmSXFTT3A4?=
 =?utf-8?B?RzA3elFZcGt2dllkc3ZzdW9GeGppbW9Zd2swZnZZSmY2aXBNWXFVUzJPemwy?=
 =?utf-8?B?ajNsTFV5ZTk3bHk3SHJOUlcxRm85dW5MZkM3dHVXamNrRGxXYTlUdE9LQXRq?=
 =?utf-8?B?T3k3RXBieTR3QkNUelJibXM5ZnMveUsweGRINFlkVEVJUlBOS210VG9xdWh3?=
 =?utf-8?B?dnpRQTNJdGhwblI4V1d5RkhjRFBPMU9CVi8xUnRLVGNqWk5ld01JRWR3NU5y?=
 =?utf-8?B?Ly85SzJlRHZ5RmdNbVd3WVFQR1diUjN4SEhraVRObWY1VnJqSVlIM1NZNGtQ?=
 =?utf-8?B?N1F0a1JnSkd4RGpZSXNIR2hMNWJYcTNnb3ovWjdwVHorMUNHWnhkRU9sNHlr?=
 =?utf-8?B?S2ljR3hJVHhkUm5TK29GZkZRTnJQd3RxWktnbm4zUnFhNnNGVCtTejJaZGNJ?=
 =?utf-8?B?S0dxamFoZXMra2VMOENxOXMyNTZPcVJrcGVncHpYY2lXdXBzR2pKT1VWNjFO?=
 =?utf-8?B?ZTVabzNJdnYrZEpaMHMvdENkc1p4aXEyQkRESmpwNXFwdFJjWmhqU0NYeFBl?=
 =?utf-8?B?UEJwdlBWNSt0dFZrUHhvTS93UnR6RE02Rjh1c1M4azhrWVpDRzdOQ201ek00?=
 =?utf-8?B?eklWWFVhUWR2NEpNcUVEUlRGeThBb1hsKzJLckRycjU1MUtuNy9vS0hIQWYw?=
 =?utf-8?B?UXhGSzJvYUt3ZlpDOWtvbnFuNXRTelRhVUdXSUVSS255dzJXUVY2V2pYY2pl?=
 =?utf-8?B?QnV0aisvU1JIZ3pmQkZ3cWJOamVjWVZaU2E4UmxFaFBYYWMrUEFvaXN5Zysz?=
 =?utf-8?Q?3Y9t7wJug20z9FT81HPG?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f16d24-6b54-447e-707a-08dc4484fd19
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 00:15:15.5213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0455


On 2024/3/14 23:17, Palmer Dabbelt wrote:
> On Mon, 29 Jan 2024 17:49:45 PST (-0800), unicornxw@gmail.com wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add bindings for the reset generator on the SOPHGO SG2042 RISC-V SoC.
>>
>>
[...]
>
> This is now
>
> Fixes: 1ce7587e507e ("riscv: dts: add reset generator for Sophgo 
> SG2042 SoC")
>
> which landed in Linus' tree.  Looks like that went up via Inochi and 
> Arnd.  I don't have that in my for-next yet, so I'm just stashing away 
> this patch for my tester.
>
> I'm happy to pick this up if folks want, but it'll probably be cleaner 
> somewhere else.

Hi, Palmer,

I see Arnd has prepared a tag 
https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/tag/?h=soc-late-6.9 
which contains the bindings part changes for sg2042 reset driver.

Let's wait for Arnd to submit, although I haven't seen this in Linus's 
tree and not sure if Arnd have submitted this.

Thanks,

Chen



