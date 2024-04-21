Return-Path: <linux-kernel+bounces-152467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1677A8ABEDC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 11:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881D3280EE6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 09:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F491119A;
	Sun, 21 Apr 2024 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="jCMYMAmJ"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2119.outbound.protection.outlook.com [40.107.22.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B3211185;
	Sun, 21 Apr 2024 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713690453; cv=fail; b=PFJtl7XwJnJlikcnLA7zHPh0OY6+G35Gz/55qLKvFLxkvNdS8HJrngCOEJn5DAXEHUORyezCxi9wnBCXwESFpKFoLBn6fX58gcBJ6Vdr8ZN+Aj/aHMFRp/MHMJF1a5acV/K3UKHSBp0yz4kuzC1qWYC3PrKqKeenIJu9RFciJXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713690453; c=relaxed/simple;
	bh=OUFmE4gbcRC/td8NwNBsN+5d4bDbYlvKp9f18zn2tjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sfPTD1m2WdMGHGntELzGW0X+qVJXjxPJefNrthiDyOyV9ANPX6w/Pil1KpKdJLPvlZw+0nYAfxD8jODCRXPCz48eDh4sUb8xao7/Tk+8YJQ5GCERFOdyqL2VwWn21om2xBSpL2pV0VzIFUAomjPMJFGFGOgCyNHtI8THan74Xz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=jCMYMAmJ; arc=fail smtp.client-ip=40.107.22.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpQ7Qv/vCQZk46RIGZ1sy2M9Y0qcE3n/FshQ9Dg4wwTUMd+w3em4h3rs0VVI0FaI7RHdgTp4JMZgwSU8LgJX4fIjct6e4C5sfH0jU/mr1YB3HTCWwSQwgr3JoodEwaZKEu7BS0qOLj+Ryp6YmZZKjNS4daenxPZ1gub7rxj9wBuR4O0XLsjBvnLzbqcWG3Y/kyhJS+d2H/BElVcnio6LWxMokxldl6xzRramLnQ77kwhiaO2O4kdo0MGUDSW/qvj2BXGLD3YFu55iBr9rtGsbo5qCt0csCcZqHMdUlOW4sBrjcGev1Aby8qLhzu2vNZ5OhOnDodG2WMuD2syPP6lWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUFmE4gbcRC/td8NwNBsN+5d4bDbYlvKp9f18zn2tjA=;
 b=aPmOV7Mh+R+ZVEldG8f5B7+sIS5yCOVNo1olSZgGAucRFo9AkaMJiP3Jz0PSiVKsmgm+bK6t5JF8LwztvDNDsJz/22dQ0FbWm9vmLnZ9W4C1SPmlLsLGM5EBb3RvcKZxuFCHGMvlIAkaNXSrg3JU6cloLYOchY8LfZx8fSLTTUMP9IdAGWoDYtqR2UE+UIcVgGTejR2nS78FWmq0EDJ4izJSTDxkWDm5FKg7vgd3dS/0DnpNhUEPtjMeb/vr41XHQdde1xWSaodr4cai7MGmQ/2l+mTOxKhvuNnoeZBLjtSFIDZjOEd2DgbOifRHF+KK2Nz7yGXwBB/uehYQ61/d0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUFmE4gbcRC/td8NwNBsN+5d4bDbYlvKp9f18zn2tjA=;
 b=jCMYMAmJyMc7S4oHsE1cfJaqZ1GwOdcycgxzfTEX5M5gSFEY/8xWH3T+bR187o2N6Mhjgvfz4OKq28yiOjSE9+G4ptmkHYD+aLFjJ4bnrhcYCOrOqVhEZmTw5q0PLD5w7tkk7yLJxk4NoQdjK5Zs+AoVl1rIF810dS0ZzBbUss8=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by GVXPR04MB10024.eurprd04.prod.outlook.com (2603:10a6:150:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sun, 21 Apr
 2024 09:07:26 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7472.044; Sun, 21 Apr 2024
 09:07:26 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Michael Hennerich <michael.hennerich@analog.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Alexandru Tachici
	<alexandru.tachici@analog.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Jon Nettleton <jon@solid-run.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: adin: add property for
 link-status pin polarity
Thread-Topic: [PATCH net-next v2 1/2] dt-bindings: net: adin: add property for
 link-status pin polarity
Thread-Index: AQHakxUeWnJJwEX9+E2iKFCftrM4ArFxVGOAgAAMx4CAAAO6gIABC5iA
Date: Sun, 21 Apr 2024 09:07:25 +0000
Message-ID: <1fe2dce3-972e-420e-b4e1-f07e15b6b35f@solid-run.com>
References: <20240420-adin-pin-polarity-v2-0-bf9714da7648@solid-run.com>
 <20240420-adin-pin-polarity-v2-1-bf9714da7648@solid-run.com>
 <41567aec-adf2-422a-867e-9087ef33ef36@lunn.ch>
 <b3c4301b-afae-44fb-86c5-94f23d363c0a@solid-run.com>
 <2c622947-3b54-4172-b009-0551f43c3504@lunn.ch>
In-Reply-To: <2c622947-3b54-4172-b009-0551f43c3504@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|GVXPR04MB10024:EE_
x-ms-office365-filtering-correlation-id: 517ea45a-c36b-4859-3a39-08dc61e27698
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?Qjhya2oxNHR1cFN5Z3Y0RnkvWTRsU2lSOXN6RWIwUGNodlYySGhNV3RNcEd4?=
 =?utf-8?B?elBZbGphcnZ3SUtzWWdXMjRDQkNUUDA3aUZGUnRYVU9tQVNzTWd2bUQ4a0RB?=
 =?utf-8?B?WllYTE1HVWk0SU9TVlBuN1FRQ0RsTFVGczMvQTAxTUwvbjc0anFJclFxVE1G?=
 =?utf-8?B?ZHcyNDN5Z1VPbU9RY0RYSFF5WVY5b2lsZWZIU2V1SVhYSjBtMXUra3N5TXZF?=
 =?utf-8?B?TkllMG5GRHBxR29lNlVlMWRzSjRQSk8wcTBqcUNRTjZLVHdoZE9VT2pYRjlm?=
 =?utf-8?B?Y0hGMlZQU2t3VGVGRGRTOTFkRytBRkZCbDI4dHN6WlJjeHd0QWgxZHhGWDhz?=
 =?utf-8?B?M2FHeGRSRnRCY252WkVsV0ZkVU5tRkNuVXNRMmhRZEJtdzdtUHZGRlR1VHlK?=
 =?utf-8?B?M2NFS0lkZVAwc1cvQ1FsY3E4WTMwZml0YXRMSDVVYmdudVplaFowOEJTcTZV?=
 =?utf-8?B?UEJ1L0U4UjVZcGVkNTAycHM1YWNkTkkwZ0hkbWhZcUkvZ2tZTGpjMW9pMUR6?=
 =?utf-8?B?K0lhN2lsZEh0dWxvVkpld09wY20vVndpRGY4c3hCTE9lMEtJb01YcnVuTE04?=
 =?utf-8?B?a2dxUnpBeVdTZFlBazVsSnB3d1pkVi9FY3MzRURLTHIrOHVmTkhaYU1mNnpo?=
 =?utf-8?B?RnBQYTBwY3k3VGp2WlBCa0luZXlnUDZRTVlybkRPN2JZSGhUL0E0L2d1WS9l?=
 =?utf-8?B?dVpOOVplcGRweVRkTEpKUXdZMGJYUGN5TUpIK3RReVpjN2lOOFNMa0lrOWFY?=
 =?utf-8?B?WUlXV2JKcE5NWndUZmhiR2RYV21mWDdNTnZyT0l1bmVWWDNaTHlXaWdlalU3?=
 =?utf-8?B?d2Q3emFjS0VaU2x2dktQZVRNcm1Ta1JLTHVBdFlVWE5FR3dlWUtkZlRQMWJY?=
 =?utf-8?B?TnJiMlFZNWhPUzl0eFEzV2J3QnRaem5SdnRRZld1R0ZqTFhzOFN1cTVHa3Vr?=
 =?utf-8?B?aVNUWlJtQ2lXZ2FvUytuSWNBMllVaVZDVDA1Q1ZpdVRGa3E4TVZCck1yZkV3?=
 =?utf-8?B?ZnRIbDVLclF6R0VyS2NPNzZFT1JDTHVLR2d4RWFwWFhMZkk1Rmp3SjFRd3FN?=
 =?utf-8?B?akVHaml4OWpTU21tTGl6TFhudWcvRHhLcWZkS3ZOYTNWTWFZOXVXUUEzTHVB?=
 =?utf-8?B?NGFUN1pVcnROTGVMQWVWRWlXM0xtZWZhQ1dkUFQ1bEVvK0s2dzV6VDhFUWJs?=
 =?utf-8?B?SThDVFl1ZDliWCsxTGxYdEJCbkFxR3VNbWFHRDdwd203TzMyMGZvNzZQZHIw?=
 =?utf-8?B?WGZHVld3akxWNWlsMnNxQ011N1JIMndUUW1iV2loSzVvckRuSUkzRURiUlRM?=
 =?utf-8?B?amp6cFF2VXFQZ1BlOHBhUllESEwzTmpjVmMyRUZlTURVRi8xZmg5OVBXNTcv?=
 =?utf-8?B?bTZjM0Q4L2VnYnV2Qm9rZUlHSFE3TzB6YjN2aG1oUHFNT3VUV2hqUnBSQ1dq?=
 =?utf-8?B?NjRLNjNBVVpNYUM0eUhmWFhZVGpYMkl0cmFDT1pDeUlQMWZ1bVRGTzN3a0hS?=
 =?utf-8?B?OEIvUHBMcXRVSmdWQzNjUThBVGNwNXlKcGFPcTRrRUFRS2psMkRhOERZR1Ew?=
 =?utf-8?B?ZFNwd2hjeTNpRG1GeGhvRHFZa2xTT3I2Q2dPUTkvaURSWWlSMHdXb2Y5a0Uz?=
 =?utf-8?B?TUphNXlFRVVjd3cycUR4TFRSV1E0blg2cmIwMHptVEt5eGZQb1BzbWtrNW80?=
 =?utf-8?B?T1VxNXgvaU1PVnhqWW1zd2llcS9PL0NUZ3BrTWxpVyt3Nm84MnZUOWgyNWw4?=
 =?utf-8?B?NUJZdXpZOUFWZm14NDAxNnhad0ZnVUNGZXpCeTZUdmFFcFRQZG1NRXorbmxE?=
 =?utf-8?B?TEh6aThBNm50VXRxbDNqdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUM0L2l6a1ZSZHhzczZqdkxPWkF6WUFCa0FpTmxMbittS04xa0ZaS2pNV0FY?=
 =?utf-8?B?QmtlNzRoc0hFdTdSeFA4U1BBbEZUTUp0WnZpYWhHSUxCY2MwTFF1cCs0Qjcx?=
 =?utf-8?B?bGc5bHR2YjJlNmFMZGJYRENvclFSdzFPaWZ6QjZYSEl2dkx0eUo1T0pUYWZK?=
 =?utf-8?B?aGZqdjVqcGRqSUhmclo3L2F6SDBmZkw4UW1tSVB1MVZUV3hQc09pblNjU3ds?=
 =?utf-8?B?bGNnT0pvb3lLY2VGWGpKbk83cDBJR1pFbDNpR2NtWk44ZnRMTmZaMkVhZ293?=
 =?utf-8?B?WE5sYk9TdVNod0tHL1dIRzRMdG90dXZ6RnVCakZKWkYxOW03dHJ3QmJ2Yy9h?=
 =?utf-8?B?elAyNWF6SnVTMCtsUGxDY0JITnM1VkZRWlpDZThmNW9ybDRwRmt5YWxNMWxZ?=
 =?utf-8?B?c3pJcE5oNmdXR0gzQVcwcnpPRmNlb2JyUUkzR1lHQTM1OTFlbEhVblY3Wkxq?=
 =?utf-8?B?cXNjemMvRkZ4UUFNMjlYdm80VVp0UVYzYUp4aVVVbjkxbU9qNkZlUDhXOFpx?=
 =?utf-8?B?akFIOExhbUtEU21PK1ZOdXR0OWJrZFpnL3FjdkdpS29QS20yWnZiTXBNOEFq?=
 =?utf-8?B?WU9pa2V0VFV2Z0FGVEZ4YnFreGZPeUVLUGVnMHpxUVVmR1Q1YldaRnJWbE4z?=
 =?utf-8?B?SU00UmpJM0dOL3V1ei9iU2k4elU5eXpTOUl6RjBBSFZQZk83aTF4c3REZ2Mw?=
 =?utf-8?B?RDFJaGZjd0RaVGJnRmxOUk1LZ2RnSmFKZURqeHZaMWVKcDRmQnlwNmZDNFVF?=
 =?utf-8?B?enRoVHVKbWdGOGRSb2JkVHIvZzhSVUpzcXdEZjNUQTFIekM0aG40TGU1SHM3?=
 =?utf-8?B?N05wYko0YVgvcXdRQ0FMRHhxRWJYNzNBalR0enVsd2o4eWNWRjMvR05sOFZp?=
 =?utf-8?B?QlZKd2Y4L3FOQlk4SThxQzdDQzVXaW5PNGp6dmVtYnBSb3BtcEd2Nmp5SGZG?=
 =?utf-8?B?Q0pFQzBNVTB0OVlsYWlQUlNDWlZyc2Z2RWIrSEsvcjlEYmludHRGTXJwRFNO?=
 =?utf-8?B?dmJCTENaRVdhcWVkMC8ybS9tZGJ6eXR0TWVxZFpyYjg2ZnJMU2x5VE9kNE1U?=
 =?utf-8?B?alNJRjFJdWI5Z3VDczMwQ2RDaVFzcmRMSkQvWW8yUVAyc1VMNWRqOGM5RkNC?=
 =?utf-8?B?dUlLRXpZT2ZFMVNmYXF5R1YzSkpOZGptQTFwY1ZtbGFKSlROZmxyNHlJVUZx?=
 =?utf-8?B?eW9sK2ZzenZyeSs3TVVBU3RiMjN1RWtVY2R1VkExaUlTN1BvcU9UTGxlNmlW?=
 =?utf-8?B?eGJTalNrMFlmTzQvZmVXMGF1Y0kzNkxQaC9MWmR4dytnM0JneFlNQkNqOWF3?=
 =?utf-8?B?c2Rtb3pCa1YwWHNHV1pLSkFOWGMrMnZNWnpGZkt0dG81Q2pDRzJtOXo2NnRm?=
 =?utf-8?B?MmRRVFZiSXBVc2JMSjUvYS9FKy9TOFJEUnNGYyt5bGhmU1FPRURJMFlJSTc5?=
 =?utf-8?B?bFROSG1SakJxVmJqWm5WU2NYc2NLaWZhTE12Q2tqL0NFc0dsNzZEVmxHUmVI?=
 =?utf-8?B?S1F2bFZKdFRtQTZwdG5ITGk3WWVDemZoZTRqMWlzZmxFb0NIK3E0NmhPN3g0?=
 =?utf-8?B?YWkzNmxHL0VSVnJNRzcyd1FNQVZLUnczLytIWjVTMXhtWjNDRk5uNGhoSjdD?=
 =?utf-8?B?NVUyL1F1ZklJTldER2xpdUJ4bS9SVVh2QkxDeDJaVWVDSGFkYkZ4KzRPME5E?=
 =?utf-8?B?aUtxa2FpRExqWElrUEdqRWNHSm1aSDRaZEFQcG9mNUxuWlJlaXBSTG9MV05q?=
 =?utf-8?B?UkF2ODZ3VUVaL2l4YWtEUXI2elB2dXBFRHdLM1hwTWFhbkJ3TXZ5SG1iWWRz?=
 =?utf-8?B?cG9Ob3dZbXhYYUI0bTczMVdURnp6dzdWRkVXTmN2b2R6RjVLUEJtdnlJQ2c2?=
 =?utf-8?B?YzRqcWQvVitDcjBDU3ZlUXhYS1FZcnB2S0gvYWkyYlpNM25YckVFemJLcys0?=
 =?utf-8?B?YTJQQXNkenAxUW1nWjZTZTlZall5bytKbGlGTFZBRExNWmsvTlRFT0xMOVg3?=
 =?utf-8?B?ejlOaFowQjdnMmpXdTY4RGtoa3o4N0dFcjIyUmZMWmc2Zm1GYWhLWDlWQnB1?=
 =?utf-8?B?aFVXMjJCM1ZzalhZc0FHZ09neGxRd2lieUl5V3FKSmhVdFhCQUswSXJ6ckhy?=
 =?utf-8?Q?y8g4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5850C9D9F47A346B70FA59656602A67@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517ea45a-c36b-4859-3a39-08dc61e27698
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2024 09:07:25.9776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sJZxNaVe7Sp1B6fCSxPVcD4hjEh3MfOdHuKNyxGQsxqWB/UYrt1+SDfzZRGsCxVIWGCSnYWTotLB6W33jqYsVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10024

DQpBbSAyMC4wNC4yNCB1bSAxOTowOSBzY2hyaWViIEFuZHJldyBMdW5uOg0KPj4gTWFpbiByZWFz
b24gZm9yIGhhdmluZyBhIHZlbmRvci1zcGVjaWZpYyBhbmQgbm9uLWxlZCBwcm9wZXJ0eQ0KPj4g
aXMgdGhhdCB0aGlzIHBpbiBpcyBub3QgYSBsZWQuDQo+IFNvIHlvdSBhcmUgbm90IGRyaXZpbmcg
YW4gTEVEIHdpdGggaXRzPyBXaGF0IGFyZSB5b3UgdXNpbmcgaXQgZm9yPw0KDQpUaGUgdW5pdCBJ
IGFtIGN1cnJlbnRseSB3b3JraW5nIG9uIGNvbm5lY3RzIGFuIExFRCwgeWVzLg0KDQpUaGVyZWZv
cmUgSSBhZ3JlZSB3aXRoIHlvdSB0aGF0IGl0IGNvdWxkIGJlIGRlc2NyaWJlZCBhZGVxdWF0ZWx5
DQpieSBhbiBsZWQgbm9kZSB3aXRoIGFjdGl2ZS1sb3cgcHJvcGVydHkuDQoNCkkgbWVyZWx5IGRv
bid0IGxpa2UgdGhlIGlkZWEgdGhhdCB0aGlzIG1ha2VzIG5vIHNlbnNlIGZvciB0aGUgb3RoZXIN
CnBvc3NpYmxlIHBpbiBmdW5jdGlvbnMuDQpPbmNlIHNvbWVib2R5IHVzZXMgdGhpcyBwaW4gZm9y
IGRpZmZlcmVudCB1c2UtY2FzZSwgdGhleSB3aWxsIG5lZWQNCnRvIHNvbHZlIGl0IGFnYWluLg0K
DQo+PiBUaGlzIGtpbmQgb2YgY29uZmlndXJhdGlvbiBpcyBtdWNoIG1vcmUgbGlrZSBwaW5jdHJs
IHRoYW4gbGVkLg0KPiAgDQo+IFNvIHdoYXQgaXMgdGhlIHBpbmN0cmwgd2F5IG9mIGRlc2NyaWJp
bmcgdGhpcz8gWW91IHNob3VsZCBub3QgYmUNCj4gaW52ZW50aW5nIHNvbWV0aGluZyBuZXcgaWYg
dGhlcmUgaXMgYW4gZXhpc3RpbmcgbWVjaGFuaXNtIHRvIGRlc2NyaWJlDQo+IGl0LiBXZSB3YW50
IGNvbnNpc3RlbmN5LCBub3QgNDIgZGlmZmVyZW50IHdheXMgb2YgZG9pbmcgb25lIHRoaW5nLg0K
SSBhbSBtb3N0bHkgZmFtaWxpYXIgd2l0aCB0aGUNCiNkZWZpbmUgUElOX0ZVTkNUSU9OIG1hZ2lj
LW51bWJlcnMNCnBpbnMgPSA8UElOX0ZVTkNUSU9OIG1vcmUtbWFnaWMtbnVtYmVycz47DQoNCkJ1
dCBvbiBNYXJ2ZWxsIHBsYXRmb3JtcyB0aGVyZSBpczoNCm1hcnZlbGwscGlucyA9wqAgIm1wcDEi
Ow0KbWFydmVsbCxmdW5jdGlvbiA9ICJncGlvIjsNCg0KSSBhbHNvIGZvdW5kIG1vcmUgZ2VuZXJp
Yz8/PzoNCkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsL3BpbmNmZy1u
b2RlLnlhbWwNCkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsL3Bpbm11
eC1ub2RlLnlhbWwNCndoaWNoIGhhdmUgb3V0cHV0LWhpZ2gvb3V0cHV0LWxvdywgZnVuY3Rpb24s
IHBpbi4NCg0KSW50ZXJlc3RpbmdseSBMRURfMCBzdXBwb3J0cyBzb21lIG5vbi1sZWQgZnVuY3Rp
b25zLCB0b286DQotIGNvbGxpc2lvbiBkZXRlY3Rpb24NCi0gY2FycmllciBzZW5zZQ0KLSB0eC9y
eCBzdGFydA0KLSB0eCBlcnJvcg0Kc28gcG9sYXJpdHkgaXMgYWxzbyByZWxldmFudCB0byBub24t
bGVkIHVzYWdlIG9mIExFRF8wIHBpbi4NCg0KTWlnaHQgYmUgSSBhbSBub3Qgc2VlaW5nIHRoZSBi
aWcgcGljdHVyZSBob3cgdGhpcyBmaXRzIGEgZ2VuZXJpYyBzdHJ1Y3R1cmUuDQoNCg==

