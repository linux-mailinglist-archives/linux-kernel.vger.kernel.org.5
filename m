Return-Path: <linux-kernel+bounces-96667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55976875FB6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799C01C218E0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D405224D4;
	Fri,  8 Mar 2024 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dyx+JlFC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vOcq953t"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE99650A70
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887182; cv=fail; b=OumaCMwVXOqI1msWFrnGW7G7yChZ7+ytekgNkWGFu5N8D4CmqJsCdYwVycKtdFncoX9PZrlrCDZNBcHrFA7ZVmtwLaGTFAyq7Ytzl+bqkkH49+6iXVHy+0ezq+kw8sOTtOopLs222QiqYrjFcM6FLB6vTQThYjjTeItdTmQr68E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887182; c=relaxed/simple;
	bh=27gE8AFMNeFJo79tK08O/m7rR6nV2QJNBq8BVPNW7Fc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cAHyUu5YdPrzBPXOWjg87zYTySfaZAkRXP3Fu4MB5M/cOvTaKfUnexfZvUOCIhOjaGOadgo/ukM3wwn1l6nm/IBnqT8W3zRUIIE4KLnvQXGjyLSl2f1ZJU2750itHl8DphaXbTsQw4ClONvsFGmwN18Fqh8mpxunNvEpdeGYoJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dyx+JlFC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vOcq953t; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4281ivvM018129;
	Fri, 8 Mar 2024 08:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hk0WdmYViO4ssHl/OlMEhHvyGso7EDpUh8pPYyfKulg=;
 b=dyx+JlFCWteacDEu9GlhmWZ/qwIL9Z2eAS2mo7FuooiBLYhMZIUD6zjzr0URo5vT41hl
 LPGhUujhiOXZ3YAwRK7qyJ1PmELEt3Ooa46lME/5P33RM4rwUqK6OXLk/WmvPyg7GfOQ
 kWqFyc7a2qXmqqxtgM6tb68y28F/eZ3XXZFPCImS+5iPJwIFFjadH+uHALYV9+2cMvIH
 r3+whTwZ7DO7hcIDRzo29agCgIKpPLG7HGX9WQeCzJyBp8Ac8q+VTZnGu4tQORmvESUw
 uv7Cy3UDYeoEGsU9BM5cfPw+bXv8DDf7ycNb7SdOgW2Z9SkiMJErjWisBW9ThhjJNAn8 fA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wku1cnem5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 08:39:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4288BtlN016065;
	Fri, 8 Mar 2024 08:39:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjcg3xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 08:39:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkGCrgv8ub1X1kBuY2adV4oBBA2m9d68fS9px4jhTtiIvyCzRwuYyf35sKuWY36rAJoLfzNATW0ubwYzTne58csaY2+9zni200QIup9EbE1vyS3/9RdD/Gcvzskg57pdzBRVCGT7i9DwPDpx363fAS7rXlEN+uWHiEO09RaJkJQpYqCSjgR/XEy/wBZ+JC6vqZUsdpTtSuf2r0lXw6QrGmKz+tRM+kB4dq0eUB0FXr8l9Crs/PnnE9pu7MI4GmaTkogyW0W6HfqLLh00pzyhb0XxNclXFWCC1LSPVNZPFSm8pVy8kHYL1vQQP0xy/J3YT0lIS9uYuHzZYX6F5Ok8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hk0WdmYViO4ssHl/OlMEhHvyGso7EDpUh8pPYyfKulg=;
 b=YWTxtY+DiKVKpVwC7QYAsMBhuFo5+tzdcbaNGlNjeXz8LkKkOaQwgcCvbITsbkdcPzO7b8whZakznyp8cw1TBdQ92rDnC6ZYRb8fp5IaIVnY2nM5htxgBjBqgkPFltuFoJRZEY5ErrR+WayPFaCdZHqWQbTx07KYw0Eampwi40ghWPhDQA7iipk8OfDfx18jCKGR2XjiICt8EctFVhqyrl7fOcwgeDFkJMmsD8x68OTphlrX7kE+7N53Ghq8rcfNXVVw7H6PHdqWXlra7ogrxutkH1KlT83qsXMPtJmqKXDAEVLDNIxTu5gdxBrmwLsBB114rnXVVpEgBVpcerHPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hk0WdmYViO4ssHl/OlMEhHvyGso7EDpUh8pPYyfKulg=;
 b=vOcq953tRrr6O4ZCMHjgO3fkDkBWpn1B/bqdsryA7ohj+v9WyROzM67kRgGdWH8ePFjiT83jkJcjRMSqRmmDRszvywtAaxVw0mHDjl4Jyk5VmojJqjkC5ywqKkh77fmDB/Anpw25wSpJEUJJao5g3B8lLSlgr5fy50u17cBjxJw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6636.namprd10.prod.outlook.com (2603:10b6:930:54::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 08:39:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 08:39:09 +0000
Message-ID: <d845a0aa-f323-4917-95b7-8edcfb3b4272@oracle.com>
Date: Fri, 8 Mar 2024 08:39:05 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] firmware_loader: Use init_utsname()->release
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, rafael@kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org
References: <20240223153121.440763-1-john.g.garry@oracle.com>
 <2024030757-trickily-tuesday-bfcc@gregkh>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <2024030757-trickily-tuesday-bfcc@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c8c5e6-eac2-4adb-252f-08dc3f4b38ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PSgHxGsCytzZvW4lOxnFceDLAJVNGLIf3NEwopwxrxyuRBbq+y51Ux5HkP7OCJ0YVZjMFHfunTco6US+x9c4higbrFASwOG5RqSyom8dKObT6VE5J0rc+mUQAQxia5+/Mxv5OymjxezhJtSsc2R0cLtZsvID2Klb9A7tXhCaZRGJBRLUYyAr4a9414bIydxn0SqQh9q6NbC0No7F/gVnVOTKjhdSo4pa5wWZ/8UcwsaNar0yWcsbik9Va7RC8f6+dioo2hmTPdxZjer94GXf5xjJ7Cv1jN80sv+Zp17pARfqzcGpRPhML9FnbxU8bdFfzDugC3IfG0jPjp5FkmhzYfmh69f6KOj6bTRyVInxMBScMkWeNV21NJK376nfRZ8KSOC4vRGgvDe0AbLxYuRjTLlUMnKiEzTcI/H9Nn3Dq2mYbK7APXsZOwEu3s4nAOrHwUYvOPQVzDR2GEMkLhpMDcOYEe6y9Z3tisCE+vtXa+vSaZ1wShSt2h5XR4rvqUBbWM4a3CzNdEukVSYXhnBhOdj/3i1Oz9y5gMLngU1DXJArgmG6jR4ZIrhq4Zj2/IDOk5bWdrNaE+o4NatRQUGMYmfqZ6anZJ0aqSU4oel8vn8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R3RsQ1VmcFlkSmJDNXlSRTY1eEJxQkl0a0ZzUDhCRGx5Q09wN2VPUkJ1VVlY?=
 =?utf-8?B?TGZqd2h2UlRCVk5ILzdLd1ptalNrS2UyOWl5UHlRdEQvSHdDdVdwOWNRbHNx?=
 =?utf-8?B?NGdXbmJDakxTQU52dWtNcTIwbHhGQVlIdTJxakFaYmVabXo5VklrUDdGZmpk?=
 =?utf-8?B?TFYrQ3JwUHJvNmVDTVpaQ250MTlpWU5qTU5LWlFpdk1Hb250Z05aUS9jYkxm?=
 =?utf-8?B?Smpsbzkyc3JnS1hZWWl3R2tTcjNCOTVWVGJCMThkSmhWaFc2Qm9GMmlyR0p3?=
 =?utf-8?B?MlVsZkFFUWtaTXZTdHVsS2JuUGhVaXRaeEN1ZGlQYkpyM29pejlpUEloTkNT?=
 =?utf-8?B?b3poTkVoQ1ZzZmRrYVpPblU2VEpXdCtpbXBySUNhVUtKOWxoR21LdnhZYjdN?=
 =?utf-8?B?eW0zN2lCNlA4RkorZ1JqYXJoOXYzWUM1QXloSFM0ODJZSC9Sa3NFRkREOC9u?=
 =?utf-8?B?NUhSM2tZWjQ4L2o5Y3J3dUFzdElSK05aT2dYUUN3enkybWpYa0x4dFI2OUYx?=
 =?utf-8?B?Q2pwaURpVWtBZTdMdGxvbjVDSGpVUDlTWE1oUVhzd0ZqcVY4bk0zTlNUcEtJ?=
 =?utf-8?B?QzJJcmhOTGRHenRUNFNRYXpSWmNjZnl5Y01kUkxjNFkvRzg3WlY0bjRwZ3Bt?=
 =?utf-8?B?d21nd09WYmpWWDMvNkgralJOQnVwYmx1dlhUNzUySWZJaDV3ZmNibEIvUVdw?=
 =?utf-8?B?czdjZzFhcW9SS2puMDBWbktsaXlUSUlzRG1YVEIxazlHQUZkcTNkVG9hSkZJ?=
 =?utf-8?B?SlpCVVBTMlM4UGJIUithT2JuQUYrWmZwYUlISlJVbG9xbCtKTGtDNGVNemxP?=
 =?utf-8?B?bC83aHVwb0xhMm1BeVJEUWFBcHJBWVRsMzNFcEtEMFdQd1VsMEFxZXhoVjZE?=
 =?utf-8?B?aDZzdHJHdjlOQjFmRnhwNGZLN2duWmJua2FQZThidFhxQlBqWmxOdHdyUy94?=
 =?utf-8?B?Q0R2MGZ2RGU5bTRzSjdnVFh5eVg4Uitsc284dUNsbWpmelo0M21PcXBBbXN4?=
 =?utf-8?B?VXhwK2pDU3ErdDB6cE5wUSthUHJRQkozK1R0SkZzTzAxbThLZFZGOGg2cjcw?=
 =?utf-8?B?Y3pnaHY3d1BTVGNWREhDSVFMTjFYdXR1dkZ1MGxhSFFUaEFTRm96WXNnK1Rk?=
 =?utf-8?B?VTJuVjJ4SFUvYTdyNHZXUksvV1A0UnB6VUFKVlpVc0RRTmcvSHNidzlMMXVY?=
 =?utf-8?B?MGFoUmF5b3ZZQzZ4M1hibzV1NGwvRXRPN0xDWlNRTDBJbXBJR0UzNFBJRnNL?=
 =?utf-8?B?cWxSOHhXdDhaM2tkSFZpZjRYc1UvSkhka3YzV3crQ1V1NkozTUxDalpNMVdD?=
 =?utf-8?B?R3RVOGFhK3hpdldLRUQ0NWVVQTgyOGdmWWRkZC9hR0dDdzJ0alc5QWpBbzR1?=
 =?utf-8?B?b2JNUFpOTTlwRlFIdzBNcFpxRmt4M2FldTJ0Sm5qRU9DRU1NbWNaSko3YkZW?=
 =?utf-8?B?c1NWWHo2WHY3bUtTQ0hnMHdaUFVTODludE9sRG1IM3VxVm45R2o4YWxDaG1K?=
 =?utf-8?B?blA4czlld2lwYVBOb2JHR1JuVnYrOURwVG5CWFJLL0d3WkZSWGpoR05kaGU3?=
 =?utf-8?B?OFg0VXNwa3pZdkxFRGcyVHZTVWZnc1pKY2pJUnVSM1Bqd3dNUTRkNnY5L1pn?=
 =?utf-8?B?OXdRV2xiT2pOVzJkNFpSY3hZTmRudURMM1JVeFYzM3dob3ltSnpsOTBUY1N0?=
 =?utf-8?B?QUdlbUVFUWdtSjRUZjJvNTBnaWNKZGhHZUtDNWFQb3p3ak95WHVWMDAycUpX?=
 =?utf-8?B?UWZhd3I0V05zNVdhaEI4VVlXQzhQV0pwbnppT0EyTFBWR2VTcXhsZ1NNQlhv?=
 =?utf-8?B?b0hBTzFuVkZ1ck9SVEhLaUlFZS96bWtzUSsvaC9PMnMwZTgvVTFwOHNXT3Ru?=
 =?utf-8?B?TDlYN01uRmtPZEpscUpjMks5OUEwUjRtNzRUZU1xYzVoSWZCMDVqcGJoNlVl?=
 =?utf-8?B?Z0hRSk5JOWdPTVdldnVWMmVrbzRaelBaZ09JSjJ0WlJJaXpaNWN4Y3lnM0Q4?=
 =?utf-8?B?d3BRa1NqbkJxd3F4MlVRdTFkUXNUazFka1AwM2NGTDRCVVA1UXI1MjBOODdz?=
 =?utf-8?B?cDVxWFJHOXgxWmVWQkVYbFlHVVVYWEtLRG9ET2l1OHlTWnMwVDRRek1QQUIw?=
 =?utf-8?Q?TcPcLvf5ahBrQ8wZlaEPWMpSV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kUrXq9DN2oz82o9EVcGLklTvsep2gPcUMkONJlYbccKU0uO5Hez/0tLBkvT7gNUcwBQAwldb/XpAeNHoELO9/HlltF76YLQ5n8WMW6UNdWJEXXrP60cClKzH/KiFrRrsCY21DxxwaxGq0LWyolrhxeCEX4KgvAcPjsRe7u4bP22/ZEtDG8youzTaDGhp8LmR/ipyaomuyy5ktyLN8IVnWzlvMiQ0z8rqJPLhuLgMCnXXKVOj6TVPRP0xmmiGWZAglq5RCo0mT208X7YonSgfUYv0YKiU9/cMYMVpRABdG+dgU7KJ/ldg3bY3M21ajKFL+H3My0zhZMRRoSPmkORi2LF6LmIHVZTHENC32uszTnz63Qu+lVcA01NEi8Il78ySL4wQqgOSTpm7URxi0hM+qq60pClryV2jr2T7p5V3oluL819UxqruMKU9d0cFINzM01GZCeO79Vx/OAkNryy4Rvc/efyrgQRjjZjZymP7GyLMgu02nXpmm3gX2SPcSX3jtfvz+6WTZqva/SuziY1fTaOwvI01oY1o0qtAdeM4kFNoclM+8R4gtYcG5w8qgFIctlS2WASsnXyr7Dd5xUGG1R4gubO4mRwx9Cw+LXU2L1I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c8c5e6-eac2-4adb-252f-08dc3f4b38ca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:39:08.9537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzJJb5ummCn+4FFO6h1kHgzhA98qdEibMTM61ti3COAM4WRwlJXzacVf9wxnveNcpCt8q8f2rv/JxWTprJaCCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_06,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080068
X-Proofpoint-ORIG-GUID: 22WkcjuUxYaA7UCwb3F5jMdB0RN_xDDT
X-Proofpoint-GUID: 22WkcjuUxYaA7UCwb3F5jMdB0RN_xDDT

On 07/03/2024 22:01, Greg KH wrote:
> On Fri, Feb 23, 2024 at 03:31:21PM +0000, John Garry wrote:
>> Instead of using UTS_RELEASE, use init_utsname()->release, which means
>> that we don't need to rebuild the code just for the git head commit
>> changing.
> But you are now exchanging build "convience" with code complexity and
> runtime checking.  Which is better, and which is "provable"?

Well I did want something that did not add too much complexity, so it 
would be an obvious win.

> 
>> Note: As mentioned by Masahiro in [0], when CONFIG_MODVERSIONS=y it
>> could be possible for a driver to be built as a module with a different
>> kernel baseline and so use a different UTS_RELEASE from that baseline. So
>> now using init_utsname()->release could lead to a change in behaviour
>> in this driver. However, considering the nature of this driver and how it
>> would not make sense to build it as an external module against a different
>> tree, this change should not have any effect on users.
> This is not a "driver", it's the firmware core so this does not make
> sense.

Understood

> 
> 
> 
>> [0]https://urldefense.com/v3/__https://lore.kernel.org/lkml/CAK7LNAQ_r5yUjNpOppLkDBQ12sDxBYQTvRZGn1ng8D1POfZr_A@mail.gmail.com/__;!!ACWV5N9M2RV99hQ!I5-MVUh-jmCxwUFtX_eLsjXZpF9BBk6KeBWJ-6mlrfjJjomRDUWQ0_nXpixUddcj_Gz6H_FiBu8lUys6u5kzcqsAyg$  
>>
>> Reviewed-by: Luis Chamberlain<mcgrof@kernel.org>
>> Signed-off-by: John Garry<john.g.garry@oracle.com>
>> ---
>> Changes in v2:
>> - moved note into commit log and tweaked slightly
>> - add Luis' RB tags, thanks
>>
>> Also verified against fw loader selftest - it seems to show no regression
>> from baseline, however the baeline sometimes hangs (and also does with
>> this patch).
>>
>> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
>> index 3c67f24785fc..9a3671659134 100644
>> --- a/drivers/base/firmware_loader/main.c
>> +++ b/drivers/base/firmware_loader/main.c
>> @@ -38,7 +38,7 @@
>>   #include <linux/zstd.h>
>>   #include <linux/xz.h>
>>   
>> -#include <generated/utsrelease.h>
>> +#include <linux/utsname.h>
>>   
>>   #include "../base.h"
>>   #include "firmware.h"
>> @@ -471,9 +471,9 @@ static int fw_decompress_xz(struct device *dev, struct fw_priv *fw_priv,
>>   static char fw_path_para[256];
>>   static const char * const fw_path[] = {
>>   	fw_path_para,
>> -	"/lib/firmware/updates/" UTS_RELEASE,
>> +	"/lib/firmware/updates/", /* UTS_RELEASE is appended later */
>>   	"/lib/firmware/updates",
>> -	"/lib/firmware/" UTS_RELEASE,
>> +	"/lib/firmware/", /* UTS_RELEASE is appended later */
>>   	"/lib/firmware"
>>   };
>>   
>> @@ -496,7 +496,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>>   	size_t size;
>>   	int i, len, maxlen = 0;
>>   	int rc = -ENOENT;
>> -	char *path, *nt = NULL;
>> +	char *path, *fw_path_string, *nt = NULL;
>>   	size_t msize = INT_MAX;
>>   	void *buffer = NULL;
>>   	dev_err(device, "%s suffix=%s\n", __func__, suffix);
>> @@ -511,6 +511,12 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>>   	if (!path)
>>   		return -ENOMEM;
>>   
>> +	fw_path_string = __getname();
>> +	if (!fw_path_string) {
>> +		__putname(path);
>> +		return -ENOMEM;
>> +	}
>> +
>>   	wait_for_initramfs();
>>   	for (i = 0; i < ARRAY_SIZE(fw_path); i++) {
>>   		size_t file_size = 0;
>> @@ -521,16 +527,32 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>>   		if (!fw_path[i][0])
>>   			continue;
>>   
>> +		len = snprintf(fw_path_string, PATH_MAX, "%s", fw_path[i]);
>> +		if (len >= PATH_MAX) {
>> +			rc = -ENAMETOOLONG;
>> +			break;
>> +		}
>> +
>> +		/* Special handling to append UTS_RELEASE */
> You don't really document why you want to do that here, and ick:

FWIW, I did leave comments for current members of fw_path[]

> 
>> +		if ((fw_path[i] != fw_path_para) && (fw_path[i][len - 1] == '/')) {
>> +			len = snprintf(fw_path_string, PATH_MAX, "%s%s",
>> +					fw_path[i], init_utsname()->release);
> You now have a "rule" where a trailing / means we add the UTS_RELEASE to
> it, how is anyone going to remember that if they want to add a new path
> to the array above?
> 

I didn't think that those path ever really changed, so would not be a 
problem, but I see what you mean.

> this is going to be a maintenance nightmare, sorry.

Understood, back to the drawing board ...

Thanks,
John

