Return-Path: <linux-kernel+bounces-164551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A078B7F36
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E681C22D63
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E19181B85;
	Tue, 30 Apr 2024 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a3UZmAaK"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D838D171671;
	Tue, 30 Apr 2024 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499302; cv=fail; b=K7UdpMEGqXe3GSUcdohQtLY5D31wc2BhkiqSc1ylJ7Z/Y4nfyc4/aELgOVz5ygrHZKE2CORaKnE52nqGOxs946nyduop4CZSPMzaIbVbc1TmrsZOuUOxXXW4tnALFZlg08iGa06ATZapceSpQkqmA/OfaJ2Bv09qmr+F8+PuNnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499302; c=relaxed/simple;
	bh=lH6C7fpuYv9vBEWstmsJyil2/FJ7ddMUmk5MT96KxDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TIMHHlxObdJNF2mfl/M5Ccf9IzBJx1P+ZB2VDY6lwGFk+Wi5oi4eEqzWBhCltL/cwxYytTU8fi+6hy2/J111NxMD8Oq2WZw3XRdsubAPvA4af3eqtgLU2feKgVx0L/vRwKLb+YiPg4TFmaCJNhMsmS5K2MLUW42NBWrpuSGoCyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a3UZmAaK; arc=fail smtp.client-ip=40.107.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcCqyp3Z5D3pOmej/oBhTCDaUOUGE01UjJ5rAeaDK2j7RiMFqTkpaJgs7axWhmYe4CUEzDPZ3JQ1GyZRG6wJCQv9FuxLoZqtOHcLtVKDTcdm9WqCAthtRbeVMfGXiib1qbT9cyvugflxy9cDpgZRj+Wp+Xxbms1pQ5WKyKL9i1EYruXUeGexgl4e+aDkhWiYDAH0cRUBxmwc6WJ+QYA5RDBh6hzi/YNVyM/xuoqsBswGpvq4Sqm8lgqJBGycAgwKzqb6JXUO5emaWOPCA4i9avcdkSE9oV0uoiKv24dr7iYdY+/11LIeFk77dSrlicvFYqFEPTRb/dM0fbnKQ4A93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lH6C7fpuYv9vBEWstmsJyil2/FJ7ddMUmk5MT96KxDY=;
 b=IvJaWDBZj7MiaCrPsDjWai0w1u7QAkJk5YBKGlbYYzEIlKufjAFH3dJBFkNdXzVEVk7uyXZMnmmgYmSJtn+3aXFUQZEclHEIVxVL4YpOHp2C786mitbm4z2gCQ0sqNBa5+Y+odW6ULOqlgaBHSW3RLbdHdOJmWEjaTKZBpyZFnezihB8fPcvqs+4MXTWMMu6F1+bnypoVkxBQsAYZ84BpDh1Vc2H5Hw/OTDnf6XW4jYJ2gP9KfA77OaT7OjxrgeYOBNGqB9vzv5MV4+rhJtyy+PSNm3lWEnXQssFpdVL0p/Pr/CUdhFCFDI5Dr7pDQwPDd+oE8z0K8unvQpjYihlqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lH6C7fpuYv9vBEWstmsJyil2/FJ7ddMUmk5MT96KxDY=;
 b=a3UZmAaKpMVY+rhleRCmWC8zaBem1XZCTPNckqrdusI/05q9ixmpoeELc7DlH7JDTO2qmAtB/sYNcLOX+lcCTQFERcMqW1Racp48+6NSfJa59hiv4jvZzuYnmBaxGzdjRzzSX7wkxKKRHChT5t/oz4joMLMi4F8yf4bxsGwrrG8KWVT55k1KYePF9cdFtDJFI5o2p3tnowRgGgmCi3PxvZW2bCrY3hAw36O0vWGBcDOi5VSSwjK/XFGrr5ugeofgfcP+czvncVJ1ZxErrz/r4GTqaiJwxXMUIh6Ip5nfApwtzkpjA3enSSt7/07qTp2+Q7fS1DBEzo4L0FjmDhGpBA==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 17:48:17 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 17:48:17 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "sdf@google.com"
	<sdf@google.com>, "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, mlxsw
	<mlxsw@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: RE: [PATCH net-next v5 10/10] ethtool: Veto some operations during
 firmware flashing process
Thread-Topic: [PATCH net-next v5 10/10] ethtool: Veto some operations during
 firmware flashing process
Thread-Index: AQHalkvLXS2a/tKk1kuzvzfl2xOLCLGALvWAgADwpXA=
Date: Tue, 30 Apr 2024 17:48:17 +0000
Message-ID:
 <DM6PR12MB45166623E27B6A3A972DAF70D81A2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240424133023.4150624-1-danieller@nvidia.com>
	<20240424133023.4150624-11-danieller@nvidia.com>
 <20240429202331.29f3dafa@kernel.org>
In-Reply-To: <20240429202331.29f3dafa@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|IA1PR12MB8554:EE_
x-ms-office365-filtering-correlation-id: 4ff67ce0-6edc-401c-fb68-08dc693db7a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFhMTlFuWUM0UkduK2hxRWF3NHJZM2EyQ2ZnMW1vTmNsWWdYVit5dk5DK2FE?=
 =?utf-8?B?RWRNS0t3L01YSzViaExUVy9IdUIvM21mNm0xQmttM2dFMUVWMzNiQU5WalBT?=
 =?utf-8?B?QjhOOGd3UGtJRnRQVmlUZFNZdm00Mmx6WjhKOGVxZHRSQmJaczRkd2xHV1Mr?=
 =?utf-8?B?Z28xYUJHL242K3VUS0x4WnY1SFNpQ1FOSktIZ0J1NURRWDFrbkhuS2RweGlj?=
 =?utf-8?B?b2M1d0pJa2VhT0VoNTJrWmxMQW9KYXgyVDA4emlFWnNaa3BsaFdkWFBSYUw4?=
 =?utf-8?B?OG5QMXppTC9XelIrOHpWUzNDeUUxQWRCOGxXcktUSjl0SDFNVDNHRDVXTmYv?=
 =?utf-8?B?Q2toNk41QjZPd0t0eVB6aGpFalZqY2ZMS3dCd3Y3RERmTXJBcU0rV2FuMjRz?=
 =?utf-8?B?WXlFR2xjY0VFQmZ1UXBSWE1JSTd6Z0F1NVFRTi9sdkN2endTWjVMSDUzNFB3?=
 =?utf-8?B?NitBTG80TThaYjNmMExTUGlRVzZYTWI4VXE3MmREMTdwVjJGSUVIbWdTcWJT?=
 =?utf-8?B?dXBnQzFvQzBnNlRScDNHRUt4STdkRFJ2ZXpyaXlhRzg3eDQyRkU4eE5taXR2?=
 =?utf-8?B?MUVsTVh6YXRyMndRRFMvMTZjeDVFUExNRWNLZkVKSEdmdzEwVXBpamdMZDZo?=
 =?utf-8?B?L2pIUXhsSUFIZnoydTVwdFR0OUdkM2ZHTWplcjhvUzlvUzloVDR1ckdJemNU?=
 =?utf-8?B?cDNtNkxSWEZQUFFYeDdlZzZibUtodTEySUViblNLYUM0dDlXaVhGdXBXeEd0?=
 =?utf-8?B?QlFkYXArSFBqYzZ4YWJGQmdPanNYc2pxdkZOYVV4bFRTMGZUdTBzb2RmYUhJ?=
 =?utf-8?B?UDBCa1pRMit3VjJuVjdlS2FCRW9HS21QTU45cG1CNHZCd1VweUVKa1RyNHNW?=
 =?utf-8?B?TDNHVHdlRXVMU0xqRXJNaFAyaS9nNUNlclJSWVBGcWN0ek1nVE0zMTk1eDhw?=
 =?utf-8?B?WFptY2VQekpkeVVYbUdvVzdkWm5oK3Ywdi9zOUlLUEovSGt1Z3hkWGtmNWda?=
 =?utf-8?B?TW0xVytITmRJQ1NSeFVpTjFsa2tOZm42a0g4eS9CekI2V3dUREtxT3VwQjNI?=
 =?utf-8?B?VStIdDEzNWMvM2hLKzJ3cGVPRHA1MUtEQmY1TS9WbWRKcFNGcTZNeUNkdzM2?=
 =?utf-8?B?WnRpUHdZOUhMMW1rNXRkbVd5MnZrTlZDTVZJQmFLZ0JEc2Nrc21DVDI4eTZk?=
 =?utf-8?B?Q3h2UC9XeS9QMm96NG5YZ0NHaXg1bllmOGV4RGttZzdoVVFRQzJmbEJSVDRR?=
 =?utf-8?B?V2hrdXMrOFlEd2czYmlrMnNsWk1Qak5vOFY5em1yaXFoN1NiTmFhcnVJZmtk?=
 =?utf-8?B?U1F1QXZHTjhFd0FvbTM0cVd2VWp3eDBqczgvWlMzUFd3Sks2dGRMNVpyTFBZ?=
 =?utf-8?B?NUxhMWlOd25QNGR2MEZxSnFBOVFDdkNxVnMvUldrdTQ0TXNab2hxY1FKVHFl?=
 =?utf-8?B?N2NNWGR5WEZMRitMK2JnQk9McTAyZXdHejVPajJSaExoZGk3M0tJc0JCTWNp?=
 =?utf-8?B?L2Y1ZEhUWTNoZGEwNFRySngraXFhdEd1eUhqR0JwTmtiN2F3TlZqYytQWWFG?=
 =?utf-8?B?UTVJa3gwWnM2d0ZwaTZmdWZhZFF0aUlFeXJmcklubnhodk5PdTNnMklONXZ6?=
 =?utf-8?B?SEgySXJyYlJ5Q0ZsMFROSmFQbVRUeCtacTUvNFRsWTBXSng2QVRLMnc5VGov?=
 =?utf-8?B?Q3F3MDRkaVNsa3RYMlpyT1h5OFltK0REWTlhTnpnOGMyWkFYNlFuaXZ5VmJv?=
 =?utf-8?B?aDY3b3VoV1U4Y25GZXhRWHBkOGFqankyckp0dVl1SWw4dDJ4U1F4a1NkYVpE?=
 =?utf-8?B?ZWIrQVJDc0xjejFpekdudz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkoySGx6S29kcDJmMVJNVnQ5SWd2VGt3Z2dtM0JIb0dZdlMrTm5pd1lDcG5M?=
 =?utf-8?B?QUt4ZkZXNUNhcklqdXpsOU9LTy82TkFUMHcvNFlrU1V6OUlHUTFiWng1K2hG?=
 =?utf-8?B?QmYvOUNTWWlYQ0FpOElHMkFiRThVTXpJSDhidi9jeDVJOXpzTlkwMlRVNTQv?=
 =?utf-8?B?R05hV2tIWEhPd3hUcHVlYVFnSHBmeHhoUVc0MVpvRDgvS0FaN0pna0RTQjhP?=
 =?utf-8?B?R1ZtMi9aNWt6QnhibE5EbGlHZDdxV0pDNjExQ2diSVB5b0IyRFIzVnVTUE02?=
 =?utf-8?B?R3hUcGw4b1ljTG9UbFJ0bmN1UERIcWhwQWZlTUVabStBc0UvQjAvVFc3azg3?=
 =?utf-8?B?V1lUOTI5bUJ3TzBYaUwrWkNqWEdOTklzcGQ4RnFHYXc2b2ZzN25MWHlrWm1s?=
 =?utf-8?B?dU10YXJUMnpaRXE4V2ZGZ29Tc0Z0LzdQblE4bWRwanlxSlR5b1dsUVR1UEs1?=
 =?utf-8?B?bW1HdWFoMFhjbUM4QmlSSkp1NUlJekszTFFZbjJpa3ZPa0ZmcjRyd3hhKzdj?=
 =?utf-8?B?MmJXa2dvbitpd050Z1J5U1Fjd21Bd0xvM0JWcEFOMFZRZ2QvUjVOcWNEZ1I3?=
 =?utf-8?B?QnQzU25HVExpU24wZmE2cElhV1VPTHVtQnl6ZWl5Skp6N0VDOUdGSUg5bnhU?=
 =?utf-8?B?bEpSM3Nqb2ErYXhzMytYRGVwVWg0dEZXOXF6R1RneUNvVkJqRXZyS1N5dFlw?=
 =?utf-8?B?eEhBK3E1R0dMTDVucjNHWGdVRlo4VEU2dE0vemphbjZ6WTh0bEozQ1IzUWl2?=
 =?utf-8?B?YVlVU2pxNUJvRnZTZXRlVXZrNHEwbjFuVlJIdlp6b3J6ZGxRY081eEhySjdk?=
 =?utf-8?B?MWNiMFVsRmg3cTJFWGZaNnNiTUpRN1dDL2NRWUxDQ0VMdGJMaFZjOGE3Zk81?=
 =?utf-8?B?bWR4SFg2VW9QN2tISWRTV00xeVp1Qmd1QUpoYTNJc3VHdHQySWtCcnpEcjk0?=
 =?utf-8?B?UEo3eGpTVUtEazE2eFNEQXQvSmRsWVZGdkRINVZqc3ZTQ1VpNWZZUHoreC9m?=
 =?utf-8?B?V3pwTEd4d1c0Tk1KZDBwNjZ0YXVaOVJ6VW9ydTFpRW9CYklKemN5S0tNb0V0?=
 =?utf-8?B?Y2QzbDNSSXFmcTNVa0hQQVFCNUhjYzhTUXVQdGJNY2ZZTnlFaW5XcVlZVkQ2?=
 =?utf-8?B?dFp0UmlSd05vWGkwQXlLTnNsU2dvcG9JdU44by95NzIzRUo5ZFYrUTZaOXU0?=
 =?utf-8?B?R3BsT0Y4bG5xNUhjdVNFemJrNFVCWGV0VXdYOWRrb0lhTCszZ29Jb1EzWExB?=
 =?utf-8?B?SHBaN2ljelB5UXUrOW5vc2E3QVp2Tk1OS3VEcGdXcXNPMGlPamRHMExwcEp0?=
 =?utf-8?B?Z0V2ZWdOTVZXYmZrZllreXgrODk4WloyYUhEU1h4eStaZkVOZHhqY3htb1d2?=
 =?utf-8?B?enE4VXcxQURKeWM5NHZyZXFiNlg3MmRjLzQ2MXJ4R1B3YysyNGtrTGl0cFhl?=
 =?utf-8?B?ZHhEa3Z0eXJDM2dseHlHVjFERGRjTzQvUWh4czJyYXpsMEpMTEsxQ3BHYlRn?=
 =?utf-8?B?VGRmVi8weUdXRXltV0V0Z1VWdE1wOFBRWVB2ZWxTS00zQy9UY3VPeW83RWM3?=
 =?utf-8?B?NDJxNnZtWWUzajNITVRWSlptRTIwcXkwM1ZkSHRsWUZ0ektEWjJQd2Jqd0Ez?=
 =?utf-8?B?SXBSTEpyZy9mdHFSYXZzaU9XRU82Qm9vU0g5QTB4TjQ4eWd5bzByQXRjd3g0?=
 =?utf-8?B?MS9zRkF1RHJwaWFqdEJRQTU2b0J6UE8xeEgranNlYmVtY1NHSlYvU3hxd2dw?=
 =?utf-8?B?UnVhWWU4UTJHQmwvV250U3h0cnhCR2NrZlBoR2MwN1E5NHB4S1pTdnk1NGRZ?=
 =?utf-8?B?RER3NDJlaFRCRyt1S1FzUzdQSGFOVEk5YmRqd0hhL3ZKU2VPSGRHNTJxaTN1?=
 =?utf-8?B?RGY4RzZyQklVMEFqMjlEVGtqQjF3SGNheWIxUXNWcEQ2SzloTGlKbkpEVk5z?=
 =?utf-8?B?U2dzTGt2V1lXVGRYdXBLTFFnSlVNdkNwKzcvMTI4SXk2YTdZTDF5OUJ0SXhh?=
 =?utf-8?B?RTliL2lKUkczR1hUWWliY1lYMjRtQU1tQkMyM016bjZ5bDZSeEJmVzdUKzh6?=
 =?utf-8?B?ajdOK1RweGJtOFJqQXhzNUpNTTJLZldpQTVvck1CeFJBdlJ4QkZOSm5LM2dq?=
 =?utf-8?Q?g8HZL/QKMYy1vuB9TjI9G2lHm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff67ce0-6edc-401c-fb68-08dc693db7a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 17:48:17.4514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dOgUCXsh7k+lqIeNjsjta3YV8kMDKjQrQpcI2AMtI53dm7I6EvpTgOcSdWTGFBU00Zge7kzpJn3M1UbSvbbmzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8554

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCAzMCBBcHJpbCAyMDI0IDY6MjQNCj4gVG86
IERhbmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+DQo+IENjOiBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOw0K
PiBwYWJlbmlAcmVkaGF0LmNvbTsgY29yYmV0QGx3bi5uZXQ7IGxpbnV4QGFybWxpbnV4Lm9yZy51
azsNCj4gc2RmQGdvb2dsZS5jb207IGtvcnkubWFpbmNlbnRAYm9vdGxpbi5jb207DQo+IG1heGlt
ZS5jaGV2YWxsaWVyQGJvb3RsaW4uY29tOyB2bGFkaW1pci5vbHRlYW5AbnhwLmNvbTsNCj4gcHJ6
ZW15c2xhdy5raXRzemVsQGludGVsLmNvbTsgYWhtZWQuemFraUBpbnRlbC5jb207DQo+IHJpY2hh
cmRjb2NocmFuQGdtYWlsLmNvbTsgc2hheWFnckBhbWF6b24uY29tOw0KPiBwYXVsLmdyZWVud2Fs
dEBpbnRlbC5jb207IGppcmlAcmVzbnVsbGkudXM7IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBtbHhzdyA8bWx4c3dAbnZpZGlhLmNv
bT47IFBldHIgTWFjaGF0YQ0KPiA8cGV0cm1AbnZpZGlhLmNvbT47IElkbyBTY2hpbW1lbCA8aWRv
c2NoQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjUgMTAvMTBd
IGV0aHRvb2w6IFZldG8gc29tZSBvcGVyYXRpb25zIGR1cmluZw0KPiBmaXJtd2FyZSBmbGFzaGlu
ZyBwcm9jZXNzDQo+IA0KPiBPbiBXZWQsIDI0IEFwciAyMDI0IDE2OjMwOjIzICswMzAwIERhbmll
bGxlIFJhdHNvbiB3cm90ZToNCj4gPiBTb21lIG9wZXJhdGlvbnMgY2Fubm90IGJlIHBlcmZvcm1l
ZCBkdXJpbmcgdGhlIGZpcm13YXJlIGZsYXNoaW5nIHByb2Nlc3MuDQo+ID4NCj4gPiBGb3IgZXhh
bXBsZToNCj4gPg0KPiA+IC0gUG9ydCBtdXN0IGJlIGRvd24gZHVyaW5nIHRoZSB3aG9sZSBmbGFz
aGluZyBwcm9jZXNzIHRvIGF2b2lkIHBhY2tldCBsb3NzDQo+ID4gICB3aGlsZSBjb21taXR0aW5n
IHJlc2V0IGZvciBleGFtcGxlLg0KPiA+DQo+ID4gLSBXcml0aW5nIHRvIEVFUFJPTSBpbnRlcnJ1
cHRzIHRoZSBmbGFzaGluZyBwcm9jZXNzLCBzbyBvcGVyYXRpb25zIGxpa2UNCj4gPiAgIGV0aHRv
b2wgZHVtcCwgbW9kdWxlIHJlc2V0LCBnZXQgYW5kIHNldCBwb3dlciBtb2RlIHNob3VsZCBiZSB2
ZXRvZWQuDQo+ID4NCj4gPiAtIFNwbGl0IHBvcnQgZmlybXdhcmUgZmxhc2hpbmcgc2hvdWxkIGJl
IHZldG9lZC4NCj4gPg0KPiA+IC0gRmxhc2hpbmcgZmlybXdhcmUgb24gYSBkZXZpY2Ugd2hpY2gg
aXMgYWxyZWFkeSBpbiBhIGZsYXNoaW5nIHByb2Nlc3MNCj4gPiAgIHNob3VsZCBiZSBmb3JiaWRk
ZW4uDQo+ID4NCj4gPiBVc2UgdGhlICdtb2R1bGVfZndfZmxhc2hpbmdfaW5fcHJvZ3Jlc3MnIGZs
YWcgaW50cm9kdWNlZCBpbiBhIHByZXZpb3VzDQo+ID4gcGF0Y2ggdG8gdmV0byB0aG9zZSBvcGVy
YXRpb25zIGFuZCBwcmV2ZW50IGludGVycnVwdGlvbnMgd2hpbGUNCj4gPiBwcmVmb3JtaW5nIG1v
ZHVsZSBmaXJtd2FyZSBmbGFzaC4NCj4gDQo+IEZlZWxzIGEgbGl0dGxlIG91dCBvZiBvcmRlciB0
byBhZGQgdGhpcyBjaGVjayBhZnRlciB0aGUgZnVuY3Rpb25hbGl0eS4NCj4gSSdkIG1lcmdlIHRo
aXMgd2l0aCBwYXRjaCA1Lg0KDQpIaSBKYWt1YiwNCg0KU29tZSBvZiB0aGlzIGNvZGUgaXMgb25s
eSBwcmVzZW50ZWQgaW4gcGF0Y2ggOSwgc28gaXQgd2lsbCBjYXVzZSBzcGxpdHRpbmcgc29tZSBv
ZiB0aGUgdmV0b2VzIGluIHBhdGNoIDUgYW5kIHNvbWUgb2YgaXQgd2hlcmUgdGhlIGNvZGUgYXJv
dW5kIGlzIHByZXNlbnRlZC4NCkRvZXMgaXQgc291bmQgcmVhc29uYWJsZSB0byB5b3U/DQoNClRo
YW5rcywNCkRhbmllbGxlDQo=

