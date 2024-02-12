Return-Path: <linux-kernel+bounces-62114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12003851BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9189F1F21B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228F63F8EA;
	Mon, 12 Feb 2024 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="PVMNLNo4"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2122.outbound.protection.outlook.com [40.107.14.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10A61EEE4;
	Mon, 12 Feb 2024 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759502; cv=fail; b=nt6dxa5vt4CYFRpyPvilE80W/Q0YH/IS9Z7gtVDcW8b0w5Dn548SJIhssiO9EsXrxjTzRwnEr1uWzu2BhSqM+xK3aHtWvaqvd9UUTbWrDr3gEyI2Rnlm5+SjyqKAwJCbwbOju7w4sPejy/oS3tScUrnWAYecsVFyPmH1cqUUzXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759502; c=relaxed/simple;
	bh=IEtViY7CaD0iO31pT2wYb++TXgnSWaSPlcgvcYY3LQA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=q2zaeVkO1yfl9gSCUVWALb2xrP2ig/8Mwnqx/65BlxEtt4q1juOMO1WJI9h1o6fChn2cxmUoC5inA4bFBZvxk9htRniSB+280GhINrxRbOkloPoOChF7n7wcCjMZpo5vNpHRb8QzbYs2tjvyAb5iWy/4p1tEstBp+OWYLilImL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=PVMNLNo4; arc=fail smtp.client-ip=40.107.14.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/2A/3RQVyh3lJ+GW36NJZmxtFOqNAVVHCmks99VfDzzP8b5HT8fQD4ZBcuGT9eLH9afc0OVt5hEsLebCTK+XVQagEHXFkCDVaOZ0rZduXwG+pv2g6pzNUO2FAc8nq3r/Oe8xubq+1/GB+5cX696rXtHQ6fPqXB0jNuO79i+xAWIfpw5osPhSvnjCTSCxQTGee6UsUtjwTGg13BWcWFOm45OUhcJkdcV5MT4ubF8HOt/N/XHfRXFrE6m2RAcQEgWMx/Fme4FRo8phV/6nGvsdykUFuU5hiURbV0aHHLJMjAbdu2ydgGHKukq439HUdMPLeWVul31Y8twWaA/ldb+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7ozJX8gEn4oDXO+mPD4jjZp1ovQwYBgUPFIyAWED+8=;
 b=Bg8t/cF8adILL2c8BuiipUpFyvror3mO8ldWrPpDj0fa75TdPbqrTNB1ar20Tekdjfod2equSFEe4i7ANNfveFrDAcnpyzcAbkMTlNv50MO3xkRBi/gzxvIKYETWKLOiLnoIJBc62by8iqWmnTA9eJYfcOGn1v3k9AfnYhycVx+c8dwW7d3/qvDEVWz+s0JHIwaTpKaED2NNnGyL3T1c0wUYHIIqeHWk7ClGgzPqueYML9JecmEBAdT6/AmbRiIxVsby/7oG+SzHnKCqwHP3nT1wvyxl7JBBmpMY4/reX3L/ec7HvacAJiqtT5/uNObwI8UJBGWs4UX3HBdJwBc3mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7ozJX8gEn4oDXO+mPD4jjZp1ovQwYBgUPFIyAWED+8=;
 b=PVMNLNo4zf9I0lVFgEIplnbquYyHjd0OlGdaTUYASoDtqVaRPwJ1kaFgC9kvvHXWvR5IER4yR49lKL3RwaQp/DpZ14/RGFSytIs6xKCGbZdXXc6YeqTBrB2eweeGo04nLaPW+GT8QtjePL6eu/uTsb1LuBqc8TQWwbQmdcCWP+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7909.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Mon, 12 Feb
 2024 17:38:17 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.039; Mon, 12 Feb 2024
 17:38:16 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v6 0/7] arm64: dts: add description for solidrun am642 som
 and hummingboard evb
Date: Mon, 12 Feb 2024 18:38:07 +0100
Message-Id: <20240212-add-am64-som-v6-0-b59edb2bc8c3@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH9XymUC/33QwUoEMQwG4FdZerbSpO10xpPvIR5qm7oFZyqtF
 mWZdze7IK7j4CXwJ+Qj5CQa1UxN3B1OolLPLZeFw3BzEOHol2eSOXIWqNAoUCB9jNLPg5GtzNK
 Ch+CNo5i04JXXSil/XLiHR87H3N5K/bzoHc7db0j/hjpIJWP0kCZE5yndt/KSo6zvy20oszhjH
 a8AwA2ADIAeLZohGBzDHqB/AC4bQDOAyfBIR6to2gPMf4BhwKbxCdAnSw72AHsFwOaZ3TLgJkX
 RAQKaPxes6/oFYG/Fb7ABAAA=
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Eugene Zaikonnikov <ez@norophonic.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, 
 linux-mtd@lists.infradead.org, Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Suman Anna <s-anna@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, 
 MD Danish Anwar <danishanwar@ti.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::14) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS8PR04MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0c8ce7-9f29-4631-6672-08dc2bf16559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jxh931NooluzDs3NaDQHdxwfbo2Ls8RsHnUQvck3KjZo+zDzeil3m+3YwU4D8mbHdOa7EOuEWxlunwIt4OiQvLWyk4M2aRVv7zzG1h9SaYANOITq5C/ZK0nsvHS5BcyWrFDwtCqk7bLU1jNl1If428Wie5obzZZk0jhiiChWF0YdLmzao9LfOvWf03OHQmxVmbUNsY8qFWeLFAuS4whA90XjYYtl1flZXL9+EURpPaGT2hly7Uix4MNKEhBqWjLZ+HfPrPnp7/kgvczBNvIoBBHaDLJMO4ZgfPRCbnrP76cBFp7R5mOouAw/IOw0MFDNqX5q0cHLspI6MTBe+0z7NBN0Ji+NZDeILyb5ePZzPhWXarP4jiDkw/uKaYBzyuGr1I/9DButXRgO+bkJdunLiPFFTIOdK5gHStSFJX542d7/ItSnwD4jTCAXqMA6ZkypKSEjCOuZQ9PDXKS1j1fEnzaYRYDklu9WwCeLMNBJzO/RJIDxPLDxazInbSog53mU9Fyq/tjrFTkxESCUjoTOBCem0hd1cchs3OP18SlJT/nG44YmMEFR8DioJc9DyXYpeB4IGh7RQobzpc0njahrVRDkz5meW6nRWU3rqpQ1fVIoIATew7tkjm6faA7k5+gI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39840400004)(230922051799003)(230273577357003)(64100799003)(1800799012)(451199024)(186009)(8936002)(7416002)(66946007)(4326008)(66476007)(8676002)(66556008)(5660300002)(2906002)(41300700001)(26005)(2616005)(38350700005)(36756003)(38100700002)(86362001)(83380400001)(110136005)(54906003)(52116002)(966005)(6512007)(6666004)(6506007)(316002)(921011)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjdIeG1PblhnMHJYT0dGRi9nRWxYNEpKTEVOU3h1THlDZHhaS256TDVBaDU1?=
 =?utf-8?B?dUVDcUJhUi9JUkRhR1pHUTJ1V1pISXRLSzVxQkxrSU8vOHpsSks0SzdCd2Z2?=
 =?utf-8?B?UGNENzJ2YWh0Q2gzdFV5ZkdscmRHSWZxNmxOZHRVclJNMGpaNkFQeU1NNklu?=
 =?utf-8?B?MlNXRVhwTFBWV2ZyMzhJV2VMd0ZzbkgwRlUraUUzV085WTFCeWFwWUVtYzNz?=
 =?utf-8?B?aUdwRGNwRTlLYnBqWktkRTROemxLQVo1Tkc0alpkUEp4cUw0M2p0RzcydEJr?=
 =?utf-8?B?TWFldm1tY2pzTHpCeUR4MUZUYUk2OHJtd0QrUEZXVXdJSEE1Y3RGekRTYVc3?=
 =?utf-8?B?Wnh0YXRqZnphekZEWXpvRTZIL2tuQzVFOGNRQVhhL0k0OTBxVzVPU1diV0JJ?=
 =?utf-8?B?YlJGTFA3YTIxS0dmLzVYMzgrWUl1RVZ0VklXaEFWZ1k0NzJhclNITURyeERC?=
 =?utf-8?B?NXIvUWE1ZC8rZW1pelR1aHQzMTBNZ3pMUFNVSEc3Q0ZCM1d0QkpHemZyR0dn?=
 =?utf-8?B?RHRiMnB5ZUYwazZnNnNIaXdQOXMyY0NYUHl6UCs5OFZmNXRFbWZ4aHpqMmxx?=
 =?utf-8?B?dFRVYVBHUVJ0bHlOOFRsS0RheGxHTlJad3d0NDQ3bExGVWJhOEk1SFc0OFcr?=
 =?utf-8?B?VzFDNDhrZmdEQUtrWngzRHpSWktZMU9WVGpaUFB4WnBsUmhrVldxYWVwSVRP?=
 =?utf-8?B?cU9YMExvNlNDSlN3alVrNzNNMC95NTE0WGVaWDhrMGphd1VWbTcxYzFFL0JH?=
 =?utf-8?B?cEZ2UnFVaGVTTEVSRm0vQm9GNml0YUxNT0IrR240MWt2dDgzZXFIZTlieThi?=
 =?utf-8?B?VVc2VU5ZbGNXQ01GTk8ycmxGWDRDL0Rnb3VZejJmMEx4TW54cjhFb01jMW1k?=
 =?utf-8?B?ODZLR2Q1R04zM1JVOXRNc2FPdFZUOXhmRlJka21qTUxaQVFLR0lKR0VMZ3VR?=
 =?utf-8?B?d0F2REJ6djJudlpoeFdOZ2gwTk04d3JMZjB6VU1FYnl1cWYxU01wL3p6eEpt?=
 =?utf-8?B?by9YaXNheDBCM1RFQml0WGgzWFlsQ1RBWHdaT0xMTHRRRGxheDg2Q1hRa0lj?=
 =?utf-8?B?NDdrUDdmYzY5eFBEejgvV2pNYXJJSWZwbG1iS0tkaG03cDBrS1BXMTVCNWpJ?=
 =?utf-8?B?bGl5ejgzejE2RjVJL1lXeVd6dmsvYkh0ZzFpZlBRdXA3M2ppRUVDMkVrTGRv?=
 =?utf-8?B?MjdDZzM5VmRWeHVjZG8yRU1uYlFvUnBNbjVxRWpvYUlLQjlUN01SMlRHRnlC?=
 =?utf-8?B?M3dIQi9NZFF1SmgxZjNpbUtDN2JOaHEvUWtSVjQ4YmZIenRoTWZPSkJ2RHUw?=
 =?utf-8?B?VFJ1NGRuRFZEaGwwaDhJVWM4M3BZSGpvMVBZelRrVkZLT0lISk9DN0NuSS9k?=
 =?utf-8?B?Y1BFWjVFT1hOK09odERBb0h1blUxUGFxT3V6WHBESDlCMlp4YU9JdXNEYTg0?=
 =?utf-8?B?SlY0WGVFU3gvZTJoQ2JpbWhqK25QQlFSUlNLT0MyQXk1bFlpZm90LzQ1eW43?=
 =?utf-8?B?WXBBZVphcDlKNHFsenZmN2tQWnI5alRtK1ZQTWxCTkJ1dW9WOVFRMC9aYW14?=
 =?utf-8?B?cksybWo2dlVNT21ydWlzR3JKMTNTcXcxR2pJbVJHNUYrNkFPc1hic3NOOTNw?=
 =?utf-8?B?RWtjOE1xejBUTnlFYlZaQ0pMMzMzM2kvUVpSZmNLci9aY1crdHBUTHFnQ1BK?=
 =?utf-8?B?V3kzazFrNUZDdU1QYkpyQUpURVJ6RVpXS3prSDdMZGRqNFR3cWlrSXpwVVNo?=
 =?utf-8?B?bDZKS0JKTUJiWWw4VGNMT0VRcnM5cVZnS1hXS0xMV1dRZy9ZVEhNLzcrcVl2?=
 =?utf-8?B?TmpzMEpwVE4yNVd1V2JIVE9sVTNUNHMrSGNQYjRWdzJNSWlHcHJmYWJVcTVY?=
 =?utf-8?B?ME1pNkhIK1dGRnRyTmFGZTBZTjVYWWNpdDBWckRaSnJ3UjNzL3diQXFrWHow?=
 =?utf-8?B?TjdlbG5xRVNhWDF1K0JqUW5ZOUNmeC94anN5S2dka0h2U2hlZHBUR2JGU1dF?=
 =?utf-8?B?MlFSaHpabmhDbmhPQndSOUVPa3ZmUjdOMWt4ZVhmajBMd0ZLcFJKNW1FTjVh?=
 =?utf-8?B?UHJPa3I1NlI3UlNDbk9Ma0pLZDZ4TTV1SWVjZDVPRFVLN2c0WHdYYUpVMzhR?=
 =?utf-8?Q?qXSRQm5s8rcB7cXNqkeRdZKOP?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0c8ce7-9f29-4631-6672-08dc2bf16559
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:38:16.8912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvgID/0Iq1icugwn3ADEmXbby2PrvD8cnGmZtbpNP3AQWLo1O6I992/QEHB+uqTQSlj63Xn4VheP+DslxpniVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7909

This series adds DT bindings and dts descriptions for SolidRun AM642
based SoM and Hummingboard EVB.

Additionally a commit from downstream vendor kernel are included,
enhancing support for pru based ethernet.
I wasn't sure how to properly annotate it in commit description /
signed-off area ...:

1. add description for "Industrial Ethernet Peripherals" (IEP) to am64
   https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/arch/arm64/boot/dts/ti/k3-am64-main.dtsi?h=ti-linux-6.1.y-cicd&id=5afb73d82a014b59462162d960b350b8c58e5ae6
   IEP is already supported in-tree by a driver, and used in
   k3-am65-main.dtsi.

Unfortunately dtbs_check still reports one problem:

- 'mux-controller' does not match any of the regexes
  The expectation seems to be that a mux-controller at minimum has an
  address, something to put behind an @, e.g. "mux-controller@7".
  However this mux is not on a bus, it is just a gpio-mux,
  not sure how to name it better.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v6:
- renamed pinctrl nodes to *-default-pins
  (reported by Vignesh Raghavendra <vigneshr@ti.com>)
  (dropped Reviewed-by: Andrew Davis <afd@ti.com>)
- removed tabs from pinctrl comments to shorten lines
- updated humidity sensor yaml with interrupts property
- updated spi-nor flash yaml with interrupts property
- Link to v5: https://lore.kernel.org/r/20240211-add-am64-som-v5-0-790ed7121249@solid-run.com

Changes in v5:
- abracon,abx80x.yaml:
  - reworded 'compatible' description
  - removed $ref to interrupts.yaml
  - nested example in fake i2c
  - changed maintainer to rtc list
  (reported by Conor Dooley <conor@kernel.org>)
- patch 4/5 dts:
  - re-added status properties for sdhci nodes
    k3-am64-main.dtsi has been changed in-tree since v1
    such that sdhci nodes are explicitly status disabled now.
  - picked up reviewed-by
  (reported by Andrew Davis <afd@ti.com>)
- Link to v4: https://lore.kernel.org/r/20240202-add-am64-som-v4-0-5f8b12af5e71@solid-run.com

Changes in v4:
- abracon,abx80x.yaml: fixed dtc error in example irq reference
- Link to v3: https://lore.kernel.org/r/20240202-add-am64-som-v3-0-2f44023d50e9@solid-run.com

Changes in v3:
- removed lots more status properties, double-checked against soc dtsi
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
  (reported by Andrew Davis <afd@ti.com>)
- removed intentionally-disabled pcie node from dts
- rewrote yaml bindings to use enum instead of anyof+const+description
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
- abracon yaml
  - added missing maintainer
  - added diode type property type
  - added example
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>)
  - added reference to /schemas/interrupts.yaml#
- use generic name for pru ethernet controller node
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>)
- removed unnamed dmas from pru ethernet controller node
- moved pcie/usb3 features to dtb overlays
- Link to v2: https://lore.kernel.org/r/20240112-add-am64-som-v2-0-1385246c428c@solid-run.com

Changes in v2:
- reordered patchset to drop separate patch adding iep handle to som
- moved dtbs_check warnings to cover letter
- converted abracon abx80x rtc bindings to yaml
- updated dts:
  - remove unnecessary status properties
  - changed non-generic node names
  - use color property for led descriptions,
    they have no default function on evaluation board
  - drop earlycon bootargs from chosen node
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
- converted charger node to comment, part not assembled, has no bindings
- picked up acked-by on board bindings patch
- Link to v1: https://lore.kernel.org/r/20240103-add-am64-som-v1-0-dda1f9227aef@solid-run.com

---
Josua Mayer (6):
      dt-bindings: arm: ti: Add bindings for SolidRun AM642 HummingBoard-T
      dt-bindings: rtc: abx80x: convert to yaml
      dt-bindings: iio: humidity: hdc20x0: add optional interrupts property
      dt-bindings: mtd: spi-nor: add optional interrupts property
      arm64: dts: add description for solidrun am642 som and evaluation board
      arm64: dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb-3

Suman Anna (1):
      arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes

 Documentation/devicetree/bindings/arm/ti/k3.yaml   |   7 +
 .../bindings/iio/humidity/ti,hdc2010.yaml          |   3 +
 .../devicetree/bindings/mtd/jedec,spi-nor.yaml     |   3 +
 .../devicetree/bindings/rtc/abracon,abx80x.txt     |  31 --
 .../devicetree/bindings/rtc/abracon,abx80x.yaml    |  79 +++
 arch/arm64/boot/dts/ti/Makefile                    |   7 +
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |  24 +
 .../boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso  |  45 ++
 .../boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso  |  44 ++
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts | 292 ++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi        | 594 +++++++++++++++++++++
 11 files changed, 1098 insertions(+), 31 deletions(-)
---
base-commit: 83d0ff463b50d2395e05339a34e35d14ba82043f
change-id: 20240101-add-am64-som-51a1ca47edf3

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


