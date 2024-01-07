Return-Path: <linux-kernel+bounces-19013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C22878266B9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 00:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974C11C20E12
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 23:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B117C13FE7;
	Sun,  7 Jan 2024 23:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UfvYL7lc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fcUYwvVk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77A913AE2;
	Sun,  7 Jan 2024 23:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 407N2CgI021189;
	Sun, 7 Jan 2024 23:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=bJndHk0WTOr8yyq31/HeIWmf2QI5tOH8sEfAhfa4yvg=;
 b=UfvYL7lcars1U9AvGiMDn53LCIgrD6Ue2AFVcfcZMC2vpL5UJlSk2RsTw5hEjoZ4JelB
 2midGCK1Lc8dLmbU/nacRSZGEe9zyx+3Hkht/5pvLZSNJ0VwIiosHLH2VxmbDn+sR9Ps
 PpMlvb69TSM09dgf5nEGXUgzuqB3tIZAYAmIsKEo4AKaSYnJSfvdYtNPBmMW6v4bPQrA
 HewWrmeZ0rBaO03pyAj+ml/JCUEC2LDEB2rYbt6vrgjDVqCJV3txuyrba1bkP7inJEoH
 q+gkJSfqLWJrswRsD8FKossVBweoquVYRXYUYHznATsRUKgCAIu4wtIfjVnV17w9hhab 4Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vg596r024-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Jan 2024 23:04:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 407LuAI5008831;
	Sun, 7 Jan 2024 23:04:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuufkrb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Jan 2024 23:04:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAFZrtMVw2HOBP5O801VdcalXndwFYi4+LGems48og18IRP8alY7gUDgHM4lKlC4cemmNQ7pnUnKpYn7U/Eo50q8MIqdyYmwL7bijkVrCwWbGauMTg02Bk0Y5lrk07wEqpKoPgurxz0afi3TmPC23D/TaluwKpNcMSzXtxIBJLnbKx8aTNHApRkgwK76P0DpkotQ64ioe0mfPHtD68v0tMM9dk39p/5WYWiFjZTEvKnIVq3Z/GWFijg+Mp2SDTVmb6qNGLfOgsRrgUDQFvaVsbFoDu+yIlxoCmY7sESHxO3Q6fH1anNhRc3w6Bk4bdyEjehws7ezenCrprwdvPfUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJndHk0WTOr8yyq31/HeIWmf2QI5tOH8sEfAhfa4yvg=;
 b=lsWx9FxLGzYoXird7LF4tKZFCU7ZXI+V3B0PcHriwrxowD/TL7LMtL1eDmjl/cIQ9PUid5pCKB/D0qUsmTaSdFmoGQ32YTsYlJ5+Vmh8Nrne7zpqGY3hjxcG6T73idCUz1l5yS3VUE7IyCRnjF0w0gjTYeqddTOR52exSqhiaJhir3aIqai0lDH0J9iX71D0msDXieQ8VwCRqgUEf+7MispsEEbxy8qB3AqWqSbA7C5GR0UB/7nNTNLLMtLGJEkJ/GUfP/G92GzOElVp6FYD27hbuZ9xNKb6/eqbCVyV25SDrJWPsczgEvVd6za1z+5rIh/GMh4pUialdYJUqSrWkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJndHk0WTOr8yyq31/HeIWmf2QI5tOH8sEfAhfa4yvg=;
 b=fcUYwvVkXM4c1SYrg7mlf7q3z/2DpM6mvSie6SoCdGkCf6N4HdOqr/X+K7U1WFbekaUx50nnD+fnHUYgFJ+IrrB/7gLThxbeNzZBxe52DSMar9H0tqaahgs6ylgYN+Mufh3TmlraT3kE9HaX9YYhDN0eWcd8nNFjNxmHwpMZqAc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4237.namprd10.prod.outlook.com (2603:10b6:208:1dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Sun, 7 Jan
 2024 23:04:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7159.020; Sun, 7 Jan 2024
 23:04:21 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the nfsd tree
Thread-Topic: linux-next: duplicate patch in the nfsd tree
Thread-Index: AQHaQa9abZNJqAiB6kKb3Dilr58hZLDO+EeA
Date: Sun, 7 Jan 2024 23:04:21 +0000
Message-ID: <B165D861-0AAF-430E-9083-6E4EE91D8E8A@oracle.com>
References: <20240108081930.78bad29a@canb.auug.org.au>
In-Reply-To: <20240108081930.78bad29a@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4237:EE_
x-ms-office365-filtering-correlation-id: 81f89655-0be7-40d7-3392-08dc0fd4fc0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 P6TfwvZAKjFoY8i8Dzk8xBKN8NY1fSX6AHozY5254xnHfMPFlLLGx3M1y9Rw1EBVbadTJVp0Zj0Di5CVFv9bpFOELWWaKw2j2OFrS/BlHSrfVYTBzjRwZDsky90uvZd6v9HWstRjEK0b6+fTPBvZ7MUbh0RfAJVPxLMW2iqZ0faY/iQ0XHOMYI0rZDwjeT0HXRipa8TFforP/fUZvemEGGjypaZR95isu/Aqf3GgiVP6/3cVt7OefB3UaXhTEKwXPx6VjJugay4lm/bNL+/kvEw1r7vBB0t2PxrBeteKN9BvgEKQ+Sd7Ynp37wVMhzfPkYycFaZ6MVxo8n1TVJsWE4BuazfCFNRBkizse4AiIR+uOWFttb9imlaRf0nQmlVceIkmXIgpPP6qYQQhzOkqurIK0y5j+WU6xb0eosHnN4FSM5HtG/XrH+i7uBLcch24rfJPodqCGKalqn0g/YXWn0FAqfEVGdcX/crU8TTT/qKSSx0LuUJrYI3Fa6s9Lpjc9ueKlWxceU85fVG0NRRtHu+KDmMgRYdO0b7MHnrbRDBrgugschbWMJYnCpy1KNDLHGTmPi0w1Y8m8oYamC5Sgj9CvePeADxKCSG/CrPAnyZOoMYRKfpKH1r+N6DNdmip2p9yOZpP3dvlhMYnrxzJPw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(54906003)(122000001)(91956017)(316002)(86362001)(4326008)(71200400001)(6916009)(64756008)(66556008)(6486002)(76116006)(66446008)(66946007)(66476007)(478600001)(38100700002)(26005)(2616005)(6506007)(53546011)(6512007)(8936002)(8676002)(33656002)(5660300002)(36756003)(2906002)(4744005)(41300700001)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OG1BMEZoNlJmYW1Ba096NkU0U29xNjFrdnlJcnBNSlE3Vjd2QTcwTWJyazBY?=
 =?utf-8?B?Nkt4RWY2azlyUTA5YnVnK29OZFN1T20yaGR3dGpKK0ZjYkRRcmtLNndGOWFa?=
 =?utf-8?B?VzZFZkpnNUJvYW52VkNGVGZ2c1ZEa3M0MHZTSXBLSDR0M0daU2k2dG9HRmZS?=
 =?utf-8?B?UEtFQzNiS0drMDVwMzdJRXBIYlNwNXJNeDFTam9EenEwVUVNZnRVT3gzdnZC?=
 =?utf-8?B?Mi92cDhudEs2eFNDQmdKWmdwRkdQT0dDSTlldDlSaDBHc3pHZFhVN1dFM3J3?=
 =?utf-8?B?OXFpU2xmVjJKQWkrdzVHTDBlczI5ZTNLY3BnRXhOL1M2VTZxRmp1NkVUckVz?=
 =?utf-8?B?UENEbkJJQ0hjUHd4TEVLZkpPNVJYRTd4eFRwSFZseWN1aEozMkN4Q2lxK3hV?=
 =?utf-8?B?MDgyTFp6aEJ4U1RZWkV1K2ttQTcwWGZWRndOZkdWVW10cXM4NURLcEo5a1Jj?=
 =?utf-8?B?dmwzY2JqckhNem1oSVNVbHY5RHpJSC9VenFEL1FhMERYNllDRUFHcWVGcDI2?=
 =?utf-8?B?U0xVRmhYL1RTM05TblVGTUcyZnFvdEhUTkk1a2lpaHFWV3JMc1paMlJUbkNL?=
 =?utf-8?B?bHNHM3NiZmhwY0U4d0hZN25LVEFXVEZ3RlBONXo2RzlyRWhjcWtkN1ZmbXNE?=
 =?utf-8?B?V1l5dTdUb1JnT2xmWlV5Q0NXWE1RTDJTY2NFSDRaSDYzYmxvWjdhV0lPQVZw?=
 =?utf-8?B?OFphaWdkNzY5dXdtUmpSUXFodGlndXovd1pZejFqZnE0bjQ2QWEvOUI0Z1li?=
 =?utf-8?B?cTZHeHQwUUNSVzhieTB6TDllSk9HZEl3Q1pLeVFmdWZTVGRRWVZFYVNxRGcv?=
 =?utf-8?B?ck5UV2owVHpFS2RTWWRFcEUrb2Y5SWJNUTMxV3JQcVhBSXk1MEtsQ29Sc3FU?=
 =?utf-8?B?RkE5dnNBT0dxNDJvUTIwNXJubWJ2RVhpWWJGVEJBL1JuTWNxMlJxZWhHT0Za?=
 =?utf-8?B?TUxBWUJjT1RzYU4zMzJpNzhHNzFEZktZWWVseW5nSEhxV2VYYmhCQzlkQzg5?=
 =?utf-8?B?b3ZybTlmZStDWDhhV0xSc0p5b3dCNlNrb1NtVTFZY2JZNXV5bURWSUFjVE9a?=
 =?utf-8?B?a29YdDFpdzVOWGJxQ3lKWDBnbElZUG1XcExGaXczcVFybGovVUNzblQzQVRh?=
 =?utf-8?B?a1Q0UEExdkJnL3g2bkN6cTNPNXJXNm5naVVKN28wc0ZRZUVDbkJPbE8wVkt4?=
 =?utf-8?B?YzJqTkZncUQvelFBM3NNMU53WTlRYnhqL0YxdFpHd3gzcFdTSzhSTmZZVCt5?=
 =?utf-8?B?YUszcG95UHFKRWFBQ2dmTEtLYnhiWnZXNHZ5VDI5Njg5aURnN3pIOU1FTmND?=
 =?utf-8?B?dEZKSW5NRVE0Uk52Z3VaOWovbDlzWThtVENvVmhKZVN0MEtRMVB2Wmh4RHcx?=
 =?utf-8?B?cUFlRVVrdkt2Nkt4QTF0M3FwWC95cVZKU3ZmTlhpdG1RVW1aYmc2R0tJVld5?=
 =?utf-8?B?amtZOHJJRklKR3pqbkFMNWJtM056T25jZ1ZoQWtiRmNVWkMzSnNtaENlVE9k?=
 =?utf-8?B?WVgrS1I3L3BoQ2FwUnNBQTJMeko2Rk1pU3Nyakk1THNwVHcwWkkrWjJocFBk?=
 =?utf-8?B?UjlMdEwxdHV5Nkp4MmVMdkZLaERJSThFNWVISGJ3bDhDcmpCRTNKSk5RaDBv?=
 =?utf-8?B?Qkp1ak9OWXE0a256L3czYkduak1PRFJRVDdIY1hjRHlxN0RBZS80Rm4yM0hX?=
 =?utf-8?B?SkRvUU8wUEJ4SUpnbXNPTUpYeHRGZFNUL0xNaitGU09tRlhlN0N0Q2hIQWNk?=
 =?utf-8?B?bkVrc2l1MDVnZTJwKzgwSEpoSTkzdGl1OGVleE1nNmRwbFFMZTQyNUVPb05G?=
 =?utf-8?B?RWo0NU43b0FOcXl6SXkvN3JoRmE0LzdMbFZ5MFB4UEpMSTFXMXdWUWZEeG1y?=
 =?utf-8?B?bFczNWxDTlBLYjZKdHBvV3NzckpxTjJhWGFnS01OeEg5UGVvTFExblpNN29Q?=
 =?utf-8?B?VlcvaE5idFVoNGVFbGZ5czh4b2RlWkRnM09yZ0ZZaTVjM2M4SDVYbVEyUU1P?=
 =?utf-8?B?Z1d5YnR4ZERGTlp1c2cvaTVRTy85L0lhZjBWVlF3UkYvSk9xVUdCWGJ2Vm1j?=
 =?utf-8?B?ODl1a0p2RWhPUnF5QTZBMHhNN3VmVGNML0w3OUI4M2lkelA1V1dFUFptMEtU?=
 =?utf-8?B?aVBhekJzMDdUSXNLS3pGSXE3SklNanJNRVR3N0NIQVZ0MVZHUkhxaHdUbFJF?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF9C6040C98C364781F9694EC8A9ECA6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NVYgIzDt0selXtiXha3Iv6Mq/H99Ue4BZ2I1Iw7FP7dm0LgQDqESmSaGqhdzJE5RdLtzcviJ9BxUS6orRhkO590wDAE+zT5CKml+rxBcBWcDdovmVHlDZlEWyTNe6mtFOFWjxIC90Elo4g0Scwe+mV3GHZz2EjZq6jNOREb5KXXIBtlLhCpuT8a4y700OYOfSSZWStVSrAOBsdRoLJ/2imc5jpv4MZcdJqDEIXoqASduM19YUfelmC/xOXERKuHZzKowJG3/HXa8p4FaYv12QBEtt14x/PUuyohG2oJSHV0Gx+msblWqPX1rZQfAgAqnODYzSCj6ZuUeVBpr8c6SwVUmup8kGuCHzhYI2AmK9a5WAl7fTgbcSEaTwvWAq4KuQbZeIN8X3lKBeZcf8fj/pGmGnR0HYW8ZDM8DVFAGiFaM/cUdJwu+04/ti5/8O6CjCoUcKGBDq3Q/76IMwTJrXghD2cFqxGODEEVtKu326gTNVABl6dk5VwooFDHp4ubdTsNLjjgyEMS/1h0RaE7HkW77pO7Wd7jljTE/NL+t/WpnU8MnsNYR1w9rr6+brmL1DuwINUcSPt/nr8zfDcsnmVe6SS9juCPWUER7G7fBG6g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f89655-0be7-40d7-3392-08dc0fd4fc0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2024 23:04:21.5340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 21fruRSFxXs1VyNthaFXFejr7p5IF2hzInpsvYY4vMlx+1MteYGi7uLHMJ8lTNP1/EloR0U1gAsUSIsKjrgzCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4237
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-07_13,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401070098
X-Proofpoint-ORIG-GUID: m1EBh7eqzvvl_JOzQSAfxV_s0zjJVGua
X-Proofpoint-GUID: m1EBh7eqzvvl_JOzQSAfxV_s0zjJVGua

DQoNCj4gT24gSmFuIDcsIDIwMjQsIGF0IDQ6MTnigK9QTSwgU3RlcGhlbiBSb3Rod2VsbCA8c2Zy
QGNhbmIuYXV1Zy5vcmcuYXU+IHdyb3RlOg0KPiANCj4gSGkgYWxsLA0KPiANCj4gVGhlIGZvbGxv
d2luZyBjb21taXQgaXMgYWxzbyBpbiBMaW51cyBUb3J2YWxkcycgdHJlZSBhcyBhIGRpZmZlcmVu
dCBjb21taXQNCj4gKGJ1dCB0aGUgc2FtZSBwYXRjaCk6DQo+IA0KPiAgNzZkMjk2YTgyNjU3ICgi
bmZzZDogZHJvcCB0aGUgbmZzZF9wdXQgaGVscGVyIikNCj4gDQo+IFRoaXMgaXMgY29tbWl0DQo+
IA0KPiAgNjRlNjMwNDE2OWYxICgibmZzZDogZHJvcCB0aGUgbmZzZF9wdXQgaGVscGVyIikNCj4g
DQo+IGluIExpbnVzJyB0cmVlLg0KDQpBcHBhcmVudGx5IG15IHRvb2wgY2hhaW4gInRvdWNoZWQi
IHRoYXQgY29tbWl0IGFmdGVyIEkgcHVzaGVkDQppdCB0byBuZnNkLWZpeGVzIGJ1dCBiZWZvcmUg
SSBjcmVhdGVkIHRoZSBuZnNkLTYuNy0zIHRhZy4gVGhlDQpvbmx5IGRpZmZlcmVuY2UgSSBzZWUg
YmV0d2VlbiB0aG9zZSB0d28gY29tbWl0cyBpcyB0aGUgY29tbWl0dGVyDQpkYXRlLCBhbmQgaW4g
bXkgcHVibGljIGdpdCByZXBvLCBnaXQgY2xhaW1zIDc2ZDI5NmE4MjY1NyBpcyBub3QNCm9uIGFu
eSBicmFuY2guDQoNCkkndmUgcmVzZXQgdGhlIHB1YmxpYyBuZnNkLWZpeGVzIGJyYW5jaCB0byBw
b2ludCB0byB2Ni43Lg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

