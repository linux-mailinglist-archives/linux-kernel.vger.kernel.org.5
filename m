Return-Path: <linux-kernel+bounces-40431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905AB83E008
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EAB0281727
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3E820325;
	Fri, 26 Jan 2024 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="hAl7zSs1"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374801D553;
	Fri, 26 Jan 2024 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290121; cv=fail; b=mcoxJdFyRWfEUfQnEGX9Qe4kFCfh9ACjcD4eURnMD7koJ0g5SaFK+jZ+1Ho9NluV5C9VsNSnD8zj6Wz27pylUj2vt2/wWGMPi/Cj9ZnTejzkl9r8aa9LF4mIt7SOMoUzkrzrwBYzaAt+CAItb4TG4q16ugpE1SHoA8L+1w8OCfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290121; c=relaxed/simple;
	bh=IVMh64niZEfl6QXJoAoM3XsM/a5UZlHwxq+4aWfqMFY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FRb0adk2bSAukPg9dlkZUud5ZDB5YC8P7oTyU76Apho+2BdxpZjgHNjj4xy5kaGZA9AYUJA9s5PuMJiaJN35zuPy88vFa6mpB2ShhyYzbZ3qT/uMfkc/BW5dSIfOeTc8mtg9LtnyEzw22xzTzaJ8Vtt7DcdhWB9/wzki/nWGso8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=hAl7zSs1; arc=fail smtp.client-ip=40.107.7.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+oLocA83A08YVuEDFL/s9BawvuBHLFpUuCe7DtRgbphdNLuC8AHVo6VvD4HuUjdWWomsmUvLzaNoPN9XAjHxeSAks6cspusTjVKgrtpmvmjcK+6JRXaoKsvjixWix4MrO7x1di7idKXvsov9j8G4DIMGMJSbgX6EPwWjp7NFzkPUUyfZgWUWcDv9Wh9XvisOw+wjE2pBS6LBKWWvb5c3vm+3KDOiNGZtiHjUR7ly6Bz/qO4yXvfX8IsnW4BOYkU3YK0JuOnYJy6ICUY6Jk8MjFzfCbdnNTX+sRm7p1N6R8EREe0osinovvqeCDGZYeXAG7A0YoEIs3ETNmNtuY6sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqixvfKtPECeF4ubPvftK4PmEI+HUmvDEI7Qd1Vr3LE=;
 b=ALscU6DxdbzHFcgu3/Rs2OeXj7vdYMAbXQkRaqKMqkyNKlmErWOcniBVV98ae+Xs4dhNfj1Te6qkSPRiNuUz6taNOVVjePPznjEdhNLavUwfEJ2oWBvM9PHipIGscuwF+S7xl0Jup2luY0AkRxba3gwhG0YEUC8QHc8U2d6UPe4RwZbYaEpQ4bBbMRomhXLzjqs7zV+Q6MsIUFmSkNWKjHxSCFylf2lBVMJIfdQXUvU7+CTOwuouzZdsvCSdift6TqrJaaO2FDmAEeUIhwyeSm/9iXw4/D7znZYe/gMAPZjiGOy+jAt/vPTf8GggHs0tOXrXaWiuZOoEvo6S8oEf+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqixvfKtPECeF4ubPvftK4PmEI+HUmvDEI7Qd1Vr3LE=;
 b=hAl7zSs1X2przdOOPNPPDPWFpRJ3c2Jzb4D3QGAwcUpFPXRfQjw9YdmZID0PQqV7xVEaq1cCDx8FGenomW6+InnmozB+ZFEaeX1dW2bs4WrtzAnHuEaBt7o28DFGoGFPciEESdkzTo5bVlPm/eMKLFc06amzDjAqbkEnchSm5RTKpy0EwZmYiIwSGm+VDuRbb4LCWiQfZv93UKHxIAHlZf/slN0REsb0VUB0+bfX0yUwtN4Mz6TrcyacjpssonlXSgXtJvRZtuxEnzWrvXFI/GkgKNIPtnOazqHdrhYnLesPhEXn85jn88FFaWX0SzPLHiDTrcaS0RZl5htbAqs8/Q==
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
Date: Fri, 26 Jan 2024 18:27:42 +0100
Subject: [PATCH v5 1/6] dt-bindings: serial: Add binding for rs485 receiver
 enable GPIO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-dev-rx-enable-v5-1-5d934eda05ca@theobroma-systems.com>
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
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
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
X-MS-Office365-Filtering-Correlation-Id: 2f9c8eb7-398a-4276-fa57-08dc1e94393d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5o9E5LFBYRp95t9m+MgRzyehMWnaS7cXuWzboklvn/6UT9dHi9OiMvpI1AAZQegWmyNwAzcWZXTBSun4wD1U0Vh6GY72fuyFOIms1nkXFCEaLd6/+GM2ptC7JR4zTE3zWUotXvs3zvqLIC6wxjhDrzlU1SCGnCEv/t3uZxmKlwGWYRgL5j/CqOyElCZ++u7sLOPL5mHVJaA+2YToPeBGQRtmzWkCXk2Wf8bKT9bbvy1OTsxXcZNDbMWTufhvzMjBc3hdKoCqNiIuhwWvVp89hGLpbnp8+3Ty87PYnapWN3wLSQMmS4Xt+9MzRjadDgl0UGh7GfO5e7yMGiMOvD+h02Yd/iik1rjcFfDUi3k57hfhcskzIE8ckNbJjrczgMBt9XIKqdg5fDf6IVWCV6WhV5rpg1J2wxeweevI/SL1cveM1BqpnQYHTZqcxI7tDJv8ttordKOVRlqFAcKlUgbWb6W5+dVKmkZR0jxRdzk68rGDWIA67vIU25iREjwIaZeYSFG+2AmtEhwaSYARZn9whlI6BVt+8uxNj8kkvKkKkGriR/1mabn5SVb9PFfe0AbB9B5NPwN8vp8m54fpT2qMkWXjKOTOqCvjn8reFico9AB2ztoMTjzdT8XSqoQjnHh1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(136003)(376002)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(36756003)(478600001)(8676002)(4326008)(7416002)(8936002)(66556008)(54906003)(5660300002)(6486002)(44832011)(66476007)(316002)(2906002)(110136005)(66946007)(86362001)(6666004)(38350700005)(52116002)(6512007)(38100700002)(6506007)(2616005)(41300700001)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?US9leEJKaDBZOTFSaDN5c1dSUnB4RWUveDdZM1FORnl0dlhaZTJkczd3ZWlh?=
 =?utf-8?B?K2NOYjlpQVN2TGZPeCtERVRXZTlrbUk3MzFGM205aksyazNwZlRyOWVrbG54?=
 =?utf-8?B?cUx6ZFZpdTVOV0V0NEFrUHFiRktaeXNWaG9jdlM2NjEwYWpjaDVtNFdLZlZ4?=
 =?utf-8?B?RlV3RU91d3piNTlTRzdLcm90OEFrUWJkeU9lT0g2N1MvVlpVYmdabXc0MWVO?=
 =?utf-8?B?dnR5ZENqdVFiZDBhV1BDbStjeXBOa1JzQXEwemtQMGlVQWF4M0xYdXppVUc0?=
 =?utf-8?B?QnFQWUFlRk56VXdjbXVCKzkzcmY0Rk1LNjVzWTRaRVJQdzdsczR4Z3pPQ0Zq?=
 =?utf-8?B?NXdhbW05WGxOTEN0UDk5MUxqYVpxbXpHYkxTN01sTmRaMkRIbXdsaXZrTk5I?=
 =?utf-8?B?RFpnVk9XeGtwUVM0MEtQelhWVlcycjR3NjRKZ2x5UkJsajBYcWJQT0l2WFky?=
 =?utf-8?B?Z1JEcVBRMUxpanB2c2Q5T09CZ0JCRDlVODBtejVSd2hPeGtBUnAzdlJ4UHBY?=
 =?utf-8?B?VnU5SVhQSlFIRmxUYlloLzZCOXQzbkdTWlZsOXZJTTBHR1BheFJySmo3cTdM?=
 =?utf-8?B?VW9NWWF6SWRNamNjT2NRQW9Ea2NXMGkrV3YrMGczaTdyQjBkZ3RrRjJnNlBK?=
 =?utf-8?B?UUNhR1FGMk5kZlpRMjdkcVBmWVdxV1IrR0ZqZXY3ZGs5Wlh4VEMweGNLa3RO?=
 =?utf-8?B?UENqZmRJdzE3Q0hZWjd6emcvLzVha2FNVmdzVEpJTmpwZXZ6RGtHa2x6ZHBh?=
 =?utf-8?B?YlArTlZvVlFsbzVXbW00d3lpU05MWVVlRDJWRnAzTjdSQm9tTE51OC9MdWYv?=
 =?utf-8?B?ZkhOQW9BSWdtTmZoRGgyYmJHNDBNZlhlL09HZlVaK1pEM04vZkwxeC80UFhY?=
 =?utf-8?B?RTllMmthMXcxbndpQjloRmtQZW9KL0xDbTlWMjBESEhEYklIT3JEMkE0NENS?=
 =?utf-8?B?aWVCK05pNWFrcHZiRnlPbXBxOEczZ2hFUTVJMklKQmo0dkJ5VVpjblNLYjBu?=
 =?utf-8?B?ay9LTGozNnQxNHFoRXhWYU44cllQZEZFVHV3RUxQY2dWZzhFakR5WGZsTkhN?=
 =?utf-8?B?M1YrZGVCMThraVREQmdseWRwUlFQTjRZbHE2VkRpL2tPQXFpNUZ2bkp2YmRr?=
 =?utf-8?B?enZhWEhQK2Vtdmc5b1QrTEJya0pLMk1MUGFNZGJveVNXM0pjSzV1Y2dZdHZm?=
 =?utf-8?B?Lytsa2piejNJWjFwUy9BRVdlKzdIS3pETitZc1FSTWtoZ25NaE02amVuTnUx?=
 =?utf-8?B?cjJsc3hxMVdaaFd0WnRjOEQwQ3FsUzV4Tm85Vkg5dEVsV1ZnazFmYkV2dmFO?=
 =?utf-8?B?SDQ1dWU1d3VKNTFuZ09ZN2gxdXFROWVlekVSaWR2dW0rdnJra1VlT3NEcHdQ?=
 =?utf-8?B?cys2aGk3VFNwSG1IMUQ4Y3hCWG54M1VPWThjUTFMc0lqRGt5NUY0SVVMZDBD?=
 =?utf-8?B?VDNkUXlRbVZ6RUlmTVpEeEY4alN0NktiMkUyWW0vOHpvVk56RThoZ2RMdEJS?=
 =?utf-8?B?SVNJYVRVY2IyU0VvWWpnQ05MVGFWeDhINzUvbWd6bzFML1ZuVVNCNUk0UEZm?=
 =?utf-8?B?M1YxVzZTdjR1N1Q3eHkrc2t1VzBvM3BYVFhTcWVCbExZMEVCU3JSS3E1N1pB?=
 =?utf-8?B?VFZxWnNZNm9mSndIOWRjYkJXaEhjSjdKbElLYzQzYytoNVFUTnZxTEZOMUw4?=
 =?utf-8?B?aFVJMWJGQlRjbkdoYUNxZ0NGdWNKZXpCT0ZZUWtHTUQyYUpJbDNvMjB1T251?=
 =?utf-8?B?RDAwcHRmbE9UbFk1VXZBNHEyYnpRRXBoZUVqUmV3bGhyNnU5R2JzQXloOExu?=
 =?utf-8?B?cEdOa0Z5N0ZldzRxVTdrZERvbzgzTnVNZnFLTzNJeCtnVE1MYyszZVhpYS8v?=
 =?utf-8?B?NDk1V2ZUbWtzemhoTFhtblk4LzhxOWgyR1NtLzRoN1lSNkE0WU9PSnZUaEd3?=
 =?utf-8?B?WE1INTJnUmxpMXVSenUxY0RNdE5oTlBxS1NQOUZRWnBJOUZGY0s5dE5hZkti?=
 =?utf-8?B?ajkvQmpwaUoxRUxaazNCdDF5aUtKM3FpVjZXcy85RVgyRU92K3M1VTlpdE5N?=
 =?utf-8?B?ekI2RVVTSE1RSEgxR2FzVnM2dzJrcDFkK2hWakRBdUthM0hxOWQ1eTdzaDY5?=
 =?utf-8?B?eVBYakpsMkJrNnlPOXhza3hVdW1ab0FZd25aWEk3dlhCWUdaL2NGRks5SXJC?=
 =?utf-8?Q?PJcnTMSsYqMZtOkCSKUEdN8=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9c8eb7-398a-4276-fa57-08dc1e94393d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 17:28:34.7293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+CAngt6Nel6nWDlargf/bD+GlMe4HDHXyMY7YDkjknmsWsAZFpC8zUfJgo1VLsMq6d7k680zh/j6CQdiMGFnhPtCllKvjoWAUzRvvnAUIn/6zOcj7zcHHwONetX9EPI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820

From: Heiko Stuebner <heiko.stuebner@cherry.de>

RS485 has two signals to control transmissions "driver enable" (DE) and
"receiver enable" (RE). DE is already handled via the uarts RTS signal
while the RE signal on most implementations doesn't get handled
separately at all.

As there still will be cases where this is needed though add a gpio
property for declaring this signal pin.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Signed-off-by: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
---
 Documentation/devicetree/bindings/serial/rs485.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index 9418fd66a8e9..b64577036b5c 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -51,6 +51,10 @@ properties:
     description: enables the receiving of data even while sending data.
     $ref: /schemas/types.yaml#/definitions/flag
 
+  rs485-rx-enable-gpios:
+    description: GPIO to handle a separate RS485 receive enable signal
+    maxItems: 1
+
   rs485-term-gpios:
     description: GPIO pin to enable RS485 bus termination.
     maxItems: 1

-- 
2.34.1


