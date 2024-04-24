Return-Path: <linux-kernel+bounces-157397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB598B10F9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBCD61C23BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC40F16D4F2;
	Wed, 24 Apr 2024 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cCjmb7+x"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7290516D4C6;
	Wed, 24 Apr 2024 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979520; cv=fail; b=L7nqoJI+20p9rwAaJAlroME8pLCDLsMXrOI0WccalOn+RYzh7guTu8qLilzxcRRH5Fhx87rotkteTsDuc4H+J8FotnhfYQx8BxiujuqICyAqtqYrwjYc3MZnONwzCckBWkBjBpXtCewKQRTJ3uSAWNzAmgnUu9ehvZ46El63luM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979520; c=relaxed/simple;
	bh=InhPcvjj3xBmVTPDuNuwiqC8K2suQYKZxNXx/yFZYWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YWP4dBQSSpeuliPu/DtEJf0xI/f9K1x52iQfoEHnZ0pV7YlMPX94+NSo5naMPmBH8mjx9t292dCtJBPz5vGH6rEAgqBEeNIovIC8t6ZG6jeJ8WEkk9jQkwTEVwHWo5+NADl7DMu6rS5MFFpPMt8fIZn4tOiyMLN6Cb76+m3FfAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cCjmb7+x; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJH9eNDo7jI2yeXaL0eT+P6qUnnw0s+lbeTLsev7BUabEOO+CACU/6zqMxCVsyLRS/W7b8/NP0dX/TbFtIKxAGReSehOqcT7t5gtZMxb3evCqisF+oDRhrpb2jbavi2/AB/t9VnZZasWBoF9uE9e6YCtt/pidi2fKJF5NCdAbKifrT//8Iy5X1JsNwVNRHY4z3tMxkBsV8qu5Mi6Ij4RL50cEQ6qbpnZXb4t1FSwWUH+QC3NnYya1BGLoaSkYt3ipuXL0vLHuWll4WmHR+qQOf5F9E6JxmjxQrnv+c48uIi/vYeTF5HZL5Jh88IyRlnzXscnWRD6a8agDvgRZh7buA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InhPcvjj3xBmVTPDuNuwiqC8K2suQYKZxNXx/yFZYWU=;
 b=DBT8PRCkftLWqnPkpQlNoGIVQdbjEFyICGPMMnlvECaUJD4V4BX39tfS55pXIWlKp4qKQ5WmMRHNYuOe0BLD1iBQDWkyA4U/1XqAWMJLsPSXcv2kge6a6bMgn/HAhc8IFMSF5R8Zy6fqYPCsrJyRjX4OrHKwAkcsyQuAvdHY2QTf4jpicG2Rk0awV1aW2746zOB3EUvJfRuOs5S3/4PaN5kvDnlZJJk4fNWaWr+rqcCnuvyoIhRkvUXdpM4Ad1OYptLIZO1TNsI3mcCwSk0AZv3m9QtjKLDKbgsc0vo+IdtAn7xVaqOTmdbWrI3B6ic7wKNdbY+k025eS8fTNMabcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InhPcvjj3xBmVTPDuNuwiqC8K2suQYKZxNXx/yFZYWU=;
 b=cCjmb7+x5bsAAdV+qRtlp+Hs10Jda03CfJoHAvbDAtykibIxZDIY38EOMwIBO939fIj30a6mea7r35qljYnBy94Qg4qwp++vid/kQyR4BFMwse8BV4RE/c+fIMMiVtznzlhu2OIOhteyGVky6oIdy/CdLdhmIuyr7LgALsD+HkTCk6exW7qoRjrzuoC6y5Sf9+CnSqGngRaYO+QKA27/oLGrq/IO1fWSQyyYmr7jLGdu+/ZcHrBc17mnZM+JH4PC5oZ9AoYr/K0vHJKtnDysIYa0mZ6MPEdEF+p+W4A+ObslIqPUZncxwNL1VBa8QMYobQbX8xEMaSCKOklxJ8xpPQ==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 17:25:13 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::a8dd:546d:6166:c101]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::a8dd:546d:6166:c101%4]) with mapi id 15.20.7519.023; Wed, 24 Apr 2024
 17:25:13 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
	"edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "almasrymina@google.com"
	<almasrymina@google.com>
CC: "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, Jianbo Liu
	<jianbol@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
Thread-Topic: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
Thread-Index: AQHalmh2YwjSjfzzmU66VYtjn6H0WLF3q+gA
Date: Wed, 24 Apr 2024 17:25:13 +0000
Message-ID: <4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
References: <20240424165646.1625690-2-dtatulea@nvidia.com>
In-Reply-To: <20240424165646.1625690-2-dtatulea@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|PH7PR12MB6858:EE_
x-ms-office365-filtering-correlation-id: 5cc049bc-d8f4-4bbc-9d71-08dc64838059
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?RFlsWnFKTHB2Q0gwR3VuajlqcjR1UDhoUXdkWXRyN3FhM05zUmwzUkJyMU55?=
 =?utf-8?B?MFRJNU1UdjZjU0xudDIreFBHV1UyNCt4NUtIeFVhVVcvdkUwOCtlbFVUVC9F?=
 =?utf-8?B?Rkl5OGMzelEvOGZVdWhhMDd6a1FSTEt5encyUGhydGpYK1U5a29OOW1uNmJ6?=
 =?utf-8?B?SkFzeHJzd3JEZUtkOU5EUk1MOE9aTENzTjF5djN4eVozM3IxbFlpQ0FPSExZ?=
 =?utf-8?B?UmtLUDRpN1UzWCtxaFlHU0Q4NlBNZWozSU4zY25JSUNlZ3ViMWw0Zy9xTXJj?=
 =?utf-8?B?L3hTSjVKd3VFTHpkN0pTR0dZZTZlV1VGejVkam0xZjZSOG1mWHJlSUpNSnJC?=
 =?utf-8?B?M3ZkQkxjUzFzSmcwcXowaHRjUy95Z1I3eTFlR2o1OXdyYSt3b3ZjUGhTLzR6?=
 =?utf-8?B?OTJzeUx6Tmpwb204RlFBMkx6ZnRJcjk4dFdHbndqVmlCMzhYcFdaaUxUWklO?=
 =?utf-8?B?eGx2N1dZazdmQnFYbXFtVVlaSlllK2Iwd0RMNk1IOUZ6Y3QzdEIza3lXYThZ?=
 =?utf-8?B?WDB5NlE2cFFEa0I0cllrRDVNZ1pzZC9NK2pQRUl6aWVsMVNBbFlVZmwrQWtH?=
 =?utf-8?B?ZFcyR1E4QjRSZS8vQVlONThUSUhxeW5weWhzTFFFdzVnVFFqOTJkeFZBdXY5?=
 =?utf-8?B?RUo3Mjd4blBGcS9kMjRQV29sUTg5MGptdmR0ZmVIcnljNXJ0WVFaMEtKNDlN?=
 =?utf-8?B?aWVlMi9ITUpIa295U2d6Nmh4R2JDV2R2aFJyeWpOa09vWTdxSCt3ZndUU2l6?=
 =?utf-8?B?bTFtNkY0YjNwdTQ1SlR0dklxdmVjMnhrbHBMVU9LcHRHM2ZiL1BFSytSelpJ?=
 =?utf-8?B?aG9JTDdBM3NRNEdTemNJeVRPZStuTkdRYjdsMzFlT3o0NWJTZ3RSUmZ2TCts?=
 =?utf-8?B?c1c0NkpwamtmaW1uNzhER1JLQ2JZbWpBY0YyMEdVZ0lyRE55QXBaQ2h6KzhW?=
 =?utf-8?B?VTk5YUNwc0tmTDZMWmk0ZzA0V2gwdWs1dWpURUp1WitzTGp2ajJtZDd6aE1K?=
 =?utf-8?B?TWpqMXdkS2RPd0hvUzJncnNpaVlUbkxham9sNEpwcjQ2UVpBQmVTZ3cyVVhU?=
 =?utf-8?B?eCtEVzR1YS9jUXYzRWt2T1ZiM0Jjc3owSUpsb3hLQWt1TTFZTjVEa283SUFH?=
 =?utf-8?B?dFA4cXJnWStJYnp1TVhXMGJxN1cxNkpRYS95QVhGRWZxUTNPMHdVRk5LM3p5?=
 =?utf-8?B?TmdYOVV3dUZKRGtXaDU3N1l5cHRHbkk0cEFTYy9BaVI5dG1TcEdKVVpDTFl0?=
 =?utf-8?B?MXU0eFJtZHE2K29DV2pSODEvV1RaMmdOdmZaVjVzRXluV0NUdktBWjlNRWl5?=
 =?utf-8?B?eUp6eURvNmQyRVNnRGl5ck53czZ6amJuaGxRdWMwRSs0YUgvbndYYWZqS1B2?=
 =?utf-8?B?d3paNEZhNC9lMzk4aytqV2xWeVZGejZJdEtiRXVBQS9yOEJOVUhjSFJiMVV0?=
 =?utf-8?B?OWtkNTRpQ0pKN2FxeUlrR3dZV0c1T1RCYjlXdWZyUWdmOVhsSFVQMElPVW5m?=
 =?utf-8?B?dnQ0RVZmcEUzSmlkNXZobUhmYm9sa3NWVTdhTHk2c0RQWnQ2d09KUUJSbkRp?=
 =?utf-8?B?ZnhITWU3Zk1qQzJHTDRzYjVHWWZZbmhsckRvSkRzNkNOSWRQaVhXMGZwdTRJ?=
 =?utf-8?B?NHYzelEwT3k5MUszVUlsNk8vQnhGcTB2RkhHYVl5WExxU1AxS1VVUlJMaUtX?=
 =?utf-8?B?OE9XV010d29jbTRzcGpCREdjRkpXclJsVGFiV0x5NzExRUNQbHBlaHRjdGtJ?=
 =?utf-8?B?U3dYbDdPQWFiR0pLZjk0MlJOQkdLKy82MVFRNngvcDcwTnhiSmsyRUZaRWgv?=
 =?utf-8?B?dU1qNytOaXZuL3BlZVRXZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHR1bGhOYVJXNXB5U3doV1ZyTXl2VkNlVy9PbnE4ZTN3bDJjK3Z6WDZ2S1Ni?=
 =?utf-8?B?UUYrUDk4ME5QS1NpVVh4RHRMRndhQWNOUFNtZWZnYmxXK2NheTcrQWliZFBq?=
 =?utf-8?B?b29BWmN0a2UvNWZrNnhwY2pJRjdkZnBRZlg4cnJ3VExFRnMrMWNFcGg2eVVk?=
 =?utf-8?B?U1grY1JLdFNsMGFtdCtRbEJmZGdJTXZQeFNZMUhoa2ZXK1ZCREIwS0Uzd201?=
 =?utf-8?B?bkQyV3BYY09kLzZuSDh0Rjc5WXc2YThRMmZuTmJadVhVdGZqMFJaajVxdmt5?=
 =?utf-8?B?SXc0dHJYdkpVYVJLcFhIUEQ2V3A3d0hLNjV2NlpQQXpFUXZyUEJxM0F6eDVm?=
 =?utf-8?B?Z3pQdWVMMkdoLzFmY3FFRXdoYnV5M01oM2luUW90VDNEODExbmRTNHhlVDIv?=
 =?utf-8?B?aytRL0NRdE9naTZIR1ZxWVlRbGU3aXZCbVptbzI3N2g3T3RMSzdGN0VQREMz?=
 =?utf-8?B?cXNXbG1TY3p1Mkl2Q1RPL2U2SDhGbE1GWXNVS2dPSW5wMkhpV1U1WjJvZzJl?=
 =?utf-8?B?UWt4eHFWL1NFblBuU0pSYmhXdldtUldpdlhUZEw3ekRKWnpxWnluLzFSWmZQ?=
 =?utf-8?B?djV6UTFoakl0TU9zWjdRRmM3cUUzTmE0T2U4R1JsQS9zUm9xSWxOakErcXh1?=
 =?utf-8?B?Ums3NzJMWDYveW9ncVhTMkdCalRERlBJSUNsM2ZzR21iOGY2bzd2bmdiNW1l?=
 =?utf-8?B?T3VXM0E0NVVrZVM5YzUvNmxzdWJkSStteSt1eTl4YXRhZ21GaHFIMWlSM3k2?=
 =?utf-8?B?d2pwVVVqNlFaSVhWaURMem9yYjJrKys1aldNSzljL1VoVldCWm8wWDRCLzdF?=
 =?utf-8?B?Y2ZaSXF5U2RKL3dWL3c5Nm9ETjdWSFFQazRPTkNXbE1wMWp3RStac0U0Qm93?=
 =?utf-8?B?Y0tiUGx3NVFFdVAyTEJmYUEyVzJVa0xtam8xZEJ1NG9BMkNUeHdFczRJOTVo?=
 =?utf-8?B?ZDlGcDdEVmovZi9WU0hkY0VJWkZ3d0lYMkNRNzZ4bnlHdytoZmp5VDE0RWEx?=
 =?utf-8?B?cGViTjFOdXE0aGMxNVVqcVFzS0Z4V1lsZEtEakdZeUNuQkpjS0JQazU4TXNN?=
 =?utf-8?B?bHpUNE9WSk90dzZ6R1V0d2hvVFc0Vnl4Rjl6cW5DeVVxN3p1MnFZL002VEdQ?=
 =?utf-8?B?dU9OSElrU2YwRUlWcVZ0YVRqVUdKOWJFejR4Ty9idkJIdXdKUHllVkRpckhL?=
 =?utf-8?B?ZXNRQXBxZG8vNGJsbi9rNS9ibTV2bkFISklxZjAxYlpaWmVrVGJEekVJcGZK?=
 =?utf-8?B?WXNjVllrbVZLK2xPRHByT0ljYTZVSE5FSmVONk1SMkpHVUNEZlhhSWVzRnBL?=
 =?utf-8?B?enRURmRrMzZ3ZDl5TGhJaXRWT0cxb2owSUlBcXlDME5NUjBNNGdOMlBQV0pq?=
 =?utf-8?B?L2pvb1FQQ2VXNXVRT3VCb0RDTWVEeUVCS2xsOFhkWDFPTzNva3UxV0xRRzdw?=
 =?utf-8?B?SlYwL3Zxb2FFTG1MMHJyQ3hHQTZocXYvdkdaWnBoeFNydzdIdElrYmIwY2o4?=
 =?utf-8?B?UUlXLzBLT1pndDdnOTNqRmxTUWRHL0NHWkR1MlA5cmh6N0hkUi9wRDRNakRr?=
 =?utf-8?B?blpYendiQkhUUnozanRjMDlUSlc0d01EemNid1d5dXM1OGRxQnE2UEc4V3E5?=
 =?utf-8?B?WWVIYWNSZXFDTWRlYnIxTjYwZG9BS1ZNVHFIUFlWSVlWb3FZL25zUWtMaWZM?=
 =?utf-8?B?WUZiQVpwcTk3ZHY5N2ZwKzVJbC9GZzR5K1lLYmZXRDZlampXYWtPZjhBTEMv?=
 =?utf-8?B?S1ZIUUg0WTZmbVVmNFQzL2FaZUhHN28wdWt1WXVkaHFqdWtPMHFNSlY5K3JH?=
 =?utf-8?B?ZFc3ZFppUWQzYUVLTkowVW52aFo0anQ0V09GZ1NCUWE4TTIyUGYvQ0Mxb1dv?=
 =?utf-8?B?bHhCS2NCTnNaQXVScVBLYnpsRVcvNlV1d3dVM0doN3hyL3RDUjhWNFh3VXc0?=
 =?utf-8?B?MTJPaHU2NWV0T2NDT0NhZ2NONHloK3ZuUlkxRVVvMVJ3T3loRVhGcklaUVdZ?=
 =?utf-8?B?dnR6Q01lUHQ1cExva3ZTdXd4QmNLalo1dThCVXhQYmgweS8rZFlJb3J4cGRz?=
 =?utf-8?B?L2VzQzJJQTlNV0F5a1ViQjB1SnQ3eDROc1dNOTBwNmVaQktNVlVBdVc4M3NQ?=
 =?utf-8?B?cHYxOHZXZ29JYXNBRm84SEk5N1RaYjVaQXl2VEszZjF6R3R1UUlSYnF2THNX?=
 =?utf-8?Q?TjyENFM7eIVLs2LuHB4f2QejXNIl0oJTmjv/uqfreZkm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BFD64DA70FAA74991ED771532485806@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc049bc-d8f4-4bbc-9d71-08dc64838059
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 17:25:13.6329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gGLwVtL4xyWrMsLKTr9S92Uzs1UD1hRb3r2PTlof8sb9oNT2NJiL+Wqj2uyaS6qU9PCuonnfum2llVifnXfXMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6858

T24gV2VkLCAyMDI0LTA0LTI0IGF0IDE5OjU2ICswMzAwLCBEcmFnb3MgVGF0dWxlYSB3cm90ZToN
Cj4gVGhlIHBhdGNoIHJlZmVyZW5jZWQgaW4gdGhlIGZpeGVzIHRhZyBpbnRyb2R1Y2VkIHRoZSBz
a2JfZnJhZ191bnJlZiBBUEkuDQpUaGlzIGlzIHdyb25nIGFjdHVhbGx5LiBPbmx5IHNrYl9mcmFn
X3JlZiB3YXMgaW50cm9kdWNlZC4gU29ycnkgZm9yIHRoZQ0KY29uZnVzaW9uLg0KDQo+IFRoaXMg
QVBJIHN0aWxsIGhhcyBhIGRhcmsgY29ybmVyOiB3aGVuIHNrYi0+cHBfcmVjeWNsZWQgaXMgZmFs
c2UgYW5kIGENCj4gZnJhZ21lbnQgYmVpbmcgcmVmZXJlbmNlZCBpcyBiYWNrZWQgYnkgYSBwYWdl
X3Bvb2wgcGFnZSwgc2tiX2ZyYWdfdW5yZWYNCj4gY2FuIGxlYWsgdGhlIHBhZ2Ugb3V0IG9mIHRo
ZSBwYWdlX3Bvb2wsIGxpa2UgaW4gdGhlIGZvbGxvd2luZyBleGFtcGxlOg0KPiANCj4gIEJVRzog
QmFkIHBhZ2Ugc3RhdGUgaW4gcHJvY2VzcyBzd2FwcGVyLzQgIHBmbjoxMDM0MjMNCj4gIHBhZ2U6
IHJlZmNvdW50OjAgbWFwY291bnQ6MCBtYXBwaW5nOjAwMDAwMDAwMDAwMDAwMDAgaW5kZXg6MHgx
MDM0MjMwMDAgcGZuOjB4MTAzNDIzDQo+ICBmbGFnczogMHgyMDAwMDAwMDAwMDAwMDAobm9kZT0w
fHpvbmU9MikNCj4gIHBhZ2VfdHlwZTogMHhmZmZmZmZmZigpDQo+ICByYXc6IDAyMDAwMDAwMDAw
MDAwMDAgZGVhZDAwMDAwMDAwMDA0MCBmZmZmODg4MTA2ZjM4MDAwIDAwMDAwMDAwMDAwMDAwMDAN
Cj4gIHJhdzogMDAwMDAwMDEwMzQyMzAwMCAwMDAwMDAwMDAwMDAwMDQxIDAwMDAwMDAwZmZmZmZm
ZmYgMDAwMDAwMDAwMDAwMDAwMA0KPiAgcGFnZSBkdW1wZWQgYmVjYXVzZTogcGFnZV9wb29sIGxl
YWsNCj4gIE1vZHVsZXMgbGlua2VkIGluOiBhY3RfbWlycmVkIGFjdF9jc3VtIGFjdF9wZWRpdCBh
Y3RfZ2FjdCBjbHNfZmxvd2VyDQo+ICBhY3RfY3QgbmZfZmxvd190YWJsZSBzY2hfaW5ncmVzcyB4
dF9jb25udHJhY2sgeHRfTUFTUVVFUkFERQ0KPiAgbmZfY29ubnRyYWNrX25ldGxpbmsgbmZuZXRs
aW5rIHh0X2FkZHJ0eXBlIGlwdGFibGVfbmF0IG5mX25hdA0KPiAgYnJfbmV0ZmlsdGVyIG92ZXJs
YXkgcnBjcmRtYSByZG1hX3VjbSBpYl9pc2VyIGxpYmlzY3NpDQo+ICBzY3NpX3RyYW5zcG9ydF9p
c2NzaSBpYl91bWFkIHJkbWFfY20gaWJfaXBvaWIgaXdfY20gaWJfY20gbWx4NV9pYg0KPiAgaWJf
dXZlcmJzIGliX2NvcmUgenJhbSB6c21hbGxvYyBtbHg1X2NvcmUgZnVzZSBDUFU6IDQgUElEOiAw
IENvbW06DQo+ICBzd2FwcGVyLzQgTm90IHRhaW50ZWQgNi45LjAtcmM0KyAjMg0KPiAgSGFyZHdh
cmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwgMjAwOSksIEJJT1MgcmVsLTEu
MTMuMC0wLWdmMjFiNWE0YWViMDItcHJlYnVpbHQucWVtdS5vcmcgMDQvMDEvMjAxNA0KPiAgQ2Fs
bCBUcmFjZToNCj4gICA8SVJRPg0KPiAgIGR1bXBfc3RhY2tfbHZsKzB4NTMvMHg3MA0KPiAgIGJh
ZF9wYWdlKzB4NmYvMHhmMA0KPiAgIGZyZWVfdW5yZWZfcGFnZV9wcmVwYXJlKzB4MjcxLzB4NDIw
DQo+ICAgZnJlZV91bnJlZl9wYWdlKzB4MzgvMHgxMjANCj4gICBfX19wc2tiX3RyaW0rMHgyNjEv
MHgzOTANCj4gICBza2Jfc2VnbWVudCsweGY2MC8weDEwNDANCj4gICB0Y3BfZ3NvX3NlZ21lbnQr
MHhlOC8weDRlMA0KPiAgIGluZXRfZ3NvX3NlZ21lbnQrMHgxNTUvMHgzZDANCj4gICBza2JfbWFj
X2dzb19zZWdtZW50KzB4OTkvMHgxMDANCj4gICBfX3NrYl9nc29fc2VnbWVudCsweGI0LzB4MTYw
DQo+ICAgPyBuZXRpZl9za2JfZmVhdHVyZXMrMHg5NS8weDJmMA0KPiAgIHZhbGlkYXRlX3htaXRf
c2tiKzB4MTZjLzB4MzMwDQo+ICAgdmFsaWRhdGVfeG1pdF9za2JfbGlzdCsweDRjLzB4NzANCj4g
ICBzY2hfZGlyZWN0X3htaXQrMHgyM2UvMHgzNTANCj4gICBfX2Rldl9xdWV1ZV94bWl0KzB4MzM0
LzB4YmMwDQo+ICAgdGNmX21pcnJlZF90b19kZXYrMHgyYTUvMHgzZTAgW2FjdF9taXJyZWRdDQo+
ICAgdGNmX21pcnJlZF9hY3QrMHhkNy8weDRiMCBbYWN0X21pcnJlZF0NCj4gICA/IHRjZl9wZWRp
dF9hY3QrMHg2Zi8weDU0MCBbYWN0X3BlZGl0XQ0KPiAgIHRjZl9hY3Rpb25fZXhlYysweDgyLzB4
MTcwDQo+ICAgZmxfY2xhc3NpZnkrMHgxZWUvMHgyMDAgW2Nsc19mbG93ZXJdDQo+ICAgPyB0Y2Zf
bWlycmVkX3RvX2RldisweDJhNS8weDNlMCBbYWN0X21pcnJlZF0NCj4gICA/IG1seDVlX2NvbXBs
ZXRpb25fZXZlbnQrMHgzOS8weDQwIFttbHg1X2NvcmVdDQo+ICAgPyBtbHg1X2VxX2NvbXBfaW50
KzB4MWQ3LzB4MWYwIFttbHg1X2NvcmVdDQo+ICAgdGNmX2NsYXNzaWZ5KzB4MjZhLzB4NDcwDQo+
ICAgdGNfcnVuKzB4YTIvMHgxMjANCj4gICA/IGhhbmRsZV9pcnFfZXZlbnQrMHg1My8weDgwDQo+
ICAgPyBrdm1fY2xvY2tfZ2V0X2N5Y2xlcysweDExLzB4MjANCj4gICBfX25ldGlmX3JlY2VpdmVf
c2tiX2NvcmUuY29uc3Rwcm9wLjArMHg5MzIvMHhlZTANCj4gICBfX25ldGlmX3JlY2VpdmVfc2ti
X2xpc3RfY29yZSsweGZlLzB4MWYwDQo+ICAgbmV0aWZfcmVjZWl2ZV9za2JfbGlzdF9pbnRlcm5h
bCsweDFiNS8weDJiMA0KPiAgIG5hcGlfZ3JvX2NvbXBsZXRlLmNvbnN0cHJvcC4wKzB4ZWUvMHgx
MjANCj4gICBkZXZfZ3JvX3JlY2VpdmUrMHgzZjQvMHg3MTANCj4gICBuYXBpX2dyb19yZWNlaXZl
KzB4N2QvMHgyMjANCj4gICBtbHg1ZV9oYW5kbGVfcnhfY3FlX21wd3JxKzB4MTBkLzB4MWQwIFtt
bHg1X2NvcmVdDQo+ICAgbWx4NWVfcG9sbF9yeF9jcSsweDhiLzB4NmYwIFttbHg1X2NvcmVdDQo+
ICAgbWx4NWVfbmFwaV9wb2xsKzB4ZGMvMHg2YzAgW21seDVfY29yZV0NCj4gICBfX25hcGlfcG9s
bCsweDI1LzB4MWIwDQo+ICAgbmV0X3J4X2FjdGlvbisweDJjMS8weDMzMA0KPiAgIF9fZG9fc29m
dGlycSsweGNiLzB4MjhjDQo+ICAgaXJxX2V4aXRfcmN1KzB4NjkvMHg5MA0KPiAgIGNvbW1vbl9p
bnRlcnJ1cHQrMHg4NS8weGEwDQo+ICAgPC9JUlE+DQo+ICAgPFRBU0s+DQo+ICAgYXNtX2NvbW1v
bl9pbnRlcnJ1cHQrMHgyNi8weDQwDQo+ICBSSVA6IDAwMTA6ZGVmYXVsdF9pZGxlKzB4MTcvMHgy
MA0KPiAgQ29kZTogMDAgNGQgMjkgYzggNGMgMDEgYzcgNGMgMjkgYzIgZTkgNzYgZmYgZmYgZmYg
Y2MgY2MgY2MgY2MgZjMgMGYgMWUNCj4gIGZhIDhiIDA1IDc2IDNmIDBhIDAxIDg1IGMwIDdlIDA3
IDBmIDAwIDJkIDFkIDc0IDQxIDAwIGZiIGY0IDxmYT4gYzMgMGYNCj4gIDFmIDgwIDAwIDAwIDAw
IDAwIGYzIDBmIDFlIGZhIDY1IDQ4IDhiIDM1IDA0IGIzIDQyIDdlIGYwDQo+ICBSU1A6IDAwMTg6
ZmZmZjg4ODEwMDg3YmVkOCBFRkxBR1M6IDAwMDAwMjQ2DQo+ICBSQVg6IDAwMDAwMDAwMDAwMDAw
MDAgUkJYOiBmZmZmODg4MTAwODQxNWMwIFJDWDogMDAwMDAwZTExNmQzNTlmYg0KPiAgUkRYOiAw
MDAwMDAwMDAwMDAwMDAwIFJTSTogZmZmZmZmZmY4MjIzZTFkMSBSREk6IDAwMDAwMDAwMDAwM2Yy
MTQNCj4gIFJCUDogMDAwMDAwMDAwMDAwMDAwNCBSMDg6IDAwMDAwMDAwMDAwM2YyMTQgUjA5OiAw
MDAwMDBlMTE2ZDM1OWZiDQo+ICBSMTA6IDAwMDAwMGUxMTZkMzU5ZmIgUjExOiAwMDAwMDAwMDAw
MDVkZmVlIFIxMjogMDAwMDAwMDAwMDAwMDAwNA0KPiAgUjEzOiAwMDAwMDAwMDAwMDAwMDAwIFIx
NDogMDAwMDAwMDAwMDAwMDAwMCBSMTU6IDAwMDAwMDAwMDAwMDAwMDANCj4gICBkZWZhdWx0X2lk
bGVfY2FsbCsweDNkLzB4ZjANCj4gICBkb19pZGxlKzB4MWNlLzB4MWUwDQo+ICAgY3B1X3N0YXJ0
dXBfZW50cnkrMHgyOS8weDMwDQo+ICAgc3RhcnRfc2Vjb25kYXJ5KzB4MTA5LzB4MTMwDQo+ICAg
Y29tbW9uX3N0YXJ0dXBfNjQrMHgxMjkvMHgxMzgNCj4gICA8L1RBU0s+DQo+IA0KPiBIb3cgaXQg
aGFwcGVuczoNCj4gLT4gc2tiX3NlZ21lbnQNCj4gICAtPiBjbG9uZSBza2IgaW50byBuc2tiDQo+
ICAgLT4gY2FsbCBfX3Bza2JfdHJpbShuc2tiKQ0KPiAgICAgLT4gY2FsbCBwc2tiX2V4cGFuZF9o
ZWFkKG5za2IpIGJlY2F1c2UgbnNrYiBpcyBjbG9uZWQNCj4gICAgICAgLT4gY2FsbCBza2JfcmVs
ZWFzZV9kYXRhKG5za2IpIGJlY2F1c2UgbnNrYiBpcyBjbG9uZWQNCj4gICAgICAgICAtPiBuc2ti
LT5wcF9yZWN5Y2xlID0gMA0KPiAgICAgLT4gc2tiX3VucmVmKG5za2ItPmZyYWdbaV0sIG5za2Ip
DQo+ICAgICAJLT4gbnNrYi0+cHBfcmVjeWNsZSBpcyBmYWxzZSwgZnJhZyBpcyBwYWdlX3Bvb2wg
cGFnZQ0KPiAJLT4gRnJhZ21lbnQgaXMgcmVsZWFzZWQgdmlhIHB1dF9wYWdlKGZyYWcgcGFnZSks
IGhlbmNlIGxlYWtpbmcNCj4gCSAgIGZyb20gdGhlIHBhZ2VfcG9vbC4NCj4gDQo+IFNvbWV0aGlu
ZyB0ZWxscyBtZSB0aGF0IHRoaXMgaXMgbm90IGJlIHRoZSBvbmx5IGlzc3VlIG9mIHRoaXMga2lu
ZC4uLg0KPiANCj4gVGhlIHBhdGNoIGl0c2VsZiBjb250YWlucyBhIHN1Z2dlc3RlZCBmaXggZm9y
IHRoaXMgc3BlY2lmaWMgYnVnOiBpdA0KPiBmb3JjZXMgdGhlIHVucmVmIGluIF9fX3Bza2JfdHJp
bSB0byByZWN5Y2xlIHRvIHRoZSBwYWdlX3Bvb2wuIElmIHRoZQ0KPiBwYWdlIGlzIG5vdCBhIHBh
Z2VfcG9vbCBwYWdlLCBpdCB3aWxsIGJlIGRlcmVmZXJlbmNlZCBhcyBhIHJlZ3VsYXIgcGFnZS4N
Cj4gDQo+IFRoZSBhbHRlcm5hdGl2ZSB3b3VsZCBiZSB0byBzYXZlIHRoZSBza2ItPnBwX3JlY3lj
bGVkIGZsYWcgYmVmb3JlDQo+IHBza2JfZXhwYW5kX2hlYWQgYW5kIHVzZSBpdCBsYXRlciBkdXJp
bmcgdGhlIHVucmVmLg0KPiANCg0KT25lIG1vcmUgaW50ZXJlc3RpbmcgcG9pbnQgaXMgdGhlIGNv
bW1lbnQgaW4gc2tiX3JlbGVhc2VfZGF0YSBbMV0gYW5kIGl0J3MNCmNvbW1pdCBtZXNzYWdlIFsy
XSBmcm9tIElsaWFzLiBMb29raW5nIGF0IHRoZSBjb21taXQgbWVzc2FnZSANCg0KWzFdIGh0dHBz
Oi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjktcmM1L3NvdXJjZS9uZXQvY29yZS9za2J1
ZmYuYyNMMTEzNw0KWzJdDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD0yY2MzYWViNWVjY2NlYzBkMjY2
ODEzMTcyZmNkODJiNGI1ZmE1ODAzDQoNCj4gU2lnbmVkLW9mZi1ieTogRHJhZ29zIFRhdHVsZWEg
PGR0YXR1bGVhQG52aWRpYS5jb20+DQo+IENvLWRldmVsb3BlZC1ieTogSmlhbmJvIExpdSA8amlh
bmJvbEBudmlkaWEuY29tPg0KPiBGaXhlczogYTU4MGVhOTk0ZmQzICgibmV0OiBtaXJyb3Igc2ti
IGZyYWcgcmVmL3VucmVmIGhlbHBlcnMiKQ0KPiBDYzogTWluYSBBbG1hc3J5IDxhbG1hc3J5bWlu
YUBnb29nbGUuY29tPg0KPiAtLS0NCj4gIG5ldC9jb3JlL3NrYnVmZi5jIHwgMiArLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvbmV0L2NvcmUvc2tidWZmLmMgYi9uZXQvY29yZS9za2J1ZmYuYw0KPiBpbmRleCAzN2M4
NThkYzExYTYuLmFiNzViNGY4NzZjZSAxMDA2NDQNCj4gLS0tIGEvbmV0L2NvcmUvc2tidWZmLmMN
Cj4gKysrIGIvbmV0L2NvcmUvc2tidWZmLmMNCj4gQEAgLTI2MzQsNyArMjYzNCw3IEBAIGludCBf
X19wc2tiX3RyaW0oc3RydWN0IHNrX2J1ZmYgKnNrYiwgdW5zaWduZWQgaW50IGxlbikNCj4gIAkJ
c2tiX3NoaW5mbyhza2IpLT5ucl9mcmFncyA9IGk7DQo+ICANCj4gIAkJZm9yICg7IGkgPCBuZnJh
Z3M7IGkrKykNCj4gLQkJCXNrYl9mcmFnX3VucmVmKHNrYiwgaSk7DQo+ICsJCQlfX3NrYl9mcmFn
X3VucmVmKCZza2Jfc2hpbmZvKHNrYiktPmZyYWdzW2ldLCB0cnVlKTsNCj4gIA0KPiAgCQlpZiAo
c2tiX2hhc19mcmFnX2xpc3Qoc2tiKSkNCj4gIAkJCXNrYl9kcm9wX2ZyYWdsaXN0KHNrYik7DQoN
Cg==

