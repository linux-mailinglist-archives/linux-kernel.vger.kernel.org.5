Return-Path: <linux-kernel+bounces-152680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE31A8AC2B8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 04:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4FC1C20CA8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 02:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EE85235;
	Mon, 22 Apr 2024 02:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OIeaIfoG"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9CA4C80;
	Mon, 22 Apr 2024 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713751652; cv=fail; b=clRTcWO0r+E2+2v9NhSHA5t0GxJpbDirRSiUvDALh7qwrP+As79eo16n4r2Qmkj/m2VOFMwriT9tYhcUhpbctSwaZiMBQKISpr2kz9pgTt3E1mGbSTNZ61I1JQTlpsd/8twdONs2ralbwO3Saco+M8BOVyjLOogPsyM687zoxMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713751652; c=relaxed/simple;
	bh=m/jwUZaG+U+/GKcwVeFJtsd9H8WD9rgviFuZK1nhVFU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XU2hYvxYETTeqt/05UNW3GxMDRx6XWqJL+zw3PH02YEIvJvygm4hZ5kzJ5OE8KQ4YTE1CJBczByFkHXm9De6JsPSccebjMuyHsZuXKtuvCJgVDQzlMpxjqtdQW+34BDjHAc32XkMheUwktQX0wcmu/MiwHAbDa8ErhZt5KQssQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OIeaIfoG; arc=fail smtp.client-ip=40.107.21.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrKqBRJqOD1WfzFos+x4hxwKTmH6ZGfSxF6LUKlJsE5H69NI7YhB7EGao1y7cPhvywi4Jf72btVC6JcGNnx1UrvfMxwlIK/czbUs2UreMnqzyhGKvyHnjt+o+ip6grRPGLrEZMvNEj78+/fCq3JfyjeravsnehGvWETK15gRT+xjqkKPMbQKkQuNcJejze6YzishrqnSM/2gJ+g8eH24xZ7ki5LhTL8fpyWk8fhqLdssoBskYVrJHXxTV9AY5zQKnQZ7fn1WJL/P7f1K2T2W4bDbcJZ1lT6SrbSCTVjQ/T3+2J2EmAPw7GqyGa/DcHmmGzXYp+CxDsfP770R2XdoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/jwUZaG+U+/GKcwVeFJtsd9H8WD9rgviFuZK1nhVFU=;
 b=gY4taO4atoZXobUR1H3MNAzTxK4nmgaN2WRDBKnYVILyfln6hnN7VtTp4Ev89ohcI3HX8qfyM7vAPsCl/1tmWwpnhlOToHHxnkrCZ/wmxxDnfVw3VCI/gPX0ImxcQ6kcEgYNUajVZPD4XLYzkPvUHjsIuO2buT39heO4TMr5ei2Dk3+YGNOnG28WcAzcT9iDQBJQUusilwxD/igft2air66TdOq+a/AH00+3ipxzTbLyaPwBcE7aM/+F7HW2yEUxMEdGCgIgcsXIKJVf4ic+QELHVvGCDMNQvtqAWO0XgofumyjQ7yX1B+wH8IKr5EDRG0KIG1pGet/ByyQGOCQtTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/jwUZaG+U+/GKcwVeFJtsd9H8WD9rgviFuZK1nhVFU=;
 b=OIeaIfoGRmncRypXVZWad+QaFSoxbhIYYFpVcWkO/3pxF5eSA6fogrUJibSQcu6rXyD+hYW87ZQNU9GIO0GaZkYhdvcN6ER67LzQZ6BwvnaGbAAyIuSzBO9T0uhqefutrTmnv9HoUqn2I7CkPyaQUg5vR6fNeyMp3QqwVNQVRXQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI0PR04MB10509.eurprd04.prod.outlook.com (2603:10a6:800:214::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 02:07:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Mon, 22 Apr 2024
 02:07:27 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 12/12] arm64: defconfig: build in OCOTP ELE
Thread-Topic: [PATCH v2 12/12] arm64: defconfig: build in OCOTP ELE
Thread-Index: AQHakgnawxItN1fRy0GjdVjJXRwrkLFvmu0AgAP0UhA=
Date: Mon, 22 Apr 2024 02:07:26 +0000
Message-ID:
 <DU0PR04MB9417161B8245099E43D4156788122@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
 <20240419-imx93-dts-4-13-v2-12-9076e1d7d399@nxp.com>
 <0dfc402a-ee31-404f-9dc2-8828d7a6b337@kernel.org>
In-Reply-To: <0dfc402a-ee31-404f-9dc2-8828d7a6b337@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI0PR04MB10509:EE_
x-ms-office365-filtering-correlation-id: 6ca8893a-0956-4d3e-a5f6-08dc6270f538
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?TkhWczNES1Y5OCtOSGdjTERuUURPVkRjVjFtaXgvQmZTZzdrNEVPckFzTEdJ?=
 =?utf-8?B?TDBzamlGQ1hZWThiZk5CL3VOUk4vVGVxZWNmTko5NU5zajNKbnZzS21iYVVH?=
 =?utf-8?B?ZVlJNGl5VmlOcnN6SnRWb0ZjN3RYN2VFdjlvbEFiYS9aTnJWUlV0WDdMc2g4?=
 =?utf-8?B?eHBxWTNSd2JpMy9jdTVjb1RFV0RZQjlGL0tJekZHQjhJYW5sbER3b2M2U01B?=
 =?utf-8?B?UFRVVlgvRCttZUZtV0hZL2tQT3BIcmxJQjBRZDBKWFZwc2dDaGFqaGhuNEtk?=
 =?utf-8?B?OWgvb0I2WWJBZ1Uwa1NDOUJzU0tWbWxENWo1LzJpeDI1ZVZHNjR3c2pBejhZ?=
 =?utf-8?B?c3Q4ek1td3Q0V3AyV3BVN2RnZXFzRFIxREZuYVNmU3g2NXFlMDRsYzRJY0hW?=
 =?utf-8?B?TmkzOWgvcEoyM0ZONGhEb1JXdHdOYlM1VjEyUGhvRHNnYXdnd1FVVER4RGJX?=
 =?utf-8?B?T1BFbHhsZStlMUdwY29OSk1aSWJaV2FxN0pKNVF0NThJWGlGVkhmdGpCNkxm?=
 =?utf-8?B?RXo2K24vSHovNWNqY3cwQjBLVkZpQXhFUlordUhta3kvbkprK0kzb0pTbXdJ?=
 =?utf-8?B?UjMrci9QdXpMVUdEWW9ZbnFEYWJoYzZBb2s4L3JidWVnTlM0YURYcWlhNUo1?=
 =?utf-8?B?MHIrMEZpVStBRmhUWDRiZ0FwNEVOKzlOY0xuNGZrQTFqck52a0Iwa3lqMW5D?=
 =?utf-8?B?U0Q4NkJGSFF2N2ZZT0xnQk9mSmtLa2FvOWlsaVZhaXR6eXhKdTVKUVYrVHZz?=
 =?utf-8?B?SDlVQjh5OVd2S2hVMVBRbkswM1Z1enJqWGpzUnZSWWljK0tubjlkbkFTYkxv?=
 =?utf-8?B?eU1qcVZxUEM1dlJhdjd2Q1g5OENUUXdxdUt5QTZyVHlwMW5WU1lCeFI0UFNs?=
 =?utf-8?B?L0tTcTBERG9wU2lBamtlZXh6T0lpVFgydWpWT0phT0VGT0JEaTM1UlJjVjdF?=
 =?utf-8?B?QmI0NHNlMXNWcEVqR3I1c0hlaDVCZXlrTUg0b21rRVlIQWRmdW5TZUtNMEtv?=
 =?utf-8?B?Wm9JWkhSK3NOeVBNVDNLNkdtZDdEamc0RUhQWk4rL0JNaDBid1NXa2NNRU41?=
 =?utf-8?B?ZmVwa1ExT2VjRkxIV1lFZlpQc2hnVlB5VHl0VHlsQ0RUYUVyYUM5VmF4Rmds?=
 =?utf-8?B?NiszR05jY0FReGszamFWYmNhdUJRb1pyY1d0aWJrdjNZUTNQV3hUYVlWRDh1?=
 =?utf-8?B?cjk5dWdLdmgzak92Z3pHUXhzYWRPMmJ1SmxpdE0rN2JTb29YQjZYbHBjUzdi?=
 =?utf-8?B?ZjJjQ0J2TDhRZFdwd3kxYWVYbFZ0WklDUG1VTmYvRHdsWHlqcENaVHU4QlNR?=
 =?utf-8?B?MmNtZzZ5QTJKdGlrWElkRzg3RTJDZE5KMlZZMG1ic0lJV0NhdVdqOTV0SEl5?=
 =?utf-8?B?Ny9YZ1FLcHJ3cmlKVXp3RjhQOHk2QWxDYUFIZ1NDYWJUSUZtTHB4dHJTdzVa?=
 =?utf-8?B?L0Z3QS9ZMS8rNkkrNWFJS3hrcUlVZWs4SVV4VzFIejB2dzdxL3F2T2xsaHNo?=
 =?utf-8?B?TTRBY0pGVFVNWXNwaFR3R1BsL2xkQUloUkhRSGt4eFRvVFhmZVorS3UrMHJP?=
 =?utf-8?B?M094QzBqc3YzS3JJa0kzV3FPYUdBK0U1ZnZjREpQcisyV2dFM09ZVGovczFH?=
 =?utf-8?B?bTBIOUJYYlhCUGpMb0JFVGovOEFLWkgzNDhwbFBDZ0JqYWVYeS9IdVZkcnlu?=
 =?utf-8?B?dHhrY0prR0NXQmZKdVZRTWFZalNPSFpRajNsRUVZWmFQY1pER2p0VzZNWnRV?=
 =?utf-8?B?T01VZDJJUTZ3ZmVoa2lkaFVrOXNjT1l0NGI4aUxLbmhpcWpTOWNKa1dUcVFr?=
 =?utf-8?B?bUxhYlMvOVVtemwrWFNwQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1MrOU85OXVwb3N5dzJpOTQ2VmJRRy95ZnFud01KcUJWUnl3Ly9FZnVPclA1?=
 =?utf-8?B?MUFYMFVZNklvYWZ3cG0rMExQTTBxTGdhaUg0QmxJZFV0NFp4Q3JkeVZZR21l?=
 =?utf-8?B?K0F5alM2MDBISS91b3VxczZLdGFIK0tUaWdsMDZTQnliVXpyOFlRWG8xSis0?=
 =?utf-8?B?YUlYSEg2SlI4bCtIWmF4L1czM1hKTUhNRU1kUEYxOFdRa0dHSk90WnQyMGRJ?=
 =?utf-8?B?MTArQ0pmY3BraWdueFh4SzJOcXJoS1RaTCtXMDFrcUg0amh2aEFrSm9KRmNX?=
 =?utf-8?B?bGJ3NFhSQ0oxUlZMZUZtZDNOdmtHSm92L05BYy94VEw1VXRDZXdDSy8xeUY2?=
 =?utf-8?B?eGtkUWU5N1NBVlBFM3l4M0pVZDJ6YXN2cGlTT2Q1RDBlajFJUHRDQm1rUmtY?=
 =?utf-8?B?UEZnWVE4RkpNS25JZFZ1eFE2TzEyZktVRFdvbnNtT0hsMEdJUXRYaWp1UHFl?=
 =?utf-8?B?ODZ1aGpnNW0vcTRZOWo4NGlVYXV5V01OQjFIL2ZpdTRoUjM5UEkwRmYvY25Q?=
 =?utf-8?B?Sy9jVlkrT1lZSlhPOUpudVNoQkVUQjBZeTVUSFpMa2M1YmRnN0ZSMllhNTFX?=
 =?utf-8?B?WmVVbDR4ZjM5enNyNXErd3NVNU5ad0ZXZmhLRGFvQUxOOHV4TnlCeEFyN1lK?=
 =?utf-8?B?dFBxTlV5QkJrbXFnWTFmRWpHYjJEaVhIVmVXczZ5MnRJTkRKSDVWbkh4Rk9q?=
 =?utf-8?B?WGo0YzdoS2MvT1ovK0dIQnNtQkxCeTkxRkxnakFxclBNUkg5SzM1Y1cyRmh0?=
 =?utf-8?B?QW9JNndJU0xSdi9rdHNBbGhKS3B0SnRjWkNFUjhWK3VTb2VUOU8rMS9JdkMz?=
 =?utf-8?B?YVFWZTQ2S2pjck9QZTc2ZWN6cm1sWkcyY3VoWHN5VVpHNGxKRDJvSm1ZbTNv?=
 =?utf-8?B?SFBXWk1ReXVIV2ZXNnNPd2ZjQkgxK1NtcE1jeGUwbWhSYTlYY1RrVVRianY1?=
 =?utf-8?B?Vm5WbU1KcDRNaWVZc1hkQWRGSlUyQXFNOVQvTWRXZ1hTdlRvU1VQdlZlUFU2?=
 =?utf-8?B?a2lmLzEzQURSUTZvWThacGRHSmVFL1JCRGFkM1d1blMxaEtJN3hRVENPc2hR?=
 =?utf-8?B?Ym5YZ3VKcXR6YW8wblR0dHhqRExZTkNuZVFwTDJDU2lzaGtiRklLekpNUjc5?=
 =?utf-8?B?Ti91eER5alpjeTdvekYrL1FYZFl0N28rcXhqTjd0YXhqYWRDc0ZCcG92TzBa?=
 =?utf-8?B?Q1N5aHdqUkV2V1hnT1EwVjhXQklCem1DVE84S0RwUTNkckNrOWx1dnhwVDI5?=
 =?utf-8?B?bUV0VjZRVS9pWFFjSGlFOGNGQ0dzbXdXTlpDVE94eXY1M3RkZG5vMWt1S3F5?=
 =?utf-8?B?YnIxTUN2TUc4SjNGMkFVUTYxV0VZd1Vza09HK0NFNzFMTExVZnA2NkRIS0dU?=
 =?utf-8?B?TjM4Y1R2US9GYitUa05INTJjNG1WOGdhcWsvZk1lU21EcmdpT2h5bFpOZExT?=
 =?utf-8?B?cUQ0TkJTWU93Q0tRUXErSWNGOE9VSjRZZzBsY3JVT3EvdzcvbGRzellpWERi?=
 =?utf-8?B?L2hVNVBMTzdHc3dnQ2llajRNemRGNEFybE1ZRGJtRDhOL21majhLRkZ2MWVt?=
 =?utf-8?B?aXFZN2tWbFNDT29DbCtLcUJDYW9yN2pjTy9vSDVGTHlmY0hiT2hPeHVzWWxR?=
 =?utf-8?B?VElveCt4SnhsT0Y1OHZ2T2xiMm1pNTlPd2RsOW9BTzJ4TGxMU3piL1hsa1lE?=
 =?utf-8?B?bFkyd1VlMWZKc0Zodk9ZYitESEo5cldNeHI5bFBldUg5aU50bEFnaEEwZVla?=
 =?utf-8?B?eVcrWjJNR2MwSXRvQzJlTlV3OTFmOUVFT1AyeUFJV0NGRndsczdWUWttTjdZ?=
 =?utf-8?B?ajVIQXdIbHpFV3RvUzlwcUFOOC9pSXVuZzVBQXlDeDBGNXBJWUdtdEwzSGJQ?=
 =?utf-8?B?d1BRM2owWkdSMEhZN1JQTklwNDgyNkpxYjM3MzNSdnRZSEMyei9qOXlyVlJm?=
 =?utf-8?B?NVRISWpkdExoNDI1c25zdUo0SUQvU2syaUVzK01VMDJNYUtXbVVvdzg4K2d6?=
 =?utf-8?B?bEhnQjR1bXJ6ZlVxR2N3ZVZmMGZhTWtyMGpvRSsyZ0JIQ3RZZ2F2WFZIVDVF?=
 =?utf-8?B?M0tXd1Zaa2E4Uk42ZjFlRzhCUHBsL05EWkMvQnRacmQzcGpmc2EzQWF0YmRR?=
 =?utf-8?Q?n1bs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca8893a-0956-4d3e-a5f6-08dc6270f538
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 02:07:26.9161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qqdWfUFnRoUBX8Km2rBrt+YZmc+BeBjK+HsMessapgDXBM6XMaTLd9beWFOXB15Ay59mip+p55Or+ws2Vn8vpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10509

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEyLzEyXSBhcm02NDogZGVmY29uZmlnOiBidWlsZCBp
biBPQ09UUCBFTEUNCj4gDQo+IE9uIDE5LzA0LzIwMjQgMDU6MzcsIFBlbmcgRmFuIChPU1MpIHdy
b3RlOg0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gVGhl
IEZFQyBuZXR3b3JrIGRyaXZlciBpcyBidWlsdCBpbiwgd2l0aCBPQ09UUCBFTEUgYnVpbHQgYXMg
bW9kdWxlLA0KPiA+IHRoZSBGRUMgZHJpdmUgd2lsbCBkZWZlciBwcm9iZSBiZWNhdXNlIG52bWVt
IHByb3ZpZGVyIG5vdCByZWFkeSBhbmQNCj4gPiBuZnNib290IG5vdCB3b3JrLiBTbyBidWlsZCBp
biBPQ09UUCBFTEUgZHJpdmVyLg0KPiANCj4gVGhhdCdzIG5vdCBhbiBleHBsYW5hdGlvbi4gRkVD
IGNhbiBkZWZlciBhbmQgcHJvYmUgaW1tZWRpYXRlbHksIHRoYXQncyBub3QgYQ0KPiBwcm9ibGVt
LiBKdXN0IHVzZSByYW1kaXNrLg0KDQpubyBwcm9ibGVtLCBsZXQncyBkcm9wIHRoaXMgcGF0Y2gu
DQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IA0KPiBObywgdGhpcyBzdGF5cyBhcyBtb2R1bGUu
IEZpeCB5b3VyIHN5c3RlbSBpbnN0ZWFkLg0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6
eXN6dG9mDQoNCg==

