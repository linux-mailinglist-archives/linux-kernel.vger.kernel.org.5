Return-Path: <linux-kernel+bounces-16609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCA982410E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C891F211B9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD992137C;
	Thu,  4 Jan 2024 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cBOfh/cS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hQnDYuAK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8CC21357;
	Thu,  4 Jan 2024 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403MLbBd028160;
	Thu, 4 Jan 2024 11:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kS1ZYg2wKDQv2AHhhEX9EzmBVXnyUL0RJaE/lJeMxxs=;
 b=cBOfh/cSr0FnMA4JFVYc2/u962L6FxLF2fwZTgnsDYHrWP1EGmoRiRs1EJAzHnivsQkn
 /ONzWt94YiFxgmpL5wcIURHTu3rBgfpNsljm8b4jtoDp0diuZ/rL4HO4mo2vVd16Wlyr
 HvB5fHpIhPvMZLG7w5R0HdZD3Zfp5OzoQQ84jRxOZ0vKFTWsZr4QUmyKNCxIGjBBprVb
 q2xRchvqQAfeHv0BXhV6Xl24PoKUHr/bgGvvRszKc6IxePzf0h+NBXbCmoJALx4aC3wJ
 vvRHsiV5QlC2u2HphbthiJtIwYwKb2+4f1rLsHz6he/2rUGtbUbyYFX8ZlXhbTdQT2d5 TQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vab8d6yjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 11:55:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 404BsTZo006042;
	Thu, 4 Jan 2024 11:55:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdv5xr59n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 11:55:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9nCm28AZFHgVw7yEFroAq90pgsjCK5d1u4SlgcptLwkG8Gt+DYEQQf4gc9Mf469K0b5XcJTZpM1nlMqhR7p9B/FR6RPuDkXlqaWo4izaF5wqJdpJDHW46mUdmbiIOi33gDlT5RNrvuEUsKtdsfPeJ5dmnaeqrY2k5EWSPMaYhsM9YirzJF/kzOiuNgVOB7duh8JvleYXj6yHhvyb4EXxW9L2zEuStPP7NlaIJgd7/h7zvQL6okK9dNey59o+9FihZYUuXfdCUIfjR22askB6HduKEOQyTpbv8jk7sAcCts+gb/NJoiF16zUdN7GBYK8qqI+CHf5dFZ5fQpSO5rWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS1ZYg2wKDQv2AHhhEX9EzmBVXnyUL0RJaE/lJeMxxs=;
 b=B6WVnzpJqXQLv0qe/LVGyiYCI7D7BD3rXgJrwjBOGxkwy0yHf21pwzfsX1Gq53SwKDjRBIR5cR+elXrtBKSvWJ9yljvV4mU+Df/x0PcKWUoOHtOKcOWUA1MKBZpKqxhBi0vMIkqHtzhq3Gr68elTYnGmafFViZOlTHld1jL0MDOVtCMuPnm2A+nkdCAs+70LyWsvDbFSac+Kx51bEBnOAOhe3us5dqaLF/uhffUo1NI84QbmdBMl6nNOuXO4d65qrqm9NMjLHQ+lDBNcd9p/qdpvW4O6kg0ao+Gwt7MOz9aR+ntMd01elRtpICadxJRaCF1dMg4PPK4WeUj/2IAamA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS1ZYg2wKDQv2AHhhEX9EzmBVXnyUL0RJaE/lJeMxxs=;
 b=hQnDYuAKLVevMlc3H/C6//ccyqTSJB7TwQUKnlOlXlfDUPXt0qZydYSJj2Wgwt4X8CNVza7L4NQp6GSA0HHUC02hf4DqEucW6F4F/i+Mz+2gC6JHYjZFEjEDl8llUuD67uBJHE/2s5qIRQiOTHGwF7do9Sq+O3msyJJqjJZZJaU=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BLAPR10MB5027.namprd10.prod.outlook.com (2603:10b6:208:333::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 11:54:50 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 11:54:50 +0000
Message-ID: <0d1834f5-f8ff-46a3-84e2-798a6a7d3ffc@oracle.com>
Date: Thu, 4 Jan 2024 17:24:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/95] 5.15.146-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240103164853.921194838@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240103164853.921194838@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0233.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::19) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BLAPR10MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: d7233719-35fa-41cc-9326-08dc0d1bf4be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ef8FEDEe6s2oQXg9cSRAFX3jtNIhYWwhKbMcFPtg24SfCQrCoT00sPgsl/KqtelADFOUBklb3JuJqqBmPNT2gBxzrAVkcUtT0UjKYPJRlRHXhb3fbvK4Y1gJoabX+0pvOO6P34dMHn8+7Ug0jZTpXeAm1LcMJmZnBJ4O8arPxhrkakOf6vgY8C0ynVUPkeFPOr9y5iqntteoiDgirtyRRHbnnXg9mb1J0p1JeGUgtiZ+Ssq3yolKqmxDi1KDUS1aErkT5NP16JTnU3s+lSkn5oAouQ8nByqNnt6DS2wOeT7Uynjeev8rIjcits/a0Eu+f2i6DJxqTC1lq2ACSbNnMjmuK2PqFJBEQXgvTJbC87zX3XTgwq12Igu6Y1GunL7/5O6X6PutV0VFho6WMD+RCYvmMFvdFUGlgVK/kPeoFInn/KKaIzFab1okD43G1Qu7ju5zK1OLEy9xn/gxXZnXEAb6MCvd4g7YxuPQI6CGy25G3OPjtuYjYjwADOQ+jhdtaRFbeK5csZvoxO1llIa8TlwgSjimhMGYVfvVqJHB6r4bRYNtSYywnZQOCncaUTY69sj2hf8bDEZvw/3xKHiT168v9AIzdYSSn6wcoQRVAs322SElaqcgol3tvG4S1gxXPQZTblP8LQilh9PFgilFEw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(2906002)(86362001)(6486002)(316002)(8676002)(54906003)(4326008)(8936002)(4744005)(5660300002)(7416002)(107886003)(66476007)(66556008)(66946007)(41300700001)(2616005)(26005)(6666004)(478600001)(966005)(31696002)(6506007)(6512007)(53546011)(36756003)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bXhDNVVUenVVRjQ5VWpMbDZGa25PRm9tTVRHbW5PY3E1Vis5Y1NSRnlVd05Q?=
 =?utf-8?B?aEVPR1BrRUlRWWQ4UmRHRXVVblhoWlZuL3lPWXg2TFpkeW5JZFg0UWxra3pL?=
 =?utf-8?B?c2dpRXNPSVdJRFlKSVhnSFRGa2ViRFBmc0FNZG5HNTVTYzFpeHRzWmpqeEFy?=
 =?utf-8?B?bGRKejlFd0tjNDIyQksreFNSMzBZdEpxV05JeGNBMFY2UWVkN3NMRGVIUVc3?=
 =?utf-8?B?WHRSUXJueHRQYVU5ZzhYb0ZneDRzcXhHT0RzL3NoVnlrMWF3QTJCM1I5elJM?=
 =?utf-8?B?akNNTnp1OXZhYzlYQTFENXZiTlZES0hEOEs1Vmk2Nit5UXJxUUVvL0R5OG4w?=
 =?utf-8?B?L09UMmxVeEo2YWg5akhuRG5uMDZrd2tMT0ptcEtZT3JkcURIRHZxdyt1TFFJ?=
 =?utf-8?B?K0NXWlJFSDczWE1yVFdxb1RVMjc5UFBHUm5ieUZDSk5ZNk5YM3dLNlY2YWEy?=
 =?utf-8?B?T1UzWjhZUkVoMXpoNUh0WUR0WUhvRmxIYWxQSUJxNkZxZGMvdERLRGxIVWNM?=
 =?utf-8?B?SUY5MzNlSDJ1R3FtNkNRSEFVYVRBN055aCtBWTBObmg1K2VTRDRjcjBISnph?=
 =?utf-8?B?TFF6cWNQZ25tbEYrendmV3hMM1Z0RUxJcTVyQUo5M3llMVE4YXhNVWRGdXVv?=
 =?utf-8?B?OFJHK0M4TCsxbE0xTDdiK2daOXVnVitzYUJBby92TEZxeGlOUkRFZzZsdTBL?=
 =?utf-8?B?TFFpcXY5SENTWG9ZSUxseW0vYlY3K2FUbFdIbVFlV0E3NUtJTVhPUFNTS1FS?=
 =?utf-8?B?L1lFNHF2L2FiOEhVRUFTOTNwQmRnZ2ZPZVV2QU12RFdycTlVdVJmM3lpeXQ3?=
 =?utf-8?B?MWtUT3Mwc3hGc3MxYWRXVm1KU0FyVUFlNnBwWHpad1ZyNkdyNmZRMWxjd1ZE?=
 =?utf-8?B?VzlIZk5HYmJmTXdhUGlveWc2MnVoVS9ZWVdYMEU2Z0gzRE92OVBIKys2SGZL?=
 =?utf-8?B?blZIbjA2MXJDMWpEK3dnTTU1RVlUakFFL043MXE4SDVuWUZ3Tkxtek9LNDkr?=
 =?utf-8?B?MEpKVVVrV210NmROS3QyVFllT0NlMHJxQ081azgrV3VwN0dJQ24rT2ZuRHhV?=
 =?utf-8?B?a0w3M1FGWGFDWGlNYVdCaWJvT0Y4dUsxYVRjcWJyRkoxV3dwaExBMi9EMW5K?=
 =?utf-8?B?N0FxcG0vVHBrZCtlbjRGeXlERml3YlFUZGlHaDNmaEsrR0huOHN6RzU2MHVQ?=
 =?utf-8?B?Q0xVem5iQWFHYVRYVG90QXo1T0R5RW5YVWZKSndJZ2YrRnpMN2NzMndaT21w?=
 =?utf-8?B?MmxmMnUvTFllVC9KT093MW8vcUVpVG9uUVdWWnFCOHNRRGxjbWpaS29jVjB3?=
 =?utf-8?B?OEc5blpTWUljT2oyVUE0V0xraExRc1NnSHdwSmdPQ3NTL0VJeERlMW5rMnV4?=
 =?utf-8?B?VFMyMXJkWVRKSWdqaGNMTEpKQmxtQ0Z3VEtWTTJneCt3NTVQcHl2czBzYjgz?=
 =?utf-8?B?ZGt0cEw0bHU5bVJ3ZXAwNTlmdFl3U2pFQk5EQ21KL2hlUU84M24vMUJCNElM?=
 =?utf-8?B?NFVFK3U5cUVOZUV0bTFRdlBMdmNuajZQQzJaTk1VVzAycTVWb1g5NVlxV1dq?=
 =?utf-8?B?SVkyNWZ3bm9wZWkzV2xrRko1WmZVUTNLaE14cVRacWlDSGErYitIQTlkN1Yv?=
 =?utf-8?B?YlBpZzhBSnJVeC82cWJHOXp4T1NBTTZLVlFFVC9adVkrWUdKOWczVCtMWnFO?=
 =?utf-8?B?OVZLSW9MM1pMTUs2bEtTUnpDWU55ZmswRktXaWxZSWpRYXBDRHJQQjBnamM4?=
 =?utf-8?B?SWxrUFhCZkdURTBhelNJVlJlaHM5Y0E4QnNZRk9lM2pQN3ZaYnRQYjBoRmhR?=
 =?utf-8?B?Zm5nMFZ3ZHg0QUpFTnQzTmg0eDg0OTFPRmtOaFpUaTkyY3ovank4MW5yMjRp?=
 =?utf-8?B?SFQwNFRDTkJhZEN3Y0FtRHpOUlpOQUJsL24vaTQ3cEYrNXJOTTFNRXY4QUFJ?=
 =?utf-8?B?VW4yYVZ3OEd2VkZVMllrVEFGNUNkOWhHMHZ1eko2RXdvUk91NG1qR2JDck9H?=
 =?utf-8?B?UjUzbHNqTTh0UEl0MFVRQVd2YVhUcC9sNWJ2Q2xsUmxpd0NWM0NEOGs3ZXpv?=
 =?utf-8?B?Rytib3B6QkZ2K1NnUW9vWlk3U21uQzRta2hGTVNJVFZkZ2hTckxDbWw2a1lG?=
 =?utf-8?B?TXlOcm9TS3I2amFYRStJZkdTem93L2JTOGcwbkovZHF0d1VrbldFVjVlNzRa?=
 =?utf-8?Q?VF6njm2Vw5eCo7Huwy5bMN0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	guWb9tBDJw2etZmsF08bMh/prsukrndDdzx8D8zkyoANnRSRACTQinIlTvQSpXAqg4DlveRUwTn+TpIcLl/kEQUOojpqpu0mmmUCzGbUJ3LvSYzu0Q48YleBaPfrZK4yKgy+SXU4snansCs264tBMpfaXGudUuQTuXjyPozSDzpcdjCzznnRc2XeeaSMJgwtPicmC9RzKqi1UAW2uhAaM8cEauTXaWzWGrq3bXciV6o5DbtynCbJWr5BKG0VfqNnCqtN/qO292QKBYTphtD/GZKhOT3g0MvzZBXjYRAyMbd0URSt3/4xGTP7LzshPY7Oe2KXU9sFdrTltT5UdIp4NluNpQx3gLoA/CKv8Mcc1EnvuiXJGRmS7lexlvQ/3b4UiNadvgGge3Gt6rSuZ4Xf5CcPvZ8npIfkKjy1XvysEvfQA0i0DVagKyCDUZewgkiavdCJOy2ln0y6SOBMEadkrKalbsuj69U3g9uiCOAKo2Q1r+y9WODkLTq/g3pDnPnSqj/O4/aGzcHfTLFR4Iet2Kbwv81OVQ5jfPfHd8sVSyCFbcvgjSMdqWcfgefAuAv67U2FJPBPTJzc9qP7yVNGWkmV7v5yYV4deib2Awl/1n8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7233719-35fa-41cc-9326-08dc0d1bf4be
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 11:54:50.3459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoE0x8OyIbI2c49S4qUjBLboamveZCUZq3CISy6GQg9LF9H1ffSdHkkvH8THTPUIVSKmNqY10GpbH9IduDOSddWacHlo4PGBELSbfhFGb4xOb/cVCTVRBUEvOU/KDHxh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5027
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_07,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040092
X-Proofpoint-GUID: d6QRAIdsJHbL5podsEfNv5gLElw2228H
X-Proofpoint-ORIG-GUID: d6QRAIdsJHbL5podsEfNv5gLElw2228H

Hi Greg,

On 03/01/24 10:24 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.146 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
> 
No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.146-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

