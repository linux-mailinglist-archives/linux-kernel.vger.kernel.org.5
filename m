Return-Path: <linux-kernel+bounces-158028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 594E48B1A64
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6ABF1F22393
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759073C466;
	Thu, 25 Apr 2024 05:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GLfm3s7L"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BE83BBD6;
	Thu, 25 Apr 2024 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714023633; cv=fail; b=ESjJRW7aThcZpZhmpucA2W8JBcfbPgEhHByGpTindjnEohweG35cLkTQ5/B/B2sk6ai8AIfUJRSKbEIG+v64yAu+Z3z24yHxsMDOhc4/OARhZ/nt8JolgEqhSxFxM8rAOzW5BOBO0i37KfAWObaFeimzVBz54kL1ySOl2P1+/ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714023633; c=relaxed/simple;
	bh=C+yoa47oWvXUizK/hDakVGTxwfcJn1v58QTyr8ixM2U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WD/qRkOoV0bSNFtx21kBzXJWsJMtZmU5C1jSkt0JDsR0H0COZI+6qBQ1DOdE2eU2P0XLiPkFEd6H/xdbpqfkyHLeF07iCCiHg6kG3Ml9YfYTAja354s8DPLiqVAYyRhsNnVSsXr2B6y7ij7COoAOLkfb6geW1/qBHIahW76XrHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GLfm3s7L; arc=fail smtp.client-ip=40.107.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcmZBXZR0zMwFwGsaHC54YjztmEnOBrs2SaGg5qJ0xsNf4cfYe+UcbxMG23/1o7CbnQR3uIilJek8iKfZf774DThP+cvmkFOv6o0uyNhuZf3zKxVrfhR6Kk2bjty2hq6E30gv3UkcrRY4AGWC9QivCKJqM6P28Y+ZbKAiQxd8vnSuT9+2o8gZjUQuTbZAS14mHw7Xb1lkEgnTbY+XEYJOPcENYP5QjodXeQlxQkCAJ8h8b0lKBX06P3CQcnA14L9/v18WU7FU5vIh9y0n0/BTyiUvbezn7OuV9dwoanpS7/lCI/L2UBxqUnPTFMXOK65XllvSOWuMSHpOVWA2P+EQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlRh5q/3bIAAeEK7wUFHXDoISd+hHSN1s+6smiK8U4Q=;
 b=d7DvPkZzCir9PI9YDVVsqi0MhaM+akjvleurrAXTRxHF49dxoa/6QDdSgscv6mmyI6uF6E90qzJfnMC4kP0ZCXBFfwSLiOaEWKwH6J1sce/C25blgMddt42CjnM76x/K/m2T3r6fNfcHaraROWifuqt/aCViYYGfe1S2zKHyjhyDPaV+CoPXOWwOjyvOecqOzZZUETaHNPga54JMP29KFXh69wF+aduBVf963pWVdH45FaPfqSQtoOyYaZambwXwwZfDeq10NZfkC2/OZc4X+atG8NtGV6iVVAirBKYBFzeIWOpKCLcomMt/IAihb/DH0zgheD6wsKFh09M2YbLi2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlRh5q/3bIAAeEK7wUFHXDoISd+hHSN1s+6smiK8U4Q=;
 b=GLfm3s7LNxnAYFUsapZQTBAtR9MTnFxAcMS14gWcELDqTBrhSgByKFz82DNVgSCWeRE5dFWrcUDTnH9ZWr7Jd+kud5LeueADcPQTILoLoXNMHn6I9fpDesJkROORNJ1Kt1viui9uZNt4zGmjtU0ZfXR4N5ic0d8ZAo9hwsUEta61nabg8NHl9EQ4d5LnkJh43TBoQm45i8YgDj6llurNjSFUcztzG9k0oSC1I8H0Oh4om6zQs+ts4q22HA1oROwzdang5MhhDpJSo+EEhPc1bxqebkXDHNGJZBzMNFoWnGxpfygLymPRAex8BPhgguLLTwnb3Ex32N3Z9MFQrcB8ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 05:40:26 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%6]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 05:40:26 +0000
Message-ID: <18b9acc9-9dc8-4857-83d1-952c94b69e01@nvidia.com>
Date: Wed, 24 Apr 2024 22:40:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/khugepaged: replace page_mapcount() check by
 folio_likely_mapped_shared()
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20240424122630.495788-1-david@redhat.com>
 <73de5556-e574-4ed7-a7fb-c4648e46206b@nvidia.com>
 <ZinZSDTMXjPjAHLe@casper.infradead.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZinZSDTMXjPjAHLe@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::34) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c137be5-3c1f-4d67-e846-08dc64ea359d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SENPejRicGxvaHM0UGhMWm42d0dTdFJnTWlLeXkzT0t0d1VLb1lJbFU2K0p2?=
 =?utf-8?B?SUFTeVIwQ0pIcEpWaFVqVFQrZFNMT1JHTjVJWFpzd2JJZDFieFpjRlRLRnAv?=
 =?utf-8?B?aUpJcG9BSjZzcExEZHBKUG8xMUJhZkE0WjB0cDdsLzVoQnRuUU5vSmRCdEp6?=
 =?utf-8?B?QlMrQkRYcWhmZVp0Nzh2aFoyNDlaUHV6WG9rMjAzczBXUHVCVnBUY3YwdUJP?=
 =?utf-8?B?cFFFbmw4MUErOEdlbGszZ3NSNktpQ1B4QXZaaXpOclczZWNEOTNxdmpUOXB2?=
 =?utf-8?B?UGVybDBZWnBJSnVySitnMHkzaVhQek1TNS9wUWIza3VDYjlPaWtwZVVEREpW?=
 =?utf-8?B?OFNOTVl2Wkk0YmZocThzMlpYYTZvQm9BMFRSTURrcy9rYk43ZVBOZEs2Mno4?=
 =?utf-8?B?S2YxcC9tc3daYWpWdnRaUG15NzlHK29mbG5HWXBFVVJKV2RlS2s3YUR6NWU0?=
 =?utf-8?B?NXdldkF6dHZlQlJ1ajdhR3p2bTNFb2pSN05XakUyM1hyRFNrN2J1RTJtWjV0?=
 =?utf-8?B?M05ua2UzR3pEM3V5VEFXNkRBL2FYeWxWVSs0ZWg2VkxhaTZPSzVHWUZBNmt5?=
 =?utf-8?B?a0c1TEVqZzNJaWtIdDFsZ3J0MXYzSE5YeFhSdWdVMHhxWGZ3WkJUT1c5QkNu?=
 =?utf-8?B?TExrSVE0MmxWbjNzL1c5OENqakFOUENNZlZwNlZhMEhVaWhKL1ZWSGJrMGlP?=
 =?utf-8?B?WDZKa3JRWkxRdDRXZFBRVm9EL3dNYUNWeVUvcTBSOWFnN0dRVmtMc2tBRENK?=
 =?utf-8?B?bThrdDhDQTJXd1A5eDFZUEUwc0RLMlNoUk5WbkR5R1laSkdUWk0wQkY3aS84?=
 =?utf-8?B?N0RoVnpwKzR3ZGdKZ09NbVFHaDViTkVxNERtRFBySmQ1ZzYvQTFtdUhTRFJR?=
 =?utf-8?B?RlVlb3hzVEtTTndsNWI4Zlk4cEwxU0ttbVF0WTJIazNIV3dhS09uYzJPOXQw?=
 =?utf-8?B?VjRWQkhMc1VSNlJla0lBOEIwMWJ6VjNjVFA2Q0dFSU9Dd3d2MDN4dEloOUZa?=
 =?utf-8?B?SjlYaXZwd0kwRENuMzBqT3YyK1RoQVZjKzFBVmhWcXFTYW9qRklmYWpZaG5S?=
 =?utf-8?B?R0hXU0xDQ2hzVnlvcnl3L2ZMdzN0cGVVdlF4Z0Nid2huallDS2djb1RUd0hI?=
 =?utf-8?B?NjhWRXR3ZVJvcEtsRExxYzZaaVhGMGhhSVJRMlF6L1Jxa2g5Ty9PR2NvYnZF?=
 =?utf-8?B?M2xFQTRHMFdGNGZyeFRMd1dXTHIweWdSb2QvUjhCcktjU1BpcEhFL0ZjYk9N?=
 =?utf-8?B?dDRnbTF1d2JsL3lTVG5LNDdPN1k3aXB3MFAzT0xlbUNhWFRZQ2I4cWhCTkk0?=
 =?utf-8?B?U2xudEo0aU1xc3I2TUhXNE5YOVJoUm0yM2E2VHBOMWtNQW9LSjI2bmlkRURE?=
 =?utf-8?B?aHlqUTE0RTlEZ0hhS1MwVW1uREFzMEc1VllmU0dza2Nob1F4bFFrMnQwUDdJ?=
 =?utf-8?B?dVlsUWRWd1NpV0Uvd2tqbVFoZXpaTHFXanZjN1BIUlVtZWpqTktNRXhCS1JX?=
 =?utf-8?B?TG8yVWI4TmllNXB0ZGU1aTYrS2VKdEdXM0p5bG5FYmtDa1RuTmxvQXBsL1hx?=
 =?utf-8?B?U3QxbVBpcTZROUxtVHFtckxDN2VlNFNkc09hU1Y3a2FaNmhZOVNQRnoweU82?=
 =?utf-8?B?ckQ1N0lyWmdQNjFodGQ5K2hoOE05dmVSR1N2V05NSzFvMkZscXozSHhWMXB3?=
 =?utf-8?B?d2tNVXZoVEcySWpsOUxOdyt0T0FYN0VHdUNyRVhmRTdSZ20rR2ZDcXRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aU5SSUFDQXhPSzA1ZkZtcmVmN2hyM0U3TkF0VzZLWGFaSkJ6V2R6NEtndkJI?=
 =?utf-8?B?R0hpTzhvTVR1enJpZ0piaEVxUUhIdDBmSU8zMDNScWNxNm1maDVEWGEzMkdZ?=
 =?utf-8?B?a0FZei9YT2cwbmFEZ25RT2V3M1JoYmIxWm52TlRJRURnQ1VFU1ljVnU2aFlo?=
 =?utf-8?B?WktRaENzTmdIRnFFYW9iR1JKN3lmbzJwU0I0YWwwcmM2NDdNT0RYR0RWTGph?=
 =?utf-8?B?TEh0bHZFODc0TFhtYVEzSm52VWM2QkRnTytOT0RUT0d4ZCtycE5uZVVQNVJj?=
 =?utf-8?B?OEtVU040eExWeXo1SmZ2VnlkWXU3U1IyS3AwcHc3Wi9UMEswNC9ueVdVNzd1?=
 =?utf-8?B?dEdlSWhiUktzNndmZ1gvcGdhMExmK2lhZ1dJdWk4eVBXOG1BRGJjOHhHNSt1?=
 =?utf-8?B?c1NjaEVpZ3V5S21oN3JDTUJEdUNla0swanF1TGpUc2ZNTFpQTFVEZm04VXlq?=
 =?utf-8?B?dGIxNG9YRlZiR1VOQjg0eU5XVFg0c29kVnJ1SW5zRVovRTFObmc0Y1Bla3pZ?=
 =?utf-8?B?S3ZLUzc2YXdsK01ydXlFWGh3c3o2enNDS05PQ1ozdnhoc1VkSzRxZGlXSmxu?=
 =?utf-8?B?bmNOMnpsd2t4ckxUNG1aWHBDVDFEVHR0RmRYejFodU5rZTBhS29Vd2lDQ1kr?=
 =?utf-8?B?d0VVcXhQZHlGT2ZFZjAxWFk5TjdOa2J2YmZRTmJIVWxrYmYrV0ViRmMrT0JP?=
 =?utf-8?B?RFh6REhQSmJ6QUM1Nnl3Z1BpNjdPdnJVNFY1M1RRRG9vUm9JQlhlaG4zVFdL?=
 =?utf-8?B?Uitsai9PWVZqKzU1VC9BMXl3Q21kc3ZHc2RUOTV2cHp2ZFE1aDE5Z0Z0TUk0?=
 =?utf-8?B?N2xtVHA4MDRpOFh3ZEpKUCt4RnVZd0E4MzMvWDU2cEFOamJXNGVGYTFIckZN?=
 =?utf-8?B?blFOUHhnWEJjRnN4aXRFbTVJeDdjWjhQcUcrQmlZcGVZK3lFMFRweFNVUTBz?=
 =?utf-8?B?YkprQkVyaGVLSXdvUm9vbkpzam44WDFRalloQ09BcmdJdGErNTQyWjQ1UlZj?=
 =?utf-8?B?b0hvVzdTNVpEYzZWVlRROHd3akhCN1Q3eThwLzMxcDBSaVNGQmdyMWE2aVRQ?=
 =?utf-8?B?aW5nSmZZMWNDemwvZG9BM1N5cW9CbU9MVHRoVkFDeWFvQ3Y4UklzL1NpWnJv?=
 =?utf-8?B?M2VCeE41UUl6am9xTWloM2sycHF3UFNOa0pUYVJoNU5FL2lNWDRGVng3Nitv?=
 =?utf-8?B?QU9nYnZyWWl0bDViVE5mNys1bnA0VkFmcXNMQ3V4WGZFcGExbE9ISzlzRWp5?=
 =?utf-8?B?ZFY2NStrT3JmQnROTlpTZzR4QXZaUUZoTmZDczJwZHAreW16UDh1OHc3RVE1?=
 =?utf-8?B?Y3l1eTBWMzZqeC8rcXlwMUw1QkY4THpVanVKbm1ZVGkvQVdJdTB0aXhEUHc4?=
 =?utf-8?B?L0w0VUV5K25neEd4OW91VFZMMGxTSno4UnFCd3Jia0FCcXRXWVg4VGRiNURq?=
 =?utf-8?B?c242Z0RuaFVoY0RucTFLei9iWXhqcFYrZURvQllpL09ES1VFdFZGZ0c2SEJM?=
 =?utf-8?B?N0dNb3k3L3ZEWXVOMVg5WlcvaXgyVWNaN3NtWEdtKzExWGdJbmtFM2xMNDBI?=
 =?utf-8?B?MWJPd21WK24vWU5DTy92QUhHTWlGOU1rVFhZYXd3bjE3bXd5NG1NMkh0T3l2?=
 =?utf-8?B?TkxvcktsTnB4TTErN0l0ZjZ2SzZOK1Nzbk5yNytZZlFFVWdodjJXdzlsWms1?=
 =?utf-8?B?bnNwYnYwcjNHd21zbVd4bmkwb2FSTjFINVNFZ2xkWW9XOFR3OVNsaDc4bWxU?=
 =?utf-8?B?NjNiYS9wMHRtbitRT2ZNVzRoK1pHRHpFUG9sTDFkOWdUdlNFQVd2OXF1N3Mx?=
 =?utf-8?B?Q21FM1E4OWdPa0lkcjFEQnNvaytsbDZ6R2F1clZLS0VvMmEwdkllaS9RREtz?=
 =?utf-8?B?WUttUVhaRFJlaW56UVRsWFdZSE5KMlczMFhxY05xd05obUM0UWkwWTR0Ynpl?=
 =?utf-8?B?V2ZNcS9zYlEyQkNKMmEvUEpxcWdZZVFoTzZNMVRxYldOZ3ByS21HSGhWVTBM?=
 =?utf-8?B?Y0pucndwTmkzakxJeGtYNjg4MTBHWDFWaDRjMnYrOHV1emZzeGV0N2hNaHlC?=
 =?utf-8?B?UGlKMUF0TFBRNWM4eHVwOVVIZlhkVWcrdkxZa1JGaktReVU1ODllalh2MlBk?=
 =?utf-8?B?ZCtycytkODRJbW9rd1NxeGdUbkMyQXZUNjV6ZU1VSHpZR1RaTFFQOC9lV0Y3?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c137be5-3c1f-4d67-e846-08dc64ea359d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 05:40:26.5496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdX/mGV4W6D+bVDEj9p92Yqzi2fEqy0vLz+xNxUyNOIpaIAdmzTj7FRmuYISQtFEb8/w/MVSSrWFKdR8CsM6Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

On 4/24/24 9:17 PM, Matthew Wilcox wrote:
> On Wed, Apr 24, 2024 at 09:00:50PM -0700, John Hubbard wrote:
>>> We want to limit the use of page_mapcount() to places where absolutely
>>> required, to prepare for kernel configs where we won't keep track of
>>> per-page mapcounts in large folios.
>>
>>
>> Just curious, can you elaborate on the motivation? I probably missed
>> the discussions that explained why page_mapcount() in large folios
>> is not desirable. Are we getting rid of a field in struct page/folio?
>> Some other reason?
> 
> Two reasons.  One is that, regardless of anything else, folio_mapcount()
> is expensive on large folios as it has to walk every page in the folio
> summing the mapcounts.  The more important reason is that when we move
> to separately allocated folios, we don't want to allocate an array of
> mapcounts in order to maintain a per-page mapcount.
> 
> So we're looking for a more compact scheme to avoid maintaining a
> per-page mapcount.
>

I see. Thanks for explaining the story.

>>> The khugepage MM selftests keep working as expected, including:
>>>
>>> 	Run test: collapse_max_ptes_shared (khugepaged:anon)
>>> 	Allocate huge page... OK
>>> 	Share huge page over fork()... OK
>>> 	Trigger CoW on page 255 of 512... OK
>>> 	Maybe collapse with max_ptes_shared exceeded.... OK
>>> 	Trigger CoW on page 256 of 512... OK
>>> 	Collapse with max_ptes_shared PTEs shared.... OK
>>> 	Check if parent still has huge page... OK
>>
>> Well, a word of caution! These tests do not (yet) cover either of
>> the interesting new cases that folio_likely_mapped_shared() presents:
>> KSM or hugetlbfs interactions. In other words, false positives.
> 
> Hmm ... KSM never uses large folios and hugetlbfs is disjoint from
> khugepaged?
> 

Oh good. I thought we might have had a testing hole, but no.



thanks,
-- 
John Hubbard
NVIDIA


