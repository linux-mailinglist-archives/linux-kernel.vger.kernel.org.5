Return-Path: <linux-kernel+bounces-101132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1D987A2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77B61C215C4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A303E134D1;
	Wed, 13 Mar 2024 06:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="VauMZk/a"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F45323AD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710310586; cv=fail; b=iig0t8/wMDXEjl+ZbXw5nhst65kLW5MSSQONHHViB8s23bHKyWF+or3Ef8APrKxumoCB1DUBq5UO41rqE2LEXCmsc6PaBL+EU1qDLkw9OldY1rBzmMVwR6BYetAj+3JQU2HP9ULxD3RsEGq3W0XaJzNGI4fYbmHaIFW9zecPUyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710310586; c=relaxed/simple;
	bh=cb7UYtzZELIt3um9hOD9Nm2Hl5EH9sDOVP9BEELODCA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bNLdIZdbWgRDcPsJSzHNxDSFQp30mlAt7Y/xJhUFRB/9M+eOwGRUGRE1ZygB+PVWEeugq9JF9ibiRNTey5+2R/yfivXB+V0CrAAfeHOUupQHVHSwWA1gYwrO1zEfI/99OarE689P3jE6DtLec5V7BH9bpnsKGoch7tt3sN7CfME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=VauMZk/a; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42D5K3Ml031881;
	Wed, 13 Mar 2024 06:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=cb7UYtzZELIt3um9hOD9Nm2Hl5EH9sDOVP9BEELODCA=; b=
	VauMZk/afFx7Bgjm8SghrSzKnf+R8DeMcbPGcKTtnQp+gWNMVId09v/+4tzmvmkB
	EK8K13xNCxYNvleC5FjaaqujtDqyS3Ij/1n1kIh1cRbexlEM9//3Hk0n4b8rRX0A
	vJFMrvUWV2cCBEGh8K5U053LMD0JllkK4R2LV0G1b9HfVOaBLq4bZtEdcWb7BuLs
	Z9Rw8dz1O2wRzopyJZcvFfTHR4NY2K2xENU24fmOD7iThuEG40wDE1YOgyVMvDm3
	SscXlYALrlM5/4Y8ne75xy1u6oPz/MXOP/NZYt4zDib5qwguSIvh7jLYPaeN9BYc
	uxgzT11znptbJ/Poy78KKA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wrcyxuqe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 06:15:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmwMJuCg1i2udmCrEDVNE9dxrCy66qg1KCdQ+FXBKBMNv1PaqwATPJKmRDeOZM4az4tb9TCxunMWQkRexCgNIFHRAKziMh1xKI4F9oQb0FPKT1zCh2U9SCb5lhUc1t9i43zcDwfNaGD3W3QhTZg+mQEmjpU++PrbwHP1Ogboj/7HQ2mfQG/ivoiMYiR7BhOG+oPRpjwfmYx9tXTBRG5IKSe/jl92m02+DKneWGxiJuewdA9QoVBkZq6DBb4TDjjTHJtXA42A97dIVrAFYyahTdubgnCQU5M4X7pHVsIgkXQHvFt93Xw5c1kxbAw+Q4H//GkzbF1v4823dAuopJCoJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cb7UYtzZELIt3um9hOD9Nm2Hl5EH9sDOVP9BEELODCA=;
 b=d+ZsMMQPA9QFQO5hdLhQ3UbRRid5I7jYMJpYIX1H+L0lwEPZH3sj2PTkqLV2UK4m3ewx31v9eEy+zyvLtAKF4vAUcx5uYwhVYcM063R7j8N04TwC18fgfcqsxWiK5A1LimlM5+rrSyTz9a/KdSppJ1eeHERuhx+3TJ+Js0h8RMJF7fnzaO2DHnOQHdTO/E7EyaPFngiurRgQ8oKghf9qHXdKbD0RyLOOW9e61+964MDwtjSrSe/iObcNLSJ5VrYurhxI2fnCFxg2vr/uAhoHomN9Zb3CKmwdCQO6uWzsBObatzIdScU0iT4H5dUyl5Ngj2xIp/KBPDVsIszzcBEnew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by CO1PR11MB4882.namprd11.prod.outlook.com (2603:10b6:303:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 06:15:54 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::230c:58c0:c3f9:b5f3]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::230c:58c0:c3f9:b5f3%3]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 06:15:53 +0000
From: "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To: Chengming Zhou <chengming.zhou@linux.dev>,
        "sxwjean@me.com"
	<sxwjean@me.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg
	<penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim
	<iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mm/slub: Simplify get_partial_node()
Thread-Topic: [PATCH v2] mm/slub: Simplify get_partial_node()
Thread-Index: AQHadIZoxDwDm1aJM0aqrinyakjAIrE0OUEAgAD4vJA=
Date: Wed, 13 Mar 2024 06:15:53 +0000
Message-ID: 
 <PH0PR11MB51924D5FA695AAEC0E41428EEC2A2@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20240312140532.64124-1-sxwjean@me.com>
 <38beee7c-aceb-4d59-ac79-e7e412a01588@linux.dev>
In-Reply-To: <38beee7c-aceb-4d59-ac79-e7e412a01588@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|CO1PR11MB4882:EE_
x-ms-office365-filtering-correlation-id: 88782ac5-18df-4049-dbc8-08dc43250982
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Dys7Q7vvtBTgi4JEzcHqKqopr+SGCXlhbiVky+hcMrUDUa2N177c1FgoxkdSEjFqCZVck3dRS8aCFVhj9EeiOWnPENr29OX3XmoRkWQaoP4MuSj2+dCZgI/+RiPNAQ/pKNYMxSICUQdNpQdGSy35tbCAJMbvjkhLyAfBvD6cB6PySGJWM8zAiJ07GuJrLYv3IdIIPPyZu5+A8gDy38MD2J/brKQ0W7OQDLfzkv2IsnQH93V1iTA7ft8/XkF2HiVEr0xhqMoDz3ML2dDTe6QnchiPMaNTwezY7JxFIjeYRWBN5tohGEPNWVOwefVVo7bel9xznwmXzPTIxOYrHd/S2MiLLX8mRou1ap9wrZOZa3rXFLPc2oF/DEbYgxF8hWGX/mcGYhilx/Uyyfz6bzDloSTFeZjNOIE6SuEcv7g0ZzyxoasvzbdbXXgqOSbrK7+1gw2ycS2loJ1L7wz+7n1i//D+VhhmX8b35KKQHAdS2nSB5fQb0RqtXoc0t9HEvT45CgzRiiqEXqoxetpu4rNAxFlHAcxtoj0GQVb64VHJeIHxu6RtT3bIvWP7xrWwmCzdAPbkWERkiu8CibodkC7IEIXyJomy5fKdfYWIhi584trMPIXVep9d8eYmT462JnyWcr6aeMRhvo2U0v90/6Yc7I3eZp1sMd0j5i7ks868DKhD+VQVMU/pON1qsXbadt8T
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TU13ZGJFSTlDSzBpaUtTeGVSZUJnRDZqYyt2Q1hpTVN1Y1dybjA2N1g2LzhR?=
 =?utf-8?B?V3h6UTBCRmFyTExYQ1hySENWVWYzdEFBM09DTmJ2NnZMSnBhaVcraFhYeVVo?=
 =?utf-8?B?RmpxOC9jc0JhaDZtTVgzd3dIb0lFS0J4TVowNGJDb1laZkNQZjBMK25oWmdy?=
 =?utf-8?B?d1A5S0xCVS9wVy9xYjAydlZ1Q3FBUzVZT2NRN3d5V1hML3NQZWdIN3FnVS9X?=
 =?utf-8?B?K3BOOFBjcGs1S2lXTlNaNFJyQ3dHei9wR0RoMnlDdER1TEFkVHZJU0s4bllK?=
 =?utf-8?B?bmJKY2FDTkZzMm8xSUhsTEpCNFBEVHJoU2NhR0NhbE8xU1NBZHNBRFh2RTli?=
 =?utf-8?B?SndsTDdHSHo3RGxXSEhjdlIrbHByeC94SVFjSWFQT1ExLzFmaFIzUXNJYWhH?=
 =?utf-8?B?RDhhNkhWeWQ4U01TVVJhQ3ZRbjEvM1J2VFZoa3R2S0gxalhSOGs5a1RITDdR?=
 =?utf-8?B?Z0taMkMwM3NKcGxyZ1dtMWpiQzV1c2NjL250MU01cy80Z0NZeDAxb1BKbFVN?=
 =?utf-8?B?NlZHMVUwanIwYmdkbTFCL3BhT3FXSlZ4dUF1aktQTWpWWnptQkdkMEt3LzNt?=
 =?utf-8?B?aDlNb0RucTg0dFBWMDh1K0VYQ0l0QVZEUkk5ejZ3bGtZeTFCMW1JaTMrMC8z?=
 =?utf-8?B?R2Vyc1ZOQUk2dHlsT1d4Ky9tWWV3MjRidURBN2tTTjZOdzhkVmY3ZUltMzZl?=
 =?utf-8?B?d1M0OStXZHk0OWlJSDZpSlRyUXYxT1Y0dDFFOHoxamhTdnR1UEVyc1BFQUha?=
 =?utf-8?B?c0FHcG1BT2dtSFV5QktQbzMramsvb1VMQ25LQTgzMWczT2sxMmNqcG1FTCt2?=
 =?utf-8?B?aXJBKyswb0c5bmZObUJhVzNocXpSMlNYUmNtTVNiK2NJd2FxQ2NDYkVJd1d5?=
 =?utf-8?B?MXZpcVVXWXV2RXkwdjByZnVLSnU3WUVpK2Z2U0EwUy9IS05VcFBpRnBJM2pR?=
 =?utf-8?B?aCtXM2ZXNzRQMEVsNVBDMDdRRnEvRkdHLzNOUk9naVdWQWVaOEthQk03c0F1?=
 =?utf-8?B?Unl0RnB6Mnl4bmhReFZSUTBLdkN5ZXpWbmp3cGpvVlFWTDV3WDcwdnc5eVM0?=
 =?utf-8?B?cnR5bHV2and4NzQyMmJ2NkFQK2lsczd0Q0h5QS8zZTY2M3RQUWdWZ1ZMTUdl?=
 =?utf-8?B?alFXaFpRbjNpS3RyNjZOMFYyNU1iQ01ITXNXbWNaM3VOSjNRcGs0MnZRcWdu?=
 =?utf-8?B?NHNtRmhrenZSTmo2UW5nZFl6MlgxL0RwSzM4WE13T1FrOFl4ck1hdGF5d1pM?=
 =?utf-8?B?QWI5QVJCdC91N2Z6N3V3TjJDdk55SXNTSlVZOSt3ODhIWktROTlYS0xyamly?=
 =?utf-8?B?Y1FmTTYrc1FzZTBnSVRBNWttdlhROVREVW5pWEpFMVpEMUZFVWZXTmFkT1l1?=
 =?utf-8?B?clcrcTJrdDJoYlVhL2ViNWdmL2ZMMDVmKy9saThtL1pTTnY2Y1g5VEx3SVFn?=
 =?utf-8?B?YjRHS0R4czBnR3ZKUzdRbTJHOGU5Rm93S213aGo1cUN4cHZheFVpcmQ1ZzF2?=
 =?utf-8?B?Q2w3SitLMDNZNTFXNy84cFJkN0o0YmlCc2hmTWxZbDcxbjY4WENteUNLd0dr?=
 =?utf-8?B?b2d3VittNUFTL2dXcGRoM2FyTzkvdWZhODVNQ2FnN1A3N3BNVmVtOHFpRGkv?=
 =?utf-8?B?SU8rWXBmcFBWL1FrSEJDRnlYdmlaRDc2blM0NFpRbjEwNmwzS1ZLQXVNL3pN?=
 =?utf-8?B?N21MRy9DTHVhbCs5TTJHczF4NjV6Wk10a2x0aFZSZU1oSFVGbVptNWFrRUJE?=
 =?utf-8?B?SDFBbmRQbHBjR20yQ2pYWlZGZXNwUTQxMmFOQmZVdlRGaTJYcmNxZjVvbHEx?=
 =?utf-8?B?cXpLMjU2bjB3eTB0aDZPcS9nZndsUkJPa1FIUmFpNy9yUC90WWpvLzU5YUdh?=
 =?utf-8?B?bHpaakY2Y2dlNHFKc2xaM0d6TVRkeDZNaU1UYmxtaG0zQUVqM2MwZUcrUTFH?=
 =?utf-8?B?QVY5c0FYaFFLRFBGN2pjWFBMVm9IWVlKWCsxU2J4c0Q1SGxuNG1MNmt2ZzlE?=
 =?utf-8?B?RFcrTTZBa3FIMzV4eUczTnoxUUFkRzVjTzR3bjVIQmtLbjRoT1JqdFJENEFw?=
 =?utf-8?B?b3NLWndLMVRwcnVBRWZLRmphNCtoNUpWV3I5NmphN1BEWFNYcjlnN1BGamZM?=
 =?utf-8?B?UXJ3ejN0YmJsMjF2VjVCVnMwdERuVklFMjhMRkl2SU9LaTV6VmRSbW9udUV1?=
 =?utf-8?B?cWc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 88782ac5-18df-4049-dbc8-08dc43250982
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 06:15:53.1897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DtfXw+DXLWjqyBngjCoMJoY6U9ESko6EtZWxIuibi8qft1GhD/3utPTLhQDGRVpx4oyQT7gYC5PXqPLEFdDhDO4Pjo/1C7XUZBVETyYjPbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4882
X-Proofpoint-GUID: gBr0QhtJggtgi5rcS7PxV3ygOrq2o_dO
X-Proofpoint-ORIG-GUID: gBr0QhtJggtgi5rcS7PxV3ygOrq2o_dO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_05,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130046

PiBPbiAyMDI0LzMvMTIgMjI6MDUsIHN4d2plYW5AbWUuY29tIHdyb3RlOg0KPiA+IEZyb206IFhp
b25nd2VpIFNvbmcgPHhpb25nd2VpLnNvbmdAd2luZHJpdmVyLmNvbT4NCj4gPg0KPiA+IFJlbW92
ZSB0aGUgY2hlY2sgb2YgIWttZW1fY2FjaGVfaGFzX2NwdV9wYXJ0aWFsKCkgYmVjYXVzZSBpdCBp
cyBhbHdheXMNCj4gPiBmYWxzZSwgd2UndmUga25vd24gdGhpcyBieSBjYWxsaW5nIGttZW1fY2Fj
aGVfZGVidWcoKSBiZWZvcmUgY2FsbGluZw0KPiA+IHJlbW92ZV9wYXJ0aWFsKCksIHNvIHdlIGNh
biByZW1vdmUgdGhlIGNoZWNrLg0KPiA+DQo+ID4gTWVhbndoaWxlLCByZWRvIGZpbGxpbmcgY3B1
IHBhcnRpYWwgYW5kIGFkZCBjb21tZW50IHRvIGltcHJvdmUgdGhlDQo+ID4gcmVhZGFiaWxpdHku
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBYaW9uZ3dlaSBTb25nIDx4aW9uZ3dlaS5zb25nQHdp
bmRyaXZlci5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiAgLSBVc2UgIiNp
ZiBJU19FTkFCTEVEKENPTkZJR19TTFVCX0NQVV9QQVJUSUFMKSIgdG8gaW5zdGVhZA0KPiA+ICAg
ICJpZiAoSVNfRU5BQkxFRChDT05GSUdfU0xVQl9DUFVfUEFSVElBTCkpIiB0byBmaXggYnVpbGQg
ZXJyb3IuDQo+ID4gICAgKFRoYW5rcyBDaGVuZ21pbmcgWmhvdSkNCj4gPiAgLSBBZGQgX19tYXli
ZV91bnVzZWQgZm9yIHBhcnRpYWxfc2xhYnMgdG8gcHJldmVudCBjb21waWxlciB3YXJuaW5nLg0K
PiA+DQo+ID4gdjE6DQo+ID4gIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWtlcm5lbC8y
MDI0MDMxMTEzMjcyMC4zNzc0MS0xLXN4d2plYW5AbWUuY29tL1QvDQo+ID4gLS0tDQo+ID4gIG1t
L3NsdWIuYyB8IDI0ICsrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvbW0vc2x1Yi5jIGIvbW0vc2x1Yi5jDQo+ID4gaW5kZXggYTNhYjA5NmMzOGMwLi5hYjUyNjk2
MGVlNWIgMTAwNjQ0DQo+ID4gLS0tIGEvbW0vc2x1Yi5jDQo+ID4gKysrIGIvbW0vc2x1Yi5jDQo+
ID4gQEAgLTI1ODgsNyArMjU4OCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2xhYiAqZ2V0X3BhcnRpYWxf
bm9kZShzdHJ1Y3Qga21lbV9jYWNoZSAqcywNCj4gPiAgew0KPiA+ICAgICAgIHN0cnVjdCBzbGFi
ICpzbGFiLCAqc2xhYjIsICpwYXJ0aWFsID0gTlVMTDsNCj4gPiAgICAgICB1bnNpZ25lZCBsb25n
IGZsYWdzOw0KPiA+IC0gICAgIHVuc2lnbmVkIGludCBwYXJ0aWFsX3NsYWJzID0gMDsNCj4gPiAr
ICAgICB1bnNpZ25lZCBpbnQgX19tYXliZV91bnVzZWQgcGFydGlhbF9zbGFicyA9IDA7DQo+ID4N
Cj4gPiAgICAgICAvKg0KPiA+ICAgICAgICAqIFJhY3kgY2hlY2suIElmIHdlIG1pc3Rha2VubHkg
c2VlIG5vIHBhcnRpYWwgc2xhYnMgdGhlbiB3ZQ0KPiA+IEBAIC0yNjIwLDE5ICsyNjIwLDIxIEBA
IHN0YXRpYyBzdHJ1Y3Qgc2xhYiAqZ2V0X3BhcnRpYWxfbm9kZShzdHJ1Y3Qga21lbV9jYWNoZSAq
cywNCj4gPiAgICAgICAgICAgICAgIGlmICghcGFydGlhbCkgew0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICBwYXJ0aWFsID0gc2xhYjsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgc3RhdChz
LCBBTExPQ19GUk9NX1BBUlRJQUwpOw0KPiA+IC0gICAgICAgICAgICAgfSBlbHNlIHsNCj4gPiAt
ICAgICAgICAgICAgICAgICAgICAgcHV0X2NwdV9wYXJ0aWFsKHMsIHNsYWIsIDApOw0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICBzdGF0KHMsIENQVV9QQVJUSUFMX05PREUpOw0KPiA+IC0gICAg
ICAgICAgICAgICAgICAgICBwYXJ0aWFsX3NsYWJzKys7DQo+ID4gKw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAvKiBGaWxsIGNwdSBwYXJ0aWFsIGlmIG5lZWRlZCBmcm9tIG5leHQgaXRlcmF0
aW9uLCBvciBicmVhayAqLw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBpZiAoSVNfRU5BQkxF
RChDT05GSUdfU0xVQl9DUFVfUEFSVElBTCkpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29udGludWU7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGVsc2UNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiAgICAgICAgICAgICAgIH0NCj4g
PiAtI2lmZGVmIENPTkZJR19TTFVCX0NQVV9QQVJUSUFMDQo+ID4gLSAgICAgICAgICAgICBpZiAo
IWttZW1fY2FjaGVfaGFzX2NwdV9wYXJ0aWFsKHMpDQo+ID4gLSAgICAgICAgICAgICAgICAgICAg
IHx8IHBhcnRpYWxfc2xhYnMgPiBzLT5jcHVfcGFydGlhbF9zbGFicyAvIDIpDQo+ID4gKw0KPiA+
ICsjaWYgSVNfRU5BQkxFRChDT05GSUdfU0xVQl9DUFVfUEFSVElBTCkNCj4gDQo+IEhtbSwgdGhl
c2UgdHdvIENPTkZJR19TTFVCX0NQVV9QQVJUSUFMIGxvb2sgdmVyYm9zZSB0byBtZSA6KA0KPiAN
Cj4gSG93IGFib3V0IHVzaW5nIGp1c3Qgb25lLCBtYXliZSBsaWtlIHRoaXM/DQo+IA0KPiBkaWZm
IC0tZ2l0IGEvbW0vc2x1Yi5jIGIvbW0vc2x1Yi5jDQo+IGluZGV4IDJlZjg4YmJmNTZhMy4uYTAx
OGM3MTViNjQ4IDEwMDY0NA0KPiAtLS0gYS9tbS9zbHViLmMNCj4gKysrIGIvbW0vc2x1Yi5jDQo+
IEBAIC0yNjIwLDE5ICsyNjIwLDE2IEBAIHN0YXRpYyBzdHJ1Y3Qgc2xhYiAqZ2V0X3BhcnRpYWxf
bm9kZShzdHJ1Y3Qga21lbV9jYWNoZSAqcywNCj4gICAgICAgICAgICAgICAgIGlmICghcGFydGlh
bCkgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBwYXJ0aWFsID0gc2xhYjsNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgc3RhdChzLCBBTExPQ19GUk9NX1BBUlRJQUwpOw0KPiArI2lmZGVm
IENPTkZJR19TTFVCX0NQVV9QQVJUSUFMDQo+ICAgICAgICAgICAgICAgICB9IGVsc2Ugew0KDQpJ
IGRvbid0IGxpa2Ugc3BsaXR0aW5nICAiaWYuLi5lbHNlLi4uIiB1cCB3aXRoIHByZXByb2Nlc3Nv
ciBkaXJlY3RpdmVzIHBlcnNvbmFsbHkuIEl0J3MgbWVzc3kgZm9yIG1lLg0KDQoNCg==

