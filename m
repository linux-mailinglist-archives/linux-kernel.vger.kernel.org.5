Return-Path: <linux-kernel+bounces-17097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B461824835
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E17287F2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7D428E18;
	Thu,  4 Jan 2024 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X5Yz/CEa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P/ifHnbd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7A22C698;
	Thu,  4 Jan 2024 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404IRlHE019765;
	Thu, 4 Jan 2024 18:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=GCyeH3oKV60nUefw/zn3v1yCB0KY3dw3YAg7rbEALvI=;
 b=X5Yz/CEaM8L+dljwNM8GfB+ax16L/FZefwS6/VgC1XlLblKRgFz9zmPUqHZ2COmqF4Yt
 ul3cfKTMszD4j7KXHPr5gmYzgrbbMZ85byzywZy5505PRmvK/icBptu6KorxdgNX3OeP
 x1iem86be8bEyXlUwpj84YhLnNBCIvTRkt2FNO42XYkGvo3V5kVku3QDJvAbM3UUTJ79
 4DOnzRAS7MKK3Ar9fE/zb+Jsg8Z3UA06PNhKapxUZpRgtRSlEPHSoHdMRauFJdoBf8c6
 Lhg6LBKkHua1bGAwXgTKJc9h/v2srzKR84aFQ7uuoyRp7bKDNUYjC7ngyzKaMS240Ol3 Bg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ve1yfr0a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 18:31:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 404I8ItB016006;
	Thu, 4 Jan 2024 18:31:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vdx1jsuv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 18:31:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uxfj+JTxIc0Nm/z3+ZwY+q7dq6KkTlqeMnmjCdUqqT3oVh5PXU6rAMA3c4BajkI4vRlAM9qtIhVOe9n9GN0LTK666zZ5XjzPuS6dY5VX8c0tUeND2zF09iTeBPUo78wqrSbENKmeM07qFQkX4is5m6V88BHynClA145wMne1T3h7aOGi687gmrTJvp9QttsyucP3ZNRm7FSHbZtrGP7Qdhfh6xXrVICw1L3THnpxXJyDugUT0jMyzjg1YBD4oPyK/WXG1ZQlm+Bdtq9iaGGJDRpGGLld8XuShwv5CNiCq0ruJJ36Wa1HGwWkhDTnVN6yKwQR0lI0AVDQyonKqb4MdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCyeH3oKV60nUefw/zn3v1yCB0KY3dw3YAg7rbEALvI=;
 b=GYp/Jc2iWjjqw7rZRDbQLIZ+aWMgTS0zh8SUso5iUArQmprnPwffTMttMfw1ljg0RiB7WCIxdzfef8qjHoQ21A3D1ThBh65h5Ai9Lj2cpbTcKnctCd0aGMF64S1gI+56mOHQrnuLqRhqmZM0OFqLCuVSzwaLjuwbtkymPkvhj8rrl/pKL/vjxNXIyfbn/A2Vjoh1cjqIPwlRMQvRNZFd2LSoBgma0lJHENMW1EF/GnPf/VP2G/Vzw54lvcGbnrEeii/YIxaX5FZ5BYpPXoy+iJU4JQmz/nqXPiwSmEqRTy1u1jzWI2EY7MdtplVxY4R+FIrMkK1b5/sKT5qucfp/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCyeH3oKV60nUefw/zn3v1yCB0KY3dw3YAg7rbEALvI=;
 b=P/ifHnbdQjvRa70PMT7VVN28tsz5GB5mIOh3KL+MxXwrbJOaYYV3eYCmlgxAKcoDELPeHg9l2YYA7GwMs18SQutQpd/IkPJDig3tADQI1qflVVi3hCu79T/Yhk+0GFW6cyM6v9iolp6dGnck4CxqvpCwLRMPi1UxROrJkaHpNhY=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by BY5PR10MB4194.namprd10.prod.outlook.com (2603:10b6:a03:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 18:31:35 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 18:31:35 +0000
Message-ID: <c42282c1-238b-4e35-bdac-1eb8260fe351@oracle.com>
Date: Thu, 4 Jan 2024 19:31:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] VMCI: Silence memcpy() run-time false positive
 warning
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: linux-hardening@vger.kernel.org, keescook@chromium.org,
        gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com, syzkaller <syzkaller@googlegroups.com>
References: <20240101130828.3666251-1-harshit.m.mogalapalli@oracle.com>
 <2024010103-connector-plausibly-bc35@gregkh>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <2024010103-connector-plausibly-bc35@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0110.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cf::16) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|BY5PR10MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: 138385e1-e7b9-48fd-1b33-08dc0d53618e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EqOTbUbUnH73elEAzHKGAUV8aaKCTOU3nyAqJYQF4EdT72p8SlmHtWpgG1ogmH1m9EyDFPu2Mcn6m8HICQoAUK09HrwVHFEV0eKB7IdBkhHHqYI86Og4gU7QrvIGyv2Pl6p74qNvjKnK2k2S+w7hmIgdSxoOjOylXceuB1CeVVCsKLZsR1VmbMa/Bw4gYF5J7BIKi9Ztf5WnOUCX+2ab8lwkvaauuk5Z9YcBNGcA0FwCKmnnYCzuwr0hqBYGV+HKhwj189eCjBBIaS7jAnQplC4GTmXPO87GTmmIE4PaJ5Kef4qOmQrHCgmToFQLaKSq8aRhSn2Q0yIdoZJ1y19hnfwAeu5PjswjcEczuGFYbs+CMI/v4g9A10nAKGr/yUDENfgES4FaVFet9ackLm+p5dgAOd/jJLOuPLS4zqUS+7JIQDa65xDXlzJ/ma9bJQrCrUjkx99ITl/hxzJ3aXV991bfN6jid9wzzMFlJxC8tiSyMK2f+6vKlta/PjpaYJvy+pvjdzVsPuBmnZJXyjxm7FKE6zLVlQyeAIYocs2D0C/ZhEIq+NnBlqn8FSlDA6XrbWuotQZA1opbgHbk6J+SflZNDRG+RrfPlDCZ3P3GSzETo6lA61ERjFHR5EDW/D3lxAmzojIJjf+auQwaXAo0gemHWL4PAmmbYoKNMQjbP5pWMaoxOzeTqGQSlextKgSH
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(31686004)(53546011)(2616005)(6512007)(6506007)(6666004)(478600001)(6486002)(26005)(36756003)(86362001)(38100700002)(31696002)(2906002)(5660300002)(41300700001)(7416002)(83380400001)(110136005)(44832011)(8936002)(66946007)(66556008)(66476007)(6636002)(316002)(54906003)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NG1nRUkxcWxEd3VKRnZhK1dwUDFRMDY3akt5ck1nUWlXVkJCLzRZVFdQYmNt?=
 =?utf-8?B?alZwRXBQYTN5VFBVazZTTFNUZDJPTWlKM1E2aVliSkZYL1lVaE9lenQ5S1VN?=
 =?utf-8?B?WFcrTC8rVXV1UnZSajVUTk9IN0NUOW9OdDlxSmhZb01NM3ZVMENqb1dSWFJ1?=
 =?utf-8?B?YVJZaHJDN1I4OVgxZWlVSFhiZjVSSThJZjlubnoyRVhMVG9FVEwwNlR5d3hL?=
 =?utf-8?B?OTBCVjN0OVZhMlZCSTEzdDQ0dU5uaElKZ251YWFrRGlVb0d6YVRPenpYUVNi?=
 =?utf-8?B?aHMvck5icFVDZm83cHpDUDBUd0duNm03WGhRUW9YRHVKTmV4TnhUVWlpUy9L?=
 =?utf-8?B?VUJZVGtrd1R5UkF6M3NiNHBkVTMvaWpKaUJlYzVPKy9RVzRUUU82ckJBMDVi?=
 =?utf-8?B?cnFiZU1Ua2lCOEhRNkNIamV3eG9FVzQxa21TaU5BaUN3azNHaS9LemlBMFhn?=
 =?utf-8?B?bndVZHBNVjdvWXUwYkJXM0dBc1pvck9rTEdLZmN6ZHRvbG9PQmNsaTZaSVZu?=
 =?utf-8?B?cVFxYnJ6ZmEzT0tPZ0hlaDJaRWduWFRVdHZUOXZhVndLckUzS1ByZ1FaZGQx?=
 =?utf-8?B?OHNUWm9UQll6U0luNTlrYzYzYmhhNEZFcGsyZ2NQNVNPL0RCTXZqQnlFTkND?=
 =?utf-8?B?NFY0RWo0Wnk3RWlaTk5BeDZDTkpwWFBSY0hzUUZTWmpOWGNHQ3ozbFZwZXRk?=
 =?utf-8?B?MWJNaGdxQTRSMCtOcFJoaU4zajd5NFVET3VYdE1GYmRnaVd2NS9CczdCQjhM?=
 =?utf-8?B?TE9OOSs4a3ZUdXdoTmsraE1VQko5dXVKOVJnczVKOTd4TnFVVmoram43c05n?=
 =?utf-8?B?bUhKczJ0MndCVDRHMmtGWkJ3U2FHNm55aGVqNDdXN1JheXdzSDc4bmo3dzZX?=
 =?utf-8?B?d0NvdnVkMk94Nk10bWlUZzVuRXd2aDJXakdlOGFCU0JGY0RYaVhtZ2t3eExw?=
 =?utf-8?B?ZW5SOFByTmlNL213QUwvUGt0bllSZTN2bVowbEYvV0pqR2FmL21TbCs0Tjhm?=
 =?utf-8?B?aUJoZGRSS0tVelB6WmVOZjZtRFJkVytRYm5ROXBjU25ZUUdYNGl1YTlYMVZD?=
 =?utf-8?B?cW83MnFuaHNuNlkzRGt1d3orcTBoUVdiMHQ3cHpwMWFiUVh1bWJtRzVJcHFj?=
 =?utf-8?B?Tkx4VnJvTWxyWGFzUm90N2JzaVp6YVVtRTYwUWZWUC95M0Nvb2daaXNDYnpx?=
 =?utf-8?B?YzJ2dTdIaFBsTXdyVGZOTUE3NWRkaDVNdVZZemVldFdwNm5vN3VZV0NGbVM1?=
 =?utf-8?B?R1h6YzdMQmJJcXNBOTVXK01BRXhWY1dZUmoycDNzckJlOG80enV2dzBDc3Zr?=
 =?utf-8?B?V1p4cHdzTUV4SEN2SzlUMXpWbHdkYUZqeXorT3A2MlBkNEhRcU9QWC9oeDVC?=
 =?utf-8?B?b053VU9aMHZsSGF6Q1lQOVRsZmRwVkNmam5YcDdWQUlGT05rMHdyTzl6THBs?=
 =?utf-8?B?ZGFWTjlRT21kbVp0b0Nac2NlaFhrdk5SRmpkWTRmK3ZLVXRjRlRXOXhPb0RW?=
 =?utf-8?B?eDB2d0J1MUxQWXZKaklOWERKYlVYSjk3UmhORmhxenIvZzRLejBlMDJvRW1X?=
 =?utf-8?B?THc0U1E1TEt0Ky8wM2JaT1pvbTd2ejFvYmQyN2N4aVFvT2g5bjZUR0t2SGFs?=
 =?utf-8?B?UTlmRkhWSDRmaGpaWExQOGlsdnRwbEUyZUdvejBNNmNLdmMyL0FLaU01b2pG?=
 =?utf-8?B?MWJXekk3Z0l3N3Qyd3BnLzlFblo3clVLazhaRUVKWXNrbk1kUkZrWnVWNkdY?=
 =?utf-8?B?V25NbDd1UHlNUldhRGVPUWh0djRpSFRBNmY0SUlLUkdVb1RlMFNMckszYjdC?=
 =?utf-8?B?M1RkR2d2UEF3ZUlicXl1R0NLeTJnTFFLLys3QnBwRHVqbm1TRkpWRHhLYUdU?=
 =?utf-8?B?TkIrUlFjTWpzN3lIdXBMQXZTTFZWdktaMVhDM3M1RkFSbmhoOVlpUUVqSEow?=
 =?utf-8?B?eEkxRHVFcEhxT0d5RDdjOTZWTmRCVmJvRmhjeUQvYzFUdkNiNzAwU0p5WGlv?=
 =?utf-8?B?VDZ6T3ovMHpOZVoySEVuNFdtZFA4YU5qRHREdVBtVXdSeXYxNlgxVFhIWVpV?=
 =?utf-8?B?a0ZqVlNkUHdrckJ0ZkN0NmdYNjhEVHppL1VGYXFNYXlwV3ppSlhQM1VQRFBq?=
 =?utf-8?B?dGFoWXVOU3h2d1dYaVlZcEtlVEM1Y2MraXIwZEd2ZHJSTzkxSk1nOGNLTWNZ?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TK0KroSEf5mywcXILPB/xd+1wbBADqP5r0f9eaaBdrYa75uZLc6VFSQWsGvN0lrmxqvt4i4IPNxmJf99qg9kVrzePu69eR0NW845W/JgO8SD43kjFvsFuwJEhSS1CKUWJ66QMfrrw+3jI32WDhRqRNCllStfO2Y+GjMYJXWNomkEzStAu5+EjsRNY1SPebT3l6M1YW7NMhwYFaaAtgNixGgTrr9Rf0lav0Q2HAY6eTB9DEw0Z0X1dcoL5//c4PTX0wlQv01ygO6ItpG0r2ApMuGwaMnY8Nue/4QeU0IThkvMgQz3M56NoTzqwBo2YPuCIl4ZARbiYU3k3rwgbvD8vusAChNEnbPRHK6fB+8regmHsmlDgCqMf7TdpRvcch5KVf21oLIKnPPVX/85sY6rSK+85Xw7tDUHw6eqvkD+MVjUTUjUsOEx7vvaAoTwO0CO4EBBKiqYh6Z6WYcm+dOfy1GQgUkhK8Ss/k0c/tWrs9EyRVMvbN8IUteTq8r5eOSBSvUhRWr3qxZFfHVOfuZa3gJJQs9YJ25HRhU5Jw24/B3LBWY4yV+DjLK7xaWVait/pXBaY/ME2I8rWz6E4R46O3Jmj/UGRigaSaJeFCBcsvQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138385e1-e7b9-48fd-1b33-08dc0d53618e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 18:31:35.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDDfMlan6fRSx411EgYCS0EMIhVDSngsnMlhnGC75FXKUedQ3twbt8ajMe7aEkZObQUl4oHmvwSmy34Iho+b6r1ZiBivPSKT0GY6bmoefH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4194
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=958
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040144
X-Proofpoint-GUID: QaPSYjiv4jmzIqVmjosYQSaQo9FOqK8h
X-Proofpoint-ORIG-GUID: QaPSYjiv4jmzIqVmjosYQSaQo9FOqK8h


On 01/01/2024 14:55, Greg Kroah-Hartman wrote:
> On Mon, Jan 01, 2024 at 05:08:28AM -0800, Harshit Mogalapalli wrote:
>> One possible way to silence the warning is to split the memcpy() into
>> two parts -- one -- copying the msg and second taking care of payload.
> 
> And what are the performance impacts of this?

I did a disasssembly diff for the version of the patch that uses
dg->payload_size directly in the second memcpy and I get this as the
only change:

@@ -419,11 +419,16 @@
         mov    %rax,%rbx
         test   %rax,%rax
         je
+       mov    0x0(%rbp),%rdx
         mov    %r14,(%rax)
-       mov    %r13,%rdx
-       mov    %rbp,%rsi
-       lea    0x30(%rax),%rdi
+       lea    0x18(%rbp),%rsi
+       lea    0x48(%rax),%rdi
         movb   $0x1,0x28(%rax)
+       mov    %rdx,0x30(%rax)
+       mov    0x8(%rbp),%rdx
+       mov    %rdx,0x38(%rax)
+       mov    0x10(%rbp),%rdx
+       mov    %rdx,0x40(%rax)
         call
         mov    0x0(%rip),%rsi        #
         lea    0x8(%rbx),%rdx

Basically, I believe it's inlining the first constant-size memcpy and
keeping the second one as a call.

Overall, the number of memory accesses should be the same.

The biggest impact that I can see is therefore the code size (which
isn't much).

There is also a kmalloc() on the same code path that I assume would
dwarf any performance impact from this patch -- but happy to be corrected.


Vegard

