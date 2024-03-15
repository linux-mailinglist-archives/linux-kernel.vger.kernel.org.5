Return-Path: <linux-kernel+bounces-104843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A3487D46D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E96E9B212CE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BDE51C5F;
	Fri, 15 Mar 2024 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HQ2ei+sg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fMW6nYjD"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C058BEC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710530558; cv=fail; b=sHR/MOPCkaDU51vqzaLUwdMxXSH3nSzWfwgdXc3nWQYnM8Owi39f/wWreaYbprdSlfzLOtaDjrugAhcNcynR/UiRQFpX1v4wDGcRHo9EwOl9+416OVjb0wJidM1UlVquQ8Jd8y7hNQ9OztXD9aUDjrMbIP+m57/uOBJOsiUmz7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710530558; c=relaxed/simple;
	bh=OrEGsTV/ayVDpl+gIRKKD3G1iwiC8sKML/HFZ7N1oIE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LkefzHcnrVA9dSKcxpHRhRPCIAf1LrovLc/hxNrVdlFDEbEBzN739uA1tRT0t60rN+nH+CfrfX5MgD7y5pO7oi1cnYAzleIfJXifk8ZLUhq15H63nZq5EWoRG4K2q8e9AYmfMFD6nfyTkD3QFKFYqn2C3n7S1H4PYU5kJRoE2Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HQ2ei+sg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fMW6nYjD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FH9URX015117;
	Fri, 15 Mar 2024 18:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=OrEGsTV/ayVDpl+gIRKKD3G1iwiC8sKML/HFZ7N1oIE=;
 b=HQ2ei+sgSoQDAMpR4MZCLel89oJ5EI07QFMn8Xyx1OzwTM4LrfmxzOklwWDWmqIUTQku
 DE/9nSfrQXNf0gegXjlrBsvCRZHlC9yOcODT6rRA4qUGDwV0xzSmbBSxzOvJQT0ZxlZl
 zTZIgzz6IH3tn9dvkQ5eqYlUgsBZEBQEA9Mtc5vcF6Af3ZAFHfb/ejSydoIK31aJjo4s
 KbuN/aq7IY7U1rWnQXnnErRQrvI7HBMe24tbrzSUrStOEQFoV4FxTkdwMwkXYLlblnWK
 ds/XtpqGDIvMjOF8xGpwZARSz6BYV4nlLDvDcBckqXuMBFLqNIpQSz4fjD5vR+haJwTj yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wvsxk05xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 18:07:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42FHJJYO037704;
	Fri, 15 Mar 2024 18:06:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wvtmmhtq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 18:06:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idVyf85lSCLbpY+zEbBwjr0oI7tN8WxuLZ9lSrMsR0fQlibK6Vwh364o1ca2KkSEQSeuk4Q1RpYIO8IRzDx8nbfXXPMKBJFOQi09sP+K/qozq6MfhEOE4ikRbenKR6hLHCeKKwDH0kSrY0g8ggoRzNqchIhLs895HixbaUZMPLI8NeiJ2Xqon3oBaHLGIa9SMh8BHngy8vdIF6tYyXn6l59MplDFOqr4wMU5xSdxkRSxQcmTKw2r4roxk83fat3Lpea7o7WsieBdlyV5TMbCfN17yMKgEqvSOgZ1doUaMeGEoBIRE26+1uYrhAkEQYSR6oVFEauQQI6F2FI4WgEH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrEGsTV/ayVDpl+gIRKKD3G1iwiC8sKML/HFZ7N1oIE=;
 b=FT9Vkiyple5dggyM37vAQK5T+8uWHhjr8RMvhsAM0qvlp/HDEwkul30/CJD+sXhBV8OLW05yw7zXUxigWKc+6tAHZLI29FEy6cq/y0dQtWxN6L3Jo3sgxobsJAIhwe53xTZOTZavv0QD9B4YMgWbMHo2OAj+DCEKHf/QA9ZEQcHJiVJp5hzq02b6yUhkh2A4ZAXZPYg+0BI3Z3kVr9WTHKlnmaBNa70fqQCGi3GvAjQ06BfBjJSMFaA7CWy/+zuSJ32jYgl3voqJcHrvn10C4lNYAfrYbJWrB2D2fYI1OL7Pe1eTwQ4Jyf+HZP/jASWLRaZiM3c9VAnKMjKAMYeWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrEGsTV/ayVDpl+gIRKKD3G1iwiC8sKML/HFZ7N1oIE=;
 b=fMW6nYjDpYXWxjpDuOQP6DR7x6AsDmW3LWSUGi2mD1iCWJB+a6B1p+B1/AN/Bysv7yYJTMSihFCq0HoV2lkM+LZntUxJXwSjHHInDe88MuN8zm8wuFPLE1wi547+1VntT3XIkmQ9dzIj1KmdTC+wCWFzs5lFn69a/RwDn6a47sQ=
Received: from SJ0PR10MB4478.namprd10.prod.outlook.com (2603:10b6:a03:2d4::19)
 by DS7PR10MB4941.namprd10.prod.outlook.com (2603:10b6:5:38f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Fri, 15 Mar
 2024 18:06:57 +0000
Received: from SJ0PR10MB4478.namprd10.prod.outlook.com
 ([fe80::ab66:bf7a:660f:4890]) by SJ0PR10MB4478.namprd10.prod.outlook.com
 ([fe80::ab66:bf7a:660f:4890%4]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 18:06:57 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Dave Hansen <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
Thread-Topic: [RFC PATCH] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
Thread-Index: AQHadjilIjzOVMIJj0qYATgIHVicxLE3ioOAgAGHjQCAAAiUAA==
Date: Fri, 15 Mar 2024 18:06:57 +0000
Message-ID: <9DFC2DF1-147D-46BA-9562-4C64569339CA@oracle.com>
References: <20240314172920.2708810-1-aruna.ramakrishna@oracle.com>
 <4bd2aea0-3cea-4ef8-9607-40447cd531e5@intel.com>
 <349322E5-5E6C-48D5-BA12-1CF47CE82930@oracle.com> <871q8bl7nf.ffs@tglx>
In-Reply-To: <871q8bl7nf.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4478:EE_|DS7PR10MB4941:EE_
x-ms-office365-filtering-correlation-id: 9d4a4d6f-ab92-4934-d8f2-08dc451ab416
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 XNYHiTUY4O/9qKB2cV83pjfeilSl6LxwC+OnBku3CzCh28+eRXk33SwZBbxjBo8+jfIOG/B5uYX3PKZntmj/OkmPWxJmW0Ht+X+MThdjbZRhUfHTKeM4Ye1NSYYLUGqkoftWSDzF1WnX8/jd1Poc+GjiqQQanHZmgRysyM/usY42psbOMw6KTjff8ERTgvOSFH++ZaxbJT26uif6xdFh8UZ62z13fYGQPMj9Ttop1I+P4ub3EPPpDac6pKBDFMjP8t3ajq2871RvZeKIguU1cZoSPiuyu4pohiD7xJn7sreq8QX3YiDZ6wZPSRO3h6GlLBYYsmY6GlB3QoQEYTAiyaUU7tZe+xv3WVvX3s8uf0/EaP2CuolEPpjNgV4BMjmFcrJOhkYYtbeARWx4E7jjUia4iDY7w2nDYy0VcjqbfcXK683QaKqbP7Yai9xID6HwQoXpat5ERHgVCbJiPv97viyI6tzz/8KFAG3PPcpalq88b+cqE/kQPc/gDYptF1QIyAUhh4/5+CtAR0Rv2rfQB1b0fGMM7+LmyZbIHlib76egBIPX3pOXtJXp7x9d6viq9UdacR0NvBbXgKtVLBQ2E93keiZVJLOIGh1ZyxZ6wggE9YKg9JrpBSqBSnObRGRjLJOm5Pc/97fSpEB0ftkD/JhHlGZtYQCcKRTNkb+r7vg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4478.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bTFJZlBPaStVS0l6ZTJ2eW5tZjh5Njl1UVZVaVNPNGdhR3hQNEc3bmFGczNV?=
 =?utf-8?B?cUpMV1lhM0tlNXJiWUVyM1hHTStDZEpKMHlYMHhWUTdiR2piODFkTDN2YXZF?=
 =?utf-8?B?Z2dnL1daVTJ4dTJjOGdMUEFha0ZYdWYzcERKdnhGZHVOL1phZGFpR0lWcXBD?=
 =?utf-8?B?OHJCWXJNQ0FIdEY4bzdvZXowbDR3d3ErMWtwcHlNcTVFNFg3Yk9kT1diSjdi?=
 =?utf-8?B?RW9tTFJDYmtGQlhhVWVsclNEaXE5WEM3ZStDNDhVNFcwZi9SMk9NV2l6UTZS?=
 =?utf-8?B?bG1NVFAwUTk5bVJOY3VOanVSTFJoN1JGWWxpNXc5ZU4yOHU5KzdkZWJZMHVC?=
 =?utf-8?B?MktpQ3NaQStmYWt2N3QwejA5QWQ2NXBUSW5uVzlEQldteVVOWVhLbmpGMUZn?=
 =?utf-8?B?MDBrNjNPc1A0RmM4L2JaVm9wV3ZyeThZQ1BzQXZYcmdEVGpCMERGUmpNQk1t?=
 =?utf-8?B?TENCUTVuUXNQWHprQ09BcWowd0JPM2hzK2pyOExCeFlmcXY0YXEzNXdoT0ZF?=
 =?utf-8?B?ejJYaktLTHN6K0tkcDFCeGxQZGRhaW1RVEZlZEh6WjRkNnpyM1BkQTBjYVZN?=
 =?utf-8?B?MXBxWUVrY1hPSm02NkxkNTJvRXh4NThuWHNlN3Fhblpqd2RnNmh6TEtka1V4?=
 =?utf-8?B?VFF4QzBtSUNuS3I4dXF6VDlkWUVSU1VkczFNNnROY25TMVNWU3ZmcUhwck5D?=
 =?utf-8?B?aFg4VTRaeFNGWGxnODRxZm1FOENoYWVabGdqQWFwK0tvMlcxZWJLSkJzOFQ2?=
 =?utf-8?B?dWJUMG90TGU1RXB0M2cwTWlCVE5VbFdkRlZHaW9uTDJWRG93Yk1CVko2UHJN?=
 =?utf-8?B?UTFGQzFrS0pGeSsvb3p4UVE4ZHlGRVRmYXBOMkZ1SXI5a1lqaDZULytsQmFn?=
 =?utf-8?B?RmttN2wxSUg4MUY0aTBsMnJQanZxWW84MDlNcGVHbTQyWkFSNW8yRjFwdGoy?=
 =?utf-8?B?ajZQMnVJT0VkM2Y4aWFGTzdKOVF0WGtSV1pSbEIxMjJaOFZRMXR2bXJmc1dk?=
 =?utf-8?B?M1l6bEltOTdBRHV2a2JhN3Fkby9PUFBaNjdvNFp2ZFFMdlNWZmRoZlhUVmZE?=
 =?utf-8?B?WHJBMVNTdXp2WkRHeW55REtNZGtlU1RSTWxYQTVNZzNlQW9wYnIyc2txdlp0?=
 =?utf-8?B?UWdyc3kxNWdqSmZ1aWliTHZIVU1WOVJWWjl3Y0lVQlIxWEU4MEtPNHRhdkJK?=
 =?utf-8?B?dStmbWJuUVl4ZTJHbi9YZ21LTHllVWJUMXV6VVZDZkhkc3Y5WDEzNHM0cnVa?=
 =?utf-8?B?TzFQZCs4R3lqbmdzbDdUK001VVVySERxeTNaZTdGWUhnVVFrbFkyR215QWh5?=
 =?utf-8?B?ZXhYWEdxVGtVYUE5TVZialo1WHRJZ2lVOUFoWEIyaXVnRGdEVmVDSkF2aUxH?=
 =?utf-8?B?QlVkek5PcTJWZmlSSmNadjZseFJiSFVmVTUya3gxT0NWdHduMWsreDlweDZZ?=
 =?utf-8?B?OWp4N0Z2OTV2MWVUa0x1VXlhWnlITm14bGJUQkdBbFlldFlYTU9vcnUxZC9r?=
 =?utf-8?B?dmNzM1NKZGpaZFYzalZLWWxhZWpxbFpTTFNza01Uak4wWEZsbHpWSVVCK2xT?=
 =?utf-8?B?eDE0cnpNOXlya01ORDkzTm9jNGFhNWV3aXl0dGt5M0U2ZEFEOG9OSWRBMGJw?=
 =?utf-8?B?ai8zWWVXSkE3bGtqRXM5dnI0KzRLbGNqMDJHQ2dtbjVtV29wd01BZzQxMkNT?=
 =?utf-8?B?ZllDc3hXWUpnMUNQbzBIZEhSeFZMS09td2xPcm9hQjFiemI0UGJ1QnhUKzNn?=
 =?utf-8?B?Tkt6MUg0L3Z0YjhEQ1ZCSmNTc3RaRFpxTXBycjM4UFlCK2JVWEsydmxYMmx5?=
 =?utf-8?B?L2g5RjBVdFRIU3dta3ZvUWZzMmROd2l3TWVSdm5CZzVHRDFJS0NiSmFwc2R3?=
 =?utf-8?B?b1ZkTmtBZjVJQzdEUDFoYi9YY3BhME1MMmZacUYxKzlSSWdKOGVuNFc0OWJD?=
 =?utf-8?B?dFZ5NUJXaHprSlNaR3NFb1grNnIvQ3ExUXJqdGNXaGNiWFNrTTd1dDRVZFJN?=
 =?utf-8?B?YXZWVjdNaUIxZGp1YS93M0NMajI1WGpQbjUyMlk2Z3YwNEoyTk9oQzU5NldE?=
 =?utf-8?B?ZDJFNktiRWpOTTVSQXVvNytuY3dpNHM1ZjRTMEZUSmFIZHRZdDl2VzJhaGQy?=
 =?utf-8?B?amVJOWVlV3Yycm9URGVwc015SWI3TTdDcHFYN2htTmJYOUJ1ckFwcHJLV0pB?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60864CB237EF7245A75EEEB9DE5304E3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RIr7MkdtVP/184xEv9HJgsA/K3Z0Z5le9TdzDp35ppX13LBTmQrLO6fSIBZLqZXkE1O02tpNHF6M9cmX29tmi+a/bQ8E/3wtG+05KCGTCrHiltYn6iFQ8XnAhfX8ybw6Mnh3EBFrGr9/4s8ct/9fADJA1FbqQ+A5KFRoigfmNqQwAFcL1DROZFeCBRZ+u/eAhbNhmNi3EZ3vo67cFA5VLXIblIDXcAZj6BETiQ5o2BVZxrRiz6+tARtOZcyvSGKJUEsq9geyQ9R5jzeremP7i6caujsrz5G25WgUIQK5P++a/6XJnuyHxkHTCnMtTG+AwL+tV2g6AB/9/gZiCyspV9Dl9HFujfWYqygkyL3pBP9LyqWLSUGYw6re24zbB9o7W+/ecbTaP43AVGplgHInoW4R/R3Dbt/ZiGLgflkqJW6mPAhMrv9rDue5t9X5xCFR/4cHENBhqIh3sWHrHMJNeadXFjoKyvHr2p9K/ulpp6oVo7MvnVIoaOXQKHdOPPSHviql4kXxwhX2/CF5Up7HeoRn7YnwgeaRIEnM2e79A0lD5PTobRWvRvG6HO58NYSeBQ8mtCuGajk9iavdtvBxigjBXbRuacM4QMtSWbzc/Gk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4478.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4a4d6f-ab92-4934-d8f2-08dc451ab416
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 18:06:57.2262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6tx/JUqDg69oSAnJoMVCxDf2y5M9J6NQlm+jOfuw5b9y8CkPmiPr4ytWlNAjWPo4KCJwNsLQOAmQyOMhVvRHKUTqe+52sG3azs10Z2NTlzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4941
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_04,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403150148
X-Proofpoint-GUID: 2nYrualzFo7g2W8ztvgbL6QTQYY6ANWH
X-Proofpoint-ORIG-GUID: 2nYrualzFo7g2W8ztvgbL6QTQYY6ANWH

DQoNCj4gT24gTWFyIDE1LCAyMDI0LCBhdCAxMDozNuKAr0FNLCBUaG9tYXMgR2xlaXhuZXIgPHRn
bHhAbGludXRyb25peC5kZT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIE1hciAxNCAyMDI0IGF0IDE4
OjE0LCBBcnVuYSBSYW1ha3Jpc2huYSB3cm90ZToNCj4+PiBPbiBNYXIgMTQsIDIwMjQsIGF0IDEw
OjU04oCvQU0sIERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4+
IFRoZSBuZWVkIGZvciB0aGlzIG5ldyBmZWF0dXJlIGlzIGhpZ2hseSBkZXBlbmRlbnQgb24gdGhl
IHRocmVhdCBtb2RlbA0KPj4+IHRoYXQgaXQgc3VwcG9ydHMuICBJJ20gaGlnaGx5IGR1YmlvdXMg
dGhhdCB0aGVyZSdzIGEgdHJ1ZSBuZWVkIHRvDQo+Pj4gcHJvdGVjdCBhZ2FpbnN0IGFuIGF0dGFj
a2VyIHdpdGggYXJiaXRyYXJ5IHdyaXRlIGFjY2VzcyBpbiB0aGUgc2FtZQ0KPj4+IGFkZHJlc3Mg
c3BhY2UuICBXZSBuZWVkIHRvIGhhdmUgYSBsb3QgbW9yZSBpbmZvcm1hdGlvbiB0aGVyZS4NCj4+
IA0KPj4gSSB0aG91Z2h0IHRoZSBQS1JVIHZhbHVlIGJlaW5nIHJlc2V0IGluIHRoZSBzaWduYWwg
aGFuZGxlciB3YXMNCj4+IHN1cHBvc2VkIHRvIGJlIHRoZSBkZWZhdWx0IGJlaGF2aW9yLiBJbiB3
aGljaCBjYXNlLCB0aGlzIGlzIGEgYnVnLg0KPj4gDQo+PiAiU2lnbmFsIEhhbmRsZXIgQmVoYXZp
b3INCj4+IEVhY2ggdGltZSBhIHNpZ25hbCBoYW5kbGVyIGlzIGludm9rZWQgKGluY2x1ZGluZyBu
ZXN0ZWQgc2lnbmFscyksDQo+PiB0aGUgdGhyZWFkIGlzIHRlbXBvcmFyaWx5IGdpdmVuIGEgbmV3
LCBkZWZhdWx0IHNldCBvZiBwcm90ZWN0aW9uDQo+PiBrZXkgcmlnaHRzIHRoYXQgb3ZlcnJpZGUg
dGhlIHJpZ2h0cyBmcm9tIHRoZSBpbnRlcnJ1cHRlZCBjb250ZXh0LuKAnQ0KPj4gDQo+PiAoUmVm
OiBodHRwczovL21hbjcub3JnL2xpbnV4L21hbi1wYWdlcy9tYW43L3BrZXlzLjcuaHRtbCkNCj4+
IA0KPj4gSSdtIG5vdCB2ZXJ5IGZhbWlsaWFyIHdpdGggcHJvdGVjdGlvbiBrZXlzIChiZWZvcmUg
SSBzdGFydGVkIGxvb2tpbmcNCj4+IGludG8gdGhpcyBpc3N1ZSksIHNvIEkgYXBvbG9naXplIGZv
ciBtaXN1bmRlcnN0YW5kaW5nLg0KPj4gDQo+PiBmcHVfX2NsZWFyX3VzZXJfc3RhdGVzKCkgZG9l
cyByZXNldCBQS1JVLCBidXQgdGhhdCBoYXBwZW5zIG11Y2ggbGF0ZXINCj4+IGluIHRoZSBmbG93
LiBCZWZvcmUgdGhhdCwgdGhlIGtlcm5lbCB0cmllcyB0byBzYXZlIHJlZ2lzdGVycyBvbiB0byB0
aGUNCj4+IGFsdGVybmF0ZSBzaWduYWwgc3RhY2sgaW4gc2V0dXBfcnRfZnJhbWUoKSwgYW5kIHRo
YXQgZmFpbHMgaWYgdGhlDQo+PiBhcHBsaWNhdGlvbiBoYXMgZXhwbGljaXRseSBkaXNhYmxlZCBw
a2V5IDAgKGFuZCB0aGUgYWx0IHN0YWNrIGlzDQo+PiBwcm90ZWN0ZWQgYnkgcGtleSAwKS4gVGhp
cyBwYXRjaCBhdHRlbXB0cyB0byBtb3ZlIHRoYXQgcmVzZXQgYSBsaXR0bGUNCj4+IGVhcmxpZXIg
aW4gdGhlIGZsb3csIHNvIHRoYXQgc2V0dXBfcnRfZnJhbWUoKSBjYW4gc3VjY2VlZC4NCj4+IA0K
Pj4+IEkgaGF2ZW4ndCBldmVuIG1vcmUgdGhhbiBnbGFuY2VkIGF0IHRoZSBjb2RlLiAgSXQgbG9v
a3MgcHJldHR5DQo+Pj4gdW5zcGVha2FibHkgdWdseSBldmVuIGF0IGEgZ2xhbmNlLg0KPj4gDQo+
PiBJIGFncmVlIHdpdGggeW91IC0gbm8gYXJndW1lbnQgdGhlcmUuDQo+IA0KPiBJdCdzIGEgaG9y
cmlibGUgaGFjay4NCj4gDQo+PiBCdXQgSeKAmW0gbm90IHN1cmUgdGhlcmUgaXMgYSDigJxjbGVh
buKAnSB3YXkgdG8gZG8gdGhpcy4gSWYgdGhlcmUgaXMsIEnigJltDQo+PiBoYXBweSB0byByZWRv
IHRoZSBwYXRjaC4NCj4gDQo+IElmIGl0IHR1cm5zIG91dCB0byBiZSByZXF1aXJlZCwgZGVzaXJl
ZCB3aGF0ZXZlciB0aGVuIHRoZSBvYnZpb3VzIGNsZWFuDQo+IHNvbHV0aW9uIGlzIHRvIGhhbmQg
dGhlIFBLUlUgdmFsdWUgZG93bjoNCj4gDQo+ICAgICAgICAgc2V0dXBfcnRfZnJhbWUoKQ0KPiAg
ICAgICAgICAgeHh4X3NldHVwX3J0X2ZyYW1lKCkNCj4gICAgICAgICAgICAgZ2V0X3NpZ2ZyYW1l
KCkNCj4gICAgICAgICAgICAgICBjb3B5X2Zwc3RhdGVfdG9fc2lnZnJhbWUoKQ0KPiANCj4gY29w
eV9mcHN0YXRlX3RvX3NpZ2ZyYW1lKCkgaGFzIHRoZSB1c2VyIGZwc3RhdGUgcG9pbnRlciBhbHJl
YWR5IHNvIG5vbmUNCj4gb2YgdGhlIF9fdXBkYXRlX3BrcnVfaW5fc2lnZnJhbWUoKSBtb25zdHJv
c2l0aWVzIGFyZSByZXF1aXJlZC4gTm8/DQo+IA0KDQpJ4oCZbSBub3Qgc3VyZSBJIGZ1bGx5IHVu
ZGVyc3RhbmQuDQoNCkFyZSB5b3Ugc3VnZ2VzdGluZyBtb2RpZnlpbmcgYWxsIHRoZXNlIGZ1bmN0
aW9ucyBkb3duIHRoZSBjaGFpbiBmcm9tIGhhbmRsZV9zaWduYWwoKSB0byB0YWtlIGluIGFuIGFk
ZGl0aW9uYWwgcGFyYW1ldGVyPyBXb3VsZG7igJl0IHRoYXQgYnJlYWsga0FCST8NCg0KSW4gdGhp
cyBhcHByb2FjaCB0b28sIHRoZSBzbmlwcGV0IHdoZXJlIHRoZSB2YWx1ZSBpcyBtb2RpZmllZCBv
biB0aGUgc2lnZnJhbWUgYWZ0ZXIgeHNhdmUgd2lsbCByZW1haW4gdW5jaGFuZ2VkLCBiZWNhdXNl
IHdlIG5lZWQgdGhlIHZhbHVlIGJlZm9yZSB4c2F2ZSB0byBtYXRjaCB0aGUgcmVnaXN0ZXIgY29u
dGVudHMuDQoNCkkgZ3Vlc3Mgd2hhdCBJ4oCZbSBzYXlpbmcgaXMsIHRoaXMgYml0IHdpbGwgcmVt
YWluIHVuY2hhbmdlZCAtIGl0IHdvdWxkIGp1c3QgYmUgaW52b2tlZCBmcm9tIGNvcHlfZnBzdGF0
ZV90b19zaWdmcmFtZSgpIGluc3RlYWQgb2YgaGFuZGxlX3NpZ25hbCgpLg0KDQogICAgICAgIHBr
ID0gZ2V0X3hzYXZlX3N0YW5kYXJkX2FkZHIoKHN0cnVjdCB4cmVnc19zdGF0ZSBfX3VzZXIgKikg
YnVmLA0KICAgICAgICAgICAgICAgICAgICAgICAgWEZFQVRVUkVfUEtSVSk7DQogICAgICAgIGlm
ICghcGsgfHwgIXVzZXJfd3JpdGVfYWNjZXNzX2JlZ2luKChzdHJ1Y3QgeHJlZ3Nfc3RhdGUgX191
c2VyICopIGJ1ZiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKHN0cnVj
dCB4cmVnc19zdGF0ZSkpKQ0KICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KICAgICAgICB1bnNh
ZmVfcHV0X3VzZXIobmV3X3BrcnUsICh1bnNpZ25lZCBpbnQgX191c2VyICopIHBrLCB1YWNjZXNz
X2VuZCk7DQoNClJpZ2h0Pw0KDQpJZiBJ4oCZdmUgbWlzdW5kZXJzdG9vZCBzb21ldGhpbmcsIEkg
YXBvbG9naXplLiBJZiB0aGVyZeKAmXMgYSB3YXkgdG8gZG8gdGhpcyB3aXRob3V0IG92ZXJ3cml0
aW5nIFBLUlUgb24gdGhlIHNpZ2ZyYW1lIGFmdGVyIHhzYXZlLCBJJ2QgbGlrZSB0byB1bmRlcnN0
YW5kIHRoYXQgZmxvdy4gSSdkIGJlIGhhcHB5IHRvIHJlZG8gaXQgYW5kIHNlbmQgb3V0IGEgdjIu
DQoNClRoYW5rcywNCkFydW5hDQoNCj4gVGhhbmtzLA0KPiANCj4gICAgICAgIHRnbHgNCg0K

