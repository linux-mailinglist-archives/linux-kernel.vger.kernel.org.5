Return-Path: <linux-kernel+bounces-49940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3CB8471D2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 738CDB2A025
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1373E144624;
	Fri,  2 Feb 2024 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="WNkmhb0U"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2105.outbound.protection.outlook.com [40.107.22.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D797814460C;
	Fri,  2 Feb 2024 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883749; cv=fail; b=RHsrSBLw7F2nHDgMaouM+FhkWr73NT35WPNRsQZduz/Tlb2G3Pw1e5xAEAPBjLBbm9f5mhc/qHWgALxwfpIYwFYoErrA6hPI0RXui7Nhr/afygGZNZQ6HAAZSUkZjBpfClr/WvsWPq35uXtRBLabqwbrkXYHorf5ap3ttMoo8GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883749; c=relaxed/simple;
	bh=WSQP33IDEhBriBwDLMC+uoEcmCdyJAiNT43VjAzwp40=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Hdgt8BJum44TJiAtGXW/2C2PNFGuAmY1SkefZEuftMi/TBAXmy9n7ueV2HGuP7rXkCRnJNGwrrbdXknAXszVDPr+VFevf61sWEhuUJjftwtBEYGzwakQHk+NkmtOoAalYFDuGTUcEm1Zjg8BxPJLE+VBEfeN0Pl7l5KvtHaufOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=WNkmhb0U; arc=fail smtp.client-ip=40.107.22.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDlGtyWfP5y1jWQxeTtizVfw+HClBw/6l2wX1T4HBmBqnYsQlsD7e+zoaJ4IZB6e7XOWcDWIgCiXBK8w6A4S9TAgVX/WCyCL4kVlY4d8gv/CxH3Jx9qVnQq3MQEImp+aKCRtx27MPMkwkMz8Cg7LsOozQJ1ulBogt67b46LMRtMZiZ/C2i+JgAcIrvWr+YysGRzgukpbUIz7TXiAz/p9k04JX/iwLsMZkmVu/2M6hST8rYPFroTFbNtg+e/eAHrhU29bPpA4OMU7JBQUcPBY1Raqn8SKGmTNxWOh2CBFpuTEibDeeQ7ml9sJfrWK0/cD0feB+87ZwWNL+RkHcetc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hz0xKYn9qGcauF0wSRJBZ76G42t28i7K6qPkeazRAQ=;
 b=RCh36m8mvtT3pEBmjY/CydBKnVhjfQlPmDwKW5DnOKAZAEhwo3olBlojYIeK8+ADDQZbA8aRAvtBN6rakR3wgkKQ4DKLd95uA76wGDnO0K6v4LxP4C4w44DxtDCEbirsEEofPhPGcUQbrSCM1hRN7gWPshcYOJHvfgNKtzuLs/VgVgleJxUJaUdfEegyE0fizPlLekCxKEymfnR7ng1gZ/yiIOQDPmQy9sKX1bw3Uyo5yeVzLTOuI52xK0xk3nPwijctwxHWtVC7GMj670sYNy3pEhAMdGCup0kFekyLqa0Eb66ovXecBGf2qa5tLPBJGG/TTglthh7WSICtlfRUWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hz0xKYn9qGcauF0wSRJBZ76G42t28i7K6qPkeazRAQ=;
 b=WNkmhb0UptTlvetss4objVplwTAO6vm3xtlM+g9DOrlYmoC8Gocy82d/NZSgNFCW9NiPFTZKzmv/N4XulEj+hYfzNHapjpYKiVmxunKTSItGpUzEs1WnK55Dt1d/e473PgYdqaPLQkTluWqI9XDZs7YKAf5bYxIwzTISq7iAWYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PAXPR04MB9007.eurprd04.prod.outlook.com (2603:10a6:102:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 14:22:22 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 14:22:22 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v3 0/5] arm64: dts: add description for solidrun am642 som
 and hummingboard evb
Date: Fri, 02 Feb 2024 15:22:16 +0100
Message-Id: <20240202-add-am64-som-v3-0-2f44023d50e9@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJj6vGUC/13MSwrCMBSF4a2UjL2Se5M+dOQ+xEHIwwZsI4kGp
 XTvpgVBO/wPnG9iyUZvEztWE4s2++TDWELsKqZ7NV4teFOaESfJkSMoY0ANjYQUBqhRoVaytcY
 JVi73aJ1/rdz5Urr36RHie9UzLusXEv9QRuBgjEJ3IGqVdacUbt5AfI57HQa2YJl+AKQNQAVA0
 dUkGy2p01tgnucPbKDmLu0AAAA=
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Suman Anna <s-anna@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, 
 MD Danish Anwar <danishanwar@ti.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|PAXPR04MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b87df91-c5e1-4253-0f2a-08dc23fa5ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qgJsC0ri/YQW+F6rmD9QC77OalKSGROWuiiGdIRyp0rqjRbYFP8kihSdhmSTFIjTZe0N+UuUOr8rA3qfPBJ6ICa9HpfAxwjTDZJu/LFl8uE5+pjsYXuH5a0SVugObqLM+ivxTrizHBNuBUyNuo+YR5rVuP9Wd4DTkIyiZp+eGUq3lyhpPKlCJX1TdbGUX6wYd2r9YYNi1nlWjvQgifecgZje3y7rSEYij0jFLaJRD14/EGS+fJIIcxHM4BSx+SZ8BT1aeIj9f+6TqtZ7Eu667CK0JgyCl3XEvNyj3RyKkpk6Gi2VRhD1yFA18Qak8Fu4RbeU9g7KShoXDmhnrb3DcSR41IStrIopIrd1k6RTmUYnjdBP9P5AStYh221uCg0lMqi3no79ZokaTHTpI0PhkQnURpP7iJejN2v8CCf+Zf+3uMueGl12gT6ux+p/zP7iK23FepuEBZe2NTL3rzygKwumEe1KmLs0WGmCE5fWJaUfmGg3kJvVKdD8smL1ue5XgB2tFPIXiGHpVBrBGmN4f3wDzzMMpqbKpo0WS2CCjyQZZowAtNKmSc6/uHCbEeNvuJeRAOrsOfltQEVenO8DPthodM2P2AusQGAZqReFcjp2LJ0aq5UXc7NSv0yKxqvnFHMSYuMV4w2F3ZXCoCS/5w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39840400004)(396003)(376002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(26005)(6512007)(38100700002)(7416002)(41300700001)(83380400001)(316002)(66476007)(6666004)(478600001)(6486002)(54906003)(66946007)(66556008)(52116002)(110136005)(966005)(6506007)(2616005)(4326008)(86362001)(8936002)(8676002)(38350700005)(36756003)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUl2citXVU9lcnZjWEJURkdzczlVb3JqZm9kMWg2M1FUKzV1UFptSjdOYUtm?=
 =?utf-8?B?ZTAvUlpEL1djY1M4WUZQRFBXYnRqUWFqMXpYbkhPeWJzNy96enNwSjBLU2Nu?=
 =?utf-8?B?MVBnK2gxN1hKSkY3dm9HaEo0dy9MQUhIMjR3NG9ZdjNBV1hRSy91Q1RDcCty?=
 =?utf-8?B?S1hIVDd2anNFSFUwck8yNXFoaElnaEhmMzF4UkZGeTJLU0N4dHlYN0FvVHR6?=
 =?utf-8?B?NkdNRzg3OGw0aDdGTnludFFuWk1Xb201V1BtTlNXR0gxK2lGZi9jMjRkSGFM?=
 =?utf-8?B?QjhpOEhCK1RFdyt0Ym1aVkJRdldHeUJURUNjWmVaMzFXK0JUMndXdFg1WVpM?=
 =?utf-8?B?RDlCemlFVEt5Vy84ckUrZStCZmkrK0hpSEl6YkFYenNPTUR4bW56YTVNNnRC?=
 =?utf-8?B?TlB3aDJaL1VIbXB0WjVyRm5PRW1kN0RVT0dnUWxKNFVwYmhPN3FiTW1sUTdi?=
 =?utf-8?B?Rk9hTDdPMkVDUVNtdXpqZnJ1YzB1bVB4NWJjcU1wVjUvU0tuNFN5WXBobFRQ?=
 =?utf-8?B?Ni9ZdHZUa01oMFo4eWpLRVdQQUhMbFFDb1hwUlBzRVYyUzFEdElpK0N5OHFw?=
 =?utf-8?B?Q2c2c0E2aytXQm9WTTB0bGFMeUpEQWtySUhzdlBmSWpuSmoveHBWaFFqaHBs?=
 =?utf-8?B?d2FNSVhDcVFBUFN0aVpCVzFIZ1krUm8zVUdnSzVUY204Z0hxRHEvSmUyQlpV?=
 =?utf-8?B?bDZZdDhDN2lDeE9jcjN4SWRIMy9iM3RiV2MzSlFzaEQ4NnpkQTdQeW9ORC8y?=
 =?utf-8?B?MDREeFBWaFlPRmhiZUxBNXBrcVZMb3pzME9FWnRYR2kvRCtmcUJxNlk3S1BR?=
 =?utf-8?B?Q3luVUxPNGZSWEp4ZzJJV0xLa0Z4MFJUdXpHYUF1NG1WdWMvOE03Z1JjNlEv?=
 =?utf-8?B?R3ZNYWkwSnNpaUhDYlVJS1dJdWpoQVpjVUVUZUs0em00NEZjbXJMM0srYkUr?=
 =?utf-8?B?ZWZMQ1ZMWUdEcWhLcDllYzR5c2NES29CQU05Kzkrems3OFlrWDNTWTlpMklK?=
 =?utf-8?B?dGp1bmhrbGx1K0NQWTJ3TU5KeU5MeFZmZDVGam5lQzFiR0xpbjRQNWxudWo0?=
 =?utf-8?B?eUZGcVR2bHFxK3FQS282TzdNS3F2Y2Y4WmY4cTdjMEpYTHdZdkJ4NlQrYW95?=
 =?utf-8?B?Z2Q1bjY0dTNhYTNtb3FUZXVLendPRmZSMGwvMEJ1b01VSG1wM2N1dExyY2hE?=
 =?utf-8?B?ak82NlY2TzQ5K0dndTV4SHJnc3hCZU1FZDZlUEd4MTkxU1Y4ajNhbGFsRyt5?=
 =?utf-8?B?VTZQckR3eWo5WFNxQ3hjNTdOY0JPei9EY1k0a2N0SG1HdG9aTkRsb0EzN1Ny?=
 =?utf-8?B?WlA1OHVxLytGM1hZa0VrMkMwQXhGVHIwekNqMkw1dDRaMXJFNTFhUG9oR0JM?=
 =?utf-8?B?NjcrRXZhQnllTFNKWUs0RmdGZ1JkSkxac3VZOFZpRFREcFFVejU5aHhyaHdI?=
 =?utf-8?B?bXM5Q1JQYi9sMTBOREFIZVliMTBZTnZsVllTc2JMbWZWL01mcHpTR091ZjRt?=
 =?utf-8?B?cHVxcHBZQUIxUXIzRnlaUW1ibWhESnpLNXE0OFRuek1QdmJwRVVZWG5IODBo?=
 =?utf-8?B?NXFla3JnTnFKbk8rQkVjNnpRNnkwTzdXbWZUdllzeTU2c2hieGRCOS9HYk9X?=
 =?utf-8?B?S2xXaTJraXM4WHEvb05CQk9CUDVkSlV0NnZncm1rTUZScitYMnU2MnEreDRI?=
 =?utf-8?B?ZUtFZlV4aXprcjgwZHlyL3NBd0FSMGEzcDRLdzBBTGlNTnhZNUR4V010RTRw?=
 =?utf-8?B?QzJOQ0NDaGhVRE5UaEtCY3RMWTQ3YkdBYlh4S0d0ZktJaWliOW0zVHJvTHpQ?=
 =?utf-8?B?RzFXQ2RMMCtjNWhnQmpMdDAyYi9lMHNIZWRwdm1PR01GTEdKRmd1QU5xOTJr?=
 =?utf-8?B?RlU5a2VnVFM2cU1idDBBZTN1M1V2dmNjei90M3dDT3ZMRzhBaTY1T2ZqZDV2?=
 =?utf-8?B?WXlBWm9CeHB4UERZVVVjVGxmcHREeXYzd2pocVpMSk53b3BwQnVVWm5yU29T?=
 =?utf-8?B?ZWNtTHVwUnU5MGtlWE5RdHFrWDhoaTc2YWkwR1NOWFNrSFRHNVBQSy9TQUcr?=
 =?utf-8?B?cWprZ0NKUWY1OEIwRDV1L3hESUZma1MrbXEzVmZsMVVhZHdTYWg2SHFlSkZP?=
 =?utf-8?Q?skYotvsyu6zsbiqEPxXADETLS?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b87df91-c5e1-4253-0f2a-08dc23fa5ed5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 14:22:22.1132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EvsiDC4XCyFBkP3WGzGyvQYR9PrlOyotZOzMS+cMaggew9eef3FkcApDS3n3Bkd3Iq4R7bqsFvTsDjBw7S6gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9007

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

Unfortunately dtbs_check reported many problems, I put some remarks:

- 'mux-controller' does not match any of the regexes
  The expectation seems to be that a mux-controller at minimum has an
  address, something to put behind an @. However this is a gpio mux, not
  sure how to name it better.

- unevaluated properties: interrupts, interrupt-parent
  sensors and flash yaml are missing interrupt descriptions, but these
  parts definitely have an interrupt signal in this solidrun board.

- wrong names for pinctrl nodes
  Other TI DTSs consistently end with *-pins-default. Should a different
  naming convention be used?

- cdns,phy-type required property
  inherited from k3-am64-main.dtsi
  there is a PHY_NONE value in dt-bindings/phy/phy.h,
  but not allowed in phy-cadence-torrent.yaml

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
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
Josua Mayer (4):
      dt-bindings: arm: ti: Add bindings for SolidRun AM642 HummingBoard-T
      dt-bindings: rtc: abx80x: convert to yaml
      arm64: dts: add description for solidrun am642 som and evaluation board
      arm64: dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb-3

Suman Anna (1):
      arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes

 Documentation/devicetree/bindings/arm/ti/k3.yaml   |   7 +
 .../devicetree/bindings/rtc/abracon,abx80x.txt     |  31 --
 .../devicetree/bindings/rtc/abracon,abx80x.yaml    |  72 +++
 arch/arm64/boot/dts/ti/Makefile                    |   7 +
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |  24 +
 .../boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso  |  45 ++
 .../boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso  |  44 ++
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts | 292 ++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi        | 592 +++++++++++++++++++++
 9 files changed, 1083 insertions(+), 31 deletions(-)
---
base-commit: 861deac3b092f37b2c5e6871732f3e11486f7082
change-id: 20240101-add-am64-som-51a1ca47edf3

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


