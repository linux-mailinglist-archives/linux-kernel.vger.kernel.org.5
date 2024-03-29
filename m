Return-Path: <linux-kernel+bounces-126279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F44D8934AB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832901C237D9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44CB161309;
	Sun, 31 Mar 2024 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EmOUQJ2L"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B669915FA9B;
	Sun, 31 Mar 2024 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903436; cv=fail; b=uwsEJ+m5HdQEEvaus5hqQHSYnbb5Jjf/7VSFPyQP++zjmpFcZHHRUGjwXtgTpBBC/aSpUHwoJBszLDX142mTTWAaQ0vOZo2jyjg10SIPzbPd+Oz5MthAJ4ybu8g608isJ3t4pCFhhJ2cH6xHPlKB6o+JHdc7uEcrXLaVQFom4uQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903436; c=relaxed/simple;
	bh=bQ1sQiUme+Q3Cz7+Rqll4KOhJx3agthzwxEEFJ/fcrw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QJbwG57e0JIs7iu9KSXdmYE7Ae+zqvb9odbf3HEcaG5JfaOcMMrAkUrmyrOX8m6KrlCdKa7nlx9GUPyGnYIZAolMGQ05DFTH+JOSmLERZFB61q+4k53nfWYTkRAts81/GQ4n3bBbSEi7MzcUSzwx5l22lPj5vDuPGTCxNWsxms0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=fail smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=EmOUQJ2L; arc=fail smtp.client-ip=52.101.85.6; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microsoft.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 089E3208CD;
	Sun, 31 Mar 2024 18:43:51 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UFuCl8rsQUIt; Sun, 31 Mar 2024 18:43:50 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D4FB0208D4;
	Sun, 31 Mar 2024 18:43:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com D4FB0208D4
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id C751D800061;
	Sun, 31 Mar 2024 18:43:49 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:49 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:15 +0000
X-sender: <linux-kernel+bounces-125387-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAfUWmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAEwAAADLigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 18142
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125387-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 5916A20270
Authentication-Results: b.mx.secunet.com;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EmOUQJ2L"
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.6
ARC-Seal: i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711743799; cv=fail; b=q3+k1foNrTTfkfQaLK2E+ow3mGJnnyebWtUHpnvHFuFvnFpQlh16eemz/molaRmB3QpUPbK8LBLlIKqIsv8jiXpu/Mk0wuwrbIoFVkx+IwuOAsz0R1y8SR/5FEluXJcfsOp4K85G4ExiFAVKiH7ZyJPmeymmQqMRu1ULgvhePeM=
ARC-Message-Signature: i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711743799; c=relaxed/simple;
	bh=bQ1sQiUme+Q3Cz7+Rqll4KOhJx3agthzwxEEFJ/fcrw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ACE5xPzTJ/cJOgyyCMF8AjARNl03J8kPt2WIrCoNV/vTuWcWBAhgQCfdp/iZJ0BIRsa57dHJa5gaAO/xuyNUU7g3wX3HUDMBGoCaigBITE5JSg+AdiSC72sT+a1HFwiiDyvXSIsBxAOSSCO8ZISr4slle+jMhokfYXo/uZw4z7o=
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=EmOUQJ2L; arc=fail smtp.client-ip=52.101.85.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZDisl1mKZ3Mu5gRqY+6UjTQOkgbP1LT5X9Wp9iaPFEYvuJAZGuLNoCvSDemaHUhaEK0x1Sm8Ww/QDg2eKsrEKg1F7Uq4waZ+IkThFKATlJ9qrn51OdmFH+/YUpBxQxFKQktiyL52NeYUuq6yhggagLMbPSuMnMUHr6+wQ4E/8eqzDgViytm7sYiecmNi6h6lTqx2RNZNJjKmpkuCho1yc7JDgqnw2r7Zcg60iSK6ET8WbfjyJFd113Bg5osLUHaayiFU/oiJj+FQA7MdrZpOMk6e0y9DDKSHEjx/Ma1WEUBd8J8+wYR2RP/8ldzoEx+QzsoAKiIR4oVjGRg2ymu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQ1sQiUme+Q3Cz7+Rqll4KOhJx3agthzwxEEFJ/fcrw=;
 b=oPVMLrCvSUloN2V5IqwoTCHEFLYoEt9j+ZLlEobsRxxVSjgVVbcgysUeEWaWw1pumJNEKg6WkJ++KmWyaddzqMbhb7XEftKtlWwErsRaRW2MNJ7rtGRs9wspVNJWVFgUabNGOXIDDpCIW8b/3Fi+vPHb2mR15hhI8huD1rBRUepM+cxiyTsyBLmBdYdSt6OGsCslny05UPDjMhhdOvQwLoutGiSMwWkwR72GcrRST4Jcr5mPyDGw3m6iCd6f85R+ZZDkLceitgzs8gnjoly/2IailEyb76Vgv01f6SjeiQJ9t49SjajPE/yHOb1V61btyeC3XbTKfxwOFxB8fg2rNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ1sQiUme+Q3Cz7+Rqll4KOhJx3agthzwxEEFJ/fcrw=;
 b=EmOUQJ2LSvE9cyht6q2leDYgv+rBvND7LfYCCjSKEGrWE16uyMMToC1rJLucEHy3nvB7FP532P/WYudETqOdgJaomCuDuEUUZRIskykan935Mnu/fu2nQ3da9DBgI04q+3Z82SRjfFlmmDc2Ksj4MgcaRULNGRoabQm9/6D+sak=
From: Dexuan Cui <decui@microsoft.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>, "hch@lst.de"
	<hch@lst.de>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "zhangpeng362@huawei.com"
	<zhangpeng362@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"mhklinux@outlook.com" <mhklinux@outlook.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] swiotlb: Do not set total_used to 0 in
 swiotlb_create_debugfs_files()
Thread-Topic: [PATCH] swiotlb: Do not set total_used to 0 in
 swiotlb_create_debugfs_files()
Thread-Index: AQHaghHPup60+Vul2EyICRlEmMkd0LFPJ6Jg
Date: Fri, 29 Mar 2024 20:23:15 +0000
Message-ID: <CY5PR21MB3759BEE344CCD8F20FBB4E4CBF3A2@CY5PR21MB3759.namprd21.prod.outlook.com>
References: <20240329192809.17318-1-decui@microsoft.com>
 <07ed50c1-75a9-494c-8a6a-5edcc2d6f932@linux.microsoft.com>
In-Reply-To: <07ed50c1-75a9-494c-8a6a-5edcc2d6f932@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f62ef308-7ef8-4c3c-bba0-bb7106167ec4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-29T20:15:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR21MB3759:EE_|DM6PR21MB1514:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: czTUrw8iTH9j7FN+BqI/hqTuIkeoAkCRZxpC21oNetgeSwVvlS/lnf8LOmda1fUowBylxSObXoyVT9qAdnSdQnU963RGMclyYaTb2UnvvLUFvneriPXCwQJHUZ1Y+x0RKFBcL5wDryviBEVIUZNyDBzwbROlnrjKANVKUFbOetCNzIYso0V344zex6LsvujpYunxNK6W2od59ELvYi7LesVbm+Q1l4SMsdP2L+cib6chyTBXkQblyPBQ/VZ3zKPckyFYTsGv+H0TjYaEp7aZa8gaopi8lf0KYTzUBIrbPd89SN5NxAB6PVlcqIhzzWzOelYX9+XLviu2NLtRoulf9TcZl3oolhYJ3isYhAzmF2trwWAEHe+tNaot/e5k3wN5YpzcuYbPq8Ijs+bKbdLSYCLdjqA48y3/5GiAfI4oibQqrtjWqGN2fIE3m3fS9sOcIbvTgQMLQj+Jvurj9d+j0cUCgDkEXlrQ2r33S1r6Jvu2GvZpPl04CniCNsSNhL0Si5vAk+fy84PtYJQB0VgZ5Bk5KKtP5AO0U/s2lShowsmXQLf5diYbpio7EIJHyFBucvbJk0N+qYbZb4Rgz/XFQTfwhxz0QZ7mie8ffCQkmQGTFKHZB8pQIny0PiRgWGSIw/cUvmkdJ60alT2HyVlpqLZEOKd3yYbhLRWmILaEONE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR21MB3759.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NU9abGF5bnYrVkNUWHNpdDVNOXNEWE8veDZjUHFmWHRsRzQyeHI3QUoxcDlP?=
 =?utf-8?B?bkgvWTNIUmNsMWlNd0V2dWhMUExiT1RRSzNmMHRpaURyNzBNZWZZdmV0UDV3?=
 =?utf-8?B?aFNWbzhucEJ5bnYwMWYwWXVwNXpNc25jOUtyRmN2cnIxWGJzZm9Qd3dHMDlG?=
 =?utf-8?B?UFRnczc2TnVCRUk0ckU0dmdNcWh4REdiREVscEV0NVN4ZjRDMEE0Vkhjcldj?=
 =?utf-8?B?NU1zS1UwNllHTWZFNFRHRUJYTmlSWlc0SFd2UjR5R3FCUHdlRHhnbUZsdHhV?=
 =?utf-8?B?RTNRYzlzTElOV1RBQUwwaWRxdTRWdmxLbzBJSGtNZUxaMVUreVFKYkl1RUhn?=
 =?utf-8?B?MUxkSHVwY1JhRkFPci9KOUZLSFlSTDF5Y042ZGwzSzNXYUxsbXJlMWZBY3Fo?=
 =?utf-8?B?ZUF0TXo5ZVVTaXV4aGV6ZFdtYmZwOW1ONGg4dmYzM3JKQVNjN0ptdmxvSDhI?=
 =?utf-8?B?b2ZuemhRZkhhUGxteHpRcnVUbFhaMWhTdlBIdkZsei91eHl5NXBvN1lkR0xr?=
 =?utf-8?B?TnJVcnVndWJ4QU5mWVRTSW9GV05wbXNYaXlpNjdxQnZ3NWtobENMdElrZFpU?=
 =?utf-8?B?akZhVnlyME1mQjF2bk9EbU5xYTc3SFFqM3FHOEdremxrS1Bvam13VkNnbVoy?=
 =?utf-8?B?TEVGcFdmZXhteGxwcnd5OEZwMkxUN3VleUNWUE5uN2loZ1dpYVJ6ZXRXbmlj?=
 =?utf-8?B?NDdLNHVBTi9leWxWVjRhYmZ2YjhsK0tXb1hETVNzaXJ5WlRSclpIVzRSdjNV?=
 =?utf-8?B?Mk40c1hZRXBkK1NiUUVLaTZsU1o1Y1ZlZU5wZndva1djK3VpdzdLTTVFQUVL?=
 =?utf-8?B?azU1WURYbWdBd3lOYTE5a2dIQWMyeVB5TG9ibFl4N1hNaGRRVlo2UWNOYTJF?=
 =?utf-8?B?bGdTaUE4TTdETlQ1M2M1WHBHTGlCQklqMk4rcm9oZnJnT2pVNmdGOEpPdWxw?=
 =?utf-8?B?NVh0RUJ2UHdhZFpTdVJEa3pUUjdrZkJ3eDdvdjhmUlJMT3UwSXBZU1FacFFC?=
 =?utf-8?B?TU4zVm1ZVHdiTDJuTHZHUWpsOWdxLzNKTVhpeE1kRDBvd003U0ROZTFoN2lT?=
 =?utf-8?B?eEk2bktxc2RHL3Y4OG1WTFV5VEdwOVdjZDNwQXhFVEZMNHFXOGhwUnJDVlgz?=
 =?utf-8?B?UVBQT081Q1FiUEJNL29CUTNvR1JOMFdDSEVMUVB0cEZNQ1d2OGdUUUxncEhy?=
 =?utf-8?B?eGEvQ1dTdUVPN093ZFYvbm9QVGJ3b3YwOVc1Vi9wOUNyNTJuM1Q0QmtVUTg1?=
 =?utf-8?B?ZC9JWkhjb1RVSU1jd2IxV0t3WVVZRDA4YnJXbytaZ0RDYmowMzk5c1IvVThv?=
 =?utf-8?B?RnZURHpNZmxpQUZJRHdDUWhOd01nUUxDTU5aeXN6b01CMXR1SmQwcW53dDk3?=
 =?utf-8?B?TWxoRnIweTdZWlIyczFNVW1pNnFjYzczVGZuSmEyWkdweFpLQnFWVW41eTRP?=
 =?utf-8?B?VWNxOS92enpsMEcxRm1LYktsa2lQUEx3Znhjd0Ric3JVSnNpSCtGSDYyMjdZ?=
 =?utf-8?B?OGl5eFFOcGFPMFdLMTFzSy9hQTRud3JISWsyYUhSZiswamFMdWxPOWxrZjJY?=
 =?utf-8?B?NlpjWG9lenVsMmJNZkRLRkY0V2hSck4zVndha2ZuVld3RDd5M1QwemxjSVNj?=
 =?utf-8?B?MlVKRXlJV09rMXZSMVMrVThKRm5weTRuY0o5ZHdQWGV3ZEVIQk9kNnFIbHNW?=
 =?utf-8?B?NmN6ZVM0U0tFM1lkM3ZCY0xXU3VUV2VJdXhvdGFMYmpzSkpyNkZWb3pVQlFP?=
 =?utf-8?B?WjZJTTBKQ0JUV2lSMzNjYXpFVzN6Uk5Db21wQmY2amJvSUdPUFRKTHVLUDBP?=
 =?utf-8?B?WEczdjZiWkFncFM2QVBGNmFTSXE2b3MwYXByYTUvS0prb040NVBFeDJuNTl3?=
 =?utf-8?B?YXVWOW5qdy9IMUtvRURyWVFqOXpndmxVb2lNeWJ2Tmx2emZzUFlpbStobEhs?=
 =?utf-8?B?TXNucjgzVHFtSjdVZnZ2SzdrUVZlMURlb0U3V3RwV3FTOWV2REZ0ajQ1RXdW?=
 =?utf-8?B?Z0VCWHNiblkwdXZzczdPWlNEM29nTEFoNGRoUWYzb2ZJc0dDZWlGS1lqaHJH?=
 =?utf-8?B?U1FRc2x6b1JUdnM3RTJqY3FvTnZreG51TFBQN3FTZXRObEhucFRMVEJGb2FV?=
 =?utf-8?B?cU8xeEM2K2tLdXo2TXdFazg0VURwcDZNV0tyZS81ZHJqYlhmZlNRb1R2TFFk?=
 =?utf-8?Q?XSELpFaHrPcrzqDWI4NWb+M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR21MB3759.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972c378e-daae-4e52-85cd-08dc502e106b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 20:23:15.3950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: be4q1gsVtgAQPBkLEO0LGfx97QKMgPwPDqCRJ69251AOWQffj9YAQG+zfB3NBsCZ1z/JVn1Rwdun2TYMdP1tEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1514
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

PiBGcm9tOiBFYXN3YXIgSGFyaWhhcmFuIDxlYWhhcmloYUBsaW51eC5taWNyb3NvZnQuY29tPg0K
PiBTZW50OiBGcmlkYXksIE1hcmNoIDI5LCAyMDI0IDEyOjQ3IFBNDQo+IFsuLi5dDQo+IFNvcnJ5
LCBJJ20gbWlzc2luZyBhIHdoeSBpbiB0aGlzIGNvbW1pdCBtZXNzYWdlLiBDYW4geW91IHNheSB3
aGF0IGhhcHBlbnMNCj4gaWYgdGhlIHRvdGFsX3VzZWQgYW5kIHVzZWRfaGl3YXRlciBJUyBibGlu
ZGx5IHNldCB0byAwPyBJcyB0aGUgb25seSBlZmZlY3QNCj4gdGhlIGNoYW5nZSAgaW4gdGhlIHJl
YWRvdXQgb2YgdGhlIHN3aW90bGIgZGVidWdmcyBmaWxlcz8NCj4gDQo+IFRoYW5rcywNCj4gRWFz
d2FyDQoNClJpZ2h0LCB3aGVuIHRoZSBzeXN0ZW0gaXMgbm90IGRvaW5nIGFueSBJL08sIHRoZSBy
ZWFkb3V0IG1heSANCnJldHVybiBhIGh1Z2UgbnVtYmVyIHdoaWxlIGl0IHNob3VsZCByZXR1cm4g
MC4gVGhpcyBpcyB0aGUgb25seSBlZmZlY3QuDQoNClRoYW5rcywNCkRleHVhbg0K


