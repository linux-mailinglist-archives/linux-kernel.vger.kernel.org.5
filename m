Return-Path: <linux-kernel+bounces-75839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9167B85EFB9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53841C21743
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CE9168BD;
	Thu, 22 Feb 2024 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="CgCuFdJW"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940EF10A12
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708571645; cv=fail; b=UWY6kgnhTlimekJBuPV9Qn4ZicP17wppWGlAw/dqMJ9yWNnPQYLJDX85M3/reRTflQ2A2UxOkV6aw9VTX1WQjIxmnrlS7qqla1n2GEBNFtWJw2OBkOMVb3g0TeUMCfaeJhBqvpFwTI7NjqC2PfvKOcIXzaL0pMFDELZq9PpmuKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708571645; c=relaxed/simple;
	bh=GAp8bMM+fO0rGx8i7CXxmYBLcWjDTZpGb2xv+4zg/aU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bmu6RNcGdEssR5UZLILaqJIcSc38yZjeMI/wHvgK+RZEO4L4qQKQ6XUnk5gvWJhvJ1XqHIkhtjM2FxMEppl2DHEDDVFgSv1T31pmWU/2iost1Jz86Ck+7kJXewRQIwVy43CwV8Nj3gKb9LWvIkAmsVl++pGygdlBdJrhw1ulG9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=CgCuFdJW; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M3DBia002597;
	Wed, 21 Feb 2024 19:13:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=GAp8bMM+fO0rGx8i7CXxmYBLcWjDTZpGb2xv+4zg/aU=; b=
	CgCuFdJW9GA0tvgL5OcndESArFTNrjKxRHZj/efh26f58kZVAjhiVKn5tqT42l7D
	lymHEbLyNhlYok0PDj73/0Qknd6gkW3mXIT1ErEmraKbKzGdstq0dFVbtdpUZ0Jy
	54PfOrSb811KGAXynSWDTGfyLyJCaFV3Vs4vv23FHEHfMedPoXu6Qpd3qjEh42vD
	q+fjIrM8tehHjYptRFJb8papN+VR5+v3IWVkDYk/SbCLMJcfTYsKgCKzzRWMFDLS
	xZKqBNgSFLmco+B4hOK7c3uwJIdQHq7nW++oHJs60LeW+TcnjbQyCU0h2LBywG0p
	QKvFQPSi7CJYLdzttXhj2w==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wd20chj5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 19:13:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9P2JknbeBnD3o9mTN9KSf0pnWclWAMDB4noePFJvUi5m9dTGN1MruyvEO7BvMKZrvfdRBNJ+yrjiuRRsT540WuFIsMCDHBrbzLmtmiAgq/Q0A5Ne076orq0VAfjTxYhrMywfWFHs/LSaEGp18G/dSzkzOLQJTQqgZnhO3j/3UZPDN7+VC76SLm5Ne3ynSfpUhFOXt4oBFbKYg0R5afmsqiKuKElBob3FnHcueqrteFv1rfyletWc7ZeDu6OJuZ0lAEh5EJEMFsadSNf/8h0X/s7uxTAUff78Sz8UrmhI40cvYz0OZyFJrFiVP6A5JocF5Myf+52Q0sD88ZrZqgMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAp8bMM+fO0rGx8i7CXxmYBLcWjDTZpGb2xv+4zg/aU=;
 b=hu1m3UBrbTIz9oyBpGSWgfJPVF2DfPEVpflIsOmSHCQrCVzrOFQT51CHYIb6YI5oTY3boi56AkDopx3KVmabi9s3x8OmL95YXb+xNtLBCGAeL/IaeFbjpHTR7bG7whs+lV8hNFbfxTSV74euJJyTPO92XYkmefyBRx3IhsT8rz+7kf6680nLabxsmBJqbD4HxxLPPsnd0vjeqOg/wat+0mBGauVPVDAKgaHb8eJHZr6JgaKZj6OiTKWw5GRxgxRk/6eDqmWNhf18YaCJCmLqNiodFE/6tEUGDlkuyZq+DFRNvzUGALawYBz9rhY677C0hNIw/ro2oYcrqwgfMT3O4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by PH0PR11MB4968.namprd11.prod.outlook.com (2603:10b6:510:39::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 03:13:07 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::230c:58c0:c3f9:b5f3]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::230c:58c0:c3f9:b5f3%3]) with mapi id 15.20.7339.009; Thu, 22 Feb 2024
 03:13:06 +0000
From: "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To: Chengming Zhou <chengming.zhou@linux.dev>,
        Roman Gushchin
	<roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>
CC: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David
 Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew
 Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko
	<glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov
	<dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Zheng
 Yejian <zhengyejian1@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Steven Rostedt
	<rostedt@goodmis.org>
Subject: RE: [PATCH 1/3] mm, slab: deprecate SLAB_MEM_SPREAD flag
Thread-Topic: [PATCH 1/3] mm, slab: deprecate SLAB_MEM_SPREAD flag
Thread-Index: AQHaZB4V5G9cauwLMUeerVHZZ0FHGbEVH8qAgABvR8CAABeVAIAACOdA
Date: Thu, 22 Feb 2024 03:13:06 +0000
Message-ID: 
 <PH0PR11MB519245317F026FD9C6A6AC23EC562@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz>
 <20240220-slab-cleanup-flags-v1-1-e657e373944a@suse.cz>
 <ZdZBN_K8yJTVIbtC@P9FQF9L96D.corp.robot.car>
 <CO1PR11MB51854DA6F03753F12A540293EC562@CO1PR11MB5185.namprd11.prod.outlook.com>
 <7e27b853-e10f-4034-bc81-2d5e5a03361a@linux.dev>
In-Reply-To: <7e27b853-e10f-4034-bc81-2d5e5a03361a@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|PH0PR11MB4968:EE_
x-ms-office365-filtering-correlation-id: 10fe0838-b683-42ab-675f-08dc335430ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OH1X6II8+jY/wdX2X8Brq6z15BXC/0HP1LuO4k74nV7xYR1zgI/g/jE/98Mk8hLPvXqpvBpkkdG9ZgKOyMsD6Nr2Do1ejbn0u8SWm63M3P8+LkmJgnOBioHScGTRtL5mW9ZLZh/biXEoDjQZxIfY7g4iKHteDC7gKDvZlOoww4zyVSI8QxE56rkpu2BZXvOhl4eabq5ai0krZczGMDRUZcHHXJk5E3OHDeadXcTvDYHbfuqdBqZzLk4Rd136NMAbkhou83g/+p6AkoVcBuvK4NGlafH7XVuc32mkr+nDE6yzEN16E40S6acih6n4qc7rcmoyB8MnWfPK06L8g1CtpXeSWYzoaiJhWGhQz0uruynQgol6hNI/NyI1Ld1tHAAlu0YFWB7fDK7o6k/k3s004s49uJjetE0VzIdC5hwIB1Ox/wFK9PVoY6Nau/vYVtMkMIU9BtofWiEFXfcmr5bZdbpJ6022lF39gBol7WJSpLLggDhck5SZjO1HunB5zQFlSGGjdHwPXkV+wQL/cNrBy22JiM6+Da5HCS71ZXPJwqZoQm30xUVZsFOTV3361PYs9KtYMOD+63GPANdDLjsuD0cxf09mYEoRI2GSVBWEQgQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?alhGaGFtYUd2U0FQd0RZdG1DZTd0Sld1K084dis5K1E3U3NNeG9sQzljUWc0?=
 =?utf-8?B?RDVFdktQSys5dklua0tWUWt5WE1hR0JjMzY5c1BjUkd6M2dBOCsrYkxhT0JW?=
 =?utf-8?B?RVhQOVBwTEJZWVBoU2M0WFUxRVRmMW5QdTY4Z3djSm5pNG5pZEN2bWlyNHZn?=
 =?utf-8?B?eUFKdEtUWVZIbXJnTHEvWFk0R3QvT29remdLWllsUFlHUm1tZDI2NzRJSDhh?=
 =?utf-8?B?OW03TndlTSs5R2hGMVBaLytpVExXbU8rNG9KRTA3dDFCMURQNEsvRm96Qnpo?=
 =?utf-8?B?MXBCUkFhd2FzaW4zRkhWZEVQS0N1V05HT1VReVFvZ3hQVVNSR2ptYnJ4a0JK?=
 =?utf-8?B?LzVaU0ZQWWw1ekZRL2YvQXpOZUZ1Y09TREJWbGI4c2tRRHFiaitxVnVzbkh5?=
 =?utf-8?B?dnVHSTMxRW0vQXJrRStZQk9BNERSN2ZKclVDOWsrenRRdHZsSFVUeUY5T2FT?=
 =?utf-8?B?ZWhmSUsvYmpWY1JkbFUyUmc1ak50QllpMzc2Qm5hQmFYc3IrYTQ2VGJtT3lX?=
 =?utf-8?B?ZXB2ZUNDY1haR3NjdnNCWk85L0RORlVyRnBpQ2c4U2x0cjZXZ241TVdRM1My?=
 =?utf-8?B?cWJ0cWQyTXhGSGwveFd3NDhFSFlZSHVyc2xsQUdoYUtKNTcwaVptUTNkRU9U?=
 =?utf-8?B?TzVpZWsyZ2JlbkdQNVl6MDdHdGxuMGZEdXd5NGo5cy9TTGFsajVIT1lmV2N2?=
 =?utf-8?B?dzl6NFFwc3BXZzlKTDBWTlBXK2V5TzZQMXpHQVllT3lKU1NMM2tSSXBUL0ZR?=
 =?utf-8?B?WFhpRkFRWHN6V3d3ZnVJVkoyUFRZOUdTZXZGeVFrVSs5cUxMcy9jcGErZm9S?=
 =?utf-8?B?eUEzTEFtdElkTnNkcGpRSlpwcTVOY2RBVUxlbkYrYnllQXIwQ011VzVxVG5I?=
 =?utf-8?B?dDRjeWJBZmRjSnlicmk1cVU2d1Avb2pkdGlGMzBKMXhGb3ord2RlVW9PSjhN?=
 =?utf-8?B?dW5kaGd2T1dkZkxiWTlnN0phNTNEZFUxaG1Tak5GV3NxbjVSTC9GdnUzd3Mx?=
 =?utf-8?B?dTlJbUZtdFFXbGRicFFQcUFQYUZHUThWMkhNaE5pRmtHbDZOTTFEU3VVUzEz?=
 =?utf-8?B?dEYvRk1ZT1UyUWo5NEJxR3AxZXJUemhVTTBBWFlxMDRCNG5NcEc3RjZwT0tv?=
 =?utf-8?B?TU5QNlB6SXdTU1VSc0c0cGtLVk5ZK05uVGY3UElldkZsYjNKVzh6bU1WemVk?=
 =?utf-8?B?S1M5RjlaUGRSaGFXNTI0YkdVdkVuQkxWOHR0RWM5bzBrVTdIckhvbExtQkJZ?=
 =?utf-8?B?Wkl0TnFkdGpkS2VsdlBaT1lKOFhCT1JwMTNNS3BTeko3aEN1eHdudlUxa2xU?=
 =?utf-8?B?OXpGaTUyQWM4cXNpd051dXNrWDc4R254K0VTYnpNWk11SjAvY3Z1RGZ5RHJt?=
 =?utf-8?B?T2hTUmhBUkY3N05JTWlDWU1rUk1xLy94cDQySUMwN0FpaG5VS1VsSnZ5clZB?=
 =?utf-8?B?YVNkTE5GSEZCbTU3OEw3T2VYbFk5RkFMYlRIb3ZoVjRoSmZRUW9FMlJlcHFn?=
 =?utf-8?B?NiszalF3aWo4MTh2STBEWjZEUC9DdnVnVjJ0YUVNN0tJWTQxcjl3dFNheHNn?=
 =?utf-8?B?MW5BL2JmekxQOW1rbWZ3N1VEcTJmN0hlWGdrK2Z3SGZTUkNWZzQ5bmlrd2dD?=
 =?utf-8?B?ZTlzTTZhTTF6Y2pZcmZBQWFVQ1drNzdNQmYyYksxTEtRSld3eW1oR1JtSFVn?=
 =?utf-8?B?aGtJOEZiaHdYMTloQThRUE1yT0JiZkdlOHVzQUVNbjZhcVcraitsT3lGVWhT?=
 =?utf-8?B?R0JzdkF6ak9lY3dhanNnWlR1c1c0R2p4V1ZjQkdUMW1oWFZlaC9LU3llb3Vv?=
 =?utf-8?B?UDFPalFOUGN1ZjdRK0FNMWFPdDJ5UW5yMnIvU1A5MnhtSXB0djI3Rjd0SzFi?=
 =?utf-8?B?Y3IrRzFQTExhd3docEJlNXc3Z2ZPV3BIRDIyVlFEMVdHTW4xR0dsOE5HVkc3?=
 =?utf-8?B?RGh4VTVSNUc3eW5FMDltei8weEpEV1UyaHdJVUozeTRBakhDVDBwYlJpOFE5?=
 =?utf-8?B?YU1HMzBPenhkQXVTV0pjOVdLUlVKV0JBNzZVT0oxVXlKQ1lObkw5WGI3dmNF?=
 =?utf-8?B?b0hLbER6anpUWittZDcvVk5EZCtTUkdDdm0zb2h1SUdoK3Zjdno4Q0FNUG5G?=
 =?utf-8?B?b2U5ajBnaUFvRVlXcDd5b2xQQTRZaHZ2aDNrNFlycVlmYmYvbzM0TW5iQkx4?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fe0838-b683-42ab-675f-08dc335430ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 03:13:06.5954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 50IN8ZrZrjPyCHKHcuUtM/7L8cwZiMrIUESgolKZEVCKrIIyZoiycqVQm0X0b4oYuIlDHDCpyib98tkzcM7JvaPQvQgFXITnTRaGcDIXyFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4968
X-Proofpoint-GUID: C7CiAq9NKO_GUTSNtpWym9dERM5q0rZe
X-Proofpoint-ORIG-GUID: C7CiAq9NKO_GUTSNtpWym9dERM5q0rZe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_01,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=757 malwarescore=0
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220024

PiBPbiAyMDI0LzIvMjIgMDk6MTAsIFNvbmcsIFhpb25nd2VpIHdyb3RlOg0KPiA+IEhpIFZsYXN0
aW1pbCwNCj4gPg0KPiA+PiBPbiBUdWUsIEZlYiAyMCwgMjAyNCBhdCAwNTo1ODoyNVBNICswMTAw
LCBWbGFzdGltaWwgQmFia2Egd3JvdGU6DQo+ID4+IDA7OTU7MGM+IFRoZSBTTEFCX01FTV9TUFJF
QUQgZmxhZyB1c2VkIHRvIGJlIGltcGxlbWVudGVkIGluIFNMQUIsIHdoaWNoIHdhcw0KPiA+Pj4g
cmVtb3ZlZC4gIFNMVUIgaW5zdGVhZCByZWxpZXMgb24gdGhlIHBhZ2UgYWxsb2NhdG9yJ3MgTlVN
QSBwb2xpY2llcy4NCj4gPj4+IENoYW5nZSB0aGUgZmxhZydzIHZhbHVlIHRvIDAgdG8gZnJlZSB1
cCB0aGUgdmFsdWUgaXQgaGFkLCBhbmQgbWFyayBpdA0KPiA+Pj4gZm9yIGZ1bGwgcmVtb3ZhbCBv
bmNlIGFsbCB1c2VycyBhcmUgZ29uZS4NCj4gPj4+DQo+ID4+PiBSZXBvcnRlZC1ieTogU3RldmVu
IFJvc3RlZHQgPHJvc3RlZHRAZ29vZG1pcy5vcmc+DQo+ID4+PiBDbG9zZXM6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC8yMDI0MDEzMTE3MjAyNy4xMGY2NDQwNUBnYW5kYWxmLmxvY2FsLmhv
bWUvDQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBWbGFzdGltaWwgQmFia2EgPHZiYWJrYUBzdXNlLmN6
Pg0KPiA+Pg0KPiA+PiBSZXZpZXdlZC1ieTogUm9tYW4gR3VzaGNoaW4gPHJvbWFuLmd1c2hjaGlu
QGxpbnV4LmRldj4NCj4gPj4NCj4gPj4gRG8geW91IHBsYW4gdG8gZm9sbG93IHVwIHdpdGggYSBw
YXRjaCBzZXJpZXMgcmVtb3ZpbmcgYWxsIHVzYWdlcz8NCj4gPg0KPiA+IElmIHlvdSBhcmUgbm90
IGF2YWlsYWJsZSB3aXRoIGl0LCBJIGNhbiBkby4NCj4gDQo+IEFjdHVhbGx5LCBJIGhhdmUgZG9u
ZSBpdCB5ZXN0ZXJkYXkuIFNvcnJ5LCBJIGp1c3QgZm9yZ290IHRoaXMgdGFzay4gOikNCg0KT2ss
IHRoYXQncyBmaW5lLg0KDQpJIHJlbWVtYmVyIHlvdSBzYWlkIHlvdSB3YW50ZWQgdG8gZG8gaXQu
IEJ1dCBpdCdzIGJlZW4gZm9yIGEgbG9uZyB0aW1lLg0KSSB0aGlua3MgdGhhdCdzIHdoeSBWbGFz
dGltaWwgc2VudCB0aGUgc2VyaWVzIG91dC4gDQoNCllvdSBjb3VsZCd2ZSBzYWlkIHdoYXQgeW91
J3ZlIGRvbmUgb3IgeW91ciBhbnkgdXBkYXRlIHdoZW4geW91IHJldmlld2VkDQp0aGlzIHNlcmll
cyB5ZXN0ZXJkYXksIHdoaWNoIHdvdWxkbid0IG1ha2Ugb3RoZXJzIGNvbmZ1c2VkLiBTbyBrZWVw
aW5nIA0KdXBkYXRlIHdvdWxkIGJlIGJldHRlci4NCg0KVGhhbmtzLg0KDQo+IA0KPiBJIHBsYW4g
dG8gc2VuZCBvdXQgaXQgYWZ0ZXIgdGhpcyBzZXJpZXMgbWVyZ2VkIGluIHRoZSBzbGFiIGJyYW5j
aC4gQW5kDQo+IEknbSB3b25kZXJpbmcgaXMgaXQgYmV0dGVyIHRvIHB1dCBhbGwgZGlmZnMgaW4g
b25lIGh1Z2UgcGF0Y2ggb3Igc3BsaXQNCj4gZXZlcnkgZGlmZiB0byBlYWNoIHBhdGNoPw0KPiAN
Cj4gVGhhbmtzIQ0K

