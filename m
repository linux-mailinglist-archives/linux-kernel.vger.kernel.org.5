Return-Path: <linux-kernel+bounces-82410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5418683D3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B57F8B22D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473ED1350F0;
	Mon, 26 Feb 2024 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="n8oI9HdY";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DPus8u0t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TdT0hU6N"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7094F133436;
	Mon, 26 Feb 2024 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987018; cv=fail; b=OgZLgz+ijTAv2/GAz87QJMcjWl3t9FUnEPZVgZ5KZYtjXfc2HskBQ7IAaNGuHHdIlbO86iQV2yphe5IdVs26GymAkMvhf1XtUpXdcYMeBEUvsXl+HuZwsdHoeEkTBy/JMIb3kQkiyLD3p3PKpSIlMekc61tH60xnvhksHiWFfxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987018; c=relaxed/simple;
	bh=s8SbktsNg8AZvoGisyS/NVbkz1Hd3ObePpVDm6TDaS8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GOaXI3mWjLQQtra60axjv0O/ZbfvB1mwJk6icV33k6njWNNXmNHi4L332OBK48aDrMWi41hodVUj0DhmmvJVk0mpEgDYCrazXgVi0uuNYDRWOL+4Aw9WAal47J15uTXiQ3SVb5kSSG1Rp5auMqSwz7Nb61p1/mHUgic+Hp1E0as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=n8oI9HdY; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=DPus8u0t; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TdT0hU6N reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QGns8a016612;
	Mon, 26 Feb 2024 14:36:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=s8SbktsNg8AZvoGisyS/NVbkz1Hd3ObePpVDm6TDaS8=; b=
	n8oI9HdYW4yXFVHziU7edobxVW++RXDZSCES6+gDRWFQAPgM0ewyVl0TWTyKdyLa
	RyP9hr3xgbRK86fjIvVRHqD7YefXoMmR/hBpmcyV3Vtr38UvtKs4abHJjd88hnNI
	pS1mYt4LGzbSt+UEtuo0bC7P2CexOBUjyPROgdakxhFJGhRsfaNU3o3gq4on4dAw
	FETRe4nBFAIWVVsgiNMgWUT5KAsmxebpgJKrWyyTBwJ202mWKd8j1tYvL9qUG844
	GrYFfoy0OqnkCxuaUom3oBVjKKm0qYDgZK2nb32lQOkV6BPl0NLZhq0TCWJX/Vd8
	1/khIWnvGP3ABPtpCQsu+g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3wfgk77xyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 14:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708987009; bh=s8SbktsNg8AZvoGisyS/NVbkz1Hd3ObePpVDm6TDaS8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=DPus8u0tAjap7T0NG/eTzoHDMdjt+e72itDih10C2n7d7CE78xTkxpYFZNlF2Ae9O
	 65My/aFUA6D/1E1pU0vRi3QpVNwS8NE139dGTcUu1RhmIV2AXnM6By5b2FUIAGomF7
	 M0JTa2MgQJtX1n7qnypKys4iBj7iufL1GmQ477DDI2bmfg8G1VWWi/vYDBo6H3GBmO
	 2XhMnLrP3OUXYGNx/9wymetpFqbkW+M/2/VsLv+/XUYo8wyYKua/jj8759fLKYM8M8
	 fAXmM2nrr9bUn4j8bVilioJ2msQTS8iKCzwdhgXsFYsTmXYSA9766aDYdLahIlHeVI
	 65xT8hsZ1nSVA==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 70D8B4035E;
	Mon, 26 Feb 2024 22:36:49 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 37A93A0081;
	Mon, 26 Feb 2024 22:36:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=TdT0hU6N;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5B2C640347;
	Mon, 26 Feb 2024 22:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkvuUadTcr7owl7Ld1hnNnonh4pBz1LLsv5/NqFCsGS+90P3kD8LBWnZMtWiPwQSi/RNFtTy7hMMfwRMonPt3CqJW9IcUrR+Ztc8arKRGkeEzKQx6CDHCxcOB4Yvn0uMAhV4Ncc6HwvCeGo0VYfsIz6Hl7yYnXJ1OOCj9NYLS0Fg3NZ0/vlKrw4PpS8NTodwkxtDfkSKT/nP6oNzqo7XxlQ+lZjXeYa+n69Hf7QRRtPT0up02ctTCIkfYlYSfRM0gKD6QLrrQHOFiJtwmItb6pL0M+Lwr0ZOyawjXoJNIZyki2TkGBUM1XN/B3DNTZm4k5YeBS861czCpwjdlznAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8SbktsNg8AZvoGisyS/NVbkz1Hd3ObePpVDm6TDaS8=;
 b=JZQ9P0p8aFbnHUv+DmoQr0MDozlm4LtdKitD/xmQ5vtFf+eUV4lwMyl5DTjL+BaXwt18y8KXGdMaWCUXsiAnmFui5ElOke/S0cBOAYOanh5kg/1nSE4xnrlw6wNJbq+stpRnF9uEyNqdoWqg0bVICB97NV9LYCUtNV3Ep8RdyFoVPsKQLUDv6YrUOqW+f/lT5IT/Oh/OLwaxemUKbLxPa3bunmIqw+scUThFGq3u7VIxD56eqVus6JQ1lw2BmKRSqTgvaXDfi0/TnePyu5a10saaOr3DCLsSr3VQh/WEYu8bJM+mMfachIf3o7wsCvDkmd35UmhLkrML6Dl8TGbB+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8SbktsNg8AZvoGisyS/NVbkz1Hd3ObePpVDm6TDaS8=;
 b=TdT0hU6N9QaEIgFKBYZ2RAsu2NqD3i5brmL2fXYAw41whUHbI3thaccBIZMVL27pZLzUH89MBf3W1MmRdOmFG11ZSuj3HVC1CsI5OBgavGMDyXILb6yzX7OzMJsKrahOCsb9Tw7VpUdMo7sRsuoXF0OTHarI4QgeN9ptxFLBIqc=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CO6PR12MB5428.namprd12.prod.outlook.com (2603:10b6:5:35c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 22:36:46 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7316.035; Mon, 26 Feb 2024
 22:36:45 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Michael Trimarchi <michael@amarulasolutions.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amarula@amarulasolutions.com" <linux-amarula@amarulasolutions.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH V3] usb: dwc3: gadget: Fix suspend/resume warning when
 no-gadget is connected
Thread-Topic: [PATCH V3] usb: dwc3: gadget: Fix suspend/resume warning when
 no-gadget is connected
Thread-Index: AQHaaJtUAB4+UBk7kkGmrPnXYIiNfbEdN1SA
Date: Mon, 26 Feb 2024 22:36:45 +0000
Message-ID: <20240226223643.pay4tb66j3q44cuk@synopsys.com>
References: <20240226100502.1845284-1-michael@amarulasolutions.com>
In-Reply-To: <20240226100502.1845284-1-michael@amarulasolutions.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CO6PR12MB5428:EE_
x-ms-office365-filtering-correlation-id: f28d6b29-6a70-4796-99ab-08dc371b699f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mat4KP+peDCIjOywI3w/5n1trUrLJChfW8tlV3eHWG8723hlwtsUJ9JXzaFLzD32RyLaYGNMqR6m3rKV3o9JRlaUF3asYvzbR5ZfyeDtJTjGXjcqB5HlE00kr2plFKrd1Vqgzf1CPu/MHL0PgLd0guROu6IbALbbZKUefQeJ0L2IlOUnKry8WweabGK3SgOu6P4MvZ5Z7/flE71M71dLQCynsHmuhBpYwjDslkhMlrK0rp+sr9c9tQ4M6e8u89IFfnwm+2S0u0BXyokFbXU133jyKUTMOgRpSXJaJASWrqlljxSHwqJfgtbkZ60Ds57ex49Jz5R4Tc5f6AA8gWDLUXjVlZIO6YQx0f873uU26mrf9MD+vEee5kVumlW847+R3J1HrrPILzJHOJyKM1+Y6ucF8xu7p+Atq2J+z29h0kdG3R0XPkwX15JHaXucOAFX0fj0ukMtYCuTTF5Zmeh2Rt1fVqRcYt/pHkrosEN1V//oFq2zH2+WwNTONBG3/kOpDWHBAl91OZez2fmnQYmz5Fv9xnQ2oCtIbOgMgVzJyK7ewkOPUEAXspbq/VbD/DYgsfy6FFFBXA06gN5/Glu2HyQ3q3EOIULjWp7omM8NuPHIQht+CPqBf0lXCKPVW/GovItPmlgXRdNrmT06gF9mOc+Ih1VUZ58iEualRCw01dhMR1CHopfOMs6XRFdG6IIF4mqjiUqVSQBe1pEWvkWY6g==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MEZ0SkJFdVFzS0s0aGVuRmlTMTEyWVNPY1dEQTFobVNib3BpRmdmc2dKVXpN?=
 =?utf-8?B?NWEzSmU4S25OZXpBNGwrZ2xRTjBNeGtoSjhFdTJ4VmpSQnpJVXRaaWNOQkxx?=
 =?utf-8?B?VkkxVkwyMWM3STVVUzR2cnpqbHBvSGtFVno0UU9QMVNHMXRDeFE5ME8rS2wv?=
 =?utf-8?B?UjZVakFGZGoySTU3cmhWZkE4VlJWa1dDczlSUHBnQUsyNmlzVWNidC9wdC9Q?=
 =?utf-8?B?N3p6OHI0VytRbm5YcXB6Ymx6WmdXU0dQS0t6QmFoNkZKTmdnYUlYRDdrSVNh?=
 =?utf-8?B?YzRDYjl0SmRCMEFsSGFOd2E0b0wzUEFTYUV4a3JjTEp6WWV3eWFobFVvUnFF?=
 =?utf-8?B?OG9NS0phTXY2OStkc0ZFMFMvWk5JSjZvdE9YaFovbDFYb0lQSXlpZ1lXVUVk?=
 =?utf-8?B?dFZyWXBlQitEM3lTZzg0ZFN6Ujc4bXdadklBTzdRUWsxcEJtVWhXaUxaeG1u?=
 =?utf-8?B?cGFQeDJBMFJsMi9UY2szT3ZTM3Btb3JML28zYWFlYUdHT0tLc1V5c3R1dEF5?=
 =?utf-8?B?R251YTN4RWJRY1lGR1N6K1NKalRzb1ZnRXhpbFF1Q0IxSmFqUmQvUW4yNHlR?=
 =?utf-8?B?Z1RxN3Q2NzZzbTZYTy9JQzc5OHh1RVZ0Z29SZ0JEZXZHdStmTGNkdThVOXlu?=
 =?utf-8?B?SlZ2Q0pLbEd6YnNmT2hXcVMzeTQ1VHdKWmR2UjhQT3d2R2JINDNWS096SzhK?=
 =?utf-8?B?Nnp0NHV5cXErRHpCR0s3eDE5TXZOelBOVzFRUW1oZmdCc1RtVDhaUkMzdUF1?=
 =?utf-8?B?YXorYWZvMU1MeXNTVzR3Z2dROXV5bFhnZnFmdWJyK3h3aEZuM1Raa3dMMEdw?=
 =?utf-8?B?ODdKdzU1WGxNNEpzYUFzajNyc3hVN1ppUnZydFpDWkZhbFdmazZOYUtzUWdp?=
 =?utf-8?B?OTRmU3JWNWh4cXhuendDN2NkaTMrN3hGRkN1U0llZHJTOThGajFzamhOS0lR?=
 =?utf-8?B?VEhZYVduL3Y3UHJseFNPMklzTTl3NTRLZFpacWVzdGhUb1ZKOTJwcWtsTSty?=
 =?utf-8?B?RGRZSDZaOTVLUENWSFlWTzN0bEJRaXRQMC91bE0yV294VGtNcU9TYXJzbnB4?=
 =?utf-8?B?YkxrdHFaMGRYamxXN2ZOUExLa1UyU29EelI5a2JEVWliU2NlZHZZa2JsTEYv?=
 =?utf-8?B?cGZWUkMzcHliOS85REx0ZTlvakNCK0FVRFlJa2dNYmQrdE1Tb2M0ekpBMGFw?=
 =?utf-8?B?MktNY2xnTmRjaElIano0YW9QZS9ZY3dJTmhLS1l2aW14dzEzd215cGxGSkh0?=
 =?utf-8?B?aWxCYUl4Y250SVdaM2RSUVV2aFpGZllacEwwMnpwY1dNbi9iVXMzdXV4Zm5a?=
 =?utf-8?B?UmpTaEhQc2JLempSOGJrK2RFYTlKU0ppYTFTNjdtSUF5K1plNzVWM2hBa0pa?=
 =?utf-8?B?bUMyRVIzd0M2Tm5FY1hYSDFmWnlZZHZkZzF2d2g1Y2JtenR6UmxiSlV0ZWR0?=
 =?utf-8?B?SHdkd3BSa2E3ZU1HMXZCWUprM2Z3cEY2UjFTSEIwOHIvb0MyNjlpT0ZvOC9l?=
 =?utf-8?B?L0NYVFM1Q0ZKVjRaQm9JZmtROC9yalFJUTFtQnBhMGt2MGs4MEhuVDN5cDY4?=
 =?utf-8?B?M1U0VFpvVjlkN3lVOURWVzZjNHdiRHFjZ3crMVNobWhrNEgxYzFBSXBLaFdI?=
 =?utf-8?B?N0g3OXduY0cyTXFwdjlERDdkcEEvZ0pWZ2ZJZkpkbk1wQ01NVUpjd1RMUHV0?=
 =?utf-8?B?TnRXa1gzdFJSVDcybnc4dGphWWZTMWZqOVRDOFJxamZvMmNkOENHa0hWTDIw?=
 =?utf-8?B?b09nNDM5NmZoeGVKZ3NIMGtvNW1LOFVhWXhWSVhQRUpJZVlnc3laV3pRUnpp?=
 =?utf-8?B?SktIMGl3Z1VCd0tlMnRMRGlhRC9RZUI0TUhGYXQ1YWpHdXhpY00xcmxxNHdR?=
 =?utf-8?B?bHdDWm51c0c4dWx6Yi9ZY0RhSGN5dzRPRElxQXVBMzFBNitwakJsaEdZUXpw?=
 =?utf-8?B?QXdzRU1taFZuaVVXTUhEWUtxODg2dmtlYi9oYmFuUDc5TGxZQitYUFZzSTBZ?=
 =?utf-8?B?OWs1ZDlnYm9HTGw1SEY3NEowM0FPWDhPbGxOVmtZTWtac1lHZnFvUFp1TTBp?=
 =?utf-8?B?KzU3ZUZnVVZZbXg4S3dyQWFlTktzbnR4R0p4RDEvMVF3QVVjYnVQb1I2U0VF?=
 =?utf-8?Q?2a/at7YczS2Sf44m/baVH3Es6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D8326FCCB28D7419B22AFC6871394F5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JvVbtAnlriKh3W3ua20u22uOVC14PdZ6R/LQo21DCR+ZnVuhXPKEWvsgZbWP1OZ1BREf5WyrR2j+eKmBh4cKjEbmTYWBAElbX6dTgxNIKHoTI2NMEYP3kvtV9ir65GqxsKzZEtV1jRe38+9MND7JdJMtNGrjs7qTqFQDxAfiN6O7Z2qoFfm67qeBbAPnswCH9zJKXudZ8cd3tfkIhIenX6t+qF7HjiDiwXyb0dyUDQhAdNvP/l7ljeiM55UBte99Y4iRsJz+lPONojmIbUoKRTlzWDspv/E91Xti+Is31j51qpBaOGoO/sI2n8O2EAfy835sf10OKu+eIO2TCe0d/LvOpXB/ya2peWJokV7yneSU8NSjhJ2Tux7RGrD7oIGaK8wQKvqfILdJGh6tp15p/ROFobdjw4KtC7E/zQSCAqVQglmJITZxTEshSd4aivrnDvpP/GQi7Sw8PtZ9YU7wixofqLPKww3lFJ06BogJnkhgJfoWzfhutwqAoJ37+VVpmwCUJLjc9M2na5ebDx61IGJVV9F8Zg9OShKBG84zP4BAkssC3szKrGkMgqnLeIrKjKtqp2xYidsON4GrV22HjRIH+miFKKPopywMORMsgbuEQf8nLe4qzrIPl7ePaFCYcWqY7dJnPDRnUWHnVIpYOg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28d6b29-6a70-4796-99ab-08dc371b699f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 22:36:45.5315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KbsZVXIZhUwc7ie/7664Ae8P8FTecEf7dIyvmgBJh5n9PbNJsydQkDAl3If61YCQZay7j5qVLCYTt6QIjFTcew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5428
X-Proofpoint-GUID: kJRzZdL6WG-qP2TpLXmCvTyGlOfF8JST
X-Proofpoint-ORIG-GUID: kJRzZdL6WG-qP2TpLXmCvTyGlOfF8JST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402260175

SGksDQoNCk9uIE1vbiwgRmViIDI2LCAyMDI0LCBNaWNoYWVsIFRyaW1hcmNoaSB3cm90ZToNCj4g
VGhpcyBwYXRjaCBhdm9pZCB0byBkaXNjb25uZWN0IGFuIGFscmVhZHkgZ2FkZ2V0IGluIG5vdCBj
b25uZWN0ZWQgc3RhdGUNCj4gDQo+IFsgICA0NS41OTcyNzRdIGR3YzMgMzEwMDAwMDAudXNiOiB3
YWl0IGZvciBTRVRVUCBwaGFzZSB0aW1lZCBvdXQNCj4gWyAgIDQ1LjU5OTE0MF0gZHdjMyAzMTAw
MDAwMC51c2I6IGZhaWxlZCB0byBzZXQgU1RBTEwgb24gZXAwb3V0DQo+IFsgICA0NS42MDEwNjld
IC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiBbICAgNDUuNjAxMDczXSBX
QVJOSU5HOiBDUFU6IDAgUElEOiAxNTAgYXQgZHJpdmVycy91c2IvZHdjMy9lcDAuYzoyODkgZHdj
M19lcDBfb3V0X3N0YXJ0KzB4Y2MvMHhkNA0KPiBbICAgNDUuNjAxMTAyXSBNb2R1bGVzIGxpbmtl
ZCBpbjogY2ZnODAyMTEgcmZraWxsIGlwdjYgcnBtc2dfY3RybCBycG1zZ19jaGFyIGNyY3QxMGRp
Zl9jZSBydGlfd2R0IGszX2o3Mnh4X2JhbmRnYXAgcnRjX3RpX2szIG9tYXBfbWFpbGJveCBzYTJ1
bCBhdXRoZW5jIFtsYXN0IHVubG9hZGVkOiB0aV9rM19yNV9yZW1vdGVwcm9jXQ0KPiBbICAgNDUu
NjAxMTUxXSBDUFU6IDAgUElEOiAxNTAgQ29tbTogc2ggTm90IHRhaW50ZWQgNi44LjAtcmM1ICMx
DQo+IFsgICA0NS42MDExNTldIEhhcmR3YXJlIG5hbWU6IEJTSCAtIENDTS1NMyAoRFQpDQo+IFsg
ICA0NS42MDExNjRdIHBzdGF0ZTogNjAwMDAwYzUgKG5aQ3YgZGFJRiAtUEFOIC1VQU8gLVRDTyAt
RElUIC1TU0JTIEJUWVBFPS0tKQ0KPiBbICAgNDUuNjAxMTcyXSBwYyA6IGR3YzNfZXAwX291dF9z
dGFydCsweGNjLzB4ZDQNCj4gWyAgIDQ1LjYwMTE3OV0gbHIgOiBkd2MzX2VwMF9vdXRfc3RhcnQr
MHg1MC8weGQ0DQo+IFsgICA0NS42MDExODZdIHNwIDogZmZmZjgwMDA4MzI3MzllMA0KPiBbICAg
NDUuNjAxMTg5XSB4Mjk6IGZmZmY4MDAwODMyNzM5ZTAgeDI4OiBmZmZmODAwMDgyYTIxMDAwIHgy
NzogZmZmZjgwMDA4MDhkYzYzMA0KPiBbICAgNDUuNjAxMjAwXSB4MjY6IDAwMDAwMDAwMDAwMDAw
MDIgeDI1OiBmZmZmODAwMDgyNTMwYTQ0IHgyNDogMDAwMDAwMDAwMDAwMDAwMA0KPiBbICAgNDUu
NjAxMjEwXSB4MjM6IGZmZmYwMDAwMDBlMDc5YTAgeDIyOiBmZmZmMDAwMDAwZTA3YTY4IHgyMTog
MDAwMDAwMDAwMDAwMDAwMQ0KPiBbICAgNDUuNjAxMjE5XSB4MjA6IGZmZmYwMDAwMDBlMDc4ODAg
eDE5OiBmZmZmMDAwMDAwZTA3ODgwIHgxODogMDAwMDAwMDAwMDAwMDA0MA0KPiBbICAgNDUuNjAx
MjI5XSB4MTc6IGZmZmY3ZmZmOGUxY2UwMDAgeDE2OiBmZmZmODAwMDgwMDAwMDAwIHgxNTogZmZm
ZmZmZmZmZmZlNTI2MA0KPiBbICAgNDUuNjAxMjM5XSB4MTQ6IDAwMDAwMDAwMDAwMDAwMDAgeDEz
OiAyMDZlNmYyMDRjNGM0MTU0IHgxMjogNTMyMDc0NjU3MzIwNmY3NA0KPiBbICAgNDUuNjAxMjQ5
XSB4MTE6IDAwMDAwMDAwMDAwMDAwMDEgeDEwOiAwMDAwMDAwMDAwMDAwMDBhIHg5IDogZmZmZjgw
MDA4MzI3MzkzMA0KPiBbICAgNDUuNjAxMjU5XSB4OCA6IDAwMDAwMDAwMDAwMDAwMGEgeDcgOiBm
ZmZmZmZmZmZmZmYzZjBjIHg2IDogZmZmZmZmZmZmZmZmM2YwMA0KPiBbICAgNDUuNjAxMjY4XSB4
NSA6IGZmZmZmZmZmZmZmZjNmMGMgeDQgOiAwMDAwMDAwMDAwMDAwMDAwIHgzIDogMDAwMDAwMDAw
MDAwMDAwMA0KPiBbICAgNDUuNjAxMjc4XSB4MiA6IDAwMDAwMDAwMDAwMDAwMDAgeDEgOiBmZmZm
MDAwMDA0ZTdlNjAwIHgwIDogMDAwMDAwMDBmZmZmZmY5Mg0KPiBbICAgNDUuNjAxMjg5XSBDYWxs
IHRyYWNlOg0KPiBbICAgNDUuNjAxMjkzXSAgZHdjM19lcDBfb3V0X3N0YXJ0KzB4Y2MvMHhkNA0K
PiBbICAgNDUuNjAxMzAxXSAgZHdjM19lcDBfc3RhbGxfYW5kX3Jlc3RhcnQrMHg5OC8weGJjDQo+
IFsgICA0NS42MDEzMDldICBkd2MzX2VwMF9yZXNldF9zdGF0ZSsweDVjLzB4ODgNCj4gWyAgIDQ1
LjYwMTMxNV0gIGR3YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdCsweDE0NC8weDE2MA0KPiBbICAg
NDUuNjAxMzIzXSAgZHdjM19nYWRnZXRfc3VzcGVuZCsweDE4LzB4YjANCj4gWyAgIDQ1LjYwMTMy
OV0gIGR3YzNfc3VzcGVuZF9jb21tb24rMHg1Yy8weDE4Yw0KPiBbICAgNDUuNjAxMzQxXSAgZHdj
M19zdXNwZW5kKzB4MjAvMHg0NA0KPiBbICAgNDUuNjAxMzUwXSAgcGxhdGZvcm1fcG1fc3VzcGVu
ZCsweDJjLzB4NmMNCj4gWyAgIDQ1LjYwMTM2MF0gIF9fZGV2aWNlX3N1c3BlbmQrMHgxMGMvMHgz
NGMNCj4gWyAgIDQ1LjYwMTM3Ml0gIGRwbV9zdXNwZW5kKzB4MWE4LzB4MjQwDQo+IFsgICA0NS42
MDEzODJdICBkcG1fc3VzcGVuZF9zdGFydCsweDgwLzB4OWMNCj4gWyAgIDQ1LjYwMTM5MV0gIHN1
c3BlbmRfZGV2aWNlc19hbmRfZW50ZXIrMHgxYzQvMHg1ODQNCj4gWyAgIDQ1LjYwMTQwMl0gIHBt
X3N1c3BlbmQrMHgxYjAvMHgyNjQNCj4gWyAgIDQ1LjYwMTQwOF0gIHN0YXRlX3N0b3JlKzB4ODAv
MHhlYw0KPiBbICAgNDUuNjAxNDE1XSAga29ial9hdHRyX3N0b3JlKzB4MTgvMHgyYw0KPiBbICAg
NDUuNjAxNDI2XSAgc3lzZnNfa2Zfd3JpdGUrMHg0NC8weDU0DQo+IFsgICA0NS42MDE0MzRdICBr
ZXJuZnNfZm9wX3dyaXRlX2l0ZXIrMHgxMjAvMHgxZWMNCj4gWyAgIDQ1LjYwMTQ0NV0gIHZmc193
cml0ZSsweDIzYy8weDM1OA0KPiBbICAgNDUuNjAxNDU4XSAga3N5c193cml0ZSsweDcwLzB4MTA0
DQo+IFsgICA0NS42MDE0NjddICBfX2FybTY0X3N5c193cml0ZSsweDFjLzB4MjgNCj4gWyAgIDQ1
LjYwMTQ3N10gIGludm9rZV9zeXNjYWxsKzB4NDgvMHgxMTQNCj4gWyAgIDQ1LjYwMTQ4OF0gIGVs
MF9zdmNfY29tbW9uLmNvbnN0cHJvcC4wKzB4NDAvMHhlMA0KPiBbICAgNDUuNjAxNDk4XSAgZG9f
ZWwwX3N2YysweDFjLzB4MjgNCj4gWyAgIDQ1LjYwMTUwNl0gIGVsMF9zdmMrMHgzNC8weGI4DQo+
IFsgICA0NS42MDE1MTZdICBlbDB0XzY0X3N5bmNfaGFuZGxlcisweDEwMC8weDEyYw0KPiBbICAg
NDUuNjAxNTIyXSAgZWwwdF82NF9zeW5jKzB4MTkwLzB4MTk0DQo+IFsgICA0NS42MDE1MzFdIC0t
LVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiBbICAgNDUuNjA4Nzk0XSBEaXNh
Ymxpbmcgbm9uLWJvb3QgQ1BVcyAuLi4NCj4gWyAgIDQ1LjYxMTAyOV0gcHNjaTogQ1BVMSBraWxs
ZWQgKHBvbGxlZCAwIG1zKQ0KPiBbICAgNDUuNjExODM3XSBFbmFibGluZyBub24tYm9vdCBDUFVz
IC4uLg0KPiBbICAgNDUuNjEyMjQ3XSBEZXRlY3RlZCBWSVBUIEktY2FjaGUgb24gQ1BVMQ0KPiAN
Cj4gVGVzdGVkIG9uIGEgYW02MnggYm9hcmQgd2l0aCBhIHVzYm5ldCBnYWRnZXQNCj4gDQo+IEZp
eGVzOiA2MWEzNDg4NTdlODYgKCJ1c2I6IGR3YzM6IGdhZGdldDogRml4IE5VTEwgcG9pbnRlciBk
ZXJlZmVyZW5jZSBpbiBkd2MzX2dhZGdldF9zdXNwZW5kKQ0KPiBDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFRyaW1hcmNoaSA8bWljaGFlbEBhbWFy
dWxhc29sdXRpb25zLmNvbT4NCj4gLS0tDQo+IFYyLT5WMzoNCj4gCS0gQ2hhbmdlIHRoZSBsb2dp
YyBvZiB0aGUgcGF0Y2ggdXNpbmcgdGhlIGdhZGdldCBjb25uZWN0ZWQgc3RhdGUNCj4gCS0gQ2hh
bmdlIG9mIHRoZSBjb21taXQgbWVzc2FnZQ0KPiBWMS0+VjI6DQo+IAktIEFkZCBzdGFibGUgaW4g
Q0MNCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgOSArKysrKysrKysNCj4g
IDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRl
eCA0YzhkZDY3MjQ2NzguLmE3MzE2YTE3MDNhZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC0y
NjUwLDYgKzI2NTAsMTUgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3Qo
c3RydWN0IGR3YzMgKmR3YykNCj4gIAlpbnQgcmV0Ow0KPiAgDQo+ICAJc3Bpbl9sb2NrX2lycXNh
dmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiArCS8qDQo+ICsJICogQXR0ZW1wdCB0byBkaXNjb25u
ZWN0IGEgbm8gY29ubmVjdGVkIGdhZGdldA0KPiArCSAqLw0KPiArCWlmICghZHdjLT5jb25uZWN0
ZWQpIHsNCj4gKwkJZGV2X3dhcm4oZHdjLT5kZXYsICJObyBjb25uZWN0ZWQgZGV2aWNlXG4iKTsN
Cj4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICsJCXJl
dHVybiAwOw0KPiArCX0NCj4gKw0KPiAgCWR3Yy0+Y29ubmVjdGVkID0gZmFsc2U7DQo+ICANCj4g
IAkvKg0KPiAtLSANCj4gMi40MC4xDQo+IA0KDQpUaGVyZSdzIGFscmVhZHkgYSBmaXggZm9yIHRo
aXMsIGFuZCBpdCdzIGFscmVhZHkgaW4gbWFpbmxpbmUuIExldCBtZQ0Ka25vdyBpZiB0aGlzIHdv
cmtzIGZvciB5b3U6DQoNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPWIxOTFhMThjYjVjNDcxMDljYTY5
NjM3MGE3NGE1MDYyYTcwYWRmZDANCg0KVGhhbmtzLA0KVGhpbmg=

