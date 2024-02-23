Return-Path: <linux-kernel+bounces-79262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E31861FCB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5364288065
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3E2249F4;
	Fri, 23 Feb 2024 22:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="U2s3nlDV";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BQXNmL3S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aiIjfzgn"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686C0199A1;
	Fri, 23 Feb 2024 22:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727504; cv=fail; b=FFtLstkLsWXdTLoSF0A0cK0F+o3D4lspn1HRfgZrMGUbSuWigQPQIRjNzRWX/Qkbp7z/dsGZH2hsKWiNVKXPTzqk1T45dr8kRTvBVLyZ8wdTNW8L/Tq0FpM0J7WCpWTRhld7Vvfw8jVKfVWMmVZ3Rxul/iNVhKh76eM8LRFZCgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727504; c=relaxed/simple;
	bh=ofoXL6Xzk3461cdUcsQMtnvO9Fot6CBJHi1tSkrjRoM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CfOKRPw6qVM6/a03vCFHTI953G2sagEUZRxfrrqBzLh0jiWvYTWwTHbWBD/Qw4Nm2/hO1/pUE3P4gW+qjJHm/+2HzFvxjicCVqXeQHhdAFiabrtpsqXV8dTIdMAszDuJZv8f8KX3eV+rnezzLRZOPRYIeVWcLgU0zX74l1udrwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=U2s3nlDV; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BQXNmL3S; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=aiIjfzgn reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NGjZlf028456;
	Fri, 23 Feb 2024 14:31:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=ofoXL6Xzk3461cdUcsQMtnvO9Fot6CBJHi1tSkrjRoM=; b=
	U2s3nlDVGtSEzz128Hg/wpRjG/E11Gi9K2oiGJlQQkutMmJBPaKcK8XOakvA47Or
	TgAPNQIaEwtovot6KGkWcTOrr2lcSRn4Vbl9/dqPSo7RDRfdhTIN3BXhbdvlOXss
	sSLlBgvWzrSHQ+nzyznxny9NPSm0mYLSSfbXp1BzDVextVguax48BMisSMdjdFd7
	wejXSwwWjRZcQ4TOUlIr07AINOCKoY12aTuDJqjct/U3kL5zVVQTM+OgddSLZd1g
	5Ho+3axGm32Ze812xfkaM+TfluG9wfysn2Iy+gEaLDySWYlagsasjYzatYIMo+/H
	Kp9aia4PwkLlwD1QquY9qQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3wd22412nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708727485; bh=ofoXL6Xzk3461cdUcsQMtnvO9Fot6CBJHi1tSkrjRoM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=BQXNmL3SXpgHurxCc5gRqaMrMR85xMk+m8hsYlEMgYicY2XCXB2ZpubTDecgJMTMr
	 85z6aLtLYQuoX0f26CDQobVjWuxW/4v7YKAHIvGZEHUfUcCaigYZ1hNWKnMmIID/i2
	 W9P7F5eQhKaEaVMIha0ggFdhLpso8PLu4OD0WbxyTlHZVhMC5qDx8Hnf1CgcZ7TG6R
	 LACRIvtRY6EUtY9hISaYvgDKEK2EBwcG1/Gqpu4xVvNGfnhqxVDn7UMx/DOiggeaXK
	 3m7CnRqiDQk8+Qq2iVkGltxxN+mHueYmfW+ZshJ65cTKe8azi3216tHwZ+gZ7zIr6m
	 FgMaa7y/4a76Q==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6609540453;
	Fri, 23 Feb 2024 22:31:25 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 39A87A005C;
	Fri, 23 Feb 2024 22:31:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=aiIjfzgn;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id C62F140358;
	Fri, 23 Feb 2024 22:31:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkf4yAEmrLJjiTP9AfnjWKdOI76guQQ9NtNyJLighU+WNfsTxObJMkPsci7NXDwuy6BeuDsM1tV/Y7N3r+62QPdg4Z4U574mQ+lIjdertPvmdlAUn3uzKtax/MIKXQ3pGIPaLNlBWLEv7ecQdfDBm6jp2/38l11xtml2k5bGrEbhureTFrhjII09mNK7XY8kfyYGkwOyTWqKliesAdt+F1sPUlCv7wGfRCFzpY0X7YP+B7/5SmbJW56oyxsUc9EUBcBjM3/DV6/LPuTUAp8Wm3BNq1ppCKDMvdieW340GGUwNVz9lmCv3iyt1qi964bmZb8idDoJesMRRADOfVITWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofoXL6Xzk3461cdUcsQMtnvO9Fot6CBJHi1tSkrjRoM=;
 b=WROIVZuIl0urAWODhFvwbAUcPnvQH/XkHiyGRijsdG6akrUGPYTKXJzPmgVtt7Ap1qjCIATX8Qa+sFxSNUT5FY+nFoliCBfYEPmq04/HIdJYD0+RMGFrSRoqmg6VQztoXn0rTu1OFEwknTujC/k8vU3nOwvsVvX5FOIEID41rc5E56/ZCI7QIWTxpza3F3+MwJxQb/kyrgOOgZo9PFLLRV7rgAqE+o5c/JQ4aJmn/JOTjgf/9Q/ncbvREm1Dl2mzjACzlt9gdpgBin9o8YedaTgByr/bR2/paUYTXsHPauZBJ4tjpumZZpIfRfjvOuUGw1YiwoAsEaUhfMYh8EhWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofoXL6Xzk3461cdUcsQMtnvO9Fot6CBJHi1tSkrjRoM=;
 b=aiIjfzgnrHaMtGcVjVePatYd53B37NnkoqOIGCLQVwe4qUHq6KH12tfk3IF66Z6SQsJgCldzkVvj9Nhq6xmiXnJ90WL1jeEPMoZXHPu38cAmAwKsB2uC7ClXY6CVAUqXwWD/BzkKdHNftxv4c7dZs5L+cxdNez/mcfQ/Xo4Ewfo=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ0PR12MB8115.namprd12.prod.outlook.com (2603:10b6:a03:4e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Fri, 23 Feb
 2024 22:31:20 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 22:31:19 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, "nm@ti.com" <nm@ti.com>,
        "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
        "afd@ti.com" <afd@ti.com>, "b-liu@ti.com" <b-liu@ti.com>,
        "srk@ti.com" <srk@ti.com>,
        "francesco@dolcini.it" <francesco@dolcini.it>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] usb: dwc3-am62: fix error on module removal
Thread-Topic: [PATCH v3 2/5] usb: dwc3-am62: fix error on module removal
Thread-Index: AQHaXyr9Oy4g0cdOPUmwSElfX7s6GrEYkbMA
Date: Fri, 23 Feb 2024 22:31:19 +0000
Message-ID: <20240223223118.3awhuee5kgoebngy@synopsys.com>
References: 
 <20240214-for-v6-9-am62-usb-errata-3-0-v3-0-147ec5eae18c@kernel.org>
 <20240214-for-v6-9-am62-usb-errata-3-0-v3-2-147ec5eae18c@kernel.org>
In-Reply-To: 
 <20240214-for-v6-9-am62-usb-errata-3-0-v3-2-147ec5eae18c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ0PR12MB8115:EE_
x-ms-office365-filtering-correlation-id: ba2246fc-8a90-44de-3e8d-08dc34bf281b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 RWxKXmcPLl9zLKYTNnD7gIWhXcBgC8J2JJrhCY9asFpf/DXndGwdf4VzEqPDsd3ouGuf9W0nt3o0vcQ+uEYQyGbKzbu+GP+wzfVdmn+Hlgwylwf9SHCve/JKHxZ6LEjqmuuI/nqrmVSOMxqiNbTexTwmnw1TUzVkPnXvLQaWp3ILXcDhK7va2tMrrY2KGpKQImF5NEX8cyZNgom/d/dWJeJRUx8gzDenikpP0NpqtA1VhjtyYb/o+DWWqOnNCbqDXvHelt7/PsIfIPHI1904XPSa4reGKpgHLp3ZYqn6lsxr7dOWKsFYsyFOu1huihQT/tm1Y+sYMQ/Ch33I6nlddrTrWBb6IQiacHc7mHPIpJFeNylE945jbYKqiTI3i/wKOuld7wrmBTDKTTwSrpTshY/PW34hBZdRa3ZCpJCVsthBSQ8PX6WQm941JBFLUK/HI7eBejriEzYX9dnXvUZ5t29i6z7VBwUgrMcT6pDGPWMDczirC6p46YGo4Q1FJhCLOLfpkiIE7N/TLI1BEJsbJfXkVSd+J/gk61Sfgjgk4pHGnTquCY3RiJIAuewk9IfiiqES0Cm7X2MTCvtenMitT+JeqF5Fyr5FE4T2NI7WaPs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?M2JrandCMGhoa2dZN1BZV25ON0dwNFhJajE2ZnYzaDdYN3AyQWM2TEd1Vkl1?=
 =?utf-8?B?YXJ6ck1SbndJR2VZajdDWUFySDNMVEovVjM4YU1LbnhIZzJueForcHgrWW5h?=
 =?utf-8?B?OThDOWRqRDEwcElBSUE1aWF6b2tJTWo2Y1ZDZEduYWZxQTd5alZwTlNETUNl?=
 =?utf-8?B?WTJDQWlUTEtnVmRTTlZxbzR1Zzd2d0tjNWpTRVF3RlhPQ3FEb3Z4WHJuNms2?=
 =?utf-8?B?U0lMc2U2REljb0tCdS9nTVJmL1FQb2FGTDBGc2VGK3UzNmNSOEEyamloajBQ?=
 =?utf-8?B?Q3JBREVib2hweXVBcWFCUnBQb0ltTUpTY3hUZVRjeGlVZENTemhJUncyUUpL?=
 =?utf-8?B?Qytha1Y0QmlHSi9PNjcwajZpRkgraHlMQUlTZ3RrL2NON0wwMWhNV1ZSbVlG?=
 =?utf-8?B?MytvLzNOclBPaThFVDl2MUdyVnJHaDEzdFlFN1g2UHZMWTFlSHcwbUZjMmYv?=
 =?utf-8?B?OXFrKy9UWmYwb01saVkwaE9Td0phUmNRcGcrK1J2OUJIT1V0NXh4WTVMWWQz?=
 =?utf-8?B?NXM1NE41Sk1sdkdFWmczWnljNkliSWFkcmFqOGQwb2tMclZDSzQwdGVzQ3ZB?=
 =?utf-8?B?RVZxMmxXek9WMnhLdUZRSkdzM0ZReGpFYjFwYlNybTNGamZ0RzB2QlY0U28x?=
 =?utf-8?B?ZkNIRkZXOGlMR3BQUkh5NkRZZVoxQkFqY3A3M3d0amZDRC9rSzBPb2tBam4w?=
 =?utf-8?B?RGcydng5T2w0WWZCay8rMmhTWmN4UGRmbWtETk5WZ0xvUHozeURuVW1KQWFB?=
 =?utf-8?B?L3dMMXJQRWhhdVR5R2VQYkJiQUNZSHduRnRYZ2JJQ3NNSndodDlzRGhvVVdX?=
 =?utf-8?B?aXJuS05GM2k5WnRNQldmV3RTNlFBdXRZaEM0TFhVTWJHbWV1TjlnWUs1UnRw?=
 =?utf-8?B?blNhUGVBNHVXYjBIM3Y3dFZRT3F2NWIyVXk4ZkwrMXV5KzRsbGxEVG1zcko1?=
 =?utf-8?B?eko2TnZYbkZjOE9IRzBtcEhpRFpkVWFoSGNXeTJBbjVwOEx4Rk4rWEx5NnJP?=
 =?utf-8?B?WXlvZG1oY29IYitSbEppSXBYS003VmNuRTc4MHByZnJ4b08xU24rRDVSRVNw?=
 =?utf-8?B?U2doVGQxVlhuOFFiRmUyMjFyZHRJVzd0Skk2Qm5RbUkxOXErVXJRb3R4UW4x?=
 =?utf-8?B?bVF4UUZQNWdCQWNKM2pGNmtkUkloTlV6NXJmdDgweWlDT3FTT3ZsRUpwQUZj?=
 =?utf-8?B?Z0FVVFZtcm5BaUJ3WUgwWnVXSlVoS0s2dkhlandwcVNhNXZOdDhZeUd5ZGRj?=
 =?utf-8?B?b1RtMlVkTFF4aC9zWmhkUGVEVkpoajl4Mm5UZm51d0ZNWHlrSkNsNmVyS3c2?=
 =?utf-8?B?OXhuYmxtN3BTZFB0c05LS09OSnJmWGJIN2NaMkl6WlcweS8rYndCN1ZqUDhX?=
 =?utf-8?B?a3JpVFdxaXlyNmxCVTZjeWpPMDZNU0ZOQmV0UFQ2THVaMlYvcUV4U3lHNVdP?=
 =?utf-8?B?NTR4c2xEbmRVL2gyczV1OEtUVVUvN3RGak9LWG1CWm1qcjlDQlFTbnVBQlo2?=
 =?utf-8?B?dDY3RlM2cFltWnFsbm9VQzhUZ29Nck5oRGJZbmlRVzB1VkFlR1hzQVo4Wllo?=
 =?utf-8?B?bHVPbSthN2pZZm9EQmZwVEpkV3NqRFJLUEp2TmxmQUczbDErMzcydWY1dDVD?=
 =?utf-8?B?ZytiVlhqeEhpQTN4TDYyQUdGRXNIa0RFdlNVWm52NHFvT24wL3ROYVB5SmxJ?=
 =?utf-8?B?U2VRZ2lVdDl1QjgwdFAvSTJjejhpTFZ1YzJEbDRtYWxuMzRXTGFlS0pyUHBQ?=
 =?utf-8?B?N2tNWno1NTBwUWxud04yQWNBRGpMRkFBdzlqZTRsbVAzU0t2Z3NNSWxQd21v?=
 =?utf-8?B?RHkybTF6YVJYT0NwZmg2bjkyRWJVdk1ZUXJheGV6cnBCUTBWcUhmdGl4cDBv?=
 =?utf-8?B?Q2UybFlnamZaSWxlcmE1U29xWFJpSUtneGtnTjZRZFJwR2U2WlJrQUJ2aGVQ?=
 =?utf-8?B?ajkvbEo0empqV2xOM2FVME5hdThMRituL2VLSnVVc2o3cXZPcmRJYVU3T2pC?=
 =?utf-8?B?SVNBN0FMbHpCeitNM0IwbTJYdkFHSllFNzFTVmM5aUFHY0s4UXZZM1hlOFky?=
 =?utf-8?B?RHI1OW9GSGdSdi9ZdUhrN0pYVlNNRFRld2xNaG9CV2tPVzR1YkZ6ZXNSVG9z?=
 =?utf-8?Q?QLAtBLF7BuuoizaFOFncp6cC4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A60C5480C624B34186E5558A8B13705B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8k4KiA/nIdlZB9iRQFOfWH4RMVk3XpRxiwLEUFjqn+YJYUp1tfvLBrDGb2iR1xBKx0Tnmt6jjD8MCDFFmw8oWxMbuOrfgewfbcRjUf8CaSX2NU1CCQdZgNmpufYqYyraw8ZL3mEyHYmlb4JQt4Iz2/VH7XxKMGePtcBngPxkdsKY/+1NkpfiYoYXu8V7Vl7iLJCO6tLHpSXAbI5ZUy2Ipq8gQe25awNyV+XS96o4lgUBRKnb0DqogIOy8uGPkaKN46A2bYikjeqiYHiYCaotWEQeuDTyBhMc+nnfl7J0xwYr5eOe6B7GYkhsCmUcAOeKDq16pwVpKHOPQ/+YC2px2U0PHLcVfR62VU+0CM5WE9cXqsNEO4noeSbvtRBox0wQXIg7uxK6JyCyVx8ZQoCbJnqz1aFtAHQpGHGfmEarYmttMFpxHqwuo/k8mpuly1xUP6Jo/sqmmO7DYEIvpSLirANxQsZHZlQbJBQwvvuV4xEWppRQ3abgBzPGJ30FsULVbYM54yctV+QFjfZXnP47Tza3AIOQMm3PCPMyPfL27tNdK2tSezUjxKfoZYcrBRki/2sHLNe+45UicO5j6w2E4vGOu57lApcJIoKAZ0mIoT+MUjb+hCDQ11kpUsl4Llmq9YrOmOWtGseoua+msBjk0A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2246fc-8a90-44de-3e8d-08dc34bf281b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 22:31:19.5882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GIgX4t35lwi2nJquOrbiAgk3tIMQ9U/G5bsMoCTzzh5qhqI6iBi7UfKqKwYsL383X4yKQRPmSNF2dc5oEyjo6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8115
X-Proofpoint-GUID: ta7WpUK8KbTMRts7MojvVbdUfiMYjDoX
X-Proofpoint-ORIG-GUID: ta7WpUK8KbTMRts7MojvVbdUfiMYjDoX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402230162

T24gV2VkLCBGZWIgMTQsIDIwMjQsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IEFzIHJ1bnRpbWUg
UE0gaXMgZW5hYmxlZCwgdGhlIG1vZHVsZSBjYW4gYmUgcnVudGltZQ0KPiBzdXNwZW5kZWQgd2hl
biAucmVtb3ZlKCkgaXMgY2FsbGVkLg0KPiANCj4gRG8gYSBwbV9ydW50aW1lX2dldF9zeW5jKCkg
dG8gbWFrZSBzdXJlIG1vZHVsZSBpcyBhY3RpdmUNCj4gYmVmb3JlIGRvaW5nIGFueSByZWdpc3Rl
ciBvcGVyYXRpb25zLg0KPiANCj4gRG9pbmcgYSBwbV9ydW50aW1lX3B1dF9zeW5jKCkgc2hvdWxk
IGRpc2FibGUgdGhlIHJlZmNsaw0KPiBzbyBubyBuZWVkIHRvIGRpc2FibGUgaXQgYWdhaW4uDQo+
IA0KPiBGaXhlcyB0aGUgYmVsb3cgd2FybmluZyBhdCBtb2R1bGUgcmVtb3ZlbC4NCj4gDQo+IFsg
ICAzOS43MDUzMTBdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiBbICAg
MzkuNzEwMDA0XSBjbGs6MTYyOjMgYWxyZWFkeSBkaXNhYmxlZA0KPiBbICAgMzkuNzEzOTQxXSBX
QVJOSU5HOiBDUFU6IDAgUElEOiA5MjEgYXQgZHJpdmVycy9jbGsvY2xrLmM6MTA5MCBjbGtfY29y
ZV9kaXNhYmxlKzB4YjAvMHhiOA0KPiANCg0KQWN0dWFsbHksIGl0IHdpbGwgYmUgYmV0dGVyIHRv
IGhhdmUgYSBmaXhlcyB0YWcgYW5kIHNlcGFyYXRlIHRoaXMgZnJvbQ0KdGhpcyBzZXJpZXMgc2Vy
aWVzLiBZb3UgY2FuIHJldGFpbiBteSBBY2tlZC1ieSBpZiB5b3UgcmVzZW5kIGl0IHdpdGggdGhl
DQpGaXhlcyB0YWcgYW5kIENjIHN0YWJsZS4NCg0KQlIsDQpUaGluaA0KDQo+IFNpZ25lZC1vZmYt
Ynk6IFJvZ2VyIFF1YWRyb3MgPHJvZ2VycUBrZXJuZWwub3JnPg0KPiAtLS0NCj4gQ2hhbmdlbG9n
Og0KPiANCj4gdjM6IG5vIGNoYW5nZQ0KPiANCj4gdjI6IG5vIGNoYW5nZQ0KPiAJaHR0cHM6Ly91
cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDIwNTE0
MTIyMS41NjA3Ni0zLXJvZ2VycUBrZXJuZWwub3JnL19fOyEhQTRGMlI5R19wZyFiN18zdm1KcE5M
T0Z5M2dfd0V4TVFTQXppOTQ5TzRQb0lEM2U0ck5FdkFzYmdDdnh4a2owRGlTREZKeEY3ODU3RFpN
N3F5OURNa0g2UTVCUEQtalgkIA0KPiANCj4gdjE6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMv
X19odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDAyMDExMjEyMjAuNTUyMy0zLXJvZ2Vy
cUBrZXJuZWwub3JnL19fOyEhQTRGMlI5R19wZyFiN18zdm1KcE5MT0Z5M2dfd0V4TVFTQXppOTQ5
TzRQb0lEM2U0ck5FdkFzYmdDdnh4a2owRGlTREZKeEY3ODU3RFpNN3F5OURNa0g2UTFDY2l5bEUk
IA0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMgfCA2ICsrKysrLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMgYi9kcml2ZXJzL3VzYi9kd2Mz
L2R3YzMtYW02Mi5jDQo+IGluZGV4IDFiZmM5ZTY3NjE0Zi4uNjAwYmE5Y2ZlZmVhIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtYW02Mi5jDQo+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvZHdjMy1hbTYyLmMNCj4gQEAgLTI3Myw2ICsyNzMsMTEgQEAgc3RhdGljIHZvaWQgZHdj
M190aV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlzdHJ1Y3QgZHdj
M19hbTYyICphbTYyID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ICAJdTMyIHJlZzsN
Cj4gIA0KPiArCXBtX3J1bnRpbWVfZ2V0X3N5bmMoZGV2KTsNCj4gKw0KPiArCWRldmljZV93YWtl
dXBfZGlzYWJsZShkZXYpOw0KPiArCWRldmljZV9zZXRfd2FrZXVwX2NhcGFibGUoZGV2LCBmYWxz
ZSk7DQo+ICsNCj4gIAlvZl9wbGF0Zm9ybV9kZXBvcHVsYXRlKGRldik7DQo+ICANCj4gIAkvKiBD
bGVhciBtb2RlIHZhbGlkIGJpdCAqLw0KPiBAQCAtMjgxLDcgKzI4Niw2IEBAIHN0YXRpYyB2b2lk
IGR3YzNfdGlfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJZHdjM190
aV93cml0ZWwoYW02MiwgVVNCU1NfTU9ERV9DT05UUk9MLCByZWcpOw0KPiAgDQo+ICAJcG1fcnVu
dGltZV9wdXRfc3luYyhkZXYpOw0KPiAtCWNsa19kaXNhYmxlX3VucHJlcGFyZShhbTYyLT51c2Iy
X3JlZmNsayk7DQo+ICAJcG1fcnVudGltZV9kaXNhYmxlKGRldik7DQo+ICAJcG1fcnVudGltZV9z
ZXRfc3VzcGVuZGVkKGRldik7DQo+ICB9DQo+IA0KPiAtLSANCj4gMi4zNC4xDQo+IA0K

