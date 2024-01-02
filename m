Return-Path: <linux-kernel+bounces-14662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15654822074
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7456EB2258B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F2A154B8;
	Tue,  2 Jan 2024 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iXbKnjLi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CrBqBak3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DEB156E7;
	Tue,  2 Jan 2024 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4029TJf8014850;
	Tue, 2 Jan 2024 17:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=L/k22AoNXY54EDJ4K9AR4FnfxF3bhhDibVjhYpGhkdQ=;
 b=iXbKnjLism+3AKfwZV+fbEu3ulMfEH1Eb0Bk0xUCmJ3HI+pN4Wx3okcV/0Uxbfx591M4
 M/sdBwzSm5Gp3KRgs/0v7UKIBHtR43XpMNJaOCmMlcKBqD+y/FyURvqVmckPwzihYa4T
 qJMFQ/+NphRT+X8Sei1CAiiUPJjwl1Njkg3T1uaBaXp+4uCtiNZ/09VrKNnjSGYyYYzW
 idL7T0aUxCyWd7hBC6FepPKZdviZnA6c4j8zBSyh7VIV9HHtYXEZDC4hnK2pPtc03el1
 bIq1STVoxNYiKR0v2BeF0puoDzfNSCgYV0XLrB4yMvZnhLssIYFnwmhZDCKHpgF/clvA ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vabrv3ef4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jan 2024 17:33:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 402GnKJX001470;
	Tue, 2 Jan 2024 17:33:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3va9n7gxbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jan 2024 17:33:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhSzaQF69v+Ax4udGrP1P5JMQa4wLxFYPR/VjJknrEAQYxAjlI2EQHq4ntwK4LG7oGZqi7opXNxNq2jiGky0m41qzf/2jXnn8u/8wTFbunPbG0V/HzWe5DWZ4oMF1AJHWt92+YV9enje716L8RETRU5I7QyxwW1UEGhs3ajoe0kOnDwyLSk1LQIc83elf3muuan62ECgBznOm8suYYfR1aNLXQgAaYHEFXX+53kEUlo1qG3PHCdUN2vwk8LcOWDcvM61p4+rMsxA95ohCh5fqCIl+MTk81VPBZ5ovTdW3K3s9Csqj9hWQDgxoxt6Z8EFoWiAfxmtqn1IKKbwX7DSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/k22AoNXY54EDJ4K9AR4FnfxF3bhhDibVjhYpGhkdQ=;
 b=atUtCwaYG3n0MYqsAobjAh5AzNUqfr6ewsL8H33DekxWCtc21JQ1djjJDJ0A/FSkQds0ydTdYG4ne1GrghjV9b2C/e9wgtuh60wpETuAXeAit8fbJ4gIYT+ivf+NEiPTcpTn1gl8SgPNesGB1DeVeit8kSh7QN+6hHRUNDer5A78/sREvuS36kpr0T57ZNShQBLfxQjOrCjfKrVOcB2+oGpbBPUguxtNfporCuzbiAsxSaJR8s0qX9iXuEqbqzqZQucL0LALpEPSTs8KePeqnm0ysxLOf361YOqxCp6BVIkCBFEY1F4Gw3up5GJs/c2ZWBsMJp1WuYJ3QM59+y874Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/k22AoNXY54EDJ4K9AR4FnfxF3bhhDibVjhYpGhkdQ=;
 b=CrBqBak3beTHihsvUiDHE3xWfg9cKKf9q1pYb0IEI2VRIQdVzvP4Eb4NV13KwyYaJ2GKyOEDG8xFxi5BU7kkxMyNRx+81BwgwTfzj7+kMiSb/ydqRohB+2S/By+m2oejh7FQL38lb2x2Rg1ru3SV9d84nNtyt0/IoupbT399Aps=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by IA1PR10MB6099.namprd10.prod.outlook.com (2603:10b6:208:3ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Tue, 2 Jan
 2024 17:33:53 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cf88:f211:5770:e4ab]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::cf88:f211:5770:e4ab%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 17:33:53 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Coiby Xu <coxu@redhat.com>
CC: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "itrymybest80@protonmail.com" <itrymybest80@protonmail.com>,
        Mimi Zohar
	<zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E.
 Hallyn" <serge@hallyn.com>,
        "open list:SECURITY SUBSYSTEM"
	<linux-security-module@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] integrity: don't throw an error immediately when failed
 to add a cert to the .machine keyring
Thread-Topic: [PATCH] integrity: don't throw an error immediately when failed
 to add a cert to the .machine keyring
Thread-Index: AQHaOH8TIIKj61NKpUaRSQpmeqn6+LDG0qoA
Date: Tue, 2 Jan 2024 17:33:53 +0000
Message-ID: <2E548AE0-8029-4BB0-B162-4CAD0544EDB8@oracle.com>
References: <20231227044156.166009-1-coxu@redhat.com>
In-Reply-To: <20231227044156.166009-1-coxu@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|IA1PR10MB6099:EE_
x-ms-office365-filtering-correlation-id: 0243f48c-6ff4-4cc1-3d79-08dc0bb8fd4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 n4PewQnZhJV/dtw3PR4Eju/aoTic9dDmbyFwq5kYkfo/Sq+66I6uyJ5abs6EVH6IGhsbaM26CkHh7kwom/zaTPZ1Ad2G1PahvbLvpAoDWFI/UvqlcAvDPxKdAjKuayZP+Ukv5bYx4ajpC+FfghsMdqQvZiw3hROo+AhEUcwPLjXgKjToc/XaB6ch1gkKW4i6KAVWeAdT4E5NSXsyZ7tTRjjWyaPKvAcWizn6E88/2uMQJfDzOOxl96jbFLETXn9KgEW5vocXBpluIZAjRuOVYoYKzg5et/L7e7ukomw5KPFKYPTlLbZoSj/kZaYhSmycCzTxNJs8ufvlpnmGZwq+F3P1VYkrz/0jPPXhCAaAxcrdthtF4l8XMzk2NEyRYwjQgUo2nbFRIHvg8Zv1kHEd6BQedB7dgqRqu97gl7r2rDalLGMit2aTRWMeB0w+mUqX3Ve0+Zxzwpf8MbY2jfg9PcHYbRzwiLsJQfV7+gjXNHbPgb5sw/vvIPinuMEwRSRqMsSQuyLRkYAAc/o6SAm5UlDa+LEhp6WPpSqaU7WxlHfwaJ379GC2V6OJZAAE3crqiLECYa6Av8jdeahQnOw6BWB03O294VJnTYMaif1BWa3PiRH7sWqYYQtMo7uQnoesV7BRMrfHhSkLu1nQZotMV/RJTSR+yTXQm6oqaUoqrzShHe7PyCji1cSQAqZOgHpd
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(64756008)(83380400001)(2906002)(41300700001)(26005)(2616005)(38100700002)(122000001)(8936002)(54906003)(8676002)(7416002)(316002)(71200400001)(4326008)(4744005)(5660300002)(44832011)(966005)(478600001)(53546011)(66476007)(91956017)(6506007)(6512007)(6916009)(66556008)(66946007)(6486002)(76116006)(66446008)(14773004)(86362001)(38070700009)(33656002)(36756003)(142923001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MWVaRW1POEJWcEIxMENsNEQ0QU54Z3V1YWpqVVZOSGJ3dXM4TE54dEhxMFFj?=
 =?utf-8?B?TlRDSmtMTXRWOUVjTWxuSVpOSmNaYUpsbUNXZGljZzlzQVpjV1RNdG1wdFB5?=
 =?utf-8?B?Rlk3Z3RjMElNbHU1Z3JXVUE2ZjNoTFJYaEE4REx0SFltY0wxZjdEeXdLTFpu?=
 =?utf-8?B?M0c0RXdVcXNaYWJKN3p2RWRJVGgxRjJ2cVBRVGd2dGltQTlHbHR2aHRnelN5?=
 =?utf-8?B?Qmh5cGpWd0VFS3F1QTdXczM3RWhlYnlZNkFnMERFbnZCOUlPemJYUGhsRWI2?=
 =?utf-8?B?bUhLNnkxcElTdlI4TVdlelJLNmpPRm1EaFBZZ0NhUzBiNlBTTDJMVklyZElm?=
 =?utf-8?B?U0J1bnJOY0NQaWlJKzd2K1F3T2RzQUNLTXNRdVRxd3lkempWNytKVlFEZVQ5?=
 =?utf-8?B?aG03RlY2QkVVZkFyRnZaUjdkL0paZk42YlFLUXVyWUVNU2Z4ZVNYT00wUEVx?=
 =?utf-8?B?akV1U2RrZWxXTkJOSWlGbi90SytFU3dNOVFVNFR5bDJxS1NkdDNXUTlDeUtC?=
 =?utf-8?B?ckdWaXpqSlp2aUJwUWhCZzJJZ0pVTDd2bjlmbTVuL0tacTh1WGZlZWtHdVpC?=
 =?utf-8?B?YitnZFBLVUxhQnJMbEdSbXdGYmkxUzQvSE9mU0NlcnF6VWZrb05hWmNaY0hh?=
 =?utf-8?B?Mk90YjR2cUhzeVRBRUFVSkhkUzF6b1JDeUF6Nk1jWTkzakMxbFN0Q3pEYXF5?=
 =?utf-8?B?OW8wenl2ejc2RmRlSWZKNnU0KzBTZU5VQ01MdzhITjV1Ti9vU2xraVB2TXBr?=
 =?utf-8?B?M2FOTUQzM0hYSUMrcHJoV3FETWs2dXFCR0Iycyt0MmRQM2IrbWp1cUV5Y0dE?=
 =?utf-8?B?SXNuSGxTT1ZJa2hKblNJdy80OFY5T044WTEwT3lBOFgyTVVmSlNPQWRFS0NF?=
 =?utf-8?B?ZFdEY0dhK0pKbzIrTm9lcXpyWFBlUlNxVU9VVnYxRUFva2o0RENTYUEzeUQz?=
 =?utf-8?B?U1dFaGloekdjK29CY1llcnBGbTZkUUNaRmRyb1lzN3o5QzRrUldVd0U4Zi9P?=
 =?utf-8?B?VHFFd2V3ODBsNTVxNjdPWGYrTmg1L3k3dmlZa2JrWjNVZmdOUG5EU1p2YzZR?=
 =?utf-8?B?WWFJUk9LVlI0MlFKcFlvUUlvMDhjOVlQdTRpR0k2d3RmMzl4NkxWajNlR1g0?=
 =?utf-8?B?YlJDandLT3p2WHdDc3JKV1hPSHFwVEorNG5MN3daVGl4dGpNekt2TmM4RnFU?=
 =?utf-8?B?bHVKOTc1R0E0WUJrVHc2NXhUaVYwRkVSZk9aUjZ4cFg4dUl4eW1VbjI0U3d4?=
 =?utf-8?B?RHAxbDN5S1k4Nk5Cd2lQd2tkS0ttenE0Y3RCbUdYUTQxd2d1TXNmQmd1Zits?=
 =?utf-8?B?VHRFQjRtVndVVGp4UWVrQ3cvS2VORlVhdFJYdWcrUkJlRDhXcWYvRWEvZDMv?=
 =?utf-8?B?ZEJtZmdxRnJCL0oyZ0Iwd1JTejM1ckgzcW90VVVQQlhEcnc1WjBvSkVDZEox?=
 =?utf-8?B?RFBEbWpzTkhzR1UzZkIvRGJLUDc3NkhjdXAySFhrQXZERTBpazBOM0h3Ly82?=
 =?utf-8?B?ZWZxa0hUTWdMdTA2KzlHcEwrUHU5NjFGVkJ3N3Y1VW1JU3lBMTVCNDltSkhY?=
 =?utf-8?B?dHlyUk5nOEhxUmM4dVk0eExXMXBqT0lBMUxLVTNLVENYRHdVN3VuNCtZY2hH?=
 =?utf-8?B?Y0Q4bks2SnpRb2hLQUdHNjlWWXZZeE5yeEhZYkxyakMzWGFBZmU0SWU4Tzhp?=
 =?utf-8?B?eXRRcU4raVVoMVR2VWlVZlFsd295aGNsWXduQTJXUUxabHJZVWE0V243aTFL?=
 =?utf-8?B?T1lKUWNJd2xpejVWT3g1NTV5S3l0clpPT0ZwSVUzcEcxcG43cGI3VmpseGt5?=
 =?utf-8?B?RnR6TmhkTXUyT1JWSDIwMTE2UDU5OGxuMlk5TDFhUnVRRmhRNkZUSk4wMGJv?=
 =?utf-8?B?N0hBd0htdHFtQ3Boby90NUtuNXpuaC92UnhMb1JSbkVMYmpsc2ZBYjBjWlNE?=
 =?utf-8?B?STRqaWpNMTMwVU8yemdidXpTK2pwUFc3a3kvbGpXd2FtcU40dnRQdWp4ZFRr?=
 =?utf-8?B?OTJrL2NQdkt5OFlJYUZaK2VVUjlYREovRW1USWQrbVJDRVF1SXBETUNiWGFz?=
 =?utf-8?B?dDgvZFQ2Y21tSlF0aXp0cGRQSVhZTThxNnZuaTBFNlZXVVgzcUdTelZWZTZN?=
 =?utf-8?B?a1pVNXdmNWVISUpCakFlUTE0Y25ZdS9DS3Q4V2hRbTg1YWk3a2VFdmZ1SFVF?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3E27294A4514D4F91B5DE9254875FD4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OuST4yqw0hfdPSyEH91XOOSYHBUK/fQMCROHUxTeW6Ww45DVga3eHmTgV9cuIZMVkBs9uoSGe81EesGL5mqbdnEh4092prmahayxrN4t3Ugh5AAtYudGgnVqi4+8E8dkqfUobdrIL4K4o3PCO/U05NbsJPf7yHmR8ymkIizt+uzQCxO4fRUCdWSvbogp0w9ydAfCg0gQ1RwY9Fdw5cMZTX+/X4Wew1dZRbirCcWSPTk2dChttHO0hqQP+NA81P6XqX1REur5tteDmMjjB7QS/toxAKetgYG1rCceRf3v0G133jkn+9oZhqFl9J6Kb/gUCTkQcdPP+bFgWuLDWdnWbuofnUjoIFiAlPvZT5BcvmC0ClC8a87qkmaLP/IlZniCNjH6jz8R3ubD6FnLjw1viXQwh35M5jWdTCxgX60a3cIwarhzI86UrpGngqhfl0D9BkBb+exP2edyAkBKnk/JYZe/KSgEfIuyHLiIWS4AFpnEzYTggavrNeOVZzmkNM80R0oc0e8ufLGSrbi30HzUrwrHRswYv/s93l2GL0NupayvnnTVoXepmjtwYMaEVX8v8oQnP4499zjriEb68EuOGUqe0pcelJVZQu0qtop1c6A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0243f48c-6ff4-4cc1-3d79-08dc0bb8fd4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 17:33:53.1269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ut/vtBajHDw/8SREs6qvxmjV7uK9KDE46HOLwkeuBptYmYPkX1+P/l0iWjX4nSZunGb/QaEgDF1AqLrAUY+WGAg7Mn/ftFC6k4lgiID5/UY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_06,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401020132
X-Proofpoint-ORIG-GUID: beLntiwhNrP32_Uc1EV6VV_9-lz1vM5E
X-Proofpoint-GUID: beLntiwhNrP32_Uc1EV6VV_9-lz1vM5E

DQoNCj4gT24gRGVjIDI2LCAyMDIzLCBhdCA5OjQx4oCvUE0sIENvaWJ5IFh1IDxjb3h1QHJlZGhh
dC5jb20+IHdyb3RlOg0KPiANCj4gQ3VycmVudGx5IHdoZW4gdGhlIGtlcm5lbCBmYWlscyB0byBh
ZGQgYSBjZXJ0IHRvIHRoZSAubWFjaGluZSBrZXlyaW5nLA0KPiBpdCB3aWxsIHRocm93IGFuIGVy
cm9yIGltbWVkaWF0ZWx5IGluIHRoZSBmdW5jdGlvbiBpbnRlZ3JpdHlfYWRkX2tleS4NCj4gDQo+
IFNpbmNlIHRoZSBrZXJuZWwgd2lsbCB0cnkgYWRkaW5nIHRvIHRoZSAucGxhdGZvcm0ga2V5cmlu
ZyBuZXh0IG9yIHRocm93DQo+IGFuIGVycm9yIChpbiB0aGUgY2FsbGVyIG9mIGludGVncml0eV9h
ZGRfa2V5IGkuZS4gYWRkX3RvX21hY2hpbmVfa2V5cmluZyksDQo+IHNvIHRoZXJlIGlzIG5vIG5l
ZWQgdG8gdGhyb3cgYW4gZXJyb3IgaW1tZWRpYXRlbHkgaW4gaW50ZWdyaXR5X2FkZF9rZXkuDQo+
IA0KPiBSZXBvcnRlZC1ieTogaXRyeW15YmVzdDgwQHByb3Rvbm1haWwuY29tDQo+IENsb3Nlczog
aHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0yMjM5MzMxDQo+IFNp
Z25lZC1vZmYtYnk6IENvaWJ5IFh1IDxjb3h1QHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBF
cmljIFNub3diZXJnIDxlcmljLnNub3diZXJnQG9yYWNsZS5jb20+DQoNCg==

