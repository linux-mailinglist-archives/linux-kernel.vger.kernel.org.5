Return-Path: <linux-kernel+bounces-158199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FFD8B1CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018381F23056
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B0E7D086;
	Thu, 25 Apr 2024 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aNiKFfjv"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066DE6F06A;
	Thu, 25 Apr 2024 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714034052; cv=fail; b=L30okO3qwS16c3x2Nqdcm9igs6kMBpb69hwOvUgF12EYL8aobQiqdJfeYF6+hFewz+agfE9edGYGKezrP7PpASqrnkLbA6DwacULtcTgI23NxxgmT/I2KSX5bC0ebcPJ377ShywiwwqffWlnGSg3KMkm5VrIL4lpoDDPLLkgdhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714034052; c=relaxed/simple;
	bh=34uaN6m1uTvrqpW4zqc+E2DXnYXbJl7rXusCogJ1TaI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bAFP/VXCxza4EotnxocDdZppW2NQQdaXSJP2wb/+a4LhSjaw+6FxB41kVltJlrUKh6qXpPM8gHxKYrSETam6oP+UM749iQIlPXApIHoaIfFfzj4ELfbTVqslyxalssJALjPRCgvqUjbW6hNUZBp647RQI1gJWYSa7fT5k1yj7Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=aNiKFfjv; arc=fail smtp.client-ip=40.107.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qwk/gtZAbQKqjyGXs5/wNuSHtKZSfZLF7GbsYFkLvpEslAuRW1L0XOrIkClnJNv4EXeLtE12YjAJCWqH2PuahVqeqs13PXnhiwjCs2hxBo8CIjcbLXzu8nXA1MOAllf/vdr5Ef3TAp70vd00LRyXMTANlX8cDIEn3SoGXDDxT5CDTAFPNyo2FdltNyFn4/Y4IK/0tgrP5+ZTK9CyJd5ElnEcG4J3F5mJUzv3PYjjggXO9QHeOcjq3iTF6x4jTDonSa8zeBYMpZR9PPJXqGKpgxK1UoVZt5FY3lEn5Rf466QUkFAS+IKhVJQiBYztDpNkLnQYpwo6y7ZPx9s5YUCMow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34uaN6m1uTvrqpW4zqc+E2DXnYXbJl7rXusCogJ1TaI=;
 b=eWBtJiOFX8aoRSzfdabOAdX4VHdBAYoxH4q7LQ0lmcX0ehz5x/4FmRD+bp/NISuc/2Kvmvk+8ejXa6POlGaU4Z+wDOpWLsvFucJhYHrHkOXkER1juD0NIroFWu+1HHsqQqoUBgVMWjzb8m2LrA0yggZhp+xAUenSwLcP9RlvTY+MQiWYoNWms5AslEbbN6XZLhGANVc6Oe9BtSZ8jguUlWgHFMiuSJ9OMUt4TLBTv2llnxfWTvF2CPn1RxvQOaiRs9xtmXFEHiA6QaE2MJwqx0qGqmHCMDETSTYp9GOz59uX+a00Ow5zQ/WzTN0uiwkRkifBaNfJunJpDtfoO6+p5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34uaN6m1uTvrqpW4zqc+E2DXnYXbJl7rXusCogJ1TaI=;
 b=aNiKFfjvfly9CmErW2j37otFip/si8gfwdKrpD9cfIzq9VhkjMZO3Oo21nkK8MY0b5qDc0AheJ6+DUgMJCfNX24T16+2b1Xw8wIR3lHjAD6kvOGFb/fJCZNiMPYhGWxJNRqE1ZzIDmsnGx1aA6Jw798JeI948+HyFKm9XGdCWAs=
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by DUZPR04MB9917.eurprd04.prod.outlook.com (2603:10a6:10:4d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 08:34:07 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::13a3:8937:4e42:19b9]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::13a3:8937:4e42:19b9%4]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 08:34:07 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "vkoul@kernel.org" <vkoul@kernel.org>, "kishon@kernel.org"
	<kishon@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v3 2/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding
Thread-Topic: [PATCH v3 2/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding
Thread-Index: AQHalhI1l5d28MLfSUGFHBYdo/fEdbF3UveAgAArSQCAAP+/UA==
Date: Thu, 25 Apr 2024 08:34:07 +0000
Message-ID:
 <DU2PR04MB86778A9F197D04187E5FB8B58C172@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <1713939683-15328-1-git-send-email-hongxing.zhu@nxp.com>
 <1713939683-15328-3-git-send-email-hongxing.zhu@nxp.com>
 <20240424-lustfully-region-826b9570bc38@spud>
 <ZikZmo3420wqx16E@lizhi-Precision-Tower-5810>
In-Reply-To: <ZikZmo3420wqx16E@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8677:EE_|DUZPR04MB9917:EE_
x-ms-office365-filtering-correlation-id: f9fb8364-2891-4d19-9fb6-08dc650278ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?gb2312?B?ZmlJN2lYV3puQlV0Y1NrNktSZTc0SVlyWlg0T1RMeDlNZEJoRjc4WktxVHdm?=
 =?gb2312?B?MHFWNGZENkxOUDlYTTFMeTZXSzV0b1hTd2RuQittdlhDUExHY1ZHaFR6WEk1?=
 =?gb2312?B?cFBvNW5ua2cvdDlQWGsyRnFUOTZmL3UraEs1VzdJejE5amhKeTRFbmE0cVZn?=
 =?gb2312?B?MUNhSlRjZFJkaWY5NGpZMUpSSkJRdFNENGpOaXpDTUpuRXBGdXdQdzliM1Aw?=
 =?gb2312?B?WW1XTCsvenRoK2xlc0lhMFBkUnFDcUtnTFJLT1NBYnB4WFZvU0tsRFltZXZo?=
 =?gb2312?B?R1Eya29lL0haS1hkWDAwRW9oQzQ3UmZoZjIyNXBPQUszKzhnWEZRcW1YRG05?=
 =?gb2312?B?VnVreHVOck5yL0RHc2RKU3EyYVdiZkk2SyszcEJEK0lOK2NPdW9PN21xOS9j?=
 =?gb2312?B?N3IyWEVKMGNQQTFzZ1BXemZWYjc2YVN3emE1OTJNTFlPQ3Zsd3lKbmF6cGVz?=
 =?gb2312?B?OGFFWU5VNmdjTWlMdy84V3NQbnBXYTJETUxTTGRPQmNvZUVRS3pqSFBpV3RW?=
 =?gb2312?B?SFY2cW1vc0dEcHg1WGJ6UUlGQW9mQWRoK0JmVzVoUzMrY0gya2FmREozeGFO?=
 =?gb2312?B?NGV3dWxnKy9wZ1NYKzRRZTFBMEVlcFR5bExmZlg4azJDNXM2VFcxcHJyU1ho?=
 =?gb2312?B?RlBGSSsycFVaYUNldzhDRm1uMThkN2xQeDJlS3VzblhQSnR2cUF5K3RPMmlI?=
 =?gb2312?B?UWJGMUFnNHJ5cEdYVzB5STgya2NKQUxGNmV4ZWRldzl3elJNeDEzYUhHOGdG?=
 =?gb2312?B?R3VmRVNOdk93Rzk1MWkvRm8xY2FMc3pqakNkK0Q5N3dBdXpCcUZrNVNIeWNl?=
 =?gb2312?B?OG5yWlF4cU9lNFc3SElOQWw5QnZNZ3J6S1B5Q0MrVHN2UCtPNWJzMUEreDA1?=
 =?gb2312?B?UUhHN3pXYVFwTjYzV1ZoODQvSkJCTUVLQWY2K0dBbmRBekIvWVJqa01OV0JZ?=
 =?gb2312?B?RlkzWVlxS3NBVTcxdjJlcFFKaGdqRUdzYTVHc3gxQm9WRW50ZWZxb1pkZ1hK?=
 =?gb2312?B?QnF3eUp4MFlSSUZ0cjY3eGpsOE11YjhHWEJtcjFHZUUxcTdsVVZSMUFCaThx?=
 =?gb2312?B?OVQxMll3cW1taVgxMWhpR2YvakxSOTBMcnBPamhObTU3OGVwVWM1RVBPTzI1?=
 =?gb2312?B?QUJha29BSE9BckJYTmR2Y0hPL0Rja1dVM281bnIzY09FZFNieVdhbkNnN0RE?=
 =?gb2312?B?VVNKbmZFZkVSaENDTUFNVUFxS0NURko2Z3AxNW1YM3o5S05ZVGs3RkpNTVdW?=
 =?gb2312?B?R1Z6VytEdUVmTmtsQk9JdVluVE82bzJvbVhUTVU3QUhTRmY3dFpBN3hFVXpU?=
 =?gb2312?B?by93QU9QYWVUbUJxblZjSjhwenBuaFZRVk9HVGROU3VQbXl3MmpmSlgreHhn?=
 =?gb2312?B?QWdMVEdCMnkvSDhjdTdpbEFTM1lTdWxMa1dDR2J1QUpENUEzTmJxQVN2QkU5?=
 =?gb2312?B?SW5PVVYxaG1NQzZPeVloSTF6Sk9HTDRrRytyNmFOTU5QVThLeTgwNjJaQzdX?=
 =?gb2312?B?Zk05MjFwQ2RnNHN2THhQTWRSdmF2bFNmd0duMlJWWUh1Q0RzcVVVaDYyT1lk?=
 =?gb2312?B?ZitMcXVSV1dVU0Q2dDZzQkZEYWh4aTFOZitIYVE1N242NnZTMlRnNkRqTlBy?=
 =?gb2312?B?aVhrNkhNSm9QYkVRODljaGdsejNNbWNDazMvaTgyVHMyVStUR3VUOTFTNE5z?=
 =?gb2312?B?YWZXL1NROExXNk15NGZJeXZVaFN4bTRzQlJmZGpBbzFQNHlVVkZQYmZBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Y3ZzMTJwaVhVTkk4bUJZTDg2MXIxUEVsMTFPNHhwa2dodWE0Sks2MFN6RXhL?=
 =?gb2312?B?OHpIU3dvdHN2MUNyVGhyK09yZDkrME8yRlBPdlpsTnh1QWZSTDFMNnpYNHVw?=
 =?gb2312?B?REJlNE94S2QzbXNlNytobW41VllBZ1V1TzJVQktONERsdnVJTE5aeVZ1Yys1?=
 =?gb2312?B?V2dFeVNoQUpJMVpnSmsrZE5nRlBIWFVXQVRROXBvUXRiNVNpWGNYQWNxNVhy?=
 =?gb2312?B?YlBEMi9KbmxsNGx4R2tycS9qc280YWxJb01YM1NWWDhMSkZnWmVMQ3ZvVERP?=
 =?gb2312?B?a3hoa3ZyZ1c2Y2d6Z0JBbXEwZzY0RVp2cGprdkdLWldLWGo3RDhSa05vVWIx?=
 =?gb2312?B?UDZlYlYxaFVXRXJJaTU0V3F4RHFhKzk4MnFWOXBwSEwrbkJOQzdKNlpaWW1L?=
 =?gb2312?B?TlY3dUNSd2pWdVhOa2Y0S2VVQ0VkQkpSdzQ4U051V25VRFVReVpqbTR3QWk2?=
 =?gb2312?B?WHk5TkV1S3h0VTFuRFBFUFF0eVUwUjZFZjNWRVlvNkVIcTlFbTA3RDlUanor?=
 =?gb2312?B?ZHRxYjhPZ29KbzFleWxINCtQUUdFTCs3VkhGcnN6bGczb2tZMC9mdkFZMU96?=
 =?gb2312?B?aWdBeGREZTcxWVF4WVlIN1RheDJCOWhka3c1N2FPcEtzSEw2dEFGNWRHN21X?=
 =?gb2312?B?TWEyMS9xcEdkRW5jY3duYXh4ZnVFa21taisraTBUYzd5UXluS3dpekNncXpm?=
 =?gb2312?B?ZmZ2ZjRNbk04bkp2anp2R1V4eXFESGJ3cWtmamNCYkxNWVEyZlJZLzUxbjZ0?=
 =?gb2312?B?U0JxN0NXWktZYnBjaGdYR2p6eVdNQUczc29td3dVM05NeHM1bUJlZ1FYYnR5?=
 =?gb2312?B?emRrSW4vRHRYUXZjYWNOSGdlazV4RTdWblg2LzFFZS9HZThhbDJGS3BVeGJV?=
 =?gb2312?B?VTJSWFp4cUk0YnVNSE5BSUhSaWVsSUxyUXVYekY4eTVWYzl0WWVnNURLeVND?=
 =?gb2312?B?R2FXZG9Va08wMm1JbVoxT0gzK3lPSmFERnFLQm1WMWw5cHBXRHJ2UlBrZnVM?=
 =?gb2312?B?VktpSmZwZGRxRFhnYmhHdFBQNG5SNGRtdGRkeHlNQ05oT0syd3hHeTdIa2Vh?=
 =?gb2312?B?citaZnd6aFdML0Yra2lZWWo1NTNHYjJWUjRSZWRvSEhWSFhENlM3Wm9pUlFQ?=
 =?gb2312?B?K1MyWGJqK1dpcVNxN1hrcUx1bGZrYWpvdFM1VGxVL2JmTzRYY21pQkdIOWgv?=
 =?gb2312?B?MkJDZU91WmVYNWRlWTRPdEhHMEVNUFRCRUs5c1VuV0RtdFE0ZE9JMnhiUXVM?=
 =?gb2312?B?N21HRDBkdElpTDRwTFVMZHdtUFhKSTFxS1RaYVY5blJDeDBrdEFZbUUxaWV1?=
 =?gb2312?B?YjMwWDkvdkY0NXdXekFtT2pYTmh3bVJlSktXdWlTaW43R3J3dzlnMTJOYTU4?=
 =?gb2312?B?dGdYcHk5MGhLajRWbExwSlNsRFlWWE95RUsvOFhxRXRoMWthemg0V0R6N1RP?=
 =?gb2312?B?ZjRCL1hpc2sxTVBFcXZETUxxam1xdjUwNVM0YmFudWd3OEltbWNoTFE1YklE?=
 =?gb2312?B?TTNucXRyNTJGYnh5bUVRZy9DUmsvdmpsbk1VT250OWg3cEtDMjhJNDd2VDQv?=
 =?gb2312?B?emN5eEh0YUIyYTFjbE40UloyRHV2d2s3RUlmWkpRY0RGNkRNZXljakZXV0xR?=
 =?gb2312?B?cGJjWG9mSXdkUTU0dEduUURKL3dNbG9HdFVTbndGNk1vb1lWd3BqTWcxaHBp?=
 =?gb2312?B?Qkc1L0N2WkpwYUNmY2Fud2VBN2lxckhlQ3ZuWGJ3MnNjcGM3ZElqU3JWNDBq?=
 =?gb2312?B?L2NhRE1MWGhEanU4aTAwNlFzaWJRTUJaS3pPTU9lamRya0FFbHZURCsyYXpw?=
 =?gb2312?B?NmVJWXIyeVUwMjFyK3Ivc2NLZmo1VWtYNXJIWXNNSlJ2TTczVHBaMFJZYWhU?=
 =?gb2312?B?WFpOVUdsOU9zM0ovbWRtNjczUSt0MG02Z2JhTzJXd09FTmFkZTZXdTZVeUVF?=
 =?gb2312?B?SFp0c1I2Z3dIQW1Hb1BIckg1OFdMQ1gwSSt4akVPMHByOUZDOTlNN3FNb2lx?=
 =?gb2312?B?eDJ0enZvenphVDBzbllxc2pvZmkzc3JLZkMrSnQ4b0k5WFVDU3VFd2JpcE9G?=
 =?gb2312?B?cEZtempraHcvblZEdkI3SUdabnV2elkyT2V0aTRZOUlPdS9PZlhSSG5UQ3Rm?=
 =?gb2312?Q?QAHIB8CgmIUQEw4jlZVIR+LkI?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8677.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fb8364-2891-4d19-9fb6-08dc650278ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 08:34:07.2853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4VHxINeNiB4Jusj5UlYSfMXeaHYUGTMEO/brqtjwGgjWTx6U32hYn8K6NGgbfJkmLyICf4EkQ1+zWb9GIUOcnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9917

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZyYW5rIExpIDxmcmFuay5s
aUBueHAuY29tPg0KPiBTZW50OiAyMDI0xOo01MIyNMjVIDIyOjM5DQo+IFRvOiBIb25neGluZyBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56
aHVAbnhwLmNvbT47IHZrb3VsQGtlcm5lbC5vcmc7DQo+IGtpc2hvbkBrZXJuZWwub3JnOyByb2Jo
K2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsNCj4gY29u
b3IrZHRAa2VybmVsLm9yZzsgbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5k
ZTsgaW14QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvM10gZHQt
YmluZGluZ3M6IHBoeTogQWRkIGkuTVg4USBIU0lPIFNlckRlcyBQSFkNCj4gYmluZGluZw0KPiAN
Cj4gT24gV2VkLCBBcHIgMjQsIDIwMjQgYXQgMDE6MDQ6MjdQTSArMDEwMCwgQ29ub3IgRG9vbGV5
IHdyb3RlOg0KPiA+IE9uIFdlZCwgQXByIDI0LCAyMDI0IGF0IDAyOjIxOjIyUE0gKzA4MDAsIFJp
Y2hhcmQgWmh1IHdyb3RlOg0KPiA+ID4gQWRkIGkuTVg4UU0gYW5kIGkuTVg4UVhQIEhTSU8gU2Vy
RGVzIFBIWSBiaW5kaW5nLg0KPiA+ID4gSW50cm9kdWNlIG9uZSBIU0lPIGNvbmZpZ3VyYXRpb24g
J2ZzbCxoc2lvLWNmZycsIHdoaWNoIG5lZWQgYmUgc2V0DQo+ID4gPiBhdCBpbml0aWFsaXphdGlv
biBhY2NvcmRpbmcgdG8gYm9hcmQgZGVzaWduLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIC4u
Li9iaW5kaW5ncy9waHkvZnNsLGlteDhxbS1oc2lvLnlhbWwgICAgICAgICB8IDE0Ng0KPiArKysr
KysrKysrKysrKysrKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQ2IGluc2VydGlvbnMoKykN
Cj4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9waHkvZnNsLGlteDhxbS1oc2lvLnlhbWwNCj4gPiA+DQo+ID4gPiBkaWZmIC0t
Z2l0DQo+ID4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvZnNsLGlt
eDhxbS1oc2lvLnlhbWwNCj4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BoeS9mc2wsaW14OHFtLWhzaW8ueWFtbA0KPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
PiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uM2UyODI0ZDE2MTZjDQo+ID4gPiAtLS0gL2Rldi9udWxs
DQo+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L2ZzbCxp
bXg4cW0taHNpby55YW1sDQo+ID4gPiBAQCAtMCwwICsxLDE0NiBAQA0KPiA+ID4gKyMgU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAx
LjINCj4gPiA+ICstLS0NCj4gPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFz
L3BoeS9mc2wsaW14OHFtLWhzaW8ueWFtbCMNCj4gPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNl
dHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiA+ICsNCj4gPiA+ICt0aXRsZTog
RnJlZXNjYWxlIGkuTVg4UU0gU29DIHNlcmllcyBIU0lPIFNFUkRFUyBQSFkNCj4gPiA+ICsNCj4g
PiA+ICttYWludGFpbmVyczoNCj4gPiA+ICsgIC0gUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBu
eHAuY29tPg0KPiA+ID4gKw0KPiA+ID4gK3Byb3BlcnRpZXM6DQo+ID4gPiArICBjb21wYXRpYmxl
Og0KPiA+ID4gKyAgICBlbnVtOg0KPiA+ID4gKyAgICAgIC0gZnNsLGlteDhxbS1oc2lvDQo+ID4g
PiArICAgICAgLSBmc2wsaW14OHF4cC1oc2lvDQo+ID4gPiArICByZWc6DQo+ID4gPiArICAgIG1p
bkl0ZW1zOiA0DQo+ID4gPiArICAgIG1heEl0ZW1zOiA0DQo+ID4gPiArDQo+ID4gPiArICAiI3Bo
eS1jZWxscyI6DQo+ID4gPiArICAgIGNvbnN0OiAzDQo+ID4gPiArICAgIGRlc2NyaXB0aW9uOg0K
PiA+ID4gKyAgICAgIFRoZSBmaXJzdCBkZWZpbmVzIHRoZSB0eXBlIG9mIHRoZSBQSFkgcmVmZXIg
dG8gdGhlIGluY2x1ZGUgcGh5LmguDQo+ID4gPiArICAgICAgVGhlIHNlY29uZCBkZWZpbmVzIGNv
bnRyb2xsZXIgaW5kZXguDQo+ID4gPiArICAgICAgVGhlIHRoaXJkIGRlZmluZXMgdGhlIGxhbmUg
bWFzayBvZiB0aGUgbGFuZSBJRCwgaW5kaWNhdGVkIHdoaWNoDQo+ID4gPiArICAgICAgbGFuZSBp
cyB1c2VkIGJ5IHRoZSBQSFkuIFRoZXkgYXJlIGRlZmluZWQgYXMgSFNJT19MQU4qIGluDQo+ID4g
PiArICAgICAgZHQtYmluZGluZ3MvcGh5L3BoeS1pbXg4LXBjaWUuaA0KPiA+ID4gKw0KPiA+ID4g
KyAgcmVnLW5hbWVzOg0KPiA+ID4gKyAgICBpdGVtczoNCj4gPiA+ICsgICAgICAtIGNvbnN0OiBy
ZWcNCj4gPiA+ICsgICAgICAtIGNvbnN0OiBwaHkNCj4gPiA+ICsgICAgICAtIGNvbnN0OiBjdHJs
DQo+ID4gPiArICAgICAgLSBjb25zdDogbWlzYw0KPiA+ID4gKw0KPiA+ID4gKyAgY2xvY2tzOg0K
PiA+ID4gKyAgICBtaW5JdGVtczogNQ0KPiA+ID4gKyAgICBtYXhJdGVtczogMTQNCj4gPiA+ICsN
Cj4gPiA+ICsgIGNsb2NrLW5hbWVzOg0KPiA+ID4gKyAgICBtaW5JdGVtczogNQ0KPiA+ID4gKyAg
ICBtYXhJdGVtczogMTQNCj4gPiA+ICsNCj4gPiA+ICsgIGZzbCxoc2lvLWNmZzoNCj4gPiA+ICsg
ICAgZGVzY3JpcHRpb246IFJlZmVyIG1hY3JvIEhTSU9fQ0ZHKg0KPiBpbmNsdWRlL2R0LWJpbmRp
bmdzL3BoeS9waHktaW14OC1wY2llLmguDQo+ID4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVz
LnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ID4gKw0KPiA+ID4gKyAgZnNsLHJlZmNsay1w
YWQtbW9kZToNCj4gPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gPiArICAgICAgU3BlY2lmaWVz
IHRoZSBtb2RlIG9mIHRoZSByZWZjbGsgcGFkIHVzZWQuIEl0IGNhbiBiZSBVTlVTRUQoUEhZDQo+
ID4gPiArICAgICAgcmVmY2xvY2sgaXMgZGVyaXZlZCBmcm9tIFNvQyBpbnRlcm5hbCBzb3VyY2Up
LCBJTlBVVChQSFkgcmVmY2xvY2sNCj4gPiA+ICsgICAgICBpcyBwcm92aWRlZCBleHRlcm5hbGx5
IHZpYSB0aGUgcmVmY2xrIHBhZCkgb3IgT1VUUFVUKFBIWSByZWZjbG9jaw0KPiA+ID4gKyAgICAg
IGlzIGRlcml2ZWQgZnJvbSBTb0MgaW50ZXJuYWwgc291cmNlIGFuZCBwcm92aWRlZCBvbiB0aGUg
cmVmY2xrIHBhZCkuDQo+ID4gPiArICAgICAgUmVmZXIgaW5jbHVkZS9kdC1iaW5kaW5ncy9waHkv
cGh5LWlteDgtcGNpZS5oIGZvciB0aGUgY29uc3RhbnRzDQo+ID4gPiArICAgICAgdG8gYmUgdXNl
ZC4NCj4gPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWlu
dDMyDQo+ID4gPiArICAgIGRlZmF1bHQ6IElNWDhfUENJRV9SRUZDTEtfUEFEX09VVFBVVA0KPiA+
DQo+ID4gTXkgY29tbWVudHMgb24gdGhpcyBhcmUgc3RpbGwgbm90IGFkZHJlc3NlZC4gUGxlYXNl
IGdvIGJhY2sgYW5kIHJlYWQNCj4gPiBteSBjb21tZW50cyBhYm91dCB0aGlzIHByb3BlcnR5IG9u
IHYxLg0KSGkgQ29ub3I6DQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuDQpBcyBGcmFuayBzYWlk
IGJlbG93LCB5b3VyIGNvbW1lbnRzIGFyZSBtaXN1bmRlcnN0YW5kLg0KPiANCj4gUmljaGFyZDog
SSB0aGluayB3ZSBtaXNzdW5kZXJzdGFuZCBjb25vcidzIG1lYW5zIGF0IHYxLg0KPiANCj4gIldo
eSBkbyB3ZSBuZWVkIG51bWJlcnMgYW5kIGEgaGVhZGVyIGhlcmUgYXQgYWxsPyBUaGUgZW51bSBz
aG91bGQgYmUgYW4NCj4gZW51bSBvZiBzdHJpbmdzIGlucHV0LCBvdXRwdXQgJiB1bnVzZWQuIE9o
IGFuZCAidW51c2VkIiBjYW4ganVzdCBiZSBkcm9wcGVkLA0KPiBhbmQgbm90IGhhdmluZyB0aGUg
cHJvcGVydHkgYXQgYWxsIHdvdWxkIG1lYW4gInVudXNlZCIuIg0KPiANCj4gZnNsLHJlZmNsay1w
YWQtbW9kZToNCj4gICBkZXNjcmlwdGlvbjoNCj4gICAgIC4uLg0KPiAgIGVudW06IFsiaW5wdXQi
LCAib3V0cHV0Il0uDQo+IA0KPiBJZiBub3QgZXhpc3QgImZzbCxyZWZjbGstcGFkLW1vZGUiIG1l
YW5zICJ1bnVzZWQiLg0KPiANCj4gRnJhbmsNClRoYW5rcy4NCldvdWxkIGJlIGNoYW5nZWQgYXMg
dGhpcyB3YXkgbGF0ZXIuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KDQo=

