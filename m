Return-Path: <linux-kernel+bounces-18434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EED21825D5F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 01:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23445B22D7A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 00:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1471396;
	Sat,  6 Jan 2024 00:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y3M8QTTV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZrzlJqv5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D43810E3;
	Sat,  6 Jan 2024 00:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4060M1TU023452;
	Sat, 6 Jan 2024 00:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=bRf838ysuYU7HbjbWp4BVQn7q70CP4t9wYkmXh2tqmE=;
 b=Y3M8QTTVxmdGOX9al1MlmnMSHnc+VLaJkHTer16kkacLu8OegSxYGpObePVzWjsEDHVU
 wb7YAK8m+olLluLUZRzzVxM5UGGWtKbKscBEDUu/JA3cN0EOnYBuzRFima0DLO0X8GWR
 DYS9+3pFBUZvyXgbjjo6G88wmEi/Q1B2oAh4yvjMXZVwBJQ3aR7qtxfgv42UhpuDp03V
 tk9ybcA1Fayf3fvgk9yvZQwvdEtQt9vxutAjWZ4se7drFupsVi2TE08O2hXOu/6GP6By
 JmgPsszspqTYh0OnilKuh25gPN0LIWhdhpxcY+d2apCJuXTezoXMok1Dr7iJEB6YDz15 5w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vev8kg05v-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Jan 2024 00:31:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 405NJKtS010797;
	Sat, 6 Jan 2024 00:26:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ve176f52c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Jan 2024 00:26:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DraRPwxJZueYecCIOS9HQshUk9lPxHgEj1MUO12YEzjCYhAtaRTaoj+sPn7619KHfTCcJDqZkmMgCOpacBeKs0kOS/jBX3yRvtM0jy3bPx5Ei8/DF2Lzs3Wu7V1pP7cilUqCNxwS5kEq09JQjp1UBPyakI21yKdaptRc4ypfp/pnI8N8DfKTNsZ+w4HSNRXr9oQ/VGVB9gNHTLCfcptlv7g2XQBIUr3SNvTpNQzej+jg6v7P6mlyeXFkQCmlvCFTZ89i8A8/x41r7OAsUr0ZGY9gf0QZEVa7xra48+2l4sFBBBtBUdveNe2yXPzaG3lvuZW+sG2W+s+wtjs6M4pfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRf838ysuYU7HbjbWp4BVQn7q70CP4t9wYkmXh2tqmE=;
 b=kIzS4TcGf6LtdGY0FKqCsm/ZecGMrd5TbzHEMqYZLcYFAel6qddA9Cc0WnkHbE6JBqU7+QtvIt0ICSA0d2/tIdM9TElKAazVl0B4USXUqx+lUZUsfMS4R3FOFK0bA29G3m2uZ8/AFdOmeaQrfqc4jluVflRw2oVBOn7EzTW9YwrOzX0zgxmSsezc7+hn10uizRVJv+3V5QeRXIu2LySfieqhgTHlTAeVlZXO2opguDZ22CQTlaVx4uuZQeneTUxyzXU6rNnucpatnW23CrXJoqp3ppA/g2BYMWtzXfAL4XEllibK8mGwLl2oveV91RJcLTCV8P+33/cidUoaPiTfeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRf838ysuYU7HbjbWp4BVQn7q70CP4t9wYkmXh2tqmE=;
 b=ZrzlJqv5WRIsPPF3Iasuc6OouQ4C9Ehvis4TbFj0jTEMvS1mDgTQE5D3Rpohvsn/SvSyJ/AkTkORLoV7VnWWPe2kVO/kwbLTQAd1u2yt9oTGY5qZNjp4x454eJuI/ZSrRM6v+urOYx7lsfu5+HUKLVPYCYCgmXVr/l42V8scvSo=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by SA1PR10MB6366.namprd10.prod.outlook.com (2603:10b6:806:256::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Sat, 6 Jan
 2024 00:26:53 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::f88a:b338:c1cd:9158]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::f88a:b338:c1cd:9158%7]) with mapi id 15.20.7159.015; Sat, 6 Jan 2024
 00:26:53 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Jeff Layton <jlayton@kernel.org>, Jeff Layton <jlayton@redhat.com>,
        Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List
	<linux-next@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: linux-next: manual merge of the nfsd tree with the nfsd-fixes
 tree
Thread-Topic: linux-next: manual merge of the nfsd tree with the nfsd-fixes
 tree
Thread-Index: AQHaP2oyG8aHyGJuCk+gdm+YHXAyhrDKlf6AgAE5rICAAB+MAA==
Date: Sat, 6 Jan 2024 00:26:53 +0000
Message-ID: <A65DB9F5-8777-430E-8BDB-F2AD2E073A25@oracle.com>
References: <20240105110007.3f932561@canb.auug.org.au>
 <ZZd8q4RSTTN/5wSq@tissot.1015granger.net>
 <20240106093347.15810e18@canb.auug.org.au>
In-Reply-To: <20240106093347.15810e18@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5134:EE_|SA1PR10MB6366:EE_
x-ms-office365-filtering-correlation-id: 208a11fa-ae1f-42fe-bd88-08dc0e4e2eaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 K9VM69mfQu3YedFyzXZSdJZOEupfc+KBwMPMx/HvOgK0NFcOPALfzCmCoMrWwx9qUOWsNjavtqI1sqg9OQjqaMRc+WfhFJD8t499xoxL2L1FvKgA8FVFlY+ntcWN3zS54Ax7/d/c4Z02ZxKfCt8Nw15NFag9vNls4EJ5ExZSy8Ghm3FGtxL9APZyt+v7MuivoynMHVo2IF765SvpxCDtI8QmOcyiGYt0HB5C25iJggNTpxDEMcTlhgz0tRjvXR2JJ3g/KX7N/i84qbtEJw7daEmKoXiJZRQapNpMIKZdNcWDlN+vEblUG9nNchKyQa6Q5a3UZRHhux4kUhcbUGPJpI26GMeSFxAqwdl4m9rqebzrgB+7cCgbSjDT0zEazCtXMxQ7tcTPjzNwbslxe1YY+aHCjrUWuynAguC1pAMmC63Kfx5PKtEOHKEbBQH8lOo8rpYUEbhFzAiZSLufwBHaMoc4WHt5Jjyrgz3Cc+ABkiN3f9BnpaHPWTm2rth442G7w3Cu7MFrjTgizhbP4u2n8pria31lyIsZqt0mrLU7dfH0wpdPF8EK1US4IHWLrhNDUe+uy97DEx0AUg4/ntUd3rMZUAnCZIbeQYyURKSvFspDz/k1lbTotaXG63ICix2ik/o4z11TOWeD0VrS19V5Cg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(2906002)(26005)(83380400001)(4744005)(122000001)(38100700002)(2616005)(8936002)(8676002)(316002)(54906003)(478600001)(4326008)(5660300002)(71200400001)(64756008)(91956017)(66556008)(41300700001)(76116006)(6916009)(6512007)(53546011)(66946007)(66476007)(66446008)(6506007)(86362001)(6486002)(33656002)(38070700009)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dFE1OS9jSlN5L2gxd2xsb0xGUzByOVVEZkRERm8yeHp6alZ1RzlHUG81S3ZX?=
 =?utf-8?B?d0E1QkRlb1pydVY1UzEzMXNXanFlT2FTUlJSaForQy9iNWZjSG9nMUhsZVZB?=
 =?utf-8?B?Q1FvZ0NmQlVQc0E4Y1c2aEZpT3MvcnhTT09SV1hlWnRLYUZBei9OKytiRlRk?=
 =?utf-8?B?dGg4MmRNQXlYYlZjMEFBOWlkeVZGYis4ZHlUNVhHb3JxWHRyNENXd1NVZ3NT?=
 =?utf-8?B?eHpXVXlERHhmaTE0UWIvempUbDR0TnF1T0cvckx2YldrN1ErSVdsRklYcmR4?=
 =?utf-8?B?WTNVK3Y1NzdFY0d6M2dibi81UTc0eFB0aWE4MG1USzhRdy9uSEZRUUZDdFFl?=
 =?utf-8?B?b3dwWmhPQmIwYmFqOEJMbXErQ2t1RW9hQnpYVnhsZFNYbzBNdmhJM1laNStw?=
 =?utf-8?B?SEFLSlRHNEJEVjVvNVFsRFloclFWaklhcE5sTWJuL2tORWYxTGNyQ2IwMm15?=
 =?utf-8?B?MW1QU3BsdThuUVFocE9wSlc3WkdlODV6Y1d3UXYrS3UwSWpFT3ZWUjdsTUxl?=
 =?utf-8?B?QmFCdE1HSHFTVmVGV3BvN3V1WFJkYjdZYVl5UkhXbzFrWnlFT2ZLYm5NUnNa?=
 =?utf-8?B?TVk0eVFTS0t5bU5TNmJnUE95cEdhWXJURDJNMEJpMDdvN20rakVSUzBqU3Q3?=
 =?utf-8?B?M04wckVsK3dqcjhXZ0ZTV1YwdncrODUvUE9DYUJoWVF3OW90TG5nOTBGQm5W?=
 =?utf-8?B?aVFnTzFXT3J1QkJPSm9ZWG83QVhKOHRQRkpxY2huTzBXN3U5WjdhOUlFUWlI?=
 =?utf-8?B?MEtFZlZVRisxK2FaUEpJMXFrc1U2dWNvS3pxN1VVUlJ1UHA3RWppMTFDWmdL?=
 =?utf-8?B?MS9NWmhjbHM1aFdsVkxmRDcvaHhjTC9tZ01PZWxFd3FyQmxzVHpJL0pTTEc4?=
 =?utf-8?B?c0FPOGgxVXNyaDFlaXFURXlRS1JCT3J4NFduNmdibzk5WXRUWU9mbTRXS0dV?=
 =?utf-8?B?OVBCUGljYklQcmVWS3FQZkFzNlVIT0pWbGIxT0c3S2dsMXZ3dndLQkpKTTE3?=
 =?utf-8?B?ZVdpS21JWjYzRTlGM0N1THVZVG1mRTF6NEx2TGlUMGdSRnNrQTRWMjAwMlVR?=
 =?utf-8?B?bXd2UjhEQno1YnIyMXJsQ2p1RUFoT1E5YjB0SS9rOEtzb2l0elZCbk1RWnZi?=
 =?utf-8?B?QWR5cTVwRGJNODBIYU9PZi9TTEtKZklHZUcvWWtQYUVxZ3Z6Q3dXSjNscUdH?=
 =?utf-8?B?a3krUjZrRkZXMzlPM1ZEZjFXY3Q5RDR2NFBWME5CRjlxS0l2azRHNVhRdVUz?=
 =?utf-8?B?bzY5Ti9FN1FpZkFqeWlQbjZxQVZJSDFSUlFUcG53SjQ2eGJSalBDVk9PaUoy?=
 =?utf-8?B?Z254dE1tN09ibDVoODAzRnQ1cWtkRGdaMTFEc0lyWkZvaGh0RFlOWmFsNmIy?=
 =?utf-8?B?RTd2eXMrYlAwUm9pVGtCd0NJL05wdWtJYmhQQy9QaUJSK2ZCSEpBR1ByQWd3?=
 =?utf-8?B?b0RWTmxjdVNMZjFESmFxTEgrS0trbjVXcUN1QkIveDFSNmhCNHBqeWFwRnha?=
 =?utf-8?B?RUxwRXZHTHAvUlhvSURQUGxKNTh0NW9iZXgrT3FpSlJiL2lJYVF2eGpVL2VG?=
 =?utf-8?B?Q3U3MHNVbVhNY3FKZGxCMTJ3UUlGcXdyejBGdVdIeGg4Q1VOZnpZTzhHaE9I?=
 =?utf-8?B?WnJOS0xXNE1zY3h3ek9SNmFrYjBhQy9xUDNjWGYwZm1uQWVUVEZRbG9qS0xj?=
 =?utf-8?B?a1pwQkxWUHB6cHJOcVJBVUcvN3dlVzl2b3oveXhaeUNpL0h0eitaQlFzZEVt?=
 =?utf-8?B?ZVZHMEJhU2YwSlo3U3NEU3IwU2dqb3BuOXA1RW1lSlQwNExWT0NtUlNPRFNi?=
 =?utf-8?B?b3NwVXIvc3hGdjZiWmhEL3NZQTQwOEIrbGdwZWdTZ3hoZ0NOb1B6N1lEZEZ6?=
 =?utf-8?B?c2JyNmk5aHVnYmFOOFNNSVMrUHhGenBYRDU3SDlNT0h3ZUkzNDRvcHJCdVJS?=
 =?utf-8?B?QUU2TmZvVmVvMWlWQVBkY1V0V05NL2JseFBvNnpGUHZwL0FOL1NTdVZ2N1VR?=
 =?utf-8?B?d2N3YVVrbXNpRFFaejkvOXRkT09mNTM1Mm4xSnY1TURsL1owR3hMUXNHYTFE?=
 =?utf-8?B?VlN1S2ZMMkFEK24yU2JseGE1NTFvdTVhMlNrUk9wYzViNlpQWWlUVFh5Z0V0?=
 =?utf-8?B?TDZRdEFaTlBkMS9ZZTAwSlNCUTNzdG5xcFhiTWMyZktaTHhTNGpzQUtXSzNI?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10234FBC24B05A4D935FE2AEECFF2397@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5LKU42ckOJCWRPuldxPC6lFebqDQaLtdp9UTbHC4T4EfVjmzxV7o+5Slux2vzSwf8abIMUWCgPq6gWN+FPW9dUZL8qZQQLOMl0rbNbZJNJmoXveQvNTJIls4wsc2lskJphhDOE7ipM+NQBikRn85sgpVCSPvQuzIaoikgfsx2vaU43VMbc/HA5eTcGbemMTQuDYJ0L/UTuMXF8TtGIaT1FbHy27lf+4NCb23GO192FOng9HUUsv6TRrMumZBD18v6+HwBBqchR/Y3/v6G51B6Mas5G7v0VPbfL8rDzBeNYbGRo4ZJL0Iy7wDsNOK5xjm/vPU0lZzW639TvQZfWWWVyW1ZN72hyyUegPT4NKCU/UxAS6wMPf4PZ3K77FXuO264aP3AvALjj2P+Tw5VCH0wqN7t67Q/AKxmmEv6LJlvVPuWjv35TJmOL259/3aaX6iQWZJk1eOREueyHJNlNnkxUzTQ/VYitglsdgUl5+9vRTzzxLhEwg5NvaBRUjtNUASC7Qkr/tJKXPpKp4BFfsZAPGGFVijm4k7GKw0OJI+pWw0tTppXXIdtL8RKSVKwLDcSJsg5a47ShRwAfuzfmVVCapWOyzgo4mB6Tkc1nOQq8E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208a11fa-ae1f-42fe-bd88-08dc0e4e2eaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2024 00:26:53.3054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pa0BpobWQIed2aAuYgAeSwixNdhrXCeuc210+kG8ySMZScCVWpF7UGH6b1hsF+AoWnOU249V49eb/XiP4otOBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6366
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401060000
X-Proofpoint-GUID: TX23N7qTL2oFYcw_GPrbEkWq3aOYnHPz
X-Proofpoint-ORIG-GUID: TX23N7qTL2oFYcw_GPrbEkWq3aOYnHPz

DQoNCj4gT24gSmFuIDUsIDIwMjQsIGF0IDU6MzPigK9QTSwgU3RlcGhlbiBSb3Rod2VsbCA8c2Zy
QGNhbmIuYXV1Zy5vcmcuYXU+IHdyb3RlOg0KPiANCj4gSGkgQ2h1Y2ssDQo+IA0KPiBPbiBUaHUs
IDQgSmFuIDIwMjQgMjI6NTE6MDcgLTA1MDAgQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNs
ZS5jb20+IHdyb3RlOg0KPj4gDQo+PiBJIHBsYW4gdG8gcmViYXNlIG5mc2QtbmV4dCBhcyBzb29u
IGFzIDc2ZDI5NmE4MjY1NyAoIm5mc2Q6IGRyb3AgdGhlDQo+PiBuZnNkX3B1dCBoZWxwZXIiKSBp
cyBtZXJnZWQuIEknbGwgaGF2ZSBhIGNsb3NlciBsb29rIGF0IHRoaXMNCj4+IGNvbmZsaWN0IHRv
bW9ycm93IChteSB0aW1lKS4NCj4gDQo+IEluc3RlYWQgb2YgcmViYXNpbmcgeW91ciB0cmVlIGp1
c3QgYmVmb3JlIHRoZSBtZXJnZSB3aW5kb3csIHdoeSBub3QNCj4ganVzdCBtZXJnZSBuZnNkLWZp
eGVzIGludG8gdGhlIG5mc2QgdHJlZT8NCg0KTXkgZGV2ZWxvcG1lbnQgdG9vbGNoYWluIGlzIHN0
Z2l0LCB3aGVyZSByZWJhc2luZyBpcyBidXR0LQ0Kc2ltcGxlLg0KDQpJJ20gbm90IHNtYXJ0IGVu
b3VnaCB0byBtYWtlIGFsbCB0aGF0IHdvcmsgb3V0LCBhbmQgbWVyZ2VzDQptYWtlIG15IGhlYWQg
aHVydC4gVGhhdCdzIHdoeSBJIGxldCB5b3UgYW5kIExpbnVzIGhhbmRsZSBpdCwNCmFuZCB0aGVu
IG5ldmVyIHJlYmFzZSBvbmNlIG15IFBScyBhcmUgbWVyZ2VkIGludG8NCnRvcnZhbGRzL2xpbnV4
LmdpdC4NCg0KSSdtIG9wZW4gdG8gbGVhcm5pbmcgbW9yZSwgYnV0IEkgbWlnaHQgcmVzaXN0IG1h
a2luZyBteSBkZXYNCndvcmtmbG93IG1vcmUgY29tcGxpY2F0ZWQuDQoNCg0KLS0NCkNodWNrIExl
dmVyDQoNCg0K

