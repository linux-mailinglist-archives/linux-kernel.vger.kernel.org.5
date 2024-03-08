Return-Path: <linux-kernel+bounces-96704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F01876048
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE1B28561B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372FC52F95;
	Fri,  8 Mar 2024 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="do3kOrw1"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2101.outbound.protection.outlook.com [40.107.6.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15244EB33;
	Fri,  8 Mar 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887978; cv=fail; b=cvcQM/OPiAOza7AIBeOSr7kazW94E9JxAWLo1A8UM9uReAIuxUB/Xi3kR+AGD789wv+aSZ7bmGOY2m+UnUnzZcFCwMyjo64N4xteqydJ9naeFdnWsjS8IM7hM7mPB+umVmbnL3UuWWu01Apr1WXB7/Ll2D6imgVHNckTE+KprAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887978; c=relaxed/simple;
	bh=Gss1IWQxaTw6AneGnrbar8NoKfAAFlazRH5h9+ADpRs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DIOPuId8d/1Jvt4/r9v365AISd68c9lmCf1xLexcxJFZU0b2qQI69dBGTRCQRuYevqquFneJWe6uMrnh8oSMuEFPHcl7jPtWroA4EFNCWIk+9seVZ4nBFol/HRCasE8mrJSJyCg2zQCGKCaarGb6u9pcDeA0rxdkZ8Bqk/xNpbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=do3kOrw1; arc=fail smtp.client-ip=40.107.6.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAUOsYb3opNeMsE63pcchcZ8bkmIHCEYkWDpBlKblzUiOqFR1HyPo9+/Nxoubk2UA9e7txS5NjerXQIuBu1I9Fjd3JkaAH4Ugcq5GbGp+jImCa3caZzLSwIzVxuw6dhG1W+rDPsYHg4Pw8F+WOecl7oSf+LRG2CBmLzyqfCPTblYR01MbkaTMVl5+jAveUc6HTBZndwNldP3T0hgexCrgCBc3O+ma++dxWuX9KwzoJZ9ut3ngsrJuNFsALOgDD4y23S81GlkSlhP/jfmx97LUSfKC9F20qRjJSl+S9jw0r/4/ql+d4Y+nmEcKcdPRMQ23TgevacASY+UqiUzHxP+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAgUFRnzGQxUEpTWcDnpiJGPurVnGXnEu3aDdbubvm8=;
 b=mp8Oe6y7HLwDGV1GN4upfFSweuy0e0uOHYPm/I87MO4ANAsIr0pWWQTz6lWZsekhsk/ObC+bHxqT+9b559PLEcrUMza2mipKPNfydNT1Qh36CZdd555xtdALAOWqC+zMHarawDJfVna7zo9VxuRkIhWl/5nb0ZJyLxu/bXUs+S1FXcHpjQtT9OiZ7H+o31TOka5H6Lsy9O6koeCWaE2VYgQCnmgHh1LGV3/Ubr/2KzPbEtd0PdoZ9iPV6BsruV2cCpE83OIqlywRRC5QSsofunXqugcc/GrHipO2f63nVWoRKJdxqGqo7WCMlZ/XOyOZsLz1gVR2KE9k6DGchmiI0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAgUFRnzGQxUEpTWcDnpiJGPurVnGXnEu3aDdbubvm8=;
 b=do3kOrw1G3FelcBFB7Rjpsx1ByaNJYymGcPLrHT9xamsBKMPOv2w4FmFnFkNq/l22AwCcac8YI7mB4i8LVKzRVCGL52gHfIfIUeOUvsFakM0oa1wsoQFDEwg3HHwhMr604ixyOW6IzelJyknViEpSfvim7PNZ4k/nsgwT74YXs210iQ+/QJwdT6C56FAXqPWkzxVIL9vRCL+IG0TERjMRpCm93mm9X59XOfrgkJlNx8aYTNnrl4gfTMijvO6Ni/2Dgl4wmP6s89Dp+g3qOSVuKBRyy1bIsJaMp2dPMExtUgJFkbdolBi38/LxXwPD+3jor+vFm6uPi1dMyidV0yhgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from VI1PR04MB6013.eurprd04.prod.outlook.com (2603:10a6:803:cb::15)
 by DB8PR04MB7131.eurprd04.prod.outlook.com (2603:10a6:10:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 08:52:52 +0000
Received: from VI1PR04MB6013.eurprd04.prod.outlook.com
 ([fe80::8881:4979:e635:7fbe]) by VI1PR04MB6013.eurprd04.prod.outlook.com
 ([fe80::8881:4979:e635:7fbe%4]) with mapi id 15.20.7316.039; Fri, 8 Mar 2024
 08:52:52 +0000
From: Iskander Amara <iskander.amara@theobroma-systems.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	vahe.grigoryan@theobroma-systems.com,
	angelogioacchino.delregno@collabora.com,
	dsimic@manjaro.org,
	alexander.stein@ew.tq-group.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: quentin.schulz@theobroma-systems.com,
	Iskander Amara <iskander.amara@theobroma-systems.com>
Subject: [PATCH 1/2] arm64: dts: rockchip: enable internal pull-up for Q7_THRM# on RK3399 Puma
Date: Fri,  8 Mar 2024 09:52:42 +0100
Message-Id: <20240308085243.69903-1-iskander.amara@theobroma-systems.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0020.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::32) To VI1PR04MB6013.eurprd04.prod.outlook.com
 (2603:10a6:803:cb::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6013:EE_|DB8PR04MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: a6eafe44-e913-466a-d600-08dc3f4d23dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DNSV+RgxCMM+ziq9OxTJHyN08K8MuFsDU0WMGmoLrEy4nFQRn1ObopCNV2iJjYqutwoXHy0KwP9HH2Cn4vvPpTystzcNs1ZTKQEcfmj8n8ATrh6QsKT/Cvj0Wsuomn++rTl7TFZolxSjKaotIIRRduu2h/3n37O/vhwnDvkMzRMhjCbI7m0spRQceJUikkbD9BiX3zij6uFYvn1b/IzjPadw/AQoKugHX7RAradCnKLQ15D0dRx+d4VeRMjLqH+CpzN5lsx5zxQUxHs2xntAuCsHwCJVCdm1abJslVD9utavwk6VpD+tBuw5n3xseGRbZRgW3eKjsTh6dumcQRR7JOQqkQcmKFPytgNr69Q8vAoZ74n+c0CDT8YCH/exF6s22gOskMZMuZijvuQ5/GVS0TVDa5mHwol4W7tC8qcrwrGmmvJWoLyi1EsEPyJZ3H6rxWDwxIb0bNRj3GYl53e15f9wXOABn95WGb/16loAUAfKbRbMnjulhT40hquphds0erg6Zyupy1M4hVDECR8Z4HKKFoAKjnWJCShTEWBzm4sN1kCCEvsnnmaZdg+E7fgd0eGLHxLZW67mYf6nUp8yMqoWxQKggec/1bXbtJeiNK+GplM83EpcbU6uWc+gehQDCg2D9TZxTnw/zW7ziS+fIPxgA2vXRKSk9p7/rMOgB+tqLuwPJxid8yri7n0G7yQlyPRyq72TH3NT0U1GvqKfCN8HeBHtvt6dgONwr5mgYHw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6013.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S4HFU4L9Vhb/vSLMORdg+2MibbRqpQqfU0v8YNuPSRH6d/dfFjj4I4xbTWXh?=
 =?us-ascii?Q?zlULN4blQEiupzFh7FAGMxuZFyjOJz5VU3O3DrHGFnVOMmV7tttxyl1Jeoxd?=
 =?us-ascii?Q?139SccfYUUZtYZMtRQSNKfKytzaiSiHySCGzjM5Vehd833nFZFvWaPy2vlPu?=
 =?us-ascii?Q?9tldYkHtgCliEECN9GP5lXM0x6vkOd81eJu8S5rmMMCJVIFesD32xTHfnGyS?=
 =?us-ascii?Q?cc+eeHqqyYfMRWWZomzWH7UlqWnE0upzgoB4HC4O/n/C8SLpx6eYB5of9nd+?=
 =?us-ascii?Q?L1Q5GWYjBjp1eu0yktNu5QxXSC8eG903DoXolRQnsVRDa1Eio90ksxqWw8pc?=
 =?us-ascii?Q?ucw4C/pWR0TW9e1fCTIHLEIYPoBFBZQIwAUNZ+vIRZhlCtH8HXb60v5slnIm?=
 =?us-ascii?Q?yEhjikOa8vtenGw5ImaaojVoaYAqqzIAKgGIqrnlvzkFQpdXW2FUc2ap2xF5?=
 =?us-ascii?Q?jrBCXNPjah3kccfmut+5Jd5FcjC+TmfvhrN3iVTkttFyX7Mxkofh1VlLmiVG?=
 =?us-ascii?Q?iE2M9cjKz0L3hUQTSdraVWkjofw96Qa4Sl6zhKRe0o5RxoaLp5h0hnaUDClu?=
 =?us-ascii?Q?bAiZHWK8VQs6zLHQo7STmFcOFQeKDEr0/JLsKpn+a6yZ9qAU/HsSf6wOqp1W?=
 =?us-ascii?Q?jomuxbNmICHkgGxy5NUDiL7Xv0htGV2XJw2ZJSocQ/++Tvvx+naiQkVEP9GJ?=
 =?us-ascii?Q?RfRAfKOU1tKl7aBalVyG0GdyhZuLXvco2IxP9VADc7JtnIQiOLtf/bX439Hv?=
 =?us-ascii?Q?svxDaYVUpVAB5RnmbMc4oCMQBvEpege93Qezf34KPdC4mtEJL5jMNmGR8GcX?=
 =?us-ascii?Q?KD6GS8DbikZVD5U9SqritBA/Se8T6ECiIsi2OtxWYoeqxeJXDbCS+ycC+AKh?=
 =?us-ascii?Q?LfzuZ2GSRrT+i0TaT48JDDCUa3EuEAsH/TqMXGQ6UJY4PRG6iC2Ywlo6eVa9?=
 =?us-ascii?Q?9N5mW4UuEWp8/8o5laSGUf7E2k19uHfcLERiYoQO410aN7k9+bNj7Yn8ALcF?=
 =?us-ascii?Q?sooPRUOYtbt52nymSFw4ggEI+xA4J/NrWghTDwgxXJvLtHMsSU9twac3Hn5p?=
 =?us-ascii?Q?/hogrXz+PWjWxwTJCzpooacW/xKb2I21eTW+d8W+tQacmUXEOeEx27mp/7z4?=
 =?us-ascii?Q?5DIf37OiKQmcDhjYJnpf0nz4ovLQrYFfJ2IplztDpZ89F6hqiwKlH19YC4ST?=
 =?us-ascii?Q?L8WaREajkbrNru0tU+d30Cx4gwba7deHh/BCnvbieoFmwMiI/eh5JT9tICJS?=
 =?us-ascii?Q?CcNVuMZV2MJVe6A9SSykBttq8MR2QKCFQnoLpY9O3WfZ1Xe9Ya6dWwZ5TYvT?=
 =?us-ascii?Q?GwINBLuj0egnn7T0M0PFTkuqN0+klab0r64fOzADGrQBDb+CwbvZ+PsrR/op?=
 =?us-ascii?Q?mV/jcD812LchqxStPGZ1/6sxg2VXJrCg67DvQ5lpqtZMWk6pMX7gERcKP2I8?=
 =?us-ascii?Q?tedsK6+1fZetivKQDLj8yGuZDj/88IAxdKLPf4+CnqfzVAqkNT66UdBLuvkf?=
 =?us-ascii?Q?ehvO+cS4t+Of1NnTg/fFzUDu/70AAUPBlYVTdxFKfj0WoWIsBoEvtsYqQEDj?=
 =?us-ascii?Q?GgtRmTM5C4Oz3QZ7k52RWcxXOskZJ0HQ4/2J4xG7ZrMrk3xBtC6V0alaIDb5?=
 =?us-ascii?Q?qgRqUKfVuUpQZrufKJEtwSs=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6eafe44-e913-466a-d600-08dc3f4d23dc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6013.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:52:52.7657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbmtaglKtPrxbH2xd3UdNtYofWlWGGGaoX3iv4NILeBSN3ZNKdl4Ao0pLK1M4ziTR3LhYrnfP+6k24xMb7W2/PgQztn/Qgwpr7qWRKVBLEMiRhM96gRUyaqgC4Rd7ujn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7131

Q7_THRM# pin is connected to a diode on the module which is used
as a level shifter, and the pin have a pull-down enabled by
default. We need to configure it to internal pull-up, other-
wise whenever the pin is configured as INPUT and we try to
control it externally the value will always remain zero.

Signed-off-by: Iskander Amara <iskander.amara@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index c08e69391c01..06f3e97af7cd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -426,6 +426,16 @@ &pwm2 {
 };
 
 &pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&q7_thermal_pin>;
+
+	gpios {
+		q7_thermal_pin: q7-thermal-pin {
+			rockchip,pins =
+				<0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	i2c8 {
 		i2c8_xfer_a: i2c8-xfer {
 			rockchip,pins =
-- 
2.34.1


