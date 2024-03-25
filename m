Return-Path: <linux-kernel+bounces-117243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8455788A907
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B568C1C61D55
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825CA155A39;
	Mon, 25 Mar 2024 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="uGqNVL5u"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2094.outbound.protection.outlook.com [40.107.22.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EB5129A9E;
	Mon, 25 Mar 2024 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376584; cv=fail; b=LScbiHb66LTkzKktuh6zhLG2ZMNps5GGHYwHmJSeEREtzyHBWfEzlbNYMakQofZfhpBXXcrvU9t7o8ma7CT7ssXpqvfsGO0NKR6/Geo8plDbXqWKTbdkfpTBnzg+RZ+GxwLX0Sv+yLtkrJ0FcH6XQFNIndlU+/XK1FGKq4M/ciY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376584; c=relaxed/simple;
	bh=SepSy7Blv6ScrGx2QEp/MylYNVmm9pfGzAWhqWUH8XY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jSAjxUAYO2LHbPXbr1rkJGBVI7d6ac6A7UJkXo0EmisXDHVy2xwO0amP901NSocNBbao+6MkYsg0GNKn0ujau3NrK99xIBA86hL0WXqmESi3FhKEHDj1UzA4ZbF4k4xB6Hkt1G4xa74ZwVbo2dD1GXMuXh4EO9OeP8BdakzfZ+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=uGqNVL5u; arc=fail smtp.client-ip=40.107.22.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEKE++UU6ywuaEEEiGH8ukQmNXXi6xbIlgVrqHRkNefmqdheB1M94+VwadFlM8kJp9LgcrPn1Xn6o7R2dbZsZsszGr+0imhBMOaCaikkQ+tJAscDSyI9fzFZR8AdKzrN5+1sUK/GK4aUpH4+zBwxcliMdmzRxVq47hV2lM1/TBBPqUZkaPoNEg5LJLcuRVS2gFpZNqBOk9GIBJ+UkHRE4rUwHJ0GBtIMJ5Iew2XS551ZUdW2ljZ/LUq0Mz89c2yfWF53Ip543B2W7Ud8UgUVN+l2YBv8qTF8yj47x5j2f20SzWRnDS/UqJdRz7wrKf9lH90L+5Wz2ANQUuCA1DpvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxXt+HPzbHV2Gum5QmHcHXGFnyfpYKgoI9s6j+W18Ss=;
 b=hb5ezJ4vPvG4IvFEc4UZG1OmetdKS6ukFpPXycwovyiPaZMRAMAZ3/daPIjvWRBGj7fthybrBgpMyCPmHeSAUnAykYPKzdac41+LEsQ0ZzfTscOZDPOh+Bq5KHtR85f5Zx8yppfIEn5KZQT0Mj4U5829km1oRhThhymy38zQZH+t+CiGA5uKiNneiuH96HhL9QJpN8p1ebDUZfEBsaSaxLnDl/fNUe6RO9/d8XXyl+fwaRD7tpwUZs78uBQippTSJMDEHjm7+ERuxCA4czgiGKNawEeL43lDuNU5XHHb/5avcnOcqMrbza8K9MvnUXxrcnRGtP4EbTt0PFdOJRdMyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxXt+HPzbHV2Gum5QmHcHXGFnyfpYKgoI9s6j+W18Ss=;
 b=uGqNVL5uddtHjpRAuX0xmsR5MoUPWUuqgu9bHb/9OXqFkN3b7pbhIYFYKBhn0p+0sWEi6N7CvRikajodB/IPsWBinNbVAxzsH/Ym/tNc3wLsSMLuy7cUGltBtBTkX/CwbYZiheEZ7urxGxYtdKPVggQCntKsrJaOkE/FuuEy3+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by GV1PR08MB8258.eurprd08.prod.outlook.com (2603:10a6:150:89::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 14:22:56 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::e86a:6893:ac7:dad9]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::e86a:6893:ac7:dad9%5]) with mapi id 15.20.7409.026; Mon, 25 Mar 2024
 14:22:56 +0000
From: Michael Riesch <michael.riesch@wolfvision.net>
Date: Mon, 25 Mar 2024 15:22:31 +0100
Subject: [PATCH 1/4] dt-bindings: add wolfvision vendor prefix
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-feature-wolfvision-pf5-v1-1-5725445f792a@wolfvision.net>
References: <20240325-feature-wolfvision-pf5-v1-0-5725445f792a@wolfvision.net>
In-Reply-To: <20240325-feature-wolfvision-pf5-v1-0-5725445f792a@wolfvision.net>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Michael Riesch <michael.riesch@wolfvision.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711376575; l=793;
 i=michael.riesch@wolfvision.net; s=20240305; h=from:subject:message-id;
 bh=SepSy7Blv6ScrGx2QEp/MylYNVmm9pfGzAWhqWUH8XY=;
 b=TeHJrJVbq6aJZi5rmjcJO9bAA7q7L69SDAuiF1o/T9nAZXrq3kpmAQzEdU1maH7nE/YJ24vno
 /N6KvGMu8+JACFSGsS4O16xhY2tqSLmTeEYlvYNfr3A4VbXwcL+MZwx
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=vXktx+l75RJD3KAojVKL7503UCD9nnGRcgujrB9SRp4=
X-ClientProxiedBy: VI1PR06CA0127.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::20) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|GV1PR08MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 7991e7bd-3de2-4e88-5aba-08dc4cd710b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VVcEwlRzLuyDgtFpVMFSMGUspyMjqX05HtsNWVl4a15CL4JHLBIEvZIuDu+I3L1khMsjbdDemyouYiAoA/v+zCBtLHM6ng88d6oeH6XrKIi3dUFKafqhyFfghZSaqQ1t4Ho0DXZR27maJK8r+lSAAmSq+zBUBn0CVyzuNsZ+rJ611TUK+AXSWUHkA/MLj8nAXkwyBX4N0cMDRGfygEvxqmJ62GyLn//dxvG3SJmvDYs4ms+PcY6Ri4DlHBztgk8av/mHVwu7MLKTOj0n1Ooc+7oZl4XHeBwAWY0Smr2cLJ4Lcti70ob+78vuP/PpI2fSrd3VRzjkKqbr6dl2xwU2VchjtHnHn9g0nf0shgAZ7rHMMXpjaREp5ZNAL20KzlC1y6r2Pvn/9EodpY1a4A8LiwK7T8Bj6y5d1DVlkeZuo8IMUUSlhaAaWPTSBUj0RsT7vt4SqHeBHMUcW0capBRDjD/ixemAm6xP8obBp7yoFUhELAky+z3x3bHOwv+w/3Qw6Y0WAMdQF+FNW6uDEAc+Ix9YY57OV2jDKWs3TPtKRZCWjOeyO0Nbfalpmn7ypIzHZQV/bYwbyGncg/IyxHBzJwbzKrHow3lflB/eNqfM3Z6e3H4kzUg+uWQGaS6G6GU3hx7Uv80e4jGiUo9Rj2uIhGa2ybxg0X5HZgfdK+0A7LI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0tLZWNzR2EyelR1L29NaTVsejAxa0c3RGk1STFrVkZWMTYySHFmWHVJTmh0?=
 =?utf-8?B?R0xTdkk3RTl4cUE3RE80VEZLUzlkSXNnd0EvSHdZeEo1RGt5aU1mUzdTNFZG?=
 =?utf-8?B?cm5BVStNU1c5S0EzbXc4MnNyVElQYkUrbjVGMDhuNmc0YmhRVUFaVExNV29l?=
 =?utf-8?B?VnpKSGFVWjFFZkQydVE1M0lwQ2Y5QWwwcXRjSGFXL0RBSzBFeXoyOUR6c1RD?=
 =?utf-8?B?SldOL0VMNWdMZDh0akNNb09tQXB2Vlcza2dPdURidkJ6VFBua09TZUtDem9p?=
 =?utf-8?B?RjlKZE84eW5KUFZmV0ZvYzhlMDVEOS9BWGt6R3Zqci9ZY1YwWCtYSzlkNHRy?=
 =?utf-8?B?K1NIK0pQNEhZNVZEN25uVEtVL1ZwRlVGWmk0cmt1aGxWN3hWTFJLVHl4OVpt?=
 =?utf-8?B?K2RTaVd5TFVwbkJwMWUxVFBnMHVpUTJSTFcveTAydXNSNWtUVllvTVJqTnc0?=
 =?utf-8?B?c0VPcFUyS1NlakxZdnVDV2d6WXNQU3l4ZzU2QnN4YVJSRGRVSVhvYm1KdEc2?=
 =?utf-8?B?TnE2eEplY1J6UXR4eHZIWjBic2dpS3A5OTlVelFpUFIzeTF0QzlJMVNXL3pp?=
 =?utf-8?B?OTI3dTZjQnVKcFdQK1FMblUyaGp3NnVMSUFSdDUwL1NacnpUOVFMc25lUzIy?=
 =?utf-8?B?WkJyT0VIQlU1dnJlY3hJdGZQNHhZMWlzdDRoNXV0TVZiMEhvWHdyblYxQS9J?=
 =?utf-8?B?QmU2VkVvOUdlWUU0VS9ZNmU1WWtWVytrOWpMelFoeGZic2o4MEV4Y2NoOW90?=
 =?utf-8?B?ZkhINTFDMHBVai9aWWpPeXEzWmE1bGxGbTY2Q2RSY3NyOXp5RS81RStONjJy?=
 =?utf-8?B?TG9GL1dmTldaQTlUTkx0em5MbEpybHhLaElRRVhoY1YvVnJUMFFkVDZVRkNx?=
 =?utf-8?B?MEUxZmd5RXFMYVVvMHdSK3BsY3UzZW1LNXlWaEJCd3ZKOUU5TGp4SUtIU3ZS?=
 =?utf-8?B?NlkwVGVrSmdWek1VQ3FiNkt3YTFwMDRoVlJpSDhLZmp4dC8yN1RiQUNzRENz?=
 =?utf-8?B?Qk9ENGt3ZzVNQ1d2WDUyVzJ5WnJnSE1uL2VtWVgrWWNLbXlCbXhaeGtRNmRs?=
 =?utf-8?B?UW1QT0I0TVZiNjZ2a1U1REo2eFZoUE5KRm5VM3VTdzNqang1ZDBnbXFDYWVx?=
 =?utf-8?B?eE5mK0NsSC9nam9DSTc4YmpkdXkwRC9ENWNta1BSWnhEUU5oanFQTEJkUDhH?=
 =?utf-8?B?V3JNcEE4ZGdMbmFYK0VQU3htSVh1VS9ZeEQ0c1BPSjcrL1lQekd3T2Z4Zkhs?=
 =?utf-8?B?YUg5bU16U2FIMitoeHB5YUNFaU5NdDJ2dkV0ckZEYzdFalRwT01kL2NSRXVT?=
 =?utf-8?B?bjY2TDRRTTI3TmE3VWNSRnRxazVRbUliMFVaNEtkZVA1NzB3MUdIeXRlOXhG?=
 =?utf-8?B?UWhSUVM1UjdJVzlBUEM5MmF0Si9EUk4ySjBEYmFQd2xyeisvSkNUYklVVFAy?=
 =?utf-8?B?RVpoYnhieGpPWVdnTXVib3o1OExKMVR6RTRIR3JORm1oUWJ1ZFVpZGRSSmxF?=
 =?utf-8?B?ZThScjNSbVhHandSbGJSN0hvRmVMWFdYSDBEYU1XZjlOdXArTFpYN004VUxI?=
 =?utf-8?B?NTBLMFo0US9ac0ZvUXptRVc2STN4cVZOMTJPVWRDS201am5LV1NLdk1hdUU4?=
 =?utf-8?B?WW9KdHI5Q242WEh4NUYxWmhobGJ2dnB6ZXJiYnF5NVdXK1BhTDVlUnhIVGlT?=
 =?utf-8?B?UUFjVUd1R29UUjNoTzhQOEV6bGhOUEQ1cit2a29lYkxncXhxVDJZeDVrSTJl?=
 =?utf-8?B?WFRKMVZONU9uak15MVBWdHEvRFhIcXdpMFNGM1dWZVdNR2x5YW5KWEcza1E5?=
 =?utf-8?B?YWg3aW1UYUZ6dkZrS2w1L3FscWJqaThTS2NuTjlhbGVmYUpMbG5HL01GL3dF?=
 =?utf-8?B?MHJOSXhVQ2dyQXVEWC9xTWZYZm9iV254ZE8zd05hdlBMUlQ0a0NDQXV2WEMv?=
 =?utf-8?B?RmRkMmpmVzUvb1Btalo1UmF1Q1d5VlFLaUFuVUo5S3c2dDV1aTVGWW5Wby9F?=
 =?utf-8?B?UVdjRTFhSWh5bTFRdE4xWkdHbUMyb243K05iYkRrNjFXbGlDcEUyN1NZUzk4?=
 =?utf-8?B?Rnd3aUdNeGRWUm13akpZQjYvSTRiVWFVZ2wwcW9BRkt4VVBXSmF3TjlYSGJ1?=
 =?utf-8?B?bWZrbHNpVEZSVEpEUEdXYXU1djVvZ2RmTkRycytzVUFUVURpejZ6SWJIZEhm?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7991e7bd-3de2-4e88-5aba-08dc4cd710b9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 14:22:56.2586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYA1fFbiOGRE6fFiNDnQTExGQSmWfeQL4UKsuDabKiAvrJiElyPi1js55rJ9RskziSxrSOHhQOPRr3bgVx5u0fLRzC6YXj0iVHOC9uH7mrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8258

Add vendor prefix for WolfVision GmbH (https://wolfvision.com).

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b97d298b3eb6..59c6c6760bc0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1627,6 +1627,8 @@ patternProperties:
     description: Wondermedia Technologies, Inc.
   "^wobo,.*":
     description: Wobo
+  "^wolfvision,.*":
+    description: WolfVision GmbH
   "^x-powers,.*":
     description: X-Powers
   "^xen,.*":

-- 
2.34.1


