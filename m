Return-Path: <linux-kernel+bounces-49378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131F08469B8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0225281A34
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FE817BC2;
	Fri,  2 Feb 2024 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="CAjS50lZ"
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A5117BA0
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706859871; cv=fail; b=QScAkpL8yXdT1C+q99bSOsbQmvgPExCijSKP2JZSY3RFaZWJzq8TutUizqc+ScLCwwfXqWomQV7U6szkvcYPqrUTdyC/sjEGrDhj8xJZHQSqqOiMB+z5rKqnzp1M+y0a7IPN3UrCGv2bRsDRvso/MyszIIeJl+BO86dzis2p5Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706859871; c=relaxed/simple;
	bh=bC/7180Sz30kD7poMCfp0/0tdMtinkH59A9HsFTAB8s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=syN2By9wRFFZYhEHR7cZmjaMJo1B5STBZpAdHOOXNdcKoL16nOVYdxSrbXc7SAZkvg+HCoDyIBI7sohWCoipMs19t9f3iU13Qgb1zPwfDfjwJIhX+7eVSWWmsmHEPteHiu4LRTzM920ZAOB9J17lPoEUyPiD0OP7r/WTosOiJ/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=CAjS50lZ; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1706859869; x=1738395869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bC/7180Sz30kD7poMCfp0/0tdMtinkH59A9HsFTAB8s=;
  b=CAjS50lZIzI8tV+qRSUd4QA042BLUS8HM03JCPLllDiqhfYPJfNpA0Jl
   kZFPC4xwOPr47I/SB+2UFY6IGgcxaTBtXsy7Z4lSyI0zgAEpMAzHkg7ja
   LCWsnLj4UOAAwWKyGxwubfMlVrQ+LRxviIMGDOYex3J9FgFuLRr6ZDqa7
   OmBlgtD/WRJTGv8rCPQoTYr/RqeReDG7sJaz2phvdiEZ2ayIMv73aKOgo
   fanRbWtUDCc4CHLAxQZMxmbbfwrHLFj74aYe/DmJvqhYz0nMhtj6vX8er
   0n26TZhcOuvMAN8bR6gRFlGBKYPLXrcYLTY9VwiuXPKyTbQiEtfV0lP9X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="109643167"
X-IronPort-AV: E=Sophos;i="6.05,237,1701097200"; 
   d="scan'208";a="109643167"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 16:43:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlzZSB61GgCqxwIfQD5cyUg6X4GIvEMgeWStcyjARkKWpxQtyhEIg5oaOHJGWADpBoiaqT+qO7rRyPmkpknKoARgMXfzNmODMHDDlKNaPaY5TR2r0YaOrE0dC/TEH5locqxLhO0m5MuAKZjX2mkooiVElRydVw12MltGz4OpQKvbkJl/Cmo6fKkMY+QuEV+VPQY3ELg/MOvDoveEMY8kZuZEaXbr5Me/WAY2rActRhmrVbqnypH4yuoGwg/R9Oo4fKMvuOLqJwoV7miyencEEpEkNYErOCbvJgDwRrzCV40lgnPXErjon7RzOvjqm0pcJMEiOCCEh22l1R3bMUs86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bC/7180Sz30kD7poMCfp0/0tdMtinkH59A9HsFTAB8s=;
 b=iQEeX0Q0hcTfK6mT/t/3x99coTDiu4F72r9aQjZeylogafS0+bSbQi1a/rrWezJb68Vx3+jBIPBsOuw7Idtu9z6j6d0M17Ru4qZ2gJt63UBRM99FQPwQsYuM/C5FxtKShvSTyo9UA8Sx3YE1qH03YDO7eAyh1WmEfNZd4bvcZbr8arZe3zCJ1SCpynZ02H53ikUJzNIwclGXwOToatTy8KG5nvl/+BAHjINV4S8lROebu78Y0gNXoyJOExA4rxn2rtARxJemK9KLmbgfh17vGAzZIuSLNNi0JVVbVnqCCNZaegasrxpiDUgwUWYG/vo5f1iCjaJUekaMb2m4ASn5vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB1905.jpnprd01.prod.outlook.com (2603:1096:603:15::14)
 by TYYPR01MB8023.jpnprd01.prod.outlook.com (2603:1096:400:f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Fri, 2 Feb
 2024 07:43:12 +0000
Received: from OSAPR01MB1905.jpnprd01.prod.outlook.com
 ([fe80::b91d:bacc:c776:c190]) by OSAPR01MB1905.jpnprd01.prod.outlook.com
 ([fe80::b91d:bacc:c776:c190%2]) with mapi id 15.20.7249.024; Fri, 2 Feb 2024
 07:43:11 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "Huang, Ying" <ying.huang@intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "Yasunori Gotou (Fujitsu)"
	<y-goto@fujitsu.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: Re: [PATCH RFC 1/4] drivers/base/node: Add demotion_nodes sys
 infterface
Thread-Topic: [PATCH RFC 1/4] drivers/base/node: Add demotion_nodes sys
 infterface
Thread-Index: AQHaDTg+8WEYMUmyx0WBKXqinoE2/bBmXHiXgIw8lwCAARKLkoAAIh4AgANuxwA=
Date: Fri, 2 Feb 2024 07:43:11 +0000
Message-ID: <797f9b10-5626-4511-af6f-6b90cd5c884c@fujitsu.com>
References: <20231102025648.1285477-1-lizhijian@fujitsu.com>
 <20231102025648.1285477-2-lizhijian@fujitsu.com>
 <878r7g3ktj.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <d1d5add8-8f4a-4578-8bf0-2cbe79b09989@fujitsu.com>
 <87fryegv9c.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <cc125e55-890e-4de8-876a-30d88e8438b0@fujitsu.com>
In-Reply-To: <cc125e55-890e-4de8-876a-30d88e8438b0@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB1905:EE_|TYYPR01MB8023:EE_
x-ms-office365-filtering-correlation-id: a8fb29d4-3d11-43e0-56bf-08dc23c29b7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TrbKx/q1W7cgwe4kpzOYOpEM60YZ4ahHKLUrJ/6c31ZsQYFrLo4XUD5AwH5YxW0aUvSSP4FJ+KJJbNx+eBqIjVeMu3RGlb7TqiwGECgXCLfQ9VBzZKBmxP9zWpg0NBjzzsEchqFFBUhZMf0DUXaAZB0uP+WEBSGZ9C4oQo3miwOlhspkSl4WZOYLfflhfhJNYbBPExDWJ8rJzavw1jluCYMPLjo+v9Vof1EupuUxAWF56YuIdNZrNKBVqnTwfkMF6ZygHg2ld2SYoRQbevyUZS9ujPn7O9zdLvCZ9EHdLqME9o48GpUfMOybk88HCt55G1k9qWUD4vQKDNhQzTS9tiJk39T49SZfNqSGCWwwVz8lo7ZmbMeMmwJkOaWNV19slBvRkt9BSuIkuxguN+rucKUSz3RavnYQUsTXweVmW9WgIf6dqmSvf1ic2aRxjwF71IHRG6lB0o+jmwO/zPFTe/mlyfx8arNuzOhdc4EPBu7nafBWHI/8NYkqzxqQ9fOE2/9yw5b0H6MDg55f5ZibM6h+lizRRU515txdCf0lKjymaGdG0nUjTEzJkmW7CXzLRNLmZKz3w8+pCQDy76FCyODu4PZ/0OiyIlESZuaIKI6BuohDnhGCSv/6rZRHzhnr7+ptYMUa/kEo0H4RqbbrpHDFGlpxbx41Vg8HorKrziNHcWAHijGFgDXGnp68rflSnDlIp1Cay6+fIMu6AsD4bQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB1905.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(1590799021)(82960400001)(122000001)(2616005)(38100700002)(6512007)(53546011)(6506007)(71200400001)(83380400001)(31686004)(26005)(36756003)(1580799018)(66476007)(85182001)(66556008)(6486002)(76116006)(4326008)(66446008)(66946007)(64756008)(6916009)(316002)(38070700009)(8676002)(54906003)(41300700001)(2906002)(478600001)(86362001)(31696002)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXVkZmVFYitWMENTSnRNVVR1dzhpYnAwZG5LRlBHN3RpU1YrYk9qeDJjR2ZB?=
 =?utf-8?B?dWpoMktqazRpcTg4c1pCazJmRm5kWVpiRlFHcWJ5UCtvZHJ1TFFTd2lZSWJJ?=
 =?utf-8?B?d2t1UldMbjhONlZMQmcrMVJHaFdTazRUd2ZLcGxQSi9ENDVFcmR6UE01ZnZB?=
 =?utf-8?B?cGRjNlBvblQ3WjBRWHV3WUxnbUdpbStXeVd6MVpqczBsTm5UNm9wdUQ2SGJz?=
 =?utf-8?B?ckw1dmZPWlNFV3BBU0F4ckRjeEtBYlhqVVdvOEdmL2ZRdTVXUm1mUlBRdFl2?=
 =?utf-8?B?bEZVZjBBWGFhUUZmVllaWTZ0VVM0MFZoUWYvZmJ0anVBaEw3L0JRbzNTQ0Jq?=
 =?utf-8?B?cUR0cUd0d25xVFZnWWtjTGJEbUEyTUVkU3lITjUrVFJkejQ5OFFWM3UvaEdT?=
 =?utf-8?B?TWppWVp2cVYvR1grdS9LTCtobUlUR1pHbzlyZlNZWVpPd0k5WTFjMWZBTE8z?=
 =?utf-8?B?V3NjU294eXBPYTM5T045QkpHdHhHMm9DV3VHOE5uakZXVURPVVpXRitCK2w1?=
 =?utf-8?B?Mzllbi9zME9yOWdsYVlBc2RITS9aV3ZpaStXUlZMaXU1RWdDYS9WL0o4TTd4?=
 =?utf-8?B?ZzJUWUtWUytkT1dRMERkcXZuN011ODdXaUJWa2pGV1FIUEliMlpiYnB6OUgx?=
 =?utf-8?B?bHAzaStjOURKYzFuMmM5eEwvelk0dnA5VG1KRlZ0QTVKK29lMUJ5RmdtWUY4?=
 =?utf-8?B?c2pHNDZGM2N4Ny9aUWJZSUttNFU0VjIwUnFMQ2hFdXRjMmZiMG5hd0VBSjJ6?=
 =?utf-8?B?Ly8yYjgwUDV6OWhhbTFYSGN5WWloR0ZFWndETE4yTnM4bFRIemZuOTZGUE50?=
 =?utf-8?B?N1l1TS9vbTgwcHdVTUNTaGt2TytkYldGVndDMHFrd3JnQkJzdFY1cHhLRHRv?=
 =?utf-8?B?TjBNUEJ1UXFkWVpoVGZXZm9XbFlhZEthV0tGU214Y0o0aVpUWlowc25OZzVv?=
 =?utf-8?B?YksxRWtJdGozWlR3K1lvdE5ZZVlPdVlia1VEZnA5OXpMOTZ6Z2ROdWdib0dQ?=
 =?utf-8?B?cDU2Q2llL2Erc1JTM0dSa25sRXZmU2NQQlkvZ0pWZE5UcXlBVExjVXphOC9I?=
 =?utf-8?B?RVRpeFhFVlhoYUVmazJBTktGbzJKcE5tR0xTdVJQYklwM1VkMC9IUXFNeVpZ?=
 =?utf-8?B?aXFtQzZFbDByNXRqOS9mQWRwNmJldnFyQStvRlpmV210dkRsNDZwME55Z0RC?=
 =?utf-8?B?TUNOc2NtRE9TOXE2S2dRODBJcDJjNk5Veml4QnNqZXhQNUZKOU5NUklGWStm?=
 =?utf-8?B?cW1TQlRDR2JBNTEwZ3JuM0UzSThKVnV2WUozOEMzNmRZcm9Qc1RYc1NTNC9h?=
 =?utf-8?B?cHQxZWdFZGd4V3d4Y09OVy9yWU9PSWFwR0xnck1BaDhFaG1ZNkxjNlF5eVlB?=
 =?utf-8?B?RWhPQjF3emlnb0Y5SDdIL1BucTAybHBONXpTWmZFU09kZWdLb3BMSnJweDF2?=
 =?utf-8?B?VmladzZkVzl0Qzc4TGovc0Q2NUNzRmRIZXAxbnFxT3dkSW16VFpjKy9SWjVN?=
 =?utf-8?B?Zjc3TUQvWUhwaC9vL0NwaDNtS2E3ZmRMa05CZlVrUy9oOG5tbjlic0tGV3VE?=
 =?utf-8?B?aHNxb2pEaDVseG40TmU5aTJDSlY4NGZwZ3FId3RWU2dSUGM4WGJxV0tmdnFP?=
 =?utf-8?B?MVBPU2ZmaGRwZXR2cWJUVVhiZ2lGQytJS0YyZWFWVml0T1BNWFF3NFNjaCtD?=
 =?utf-8?B?eCtZdjIzMk40b2x1Tkd6dzVIUEk2WlVGOE12QXhGbTBTSmJzaENFTGk5QU1L?=
 =?utf-8?B?SU1kcDg2SkRWTHZ2cENDTnFCdjQ1NS8xQWFRZHd4QTc4bjdsTldsVWNoZWcw?=
 =?utf-8?B?N0ZZelptUytiNXdBRnpZQWtBcWJPRkN6bWdBT0JDbkJMbWNFK0poUkpXS2dm?=
 =?utf-8?B?T2tqd0FucnZCbmVxMFhoMCt2NkxDSHllMngzZHRTazZSZDZmRjJUbWdHNE5Q?=
 =?utf-8?B?RWZrYjU2bm8zcXZucE0zUkVFazJiTFl0bmc4WlZzN0xMd24xdGVCQnp3NExq?=
 =?utf-8?B?NlJxU3EwT1VLb0d5Y0hLb1owc0ZiRlZrbzVPelpxUGhtQkdiWXdjTGM2T3BV?=
 =?utf-8?B?N0gvR05tUWdKbk9ZUkl1blc3TmV1bEpKcFNlTWgxN0k0U2t3SlBjYUd2UlVX?=
 =?utf-8?B?czRhV3RVSHZKczlLK3lsT0F6a04waGNxQ1h1bFBuR3VVN29QeldhdFFyLzVk?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1B2E4ED949697498E5BB13F6CD148F4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8irNqLDRVvobe4BXeDbhjJ924UD/o1mZruWPVDE9lS+XNU9pu2TrHNcaPX5eExHjDeia2Z+APtNyPs3m79F2iq4yQAtPDhM9BKyhPSnTu/81jit4L0IcOBvRGCJYmhNDUe7iHJV9pxLucB4j5F/O4bQnyuuvV7lgb64mQGnxZ1PrGLM+NdxVsE3zNyQCTd62DLuKsCapbk+LzO+ux91Kjr0eMI40XvijX2MKiBuux3ncH8aZTklgxkKHy6m2YpJsTiMVc0Ijx1eC4KpojEZ3gbw6TKF5hdFpp/glS2YR6w3upqmrP21PaDef8Ok3jAO9XohD28NTtsspGicv9eoD8sJE9kbXY1uPF3TMbLZFstnnK1++rfbohazd/jjt7ox4EjG+rgfe/zIlNFkgi35AUOVhGHx9CnMpA/1dBXH0oAFONqR5YWeiejBZyMsWslsr6TqQmLtTVy5uGMiyJbpd9pxkrflzMyxHgmgAq8ewWXTz7EcYcJWWyRZ0/AE2CCm/+tUY301lelK/2VLD9OJ+wvT/RHPQkXeIpeQjsLWwPRFCDd39Y516HQLIzafqtzTAuYHtgY4rkcbUJNHhIsvyUHPkzPKZB+059i6a+WMwJUxSrl5gw5wxTtzY+taryCIn
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB1905.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fb29d4-3d11-43e0-56bf-08dc23c29b7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 07:43:11.8598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dIIyt+meOV5CMnle0Fw/VSvl+ehSMfPhkMFGDaOUiX6JCTr1yLaKeZhOQ9GIyL6EG2CEG7T9bGmqpDgJxcWBmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8023

DQpPbiAzMS8wMS8yMDI0IDExOjE3LCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4+IG5vZGVbMF0ucHJl
ZmVycmVkwqA9wqAyDQo+Pj4gbm9kZVswXS5kZW1vdGlvbl90YXJnZXRzwqA9wqAyLTUNCj4+PiBu
b2RlWzFdLnByZWZlcnJlZMKgPcKgNQ0KPj4+IG5vZGVbMV0uZGVtb3Rpb25fdGFyZ2V0c8KgPcKg
Mi01DQo+Pj4gbm9kZVsyXS5wcmVmZXJyZWTCoD3CoDQNCj4+PiBub2RlWzJdLmRlbW90aW9uX3Rh
cmdldHPCoD3CoDMtNA0KPj4+IG5vZGVbM10ucHJlZmVycmVkwqA9wqA8ZW1wdHk+DQo+Pj4gbm9k
ZVszXS5kZW1vdGlvbl90YXJnZXRzwqA9wqA8ZW1wdHk+DQo+Pj4gbm9kZVs0XS5wcmVmZXJyZWTC
oD3CoDxlbXB0eT4NCj4+PiBub2RlWzRdLmRlbW90aW9uX3RhcmdldHPCoD3CoDxlbXB0eT4NCj4+
PiBub2RlWzVdLnByZWZlcnJlZMKgPcKgMw0KPj4+IG5vZGVbNV0uZGVtb3Rpb25fdGFyZ2V0c8Kg
PcKgMy00DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEJ1dA0KPj4+IHRo
aXPCoGRlbW90aW9uwqBwYXRowqBpc8Kgbm90wqBleHBsaWNpdGx5wqBrbm93bsKgdG/CoGFkbWlu
aXN0cmF0b3IuwqBBbmTCoHdpdGgNCj4+PiB0aGUNCj4+PiBmZWVkYmFja8KgZnJvbcKgb3VywqBj
dXN0b21lcnMswqB0aGV5wqBhbHNvwqB0aGlua8KgaXTCoGlzwqBoZWxwZnVswqB0b8Kga25vd8Kg
ZGVtb3Rpb24NCj4+PiBwYXRowqBidWlsdMKgYnnCoGtlcm5lbMKgdG/CoHVuZGVyc3RhbmTCoHRo
ZcKgZGVtb3Rpb27CoGJlaGF2aW9ycy4NCj4+Pg0KPj4+IFNvwqBpwqB0aGlua8Kgd2XCoHNob3Vs
ZMKgaGF2ZcKgMsKgbmV3wqBpbnRlcmZhY2VzwqBmb3LCoGVhY2jCoG5vZGU6DQo+Pj4NCg0KPj4+
IC9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9ub2RlTi9kZW1vdGlvbl9hbGxvd2VkX25vZGVzDQo+
Pj4gL3N5cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGVOL2RlbW90aW9uX3ByZWZlcnJlZF9ub2Rl
cw0KPj4+DQo+Pj4gScKgdmFsdWXCoHlvdXLCoG9waW5pb24swqBhbmTCoEknZMKgbGlrZcKgdG/C
oGtub3fCoHdoYXTCoHlvdcKgdGhpbmvCoGFib3V0Li4uDQo+Pg0KPj4gUGVywqBtecKgdW5kZXJz
dGFuZGluZyzCoHdlwqB3aWxswqBub3TCoGV4cG9zZcKgZXZlcnl0aGluZ8KgaW5zaWRlwqBrZXJu
ZWzCoHRvDQo+PiB1c2VywqBzcGFjZS7CoMKgRm9ywqBwYWdlwqBwbGFjZW1lbnTCoGluwqBhwqB0
aWVyZWTCoG1lbW9yecKgc3lzdGVtLMKgZGVtb3Rpb27CoGlzDQo+PiBqdXN0wqBhwqBwYXJ0wqBv
ZsKgdGhlwqBzdG9yeS7CoMKgRm9ywqBleGFtcGxlLMKgaWbCoHRoZcKgRFJBTcKgb2bCoGHCoHN5
c3RlbcKgYmVjb21lcw0KPj4gZnVsbCzCoG5ld8KgcGFnZcKgYWxsb2NhdGlvbsKgd2lsbMKgZmFs
bMKgYmFja8KgdG/CoHRoZcKgQ1hMwqBtZW1vcnkuwqDCoEhhdmXCoHdlDQo+PiBleHBvc2VkwqB0
aGXCoGRlZmF1bHTCoHBhZ2XCoGFsbG9jYXRpb27CoGZhbGxiYWNrwqBvcmRlcsKgdG/CoHVzZXLC
oHNwYWNlPw0KDQoNCkJhY2sgdG8gb3VyIGluaXRpYWwgcmVxdWlyZW1lbnQ6DQpXaGVuIGRlbW90
aW9uIGlzIGVuYWJsZWQsIHdoYXQncyB0aGUgZGVtb3Rpb24gcGF0aCwgZXNwZWNpYWxseSB0aGUg
cHJlZmVycmVkIG5vZGU/DQphcmUgdGhleSBjb25zaXN0ZW50IHdpdGggYWRtaW5pc3RyYXRvcidz
IGV4cGVjdGF0aW9ucz8iDQoNCkl0IHNlZW1zIHRoZXJlIGlzIG5vIGEgZGlyZWN0IGFuc3dlci4g
QnV0IGFjdHVhbGx5LCBrZXJuZWwgaGF2ZSBhbHJlYWR5IGtub3duDQp0aGlzIGluZm9ybWF0aW9u
LCBJTUhPLCBleHBvc2luZyB0aGVtIHRvIHVzZXJzIGlzIG5vdCBhIGJhZCBjaG9pY2UuDQoNClRo
aXMgaW5mb3JtYXRpb24gaXMgYWJsZSB0byBoZWxwIHRoZW0gYWRqdXN0L3R1bmUgdGhlIG1hY2hp
bmUgYmVmb3JlIHJlYWxseQ0KZGVwbG95IHRoZWlyIHdvcmtsb2Fkcy4NCg0KSWYgdGhlIHN5c2Zz
IGFwcHJvYWNoIGlzbid0IGJldHRlciBlbm91Z2gsIGlzIGl0IHBvc3NpYmxlIHRvIGhhdmUgYW5v
dGhlciBtb3JlDQp1c2VyLWZyaWVuZGx5IHdheSB0byBjb252ZXkgdGhpcyBpbmZvcm1hdGlvbj8g
bGlrZSB0aGUgYWxsb2NhdGlvbiBmYWxsYmFjayBvcmRlciBkb2VzLA0Kc2ltcGx5IHByaW50IHRo
ZW0gdG8gZG1lc2c/DQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KPiANCj4gR29vZMKgcXVlc3Rp
b24swqBJwqBoYXZlwqBub8KgYW5zd2VywqB5ZXQswqBidXTCoEnCoHRoaW5rwqB3ZcKgY2FuwqBn
ZXTCoHRoZcKgZmFsbGJhY2vCoG9yZGVyDQo+IGZyb23CoHRoZcKgZG1lc2fCoG5vdy4NCj4gDQo+
IFRoZcKgZnVydGhlcsKgYWN0aW9uwqBmb3LCoHVzwqBpc8KgdGhhdMKgd2XCoHdpbGzCoGFsc2/C
oHRyecKgaW1wcm92ZcKgdGhlwqB1c2XCoHNwYWNlwqB0b29sLA0KPiBzdWNowqBhc8KgbnVtYWN0
bMKgdG/CoHNob3fCoHRoZcKgZGVtb3Rpb27CoHBhdGjCoHdpdGjCoHRoZcKgaGVscMKgb2bCoHRo
aXPCoGV4cG9zZWTCoGluZm9ybWF0aW9uLg==

