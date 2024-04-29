Return-Path: <linux-kernel+bounces-162009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AE68B549B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06CAC2829F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C77E2C6B9;
	Mon, 29 Apr 2024 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Pzmv3DHa"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2126.outbound.protection.outlook.com [40.107.22.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7110E2375B;
	Mon, 29 Apr 2024 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714384475; cv=fail; b=j+SefhwjaXD2rn8ISAjxoBxKeKlQ99rmP2hpoNCBff7S090eCX/NwarkMuRwzDSHg59JqRFSsBoSA0FwUOY5h7pzn6fMrVNgGVOlYR+QfCzUuAaPQCMxICvOJBloi0m4PGaLyiev4NPhe1DGzoBETU+hLdR4H4BddFUyDv5/0dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714384475; c=relaxed/simple;
	bh=Bbvu50K3p1h/bYK6pOrzDl6m3hNAVSVIjytG1xUox94=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=abu/Pvs4JzkE+db/oMsuX0vfMXA0sDKsnLLTttBqHceA46/TU3wjz+b146MVlzRn+KnCZhuKjzmTO9MUyz+NPW27+f1J2URhB576PmpaAAaK78fP6gHTEPJxrUNKYD62S4QHOL0TGYU7z5R6COJAdrodzk3KLHQJR99ZVU72PL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Pzmv3DHa; arc=fail smtp.client-ip=40.107.22.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhjUbibKm6X7FQgHq9v810SdZ4mHTgvCIZnQiu0bpttWMTSvYdPWZ/AXF3xFiUs3FJ8LVdTvjfJe2zgvMxChFFnOJHXveInxDlHnUnXEdFENrlUiDjvirVNfjeXINVBluODo69k0DezWM+5t7y7DEzpIs+afz5isS2iKdwstdjbS+7tJUcjfbeqTLvFgq42Fh92MLOnVZ3czO0/cdBSOrWohfheJ0EcbRM8SxBOviq1tTeorVci5aznijjecLfXgbuQp2Yh4qc7wpPLqU0ng2jThxCEQulf98MaXowCZCJEgURK5rHoxCiOjqNIvsi+7wjpasUZnP1Va0Y6NCAFRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bbvu50K3p1h/bYK6pOrzDl6m3hNAVSVIjytG1xUox94=;
 b=bPrfLMTsCKSKUs7TxJKxfkKLLNK80Lh6zCgE0SfhB9hJeHTmvoj79X8WAeIsxsAAWVQFpTD2a2ak2cSzhBaIeKtPe+sWwtKywGBaWDdds5fUaspzbuE1krEERa86z7i/OUcSHnNDFoylCpQAlzbSVXnsm6o0EiPzpw+bX7Y0JmTVSlt0ueNyksrbJoVp/VF0WyS/1idQVY3DrA5Z7pAG5yFFWiMohdPNKXahUA1OSnKVUwhK2WdoebvGc5z55YdCFKscfq1ioWdjCM/WaDlt7j6n5f+tJ42f/TrL0ccWOQUf6MKiwydO49le5O2NZh90HNxv4cXufDA8B4iSAHy/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bbvu50K3p1h/bYK6pOrzDl6m3hNAVSVIjytG1xUox94=;
 b=Pzmv3DHaQj/MHDkm/TmrDehW9n4LIAZ+kdzeSb5yim+fTD8ouRmAG948kStepy2uohsd5Djbt1rGNSDK4mH1dmyDQqDTrdDKhxUsRp8oZQWDh8XHIm/Gb4BAHcOJiALhquVYjJbQCTWJCpihLlmShKC2F+Kdd3HTa4ls/BctKS8=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB9PR04MB9701.eurprd04.prod.outlook.com (2603:10a6:10:300::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 09:54:29 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 09:54:29 +0000
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
Thread-Index:
 AQHakxUeWnJJwEX9+E2iKFCftrM4ArFxVGOAgAAMx4CAAAO6gIABC5iAgACTSwCADAyBAA==
Date: Mon, 29 Apr 2024 09:54:29 +0000
Message-ID: <b6f5ff0f-65e1-4b46-8f18-edf24ab3cea5@solid-run.com>
References: <20240420-adin-pin-polarity-v2-0-bf9714da7648@solid-run.com>
 <20240420-adin-pin-polarity-v2-1-bf9714da7648@solid-run.com>
 <41567aec-adf2-422a-867e-9087ef33ef36@lunn.ch>
 <b3c4301b-afae-44fb-86c5-94f23d363c0a@solid-run.com>
 <2c622947-3b54-4172-b009-0551f43c3504@lunn.ch>
 <1fe2dce3-972e-420e-b4e1-f07e15b6b35f@solid-run.com>
 <ac8fba1b-93ef-4120-a03b-f91772ecb5df@lunn.ch>
In-Reply-To: <ac8fba1b-93ef-4120-a03b-f91772ecb5df@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|DB9PR04MB9701:EE_
x-ms-office365-filtering-correlation-id: 86ddd51b-5b0d-4849-e54e-08dc68325cad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZGlob0tpdE1WbzI2TW16VUV4SFBiMnVjS3djTzQrVGE3ajRSdktXWHpxOGxB?=
 =?utf-8?B?SndvWlNzZWp0S0trWlpUVkJEczFtMzQxTHdFeEpmVVZXM1ZKdXAzOWF5ak0w?=
 =?utf-8?B?ZUUvVVJ6NTBUbUltYXBvUFdITWc0MXZRa0RFdUZoNWVLTSswdHJqQ3BpaGRi?=
 =?utf-8?B?V2ZUbXUwLzJQUngxaTZPdDRBbFZEbHpwVDI1Vk40RGZVNW1uSjh1UUJyT2Rn?=
 =?utf-8?B?NFVRS0dpYzcrRGU0QjdDdWs1MVF3MmRFUFA0Rk1UNU94RWRmOUFYa2Jvejd0?=
 =?utf-8?B?Y2hCTFVibHBGK3M4M2pSWm0xM1Bkc0g2d1ZwV1J6bmVkY0ZEWkFmamFuVmJl?=
 =?utf-8?B?MkEwa1g3RUFmbzAvQTV4eHl0TFRoRld1Z05NTjBjSHhjNlJkU3BFczZ2RGd2?=
 =?utf-8?B?cHk5K2d6NHp3UDZyOU5QYjdzaWlueGxNUnFieTB2OVdraWdTc1Fkcy8rUDgr?=
 =?utf-8?B?Y1FOSkRoMVFyaExxU2RyU3ovNU9aNW1VU0I1TmdUOURXRisvQUkzeVN5TERD?=
 =?utf-8?B?VjV1UEYyTHMyNlJPNGFhRTdMb3U1T3p2Q3JTRDA1L3laUDlwYjhrNHJ0cUlX?=
 =?utf-8?B?azBQMEtDOUUyU21RNzhLV1VJdjNOR2dKUDJwZC9RQTV4djZKMUlTWWh0RkVk?=
 =?utf-8?B?RndkbGJmNXZScVVDcWllZ09tbisxci95QXRPckR1Z0E2eVRzdEFHV0Zrd0k3?=
 =?utf-8?B?UnZKUVFtbEU1cTIzd0FYcU9qL1F0ZzI1TjQyRkxua0NRN0crV0lJV29jS2RY?=
 =?utf-8?B?T1M5ZmJxT3ZZa2UwQVZqbXZDNTJST2wvdG5Ea1ZOTjArZWNUV2ZOVDgrQWNi?=
 =?utf-8?B?RTBVWXErMHpaNU5HSTlrZm1MYmNlS3c0UkNaSXJWTWZGYTlkVUFEYmwzcW1W?=
 =?utf-8?B?ZkpYek0wWTRIRDJtQ0dmenVSUmVnZFkwZjBMYUc2WHRoa1JMOFpDRGU0Umpx?=
 =?utf-8?B?RWFSNmwwdW9lc3Jqc0xSaE1XQzQzN3pCUkFQVWJiRjJ3L0RkampDbFM0R0Mw?=
 =?utf-8?B?WnAwV3VzVldyL3lGYlhQK1BoNkVTRlRSbzF2L05LK2wzOThKeUoycFVzaXcx?=
 =?utf-8?B?b3pnMXl6MEFVMldnaUVGWC9naVcrTzhFWlNMS052Znkyd2VSVHlKMjlzOG5q?=
 =?utf-8?B?NzNCZ3pzMHM3c0ZnQllwZGR2WTRuemc1YnNQZGxxSHlDYkc4TUNJbkZNMVdF?=
 =?utf-8?B?bGg3S0FnQU5CcGJBMXlhTDlGeGw2VG04aGppZXRKa1dGcmJTblFMUjRMTUVM?=
 =?utf-8?B?T0FuQndwb3JTdFBTcDlBSlJqRnMwcCtYS3hLU0YyYk9CZ3YvT3VrZEplNVRk?=
 =?utf-8?B?R1pTVUJaSWJLYlE0QTJwZm5FMUV1elVWS2thbkE3ajIwcHRDOFN2Zm1iNUZK?=
 =?utf-8?B?UzNEZi93aTFQVmhBRlBTNXJnZWlBUU9RNnRNZ0lzSDdBSjBYem82NjVZUGtL?=
 =?utf-8?B?anpvekdHTzlzTmRuM1U2Y3FTQkoycFFFemg0MUJZb1VRNjFyZ2hVNG9PYm9o?=
 =?utf-8?B?OTBqTjBvQUUxejIvZVpWdE1iYkd2U21yS1duYkxOQk1KT3QyVkJoSkxSWUFM?=
 =?utf-8?B?Q0E4a2ZpUDV1T2RkT2hkVG9BVFQ0bHAwdndudEVvUlR6SmQ5Vmc4L1RVaXgr?=
 =?utf-8?B?cXZpYnFmK21YTWtua0JremRDU0U2eUkramx5S1cxQUlMNjF6SG5GQXUzS1FM?=
 =?utf-8?B?UHlxMFhaa0FJRGxCa2l4V1pEZkowZlJyZHZKRlhYcTZpekJ3RUdrQ0VQTzN3?=
 =?utf-8?B?NWFhcUEzNnBnNE82L2lqTXQ4bGVJdjY2TlgvQXpIREI2RFFGVU9yVndTL0VH?=
 =?utf-8?B?TVFUc0N4b2F2ZlBGUDEyUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cm1LKzZDNFBMQ1Fic2s0WFIzbW1peEhFUXZvTEtxNjFEZVljd080YS9YbWlV?=
 =?utf-8?B?VC9ERWlaK1lQcFdlekFDak5LMkJFY3M4c2FvV1BlK0FoSGdCRFNvQlRQbWRV?=
 =?utf-8?B?NkNlYW9vYnZJWUxIWFprU0VtY283aStLbk5SRDhyeTdSeFlBVXdndEJaNkdm?=
 =?utf-8?B?eHc3TVpBUGtYZXFTTXhIV3VtTGhkcWJpcUNBTTA2RW9HRkRLNUxNa2FKbldL?=
 =?utf-8?B?blNOK0ZTQ0hLSnYrQ2luYk5VWTgyRnB4dTVKOERXL0FmSGI1b2RRNEtEanh1?=
 =?utf-8?B?S1NqK1Y2bjMwODdPQ1lZWUNEYkFJVEdBSzZIVHJBMlRndUsxRmlmYmQySm5M?=
 =?utf-8?B?SWw5Q1h6bzNKNEp5bmZZNTZEYWZUTzFPMUp2SXFxb3l2N3AxK041RWZTNnYr?=
 =?utf-8?B?Nmc5cXhzUUErK0pSWVpMWWdyb25PNlZXRWYxa0VMQnNLL0JKOVBlQ1lZU0k2?=
 =?utf-8?B?NHVKR1BqOGpMRjI5VW1vRXdtZ1BpSVBFOFRVQUZCeklKa0Z6TzVQTUtOVGtS?=
 =?utf-8?B?YXR3emhtTUlrYUd0YmtiZk1RbmlkdXVnV3Bta214Z01pcFEwbGZTMHcyYVBX?=
 =?utf-8?B?TGZYL0ErcGFxMWJyNThLVlRiL2FKQkdNaFl5K1MwSjArd2tYeW5Rb1VCRTVR?=
 =?utf-8?B?YUFNeXRqYUdGcHlVZE04eS9CMFBaUnErOEhqUkw4ZjFFdU9PeHZvSS9Pd3RT?=
 =?utf-8?B?VDZzcGZuVy9iSDF1c1RPMldhVEo5QVpzQ2lSWG8wc3pyYW5ORGg2S3draHRQ?=
 =?utf-8?B?NXc0S1ZPVDFpYlZEUDJ6S0prTVErN1QvNGFHWjVkQ2svbk5LOFJrQVRNalNw?=
 =?utf-8?B?anA5bU80VW5QbXBRZU9oUk1idGZOQnB1TCtYMG1CNkdCQVVTajRQVmM5bngr?=
 =?utf-8?B?K2tMNXlPanBmaEdVQnpoejRMcWNiUy9JUUxJVTl5M2hWanNXLzRrNDQ3YUNr?=
 =?utf-8?B?OXNQbHhTTDM1aXJRV0lsbmRDaUE0MDdYaWg2R1NXVk1BWDVTT0MwR0IveVhH?=
 =?utf-8?B?OGRCdjRnU0liNG5UOXBkZXJxZjhFV2dES21wSkVNSUlnRXc0K0xHaWNLNjQy?=
 =?utf-8?B?RFdOdEVPWWk5RFltV2sxU1NRM3hWZHZSVmtFMGY1M0p3NzlHR0wzNk0vWDVQ?=
 =?utf-8?B?R1lKSUJ4ZXBVc1ZRSXdPbHcxSTFBclQ3L2gyUjJ2aWkreFRTNTZrYTc0alpT?=
 =?utf-8?B?NEFOU3dXSExlK0dWbWpRZ05scW9qdjJZRkk0UUpoWDdheEE5YitVaXVKaFNk?=
 =?utf-8?B?dXZSRGVJVXVhSlNrTUE5YWxwQWRHTjdoTGdJWkExTVRURjJGZ3BQTDMzOVE5?=
 =?utf-8?B?aHAzTmk5blJZL3BKbUNFQ2E4V3o0OVB3Zmxuc3hiaGpBQnROMFk1QllNem51?=
 =?utf-8?B?VzFjb2RGbnJyNkViVFhJS2ZOZ0hPS3FxclFYajlFTEMva1pUZ3UyN08zVVBS?=
 =?utf-8?B?bXJOUi94MzFNemxMYzFXT0RMZ0I1dlBqcXpkZlptMG1wNFQ4U1pkTEkvY09J?=
 =?utf-8?B?ZUpRMWN2WnRkUlU1YjU4OFhYQnd6a2IvajlFT09IcmQrWGpRbVVobmZRSzk0?=
 =?utf-8?B?blhkak5JamJuMEJFcjcvZFJ0SHh5SHNMM2NWaHQvZEtUTy9EYzZNMG1FQVRW?=
 =?utf-8?B?S081OFl2bzMxSFJVaXN5d0JZUXZLYUQrV3VDSll1TGtFOEM5SzFmd1NxOFh4?=
 =?utf-8?B?bFVyd1h5WThoRUZZdVRxY2t3UDgzT3djb0wxK3IvS2xSYTFSdmFINXlzNjVm?=
 =?utf-8?B?MDlrSHdTUi9iNzJScTBJMDRTUEpKdHBoOFl3MXEzMkxzcEZSa0dWN3Q2Z2JD?=
 =?utf-8?B?TUJESXhrL0s1UU94YXVqZHlSb3hObkwvWFI5ZFdHOEVCTU5qU2tZcUJ1VTFX?=
 =?utf-8?B?SVgrZXV2RTB5WmxlUlNOQzNsbHhoK2hYZUMvS0NQYTJMVmZLNk1lQXNFaWs1?=
 =?utf-8?B?dStrTHJDQUJzU1V0WDdXY3dhL0R4RVEwaS8xZXFXeVlPMjhnMkRPdjBxdU9n?=
 =?utf-8?B?aU9FdHpCVzc3eVl2NWNwMnRJMEsybDlsTnB0akJOYWZyaHc2bDRMU2EwVjJ6?=
 =?utf-8?B?RldEZmtodmhIYmp4S0QxaVcvbXpLR0xMYWtUVi9sOUVZZXVEa0s3NFFZN3Ny?=
 =?utf-8?Q?ej18jESOHO3ynRqfPwkTggyBv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <173BCD3123D4704FA4BC23951839F901@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ddd51b-5b0d-4849-e54e-08dc68325cad
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 09:54:29.1955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dqa020nqd+b4mVy452bFp11ejxnimkg4c4OtdIcYtcbOr1F2h6y6m/eu4oJ7lB+RBo/l5dJkAizLGz0c/1GXgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9701

QW0gMjEuMDQuMjQgdW0gMTk6NTQgc2NocmllYiBBbmRyZXcgTHVubjoNCj4+IEkgbWVyZWx5IGRv
bid0IGxpa2UgdGhlIGlkZWEgdGhhdCB0aGlzIG1ha2VzIG5vIHNlbnNlIGZvciB0aGUgb3RoZXIN
Cj4+IHBvc3NpYmxlIHBpbiBmdW5jdGlvbnMuDQo+PiBPbmNlIHNvbWVib2R5IHVzZXMgdGhpcyBw
aW4gZm9yIGRpZmZlcmVudCB1c2UtY2FzZSwgdGhleSB3aWxsIG5lZWQNCj4+IHRvIHNvbHZlIGl0
IGFnYWluLg0KPiBUaGVyZSBhcmUgbm90IHRvbyBtYW55IGRpZmZlcmVudCB1c2VzIG9mIHRoaXMg
cGluLiBUaGUgZGF0YSBzaGVldA0KPiBpbmRpY2F0ZXMgeW91IGNhbiBjb25uZWN0IGl0IHRvIHRo
ZSBNQUMgdG8gaW5kaWNhdGUgbGluay4gWW91IG1pZ2h0DQo+IGFsc28gYmUgYWJsZSB0byB1c2Ug
aXQgd2l0aCBhbiBleHRlcm5hbCBQVFAgc3RhbXBlciwgdXNpbmcgdGhlIHN0YXJ0DQo+IG9mIGZy
YW1lIGluZGljYXRpb24uDQo+DQo+IEkgZG9uJ3Qga25vdyBvZiBhbnkgYmluZGluZ3MgZm9yIHN1
Y2ggdXNlIGNhc2UsIGJ1dCBzb21ldGhpbmcgd2lsbCBiZQ0KPiBuZWVkZWQgdG8gZGVzY3JpYmUg
aG93IHRoZSBwaW4gaXMgY29ubmVjdGVkIHRvIHRoZSBvdGhlciBkZXZpY2UuIEFuZA0KPiBhdCB0
aGF0IHBvaW50LCB0aGUgYWN0aXZlIGxvdyBwcm9wZXJ0eSBjb3VsZCBiZSB1c2VkLg0KPg0KPj4+
PiBUaGlzIGtpbmQgb2YgY29uZmlndXJhdGlvbiBpcyBtdWNoIG1vcmUgbGlrZSBwaW5jdHJsIHRo
YW4gbGVkLg0KPj4+ICANCj4+PiBTbyB3aGF0IGlzIHRoZSBwaW5jdHJsIHdheSBvZiBkZXNjcmli
aW5nIHRoaXM/IFlvdSBzaG91bGQgbm90IGJlDQo+Pj4gaW52ZW50aW5nIHNvbWV0aGluZyBuZXcg
aWYgdGhlcmUgaXMgYW4gZXhpc3RpbmcgbWVjaGFuaXNtIHRvIGRlc2NyaWJlDQo+Pj4gaXQuIFdl
IHdhbnQgY29uc2lzdGVuY3ksIG5vdCA0MiBkaWZmZXJlbnQgd2F5cyBvZiBkb2luZyBvbmUgdGhp
bmcuDQo+PiBJIGFtIG1vc3RseSBmYW1pbGlhciB3aXRoIHRoZQ0KPj4gI2RlZmluZSBQSU5fRlVO
Q1RJT04gbWFnaWMtbnVtYmVycw0KPj4gcGlucyA9IDxQSU5fRlVOQ1RJT04gbW9yZS1tYWdpYy1u
dW1iZXJzPjsNCj4+DQo+PiBCdXQgb24gTWFydmVsbCBwbGF0Zm9ybXMgdGhlcmUgaXM6DQo+PiBt
YXJ2ZWxsLHBpbnMgPcKgICJtcHAxIjsNCj4+IG1hcnZlbGwsZnVuY3Rpb24gPSAiZ3BpbyI7DQo+
Pg0KPj4gSSBhbHNvIGZvdW5kIG1vcmUgZ2VuZXJpYz8/PzoNCj4+IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsL3BpbmNmZy1ub2RlLnlhbWwNCj4+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsL3Bpbm11eC1ub2RlLnlhbWwNCj4+IHdoaWNo
IGhhdmUgb3V0cHV0LWhpZ2gvb3V0cHV0LWxvdywgZnVuY3Rpb24sIHBpbi4NCj4gU28gdGhhdCBp
cyBwcm9iYWJseSB5b3VyIGFsdGVybmF0aXZlIGlmIHlvdSB3YW50IHRvIG5vdCB1c2UgdGhlIExF
RA0KPiBiaW5kaW5nLg0KSSB3aWxsIGNvbnNpZGVyIHVzaW5nIHBpbmNmZy8tbXV4DQo+DQo+PiBJ
bnRlcmVzdGluZ2x5IExFRF8wIHN1cHBvcnRzIHNvbWUgbm9uLWxlZCBmdW5jdGlvbnMsIHRvbzoN
Cj4+IC0gY29sbGlzaW9uIGRldGVjdGlvbg0KPj4gLSBjYXJyaWVyIHNlbnNlDQo+PiAtIHR4L3J4
IHN0YXJ0DQo+PiAtIHR4IGVycm9yDQo+PiBzbyBwb2xhcml0eSBpcyBhbHNvIHJlbGV2YW50IHRv
IG5vbi1sZWQgdXNhZ2Ugb2YgTEVEXzAgcGluLg0KPiBDb2xsaXNpb24gZGV0ZWN0aW9uIGlzIGFu
IExFRCB1c2FnZSwgeW91IGp1c3QgZG9uJ3Qgc2VlIGl0IHZlcnkgb2Z0ZW4NCj4gc2luY2UgaGFs
ZiBkdXBsZXggaXMgcHJldHR5IHVudXN1YWwgdGhpcyBjZW50dXJ5LiBDYXJyaWVyIHNlbnNlIGlz
DQo+IGFsc28gc2ltaWxhciBhZ2UsIGZyb20gd2hlbiBFdGhlcm5ldCB3YXMgQ1NNQS9DRC4NCj4N
Cj4gU2luY2UgdGhleSBhcmUgbm90IHJlYWxseSB1c2VkIGFueSBtb3JlIHdlIGRvbid0IGhhdmUg
dGhlbSBpbiB0aGUgTEVEDQo+IGZyYW1ld29yaywgYnV0IGkgdGhpbmsgd2UgY291bGQgaW1wbGVt
ZW50IHRoZW0gaWYgc29tZWJvZHkgYWN0dWFsbHkNCj4gd2FudGVkIHRoZW0uIE15IGludGVudGlv
biB3YXMgdG8ga2VlcCB0aGUgTEVEIGZyYW1ld29yayBLSVNTLCBzaW5jZQ0KPiB2ZW5kb3JzIHRl
bmQgdG8gaW1wbGVtZW50IGFsbCBzb3J0cyBvZiBvZGQgTEVEIGJsaW5rIHJlYXNvbnMuIEJ1dCBp
Zg0KPiBub2JvZHkgd2FudHMgdGhlbSwgbm9ib2R5IGhhcyBhIGdvb2QgZW5kIHVzZXIgdXNlIGNh
c2UgZm9yIHRoZW0sIHdoeQ0KPiBzdXBwb3J0IHRoZW0/DQpJIHNlZS4gU28gaW4gZmFjdCBtb3N0
IGZ1bmN0aW9ucyBJIHdhbnRlZCB0byBlbmFibGUgbXV4aW5nIGFyZSBMRUQgZnVuY3Rpb25zLA0K
bGVhdmluZyBvbmx5IHNvbWUgc3BlY2lmaWNhbGx5IGZvciBwaW5tdXguDQoNCkkgYmVsaWV2ZSBw
aW5tdXggaXMgbW9yZSBjb3JyZWN0LCBidXQgdGhlcmUgaXMgb3ZlcmxhcCB3aXRoIGxlZCBmdW5j
dGlvbi4NCg0KSSB3aWxswqAgdHJ5IHRvIGZpbmQgc29tZSB0aW1lIGZvcg0KMS4gZGVzY3JpYmlu
ZyBib3RoIHNpZ25hbHMgYXMgTEVEcywgdGFraW5nIGNhcmUgb2YgYWN0aXZlLWxvdw0KMi4gbG9v
ayBpbnRvIHVzaW5nIHBpbm11eCAobG93ZXIgcHJpb3JpdHkpLg0KSSB0aGluayB0aGlzIHdvdWxk
IGJlIG1vcmUgaW50ZXJlc3RpbmcgdG8gYmlnZ2VyIHBoeXMgd2l0aCBtb3JlIG11eGFibGUgc2ln
bmFscywNCmFkaW4xMzAwIGlzIHJhdGhlciBzbWFsbC4NCg0KVGhhbmsgeW91IGZvciBhbGwgdGhl
IGNvbW1lbnRzIQ0KDQo=

