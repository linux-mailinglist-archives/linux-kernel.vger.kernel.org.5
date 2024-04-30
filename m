Return-Path: <linux-kernel+bounces-163307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F0A8B6931
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C701C218C6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6142910A1F;
	Tue, 30 Apr 2024 03:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mzvxRtsL"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927D410965
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448824; cv=fail; b=m+MKblldZa8H7uUMnQAVBk911o2UW4vaaX6StOCkjqLoPBVweC8xc0vI4pPZqVt9ETrj343yTdyv6/bpCBRr3dLeGhhgVCRbgFgfytU4jW1X5v4oMlKrZz0PflCecCly/VLXbf59TH5JBtnqEYPQqlNRkgZgjaWEB+J+wvGi+tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448824; c=relaxed/simple;
	bh=mgHxFgpKQ6afxbJ8nJPqlVC9ET8HcNfJBDYr6E9+2VI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tXQcDLQo+/ZZogdVShl6y6I+e3mXMOqddUr22YKXm2axJjZGrZVlpcWqHMMpS+EjyX/aN8Z5NXZq8EHbdrtDJnug+pA4gzsfjcXhs+Gl8o5yCFi8dWeUmLn3qKibcxi5QHhkWbQlUEcDY6WM16nMGgxEMeFK/eYI5rKq6hnNJz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mzvxRtsL; arc=fail smtp.client-ip=40.107.212.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4oBiuYYuNBnk6yiAfGs8mpmvxztpCFieK7I4CNlb3MP6o8S5ouznJVHjFAbTqezOLNtv0bv9oYSltviQpr2XjZRSIkDdWs1Zml1lLHNNAVQ39GnDiL2RuOQBZAesGeaqrIuG26H+IpB9PuBUFA/8D3B7C5hCivORJYP9Ot2mcPCZpCFTuXF4VP0/2USMxnVh38LdhrT2/s7YHSRAudFHQ0Wl9CstdcKYiUeWlM5A22waJunGq/CNWIMI9bcuWarHfzeGtjtZFVZZd1MoJ5pZEfczXhGqmZtrt2WTS52pporyKZ9yzSzLCwndZEA6OX0TLaGUwRnCxSQ/h3Y1ApVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgHxFgpKQ6afxbJ8nJPqlVC9ET8HcNfJBDYr6E9+2VI=;
 b=kqyPb3Acbzh0skC29xuf1/UPpF95njMlr565jZdpqWOndhQ9B0dEwzYcCCBqbS44XyjK3858PQnWB1hhmraggwfD9rEHVuhfpIE7L8gTQ+mbJf1EProvHoZ0NmLhx5kBo/fJGs8cTTiBWzBh3/I5aWQLNS40kgX51FFylwgKhvCEq+PPrw0pcza/SlyP0lf89XE5OPynpkmRlaZrkosuKZ2BZ6IlPTTLe79cP9J1Pqi47YVoeY/+D344jt+WifYnwqsO0XJE7UldeJykoQw9CfjxQxgrbn1b5bxxCbPDmpcp48mzJP8YOJGAonSSyfrcIT5a3CzMmdoESjfCSSRq0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgHxFgpKQ6afxbJ8nJPqlVC9ET8HcNfJBDYr6E9+2VI=;
 b=mzvxRtsLtRCNTvEpN95brpSsw+qBhQSNg2LGZeycK9upqmWEg0D3mS8oon43jghH6YZj+d+qcy4BC0aIwA788XXi0gjhlb5fQSwhHhzyfMcRKKfNHVTLZr13xFu1z8SobGnp+NtS7zQGL6LLIL5Hg4Pa3nzhKxreWtAUujAj5jubL5h1M/q1sWN8iCQ9bz9rQ4Rlss4f12RJ/zfbspPFnbJg+5atoqWPXLBO1FZw+ew+xxMqIduEiP3LKKizjH0BvDxScr4Nitzo+F/I/ikrl1xHnxAdCYh6IkbG0sQt4bd8AhO74JSiGIKktgKJq/mDYqthpe7y8Ci5gGA6frjBNw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 03:46:59 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 03:46:59 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: brookxu.cn <brookxu.cn@gmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-fabrics: use reserved tag for reg read/write command
Thread-Topic: [PATCH] nvme-fabrics: use reserved tag for reg read/write
 command
Thread-Index: AQHamqS0v0NsidyZk0GUPwZHGIlgabGALNMA
Date: Tue, 30 Apr 2024 03:46:59 +0000
Message-ID: <8379e4a9-3114-4d35-9d1f-81ca61351b85@nvidia.com>
References: <20240430021753.385089-1-brookxu.cn@gmail.com>
In-Reply-To: <20240430021753.385089-1-brookxu.cn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA0PR12MB8207:EE_
x-ms-office365-filtering-correlation-id: 9cd38326-9068-41c1-f2cc-08dc68c8307a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?d1laRWNTUFhBQ21vVU8zZERJYWRxT3lXRG52eXk5bjY4Q3dFdmZzZXlGTit6?=
 =?utf-8?B?d1N0MDlXMEgxNGViYk5vZWx3M3FnemQwSjN6MzZjY2RMS3BtM1VzQzArL2VT?=
 =?utf-8?B?WTFDcEY3TncvVmFibDdncDdMZUZTZFVPYWxKSXpZTU1MTS9kVHZDMTZxWjNJ?=
 =?utf-8?B?NHNEU0VVZERxS3BzUFVhVUkrVXBVb0d6WnRDdHpWVkVQcEtUdVpRdUhZRTNO?=
 =?utf-8?B?R2wrRVlOOTRnRktEMFhvbTVoR1NxemlYU0ZxNE5JN1dZdEs2Q3RWaTdLeHdZ?=
 =?utf-8?B?N3FUQm9DMmdkcmJRVDNRSTlSdFQxT01tYVlUZmVEOXlzL1l0WklEMmhJZnN3?=
 =?utf-8?B?cHdjNnc2ZnR1V3d3Z0tFY21QbWFjaXNUS09pUlhvOEVxUmJjeEhZK21wK1pa?=
 =?utf-8?B?MkRqQXZnWE85cVFxODI1djR4dVYxSGF0ekpSdWl0ZXRMRFRFMWJvbjV1R2dp?=
 =?utf-8?B?dEtNc0YvZEhMYk9mWUtqNlNrUkdXMGkwaEkvdEFnOVpseHV1WVVPRExLS0xC?=
 =?utf-8?B?NkZCNkxVRFBwRTFwYm1PbHJycVc0UW1oSVoxWGN3M0ZtR3FmZ1pPMmhYSTZ3?=
 =?utf-8?B?bVJNYXFIcmFmWXAweDhWcHZXVlNBU3F4ckM0cURuOE96UzlYN2pxUXFhSWt3?=
 =?utf-8?B?ZHhBK1luT1RaQjV4OGZ6S2FCSWNsRTVGOENQZExuQlpvZ1JNN2lVQlJUNllK?=
 =?utf-8?B?TnI0R281Ym9Yak1XT2NLektBTkttL0hEOGtacHM1M0RpZTJSUDA1MTBNdm9h?=
 =?utf-8?B?dlhGdE9UMy9UeFYxM1VUUEdxNWdNSksxdkRpQTd4ZUszU3czK1duRjR6NzRr?=
 =?utf-8?B?V0hodk1KUmoyNmNMd0VJOHJyMENRSTFDZVFGUVB3aEFlY2xGdUxYWm5CYnFl?=
 =?utf-8?B?L0ZFK2FEc2w5WnlJTWd6R0ltcmZzQXJjMTNzOUV2MFBvR2NxdnRvbVpsUi9i?=
 =?utf-8?B?RW5YVWkzU3o2dnlhdkt6Z2V1M0lPRXlzZ2hwbjFBa256RWJuTWU3bkM2bnlT?=
 =?utf-8?B?dUtzYTBVWE1pcDhWZFR3a2tDOWFXaVN4SWtHdEY3NnljT0tORlhDaVlCdlhC?=
 =?utf-8?B?YWxCQSthTmhCMDF5ajV6UUl1ZDhRRHVlc1hRN1BOU2orQ1lSdVdDdW1DQTds?=
 =?utf-8?B?YnphdlBtWDNxMS9UVWZGSCsvbFpXakkwbTNIVGs4RFNzZ3RxNDFiQ2gvbkhB?=
 =?utf-8?B?b1dnM1R6UC9tODR0ZmJDQno4S0VvVnFUaFhiY3YwUjFmTU0yb1V1NEt0VXUw?=
 =?utf-8?B?VnR5OHBwMDluRktVOXlraVlVcmZQSG5hS3dYL2xNeUgwMFN5aDkrK0FFM2xj?=
 =?utf-8?B?MDRLOEFBZkJkYjNjT1p4OVo5OGlWVHZTWU82bW13U0RxVCtUWnlKY0dJRkRl?=
 =?utf-8?B?VlljNGE1K3JITlJYaTR2dTlVeXNLVFk0TW1rbWZOcS9pSkViS3hqdCttUzQ5?=
 =?utf-8?B?ZzRTZ3NvNEphM2J1WmU1VkFhU1hoM04zeTJzbm1FMGdBWUROZU9uZGFRZ2Rj?=
 =?utf-8?B?ZXJEWnM5RjZSVm1PV3BaMVlRSklkQ25qV0E0UDZrOEZpeWFaMFlYRnBjWVpn?=
 =?utf-8?B?MzRtb3VXenVVdUM5c2J0bE12SnFLT0dvMHV4d1lVMTVnUm9qajBvUU1WZjcr?=
 =?utf-8?B?SVgxM2wwNVhJTjlBd1JyMUVYTUdZOEltRDNDbG52TXdlOHdSbjF1aE82OTla?=
 =?utf-8?B?ak9PN3NOTmplaWJjZENZTHZVSXRtRVduYTVweGpqNkNoZEgwdmdCSW1xZGti?=
 =?utf-8?B?YWo1UkRoV0xxR3J1SER2SnJCNHN3dkRmYXRjVExqVXUrbWRGRUpmK0tKUWY1?=
 =?utf-8?B?QkxwWDhRY2tRQldpRjRTZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S3lTZTM0VHFDeHZkS0dvcWVqS2NNVlVUVmM1ZDE5Mlo4Tmd2V20vaWRycEdO?=
 =?utf-8?B?VS8wT1VCdDA1RVBuQ2RWVFlZTGJMaHNBSlU3TXROaHFZRVV4Tk5HOFoxMHpy?=
 =?utf-8?B?bDhiSXMyd3VPV0lOdXNMd3pjemFIUGg2S2pGN09ET01yMGtzMzNnWkZ6Q1hV?=
 =?utf-8?B?ZURWMGtwWDZHaHQ0RTY0dkdXcHpnSThZTnRvZFlBNDc0TGl1dHBjWVdCNjJG?=
 =?utf-8?B?VStRejJBNU95OVorMUkweEVJZEk5b2lFK0dmRDFDQ0J6cGlQN0NwN1QxZUxY?=
 =?utf-8?B?TTVyemxIQW93S3pFUHRSdTN4NzVJRnhaWHZ5VGFkbnVJMkJYRm1pWnBDUVc3?=
 =?utf-8?B?STNNNU94ZVpBdThZWDZMektFMUxadGFENHN1MFB2SXpST0F5bTVHV2ZDeHYw?=
 =?utf-8?B?T3NndEwyQmRqMGF3bWsxTmFGZ1U4dVR3QjA4TEtLMnVFemwyTnBpQm5lWlFR?=
 =?utf-8?B?dEc4YUxURG1SdHdOWE9YQnJta0ZSdk55cGpBa2hvR2NCTnhWcVRTY2ZwbGpH?=
 =?utf-8?B?Y3prM2VZUDVFWEFJVXcyKzhxL2ZvNG96MFBRN3prTGR4LytoOGYwbGhpNUdM?=
 =?utf-8?B?T0gzcTZPdlp0Sjh1UTdlTjJGc041OEdNaHludENDM0t0d0NGSnhJK0dEK0tY?=
 =?utf-8?B?RXc0YkRHblI3Ym1zR2N0ZFJLZFRkUklqRkt2ZDlTR1E3NDFzY2xGa3cwSC9Y?=
 =?utf-8?B?MkVka1piKzE2dHZRNEpQMXpNUGl5ZEJxN1pkbzZtTmlkVlNkMGo3S3BxRXN2?=
 =?utf-8?B?dElldERBR3BaQmdrbzFVbUU4T2FKcVJlak1aaGZKVnhUaHpRaGpTL2pZeGpu?=
 =?utf-8?B?VlFCZVljMitSem4xTjUreWxTU2J2eG1qUmVkUXhibVFsc1pRWncwdTBpRXJY?=
 =?utf-8?B?T1N1eHRzSlNWU0RKT0NHS3k4bUNySWl5NHozN3owN3IzZ0xmL1Q0dDBwNC9S?=
 =?utf-8?B?dFQ5d0wyZVpxVjRGQ1ZIY2hJV0tMWWNKYnhScWtaT0Q2anlXWHViNlNyeGFJ?=
 =?utf-8?B?aHcvTE1aMENWbUVuSXNwVWd0Q1BWUldYMXkwZUlQU1A2ektucnRIbnJlakRp?=
 =?utf-8?B?TXdFVHNqa2tEUVErRzVmckd2MjFUQUdRSlNPMy9wL3NnRmdzM1hnaWtKeFNn?=
 =?utf-8?B?dm9RR0xHN29zY0xHQUQ1TE41cVVPQm93VnN1VUpSRFFkeDFFWngwYVJ5VmRU?=
 =?utf-8?B?RmMrUTdMY3BWdUV1b2F3VGtIR2xWWm1GZHRqWEZrZnE0YzhWTG9yZWlxMGJy?=
 =?utf-8?B?T2lxTEJJemtVbkVCM1BjMnlsSW5iNE0rUThuSmdIOHdTd3FxdmVXOGc1RkpM?=
 =?utf-8?B?NDRrNmY2MlZEc3dmUUdpWTVVN0FPOWpiTDN2dDM4S05xZHdvcUV1WjkrblZO?=
 =?utf-8?B?ZmVtUkJVVjBndXRtbktlcDlDZi9WeGlSVVhDaWdpTkJaMm5uT3kxSkFDVEpy?=
 =?utf-8?B?NlVic2R4anlKZHhwNTdJdnJHKzN2US9XUkZzZ09FWk1KS0orbmNGeGxBZEow?=
 =?utf-8?B?RjdBU2Y0MUowcmFHeTF6dHJPL2VIVlg0WFdaejFIVXhBL3JpSUFtTTBJL2lB?=
 =?utf-8?B?bXhvUTkvZjFETWVLN0lmYWl4M0hqdzJsNGNGRFZ4bWZVNkpyMUNQWW9XV1Na?=
 =?utf-8?B?TThYa0lYbkdESGhnL3AzTWprRDVMMjJlOWtlT3VJbGN6L0p4cjVJUlpCd205?=
 =?utf-8?B?QUgyMEdIWHhxMDZybFRQLzBtYTZHbU40SENlUlFyMXZGZi9NUEdJa0V3TmlX?=
 =?utf-8?B?SHFUQUllQmE1ZkJlUUxOSTVwWjU4YWZwSTQzY04yMno0MGRCN0dRd2N3TG1W?=
 =?utf-8?B?RTFGWTdZWThndEJKSmVkVUdJOUJxZDFlTmMxNGlaRVp1bk0zRHFGYlR0elRy?=
 =?utf-8?B?TnZmZ1JMeStCL3RuZU4ydlBKN0c2Vk4vQ29ScU9LUmdKOEFPUG9PTk5HVkZa?=
 =?utf-8?B?VFFBOEM5Kysxd0wxYnhMT012VkJMcGpROUdFRHAwOFR1U2dyb3JvK091a0tJ?=
 =?utf-8?B?dGpXQzNZaGplelpzcVVUejdWL2dVNVlhZkZqUEt6eE02NjlpR0NVVkRkTDRF?=
 =?utf-8?B?VVE5bXpPK3FYMTdWdCtmNmo1UkM0dEVSSncwc3hGazR6dGhjMnBVVmh2UEVM?=
 =?utf-8?B?bER3WFg1ZktKV0h1TzdrbDFmRko3Ym4vNCs5MXA5d2ZadGtXUmpHM0ZobFNJ?=
 =?utf-8?Q?g/gJym8FpgOlKXciw9NZFp1u3INvoeAa3LX9GCVeSYEK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <903621533DA6D444A31208DEC52DE2DD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd38326-9068-41c1-f2cc-08dc68c8307a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 03:46:59.5677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CgiOPbAuQfUC7grCvpeaYm2HdV8hay0xZd2GugF3Bb5M77TkwRzBmfHtH2BnltF0BCvejF+JvCJEHchv49BWHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207

T24gNC8yOS8yMDI0IDc6MTcgUE0sIGJyb29reHUuY24gd3JvdGU6DQo+IEZyb206IENodW5ndWFu
ZyBYdSA8Y2h1bmd1YW5nLnh1QHNob3BlZS5jb20+DQo+IA0KPiBJbiBzb21lIHNjZW5hcmlvcywg
aWYgdG9vIG1hbnkgY29tbWFuZHMgYXJlIGlzc3VlZCBieSBudm1lIGNvbW1hbmQgaW4NCj4gdGhl
IHNhbWUgdGltZSBieSB1c2VyIHRhc2tzLCB0aGlzIG1heSBleGhhdXN0IGFsbCB0YWdzIG9mIGFk
bWluX3EuIElmDQo+IGEgcmVzZXQgKG52bWUgcmVzZXQgb3IgSU8gdGltZW91dCkgb2NjdXJzIGJl
Zm9yZSB0aGVzZSBjb21tYW5kcyBmaW5pc2gsDQo+IHJlY29ubmVjdCByb3V0aW5lIG1heSBmYWls
IHRvIHVwZGF0ZSBudm1lIHJlZ3MgZHVlIHRvIGluc3VmZmljaWVudCB0YWdzLA0KPiB3aGljaCB3
aWxsIGNhdXNlIGtlcm5lbCBoYW5nIGZvcmV2ZXIuIEluIG9yZGVyIHRvIHdvcmthcm91bmQgdGhp
cyBpc3N1ZSwNCj4gbWF5YmUgd2UgY2FuIGxldCByZWdfcmVhZDMyKCkvcmVnX3JlYWQ2NCgpL3Jl
Z193cml0ZTMyKCkgdXNlIHJlc2VydmVkDQo+IHRhZ3MuIFRoaXMgbWF5YmUgc2FmZSBmb3IgbnZt
ZjoNCj4gDQo+IDEuIEZvciB0aGUgZGlzYWJsZSBjdHJsIHBhdGgsICB3ZSB3aWxsIG5vdCBpc3N1
ZSBjb25uZWN0IGNvbW1hbmQNCj4gMi4gRm9yIHRoZSBlbmFibGUgY3RybCAvIGZ3IGFjdGl2YXRl
IHBhdGgsIHNpbmNlIGNvbm5lY3QgYW5kIHJlZ194eCgpDQo+ICAgICBhcmUgY2FsbGVkIHNlcmlh
bGx5Lg0KPiANCg0KR2l2ZW4gdGhlIGNvbXBsZXhpdHkgb2YgdGhlIHNjZW5hcmlvIGRlc2NyaWJl
ZCBhYm92ZSwgaXMgaXQgcG9zc2libGUgdG8gDQp3cml0ZSBhIHNjcmlwdCBmb3IgdGhpcyBzY2Vu
YXJpbyB0aGF0IHdpbGwgdHJpZ2dlciB0aGlzIGFuZCBzdWJtaXQgdG8gDQpibGt0ZXN0ID8gbm90
IHRoYXQgdGhpcyBpcyBhIGJsb2NrZXIgdG8gZ2V0IHRoaXMgcGF0Y2ggcmV2aWV3ZWQsIGJ1dCAN
CmJlbGlldmUgaXQgaXMgbmVlZGVkIGluIGxvbmcgcnVuLCBXRFlUID8NCg0KPiBTbyB0aGUgcmVz
ZXJ2ZWQgdGFncyBtYXkgc3RpbGwgYmUgZW5vdWdoIHdoaWxlIHJlZ194eCgpIHVzZSByZXNlcnZl
ZCB0YWdzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2h1bmd1YW5nIFh1IDxjaHVuZ3VhbmcueHVA
c2hvcGVlLmNvbT4NCj4gLS0tDQoNCi1jaw0KDQoNCg==

