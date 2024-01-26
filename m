Return-Path: <linux-kernel+bounces-40433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1AC83E00E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DA228193C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD9B20DC7;
	Fri, 26 Jan 2024 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="LXXSImBb"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F48B208C0;
	Fri, 26 Jan 2024 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290126; cv=fail; b=lKBm9LfochdCRVVD59GupFr5uej791Zt4G0QYew7jP1ZFu+v4o7FWg8q9R3RSYcREx0vf4FokCu9CYSa1UsI6mmmeVDSSVo0j5L/JDowLHkmlxJBB29c96rfmAP2hWfW5ljToD7TCUDib8qhhL7YJYGCjDWLUKuHiUnIs/BympY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290126; c=relaxed/simple;
	bh=bU8QzIIAEmLwIHySXLaVymY4yS06nq9pd0KTDM18h3M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nh98flohODleQrVgqFa2ck6iWfhr9fF9yCCA+DlvRUhFJpRqlKOCgX3/Z6WFkz0FFKPgvFzdGpX3IIzBATc9PwXpGZOSVsu3WbujhI+55eNqtkG0zkCSk9FTptKISp8/ZG5eFmPdS+upmmgv/c5wSaTFa2ER7Ca+tNF4Vz499sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=LXXSImBb; arc=fail smtp.client-ip=40.107.7.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/XWUTVnGXM8fkCyYKfMx3EI0DXgTnt0indLa3kHSZCpsSiOW6oA+gY9aOvTt3uABrq1/yjPEELXWjgJfW2Db5fh9rE6KHM6BDS3/mFmC258iGXWJJRECtiFMQCTYi9R2TX5/XQHFeSEpFGvsCzfVjNo+SYnwI1PRS7wTH6P2vfe6xAgYhl4Q8epmmbOWeYxeRMEoAmpL01a/bC55Z2XvgchtOe6ThQskLaciFXJalZS+RwlU8Z4PgLSx1APecfihzDegg5rYq4cIcvfQRRJQDC9dBMzL2VMcJ/wlka1kqTHAGPz/QbSYz3Y+gSCrg4q8d4KfeA86FWckGEFty0QOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wb46A5LLYS4lPodtjzqkEpywdweV2Ij7mTZrNtpcHr8=;
 b=Q4JhFCNOzH0egUqrOZG+xJqmD6XqW13DMyfMeb0QDDgowgKPLmePMjMFTssOhMW1WZ/pa+FF0tza2hqiDWOx7jO0gtWZg2jHgpdGGHPWiAJHtBGTR08SRTk+M/CeaIOrHRotcee9qqPAIw6xoF+9YbBfPyMGqHn6YdRf4QMuRrAl00AS/XO6sOyNPiYJMDLVsDl/Ips40zKrT7MG86LKmm6HmeMuJwhE1buzuQeByDzew237gt7brhCft2PsyGuqG51wcV1T9+DP27RZZt5h19RcbP4hVj3KFfLquZ5gp4B/oS5H8/sI/MTHY1XJlXGPiXkktLTPaut7kffmoiiZSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb46A5LLYS4lPodtjzqkEpywdweV2Ij7mTZrNtpcHr8=;
 b=LXXSImBbBh3Rl+kbiyZr4VbxpAIwgJCN+uXKjzLTuLJNIeh/Ri3F+QTK02UKzphvOTU8S8u5s+vThDBgQ6is7UqvBbAKHgIlOKEJMT0DG2A4ZpJ74bkygJOnfnPZDQ1UOfwb4pLo/bcwNNuVFQDci3wm+fLTUxaJAJ3Qz0wDIgST7idzOcSr6nNuIRpYaBMnP67/wtpJXnhd37WH41V2jioGiPbhgpE0KGGrt43IQ0CJDZZugR4KqWF5BSi4q5rdcfGQxIfIu6jAmdHDyccKrkN83qAmGQgxEV7Af90DM6nnB9CaHv6J/hlkHmz/PrATNN9GsFcRUAKHiRMqp0e7Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 17:28:36 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::d4b1:cea8:7085:ec50]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::d4b1:cea8:7085:ec50%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 17:28:36 +0000
From: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Date: Fri, 26 Jan 2024 18:27:44 +0100
Subject: [PATCH v5 3/6] dt-bindings: serial: add binding for rs485
 rx-enable state when rs485 is disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-dev-rx-enable-v5-3-5d934eda05ca@theobroma-systems.com>
References: <20240126-dev-rx-enable-v5-0-5d934eda05ca@theobroma-systems.com>
In-Reply-To: <20240126-dev-rx-enable-v5-0-5d934eda05ca@theobroma-systems.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 quentin.schulz@theobroma-systems.com, 
 Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: VE1PR03CA0003.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::15) To VE1PR04MB6382.eurprd04.prod.outlook.com
 (2603:10a6:803:122::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6382:EE_|DB9PR04MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: b466c037-1544-4b2c-fb7f-08dc1e9439ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P0isZ+qFcu1OXMAuorUI6IbCuDe7YsNZQQqGx+wzcLJcggDWwqLvFBJpMh41fenSz8nFdNrE94kcNFasCpIL+mxGVomi//1ZuYnObenKWfP0Wq5AmUY3DykEs2W4aha/4CPFg60RvXsUeQkz5cMyFypRSOp3DkK0h6ImfiEuYacyw+yp6pY94NbFqJSD8lhsIp9mdA7Cq3u26BSBgrqZj5sjdQzEsjdRKQheTmB5faoBHtk2PJIySlNudpScikS/QFOmQ0RHNMhx4v9tzxJHmr93I6b9Cyf/LZnk6+2LG8M6SYEc8WwgqFcyye8uPNdKk0UQszS6HpmeKoTzNrRm8/UJ02WOnzvU+2zY4DASHIOvb7fHKSWt6sx6MoZQOp5Da+41JAS+BoaRjQ+6XsqO5x1Do7WxmjTqO8vzGa4jKkR2528BSWFJVpDWhZTMIYp+DzsTNHvh/99kVEh7nNbJRPiBOpBb1wRqxZFMVd8nqqjNkbfWetY2ThQdkdmYsI7F4CBXlkjph6O5rz2FTOp0IkFiJ/vuldEDZbBSOgU9HYCOF88sGhOnv+Vdt0zzJRY8QUMxm4jB3tyN/bEMlmc9VpaeppjVIbKKwTThb0axwLI6awFxe+0AYZEyxc3UDRUD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(136003)(376002)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(36756003)(478600001)(8676002)(4326008)(7416002)(8936002)(66556008)(54906003)(5660300002)(6486002)(44832011)(66476007)(316002)(2906002)(110136005)(66946007)(86362001)(6666004)(38350700005)(52116002)(6512007)(38100700002)(83380400001)(6506007)(2616005)(41300700001)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmxFZnQzM2Nmc0ViL1pXM1c3QjlwTjVZZGZnVFo5U1ZtdURMOHdVT0E2eU9L?=
 =?utf-8?B?TG9CaElIb2MxNDY0YWJjSlpNRDJXSVdJZTc3SXhzM282dWdlQ2RjTVU4N3hI?=
 =?utf-8?B?Qk02bDhpMHQ2c0tIaFBaM1BLYXRrN2l4OWlKUFNzK0Y3THRSMWNidVVDQXJq?=
 =?utf-8?B?cytveis1NFhkZGRZdUd6Y3kvUkdxak96NWUzMlM3QUQvMThhOXhvQlAyWGxk?=
 =?utf-8?B?b01OcWw5ZDg5MGhiMDJoU3p1QkdZY3paZzBpc0psRE9qZ2pzOGhmRlY2dFZK?=
 =?utf-8?B?NVFUZWZJZ2ZYZ0FoOG5SNTltRFl5Uy9yc3ZrdDV3clkzazNXZUFYWkhMb3VT?=
 =?utf-8?B?eEREQ0R4ZDhVWlhSTXhXdlFYWVBmNnhZcExualQwZ1hHMWt6YUQ1cFlqS1pQ?=
 =?utf-8?B?OW02L1BFVURvYTZGSEllODFDVTlFcnYydEN3MG8weDZ3L3NDUkowRHVmR1VF?=
 =?utf-8?B?T3Ayb3c3WWNqNExSTytTVWxKYVlpK2JYcThkc3RvQ1lqS0Z2NmNLMks1bVRI?=
 =?utf-8?B?S1B6Q0FpWVRqZXAwSUFCbFA5TkExVXF1cDF3OGxqRXpVSk1EUXpKL0lBZDRp?=
 =?utf-8?B?MzlwRGdpVm8rOWNpQmxldDQybGtIWjNiLzd0RXdCaTh1czZjYXZYSjIvKzNm?=
 =?utf-8?B?UzRwaVF6UHdoK1dDQi9tVFh6MWYrZW5TdEtPUHVMRExmYTJOVitFd2NhekpP?=
 =?utf-8?B?cE44TkdSQ1U1Q1Q2OXk2SmpsbDJHK2Y0NSt2YlU2NDRFSjVIVWRsMDV6bkdi?=
 =?utf-8?B?RE1RVjBZcjZDVUJNaXVhNlBObTFTOUhSWCtoQitiUmZmNGF0eDhYZmFqNWJi?=
 =?utf-8?B?VWthNWl1eDNGc1JUZTB1UG9LSmRWcHliYkdaNGV5VnY5TnNHeTZpbXFoT3Y5?=
 =?utf-8?B?RzlBamdraS8ySThBd01TMCtMR0lUck1wNklzc3ZoeHo4SHBLWW5oTGtsZDBi?=
 =?utf-8?B?aitCd0c4c3IyZGhMdkU1SVZQVFN4QUZMLzU3RGxCSUVIYjVyWFN1VUZERCsy?=
 =?utf-8?B?YVRtdHFjVisvMVhpb1RWa05EZ2ZPNFd1RDRtajMvY2RGZnc0VEQwS0tWc2Vr?=
 =?utf-8?B?WDczT1pLQTJ5SWtCb1ZucVF1ak12QnNlM0QvbmJPYjR4N3BwVXF5VVl1akRI?=
 =?utf-8?B?WVVFNVFZYS9uNDU1WjNUSlkzaytPT3FTWXpNSUswOVZVRHY3UVFyS3VJci85?=
 =?utf-8?B?NDJGUnNtWVpPTWpJUzFKY0lqbGYxNTlUL0Zqc3hSZ2FaYVpSSWVRS1l3M21m?=
 =?utf-8?B?Y2UwYVd4TlhVcHdiNDVNR0lEeGhXbUxSOEErWUlHMkl1Vkh5VkcvdlNwczI0?=
 =?utf-8?B?bjY4ZlkyRUxqVjVEc2l4TlVkeEwyeGhmTHRtSEtaU3IzMWtBcVRBb3Q0Skk5?=
 =?utf-8?B?Z3QwTmt5MFdBN1V6bE15MTcxeTExaUtSWmFGTzlOV2NUZnc3Z1VmK0VwTW8r?=
 =?utf-8?B?WmJyeUYrVjErTGhrQzNxcndEOUJlMlcrT2VzOHZCdWwyczFoY0IrZjFGV1pH?=
 =?utf-8?B?T2RJUU1lUUZQcHNZUzdoSzdYRWlWNzJhazExQTZZWmpodjZVc1dhT3ZmSGRI?=
 =?utf-8?B?L1UwWWFJMnFBVE12eU9JSzZPN3lCRk5PNm1RUFNhKy8reUlCVzhLcTlIUFE4?=
 =?utf-8?B?Q1ZGNzQ4dGlTcTJOOUI5bGlJeDNvVEk5L3hWMWUveDlFemRvaUhGZFc0Tzcr?=
 =?utf-8?B?bEJONjEvSmFrSENFRGdnVzhpcXUycElGSUlSVG9mb1dnMVNWcmU0K29CcHhz?=
 =?utf-8?B?eGVXZnFXVXZtM0tUcUhPOVJYSFpxWEh0RVlOTEgzL2hxOHp2bHZraUlhNlBr?=
 =?utf-8?B?ZFZ5TVJNaW5JT0tLSzdrUllXNkh5RkV1b1FVdWQxa241enE2d0hZUXJSdHVT?=
 =?utf-8?B?K0NWaHd6TnBEMWQzbUFiM2NOb3hTc2NOcVRZM3dWWDBKR3FFTWtKZUZsaldx?=
 =?utf-8?B?OEFMcm5kTDIzTWF0bUFWazRFWmx0VWVQMkl3OXF3SDJ0cFdQclY1R05HMUZt?=
 =?utf-8?B?VmRjVXRLYUZNdFlxSHBOZ2k5N2Y4NkxLWmNVaUUwS2o0cFFLZ0hzd08xb01o?=
 =?utf-8?B?dFJpdkw2b250Qm5rakwwalpmZUMzWHlFV1hZVVQ0clY5UVl2cWRJMmxZb2Mz?=
 =?utf-8?B?NENRa3VXMWxkbnpZZkVkSlBIVGY0THZac3orVXA2aTdoVHNHeXkxTm8xOXhC?=
 =?utf-8?Q?gWiVhu04/wd0wokRlV2o59w=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b466c037-1544-4b2c-fb7f-08dc1e9439ee
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 17:28:35.6552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbiBoWmkXLfXnlwJODFn/Dnp7Pi9Jh5rGwkEotyIribKFu9Swr0HAjyfmZxUVUCMi7sP747yZAMs9UHT/tkrT8uSCca+S7m15Lvz6ZwyrxRaSU4z41nDXMUJ8TTWjs6n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820

RS485 can have a receiver-enable gpio (rx-enable-gpios). When rs485 is
enabled, this gpio, if provided, must be driven active while receiving.
However when RS485 is disabled this gpio should not have an undefined
state. In that case, as DE and RE pins can be connected both to this gpio,
if its state is not properly defined, can cause unexpected transceiver
behavior.
This binding depend on rx-enable-gpios to be implemented.

Signed-off-by: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
---
 Documentation/devicetree/bindings/serial/rs485.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index b64577036b5c..4c79dfaaf460 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -55,6 +55,11 @@ properties:
     description: GPIO to handle a separate RS485 receive enable signal
     maxItems: 1
 
+  rs485-rx-enable-inactive-when-rs485-disabled:
+    description: rx-enable GPIO is not active when RS485 is disabled. If missing, active-state
+      is assumed.
+    $ref: /schemas/types.yaml#/definitions/flag
+
   rs485-term-gpios:
     description: GPIO pin to enable RS485 bus termination.
     maxItems: 1

-- 
2.34.1


